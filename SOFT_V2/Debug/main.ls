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
2270                     ; 184 void vent_resurs_hndl(void)
2270                     ; 185 {
2271                     	scross	off
2272                     	switch	.text
2273  0000               _vent_resurs_hndl:
2275  0000 88            	push	a
2276       00000001      OFST:	set	1
2279                     ; 187 if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
2281  0001 3d00          	tnz	_bVENT_BLOCK
2282  0003 2607          	jrne	L7441
2285  0005 be02          	ldw	x,_vent_resurs_sec_cnt
2286  0007 1c0001        	addw	x,#1
2287  000a bf02          	ldw	_vent_resurs_sec_cnt,x
2288  000c               L7441:
2289                     ; 188 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2291  000c be02          	ldw	x,_vent_resurs_sec_cnt
2292  000e a30e11        	cpw	x,#3601
2293  0011 251b          	jrult	L1541
2294                     ; 190 	if(vent_resurs<60000)vent_resurs++;
2296  0013 9c            	rvf
2297  0014 ce0000        	ldw	x,_vent_resurs
2298  0017 cd0000        	call	c_uitolx
2300  001a ae0000        	ldw	x,#L6
2301  001d cd0000        	call	c_lcmp
2303  0020 2e09          	jrsge	L3541
2306  0022 ce0000        	ldw	x,_vent_resurs
2307  0025 1c0001        	addw	x,#1
2308  0028 cf0000        	ldw	_vent_resurs,x
2309  002b               L3541:
2310                     ; 191 	vent_resurs_sec_cnt=0;
2312  002b 5f            	clrw	x
2313  002c bf02          	ldw	_vent_resurs_sec_cnt,x
2314  002e               L1541:
2315                     ; 196 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2317  002e c60001        	ld	a,_vent_resurs+1
2318  0031 a40f          	and	a,#15
2319  0033 c70000        	ld	_vent_resurs_buff,a
2320                     ; 197 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2322  0036 c60001        	ld	a,_vent_resurs+1
2323  0039 a4f0          	and	a,#240
2324  003b 4e            	swap	a
2325  003c a40f          	and	a,#15
2326  003e aa40          	or	a,#64
2327  0040 c70001        	ld	_vent_resurs_buff+1,a
2328                     ; 198 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2330  0043 c60000        	ld	a,_vent_resurs
2331  0046 97            	ld	xl,a
2332  0047 c60001        	ld	a,_vent_resurs+1
2333  004a 9f            	ld	a,xl
2334  004b a40f          	and	a,#15
2335  004d 97            	ld	xl,a
2336  004e 4f            	clr	a
2337  004f 02            	rlwa	x,a
2338  0050 4f            	clr	a
2339  0051 01            	rrwa	x,a
2340  0052 9f            	ld	a,xl
2341  0053 aa80          	or	a,#128
2342  0055 c70002        	ld	_vent_resurs_buff+2,a
2343                     ; 199 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2345  0058 c60000        	ld	a,_vent_resurs
2346  005b 97            	ld	xl,a
2347  005c c60001        	ld	a,_vent_resurs+1
2348  005f 9f            	ld	a,xl
2349  0060 a4f0          	and	a,#240
2350  0062 97            	ld	xl,a
2351  0063 4f            	clr	a
2352  0064 02            	rlwa	x,a
2353  0065 01            	rrwa	x,a
2354  0066 4f            	clr	a
2355  0067 41            	exg	a,xl
2356  0068 4e            	swap	a
2357  0069 a40f          	and	a,#15
2358  006b 02            	rlwa	x,a
2359  006c 9f            	ld	a,xl
2360  006d aac0          	or	a,#192
2361  006f c70003        	ld	_vent_resurs_buff+3,a
2362                     ; 201 temp=vent_resurs_buff[0]&0x0f;
2364  0072 c60000        	ld	a,_vent_resurs_buff
2365  0075 a40f          	and	a,#15
2366  0077 6b01          	ld	(OFST+0,sp),a
2367                     ; 202 temp^=vent_resurs_buff[1]&0x0f;
2369  0079 c60001        	ld	a,_vent_resurs_buff+1
2370  007c a40f          	and	a,#15
2371  007e 1801          	xor	a,(OFST+0,sp)
2372  0080 6b01          	ld	(OFST+0,sp),a
2373                     ; 203 temp^=vent_resurs_buff[2]&0x0f;
2375  0082 c60002        	ld	a,_vent_resurs_buff+2
2376  0085 a40f          	and	a,#15
2377  0087 1801          	xor	a,(OFST+0,sp)
2378  0089 6b01          	ld	(OFST+0,sp),a
2379                     ; 204 temp^=vent_resurs_buff[3]&0x0f;
2381  008b c60003        	ld	a,_vent_resurs_buff+3
2382  008e a40f          	and	a,#15
2383  0090 1801          	xor	a,(OFST+0,sp)
2384  0092 6b01          	ld	(OFST+0,sp),a
2385                     ; 206 vent_resurs_buff[0]|=(temp&0x03)<<4;
2387  0094 7b01          	ld	a,(OFST+0,sp)
2388  0096 a403          	and	a,#3
2389  0098 97            	ld	xl,a
2390  0099 a610          	ld	a,#16
2391  009b 42            	mul	x,a
2392  009c 9f            	ld	a,xl
2393  009d ca0000        	or	a,_vent_resurs_buff
2394  00a0 c70000        	ld	_vent_resurs_buff,a
2395                     ; 207 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2397  00a3 7b01          	ld	a,(OFST+0,sp)
2398  00a5 a40c          	and	a,#12
2399  00a7 48            	sll	a
2400  00a8 48            	sll	a
2401  00a9 ca0001        	or	a,_vent_resurs_buff+1
2402  00ac c70001        	ld	_vent_resurs_buff+1,a
2403                     ; 208 vent_resurs_buff[2]|=(temp&0x30);
2405  00af 7b01          	ld	a,(OFST+0,sp)
2406  00b1 a430          	and	a,#48
2407  00b3 ca0002        	or	a,_vent_resurs_buff+2
2408  00b6 c70002        	ld	_vent_resurs_buff+2,a
2409                     ; 209 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2411  00b9 7b01          	ld	a,(OFST+0,sp)
2412  00bb a4c0          	and	a,#192
2413  00bd 44            	srl	a
2414  00be 44            	srl	a
2415  00bf ca0003        	or	a,_vent_resurs_buff+3
2416  00c2 c70003        	ld	_vent_resurs_buff+3,a
2417                     ; 212 vent_resurs_tx_cnt++;
2419  00c5 3c01          	inc	_vent_resurs_tx_cnt
2420                     ; 213 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2422  00c7 b601          	ld	a,_vent_resurs_tx_cnt
2423  00c9 a104          	cp	a,#4
2424  00cb 2502          	jrult	L5541
2427  00cd 3f01          	clr	_vent_resurs_tx_cnt
2428  00cf               L5541:
2429                     ; 216 }
2432  00cf 84            	pop	a
2433  00d0 81            	ret
2486                     ; 219 void gran(signed short *adr, signed short min, signed short max)
2486                     ; 220 {
2487                     	switch	.text
2488  00d1               _gran:
2490  00d1 89            	pushw	x
2491       00000000      OFST:	set	0
2494                     ; 221 if (*adr<min) *adr=min;
2496  00d2 9c            	rvf
2497  00d3 9093          	ldw	y,x
2498  00d5 51            	exgw	x,y
2499  00d6 fe            	ldw	x,(x)
2500  00d7 1305          	cpw	x,(OFST+5,sp)
2501  00d9 51            	exgw	x,y
2502  00da 2e03          	jrsge	L5051
2505  00dc 1605          	ldw	y,(OFST+5,sp)
2506  00de ff            	ldw	(x),y
2507  00df               L5051:
2508                     ; 222 if (*adr>max) *adr=max; 
2510  00df 9c            	rvf
2511  00e0 1e01          	ldw	x,(OFST+1,sp)
2512  00e2 9093          	ldw	y,x
2513  00e4 51            	exgw	x,y
2514  00e5 fe            	ldw	x,(x)
2515  00e6 1307          	cpw	x,(OFST+7,sp)
2516  00e8 51            	exgw	x,y
2517  00e9 2d05          	jrsle	L7051
2520  00eb 1e01          	ldw	x,(OFST+1,sp)
2521  00ed 1607          	ldw	y,(OFST+7,sp)
2522  00ef ff            	ldw	(x),y
2523  00f0               L7051:
2524                     ; 223 } 
2527  00f0 85            	popw	x
2528  00f1 81            	ret
2581                     ; 226 void granee(@eeprom signed short *adr, signed short min, signed short max)
2581                     ; 227 {
2582                     	switch	.text
2583  00f2               _granee:
2585  00f2 89            	pushw	x
2586       00000000      OFST:	set	0
2589                     ; 228 if (*adr<min) *adr=min;
2591  00f3 9c            	rvf
2592  00f4 9093          	ldw	y,x
2593  00f6 51            	exgw	x,y
2594  00f7 fe            	ldw	x,(x)
2595  00f8 1305          	cpw	x,(OFST+5,sp)
2596  00fa 51            	exgw	x,y
2597  00fb 2e09          	jrsge	L7351
2600  00fd 1e05          	ldw	x,(OFST+5,sp)
2601  00ff 89            	pushw	x
2602  0100 1e03          	ldw	x,(OFST+3,sp)
2603  0102 cd0000        	call	c_eewrw
2605  0105 85            	popw	x
2606  0106               L7351:
2607                     ; 229 if (*adr>max) *adr=max; 
2609  0106 9c            	rvf
2610  0107 1e01          	ldw	x,(OFST+1,sp)
2611  0109 9093          	ldw	y,x
2612  010b 51            	exgw	x,y
2613  010c fe            	ldw	x,(x)
2614  010d 1307          	cpw	x,(OFST+7,sp)
2615  010f 51            	exgw	x,y
2616  0110 2d09          	jrsle	L1451
2619  0112 1e07          	ldw	x,(OFST+7,sp)
2620  0114 89            	pushw	x
2621  0115 1e03          	ldw	x,(OFST+3,sp)
2622  0117 cd0000        	call	c_eewrw
2624  011a 85            	popw	x
2625  011b               L1451:
2626                     ; 230 }
2629  011b 85            	popw	x
2630  011c 81            	ret
2691                     ; 233 long delay_ms(short in)
2691                     ; 234 {
2692                     	switch	.text
2693  011d               _delay_ms:
2695  011d 520c          	subw	sp,#12
2696       0000000c      OFST:	set	12
2699                     ; 237 i=((long)in)*100UL;
2701  011f 90ae0064      	ldw	y,#100
2702  0123 cd0000        	call	c_vmul
2704  0126 96            	ldw	x,sp
2705  0127 1c0005        	addw	x,#OFST-7
2706  012a cd0000        	call	c_rtol
2708                     ; 239 for(ii=0;ii<i;ii++)
2710  012d ae0000        	ldw	x,#0
2711  0130 1f0b          	ldw	(OFST-1,sp),x
2712  0132 ae0000        	ldw	x,#0
2713  0135 1f09          	ldw	(OFST-3,sp),x
2715  0137 2012          	jra	L1061
2716  0139               L5751:
2717                     ; 241 		iii++;
2719  0139 96            	ldw	x,sp
2720  013a 1c0001        	addw	x,#OFST-11
2721  013d a601          	ld	a,#1
2722  013f cd0000        	call	c_lgadc
2724                     ; 239 for(ii=0;ii<i;ii++)
2726  0142 96            	ldw	x,sp
2727  0143 1c0009        	addw	x,#OFST-3
2728  0146 a601          	ld	a,#1
2729  0148 cd0000        	call	c_lgadc
2731  014b               L1061:
2734  014b 9c            	rvf
2735  014c 96            	ldw	x,sp
2736  014d 1c0009        	addw	x,#OFST-3
2737  0150 cd0000        	call	c_ltor
2739  0153 96            	ldw	x,sp
2740  0154 1c0005        	addw	x,#OFST-7
2741  0157 cd0000        	call	c_lcmp
2743  015a 2fdd          	jrslt	L5751
2744                     ; 244 }
2747  015c 5b0c          	addw	sp,#12
2748  015e 81            	ret
2784                     ; 247 void led_hndl(void)
2784                     ; 248 {
2785                     	switch	.text
2786  015f               _led_hndl:
2790                     ; 249 if(adress_error)
2792  015f 725d00f8      	tnz	_adress_error
2793  0163 2718          	jreq	L5161
2794                     ; 251 	led_red=0x55555555L;
2796  0165 ae5555        	ldw	x,#21845
2797  0168 bf10          	ldw	_led_red+2,x
2798  016a ae5555        	ldw	x,#21845
2799  016d bf0e          	ldw	_led_red,x
2800                     ; 252 	led_green=0x55555555L;
2802  016f ae5555        	ldw	x,#21845
2803  0172 bf14          	ldw	_led_green+2,x
2804  0174 ae5555        	ldw	x,#21845
2805  0177 bf12          	ldw	_led_green,x
2807  0179 ac040804      	jpf	L7161
2808  017d               L5161:
2809                     ; 268 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2811  017d 3d04          	tnz	_bps_class
2812  017f 2703          	jreq	L02
2813  0181 cc0443        	jp	L1261
2814  0184               L02:
2815                     ; 270 	if(jp_mode!=jp3)
2817  0184 b64a          	ld	a,_jp_mode
2818  0186 a103          	cp	a,#3
2819  0188 2603          	jrne	L22
2820  018a cc033f        	jp	L3261
2821  018d               L22:
2822                     ; 272 		if(main_cnt1<(5*ee_TZAS))
2824  018d 9c            	rvf
2825  018e ce0016        	ldw	x,_ee_TZAS
2826  0191 90ae0005      	ldw	y,#5
2827  0195 cd0000        	call	c_imul
2829  0198 b351          	cpw	x,_main_cnt1
2830  019a 2d18          	jrsle	L5261
2831                     ; 274 			led_red=0x00000000L;
2833  019c ae0000        	ldw	x,#0
2834  019f bf10          	ldw	_led_red+2,x
2835  01a1 ae0000        	ldw	x,#0
2836  01a4 bf0e          	ldw	_led_red,x
2837                     ; 275 			led_green=0x0303030fL;
2839  01a6 ae030f        	ldw	x,#783
2840  01a9 bf14          	ldw	_led_green+2,x
2841  01ab ae0303        	ldw	x,#771
2842  01ae bf12          	ldw	_led_green,x
2844  01b0 acf102f1      	jpf	L7261
2845  01b4               L5261:
2846                     ; 278 		else if((link==ON)&&(flags_tu&0b10000000))
2848  01b4 b663          	ld	a,_link
2849  01b6 a155          	cp	a,#85
2850  01b8 261e          	jrne	L1361
2852  01ba b660          	ld	a,_flags_tu
2853  01bc a580          	bcp	a,#128
2854  01be 2718          	jreq	L1361
2855                     ; 280 			led_red=0x00055555L;
2857  01c0 ae5555        	ldw	x,#21845
2858  01c3 bf10          	ldw	_led_red+2,x
2859  01c5 ae0005        	ldw	x,#5
2860  01c8 bf0e          	ldw	_led_red,x
2861                     ; 281 			led_green=0xffffffffL;
2863  01ca aeffff        	ldw	x,#65535
2864  01cd bf14          	ldw	_led_green+2,x
2865  01cf aeffff        	ldw	x,#-1
2866  01d2 bf12          	ldw	_led_green,x
2868  01d4 acf102f1      	jpf	L7261
2869  01d8               L1361:
2870                     ; 284 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2872  01d8 9c            	rvf
2873  01d9 ce0016        	ldw	x,_ee_TZAS
2874  01dc 90ae0005      	ldw	y,#5
2875  01e0 cd0000        	call	c_imul
2877  01e3 b351          	cpw	x,_main_cnt1
2878  01e5 2e37          	jrsge	L5361
2880  01e7 9c            	rvf
2881  01e8 ce0016        	ldw	x,_ee_TZAS
2882  01eb 90ae0005      	ldw	y,#5
2883  01ef cd0000        	call	c_imul
2885  01f2 1c0064        	addw	x,#100
2886  01f5 b351          	cpw	x,_main_cnt1
2887  01f7 2d25          	jrsle	L5361
2889  01f9 ce0006        	ldw	x,_ee_AVT_MODE
2890  01fc a30055        	cpw	x,#85
2891  01ff 271d          	jreq	L5361
2893  0201 ce0004        	ldw	x,_ee_DEVICE
2894  0204 2618          	jrne	L5361
2895                     ; 286 			led_red=0x00000000L;
2897  0206 ae0000        	ldw	x,#0
2898  0209 bf10          	ldw	_led_red+2,x
2899  020b ae0000        	ldw	x,#0
2900  020e bf0e          	ldw	_led_red,x
2901                     ; 287 			led_green=0xffffffffL;	
2903  0210 aeffff        	ldw	x,#65535
2904  0213 bf14          	ldw	_led_green+2,x
2905  0215 aeffff        	ldw	x,#-1
2906  0218 bf12          	ldw	_led_green,x
2908  021a acf102f1      	jpf	L7261
2909  021e               L5361:
2910                     ; 290 		else  if(link==OFF)
2912  021e b663          	ld	a,_link
2913  0220 a1aa          	cp	a,#170
2914  0222 2618          	jrne	L1461
2915                     ; 292 			led_red=0x55555555L;
2917  0224 ae5555        	ldw	x,#21845
2918  0227 bf10          	ldw	_led_red+2,x
2919  0229 ae5555        	ldw	x,#21845
2920  022c bf0e          	ldw	_led_red,x
2921                     ; 293 			led_green=0xffffffffL;
2923  022e aeffff        	ldw	x,#65535
2924  0231 bf14          	ldw	_led_green+2,x
2925  0233 aeffff        	ldw	x,#-1
2926  0236 bf12          	ldw	_led_green,x
2928  0238 acf102f1      	jpf	L7261
2929  023c               L1461:
2930                     ; 296 		else if((link==ON)&&((flags&0b00111110)==0))
2932  023c b663          	ld	a,_link
2933  023e a155          	cp	a,#85
2934  0240 261d          	jrne	L5461
2936  0242 b605          	ld	a,_flags
2937  0244 a53e          	bcp	a,#62
2938  0246 2617          	jrne	L5461
2939                     ; 298 			led_red=0x00000000L;
2941  0248 ae0000        	ldw	x,#0
2942  024b bf10          	ldw	_led_red+2,x
2943  024d ae0000        	ldw	x,#0
2944  0250 bf0e          	ldw	_led_red,x
2945                     ; 299 			led_green=0xffffffffL;
2947  0252 aeffff        	ldw	x,#65535
2948  0255 bf14          	ldw	_led_green+2,x
2949  0257 aeffff        	ldw	x,#-1
2950  025a bf12          	ldw	_led_green,x
2952  025c cc02f1        	jra	L7261
2953  025f               L5461:
2954                     ; 302 		else if((flags&0b00111110)==0b00000100)
2956  025f b605          	ld	a,_flags
2957  0261 a43e          	and	a,#62
2958  0263 a104          	cp	a,#4
2959  0265 2616          	jrne	L1561
2960                     ; 304 			led_red=0x00010001L;
2962  0267 ae0001        	ldw	x,#1
2963  026a bf10          	ldw	_led_red+2,x
2964  026c ae0001        	ldw	x,#1
2965  026f bf0e          	ldw	_led_red,x
2966                     ; 305 			led_green=0xffffffffL;	
2968  0271 aeffff        	ldw	x,#65535
2969  0274 bf14          	ldw	_led_green+2,x
2970  0276 aeffff        	ldw	x,#-1
2971  0279 bf12          	ldw	_led_green,x
2973  027b 2074          	jra	L7261
2974  027d               L1561:
2975                     ; 307 		else if(flags&0b00000010)
2977  027d b605          	ld	a,_flags
2978  027f a502          	bcp	a,#2
2979  0281 2716          	jreq	L5561
2980                     ; 309 			led_red=0x00010001L;
2982  0283 ae0001        	ldw	x,#1
2983  0286 bf10          	ldw	_led_red+2,x
2984  0288 ae0001        	ldw	x,#1
2985  028b bf0e          	ldw	_led_red,x
2986                     ; 310 			led_green=0x00000000L;	
2988  028d ae0000        	ldw	x,#0
2989  0290 bf14          	ldw	_led_green+2,x
2990  0292 ae0000        	ldw	x,#0
2991  0295 bf12          	ldw	_led_green,x
2993  0297 2058          	jra	L7261
2994  0299               L5561:
2995                     ; 312 		else if(flags&0b00001000)
2997  0299 b605          	ld	a,_flags
2998  029b a508          	bcp	a,#8
2999  029d 2716          	jreq	L1661
3000                     ; 314 			led_red=0x00090009L;
3002  029f ae0009        	ldw	x,#9
3003  02a2 bf10          	ldw	_led_red+2,x
3004  02a4 ae0009        	ldw	x,#9
3005  02a7 bf0e          	ldw	_led_red,x
3006                     ; 315 			led_green=0x00000000L;	
3008  02a9 ae0000        	ldw	x,#0
3009  02ac bf14          	ldw	_led_green+2,x
3010  02ae ae0000        	ldw	x,#0
3011  02b1 bf12          	ldw	_led_green,x
3013  02b3 203c          	jra	L7261
3014  02b5               L1661:
3015                     ; 317 		else if(flags&0b00010000)
3017  02b5 b605          	ld	a,_flags
3018  02b7 a510          	bcp	a,#16
3019  02b9 2716          	jreq	L5661
3020                     ; 319 			led_red=0x00490049L;
3022  02bb ae0049        	ldw	x,#73
3023  02be bf10          	ldw	_led_red+2,x
3024  02c0 ae0049        	ldw	x,#73
3025  02c3 bf0e          	ldw	_led_red,x
3026                     ; 320 			led_green=0x00000000L;	
3028  02c5 ae0000        	ldw	x,#0
3029  02c8 bf14          	ldw	_led_green+2,x
3030  02ca ae0000        	ldw	x,#0
3031  02cd bf12          	ldw	_led_green,x
3033  02cf 2020          	jra	L7261
3034  02d1               L5661:
3035                     ; 323 		else if((link==ON)&&(flags&0b00100000))
3037  02d1 b663          	ld	a,_link
3038  02d3 a155          	cp	a,#85
3039  02d5 261a          	jrne	L7261
3041  02d7 b605          	ld	a,_flags
3042  02d9 a520          	bcp	a,#32
3043  02db 2714          	jreq	L7261
3044                     ; 325 			led_red=0x00000000L;
3046  02dd ae0000        	ldw	x,#0
3047  02e0 bf10          	ldw	_led_red+2,x
3048  02e2 ae0000        	ldw	x,#0
3049  02e5 bf0e          	ldw	_led_red,x
3050                     ; 326 			led_green=0x00030003L;
3052  02e7 ae0003        	ldw	x,#3
3053  02ea bf14          	ldw	_led_green+2,x
3054  02ec ae0003        	ldw	x,#3
3055  02ef bf12          	ldw	_led_green,x
3056  02f1               L7261:
3057                     ; 329 		if((jp_mode==jp1))
3059  02f1 b64a          	ld	a,_jp_mode
3060  02f3 a101          	cp	a,#1
3061  02f5 2616          	jrne	L3761
3062                     ; 331 			led_red=0x00000000L;
3064  02f7 ae0000        	ldw	x,#0
3065  02fa bf10          	ldw	_led_red+2,x
3066  02fc ae0000        	ldw	x,#0
3067  02ff bf0e          	ldw	_led_red,x
3068                     ; 332 			led_green=0x33333333L;
3070  0301 ae3333        	ldw	x,#13107
3071  0304 bf14          	ldw	_led_green+2,x
3072  0306 ae3333        	ldw	x,#13107
3073  0309 bf12          	ldw	_led_green,x
3075  030b 201a          	jra	L5761
3076  030d               L3761:
3077                     ; 334 		else if((jp_mode==jp2))
3079  030d b64a          	ld	a,_jp_mode
3080  030f a102          	cp	a,#2
3081  0311 2614          	jrne	L5761
3082                     ; 336 			led_red=0xccccccccL;
3084  0313 aecccc        	ldw	x,#52428
3085  0316 bf10          	ldw	_led_red+2,x
3086  0318 aecccc        	ldw	x,#-13108
3087  031b bf0e          	ldw	_led_red,x
3088                     ; 337 			led_green=0x00000000L;
3090  031d ae0000        	ldw	x,#0
3091  0320 bf14          	ldw	_led_green+2,x
3092  0322 ae0000        	ldw	x,#0
3093  0325 bf12          	ldw	_led_green,x
3094  0327               L5761:
3095                     ; 339 	led_red=0x00000000L;
3097  0327 ae0000        	ldw	x,#0
3098  032a bf10          	ldw	_led_red+2,x
3099  032c ae0000        	ldw	x,#0
3100  032f bf0e          	ldw	_led_red,x
3101                     ; 340 	led_green=0xffffffffL;			
3103  0331 aeffff        	ldw	x,#65535
3104  0334 bf14          	ldw	_led_green+2,x
3105  0336 aeffff        	ldw	x,#-1
3106  0339 bf12          	ldw	_led_green,x
3108  033b ac040804      	jpf	L7161
3109  033f               L3261:
3110                     ; 342 	else if(jp_mode==jp3)
3112  033f b64a          	ld	a,_jp_mode
3113  0341 a103          	cp	a,#3
3114  0343 2703          	jreq	L42
3115  0345 cc0804        	jp	L7161
3116  0348               L42:
3117                     ; 344 		if(main_cnt1<(5*ee_TZAS))
3119  0348 9c            	rvf
3120  0349 ce0016        	ldw	x,_ee_TZAS
3121  034c 90ae0005      	ldw	y,#5
3122  0350 cd0000        	call	c_imul
3124  0353 b351          	cpw	x,_main_cnt1
3125  0355 2d18          	jrsle	L5071
3126                     ; 346 			led_red=0x00000000L;
3128  0357 ae0000        	ldw	x,#0
3129  035a bf10          	ldw	_led_red+2,x
3130  035c ae0000        	ldw	x,#0
3131  035f bf0e          	ldw	_led_red,x
3132                     ; 347 			led_green=0x03030303L;
3134  0361 ae0303        	ldw	x,#771
3135  0364 bf14          	ldw	_led_green+2,x
3136  0366 ae0303        	ldw	x,#771
3137  0369 bf12          	ldw	_led_green,x
3139  036b ac040804      	jpf	L7161
3140  036f               L5071:
3141                     ; 349 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3143  036f 9c            	rvf
3144  0370 ce0016        	ldw	x,_ee_TZAS
3145  0373 90ae0005      	ldw	y,#5
3146  0377 cd0000        	call	c_imul
3148  037a b351          	cpw	x,_main_cnt1
3149  037c 2e2a          	jrsge	L1171
3151  037e 9c            	rvf
3152  037f ce0016        	ldw	x,_ee_TZAS
3153  0382 90ae0005      	ldw	y,#5
3154  0386 cd0000        	call	c_imul
3156  0389 1c0046        	addw	x,#70
3157  038c b351          	cpw	x,_main_cnt1
3158  038e 2d18          	jrsle	L1171
3159                     ; 351 			led_red=0x00000000L;
3161  0390 ae0000        	ldw	x,#0
3162  0393 bf10          	ldw	_led_red+2,x
3163  0395 ae0000        	ldw	x,#0
3164  0398 bf0e          	ldw	_led_red,x
3165                     ; 352 			led_green=0xffffffffL;	
3167  039a aeffff        	ldw	x,#65535
3168  039d bf14          	ldw	_led_green+2,x
3169  039f aeffff        	ldw	x,#-1
3170  03a2 bf12          	ldw	_led_green,x
3172  03a4 ac040804      	jpf	L7161
3173  03a8               L1171:
3174                     ; 355 		else if((flags&0b00011110)==0)
3176  03a8 b605          	ld	a,_flags
3177  03aa a51e          	bcp	a,#30
3178  03ac 2618          	jrne	L5171
3179                     ; 357 			led_red=0x00000000L;
3181  03ae ae0000        	ldw	x,#0
3182  03b1 bf10          	ldw	_led_red+2,x
3183  03b3 ae0000        	ldw	x,#0
3184  03b6 bf0e          	ldw	_led_red,x
3185                     ; 358 			led_green=0xffffffffL;
3187  03b8 aeffff        	ldw	x,#65535
3188  03bb bf14          	ldw	_led_green+2,x
3189  03bd aeffff        	ldw	x,#-1
3190  03c0 bf12          	ldw	_led_green,x
3192  03c2 ac040804      	jpf	L7161
3193  03c6               L5171:
3194                     ; 362 		else if((flags&0b00111110)==0b00000100)
3196  03c6 b605          	ld	a,_flags
3197  03c8 a43e          	and	a,#62
3198  03ca a104          	cp	a,#4
3199  03cc 2618          	jrne	L1271
3200                     ; 364 			led_red=0x00010001L;
3202  03ce ae0001        	ldw	x,#1
3203  03d1 bf10          	ldw	_led_red+2,x
3204  03d3 ae0001        	ldw	x,#1
3205  03d6 bf0e          	ldw	_led_red,x
3206                     ; 365 			led_green=0xffffffffL;	
3208  03d8 aeffff        	ldw	x,#65535
3209  03db bf14          	ldw	_led_green+2,x
3210  03dd aeffff        	ldw	x,#-1
3211  03e0 bf12          	ldw	_led_green,x
3213  03e2 ac040804      	jpf	L7161
3214  03e6               L1271:
3215                     ; 367 		else if(flags&0b00000010)
3217  03e6 b605          	ld	a,_flags
3218  03e8 a502          	bcp	a,#2
3219  03ea 2718          	jreq	L5271
3220                     ; 369 			led_red=0x00010001L;
3222  03ec ae0001        	ldw	x,#1
3223  03ef bf10          	ldw	_led_red+2,x
3224  03f1 ae0001        	ldw	x,#1
3225  03f4 bf0e          	ldw	_led_red,x
3226                     ; 370 			led_green=0x00000000L;	
3228  03f6 ae0000        	ldw	x,#0
3229  03f9 bf14          	ldw	_led_green+2,x
3230  03fb ae0000        	ldw	x,#0
3231  03fe bf12          	ldw	_led_green,x
3233  0400 ac040804      	jpf	L7161
3234  0404               L5271:
3235                     ; 372 		else if(flags&0b00001000)
3237  0404 b605          	ld	a,_flags
3238  0406 a508          	bcp	a,#8
3239  0408 2718          	jreq	L1371
3240                     ; 374 			led_red=0x00090009L;
3242  040a ae0009        	ldw	x,#9
3243  040d bf10          	ldw	_led_red+2,x
3244  040f ae0009        	ldw	x,#9
3245  0412 bf0e          	ldw	_led_red,x
3246                     ; 375 			led_green=0x00000000L;	
3248  0414 ae0000        	ldw	x,#0
3249  0417 bf14          	ldw	_led_green+2,x
3250  0419 ae0000        	ldw	x,#0
3251  041c bf12          	ldw	_led_green,x
3253  041e ac040804      	jpf	L7161
3254  0422               L1371:
3255                     ; 377 		else if(flags&0b00010000)
3257  0422 b605          	ld	a,_flags
3258  0424 a510          	bcp	a,#16
3259  0426 2603          	jrne	L62
3260  0428 cc0804        	jp	L7161
3261  042b               L62:
3262                     ; 379 			led_red=0x00490049L;
3264  042b ae0049        	ldw	x,#73
3265  042e bf10          	ldw	_led_red+2,x
3266  0430 ae0049        	ldw	x,#73
3267  0433 bf0e          	ldw	_led_red,x
3268                     ; 380 			led_green=0xffffffffL;	
3270  0435 aeffff        	ldw	x,#65535
3271  0438 bf14          	ldw	_led_green+2,x
3272  043a aeffff        	ldw	x,#-1
3273  043d bf12          	ldw	_led_green,x
3274  043f ac040804      	jpf	L7161
3275  0443               L1261:
3276                     ; 384 else if(bps_class==bpsIPS)	//если блок ИПСный
3278  0443 b604          	ld	a,_bps_class
3279  0445 a101          	cp	a,#1
3280  0447 2703          	jreq	L03
3281  0449 cc0804        	jp	L7161
3282  044c               L03:
3283                     ; 386 	if(jp_mode!=jp3)
3285  044c b64a          	ld	a,_jp_mode
3286  044e a103          	cp	a,#3
3287  0450 2603          	jrne	L23
3288  0452 cc06fc        	jp	L3471
3289  0455               L23:
3290                     ; 388 		if(main_cnt1<(5*ee_TZAS))
3292  0455 9c            	rvf
3293  0456 ce0016        	ldw	x,_ee_TZAS
3294  0459 90ae0005      	ldw	y,#5
3295  045d cd0000        	call	c_imul
3297  0460 b351          	cpw	x,_main_cnt1
3298  0462 2d18          	jrsle	L5471
3299                     ; 390 			led_red=0x00000000L;
3301  0464 ae0000        	ldw	x,#0
3302  0467 bf10          	ldw	_led_red+2,x
3303  0469 ae0000        	ldw	x,#0
3304  046c bf0e          	ldw	_led_red,x
3305                     ; 391 			led_green=0x0303033fL; 
3307  046e ae033f        	ldw	x,#831
3308  0471 bf14          	ldw	_led_green+2,x
3309  0473 ae0303        	ldw	x,#771
3310  0476 bf12          	ldw	_led_green,x
3312  0478 acbd06bd      	jpf	L7471
3313  047c               L5471:
3314                     ; 394 		else if((link==ON)&&(flags_tu&0b10000000))
3316  047c b663          	ld	a,_link
3317  047e a155          	cp	a,#85
3318  0480 261e          	jrne	L1571
3320  0482 b660          	ld	a,_flags_tu
3321  0484 a580          	bcp	a,#128
3322  0486 2718          	jreq	L1571
3323                     ; 396 			led_red=0x00055555L;
3325  0488 ae5555        	ldw	x,#21845
3326  048b bf10          	ldw	_led_red+2,x
3327  048d ae0005        	ldw	x,#5
3328  0490 bf0e          	ldw	_led_red,x
3329                     ; 397 			led_green=0xffffffffL;
3331  0492 aeffff        	ldw	x,#65535
3332  0495 bf14          	ldw	_led_green+2,x
3333  0497 aeffff        	ldw	x,#-1
3334  049a bf12          	ldw	_led_green,x
3336  049c acbd06bd      	jpf	L7471
3337  04a0               L1571:
3338                     ; 400 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3340  04a0 9c            	rvf
3341  04a1 ce0016        	ldw	x,_ee_TZAS
3342  04a4 90ae0005      	ldw	y,#5
3343  04a8 cd0000        	call	c_imul
3345  04ab b351          	cpw	x,_main_cnt1
3346  04ad 2e37          	jrsge	L5571
3348  04af 9c            	rvf
3349  04b0 ce0016        	ldw	x,_ee_TZAS
3350  04b3 90ae0005      	ldw	y,#5
3351  04b7 cd0000        	call	c_imul
3353  04ba 1c0064        	addw	x,#100
3354  04bd b351          	cpw	x,_main_cnt1
3355  04bf 2d25          	jrsle	L5571
3357  04c1 ce0006        	ldw	x,_ee_AVT_MODE
3358  04c4 a30055        	cpw	x,#85
3359  04c7 271d          	jreq	L5571
3361  04c9 ce0004        	ldw	x,_ee_DEVICE
3362  04cc 2618          	jrne	L5571
3363                     ; 402 			led_red=0x00000000L;
3365  04ce ae0000        	ldw	x,#0
3366  04d1 bf10          	ldw	_led_red+2,x
3367  04d3 ae0000        	ldw	x,#0
3368  04d6 bf0e          	ldw	_led_red,x
3369                     ; 403 			led_green=0xffffffffL;	
3371  04d8 aeffff        	ldw	x,#65535
3372  04db bf14          	ldw	_led_green+2,x
3373  04dd aeffff        	ldw	x,#-1
3374  04e0 bf12          	ldw	_led_green,x
3376  04e2 acbd06bd      	jpf	L7471
3377  04e6               L5571:
3378                     ; 406 		else  if(link==OFF)
3380  04e6 b663          	ld	a,_link
3381  04e8 a1aa          	cp	a,#170
3382  04ea 2703          	jreq	L43
3383  04ec cc0608        	jp	L1671
3384  04ef               L43:
3385                     ; 408 			if((flags&0b00011110)==0)
3387  04ef b605          	ld	a,_flags
3388  04f1 a51e          	bcp	a,#30
3389  04f3 262d          	jrne	L3671
3390                     ; 410 				led_red=0x00000000L;
3392  04f5 ae0000        	ldw	x,#0
3393  04f8 bf10          	ldw	_led_red+2,x
3394  04fa ae0000        	ldw	x,#0
3395  04fd bf0e          	ldw	_led_red,x
3396                     ; 411 				if(bMAIN)led_green=0xfffffff5L;
3398                     	btst	_bMAIN
3399  0504 240e          	jruge	L5671
3402  0506 aefff5        	ldw	x,#65525
3403  0509 bf14          	ldw	_led_green+2,x
3404  050b aeffff        	ldw	x,#-1
3405  050e bf12          	ldw	_led_green,x
3407  0510 acbd06bd      	jpf	L7471
3408  0514               L5671:
3409                     ; 412 				else led_green=0xffffffffL;
3411  0514 aeffff        	ldw	x,#65535
3412  0517 bf14          	ldw	_led_green+2,x
3413  0519 aeffff        	ldw	x,#-1
3414  051c bf12          	ldw	_led_green,x
3415  051e acbd06bd      	jpf	L7471
3416  0522               L3671:
3417                     ; 415 			else if((flags&0b00111110)==0b00000100)
3419  0522 b605          	ld	a,_flags
3420  0524 a43e          	and	a,#62
3421  0526 a104          	cp	a,#4
3422  0528 262d          	jrne	L3771
3423                     ; 417 				led_red=0x00010001L;
3425  052a ae0001        	ldw	x,#1
3426  052d bf10          	ldw	_led_red+2,x
3427  052f ae0001        	ldw	x,#1
3428  0532 bf0e          	ldw	_led_red,x
3429                     ; 418 				if(bMAIN)led_green=0xfffffff5L;
3431                     	btst	_bMAIN
3432  0539 240e          	jruge	L5771
3435  053b aefff5        	ldw	x,#65525
3436  053e bf14          	ldw	_led_green+2,x
3437  0540 aeffff        	ldw	x,#-1
3438  0543 bf12          	ldw	_led_green,x
3440  0545 acbd06bd      	jpf	L7471
3441  0549               L5771:
3442                     ; 419 				else led_green=0xffffffffL;	
3444  0549 aeffff        	ldw	x,#65535
3445  054c bf14          	ldw	_led_green+2,x
3446  054e aeffff        	ldw	x,#-1
3447  0551 bf12          	ldw	_led_green,x
3448  0553 acbd06bd      	jpf	L7471
3449  0557               L3771:
3450                     ; 421 			else if(flags&0b00000010)
3452  0557 b605          	ld	a,_flags
3453  0559 a502          	bcp	a,#2
3454  055b 272d          	jreq	L3002
3455                     ; 423 				led_red=0x00010001L;
3457  055d ae0001        	ldw	x,#1
3458  0560 bf10          	ldw	_led_red+2,x
3459  0562 ae0001        	ldw	x,#1
3460  0565 bf0e          	ldw	_led_red,x
3461                     ; 424 				if(bMAIN)led_green=0x00000005L;
3463                     	btst	_bMAIN
3464  056c 240e          	jruge	L5002
3467  056e ae0005        	ldw	x,#5
3468  0571 bf14          	ldw	_led_green+2,x
3469  0573 ae0000        	ldw	x,#0
3470  0576 bf12          	ldw	_led_green,x
3472  0578 acbd06bd      	jpf	L7471
3473  057c               L5002:
3474                     ; 425 				else led_green=0x00000000L;
3476  057c ae0000        	ldw	x,#0
3477  057f bf14          	ldw	_led_green+2,x
3478  0581 ae0000        	ldw	x,#0
3479  0584 bf12          	ldw	_led_green,x
3480  0586 acbd06bd      	jpf	L7471
3481  058a               L3002:
3482                     ; 427 			else if(flags&0b00001000)
3484  058a b605          	ld	a,_flags
3485  058c a508          	bcp	a,#8
3486  058e 272d          	jreq	L3102
3487                     ; 429 				led_red=0x00090009L;
3489  0590 ae0009        	ldw	x,#9
3490  0593 bf10          	ldw	_led_red+2,x
3491  0595 ae0009        	ldw	x,#9
3492  0598 bf0e          	ldw	_led_red,x
3493                     ; 430 				if(bMAIN)led_green=0x00000005L;
3495                     	btst	_bMAIN
3496  059f 240e          	jruge	L5102
3499  05a1 ae0005        	ldw	x,#5
3500  05a4 bf14          	ldw	_led_green+2,x
3501  05a6 ae0000        	ldw	x,#0
3502  05a9 bf12          	ldw	_led_green,x
3504  05ab acbd06bd      	jpf	L7471
3505  05af               L5102:
3506                     ; 431 				else led_green=0x00000000L;	
3508  05af ae0000        	ldw	x,#0
3509  05b2 bf14          	ldw	_led_green+2,x
3510  05b4 ae0000        	ldw	x,#0
3511  05b7 bf12          	ldw	_led_green,x
3512  05b9 acbd06bd      	jpf	L7471
3513  05bd               L3102:
3514                     ; 433 			else if(flags&0b00010000)
3516  05bd b605          	ld	a,_flags
3517  05bf a510          	bcp	a,#16
3518  05c1 272d          	jreq	L3202
3519                     ; 435 				led_red=0x00490049L;
3521  05c3 ae0049        	ldw	x,#73
3522  05c6 bf10          	ldw	_led_red+2,x
3523  05c8 ae0049        	ldw	x,#73
3524  05cb bf0e          	ldw	_led_red,x
3525                     ; 436 				if(bMAIN)led_green=0x00000005L;
3527                     	btst	_bMAIN
3528  05d2 240e          	jruge	L5202
3531  05d4 ae0005        	ldw	x,#5
3532  05d7 bf14          	ldw	_led_green+2,x
3533  05d9 ae0000        	ldw	x,#0
3534  05dc bf12          	ldw	_led_green,x
3536  05de acbd06bd      	jpf	L7471
3537  05e2               L5202:
3538                     ; 437 				else led_green=0x00000000L;	
3540  05e2 ae0000        	ldw	x,#0
3541  05e5 bf14          	ldw	_led_green+2,x
3542  05e7 ae0000        	ldw	x,#0
3543  05ea bf12          	ldw	_led_green,x
3544  05ec acbd06bd      	jpf	L7471
3545  05f0               L3202:
3546                     ; 441 				led_red=0x55555555L;
3548  05f0 ae5555        	ldw	x,#21845
3549  05f3 bf10          	ldw	_led_red+2,x
3550  05f5 ae5555        	ldw	x,#21845
3551  05f8 bf0e          	ldw	_led_red,x
3552                     ; 442 				led_green=0xffffffffL;
3554  05fa aeffff        	ldw	x,#65535
3555  05fd bf14          	ldw	_led_green+2,x
3556  05ff aeffff        	ldw	x,#-1
3557  0602 bf12          	ldw	_led_green,x
3558  0604 acbd06bd      	jpf	L7471
3559  0608               L1671:
3560                     ; 458 		else if((link==ON)&&((flags&0b00111110)==0))
3562  0608 b663          	ld	a,_link
3563  060a a155          	cp	a,#85
3564  060c 261d          	jrne	L5302
3566  060e b605          	ld	a,_flags
3567  0610 a53e          	bcp	a,#62
3568  0612 2617          	jrne	L5302
3569                     ; 460 			led_red=0x00000000L;
3571  0614 ae0000        	ldw	x,#0
3572  0617 bf10          	ldw	_led_red+2,x
3573  0619 ae0000        	ldw	x,#0
3574  061c bf0e          	ldw	_led_red,x
3575                     ; 461 			led_green=0xffffffffL;
3577  061e aeffff        	ldw	x,#65535
3578  0621 bf14          	ldw	_led_green+2,x
3579  0623 aeffff        	ldw	x,#-1
3580  0626 bf12          	ldw	_led_green,x
3582  0628 cc06bd        	jra	L7471
3583  062b               L5302:
3584                     ; 464 		else if((flags&0b00111110)==0b00000100)
3586  062b b605          	ld	a,_flags
3587  062d a43e          	and	a,#62
3588  062f a104          	cp	a,#4
3589  0631 2616          	jrne	L1402
3590                     ; 466 			led_red=0x00010001L;
3592  0633 ae0001        	ldw	x,#1
3593  0636 bf10          	ldw	_led_red+2,x
3594  0638 ae0001        	ldw	x,#1
3595  063b bf0e          	ldw	_led_red,x
3596                     ; 467 			led_green=0xffffffffL;	
3598  063d aeffff        	ldw	x,#65535
3599  0640 bf14          	ldw	_led_green+2,x
3600  0642 aeffff        	ldw	x,#-1
3601  0645 bf12          	ldw	_led_green,x
3603  0647 2074          	jra	L7471
3604  0649               L1402:
3605                     ; 469 		else if(flags&0b00000010)
3607  0649 b605          	ld	a,_flags
3608  064b a502          	bcp	a,#2
3609  064d 2716          	jreq	L5402
3610                     ; 471 			led_red=0x00010001L;
3612  064f ae0001        	ldw	x,#1
3613  0652 bf10          	ldw	_led_red+2,x
3614  0654 ae0001        	ldw	x,#1
3615  0657 bf0e          	ldw	_led_red,x
3616                     ; 472 			led_green=0x00000000L;	
3618  0659 ae0000        	ldw	x,#0
3619  065c bf14          	ldw	_led_green+2,x
3620  065e ae0000        	ldw	x,#0
3621  0661 bf12          	ldw	_led_green,x
3623  0663 2058          	jra	L7471
3624  0665               L5402:
3625                     ; 474 		else if(flags&0b00001000)
3627  0665 b605          	ld	a,_flags
3628  0667 a508          	bcp	a,#8
3629  0669 2716          	jreq	L1502
3630                     ; 476 			led_red=0x00090009L;
3632  066b ae0009        	ldw	x,#9
3633  066e bf10          	ldw	_led_red+2,x
3634  0670 ae0009        	ldw	x,#9
3635  0673 bf0e          	ldw	_led_red,x
3636                     ; 477 			led_green=0x00000000L;	
3638  0675 ae0000        	ldw	x,#0
3639  0678 bf14          	ldw	_led_green+2,x
3640  067a ae0000        	ldw	x,#0
3641  067d bf12          	ldw	_led_green,x
3643  067f 203c          	jra	L7471
3644  0681               L1502:
3645                     ; 479 		else if(flags&0b00010000)
3647  0681 b605          	ld	a,_flags
3648  0683 a510          	bcp	a,#16
3649  0685 2716          	jreq	L5502
3650                     ; 481 			led_red=0x00490049L;
3652  0687 ae0049        	ldw	x,#73
3653  068a bf10          	ldw	_led_red+2,x
3654  068c ae0049        	ldw	x,#73
3655  068f bf0e          	ldw	_led_red,x
3656                     ; 482 			led_green=0x00000000L;	
3658  0691 ae0000        	ldw	x,#0
3659  0694 bf14          	ldw	_led_green+2,x
3660  0696 ae0000        	ldw	x,#0
3661  0699 bf12          	ldw	_led_green,x
3663  069b 2020          	jra	L7471
3664  069d               L5502:
3665                     ; 485 		else if((link==ON)&&(flags&0b00100000))
3667  069d b663          	ld	a,_link
3668  069f a155          	cp	a,#85
3669  06a1 261a          	jrne	L7471
3671  06a3 b605          	ld	a,_flags
3672  06a5 a520          	bcp	a,#32
3673  06a7 2714          	jreq	L7471
3674                     ; 487 			led_red=0x00000000L;
3676  06a9 ae0000        	ldw	x,#0
3677  06ac bf10          	ldw	_led_red+2,x
3678  06ae ae0000        	ldw	x,#0
3679  06b1 bf0e          	ldw	_led_red,x
3680                     ; 488 			led_green=0x00030003L;
3682  06b3 ae0003        	ldw	x,#3
3683  06b6 bf14          	ldw	_led_green+2,x
3684  06b8 ae0003        	ldw	x,#3
3685  06bb bf12          	ldw	_led_green,x
3686  06bd               L7471:
3687                     ; 491 		if((jp_mode==jp1))
3689  06bd b64a          	ld	a,_jp_mode
3690  06bf a101          	cp	a,#1
3691  06c1 2618          	jrne	L3602
3692                     ; 493 			led_red=0x00000000L;
3694  06c3 ae0000        	ldw	x,#0
3695  06c6 bf10          	ldw	_led_red+2,x
3696  06c8 ae0000        	ldw	x,#0
3697  06cb bf0e          	ldw	_led_red,x
3698                     ; 494 			led_green=0x33333333L;
3700  06cd ae3333        	ldw	x,#13107
3701  06d0 bf14          	ldw	_led_green+2,x
3702  06d2 ae3333        	ldw	x,#13107
3703  06d5 bf12          	ldw	_led_green,x
3705  06d7 acf007f0      	jpf	L1702
3706  06db               L3602:
3707                     ; 496 		else if((jp_mode==jp2))
3709  06db b64a          	ld	a,_jp_mode
3710  06dd a102          	cp	a,#2
3711  06df 2703          	jreq	L63
3712  06e1 cc07f0        	jp	L1702
3713  06e4               L63:
3714                     ; 500 			led_red=0xccccccccL;
3716  06e4 aecccc        	ldw	x,#52428
3717  06e7 bf10          	ldw	_led_red+2,x
3718  06e9 aecccc        	ldw	x,#-13108
3719  06ec bf0e          	ldw	_led_red,x
3720                     ; 501 			led_green=0x00000000L;
3722  06ee ae0000        	ldw	x,#0
3723  06f1 bf14          	ldw	_led_green+2,x
3724  06f3 ae0000        	ldw	x,#0
3725  06f6 bf12          	ldw	_led_green,x
3726  06f8 acf007f0      	jpf	L1702
3727  06fc               L3471:
3728                     ; 504 	else if(jp_mode==jp3)
3730  06fc b64a          	ld	a,_jp_mode
3731  06fe a103          	cp	a,#3
3732  0700 2703          	jreq	L04
3733  0702 cc07f0        	jp	L1702
3734  0705               L04:
3735                     ; 506 		if(main_cnt1<(5*ee_TZAS))
3737  0705 9c            	rvf
3738  0706 ce0016        	ldw	x,_ee_TZAS
3739  0709 90ae0005      	ldw	y,#5
3740  070d cd0000        	call	c_imul
3742  0710 b351          	cpw	x,_main_cnt1
3743  0712 2d18          	jrsle	L5702
3744                     ; 508 			led_red=0x00000000L;
3746  0714 ae0000        	ldw	x,#0
3747  0717 bf10          	ldw	_led_red+2,x
3748  0719 ae0000        	ldw	x,#0
3749  071c bf0e          	ldw	_led_red,x
3750                     ; 509 			led_green=0x03030303L;
3752  071e ae0303        	ldw	x,#771
3753  0721 bf14          	ldw	_led_green+2,x
3754  0723 ae0303        	ldw	x,#771
3755  0726 bf12          	ldw	_led_green,x
3757  0728 acf007f0      	jpf	L1702
3758  072c               L5702:
3759                     ; 511 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3761  072c 9c            	rvf
3762  072d ce0016        	ldw	x,_ee_TZAS
3763  0730 90ae0005      	ldw	y,#5
3764  0734 cd0000        	call	c_imul
3766  0737 b351          	cpw	x,_main_cnt1
3767  0739 2e29          	jrsge	L1012
3769  073b 9c            	rvf
3770  073c ce0016        	ldw	x,_ee_TZAS
3771  073f 90ae0005      	ldw	y,#5
3772  0743 cd0000        	call	c_imul
3774  0746 1c0046        	addw	x,#70
3775  0749 b351          	cpw	x,_main_cnt1
3776  074b 2d17          	jrsle	L1012
3777                     ; 513 			led_red=0x00000000L;
3779  074d ae0000        	ldw	x,#0
3780  0750 bf10          	ldw	_led_red+2,x
3781  0752 ae0000        	ldw	x,#0
3782  0755 bf0e          	ldw	_led_red,x
3783                     ; 514 			led_green=0xffffffffL;	
3785  0757 aeffff        	ldw	x,#65535
3786  075a bf14          	ldw	_led_green+2,x
3787  075c aeffff        	ldw	x,#-1
3788  075f bf12          	ldw	_led_green,x
3790  0761 cc07f0        	jra	L1702
3791  0764               L1012:
3792                     ; 517 		else if((flags&0b00011110)==0)
3794  0764 b605          	ld	a,_flags
3795  0766 a51e          	bcp	a,#30
3796  0768 2616          	jrne	L5012
3797                     ; 519 			led_red=0x00000000L;
3799  076a ae0000        	ldw	x,#0
3800  076d bf10          	ldw	_led_red+2,x
3801  076f ae0000        	ldw	x,#0
3802  0772 bf0e          	ldw	_led_red,x
3803                     ; 520 			led_green=0xffffffffL;
3805  0774 aeffff        	ldw	x,#65535
3806  0777 bf14          	ldw	_led_green+2,x
3807  0779 aeffff        	ldw	x,#-1
3808  077c bf12          	ldw	_led_green,x
3810  077e 2070          	jra	L1702
3811  0780               L5012:
3812                     ; 524 		else if((flags&0b00111110)==0b00000100)
3814  0780 b605          	ld	a,_flags
3815  0782 a43e          	and	a,#62
3816  0784 a104          	cp	a,#4
3817  0786 2616          	jrne	L1112
3818                     ; 526 			led_red=0x00010001L;
3820  0788 ae0001        	ldw	x,#1
3821  078b bf10          	ldw	_led_red+2,x
3822  078d ae0001        	ldw	x,#1
3823  0790 bf0e          	ldw	_led_red,x
3824                     ; 527 			led_green=0xffffffffL;	
3826  0792 aeffff        	ldw	x,#65535
3827  0795 bf14          	ldw	_led_green+2,x
3828  0797 aeffff        	ldw	x,#-1
3829  079a bf12          	ldw	_led_green,x
3831  079c 2052          	jra	L1702
3832  079e               L1112:
3833                     ; 529 		else if(flags&0b00000010)
3835  079e b605          	ld	a,_flags
3836  07a0 a502          	bcp	a,#2
3837  07a2 2716          	jreq	L5112
3838                     ; 531 			led_red=0x00010001L;
3840  07a4 ae0001        	ldw	x,#1
3841  07a7 bf10          	ldw	_led_red+2,x
3842  07a9 ae0001        	ldw	x,#1
3843  07ac bf0e          	ldw	_led_red,x
3844                     ; 532 			led_green=0x00000000L;	
3846  07ae ae0000        	ldw	x,#0
3847  07b1 bf14          	ldw	_led_green+2,x
3848  07b3 ae0000        	ldw	x,#0
3849  07b6 bf12          	ldw	_led_green,x
3851  07b8 2036          	jra	L1702
3852  07ba               L5112:
3853                     ; 534 		else if(flags&0b00001000)
3855  07ba b605          	ld	a,_flags
3856  07bc a508          	bcp	a,#8
3857  07be 2716          	jreq	L1212
3858                     ; 536 			led_red=0x00090009L;
3860  07c0 ae0009        	ldw	x,#9
3861  07c3 bf10          	ldw	_led_red+2,x
3862  07c5 ae0009        	ldw	x,#9
3863  07c8 bf0e          	ldw	_led_red,x
3864                     ; 537 			led_green=0x00000000L;	
3866  07ca ae0000        	ldw	x,#0
3867  07cd bf14          	ldw	_led_green+2,x
3868  07cf ae0000        	ldw	x,#0
3869  07d2 bf12          	ldw	_led_green,x
3871  07d4 201a          	jra	L1702
3872  07d6               L1212:
3873                     ; 539 		else if(flags&0b00010000)
3875  07d6 b605          	ld	a,_flags
3876  07d8 a510          	bcp	a,#16
3877  07da 2714          	jreq	L1702
3878                     ; 541 			led_red=0x00490049L;
3880  07dc ae0049        	ldw	x,#73
3881  07df bf10          	ldw	_led_red+2,x
3882  07e1 ae0049        	ldw	x,#73
3883  07e4 bf0e          	ldw	_led_red,x
3884                     ; 542 			led_green=0xffffffffL;	
3886  07e6 aeffff        	ldw	x,#65535
3887  07e9 bf14          	ldw	_led_green+2,x
3888  07eb aeffff        	ldw	x,#-1
3889  07ee bf12          	ldw	_led_green,x
3890  07f0               L1702:
3891                     ; 545 	led_red=0xffffffffL;
3893  07f0 aeffff        	ldw	x,#65535
3894  07f3 bf10          	ldw	_led_red+2,x
3895  07f5 aeffff        	ldw	x,#-1
3896  07f8 bf0e          	ldw	_led_red,x
3897                     ; 546 	led_green=0x00000000L;		
3899  07fa ae0000        	ldw	x,#0
3900  07fd bf14          	ldw	_led_green+2,x
3901  07ff ae0000        	ldw	x,#0
3902  0802 bf12          	ldw	_led_green,x
3903  0804               L7161:
3904                     ; 548 }
3907  0804 81            	ret
3935                     ; 551 void led_drv(void)
3935                     ; 552 {
3936                     	switch	.text
3937  0805               _led_drv:
3941                     ; 554 GPIOA->DDR|=(1<<4);
3943  0805 72185002      	bset	20482,#4
3944                     ; 555 GPIOA->CR1|=(1<<4);
3946  0809 72185003      	bset	20483,#4
3947                     ; 556 GPIOA->CR2&=~(1<<4);
3949  080d 72195004      	bres	20484,#4
3950                     ; 557 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3952  0811 b640          	ld	a,_led_red_buff+3
3953  0813 a501          	bcp	a,#1
3954  0815 2706          	jreq	L7312
3957  0817 72185000      	bset	20480,#4
3959  081b 2004          	jra	L1412
3960  081d               L7312:
3961                     ; 558 else GPIOA->ODR&=~(1<<4); 
3963  081d 72195000      	bres	20480,#4
3964  0821               L1412:
3965                     ; 561 GPIOA->DDR|=(1<<5);
3967  0821 721a5002      	bset	20482,#5
3968                     ; 562 GPIOA->CR1|=(1<<5);
3970  0825 721a5003      	bset	20483,#5
3971                     ; 563 GPIOA->CR2&=~(1<<5);	
3973  0829 721b5004      	bres	20484,#5
3974                     ; 564 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3976  082d b63c          	ld	a,_led_green_buff+3
3977  082f a501          	bcp	a,#1
3978  0831 2706          	jreq	L3412
3981  0833 721a5000      	bset	20480,#5
3983  0837 2004          	jra	L5412
3984  0839               L3412:
3985                     ; 565 else GPIOA->ODR&=~(1<<5);
3987  0839 721b5000      	bres	20480,#5
3988  083d               L5412:
3989                     ; 568 led_red_buff>>=1;
3991  083d 373d          	sra	_led_red_buff
3992  083f 363e          	rrc	_led_red_buff+1
3993  0841 363f          	rrc	_led_red_buff+2
3994  0843 3640          	rrc	_led_red_buff+3
3995                     ; 569 led_green_buff>>=1;
3997  0845 3739          	sra	_led_green_buff
3998  0847 363a          	rrc	_led_green_buff+1
3999  0849 363b          	rrc	_led_green_buff+2
4000  084b 363c          	rrc	_led_green_buff+3
4001                     ; 570 if(++led_drv_cnt>32)
4003  084d 3c16          	inc	_led_drv_cnt
4004  084f b616          	ld	a,_led_drv_cnt
4005  0851 a121          	cp	a,#33
4006  0853 2512          	jrult	L7412
4007                     ; 572 	led_drv_cnt=0;
4009  0855 3f16          	clr	_led_drv_cnt
4010                     ; 573 	led_red_buff=led_red;
4012  0857 be10          	ldw	x,_led_red+2
4013  0859 bf3f          	ldw	_led_red_buff+2,x
4014  085b be0e          	ldw	x,_led_red
4015  085d bf3d          	ldw	_led_red_buff,x
4016                     ; 574 	led_green_buff=led_green;
4018  085f be14          	ldw	x,_led_green+2
4019  0861 bf3b          	ldw	_led_green_buff+2,x
4020  0863 be12          	ldw	x,_led_green
4021  0865 bf39          	ldw	_led_green_buff,x
4022  0867               L7412:
4023                     ; 580 } 
4026  0867 81            	ret
4052                     ; 583 void JP_drv(void)
4052                     ; 584 {
4053                     	switch	.text
4054  0868               _JP_drv:
4058                     ; 586 GPIOD->DDR&=~(1<<6);
4060  0868 721d5011      	bres	20497,#6
4061                     ; 587 GPIOD->CR1|=(1<<6);
4063  086c 721c5012      	bset	20498,#6
4064                     ; 588 GPIOD->CR2&=~(1<<6);
4066  0870 721d5013      	bres	20499,#6
4067                     ; 590 GPIOD->DDR&=~(1<<7);
4069  0874 721f5011      	bres	20497,#7
4070                     ; 591 GPIOD->CR1|=(1<<7);
4072  0878 721e5012      	bset	20498,#7
4073                     ; 592 GPIOD->CR2&=~(1<<7);
4075  087c 721f5013      	bres	20499,#7
4076                     ; 594 if(GPIOD->IDR&(1<<6))
4078  0880 c65010        	ld	a,20496
4079  0883 a540          	bcp	a,#64
4080  0885 270a          	jreq	L1612
4081                     ; 596 	if(cnt_JP0<10)
4083  0887 b649          	ld	a,_cnt_JP0
4084  0889 a10a          	cp	a,#10
4085  088b 2411          	jruge	L5612
4086                     ; 598 		cnt_JP0++;
4088  088d 3c49          	inc	_cnt_JP0
4089  088f 200d          	jra	L5612
4090  0891               L1612:
4091                     ; 601 else if(!(GPIOD->IDR&(1<<6)))
4093  0891 c65010        	ld	a,20496
4094  0894 a540          	bcp	a,#64
4095  0896 2606          	jrne	L5612
4096                     ; 603 	if(cnt_JP0)
4098  0898 3d49          	tnz	_cnt_JP0
4099  089a 2702          	jreq	L5612
4100                     ; 605 		cnt_JP0--;
4102  089c 3a49          	dec	_cnt_JP0
4103  089e               L5612:
4104                     ; 609 if(GPIOD->IDR&(1<<7))
4106  089e c65010        	ld	a,20496
4107  08a1 a580          	bcp	a,#128
4108  08a3 270a          	jreq	L3712
4109                     ; 611 	if(cnt_JP1<10)
4111  08a5 b648          	ld	a,_cnt_JP1
4112  08a7 a10a          	cp	a,#10
4113  08a9 2411          	jruge	L7712
4114                     ; 613 		cnt_JP1++;
4116  08ab 3c48          	inc	_cnt_JP1
4117  08ad 200d          	jra	L7712
4118  08af               L3712:
4119                     ; 616 else if(!(GPIOD->IDR&(1<<7)))
4121  08af c65010        	ld	a,20496
4122  08b2 a580          	bcp	a,#128
4123  08b4 2606          	jrne	L7712
4124                     ; 618 	if(cnt_JP1)
4126  08b6 3d48          	tnz	_cnt_JP1
4127  08b8 2702          	jreq	L7712
4128                     ; 620 		cnt_JP1--;
4130  08ba 3a48          	dec	_cnt_JP1
4131  08bc               L7712:
4132                     ; 625 if((cnt_JP0==10)&&(cnt_JP1==10))
4134  08bc b649          	ld	a,_cnt_JP0
4135  08be a10a          	cp	a,#10
4136  08c0 2608          	jrne	L5022
4138  08c2 b648          	ld	a,_cnt_JP1
4139  08c4 a10a          	cp	a,#10
4140  08c6 2602          	jrne	L5022
4141                     ; 627 	jp_mode=jp0;
4143  08c8 3f4a          	clr	_jp_mode
4144  08ca               L5022:
4145                     ; 629 if((cnt_JP0==0)&&(cnt_JP1==10))
4147  08ca 3d49          	tnz	_cnt_JP0
4148  08cc 260a          	jrne	L7022
4150  08ce b648          	ld	a,_cnt_JP1
4151  08d0 a10a          	cp	a,#10
4152  08d2 2604          	jrne	L7022
4153                     ; 631 	jp_mode=jp1;
4155  08d4 3501004a      	mov	_jp_mode,#1
4156  08d8               L7022:
4157                     ; 633 if((cnt_JP0==10)&&(cnt_JP1==0))
4159  08d8 b649          	ld	a,_cnt_JP0
4160  08da a10a          	cp	a,#10
4161  08dc 2608          	jrne	L1122
4163  08de 3d48          	tnz	_cnt_JP1
4164  08e0 2604          	jrne	L1122
4165                     ; 635 	jp_mode=jp2;
4167  08e2 3502004a      	mov	_jp_mode,#2
4168  08e6               L1122:
4169                     ; 637 if((cnt_JP0==0)&&(cnt_JP1==0))
4171  08e6 3d49          	tnz	_cnt_JP0
4172  08e8 2608          	jrne	L3122
4174  08ea 3d48          	tnz	_cnt_JP1
4175  08ec 2604          	jrne	L3122
4176                     ; 639 	jp_mode=jp3;
4178  08ee 3503004a      	mov	_jp_mode,#3
4179  08f2               L3122:
4180                     ; 642 }
4183  08f2 81            	ret
4215                     ; 645 void link_drv(void)		//10Hz
4215                     ; 646 {
4216                     	switch	.text
4217  08f3               _link_drv:
4221                     ; 647 if(jp_mode!=jp3)
4223  08f3 b64a          	ld	a,_jp_mode
4224  08f5 a103          	cp	a,#3
4225  08f7 274d          	jreq	L5222
4226                     ; 649 	if(link_cnt<602)link_cnt++;
4228  08f9 9c            	rvf
4229  08fa be61          	ldw	x,_link_cnt
4230  08fc a3025a        	cpw	x,#602
4231  08ff 2e07          	jrsge	L7222
4234  0901 be61          	ldw	x,_link_cnt
4235  0903 1c0001        	addw	x,#1
4236  0906 bf61          	ldw	_link_cnt,x
4237  0908               L7222:
4238                     ; 650 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4240  0908 be61          	ldw	x,_link_cnt
4241  090a a3024e        	cpw	x,#590
4242  090d 2606          	jrne	L1322
4245  090f b605          	ld	a,_flags
4246  0911 a4c1          	and	a,#193
4247  0913 b705          	ld	_flags,a
4248  0915               L1322:
4249                     ; 651 	if(link_cnt==600)
4251  0915 be61          	ldw	x,_link_cnt
4252  0917 a30258        	cpw	x,#600
4253  091a 262e          	jrne	L3422
4254                     ; 653 		link=OFF;
4256  091c 35aa0063      	mov	_link,#170
4257                     ; 658 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4259  0920 b604          	ld	a,_bps_class
4260  0922 a101          	cp	a,#1
4261  0924 2606          	jrne	L5322
4264  0926 72100001      	bset	_bMAIN
4266  092a 2004          	jra	L7322
4267  092c               L5322:
4268                     ; 659 		else bMAIN=0;
4270  092c 72110001      	bres	_bMAIN
4271  0930               L7322:
4272                     ; 661 		cnt_net_drv=0;
4274  0930 3f32          	clr	_cnt_net_drv
4275                     ; 662     		if(!res_fl_)
4277  0932 725d000a      	tnz	_res_fl_
4278  0936 2612          	jrne	L3422
4279                     ; 664 	    		bRES_=1;
4281  0938 3501000d      	mov	_bRES_,#1
4282                     ; 665 	    		res_fl_=1;
4284  093c a601          	ld	a,#1
4285  093e ae000a        	ldw	x,#_res_fl_
4286  0941 cd0000        	call	c_eewrc
4288  0944 2004          	jra	L3422
4289  0946               L5222:
4290                     ; 669 else link=OFF;	
4292  0946 35aa0063      	mov	_link,#170
4293  094a               L3422:
4294                     ; 670 } 
4297  094a 81            	ret
4367                     	switch	.const
4368  0004               L25:
4369  0004 0000000b      	dc.l	11
4370  0008               L45:
4371  0008 00000001      	dc.l	1
4372                     ; 674 void vent_drv(void)
4372                     ; 675 {
4373                     	switch	.text
4374  094b               _vent_drv:
4376  094b 520e          	subw	sp,#14
4377       0000000e      OFST:	set	14
4380                     ; 678 	short vent_pwm_i_necc=400;
4382  094d ae0190        	ldw	x,#400
4383  0950 1f07          	ldw	(OFST-7,sp),x
4384                     ; 679 	short vent_pwm_t_necc=400;
4386  0952 ae0190        	ldw	x,#400
4387  0955 1f09          	ldw	(OFST-5,sp),x
4388                     ; 680 	short vent_pwm_max_necc=400;
4390                     ; 685 	tempSL=36000L/(signed long)ee_Umax;
4392  0957 ce0014        	ldw	x,_ee_Umax
4393  095a cd0000        	call	c_itolx
4395  095d 96            	ldw	x,sp
4396  095e 1c0001        	addw	x,#OFST-13
4397  0961 cd0000        	call	c_rtol
4399  0964 ae8ca0        	ldw	x,#36000
4400  0967 bf02          	ldw	c_lreg+2,x
4401  0969 ae0000        	ldw	x,#0
4402  096c bf00          	ldw	c_lreg,x
4403  096e 96            	ldw	x,sp
4404  096f 1c0001        	addw	x,#OFST-13
4405  0972 cd0000        	call	c_ldiv
4407  0975 96            	ldw	x,sp
4408  0976 1c000b        	addw	x,#OFST-3
4409  0979 cd0000        	call	c_rtol
4411                     ; 686 	tempSL=(signed long)I/tempSL;
4413  097c ce0012        	ldw	x,_I
4414  097f cd0000        	call	c_itolx
4416  0982 96            	ldw	x,sp
4417  0983 1c000b        	addw	x,#OFST-3
4418  0986 cd0000        	call	c_ldiv
4420  0989 96            	ldw	x,sp
4421  098a 1c000b        	addw	x,#OFST-3
4422  098d cd0000        	call	c_rtol
4424                     ; 688 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4426  0990 ce0004        	ldw	x,_ee_DEVICE
4427  0993 a30001        	cpw	x,#1
4428  0996 2614          	jrne	L7722
4431  0998 ce0012        	ldw	x,_I
4432  099b 90ce0002      	ldw	y,_ee_IMAXVENT
4433  099f cd0000        	call	c_idiv
4435  09a2 cd0000        	call	c_itolx
4437  09a5 96            	ldw	x,sp
4438  09a6 1c000b        	addw	x,#OFST-3
4439  09a9 cd0000        	call	c_rtol
4441  09ac               L7722:
4442                     ; 690 	if(tempSL>10)vent_pwm_i_necc=1000;
4444  09ac 9c            	rvf
4445  09ad 96            	ldw	x,sp
4446  09ae 1c000b        	addw	x,#OFST-3
4447  09b1 cd0000        	call	c_ltor
4449  09b4 ae0004        	ldw	x,#L25
4450  09b7 cd0000        	call	c_lcmp
4452  09ba 2f07          	jrslt	L1032
4455  09bc ae03e8        	ldw	x,#1000
4456  09bf 1f07          	ldw	(OFST-7,sp),x
4458  09c1 2025          	jra	L3032
4459  09c3               L1032:
4460                     ; 691 	else if(tempSL<1)vent_pwm_i_necc=400;
4462  09c3 9c            	rvf
4463  09c4 96            	ldw	x,sp
4464  09c5 1c000b        	addw	x,#OFST-3
4465  09c8 cd0000        	call	c_ltor
4467  09cb ae0008        	ldw	x,#L45
4468  09ce cd0000        	call	c_lcmp
4470  09d1 2e07          	jrsge	L5032
4473  09d3 ae0190        	ldw	x,#400
4474  09d6 1f07          	ldw	(OFST-7,sp),x
4476  09d8 200e          	jra	L3032
4477  09da               L5032:
4478                     ; 692 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4480  09da 1e0d          	ldw	x,(OFST-1,sp)
4481  09dc 90ae003c      	ldw	y,#60
4482  09e0 cd0000        	call	c_imul
4484  09e3 1c0190        	addw	x,#400
4485  09e6 1f07          	ldw	(OFST-7,sp),x
4486  09e8               L3032:
4487                     ; 693 	gran(&vent_pwm_i_necc,400,1000);
4489  09e8 ae03e8        	ldw	x,#1000
4490  09eb 89            	pushw	x
4491  09ec ae0190        	ldw	x,#400
4492  09ef 89            	pushw	x
4493  09f0 96            	ldw	x,sp
4494  09f1 1c000b        	addw	x,#OFST-3
4495  09f4 cd00d1        	call	_gran
4497  09f7 5b04          	addw	sp,#4
4498                     ; 695 	tempSL=(signed long)T;
4500  09f9 b668          	ld	a,_T
4501  09fb b703          	ld	c_lreg+3,a
4502  09fd 48            	sll	a
4503  09fe 4f            	clr	a
4504  09ff a200          	sbc	a,#0
4505  0a01 b702          	ld	c_lreg+2,a
4506  0a03 b701          	ld	c_lreg+1,a
4507  0a05 b700          	ld	c_lreg,a
4508  0a07 96            	ldw	x,sp
4509  0a08 1c000b        	addw	x,#OFST-3
4510  0a0b cd0000        	call	c_rtol
4512                     ; 696 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4514  0a0e 9c            	rvf
4515  0a0f ce000e        	ldw	x,_ee_tsign
4516  0a12 cd0000        	call	c_itolx
4518  0a15 a61e          	ld	a,#30
4519  0a17 cd0000        	call	c_lsbc
4521  0a1a 96            	ldw	x,sp
4522  0a1b 1c000b        	addw	x,#OFST-3
4523  0a1e cd0000        	call	c_lcmp
4525  0a21 2f07          	jrslt	L1132
4528  0a23 ae0190        	ldw	x,#400
4529  0a26 1f09          	ldw	(OFST-5,sp),x
4531  0a28 2030          	jra	L3132
4532  0a2a               L1132:
4533                     ; 697 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4535  0a2a 9c            	rvf
4536  0a2b ce000e        	ldw	x,_ee_tsign
4537  0a2e cd0000        	call	c_itolx
4539  0a31 96            	ldw	x,sp
4540  0a32 1c000b        	addw	x,#OFST-3
4541  0a35 cd0000        	call	c_lcmp
4543  0a38 2c07          	jrsgt	L5132
4546  0a3a ae03e8        	ldw	x,#1000
4547  0a3d 1f09          	ldw	(OFST-5,sp),x
4549  0a3f 2019          	jra	L3132
4550  0a41               L5132:
4551                     ; 698 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4553  0a41 ce000e        	ldw	x,_ee_tsign
4554  0a44 1d001e        	subw	x,#30
4555  0a47 1f03          	ldw	(OFST-11,sp),x
4556  0a49 1e0d          	ldw	x,(OFST-1,sp)
4557  0a4b 72f003        	subw	x,(OFST-11,sp)
4558  0a4e 90ae0014      	ldw	y,#20
4559  0a52 cd0000        	call	c_imul
4561  0a55 1c0190        	addw	x,#400
4562  0a58 1f09          	ldw	(OFST-5,sp),x
4563  0a5a               L3132:
4564                     ; 699 	gran(&vent_pwm_t_necc,400,1000);
4566  0a5a ae03e8        	ldw	x,#1000
4567  0a5d 89            	pushw	x
4568  0a5e ae0190        	ldw	x,#400
4569  0a61 89            	pushw	x
4570  0a62 96            	ldw	x,sp
4571  0a63 1c000d        	addw	x,#OFST-1
4572  0a66 cd00d1        	call	_gran
4574  0a69 5b04          	addw	sp,#4
4575                     ; 701 	vent_pwm_max_necc=vent_pwm_i_necc;
4577  0a6b 1e07          	ldw	x,(OFST-7,sp)
4578  0a6d 1f05          	ldw	(OFST-9,sp),x
4579                     ; 702 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4581  0a6f 9c            	rvf
4582  0a70 1e09          	ldw	x,(OFST-5,sp)
4583  0a72 1307          	cpw	x,(OFST-7,sp)
4584  0a74 2d04          	jrsle	L1232
4587  0a76 1e09          	ldw	x,(OFST-5,sp)
4588  0a78 1f05          	ldw	(OFST-9,sp),x
4589  0a7a               L1232:
4590                     ; 704 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4592  0a7a 9c            	rvf
4593  0a7b be05          	ldw	x,_vent_pwm
4594  0a7d 1305          	cpw	x,(OFST-9,sp)
4595  0a7f 2e07          	jrsge	L3232
4598  0a81 be05          	ldw	x,_vent_pwm
4599  0a83 1c000a        	addw	x,#10
4600  0a86 bf05          	ldw	_vent_pwm,x
4601  0a88               L3232:
4602                     ; 705 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4604  0a88 9c            	rvf
4605  0a89 be05          	ldw	x,_vent_pwm
4606  0a8b 1305          	cpw	x,(OFST-9,sp)
4607  0a8d 2d07          	jrsle	L5232
4610  0a8f be05          	ldw	x,_vent_pwm
4611  0a91 1d000a        	subw	x,#10
4612  0a94 bf05          	ldw	_vent_pwm,x
4613  0a96               L5232:
4614                     ; 706 	gran(&vent_pwm,400,1000);
4616  0a96 ae03e8        	ldw	x,#1000
4617  0a99 89            	pushw	x
4618  0a9a ae0190        	ldw	x,#400
4619  0a9d 89            	pushw	x
4620  0a9e ae0005        	ldw	x,#_vent_pwm
4621  0aa1 cd00d1        	call	_gran
4623  0aa4 5b04          	addw	sp,#4
4624                     ; 710 	if(bVENT_BLOCK)vent_pwm=0;
4626  0aa6 3d00          	tnz	_bVENT_BLOCK
4627  0aa8 2703          	jreq	L7232
4630  0aaa 5f            	clrw	x
4631  0aab bf05          	ldw	_vent_pwm,x
4632  0aad               L7232:
4633                     ; 711 }
4636  0aad 5b0e          	addw	sp,#14
4637  0aaf 81            	ret
4664                     ; 716 void pwr_drv(void)
4664                     ; 717 {
4665                     	switch	.text
4666  0ab0               _pwr_drv:
4670                     ; 778 gran(&pwm_u,2,1020);
4672  0ab0 ae03fc        	ldw	x,#1020
4673  0ab3 89            	pushw	x
4674  0ab4 ae0002        	ldw	x,#2
4675  0ab7 89            	pushw	x
4676  0ab8 ae0008        	ldw	x,#_pwm_u
4677  0abb cd00d1        	call	_gran
4679  0abe 5b04          	addw	sp,#4
4680                     ; 788 TIM1->CCR2H= (char)(pwm_u/256);	
4682  0ac0 be08          	ldw	x,_pwm_u
4683  0ac2 90ae0100      	ldw	y,#256
4684  0ac6 cd0000        	call	c_idiv
4686  0ac9 9f            	ld	a,xl
4687  0aca c75267        	ld	21095,a
4688                     ; 789 TIM1->CCR2L= (char)pwm_u;
4690  0acd 5500095268    	mov	21096,_pwm_u+1
4691                     ; 791 TIM1->CCR1H= (char)(pwm_i/256);	
4693  0ad2 be0a          	ldw	x,_pwm_i
4694  0ad4 90ae0100      	ldw	y,#256
4695  0ad8 cd0000        	call	c_idiv
4697  0adb 9f            	ld	a,xl
4698  0adc c75265        	ld	21093,a
4699                     ; 792 TIM1->CCR1L= (char)pwm_i;
4701  0adf 55000b5266    	mov	21094,_pwm_i+1
4702                     ; 794 TIM1->CCR3H= (char)(vent_pwm/256);	
4704  0ae4 be05          	ldw	x,_vent_pwm
4705  0ae6 90ae0100      	ldw	y,#256
4706  0aea cd0000        	call	c_idiv
4708  0aed 9f            	ld	a,xl
4709  0aee c75269        	ld	21097,a
4710                     ; 795 TIM1->CCR3L= (char)vent_pwm;
4712  0af1 550006526a    	mov	21098,_vent_pwm+1
4713                     ; 796 }
4716  0af6 81            	ret
4775                     	switch	.const
4776  000c               L26:
4777  000c 0000028a      	dc.l	650
4778                     ; 801 void pwr_hndl(void)				
4778                     ; 802 {
4779                     	switch	.text
4780  0af7               _pwr_hndl:
4782  0af7 5209          	subw	sp,#9
4783       00000009      OFST:	set	9
4786                     ; 803 if(jp_mode==jp3)
4788  0af9 b64a          	ld	a,_jp_mode
4789  0afb a103          	cp	a,#3
4790  0afd 260a          	jrne	L3632
4791                     ; 805 	pwm_u_=0;
4793  0aff 5f            	clrw	x
4794  0b00 bf4b          	ldw	_pwm_u_,x
4795                     ; 806 	pwm_i=0;
4797  0b02 5f            	clrw	x
4798  0b03 bf0a          	ldw	_pwm_i,x
4800  0b05 acbb0bbb      	jpf	L5632
4801  0b09               L3632:
4802                     ; 808 else if(jp_mode==jp2)
4804  0b09 b64a          	ld	a,_jp_mode
4805  0b0b a102          	cp	a,#2
4806  0b0d 260c          	jrne	L7632
4807                     ; 810 	pwm_u_=0;
4809  0b0f 5f            	clrw	x
4810  0b10 bf4b          	ldw	_pwm_u_,x
4811                     ; 811 	pwm_i=0x3ff;
4813  0b12 ae03ff        	ldw	x,#1023
4814  0b15 bf0a          	ldw	_pwm_i,x
4816  0b17 acbb0bbb      	jpf	L5632
4817  0b1b               L7632:
4818                     ; 813 else if(jp_mode==jp1)
4820  0b1b b64a          	ld	a,_jp_mode
4821  0b1d a101          	cp	a,#1
4822  0b1f 260e          	jrne	L3732
4823                     ; 815 	pwm_u_=0x3ff;
4825  0b21 ae03ff        	ldw	x,#1023
4826  0b24 bf4b          	ldw	_pwm_u_,x
4827                     ; 816 	pwm_i=0x3ff;
4829  0b26 ae03ff        	ldw	x,#1023
4830  0b29 bf0a          	ldw	_pwm_i,x
4832  0b2b acbb0bbb      	jpf	L5632
4833  0b2f               L3732:
4834                     ; 827 else if(link==OFF)
4836  0b2f b663          	ld	a,_link
4837  0b31 a1aa          	cp	a,#170
4838  0b33 261b          	jrne	L7732
4839                     ; 829 	pwm_i=0x3ff;
4841  0b35 ae03ff        	ldw	x,#1023
4842  0b38 bf0a          	ldw	_pwm_i,x
4843                     ; 830 	pwm_u_=(short)((1000L*((long)Unecc))/650L);
4845  0b3a ce000a        	ldw	x,_Unecc
4846  0b3d 90ae03e8      	ldw	y,#1000
4847  0b41 cd0000        	call	c_vmul
4849  0b44 ae000c        	ldw	x,#L26
4850  0b47 cd0000        	call	c_ldiv
4852  0b4a be02          	ldw	x,c_lreg+2
4853  0b4c bf4b          	ldw	_pwm_u_,x
4855  0b4e 206b          	jra	L5632
4856  0b50               L7732:
4857                     ; 833 else	if(link==ON)				//если есть связьvol_i_temp_avar
4859  0b50 b663          	ld	a,_link
4860  0b52 a155          	cp	a,#85
4861  0b54 2665          	jrne	L5632
4862                     ; 835 	if((flags&0b00100000)==0)	//если нет блокировки извне
4864  0b56 b605          	ld	a,_flags
4865  0b58 a520          	bcp	a,#32
4866  0b5a 2653          	jrne	L5042
4867                     ; 837 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4869  0b5c b605          	ld	a,_flags
4870  0b5e a51a          	bcp	a,#26
4871  0b60 262e          	jrne	L7042
4872                     ; 839 			pwm_i=1000;
4874  0b62 ae03e8        	ldw	x,#1000
4875  0b65 bf0a          	ldw	_pwm_i,x
4876                     ; 841 			pwm_u_=(short)(((1000L*((long)Unecc))/650L)+_x_);
4878  0b67 be5e          	ldw	x,__x_
4879  0b69 cd0000        	call	c_itolx
4881  0b6c 96            	ldw	x,sp
4882  0b6d 1c0001        	addw	x,#OFST-8
4883  0b70 cd0000        	call	c_rtol
4885  0b73 ce000a        	ldw	x,_Unecc
4886  0b76 90ae03e8      	ldw	y,#1000
4887  0b7a cd0000        	call	c_vmul
4889  0b7d ae000c        	ldw	x,#L26
4890  0b80 cd0000        	call	c_ldiv
4892  0b83 96            	ldw	x,sp
4893  0b84 1c0001        	addw	x,#OFST-8
4894  0b87 cd0000        	call	c_ladd
4896  0b8a be02          	ldw	x,c_lreg+2
4897  0b8c bf4b          	ldw	_pwm_u_,x
4899  0b8e 200c          	jra	L1142
4900  0b90               L7042:
4901                     ; 843 		else if(flags&0b00011010)					//если есть аварии
4903  0b90 b605          	ld	a,_flags
4904  0b92 a51a          	bcp	a,#26
4905  0b94 2706          	jreq	L1142
4906                     ; 845 			pwm_u_=0;								//то полный стоп
4908  0b96 5f            	clrw	x
4909  0b97 bf4b          	ldw	_pwm_u_,x
4910                     ; 846 			pwm_i=0;
4912  0b99 5f            	clrw	x
4913  0b9a bf0a          	ldw	_pwm_i,x
4914  0b9c               L1142:
4915                     ; 849 		if(vol_i_temp==1000)
4917  0b9c be56          	ldw	x,_vol_i_temp
4918  0b9e a303e8        	cpw	x,#1000
4919  0ba1 2618          	jrne	L5632
4920                     ; 851 			pwm_u_=1000;
4922  0ba3 ae03e8        	ldw	x,#1000
4923  0ba6 bf4b          	ldw	_pwm_u_,x
4924                     ; 852 			pwm_i=1000;
4926  0ba8 ae03e8        	ldw	x,#1000
4927  0bab bf0a          	ldw	_pwm_i,x
4928  0bad 200c          	jra	L5632
4929  0baf               L5042:
4930                     ; 855 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4932  0baf b605          	ld	a,_flags
4933  0bb1 a520          	bcp	a,#32
4934  0bb3 2706          	jreq	L5632
4935                     ; 857 		pwm_u_=0;
4937  0bb5 5f            	clrw	x
4938  0bb6 bf4b          	ldw	_pwm_u_,x
4939                     ; 858 		pwm_i=0;
4941  0bb8 5f            	clrw	x
4942  0bb9 bf0a          	ldw	_pwm_i,x
4943  0bbb               L5632:
4944                     ; 863 pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4946  0bbb c60015        	ld	a,_pwm_u_buff_ptr
4947  0bbe 5f            	clrw	x
4948  0bbf 97            	ld	xl,a
4949  0bc0 58            	sllw	x
4950  0bc1 90be4b        	ldw	y,_pwm_u_
4951  0bc4 df0018        	ldw	(_pwm_u_buff,x),y
4952                     ; 864 pwm_u_buff_ptr++;
4954  0bc7 725c0015      	inc	_pwm_u_buff_ptr
4955                     ; 865 if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4957  0bcb c60015        	ld	a,_pwm_u_buff_ptr
4958  0bce a110          	cp	a,#16
4959  0bd0 2504          	jrult	L3242
4962  0bd2 725f0015      	clr	_pwm_u_buff_ptr
4963  0bd6               L3242:
4964                     ; 869 tempSL=0;
4966  0bd6 ae0000        	ldw	x,#0
4967  0bd9 1f07          	ldw	(OFST-2,sp),x
4968  0bdb ae0000        	ldw	x,#0
4969  0bde 1f05          	ldw	(OFST-4,sp),x
4970                     ; 870 for(i=0;i<16;i++)
4972  0be0 0f09          	clr	(OFST+0,sp)
4973  0be2               L5242:
4974                     ; 872 	tempSL+=(signed long)pwm_u_buff[i];
4976  0be2 7b09          	ld	a,(OFST+0,sp)
4977  0be4 5f            	clrw	x
4978  0be5 97            	ld	xl,a
4979  0be6 58            	sllw	x
4980  0be7 de0018        	ldw	x,(_pwm_u_buff,x)
4981  0bea cd0000        	call	c_itolx
4983  0bed 96            	ldw	x,sp
4984  0bee 1c0005        	addw	x,#OFST-4
4985  0bf1 cd0000        	call	c_lgadd
4987                     ; 870 for(i=0;i<16;i++)
4989  0bf4 0c09          	inc	(OFST+0,sp)
4992  0bf6 7b09          	ld	a,(OFST+0,sp)
4993  0bf8 a110          	cp	a,#16
4994  0bfa 25e6          	jrult	L5242
4995                     ; 874 tempSL>>=4;
4997  0bfc 96            	ldw	x,sp
4998  0bfd 1c0005        	addw	x,#OFST-4
4999  0c00 a604          	ld	a,#4
5000  0c02 cd0000        	call	c_lgrsh
5002                     ; 875 pwm_u_buff_=(signed short)tempSL;
5004  0c05 1e07          	ldw	x,(OFST-2,sp)
5005  0c07 cf0016        	ldw	_pwm_u_buff_,x
5006                     ; 877 pwm_u=pwm_u_;
5008  0c0a be4b          	ldw	x,_pwm_u_
5009  0c0c bf08          	ldw	_pwm_u,x
5010                     ; 878 if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
5012  0c0e 9c            	rvf
5013  0c0f ce000e        	ldw	x,_Ui
5014  0c12 72b0000a      	subw	x,_Unecc
5015  0c16 cd0000        	call	_abs
5017  0c19 a30014        	cpw	x,#20
5018  0c1c 2e06          	jrsge	L3342
5021  0c1e 725c0014      	inc	_pwm_u_buff_cnt
5023  0c22 2004          	jra	L5342
5024  0c24               L3342:
5025                     ; 879 else pwm_u_buff_cnt=0;
5027  0c24 725f0014      	clr	_pwm_u_buff_cnt
5028  0c28               L5342:
5029                     ; 881 if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
5031  0c28 c60014        	ld	a,_pwm_u_buff_cnt
5032  0c2b a114          	cp	a,#20
5033  0c2d 2504          	jrult	L7342
5036  0c2f 35140014      	mov	_pwm_u_buff_cnt,#20
5037  0c33               L7342:
5038                     ; 882 if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
5040  0c33 c60014        	ld	a,_pwm_u_buff_cnt
5041  0c36 a10f          	cp	a,#15
5042  0c38 2505          	jrult	L1442
5045  0c3a ce0016        	ldw	x,_pwm_u_buff_
5046  0c3d bf08          	ldw	_pwm_u,x
5047  0c3f               L1442:
5048                     ; 885 if(pwm_u>main_cnt*10)pwm_u=main_cnt*10;
5050  0c3f 9c            	rvf
5051  0c40 ce0255        	ldw	x,_main_cnt
5052  0c43 90ae000a      	ldw	y,#10
5053  0c47 cd0000        	call	c_imul
5055  0c4a b308          	cpw	x,_pwm_u
5056  0c4c 2e0c          	jrsge	L3442
5059  0c4e ce0255        	ldw	x,_main_cnt
5060  0c51 90ae000a      	ldw	y,#10
5061  0c55 cd0000        	call	c_imul
5063  0c58 bf08          	ldw	_pwm_u,x
5064  0c5a               L3442:
5065                     ; 886 if(pwm_u>1000)pwm_u=1000;
5067  0c5a 9c            	rvf
5068  0c5b be08          	ldw	x,_pwm_u
5069  0c5d a303e9        	cpw	x,#1001
5070  0c60 2f05          	jrslt	L5442
5073  0c62 ae03e8        	ldw	x,#1000
5074  0c65 bf08          	ldw	_pwm_u,x
5075  0c67               L5442:
5076                     ; 887 if(pwm_i>1000)pwm_i=1000;
5078  0c67 9c            	rvf
5079  0c68 be0a          	ldw	x,_pwm_i
5080  0c6a a303e9        	cpw	x,#1001
5081  0c6d 2f05          	jrslt	L7442
5084  0c6f ae03e8        	ldw	x,#1000
5085  0c72 bf0a          	ldw	_pwm_i,x
5086  0c74               L7442:
5087                     ; 889 }
5090  0c74 5b09          	addw	sp,#9
5091  0c76 81            	ret
5146                     	switch	.const
5147  0010               L66:
5148  0010 00000258      	dc.l	600
5149  0014               L07:
5150  0014 000003e8      	dc.l	1000
5151  0018               L27:
5152  0018 00000708      	dc.l	1800
5153                     ; 892 void matemat(void)
5153                     ; 893 {
5154                     	switch	.text
5155  0c77               _matemat:
5157  0c77 5208          	subw	sp,#8
5158       00000008      OFST:	set	8
5161                     ; 917 I=adc_buff_[4];
5163  0c79 ce0109        	ldw	x,_adc_buff_+8
5164  0c7c cf0012        	ldw	_I,x
5165                     ; 918 temp_SL=adc_buff_[4];
5167  0c7f ce0109        	ldw	x,_adc_buff_+8
5168  0c82 cd0000        	call	c_itolx
5170  0c85 96            	ldw	x,sp
5171  0c86 1c0005        	addw	x,#OFST-3
5172  0c89 cd0000        	call	c_rtol
5174                     ; 919 temp_SL-=ee_K[0][0];
5176  0c8c ce001a        	ldw	x,_ee_K
5177  0c8f cd0000        	call	c_itolx
5179  0c92 96            	ldw	x,sp
5180  0c93 1c0005        	addw	x,#OFST-3
5181  0c96 cd0000        	call	c_lgsub
5183                     ; 920 if(temp_SL<0) temp_SL=0;
5185  0c99 9c            	rvf
5186  0c9a 0d05          	tnz	(OFST-3,sp)
5187  0c9c 2e0a          	jrsge	L7642
5190  0c9e ae0000        	ldw	x,#0
5191  0ca1 1f07          	ldw	(OFST-1,sp),x
5192  0ca3 ae0000        	ldw	x,#0
5193  0ca6 1f05          	ldw	(OFST-3,sp),x
5194  0ca8               L7642:
5195                     ; 921 temp_SL*=ee_K[0][1];
5197  0ca8 ce001c        	ldw	x,_ee_K+2
5198  0cab cd0000        	call	c_itolx
5200  0cae 96            	ldw	x,sp
5201  0caf 1c0005        	addw	x,#OFST-3
5202  0cb2 cd0000        	call	c_lgmul
5204                     ; 922 temp_SL/=600;
5206  0cb5 96            	ldw	x,sp
5207  0cb6 1c0005        	addw	x,#OFST-3
5208  0cb9 cd0000        	call	c_ltor
5210  0cbc ae0010        	ldw	x,#L66
5211  0cbf cd0000        	call	c_ldiv
5213  0cc2 96            	ldw	x,sp
5214  0cc3 1c0005        	addw	x,#OFST-3
5215  0cc6 cd0000        	call	c_rtol
5217                     ; 923 I=(signed short)temp_SL;
5219  0cc9 1e07          	ldw	x,(OFST-1,sp)
5220  0ccb cf0012        	ldw	_I,x
5221                     ; 926 temp_SL=(signed long)adc_buff_[1];//1;
5223                     ; 927 temp_SL=(signed long)adc_buff_[3];//1;
5225  0cce ce0107        	ldw	x,_adc_buff_+6
5226  0cd1 cd0000        	call	c_itolx
5228  0cd4 96            	ldw	x,sp
5229  0cd5 1c0005        	addw	x,#OFST-3
5230  0cd8 cd0000        	call	c_rtol
5232                     ; 929 if(temp_SL<0) temp_SL=0;
5234  0cdb 9c            	rvf
5235  0cdc 0d05          	tnz	(OFST-3,sp)
5236  0cde 2e0a          	jrsge	L1742
5239  0ce0 ae0000        	ldw	x,#0
5240  0ce3 1f07          	ldw	(OFST-1,sp),x
5241  0ce5 ae0000        	ldw	x,#0
5242  0ce8 1f05          	ldw	(OFST-3,sp),x
5243  0cea               L1742:
5244                     ; 930 temp_SL*=(signed long)ee_K[2][1];
5246  0cea ce0024        	ldw	x,_ee_K+10
5247  0ced cd0000        	call	c_itolx
5249  0cf0 96            	ldw	x,sp
5250  0cf1 1c0005        	addw	x,#OFST-3
5251  0cf4 cd0000        	call	c_lgmul
5253                     ; 931 temp_SL/=1000L;
5255  0cf7 96            	ldw	x,sp
5256  0cf8 1c0005        	addw	x,#OFST-3
5257  0cfb cd0000        	call	c_ltor
5259  0cfe ae0014        	ldw	x,#L07
5260  0d01 cd0000        	call	c_ldiv
5262  0d04 96            	ldw	x,sp
5263  0d05 1c0005        	addw	x,#OFST-3
5264  0d08 cd0000        	call	c_rtol
5266                     ; 932 Ui=(unsigned short)temp_SL;
5268  0d0b 1e07          	ldw	x,(OFST-1,sp)
5269  0d0d cf000e        	ldw	_Ui,x
5270                     ; 934 temp_SL=(signed long)adc_buff_5;
5272  0d10 ce00ff        	ldw	x,_adc_buff_5
5273  0d13 cd0000        	call	c_itolx
5275  0d16 96            	ldw	x,sp
5276  0d17 1c0005        	addw	x,#OFST-3
5277  0d1a cd0000        	call	c_rtol
5279                     ; 936 if(temp_SL<0) temp_SL=0;
5281  0d1d 9c            	rvf
5282  0d1e 0d05          	tnz	(OFST-3,sp)
5283  0d20 2e0a          	jrsge	L3742
5286  0d22 ae0000        	ldw	x,#0
5287  0d25 1f07          	ldw	(OFST-1,sp),x
5288  0d27 ae0000        	ldw	x,#0
5289  0d2a 1f05          	ldw	(OFST-3,sp),x
5290  0d2c               L3742:
5291                     ; 937 temp_SL*=(signed long)ee_K[4][1];
5293  0d2c ce002c        	ldw	x,_ee_K+18
5294  0d2f cd0000        	call	c_itolx
5296  0d32 96            	ldw	x,sp
5297  0d33 1c0005        	addw	x,#OFST-3
5298  0d36 cd0000        	call	c_lgmul
5300                     ; 938 temp_SL/=1000L;
5302  0d39 96            	ldw	x,sp
5303  0d3a 1c0005        	addw	x,#OFST-3
5304  0d3d cd0000        	call	c_ltor
5306  0d40 ae0014        	ldw	x,#L07
5307  0d43 cd0000        	call	c_ldiv
5309  0d46 96            	ldw	x,sp
5310  0d47 1c0005        	addw	x,#OFST-3
5311  0d4a cd0000        	call	c_rtol
5313                     ; 939 Usum=(unsigned short)temp_SL;
5315  0d4d 1e07          	ldw	x,(OFST-1,sp)
5316  0d4f cf0006        	ldw	_Usum,x
5317                     ; 943 temp_SL=adc_buff_[3];
5319  0d52 ce0107        	ldw	x,_adc_buff_+6
5320  0d55 cd0000        	call	c_itolx
5322  0d58 96            	ldw	x,sp
5323  0d59 1c0005        	addw	x,#OFST-3
5324  0d5c cd0000        	call	c_rtol
5326                     ; 945 if(temp_SL<0) temp_SL=0;
5328  0d5f 9c            	rvf
5329  0d60 0d05          	tnz	(OFST-3,sp)
5330  0d62 2e0a          	jrsge	L5742
5333  0d64 ae0000        	ldw	x,#0
5334  0d67 1f07          	ldw	(OFST-1,sp),x
5335  0d69 ae0000        	ldw	x,#0
5336  0d6c 1f05          	ldw	(OFST-3,sp),x
5337  0d6e               L5742:
5338                     ; 946 temp_SL*=ee_K[1][1];
5340  0d6e ce0020        	ldw	x,_ee_K+6
5341  0d71 cd0000        	call	c_itolx
5343  0d74 96            	ldw	x,sp
5344  0d75 1c0005        	addw	x,#OFST-3
5345  0d78 cd0000        	call	c_lgmul
5347                     ; 947 temp_SL/=1800;
5349  0d7b 96            	ldw	x,sp
5350  0d7c 1c0005        	addw	x,#OFST-3
5351  0d7f cd0000        	call	c_ltor
5353  0d82 ae0018        	ldw	x,#L27
5354  0d85 cd0000        	call	c_ldiv
5356  0d88 96            	ldw	x,sp
5357  0d89 1c0005        	addw	x,#OFST-3
5358  0d8c cd0000        	call	c_rtol
5360                     ; 948 Un=(unsigned short)temp_SL;
5362  0d8f 1e07          	ldw	x,(OFST-1,sp)
5363  0d91 cf0010        	ldw	_Un,x
5364                     ; 951 Un=pwm_u;//vol_i_temp;//2345;
5366  0d94 be08          	ldw	x,_pwm_u
5367  0d96 cf0010        	ldw	_Un,x
5368                     ; 953 temp_SL=adc_buff_[2];
5370  0d99 ce0105        	ldw	x,_adc_buff_+4
5371  0d9c cd0000        	call	c_itolx
5373  0d9f 96            	ldw	x,sp
5374  0da0 1c0005        	addw	x,#OFST-3
5375  0da3 cd0000        	call	c_rtol
5377                     ; 954 temp_SL*=ee_K[3][1];
5379  0da6 ce0028        	ldw	x,_ee_K+14
5380  0da9 cd0000        	call	c_itolx
5382  0dac 96            	ldw	x,sp
5383  0dad 1c0005        	addw	x,#OFST-3
5384  0db0 cd0000        	call	c_lgmul
5386                     ; 955 temp_SL/=1000;
5388  0db3 96            	ldw	x,sp
5389  0db4 1c0005        	addw	x,#OFST-3
5390  0db7 cd0000        	call	c_ltor
5392  0dba ae0014        	ldw	x,#L07
5393  0dbd cd0000        	call	c_ldiv
5395  0dc0 96            	ldw	x,sp
5396  0dc1 1c0005        	addw	x,#OFST-3
5397  0dc4 cd0000        	call	c_rtol
5399                     ; 956 T=(signed short)(temp_SL-273L);
5401  0dc7 7b08          	ld	a,(OFST+0,sp)
5402  0dc9 5f            	clrw	x
5403  0dca 4d            	tnz	a
5404  0dcb 2a01          	jrpl	L47
5405  0dcd 53            	cplw	x
5406  0dce               L47:
5407  0dce 97            	ld	xl,a
5408  0dcf 1d0111        	subw	x,#273
5409  0dd2 01            	rrwa	x,a
5410  0dd3 b768          	ld	_T,a
5411  0dd5 02            	rlwa	x,a
5412                     ; 957 if(T<-30)T=-30;
5414  0dd6 9c            	rvf
5415  0dd7 b668          	ld	a,_T
5416  0dd9 a1e2          	cp	a,#226
5417  0ddb 2e04          	jrsge	L7742
5420  0ddd 35e20068      	mov	_T,#226
5421  0de1               L7742:
5422                     ; 958 if(T>120)T=120;
5424  0de1 9c            	rvf
5425  0de2 b668          	ld	a,_T
5426  0de4 a179          	cp	a,#121
5427  0de6 2f04          	jrslt	L1052
5430  0de8 35780068      	mov	_T,#120
5431  0dec               L1052:
5432                     ; 960 Udb=flags;
5434  0dec b605          	ld	a,_flags
5435  0dee 5f            	clrw	x
5436  0def 97            	ld	xl,a
5437  0df0 cf000c        	ldw	_Udb,x
5438                     ; 962 Uin=Usum-Ui;
5440  0df3 ce0006        	ldw	x,_Usum
5441  0df6 72b0000e      	subw	x,_Ui
5442  0dfa cf0004        	ldw	_Uin,x
5443                     ; 963 if(link==ON)
5445  0dfd b663          	ld	a,_link
5446  0dff a155          	cp	a,#85
5447  0e01 2641          	jrne	L3052
5448                     ; 965 	Unecc=U_out_const-Uin;
5450  0e03 ce0008        	ldw	x,_U_out_const
5451  0e06 72b00004      	subw	x,_Uin
5452  0e0a cf000a        	ldw	_Unecc,x
5453                     ; 966 	if(vol_i_temp!=1000)
5455  0e0d be56          	ldw	x,_vol_i_temp
5456  0e0f a303e8        	cpw	x,#1000
5457  0e12 271c          	jreq	L5052
5458                     ; 968 		gran(&vol_i_temp,-50,50);
5460  0e14 ae0032        	ldw	x,#50
5461  0e17 89            	pushw	x
5462  0e18 aeffce        	ldw	x,#65486
5463  0e1b 89            	pushw	x
5464  0e1c ae0056        	ldw	x,#_vol_i_temp
5465  0e1f cd00d1        	call	_gran
5467  0e22 5b04          	addw	sp,#4
5468                     ; 969 		Unecc+=vol_i_temp;
5470  0e24 ce000a        	ldw	x,_Unecc
5471  0e27 72bb0056      	addw	x,_vol_i_temp
5472  0e2b cf000a        	ldw	_Unecc,x
5474  0e2e 200a          	jra	L7052
5475  0e30               L5052:
5476                     ; 971 	else Unecc=ee_UAVT-Uin;
5478  0e30 ce000c        	ldw	x,_ee_UAVT
5479  0e33 72b00004      	subw	x,_Uin
5480  0e37 cf000a        	ldw	_Unecc,x
5481  0e3a               L7052:
5482                     ; 972 	if(Unecc<0)Unecc=0;
5484  0e3a 9c            	rvf
5485  0e3b ce000a        	ldw	x,_Unecc
5486  0e3e 2e04          	jrsge	L3052
5489  0e40 5f            	clrw	x
5490  0e41 cf000a        	ldw	_Unecc,x
5491  0e44               L3052:
5492                     ; 974 Un=Unecc;
5494  0e44 ce000a        	ldw	x,_Unecc
5495  0e47 cf0010        	ldw	_Un,x
5496                     ; 982 temp_SL=(signed long)(T-ee_tsign);
5498  0e4a 5f            	clrw	x
5499  0e4b b668          	ld	a,_T
5500  0e4d 2a01          	jrpl	L67
5501  0e4f 53            	cplw	x
5502  0e50               L67:
5503  0e50 97            	ld	xl,a
5504  0e51 72b0000e      	subw	x,_ee_tsign
5505  0e55 cd0000        	call	c_itolx
5507  0e58 96            	ldw	x,sp
5508  0e59 1c0005        	addw	x,#OFST-3
5509  0e5c cd0000        	call	c_rtol
5511                     ; 983 temp_SL*=1000L;
5513  0e5f ae03e8        	ldw	x,#1000
5514  0e62 bf02          	ldw	c_lreg+2,x
5515  0e64 ae0000        	ldw	x,#0
5516  0e67 bf00          	ldw	c_lreg,x
5517  0e69 96            	ldw	x,sp
5518  0e6a 1c0005        	addw	x,#OFST-3
5519  0e6d cd0000        	call	c_lgmul
5521                     ; 984 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5523  0e70 ce0010        	ldw	x,_ee_tmax
5524  0e73 72b0000e      	subw	x,_ee_tsign
5525  0e77 cd0000        	call	c_itolx
5527  0e7a 96            	ldw	x,sp
5528  0e7b 1c0001        	addw	x,#OFST-7
5529  0e7e cd0000        	call	c_rtol
5531  0e81 96            	ldw	x,sp
5532  0e82 1c0005        	addw	x,#OFST-3
5533  0e85 cd0000        	call	c_ltor
5535  0e88 96            	ldw	x,sp
5536  0e89 1c0001        	addw	x,#OFST-7
5537  0e8c cd0000        	call	c_ldiv
5539  0e8f 96            	ldw	x,sp
5540  0e90 1c0005        	addw	x,#OFST-3
5541  0e93 cd0000        	call	c_rtol
5543                     ; 986 vol_i_temp_avar=(unsigned short)temp_SL; 
5545  0e96 1e07          	ldw	x,(OFST-1,sp)
5546  0e98 bf06          	ldw	_vol_i_temp_avar,x
5547                     ; 988 }
5550  0e9a 5b08          	addw	sp,#8
5551  0e9c 81            	ret
5582                     ; 991 void temper_drv(void)		//1 Hz
5582                     ; 992 {
5583                     	switch	.text
5584  0e9d               _temper_drv:
5588                     ; 994 if(T>ee_tsign) tsign_cnt++;
5590  0e9d 9c            	rvf
5591  0e9e 5f            	clrw	x
5592  0e9f b668          	ld	a,_T
5593  0ea1 2a01          	jrpl	L201
5594  0ea3 53            	cplw	x
5595  0ea4               L201:
5596  0ea4 97            	ld	xl,a
5597  0ea5 c3000e        	cpw	x,_ee_tsign
5598  0ea8 2d09          	jrsle	L3252
5601  0eaa be4f          	ldw	x,_tsign_cnt
5602  0eac 1c0001        	addw	x,#1
5603  0eaf bf4f          	ldw	_tsign_cnt,x
5605  0eb1 201d          	jra	L5252
5606  0eb3               L3252:
5607                     ; 995 else if (T<(ee_tsign-1)) tsign_cnt--;
5609  0eb3 9c            	rvf
5610  0eb4 ce000e        	ldw	x,_ee_tsign
5611  0eb7 5a            	decw	x
5612  0eb8 905f          	clrw	y
5613  0eba b668          	ld	a,_T
5614  0ebc 2a02          	jrpl	L401
5615  0ebe 9053          	cplw	y
5616  0ec0               L401:
5617  0ec0 9097          	ld	yl,a
5618  0ec2 90bf00        	ldw	c_y,y
5619  0ec5 b300          	cpw	x,c_y
5620  0ec7 2d07          	jrsle	L5252
5623  0ec9 be4f          	ldw	x,_tsign_cnt
5624  0ecb 1d0001        	subw	x,#1
5625  0ece bf4f          	ldw	_tsign_cnt,x
5626  0ed0               L5252:
5627                     ; 997 gran(&tsign_cnt,0,60);
5629  0ed0 ae003c        	ldw	x,#60
5630  0ed3 89            	pushw	x
5631  0ed4 5f            	clrw	x
5632  0ed5 89            	pushw	x
5633  0ed6 ae004f        	ldw	x,#_tsign_cnt
5634  0ed9 cd00d1        	call	_gran
5636  0edc 5b04          	addw	sp,#4
5637                     ; 999 if(tsign_cnt>=55)
5639  0ede 9c            	rvf
5640  0edf be4f          	ldw	x,_tsign_cnt
5641  0ee1 a30037        	cpw	x,#55
5642  0ee4 2f16          	jrslt	L1352
5643                     ; 1001 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5645  0ee6 3d4a          	tnz	_jp_mode
5646  0ee8 2606          	jrne	L7352
5648  0eea b605          	ld	a,_flags
5649  0eec a540          	bcp	a,#64
5650  0eee 2706          	jreq	L5352
5651  0ef0               L7352:
5653  0ef0 b64a          	ld	a,_jp_mode
5654  0ef2 a103          	cp	a,#3
5655  0ef4 2612          	jrne	L1452
5656  0ef6               L5352:
5659  0ef6 72140005      	bset	_flags,#2
5660  0efa 200c          	jra	L1452
5661  0efc               L1352:
5662                     ; 1003 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5664  0efc 9c            	rvf
5665  0efd be4f          	ldw	x,_tsign_cnt
5666  0eff a30006        	cpw	x,#6
5667  0f02 2e04          	jrsge	L1452
5670  0f04 72150005      	bres	_flags,#2
5671  0f08               L1452:
5672                     ; 1008 if(T>ee_tmax) tmax_cnt++;
5674  0f08 9c            	rvf
5675  0f09 5f            	clrw	x
5676  0f0a b668          	ld	a,_T
5677  0f0c 2a01          	jrpl	L601
5678  0f0e 53            	cplw	x
5679  0f0f               L601:
5680  0f0f 97            	ld	xl,a
5681  0f10 c30010        	cpw	x,_ee_tmax
5682  0f13 2d09          	jrsle	L5452
5685  0f15 be4d          	ldw	x,_tmax_cnt
5686  0f17 1c0001        	addw	x,#1
5687  0f1a bf4d          	ldw	_tmax_cnt,x
5689  0f1c 201d          	jra	L7452
5690  0f1e               L5452:
5691                     ; 1009 else if (T<(ee_tmax-1)) tmax_cnt--;
5693  0f1e 9c            	rvf
5694  0f1f ce0010        	ldw	x,_ee_tmax
5695  0f22 5a            	decw	x
5696  0f23 905f          	clrw	y
5697  0f25 b668          	ld	a,_T
5698  0f27 2a02          	jrpl	L011
5699  0f29 9053          	cplw	y
5700  0f2b               L011:
5701  0f2b 9097          	ld	yl,a
5702  0f2d 90bf00        	ldw	c_y,y
5703  0f30 b300          	cpw	x,c_y
5704  0f32 2d07          	jrsle	L7452
5707  0f34 be4d          	ldw	x,_tmax_cnt
5708  0f36 1d0001        	subw	x,#1
5709  0f39 bf4d          	ldw	_tmax_cnt,x
5710  0f3b               L7452:
5711                     ; 1011 gran(&tmax_cnt,0,60);
5713  0f3b ae003c        	ldw	x,#60
5714  0f3e 89            	pushw	x
5715  0f3f 5f            	clrw	x
5716  0f40 89            	pushw	x
5717  0f41 ae004d        	ldw	x,#_tmax_cnt
5718  0f44 cd00d1        	call	_gran
5720  0f47 5b04          	addw	sp,#4
5721                     ; 1013 if(tmax_cnt>=55)
5723  0f49 9c            	rvf
5724  0f4a be4d          	ldw	x,_tmax_cnt
5725  0f4c a30037        	cpw	x,#55
5726  0f4f 2f16          	jrslt	L3552
5727                     ; 1015 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5729  0f51 3d4a          	tnz	_jp_mode
5730  0f53 2606          	jrne	L1652
5732  0f55 b605          	ld	a,_flags
5733  0f57 a540          	bcp	a,#64
5734  0f59 2706          	jreq	L7552
5735  0f5b               L1652:
5737  0f5b b64a          	ld	a,_jp_mode
5738  0f5d a103          	cp	a,#3
5739  0f5f 2612          	jrne	L3652
5740  0f61               L7552:
5743  0f61 72120005      	bset	_flags,#1
5744  0f65 200c          	jra	L3652
5745  0f67               L3552:
5746                     ; 1017 else if (tmax_cnt<=5) flags&=0b11111101;
5748  0f67 9c            	rvf
5749  0f68 be4d          	ldw	x,_tmax_cnt
5750  0f6a a30006        	cpw	x,#6
5751  0f6d 2e04          	jrsge	L3652
5754  0f6f 72130005      	bres	_flags,#1
5755  0f73               L3652:
5756                     ; 1020 } 
5759  0f73 81            	ret
5791                     ; 1023 void u_drv(void)		//1Hz
5791                     ; 1024 { 
5792                     	switch	.text
5793  0f74               _u_drv:
5797                     ; 1025 if(jp_mode!=jp3)
5799  0f74 b64a          	ld	a,_jp_mode
5800  0f76 a103          	cp	a,#3
5801  0f78 2774          	jreq	L7752
5802                     ; 1027 	if(Ui>ee_Umax)umax_cnt++;
5804  0f7a 9c            	rvf
5805  0f7b ce000e        	ldw	x,_Ui
5806  0f7e c30014        	cpw	x,_ee_Umax
5807  0f81 2d09          	jrsle	L1062
5810  0f83 be66          	ldw	x,_umax_cnt
5811  0f85 1c0001        	addw	x,#1
5812  0f88 bf66          	ldw	_umax_cnt,x
5814  0f8a 2003          	jra	L3062
5815  0f8c               L1062:
5816                     ; 1028 	else umax_cnt=0;
5818  0f8c 5f            	clrw	x
5819  0f8d bf66          	ldw	_umax_cnt,x
5820  0f8f               L3062:
5821                     ; 1029 	gran(&umax_cnt,0,10);
5823  0f8f ae000a        	ldw	x,#10
5824  0f92 89            	pushw	x
5825  0f93 5f            	clrw	x
5826  0f94 89            	pushw	x
5827  0f95 ae0066        	ldw	x,#_umax_cnt
5828  0f98 cd00d1        	call	_gran
5830  0f9b 5b04          	addw	sp,#4
5831                     ; 1030 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5833  0f9d 9c            	rvf
5834  0f9e be66          	ldw	x,_umax_cnt
5835  0fa0 a3000a        	cpw	x,#10
5836  0fa3 2f04          	jrslt	L5062
5839  0fa5 72160005      	bset	_flags,#3
5840  0fa9               L5062:
5841                     ; 1033 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5843  0fa9 9c            	rvf
5844  0faa ce000e        	ldw	x,_Ui
5845  0fad c30010        	cpw	x,_Un
5846  0fb0 2e1d          	jrsge	L7062
5848  0fb2 9c            	rvf
5849  0fb3 ce0010        	ldw	x,_Un
5850  0fb6 72b0000e      	subw	x,_Ui
5851  0fba c30012        	cpw	x,_ee_dU
5852  0fbd 2d10          	jrsle	L7062
5854  0fbf c65005        	ld	a,20485
5855  0fc2 a504          	bcp	a,#4
5856  0fc4 2609          	jrne	L7062
5859  0fc6 be64          	ldw	x,_umin_cnt
5860  0fc8 1c0001        	addw	x,#1
5861  0fcb bf64          	ldw	_umin_cnt,x
5863  0fcd 2003          	jra	L1162
5864  0fcf               L7062:
5865                     ; 1034 	else umin_cnt=0;
5867  0fcf 5f            	clrw	x
5868  0fd0 bf64          	ldw	_umin_cnt,x
5869  0fd2               L1162:
5870                     ; 1035 	gran(&umin_cnt,0,10);	
5872  0fd2 ae000a        	ldw	x,#10
5873  0fd5 89            	pushw	x
5874  0fd6 5f            	clrw	x
5875  0fd7 89            	pushw	x
5876  0fd8 ae0064        	ldw	x,#_umin_cnt
5877  0fdb cd00d1        	call	_gran
5879  0fde 5b04          	addw	sp,#4
5880                     ; 1036 	if(umin_cnt>=10)flags|=0b00010000;	  
5882  0fe0 9c            	rvf
5883  0fe1 be64          	ldw	x,_umin_cnt
5884  0fe3 a3000a        	cpw	x,#10
5885  0fe6 2f71          	jrslt	L5162
5888  0fe8 72180005      	bset	_flags,#4
5889  0fec 206b          	jra	L5162
5890  0fee               L7752:
5891                     ; 1038 else if(jp_mode==jp3)
5893  0fee b64a          	ld	a,_jp_mode
5894  0ff0 a103          	cp	a,#3
5895  0ff2 2665          	jrne	L5162
5896                     ; 1040 	if(Ui>700)umax_cnt++;
5898  0ff4 9c            	rvf
5899  0ff5 ce000e        	ldw	x,_Ui
5900  0ff8 a302bd        	cpw	x,#701
5901  0ffb 2f09          	jrslt	L1262
5904  0ffd be66          	ldw	x,_umax_cnt
5905  0fff 1c0001        	addw	x,#1
5906  1002 bf66          	ldw	_umax_cnt,x
5908  1004 2003          	jra	L3262
5909  1006               L1262:
5910                     ; 1041 	else umax_cnt=0;
5912  1006 5f            	clrw	x
5913  1007 bf66          	ldw	_umax_cnt,x
5914  1009               L3262:
5915                     ; 1042 	gran(&umax_cnt,0,10);
5917  1009 ae000a        	ldw	x,#10
5918  100c 89            	pushw	x
5919  100d 5f            	clrw	x
5920  100e 89            	pushw	x
5921  100f ae0066        	ldw	x,#_umax_cnt
5922  1012 cd00d1        	call	_gran
5924  1015 5b04          	addw	sp,#4
5925                     ; 1043 	if(umax_cnt>=10)flags|=0b00001000;
5927  1017 9c            	rvf
5928  1018 be66          	ldw	x,_umax_cnt
5929  101a a3000a        	cpw	x,#10
5930  101d 2f04          	jrslt	L5262
5933  101f 72160005      	bset	_flags,#3
5934  1023               L5262:
5935                     ; 1046 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5937  1023 9c            	rvf
5938  1024 ce000e        	ldw	x,_Ui
5939  1027 a300c8        	cpw	x,#200
5940  102a 2e10          	jrsge	L7262
5942  102c c65005        	ld	a,20485
5943  102f a504          	bcp	a,#4
5944  1031 2609          	jrne	L7262
5947  1033 be64          	ldw	x,_umin_cnt
5948  1035 1c0001        	addw	x,#1
5949  1038 bf64          	ldw	_umin_cnt,x
5951  103a 2003          	jra	L1362
5952  103c               L7262:
5953                     ; 1047 	else umin_cnt=0;
5955  103c 5f            	clrw	x
5956  103d bf64          	ldw	_umin_cnt,x
5957  103f               L1362:
5958                     ; 1048 	gran(&umin_cnt,0,10);	
5960  103f ae000a        	ldw	x,#10
5961  1042 89            	pushw	x
5962  1043 5f            	clrw	x
5963  1044 89            	pushw	x
5964  1045 ae0064        	ldw	x,#_umin_cnt
5965  1048 cd00d1        	call	_gran
5967  104b 5b04          	addw	sp,#4
5968                     ; 1049 	if(umin_cnt>=10)flags|=0b00010000;	  
5970  104d 9c            	rvf
5971  104e be64          	ldw	x,_umin_cnt
5972  1050 a3000a        	cpw	x,#10
5973  1053 2f04          	jrslt	L5162
5976  1055 72180005      	bset	_flags,#4
5977  1059               L5162:
5978                     ; 1051 }
5981  1059 81            	ret
6008                     ; 1054 void x_drv(void)
6008                     ; 1055 {
6009                     	switch	.text
6010  105a               _x_drv:
6014                     ; 1056 if(_x__==_x_)
6016  105a be5c          	ldw	x,__x__
6017  105c b35e          	cpw	x,__x_
6018  105e 262a          	jrne	L5462
6019                     ; 1058 	if(_x_cnt<60)
6021  1060 9c            	rvf
6022  1061 be5a          	ldw	x,__x_cnt
6023  1063 a3003c        	cpw	x,#60
6024  1066 2e25          	jrsge	L5562
6025                     ; 1060 		_x_cnt++;
6027  1068 be5a          	ldw	x,__x_cnt
6028  106a 1c0001        	addw	x,#1
6029  106d bf5a          	ldw	__x_cnt,x
6030                     ; 1061 		if(_x_cnt>=60)
6032  106f 9c            	rvf
6033  1070 be5a          	ldw	x,__x_cnt
6034  1072 a3003c        	cpw	x,#60
6035  1075 2f16          	jrslt	L5562
6036                     ; 1063 			if(_x_ee_!=_x_)_x_ee_=_x_;
6038  1077 ce0018        	ldw	x,__x_ee_
6039  107a b35e          	cpw	x,__x_
6040  107c 270f          	jreq	L5562
6043  107e be5e          	ldw	x,__x_
6044  1080 89            	pushw	x
6045  1081 ae0018        	ldw	x,#__x_ee_
6046  1084 cd0000        	call	c_eewrw
6048  1087 85            	popw	x
6049  1088 2003          	jra	L5562
6050  108a               L5462:
6051                     ; 1068 else _x_cnt=0;
6053  108a 5f            	clrw	x
6054  108b bf5a          	ldw	__x_cnt,x
6055  108d               L5562:
6056                     ; 1070 if(_x_cnt>60) _x_cnt=0;	
6058  108d 9c            	rvf
6059  108e be5a          	ldw	x,__x_cnt
6060  1090 a3003d        	cpw	x,#61
6061  1093 2f03          	jrslt	L7562
6064  1095 5f            	clrw	x
6065  1096 bf5a          	ldw	__x_cnt,x
6066  1098               L7562:
6067                     ; 1072 _x__=_x_;
6069  1098 be5e          	ldw	x,__x_
6070  109a bf5c          	ldw	__x__,x
6071                     ; 1073 }
6074  109c 81            	ret
6100                     ; 1076 void apv_start(void)
6100                     ; 1077 {
6101                     	switch	.text
6102  109d               _apv_start:
6106                     ; 1078 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6108  109d 3d45          	tnz	_apv_cnt
6109  109f 2624          	jrne	L1762
6111  10a1 3d46          	tnz	_apv_cnt+1
6112  10a3 2620          	jrne	L1762
6114  10a5 3d47          	tnz	_apv_cnt+2
6115  10a7 261c          	jrne	L1762
6117                     	btst	_bAPV
6118  10ae 2515          	jrult	L1762
6119                     ; 1080 	apv_cnt[0]=60;
6121  10b0 353c0045      	mov	_apv_cnt,#60
6122                     ; 1081 	apv_cnt[1]=60;
6124  10b4 353c0046      	mov	_apv_cnt+1,#60
6125                     ; 1082 	apv_cnt[2]=60;
6127  10b8 353c0047      	mov	_apv_cnt+2,#60
6128                     ; 1083 	apv_cnt_=3600;
6130  10bc ae0e10        	ldw	x,#3600
6131  10bf bf43          	ldw	_apv_cnt_,x
6132                     ; 1084 	bAPV=1;	
6134  10c1 72100002      	bset	_bAPV
6135  10c5               L1762:
6136                     ; 1086 }
6139  10c5 81            	ret
6165                     ; 1089 void apv_stop(void)
6165                     ; 1090 {
6166                     	switch	.text
6167  10c6               _apv_stop:
6171                     ; 1091 apv_cnt[0]=0;
6173  10c6 3f45          	clr	_apv_cnt
6174                     ; 1092 apv_cnt[1]=0;
6176  10c8 3f46          	clr	_apv_cnt+1
6177                     ; 1093 apv_cnt[2]=0;
6179  10ca 3f47          	clr	_apv_cnt+2
6180                     ; 1094 apv_cnt_=0;	
6182  10cc 5f            	clrw	x
6183  10cd bf43          	ldw	_apv_cnt_,x
6184                     ; 1095 bAPV=0;
6186  10cf 72110002      	bres	_bAPV
6187                     ; 1096 }
6190  10d3 81            	ret
6225                     ; 1100 void apv_hndl(void)
6225                     ; 1101 {
6226                     	switch	.text
6227  10d4               _apv_hndl:
6231                     ; 1102 if(apv_cnt[0])
6233  10d4 3d45          	tnz	_apv_cnt
6234  10d6 271e          	jreq	L3172
6235                     ; 1104 	apv_cnt[0]--;
6237  10d8 3a45          	dec	_apv_cnt
6238                     ; 1105 	if(apv_cnt[0]==0)
6240  10da 3d45          	tnz	_apv_cnt
6241  10dc 265a          	jrne	L7172
6242                     ; 1107 		flags&=0b11100001;
6244  10de b605          	ld	a,_flags
6245  10e0 a4e1          	and	a,#225
6246  10e2 b705          	ld	_flags,a
6247                     ; 1108 		tsign_cnt=0;
6249  10e4 5f            	clrw	x
6250  10e5 bf4f          	ldw	_tsign_cnt,x
6251                     ; 1109 		tmax_cnt=0;
6253  10e7 5f            	clrw	x
6254  10e8 bf4d          	ldw	_tmax_cnt,x
6255                     ; 1110 		umax_cnt=0;
6257  10ea 5f            	clrw	x
6258  10eb bf66          	ldw	_umax_cnt,x
6259                     ; 1111 		umin_cnt=0;
6261  10ed 5f            	clrw	x
6262  10ee bf64          	ldw	_umin_cnt,x
6263                     ; 1113 		led_drv_cnt=30;
6265  10f0 351e0016      	mov	_led_drv_cnt,#30
6266  10f4 2042          	jra	L7172
6267  10f6               L3172:
6268                     ; 1116 else if(apv_cnt[1])
6270  10f6 3d46          	tnz	_apv_cnt+1
6271  10f8 271e          	jreq	L1272
6272                     ; 1118 	apv_cnt[1]--;
6274  10fa 3a46          	dec	_apv_cnt+1
6275                     ; 1119 	if(apv_cnt[1]==0)
6277  10fc 3d46          	tnz	_apv_cnt+1
6278  10fe 2638          	jrne	L7172
6279                     ; 1121 		flags&=0b11100001;
6281  1100 b605          	ld	a,_flags
6282  1102 a4e1          	and	a,#225
6283  1104 b705          	ld	_flags,a
6284                     ; 1122 		tsign_cnt=0;
6286  1106 5f            	clrw	x
6287  1107 bf4f          	ldw	_tsign_cnt,x
6288                     ; 1123 		tmax_cnt=0;
6290  1109 5f            	clrw	x
6291  110a bf4d          	ldw	_tmax_cnt,x
6292                     ; 1124 		umax_cnt=0;
6294  110c 5f            	clrw	x
6295  110d bf66          	ldw	_umax_cnt,x
6296                     ; 1125 		umin_cnt=0;
6298  110f 5f            	clrw	x
6299  1110 bf64          	ldw	_umin_cnt,x
6300                     ; 1127 		led_drv_cnt=30;
6302  1112 351e0016      	mov	_led_drv_cnt,#30
6303  1116 2020          	jra	L7172
6304  1118               L1272:
6305                     ; 1130 else if(apv_cnt[2])
6307  1118 3d47          	tnz	_apv_cnt+2
6308  111a 271c          	jreq	L7172
6309                     ; 1132 	apv_cnt[2]--;
6311  111c 3a47          	dec	_apv_cnt+2
6312                     ; 1133 	if(apv_cnt[2]==0)
6314  111e 3d47          	tnz	_apv_cnt+2
6315  1120 2616          	jrne	L7172
6316                     ; 1135 		flags&=0b11100001;
6318  1122 b605          	ld	a,_flags
6319  1124 a4e1          	and	a,#225
6320  1126 b705          	ld	_flags,a
6321                     ; 1136 		tsign_cnt=0;
6323  1128 5f            	clrw	x
6324  1129 bf4f          	ldw	_tsign_cnt,x
6325                     ; 1137 		tmax_cnt=0;
6327  112b 5f            	clrw	x
6328  112c bf4d          	ldw	_tmax_cnt,x
6329                     ; 1138 		umax_cnt=0;
6331  112e 5f            	clrw	x
6332  112f bf66          	ldw	_umax_cnt,x
6333                     ; 1139 		umin_cnt=0;          
6335  1131 5f            	clrw	x
6336  1132 bf64          	ldw	_umin_cnt,x
6337                     ; 1141 		led_drv_cnt=30;
6339  1134 351e0016      	mov	_led_drv_cnt,#30
6340  1138               L7172:
6341                     ; 1145 if(apv_cnt_)
6343  1138 be43          	ldw	x,_apv_cnt_
6344  113a 2712          	jreq	L3372
6345                     ; 1147 	apv_cnt_--;
6347  113c be43          	ldw	x,_apv_cnt_
6348  113e 1d0001        	subw	x,#1
6349  1141 bf43          	ldw	_apv_cnt_,x
6350                     ; 1148 	if(apv_cnt_==0) 
6352  1143 be43          	ldw	x,_apv_cnt_
6353  1145 2607          	jrne	L3372
6354                     ; 1150 		bAPV=0;
6356  1147 72110002      	bres	_bAPV
6357                     ; 1151 		apv_start();
6359  114b cd109d        	call	_apv_start
6361  114e               L3372:
6362                     ; 1155 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6364  114e be64          	ldw	x,_umin_cnt
6365  1150 261e          	jrne	L7372
6367  1152 be66          	ldw	x,_umax_cnt
6368  1154 261a          	jrne	L7372
6370  1156 c65005        	ld	a,20485
6371  1159 a504          	bcp	a,#4
6372  115b 2613          	jrne	L7372
6373                     ; 1157 	if(cnt_apv_off<20)
6375  115d b642          	ld	a,_cnt_apv_off
6376  115f a114          	cp	a,#20
6377  1161 240f          	jruge	L5472
6378                     ; 1159 		cnt_apv_off++;
6380  1163 3c42          	inc	_cnt_apv_off
6381                     ; 1160 		if(cnt_apv_off>=20)
6383  1165 b642          	ld	a,_cnt_apv_off
6384  1167 a114          	cp	a,#20
6385  1169 2507          	jrult	L5472
6386                     ; 1162 			apv_stop();
6388  116b cd10c6        	call	_apv_stop
6390  116e 2002          	jra	L5472
6391  1170               L7372:
6392                     ; 1166 else cnt_apv_off=0;	
6394  1170 3f42          	clr	_cnt_apv_off
6395  1172               L5472:
6396                     ; 1168 }
6399  1172 81            	ret
6402                     	switch	.ubsct
6403  0000               L7472_flags_old:
6404  0000 00            	ds.b	1
6440                     ; 1171 void flags_drv(void)
6440                     ; 1172 {
6441                     	switch	.text
6442  1173               _flags_drv:
6446                     ; 1174 if(jp_mode!=jp3) 
6448  1173 b64a          	ld	a,_jp_mode
6449  1175 a103          	cp	a,#3
6450  1177 2723          	jreq	L7672
6451                     ; 1176 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6453  1179 b605          	ld	a,_flags
6454  117b a508          	bcp	a,#8
6455  117d 2706          	jreq	L5772
6457  117f b600          	ld	a,L7472_flags_old
6458  1181 a508          	bcp	a,#8
6459  1183 270c          	jreq	L3772
6460  1185               L5772:
6462  1185 b605          	ld	a,_flags
6463  1187 a510          	bcp	a,#16
6464  1189 2726          	jreq	L1003
6466  118b b600          	ld	a,L7472_flags_old
6467  118d a510          	bcp	a,#16
6468  118f 2620          	jrne	L1003
6469  1191               L3772:
6470                     ; 1178     		if(link==OFF)apv_start();
6472  1191 b663          	ld	a,_link
6473  1193 a1aa          	cp	a,#170
6474  1195 261a          	jrne	L1003
6477  1197 cd109d        	call	_apv_start
6479  119a 2015          	jra	L1003
6480  119c               L7672:
6481                     ; 1181 else if(jp_mode==jp3) 
6483  119c b64a          	ld	a,_jp_mode
6484  119e a103          	cp	a,#3
6485  11a0 260f          	jrne	L1003
6486                     ; 1183 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6488  11a2 b605          	ld	a,_flags
6489  11a4 a508          	bcp	a,#8
6490  11a6 2709          	jreq	L1003
6492  11a8 b600          	ld	a,L7472_flags_old
6493  11aa a508          	bcp	a,#8
6494  11ac 2603          	jrne	L1003
6495                     ; 1185     		apv_start();
6497  11ae cd109d        	call	_apv_start
6499  11b1               L1003:
6500                     ; 1188 flags_old=flags;
6502  11b1 450500        	mov	L7472_flags_old,_flags
6503                     ; 1190 } 
6506  11b4 81            	ret
6541                     ; 1327 void adr_drv_v4(char in)
6541                     ; 1328 {
6542                     	switch	.text
6543  11b5               _adr_drv_v4:
6547                     ; 1329 if(adress!=in)adress=in;
6549  11b5 c100f9        	cp	a,_adress
6550  11b8 2703          	jreq	L5203
6553  11ba c700f9        	ld	_adress,a
6554  11bd               L5203:
6555                     ; 1330 }
6558  11bd 81            	ret
6587                     ; 1333 void adr_drv_v3(void)
6587                     ; 1334 {
6588                     	switch	.text
6589  11be               _adr_drv_v3:
6591  11be 88            	push	a
6592       00000001      OFST:	set	1
6595                     ; 1340 GPIOB->DDR&=~(1<<0);
6597  11bf 72115007      	bres	20487,#0
6598                     ; 1341 GPIOB->CR1&=~(1<<0);
6600  11c3 72115008      	bres	20488,#0
6601                     ; 1342 GPIOB->CR2&=~(1<<0);
6603  11c7 72115009      	bres	20489,#0
6604                     ; 1343 ADC2->CR2=0x08;
6606  11cb 35085402      	mov	21506,#8
6607                     ; 1344 ADC2->CR1=0x40;
6609  11cf 35405401      	mov	21505,#64
6610                     ; 1345 ADC2->CSR=0x20+0;
6612  11d3 35205400      	mov	21504,#32
6613                     ; 1346 ADC2->CR1|=1;
6615  11d7 72105401      	bset	21505,#0
6616                     ; 1347 ADC2->CR1|=1;
6618  11db 72105401      	bset	21505,#0
6619                     ; 1348 adr_drv_stat=1;
6621  11df 35010002      	mov	_adr_drv_stat,#1
6622  11e3               L7303:
6623                     ; 1349 while(adr_drv_stat==1);
6626  11e3 b602          	ld	a,_adr_drv_stat
6627  11e5 a101          	cp	a,#1
6628  11e7 27fa          	jreq	L7303
6629                     ; 1351 GPIOB->DDR&=~(1<<1);
6631  11e9 72135007      	bres	20487,#1
6632                     ; 1352 GPIOB->CR1&=~(1<<1);
6634  11ed 72135008      	bres	20488,#1
6635                     ; 1353 GPIOB->CR2&=~(1<<1);
6637  11f1 72135009      	bres	20489,#1
6638                     ; 1354 ADC2->CR2=0x08;
6640  11f5 35085402      	mov	21506,#8
6641                     ; 1355 ADC2->CR1=0x40;
6643  11f9 35405401      	mov	21505,#64
6644                     ; 1356 ADC2->CSR=0x20+1;
6646  11fd 35215400      	mov	21504,#33
6647                     ; 1357 ADC2->CR1|=1;
6649  1201 72105401      	bset	21505,#0
6650                     ; 1358 ADC2->CR1|=1;
6652  1205 72105401      	bset	21505,#0
6653                     ; 1359 adr_drv_stat=3;
6655  1209 35030002      	mov	_adr_drv_stat,#3
6656  120d               L5403:
6657                     ; 1360 while(adr_drv_stat==3);
6660  120d b602          	ld	a,_adr_drv_stat
6661  120f a103          	cp	a,#3
6662  1211 27fa          	jreq	L5403
6663                     ; 1362 GPIOE->DDR&=~(1<<6);
6665  1213 721d5016      	bres	20502,#6
6666                     ; 1363 GPIOE->CR1&=~(1<<6);
6668  1217 721d5017      	bres	20503,#6
6669                     ; 1364 GPIOE->CR2&=~(1<<6);
6671  121b 721d5018      	bres	20504,#6
6672                     ; 1365 ADC2->CR2=0x08;
6674  121f 35085402      	mov	21506,#8
6675                     ; 1366 ADC2->CR1=0x40;
6677  1223 35405401      	mov	21505,#64
6678                     ; 1367 ADC2->CSR=0x20+9;
6680  1227 35295400      	mov	21504,#41
6681                     ; 1368 ADC2->CR1|=1;
6683  122b 72105401      	bset	21505,#0
6684                     ; 1369 ADC2->CR1|=1;
6686  122f 72105401      	bset	21505,#0
6687                     ; 1370 adr_drv_stat=5;
6689  1233 35050002      	mov	_adr_drv_stat,#5
6690  1237               L3503:
6691                     ; 1371 while(adr_drv_stat==5);
6694  1237 b602          	ld	a,_adr_drv_stat
6695  1239 a105          	cp	a,#5
6696  123b 27fa          	jreq	L3503
6697                     ; 1375 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6699  123d 9c            	rvf
6700  123e ce0101        	ldw	x,_adc_buff_
6701  1241 a3022a        	cpw	x,#554
6702  1244 2f0f          	jrslt	L1603
6704  1246 9c            	rvf
6705  1247 ce0101        	ldw	x,_adc_buff_
6706  124a a30253        	cpw	x,#595
6707  124d 2e06          	jrsge	L1603
6710  124f 725f00fa      	clr	_adr
6712  1253 204c          	jra	L3603
6713  1255               L1603:
6714                     ; 1376 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6716  1255 9c            	rvf
6717  1256 ce0101        	ldw	x,_adc_buff_
6718  1259 a3036d        	cpw	x,#877
6719  125c 2f0f          	jrslt	L5603
6721  125e 9c            	rvf
6722  125f ce0101        	ldw	x,_adc_buff_
6723  1262 a30396        	cpw	x,#918
6724  1265 2e06          	jrsge	L5603
6727  1267 350100fa      	mov	_adr,#1
6729  126b 2034          	jra	L3603
6730  126d               L5603:
6731                     ; 1377 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6733  126d 9c            	rvf
6734  126e ce0101        	ldw	x,_adc_buff_
6735  1271 a302a3        	cpw	x,#675
6736  1274 2f0f          	jrslt	L1703
6738  1276 9c            	rvf
6739  1277 ce0101        	ldw	x,_adc_buff_
6740  127a a302cc        	cpw	x,#716
6741  127d 2e06          	jrsge	L1703
6744  127f 350200fa      	mov	_adr,#2
6746  1283 201c          	jra	L3603
6747  1285               L1703:
6748                     ; 1378 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6750  1285 9c            	rvf
6751  1286 ce0101        	ldw	x,_adc_buff_
6752  1289 a303e3        	cpw	x,#995
6753  128c 2f0f          	jrslt	L5703
6755  128e 9c            	rvf
6756  128f ce0101        	ldw	x,_adc_buff_
6757  1292 a3040c        	cpw	x,#1036
6758  1295 2e06          	jrsge	L5703
6761  1297 350300fa      	mov	_adr,#3
6763  129b 2004          	jra	L3603
6764  129d               L5703:
6765                     ; 1379 else adr[0]=5;
6767  129d 350500fa      	mov	_adr,#5
6768  12a1               L3603:
6769                     ; 1381 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6771  12a1 9c            	rvf
6772  12a2 ce0103        	ldw	x,_adc_buff_+2
6773  12a5 a3022a        	cpw	x,#554
6774  12a8 2f0f          	jrslt	L1013
6776  12aa 9c            	rvf
6777  12ab ce0103        	ldw	x,_adc_buff_+2
6778  12ae a30253        	cpw	x,#595
6779  12b1 2e06          	jrsge	L1013
6782  12b3 725f00fb      	clr	_adr+1
6784  12b7 204c          	jra	L3013
6785  12b9               L1013:
6786                     ; 1382 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6788  12b9 9c            	rvf
6789  12ba ce0103        	ldw	x,_adc_buff_+2
6790  12bd a3036d        	cpw	x,#877
6791  12c0 2f0f          	jrslt	L5013
6793  12c2 9c            	rvf
6794  12c3 ce0103        	ldw	x,_adc_buff_+2
6795  12c6 a30396        	cpw	x,#918
6796  12c9 2e06          	jrsge	L5013
6799  12cb 350100fb      	mov	_adr+1,#1
6801  12cf 2034          	jra	L3013
6802  12d1               L5013:
6803                     ; 1383 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6805  12d1 9c            	rvf
6806  12d2 ce0103        	ldw	x,_adc_buff_+2
6807  12d5 a302a3        	cpw	x,#675
6808  12d8 2f0f          	jrslt	L1113
6810  12da 9c            	rvf
6811  12db ce0103        	ldw	x,_adc_buff_+2
6812  12de a302cc        	cpw	x,#716
6813  12e1 2e06          	jrsge	L1113
6816  12e3 350200fb      	mov	_adr+1,#2
6818  12e7 201c          	jra	L3013
6819  12e9               L1113:
6820                     ; 1384 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6822  12e9 9c            	rvf
6823  12ea ce0103        	ldw	x,_adc_buff_+2
6824  12ed a303e3        	cpw	x,#995
6825  12f0 2f0f          	jrslt	L5113
6827  12f2 9c            	rvf
6828  12f3 ce0103        	ldw	x,_adc_buff_+2
6829  12f6 a3040c        	cpw	x,#1036
6830  12f9 2e06          	jrsge	L5113
6833  12fb 350300fb      	mov	_adr+1,#3
6835  12ff 2004          	jra	L3013
6836  1301               L5113:
6837                     ; 1385 else adr[1]=5;
6839  1301 350500fb      	mov	_adr+1,#5
6840  1305               L3013:
6841                     ; 1387 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6843  1305 9c            	rvf
6844  1306 ce0113        	ldw	x,_adc_buff_+18
6845  1309 a3022a        	cpw	x,#554
6846  130c 2f0f          	jrslt	L1213
6848  130e 9c            	rvf
6849  130f ce0113        	ldw	x,_adc_buff_+18
6850  1312 a30253        	cpw	x,#595
6851  1315 2e06          	jrsge	L1213
6854  1317 725f00fc      	clr	_adr+2
6856  131b 204c          	jra	L3213
6857  131d               L1213:
6858                     ; 1388 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6860  131d 9c            	rvf
6861  131e ce0113        	ldw	x,_adc_buff_+18
6862  1321 a3036d        	cpw	x,#877
6863  1324 2f0f          	jrslt	L5213
6865  1326 9c            	rvf
6866  1327 ce0113        	ldw	x,_adc_buff_+18
6867  132a a30396        	cpw	x,#918
6868  132d 2e06          	jrsge	L5213
6871  132f 350100fc      	mov	_adr+2,#1
6873  1333 2034          	jra	L3213
6874  1335               L5213:
6875                     ; 1389 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6877  1335 9c            	rvf
6878  1336 ce0113        	ldw	x,_adc_buff_+18
6879  1339 a302a3        	cpw	x,#675
6880  133c 2f0f          	jrslt	L1313
6882  133e 9c            	rvf
6883  133f ce0113        	ldw	x,_adc_buff_+18
6884  1342 a302cc        	cpw	x,#716
6885  1345 2e06          	jrsge	L1313
6888  1347 350200fc      	mov	_adr+2,#2
6890  134b 201c          	jra	L3213
6891  134d               L1313:
6892                     ; 1390 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6894  134d 9c            	rvf
6895  134e ce0113        	ldw	x,_adc_buff_+18
6896  1351 a303e3        	cpw	x,#995
6897  1354 2f0f          	jrslt	L5313
6899  1356 9c            	rvf
6900  1357 ce0113        	ldw	x,_adc_buff_+18
6901  135a a3040c        	cpw	x,#1036
6902  135d 2e06          	jrsge	L5313
6905  135f 350300fc      	mov	_adr+2,#3
6907  1363 2004          	jra	L3213
6908  1365               L5313:
6909                     ; 1391 else adr[2]=5;
6911  1365 350500fc      	mov	_adr+2,#5
6912  1369               L3213:
6913                     ; 1395 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6915  1369 c600fa        	ld	a,_adr
6916  136c a105          	cp	a,#5
6917  136e 270e          	jreq	L3413
6919  1370 c600fb        	ld	a,_adr+1
6920  1373 a105          	cp	a,#5
6921  1375 2707          	jreq	L3413
6923  1377 c600fc        	ld	a,_adr+2
6924  137a a105          	cp	a,#5
6925  137c 2606          	jrne	L1413
6926  137e               L3413:
6927                     ; 1398 	adress_error=1;
6929  137e 350100f8      	mov	_adress_error,#1
6931  1382               L7413:
6932                     ; 1409 }
6935  1382 84            	pop	a
6936  1383 81            	ret
6937  1384               L1413:
6938                     ; 1402 	if(adr[2]&0x02) bps_class=bpsIPS;
6940  1384 c600fc        	ld	a,_adr+2
6941  1387 a502          	bcp	a,#2
6942  1389 2706          	jreq	L1513
6945  138b 35010004      	mov	_bps_class,#1
6947  138f 2002          	jra	L3513
6948  1391               L1513:
6949                     ; 1403 	else bps_class=bpsIBEP;
6951  1391 3f04          	clr	_bps_class
6952  1393               L3513:
6953                     ; 1405 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6955  1393 c600fc        	ld	a,_adr+2
6956  1396 a401          	and	a,#1
6957  1398 97            	ld	xl,a
6958  1399 a610          	ld	a,#16
6959  139b 42            	mul	x,a
6960  139c 9f            	ld	a,xl
6961  139d 6b01          	ld	(OFST+0,sp),a
6962  139f c600fb        	ld	a,_adr+1
6963  13a2 48            	sll	a
6964  13a3 48            	sll	a
6965  13a4 cb00fa        	add	a,_adr
6966  13a7 1b01          	add	a,(OFST+0,sp)
6967  13a9 c700f9        	ld	_adress,a
6968  13ac 20d4          	jra	L7413
7012                     ; 1412 void volum_u_main_drv(void)
7012                     ; 1413 {
7013                     	switch	.text
7014  13ae               _volum_u_main_drv:
7016  13ae 88            	push	a
7017       00000001      OFST:	set	1
7020                     ; 1416 if(bMAIN)
7022                     	btst	_bMAIN
7023  13b4 2503          	jrult	L431
7024  13b6 cc1503        	jp	L3713
7025  13b9               L431:
7026                     ; 1418 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7028  13b9 9c            	rvf
7029  13ba ce0008        	ldw	x,_UU_AVT
7030  13bd 1d000a        	subw	x,#10
7031  13c0 c30010        	cpw	x,_Un
7032  13c3 2d09          	jrsle	L5713
7035  13c5 be19          	ldw	x,_volum_u_main_
7036  13c7 1c0005        	addw	x,#5
7037  13ca bf19          	ldw	_volum_u_main_,x
7039  13cc 2039          	jra	L7713
7040  13ce               L5713:
7041                     ; 1419 	else if(Un<(UU_AVT-1))volum_u_main_++;
7043  13ce 9c            	rvf
7044  13cf ce0008        	ldw	x,_UU_AVT
7045  13d2 5a            	decw	x
7046  13d3 c30010        	cpw	x,_Un
7047  13d6 2d09          	jrsle	L1023
7050  13d8 be19          	ldw	x,_volum_u_main_
7051  13da 1c0001        	addw	x,#1
7052  13dd bf19          	ldw	_volum_u_main_,x
7054  13df 2026          	jra	L7713
7055  13e1               L1023:
7056                     ; 1420 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7058  13e1 9c            	rvf
7059  13e2 ce0008        	ldw	x,_UU_AVT
7060  13e5 1c000a        	addw	x,#10
7061  13e8 c30010        	cpw	x,_Un
7062  13eb 2e09          	jrsge	L5023
7065  13ed be19          	ldw	x,_volum_u_main_
7066  13ef 1d000a        	subw	x,#10
7067  13f2 bf19          	ldw	_volum_u_main_,x
7069  13f4 2011          	jra	L7713
7070  13f6               L5023:
7071                     ; 1421 	else if(Un>(UU_AVT+1))volum_u_main_--;
7073  13f6 9c            	rvf
7074  13f7 ce0008        	ldw	x,_UU_AVT
7075  13fa 5c            	incw	x
7076  13fb c30010        	cpw	x,_Un
7077  13fe 2e07          	jrsge	L7713
7080  1400 be19          	ldw	x,_volum_u_main_
7081  1402 1d0001        	subw	x,#1
7082  1405 bf19          	ldw	_volum_u_main_,x
7083  1407               L7713:
7084                     ; 1422 	if(volum_u_main_>1020)volum_u_main_=1020;
7086  1407 9c            	rvf
7087  1408 be19          	ldw	x,_volum_u_main_
7088  140a a303fd        	cpw	x,#1021
7089  140d 2f05          	jrslt	L3123
7092  140f ae03fc        	ldw	x,#1020
7093  1412 bf19          	ldw	_volum_u_main_,x
7094  1414               L3123:
7095                     ; 1423 	if(volum_u_main_<0)volum_u_main_=0;
7097  1414 9c            	rvf
7098  1415 be19          	ldw	x,_volum_u_main_
7099  1417 2e03          	jrsge	L5123
7102  1419 5f            	clrw	x
7103  141a bf19          	ldw	_volum_u_main_,x
7104  141c               L5123:
7105                     ; 1426 	i_main_sigma=0;
7107  141c 5f            	clrw	x
7108  141d bf0f          	ldw	_i_main_sigma,x
7109                     ; 1427 	i_main_num_of_bps=0;
7111  141f 3f11          	clr	_i_main_num_of_bps
7112                     ; 1428 	for(i=0;i<6;i++)
7114  1421 0f01          	clr	(OFST+0,sp)
7115  1423               L7123:
7116                     ; 1430 		if(i_main_flag[i])
7118  1423 7b01          	ld	a,(OFST+0,sp)
7119  1425 5f            	clrw	x
7120  1426 97            	ld	xl,a
7121  1427 6d14          	tnz	(_i_main_flag,x)
7122  1429 2719          	jreq	L5223
7123                     ; 1432 			i_main_sigma+=i_main[i];
7125  142b 7b01          	ld	a,(OFST+0,sp)
7126  142d 5f            	clrw	x
7127  142e 97            	ld	xl,a
7128  142f 58            	sllw	x
7129  1430 ee1a          	ldw	x,(_i_main,x)
7130  1432 72bb000f      	addw	x,_i_main_sigma
7131  1436 bf0f          	ldw	_i_main_sigma,x
7132                     ; 1433 			i_main_flag[i]=1;
7134  1438 7b01          	ld	a,(OFST+0,sp)
7135  143a 5f            	clrw	x
7136  143b 97            	ld	xl,a
7137  143c a601          	ld	a,#1
7138  143e e714          	ld	(_i_main_flag,x),a
7139                     ; 1434 			i_main_num_of_bps++;
7141  1440 3c11          	inc	_i_main_num_of_bps
7143  1442 2006          	jra	L7223
7144  1444               L5223:
7145                     ; 1438 			i_main_flag[i]=0;	
7147  1444 7b01          	ld	a,(OFST+0,sp)
7148  1446 5f            	clrw	x
7149  1447 97            	ld	xl,a
7150  1448 6f14          	clr	(_i_main_flag,x)
7151  144a               L7223:
7152                     ; 1428 	for(i=0;i<6;i++)
7154  144a 0c01          	inc	(OFST+0,sp)
7157  144c 7b01          	ld	a,(OFST+0,sp)
7158  144e a106          	cp	a,#6
7159  1450 25d1          	jrult	L7123
7160                     ; 1441 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7162  1452 be0f          	ldw	x,_i_main_sigma
7163  1454 b611          	ld	a,_i_main_num_of_bps
7164  1456 905f          	clrw	y
7165  1458 9097          	ld	yl,a
7166  145a cd0000        	call	c_idiv
7168  145d bf12          	ldw	_i_main_avg,x
7169                     ; 1442 	for(i=0;i<6;i++)
7171  145f 0f01          	clr	(OFST+0,sp)
7172  1461               L1323:
7173                     ; 1444 		if(i_main_flag[i])
7175  1461 7b01          	ld	a,(OFST+0,sp)
7176  1463 5f            	clrw	x
7177  1464 97            	ld	xl,a
7178  1465 6d14          	tnz	(_i_main_flag,x)
7179  1467 2603cc14f8    	jreq	L7323
7180                     ; 1446 			if(i_main[i]<(i_main_avg-10))x[i]++;
7182  146c 9c            	rvf
7183  146d 7b01          	ld	a,(OFST+0,sp)
7184  146f 5f            	clrw	x
7185  1470 97            	ld	xl,a
7186  1471 58            	sllw	x
7187  1472 90be12        	ldw	y,_i_main_avg
7188  1475 72a2000a      	subw	y,#10
7189  1479 90bf00        	ldw	c_y,y
7190  147c 9093          	ldw	y,x
7191  147e 90ee1a        	ldw	y,(_i_main,y)
7192  1481 90b300        	cpw	y,c_y
7193  1484 2e11          	jrsge	L1423
7196  1486 7b01          	ld	a,(OFST+0,sp)
7197  1488 5f            	clrw	x
7198  1489 97            	ld	xl,a
7199  148a 58            	sllw	x
7200  148b 9093          	ldw	y,x
7201  148d ee26          	ldw	x,(_x,x)
7202  148f 1c0001        	addw	x,#1
7203  1492 90ef26        	ldw	(_x,y),x
7205  1495 2029          	jra	L3423
7206  1497               L1423:
7207                     ; 1447 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7209  1497 9c            	rvf
7210  1498 7b01          	ld	a,(OFST+0,sp)
7211  149a 5f            	clrw	x
7212  149b 97            	ld	xl,a
7213  149c 58            	sllw	x
7214  149d 90be12        	ldw	y,_i_main_avg
7215  14a0 72a9000a      	addw	y,#10
7216  14a4 90bf00        	ldw	c_y,y
7217  14a7 9093          	ldw	y,x
7218  14a9 90ee1a        	ldw	y,(_i_main,y)
7219  14ac 90b300        	cpw	y,c_y
7220  14af 2d0f          	jrsle	L3423
7223  14b1 7b01          	ld	a,(OFST+0,sp)
7224  14b3 5f            	clrw	x
7225  14b4 97            	ld	xl,a
7226  14b5 58            	sllw	x
7227  14b6 9093          	ldw	y,x
7228  14b8 ee26          	ldw	x,(_x,x)
7229  14ba 1d0001        	subw	x,#1
7230  14bd 90ef26        	ldw	(_x,y),x
7231  14c0               L3423:
7232                     ; 1448 			if(x[i]>100)x[i]=100;
7234  14c0 9c            	rvf
7235  14c1 7b01          	ld	a,(OFST+0,sp)
7236  14c3 5f            	clrw	x
7237  14c4 97            	ld	xl,a
7238  14c5 58            	sllw	x
7239  14c6 9093          	ldw	y,x
7240  14c8 90ee26        	ldw	y,(_x,y)
7241  14cb 90a30065      	cpw	y,#101
7242  14cf 2f0b          	jrslt	L7423
7245  14d1 7b01          	ld	a,(OFST+0,sp)
7246  14d3 5f            	clrw	x
7247  14d4 97            	ld	xl,a
7248  14d5 58            	sllw	x
7249  14d6 90ae0064      	ldw	y,#100
7250  14da ef26          	ldw	(_x,x),y
7251  14dc               L7423:
7252                     ; 1449 			if(x[i]<-100)x[i]=-100;
7254  14dc 9c            	rvf
7255  14dd 7b01          	ld	a,(OFST+0,sp)
7256  14df 5f            	clrw	x
7257  14e0 97            	ld	xl,a
7258  14e1 58            	sllw	x
7259  14e2 9093          	ldw	y,x
7260  14e4 90ee26        	ldw	y,(_x,y)
7261  14e7 90a3ff9c      	cpw	y,#65436
7262  14eb 2e0b          	jrsge	L7323
7265  14ed 7b01          	ld	a,(OFST+0,sp)
7266  14ef 5f            	clrw	x
7267  14f0 97            	ld	xl,a
7268  14f1 58            	sllw	x
7269  14f2 90aeff9c      	ldw	y,#65436
7270  14f6 ef26          	ldw	(_x,x),y
7271  14f8               L7323:
7272                     ; 1442 	for(i=0;i<6;i++)
7274  14f8 0c01          	inc	(OFST+0,sp)
7277  14fa 7b01          	ld	a,(OFST+0,sp)
7278  14fc a106          	cp	a,#6
7279  14fe 2403cc1461    	jrult	L1323
7280  1503               L3713:
7281                     ; 1456 }
7284  1503 84            	pop	a
7285  1504 81            	ret
7308                     ; 1459 void init_CAN(void) {
7309                     	switch	.text
7310  1505               _init_CAN:
7314                     ; 1460 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7316  1505 72135420      	bres	21536,#1
7317                     ; 1461 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7319  1509 72105420      	bset	21536,#0
7321  150d               L5623:
7322                     ; 1462 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7324  150d c65421        	ld	a,21537
7325  1510 a501          	bcp	a,#1
7326  1512 27f9          	jreq	L5623
7327                     ; 1464 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7329  1514 72185420      	bset	21536,#4
7330                     ; 1466 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7332  1518 35025427      	mov	21543,#2
7333                     ; 1475 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7335  151c 35135428      	mov	21544,#19
7336                     ; 1476 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7338  1520 35c05429      	mov	21545,#192
7339                     ; 1477 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7341  1524 357f542c      	mov	21548,#127
7342                     ; 1478 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7344  1528 35e0542d      	mov	21549,#224
7345                     ; 1480 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7347  152c 35315430      	mov	21552,#49
7348                     ; 1481 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7350  1530 35c05431      	mov	21553,#192
7351                     ; 1482 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7353  1534 357f5434      	mov	21556,#127
7354                     ; 1483 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7356  1538 35e05435      	mov	21557,#224
7357                     ; 1487 	CAN->PSR= 6;									// set page 6
7359  153c 35065427      	mov	21543,#6
7360                     ; 1492 	CAN->Page.Config.FMR1&=~3;								//mask mode
7362  1540 c65430        	ld	a,21552
7363  1543 a4fc          	and	a,#252
7364  1545 c75430        	ld	21552,a
7365                     ; 1498 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7367  1548 35065432      	mov	21554,#6
7368                     ; 1499 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7370  154c 35605432      	mov	21554,#96
7371                     ; 1502 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7373  1550 72105432      	bset	21554,#0
7374                     ; 1503 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7376  1554 72185432      	bset	21554,#4
7377                     ; 1506 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7379  1558 35065427      	mov	21543,#6
7380                     ; 1508 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7382  155c 3509542c      	mov	21548,#9
7383                     ; 1509 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7385  1560 35e7542d      	mov	21549,#231
7386                     ; 1511 	CAN->IER|=(1<<1);
7388  1564 72125425      	bset	21541,#1
7389                     ; 1514 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7391  1568 72115420      	bres	21536,#0
7393  156c               L3723:
7394                     ; 1515 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7396  156c c65421        	ld	a,21537
7397  156f a501          	bcp	a,#1
7398  1571 26f9          	jrne	L3723
7399                     ; 1516 }
7402  1573 81            	ret
7510                     ; 1519 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7510                     ; 1520 {
7511                     	switch	.text
7512  1574               _can_transmit:
7514  1574 89            	pushw	x
7515       00000000      OFST:	set	0
7518                     ; 1522 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7520  1575 b66c          	ld	a,_can_buff_wr_ptr
7521  1577 a104          	cp	a,#4
7522  1579 2502          	jrult	L5533
7525  157b 3f6c          	clr	_can_buff_wr_ptr
7526  157d               L5533:
7527                     ; 1524 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7529  157d b66c          	ld	a,_can_buff_wr_ptr
7530  157f 97            	ld	xl,a
7531  1580 a610          	ld	a,#16
7532  1582 42            	mul	x,a
7533  1583 1601          	ldw	y,(OFST+1,sp)
7534  1585 a606          	ld	a,#6
7535  1587               L241:
7536  1587 9054          	srlw	y
7537  1589 4a            	dec	a
7538  158a 26fb          	jrne	L241
7539  158c 909f          	ld	a,yl
7540  158e e76d          	ld	(_can_out_buff,x),a
7541                     ; 1525 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7543  1590 b66c          	ld	a,_can_buff_wr_ptr
7544  1592 97            	ld	xl,a
7545  1593 a610          	ld	a,#16
7546  1595 42            	mul	x,a
7547  1596 7b02          	ld	a,(OFST+2,sp)
7548  1598 48            	sll	a
7549  1599 48            	sll	a
7550  159a e76e          	ld	(_can_out_buff+1,x),a
7551                     ; 1527 can_out_buff[can_buff_wr_ptr][2]=data0;
7553  159c b66c          	ld	a,_can_buff_wr_ptr
7554  159e 97            	ld	xl,a
7555  159f a610          	ld	a,#16
7556  15a1 42            	mul	x,a
7557  15a2 7b05          	ld	a,(OFST+5,sp)
7558  15a4 e76f          	ld	(_can_out_buff+2,x),a
7559                     ; 1528 can_out_buff[can_buff_wr_ptr][3]=data1;
7561  15a6 b66c          	ld	a,_can_buff_wr_ptr
7562  15a8 97            	ld	xl,a
7563  15a9 a610          	ld	a,#16
7564  15ab 42            	mul	x,a
7565  15ac 7b06          	ld	a,(OFST+6,sp)
7566  15ae e770          	ld	(_can_out_buff+3,x),a
7567                     ; 1529 can_out_buff[can_buff_wr_ptr][4]=data2;
7569  15b0 b66c          	ld	a,_can_buff_wr_ptr
7570  15b2 97            	ld	xl,a
7571  15b3 a610          	ld	a,#16
7572  15b5 42            	mul	x,a
7573  15b6 7b07          	ld	a,(OFST+7,sp)
7574  15b8 e771          	ld	(_can_out_buff+4,x),a
7575                     ; 1530 can_out_buff[can_buff_wr_ptr][5]=data3;
7577  15ba b66c          	ld	a,_can_buff_wr_ptr
7578  15bc 97            	ld	xl,a
7579  15bd a610          	ld	a,#16
7580  15bf 42            	mul	x,a
7581  15c0 7b08          	ld	a,(OFST+8,sp)
7582  15c2 e772          	ld	(_can_out_buff+5,x),a
7583                     ; 1531 can_out_buff[can_buff_wr_ptr][6]=data4;
7585  15c4 b66c          	ld	a,_can_buff_wr_ptr
7586  15c6 97            	ld	xl,a
7587  15c7 a610          	ld	a,#16
7588  15c9 42            	mul	x,a
7589  15ca 7b09          	ld	a,(OFST+9,sp)
7590  15cc e773          	ld	(_can_out_buff+6,x),a
7591                     ; 1532 can_out_buff[can_buff_wr_ptr][7]=data5;
7593  15ce b66c          	ld	a,_can_buff_wr_ptr
7594  15d0 97            	ld	xl,a
7595  15d1 a610          	ld	a,#16
7596  15d3 42            	mul	x,a
7597  15d4 7b0a          	ld	a,(OFST+10,sp)
7598  15d6 e774          	ld	(_can_out_buff+7,x),a
7599                     ; 1533 can_out_buff[can_buff_wr_ptr][8]=data6;
7601  15d8 b66c          	ld	a,_can_buff_wr_ptr
7602  15da 97            	ld	xl,a
7603  15db a610          	ld	a,#16
7604  15dd 42            	mul	x,a
7605  15de 7b0b          	ld	a,(OFST+11,sp)
7606  15e0 e775          	ld	(_can_out_buff+8,x),a
7607                     ; 1534 can_out_buff[can_buff_wr_ptr][9]=data7;
7609  15e2 b66c          	ld	a,_can_buff_wr_ptr
7610  15e4 97            	ld	xl,a
7611  15e5 a610          	ld	a,#16
7612  15e7 42            	mul	x,a
7613  15e8 7b0c          	ld	a,(OFST+12,sp)
7614  15ea e776          	ld	(_can_out_buff+9,x),a
7615                     ; 1536 can_buff_wr_ptr++;
7617  15ec 3c6c          	inc	_can_buff_wr_ptr
7618                     ; 1537 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7620  15ee b66c          	ld	a,_can_buff_wr_ptr
7621  15f0 a104          	cp	a,#4
7622  15f2 2502          	jrult	L7533
7625  15f4 3f6c          	clr	_can_buff_wr_ptr
7626  15f6               L7533:
7627                     ; 1538 } 
7630  15f6 85            	popw	x
7631  15f7 81            	ret
7660                     ; 1541 void can_tx_hndl(void)
7660                     ; 1542 {
7661                     	switch	.text
7662  15f8               _can_tx_hndl:
7666                     ; 1543 if(bTX_FREE)
7668  15f8 3d03          	tnz	_bTX_FREE
7669  15fa 2757          	jreq	L1733
7670                     ; 1545 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7672  15fc b66b          	ld	a,_can_buff_rd_ptr
7673  15fe b16c          	cp	a,_can_buff_wr_ptr
7674  1600 275f          	jreq	L7733
7675                     ; 1547 		bTX_FREE=0;
7677  1602 3f03          	clr	_bTX_FREE
7678                     ; 1549 		CAN->PSR= 0;
7680  1604 725f5427      	clr	21543
7681                     ; 1550 		CAN->Page.TxMailbox.MDLCR=8;
7683  1608 35085429      	mov	21545,#8
7684                     ; 1551 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7686  160c b66b          	ld	a,_can_buff_rd_ptr
7687  160e 97            	ld	xl,a
7688  160f a610          	ld	a,#16
7689  1611 42            	mul	x,a
7690  1612 e66d          	ld	a,(_can_out_buff,x)
7691  1614 c7542a        	ld	21546,a
7692                     ; 1552 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7694  1617 b66b          	ld	a,_can_buff_rd_ptr
7695  1619 97            	ld	xl,a
7696  161a a610          	ld	a,#16
7697  161c 42            	mul	x,a
7698  161d e66e          	ld	a,(_can_out_buff+1,x)
7699  161f c7542b        	ld	21547,a
7700                     ; 1554 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7702  1622 b66b          	ld	a,_can_buff_rd_ptr
7703  1624 97            	ld	xl,a
7704  1625 a610          	ld	a,#16
7705  1627 42            	mul	x,a
7706  1628 01            	rrwa	x,a
7707  1629 ab6f          	add	a,#_can_out_buff+2
7708  162b 2401          	jrnc	L641
7709  162d 5c            	incw	x
7710  162e               L641:
7711  162e 5f            	clrw	x
7712  162f 97            	ld	xl,a
7713  1630 bf00          	ldw	c_x,x
7714  1632 ae0008        	ldw	x,#8
7715  1635               L051:
7716  1635 5a            	decw	x
7717  1636 92d600        	ld	a,([c_x],x)
7718  1639 d7542e        	ld	(21550,x),a
7719  163c 5d            	tnzw	x
7720  163d 26f6          	jrne	L051
7721                     ; 1556 		can_buff_rd_ptr++;
7723  163f 3c6b          	inc	_can_buff_rd_ptr
7724                     ; 1557 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7726  1641 b66b          	ld	a,_can_buff_rd_ptr
7727  1643 a104          	cp	a,#4
7728  1645 2502          	jrult	L5733
7731  1647 3f6b          	clr	_can_buff_rd_ptr
7732  1649               L5733:
7733                     ; 1559 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7735  1649 72105428      	bset	21544,#0
7736                     ; 1560 		CAN->IER|=(1<<0);
7738  164d 72105425      	bset	21541,#0
7739  1651 200e          	jra	L7733
7740  1653               L1733:
7741                     ; 1565 	tx_busy_cnt++;
7743  1653 3c6a          	inc	_tx_busy_cnt
7744                     ; 1566 	if(tx_busy_cnt>=100)
7746  1655 b66a          	ld	a,_tx_busy_cnt
7747  1657 a164          	cp	a,#100
7748  1659 2506          	jrult	L7733
7749                     ; 1568 		tx_busy_cnt=0;
7751  165b 3f6a          	clr	_tx_busy_cnt
7752                     ; 1569 		bTX_FREE=1;
7754  165d 35010003      	mov	_bTX_FREE,#1
7755  1661               L7733:
7756                     ; 1572 }
7759  1661 81            	ret
7798                     ; 1575 void net_drv(void)
7798                     ; 1576 { 
7799                     	switch	.text
7800  1662               _net_drv:
7804                     ; 1578 if(bMAIN)
7806                     	btst	_bMAIN
7807  1667 2503          	jrult	L451
7808  1669 cc170f        	jp	L3143
7809  166c               L451:
7810                     ; 1580 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7812  166c 3c32          	inc	_cnt_net_drv
7813  166e b632          	ld	a,_cnt_net_drv
7814  1670 a107          	cp	a,#7
7815  1672 2502          	jrult	L5143
7818  1674 3f32          	clr	_cnt_net_drv
7819  1676               L5143:
7820                     ; 1582 	if(cnt_net_drv<=5) 
7822  1676 b632          	ld	a,_cnt_net_drv
7823  1678 a106          	cp	a,#6
7824  167a 244c          	jruge	L7143
7825                     ; 1584 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7827  167c 4be8          	push	#232
7828  167e 4be8          	push	#232
7829  1680 b632          	ld	a,_cnt_net_drv
7830  1682 5f            	clrw	x
7831  1683 97            	ld	xl,a
7832  1684 58            	sllw	x
7833  1685 ee26          	ldw	x,(_x,x)
7834  1687 72bb0019      	addw	x,_volum_u_main_
7835  168b 90ae0100      	ldw	y,#256
7836  168f cd0000        	call	c_idiv
7838  1692 9f            	ld	a,xl
7839  1693 88            	push	a
7840  1694 b632          	ld	a,_cnt_net_drv
7841  1696 5f            	clrw	x
7842  1697 97            	ld	xl,a
7843  1698 58            	sllw	x
7844  1699 e627          	ld	a,(_x+1,x)
7845  169b bb1a          	add	a,_volum_u_main_+1
7846  169d 88            	push	a
7847  169e 4b00          	push	#0
7848  16a0 4bed          	push	#237
7849  16a2 3b0032        	push	_cnt_net_drv
7850  16a5 3b0032        	push	_cnt_net_drv
7851  16a8 ae009e        	ldw	x,#158
7852  16ab cd1574        	call	_can_transmit
7854  16ae 5b08          	addw	sp,#8
7855                     ; 1585 		i_main_bps_cnt[cnt_net_drv]++;
7857  16b0 b632          	ld	a,_cnt_net_drv
7858  16b2 5f            	clrw	x
7859  16b3 97            	ld	xl,a
7860  16b4 6c09          	inc	(_i_main_bps_cnt,x)
7861                     ; 1586 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7863  16b6 b632          	ld	a,_cnt_net_drv
7864  16b8 5f            	clrw	x
7865  16b9 97            	ld	xl,a
7866  16ba e609          	ld	a,(_i_main_bps_cnt,x)
7867  16bc a10b          	cp	a,#11
7868  16be 254f          	jrult	L3143
7871  16c0 b632          	ld	a,_cnt_net_drv
7872  16c2 5f            	clrw	x
7873  16c3 97            	ld	xl,a
7874  16c4 6f14          	clr	(_i_main_flag,x)
7875  16c6 2047          	jra	L3143
7876  16c8               L7143:
7877                     ; 1588 	else if(cnt_net_drv==6)
7879  16c8 b632          	ld	a,_cnt_net_drv
7880  16ca a106          	cp	a,#6
7881  16cc 2641          	jrne	L3143
7882                     ; 1590 		plazma_int[2]=pwm_u;
7884  16ce be08          	ldw	x,_pwm_u
7885  16d0 bf37          	ldw	_plazma_int+4,x
7886                     ; 1591 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7888  16d2 3b000e        	push	_Ui
7889  16d5 3b000f        	push	_Ui+1
7890  16d8 3b0010        	push	_Un
7891  16db 3b0011        	push	_Un+1
7892  16de 3b0012        	push	_I
7893  16e1 3b0013        	push	_I+1
7894  16e4 4bda          	push	#218
7895  16e6 3b00f9        	push	_adress
7896  16e9 ae018e        	ldw	x,#398
7897  16ec cd1574        	call	_can_transmit
7899  16ef 5b08          	addw	sp,#8
7900                     ; 1592 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7902  16f1 3b0037        	push	_plazma_int+4
7903  16f4 3b0038        	push	_plazma_int+5
7904  16f7 3b005f        	push	__x_+1
7905  16fa 3b0005        	push	_flags
7906  16fd 4b00          	push	#0
7907  16ff 3b0068        	push	_T
7908  1702 4bdb          	push	#219
7909  1704 3b00f9        	push	_adress
7910  1707 ae018e        	ldw	x,#398
7911  170a cd1574        	call	_can_transmit
7913  170d 5b08          	addw	sp,#8
7914  170f               L3143:
7915                     ; 1595 }
7918  170f 81            	ret
8034                     ; 1598 void can_in_an(void)
8034                     ; 1599 {
8035                     	switch	.text
8036  1710               _can_in_an:
8038  1710 5207          	subw	sp,#7
8039       00000007      OFST:	set	7
8042                     ; 1609 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8044  1712 b6c3          	ld	a,_mess+6
8045  1714 c100f9        	cp	a,_adress
8046  1717 2703          	jreq	L471
8047  1719 cc1857        	jp	L3643
8048  171c               L471:
8050  171c b6c4          	ld	a,_mess+7
8051  171e c100f9        	cp	a,_adress
8052  1721 2703          	jreq	L671
8053  1723 cc1857        	jp	L3643
8054  1726               L671:
8056  1726 b6c5          	ld	a,_mess+8
8057  1728 a1ed          	cp	a,#237
8058  172a 2703          	jreq	L002
8059  172c cc1857        	jp	L3643
8060  172f               L002:
8061                     ; 1612 	can_error_cnt=0;
8063  172f 3f69          	clr	_can_error_cnt
8064                     ; 1614 	bMAIN=0;
8066  1731 72110001      	bres	_bMAIN
8067                     ; 1615  	flags_tu=mess[9];
8069  1735 45c660        	mov	_flags_tu,_mess+9
8070                     ; 1616  	if(flags_tu&0b00000001)
8072  1738 b660          	ld	a,_flags_tu
8073  173a a501          	bcp	a,#1
8074  173c 2706          	jreq	L5643
8075                     ; 1621  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8077  173e 721a0005      	bset	_flags,#5
8079  1742 200e          	jra	L7643
8080  1744               L5643:
8081                     ; 1632  				flags&=0b11011111; 
8083  1744 721b0005      	bres	_flags,#5
8084                     ; 1633  				off_bp_cnt=5*ee_TZAS;
8086  1748 c60017        	ld	a,_ee_TZAS+1
8087  174b 97            	ld	xl,a
8088  174c a605          	ld	a,#5
8089  174e 42            	mul	x,a
8090  174f 9f            	ld	a,xl
8091  1750 b753          	ld	_off_bp_cnt,a
8092  1752               L7643:
8093                     ; 1639  	if(flags_tu&0b00000010) flags|=0b01000000;
8095  1752 b660          	ld	a,_flags_tu
8096  1754 a502          	bcp	a,#2
8097  1756 2706          	jreq	L1743
8100  1758 721c0005      	bset	_flags,#6
8102  175c 2004          	jra	L3743
8103  175e               L1743:
8104                     ; 1640  	else flags&=0b10111111; 
8106  175e 721d0005      	bres	_flags,#6
8107  1762               L3743:
8108                     ; 1642  	U_out_const=mess[10]+mess[11]*256;
8110  1762 b6c8          	ld	a,_mess+11
8111  1764 5f            	clrw	x
8112  1765 97            	ld	xl,a
8113  1766 4f            	clr	a
8114  1767 02            	rlwa	x,a
8115  1768 01            	rrwa	x,a
8116  1769 bbc7          	add	a,_mess+10
8117  176b 2401          	jrnc	L061
8118  176d 5c            	incw	x
8119  176e               L061:
8120  176e c70009        	ld	_U_out_const+1,a
8121  1771 9f            	ld	a,xl
8122  1772 c70008        	ld	_U_out_const,a
8123                     ; 1643  	vol_i_temp=mess[12]+mess[13]*256;  
8125  1775 b6ca          	ld	a,_mess+13
8126  1777 5f            	clrw	x
8127  1778 97            	ld	xl,a
8128  1779 4f            	clr	a
8129  177a 02            	rlwa	x,a
8130  177b 01            	rrwa	x,a
8131  177c bbc9          	add	a,_mess+12
8132  177e 2401          	jrnc	L261
8133  1780 5c            	incw	x
8134  1781               L261:
8135  1781 b757          	ld	_vol_i_temp+1,a
8136  1783 9f            	ld	a,xl
8137  1784 b756          	ld	_vol_i_temp,a
8138                     ; 1653 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8140  1786 b601          	ld	a,_vent_resurs_tx_cnt
8141  1788 a102          	cp	a,#2
8142  178a 2507          	jrult	L5743
8145  178c ce0000        	ldw	x,_vent_resurs
8146  178f bf37          	ldw	_plazma_int+4,x
8148  1791 2004          	jra	L7743
8149  1793               L5743:
8150                     ; 1654 	else plazma_int[2]=vent_resurs_sec_cnt;
8152  1793 be02          	ldw	x,_vent_resurs_sec_cnt
8153  1795 bf37          	ldw	_plazma_int+4,x
8154  1797               L7743:
8155                     ; 1655  	rotor_int=flags_tu+(((short)flags)<<8);
8157  1797 b605          	ld	a,_flags
8158  1799 5f            	clrw	x
8159  179a 97            	ld	xl,a
8160  179b 4f            	clr	a
8161  179c 02            	rlwa	x,a
8162  179d 01            	rrwa	x,a
8163  179e bb60          	add	a,_flags_tu
8164  17a0 2401          	jrnc	L461
8165  17a2 5c            	incw	x
8166  17a3               L461:
8167  17a3 b718          	ld	_rotor_int+1,a
8168  17a5 9f            	ld	a,xl
8169  17a6 b717          	ld	_rotor_int,a
8170                     ; 1656 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8172  17a8 3b000e        	push	_Ui
8173  17ab 3b000f        	push	_Ui+1
8174  17ae 3b0010        	push	_Un
8175  17b1 3b0011        	push	_Un+1
8176  17b4 3b0012        	push	_I
8177  17b7 3b0013        	push	_I+1
8178  17ba 4bda          	push	#218
8179  17bc 3b00f9        	push	_adress
8180  17bf ae018e        	ldw	x,#398
8181  17c2 cd1574        	call	_can_transmit
8183  17c5 5b08          	addw	sp,#8
8184                     ; 1657 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
8186  17c7 3b0006        	push	_Usum
8187  17ca 3b0007        	push	_Usum+1
8188  17cd 3b005f        	push	__x_+1
8189  17d0 3b0005        	push	_flags
8190  17d3 b601          	ld	a,_vent_resurs_tx_cnt
8191  17d5 5f            	clrw	x
8192  17d6 97            	ld	xl,a
8193  17d7 d60000        	ld	a,(_vent_resurs_buff,x)
8194  17da 88            	push	a
8195  17db 3b0068        	push	_T
8196  17de 4bdb          	push	#219
8197  17e0 3b00f9        	push	_adress
8198  17e3 ae018e        	ldw	x,#398
8199  17e6 cd1574        	call	_can_transmit
8201  17e9 5b08          	addw	sp,#8
8202                     ; 1658 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&pwm_u)+1),*((char*)&pwm_u),*(((char*)&pwm_u_buff_)+1),*((char*)&pwm_u_buff_),flags,_x_);
8204  17eb 3b005f        	push	__x_+1
8205  17ee 3b0005        	push	_flags
8206  17f1 3b0016        	push	_pwm_u_buff_
8207  17f4 3b0017        	push	_pwm_u_buff_+1
8208  17f7 3b0008        	push	_pwm_u
8209  17fa 3b0009        	push	_pwm_u+1
8210  17fd 4bdc          	push	#220
8211  17ff 3b00f9        	push	_adress
8212  1802 ae018e        	ldw	x,#398
8213  1805 cd1574        	call	_can_transmit
8215  1808 5b08          	addw	sp,#8
8216                     ; 1659      link_cnt=0;
8218  180a 5f            	clrw	x
8219  180b bf61          	ldw	_link_cnt,x
8220                     ; 1660      link=ON;
8222  180d 35550063      	mov	_link,#85
8223                     ; 1662      if(flags_tu&0b10000000)
8225  1811 b660          	ld	a,_flags_tu
8226  1813 a580          	bcp	a,#128
8227  1815 2716          	jreq	L1053
8228                     ; 1664      	if(!res_fl)
8230  1817 725d000b      	tnz	_res_fl
8231  181b 2626          	jrne	L5053
8232                     ; 1666      		res_fl=1;
8234  181d a601          	ld	a,#1
8235  181f ae000b        	ldw	x,#_res_fl
8236  1822 cd0000        	call	c_eewrc
8238                     ; 1667      		bRES=1;
8240  1825 3501000c      	mov	_bRES,#1
8241                     ; 1668      		res_fl_cnt=0;
8243  1829 3f41          	clr	_res_fl_cnt
8244  182b 2016          	jra	L5053
8245  182d               L1053:
8246                     ; 1673      	if(main_cnt>20)
8248  182d 9c            	rvf
8249  182e ce0255        	ldw	x,_main_cnt
8250  1831 a30015        	cpw	x,#21
8251  1834 2f0d          	jrslt	L5053
8252                     ; 1675     			if(res_fl)
8254  1836 725d000b      	tnz	_res_fl
8255  183a 2707          	jreq	L5053
8256                     ; 1677      			res_fl=0;
8258  183c 4f            	clr	a
8259  183d ae000b        	ldw	x,#_res_fl
8260  1840 cd0000        	call	c_eewrc
8262  1843               L5053:
8263                     ; 1682       if(res_fl_)
8265  1843 725d000a      	tnz	_res_fl_
8266  1847 2603          	jrne	L202
8267  1849 cc1de6        	jp	L7243
8268  184c               L202:
8269                     ; 1684       	res_fl_=0;
8271  184c 4f            	clr	a
8272  184d ae000a        	ldw	x,#_res_fl_
8273  1850 cd0000        	call	c_eewrc
8275  1853 ace61de6      	jpf	L7243
8276  1857               L3643:
8277                     ; 1687 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8279  1857 b6c3          	ld	a,_mess+6
8280  1859 c100f9        	cp	a,_adress
8281  185c 2703          	jreq	L402
8282  185e cc1ad4        	jp	L7153
8283  1861               L402:
8285  1861 b6c4          	ld	a,_mess+7
8286  1863 c100f9        	cp	a,_adress
8287  1866 2703          	jreq	L602
8288  1868 cc1ad4        	jp	L7153
8289  186b               L602:
8291  186b b6c5          	ld	a,_mess+8
8292  186d a1ee          	cp	a,#238
8293  186f 2703          	jreq	L012
8294  1871 cc1ad4        	jp	L7153
8295  1874               L012:
8297  1874 b6c6          	ld	a,_mess+9
8298  1876 b1c7          	cp	a,_mess+10
8299  1878 2703          	jreq	L212
8300  187a cc1ad4        	jp	L7153
8301  187d               L212:
8302                     ; 1689 	rotor_int++;
8304  187d be17          	ldw	x,_rotor_int
8305  187f 1c0001        	addw	x,#1
8306  1882 bf17          	ldw	_rotor_int,x
8307                     ; 1690 	if((mess[9]&0xf0)==0x20)
8309  1884 b6c6          	ld	a,_mess+9
8310  1886 a4f0          	and	a,#240
8311  1888 a120          	cp	a,#32
8312  188a 2673          	jrne	L1253
8313                     ; 1692 		if((mess[9]&0x0f)==0x01)
8315  188c b6c6          	ld	a,_mess+9
8316  188e a40f          	and	a,#15
8317  1890 a101          	cp	a,#1
8318  1892 260d          	jrne	L3253
8319                     ; 1694 			ee_K[0][0]=adc_buff_[4];
8321  1894 ce0109        	ldw	x,_adc_buff_+8
8322  1897 89            	pushw	x
8323  1898 ae001a        	ldw	x,#_ee_K
8324  189b cd0000        	call	c_eewrw
8326  189e 85            	popw	x
8328  189f 204a          	jra	L5253
8329  18a1               L3253:
8330                     ; 1696 		else if((mess[9]&0x0f)==0x02)
8332  18a1 b6c6          	ld	a,_mess+9
8333  18a3 a40f          	and	a,#15
8334  18a5 a102          	cp	a,#2
8335  18a7 260b          	jrne	L7253
8336                     ; 1698 			ee_K[0][1]++;
8338  18a9 ce001c        	ldw	x,_ee_K+2
8339  18ac 1c0001        	addw	x,#1
8340  18af cf001c        	ldw	_ee_K+2,x
8342  18b2 2037          	jra	L5253
8343  18b4               L7253:
8344                     ; 1700 		else if((mess[9]&0x0f)==0x03)
8346  18b4 b6c6          	ld	a,_mess+9
8347  18b6 a40f          	and	a,#15
8348  18b8 a103          	cp	a,#3
8349  18ba 260b          	jrne	L3353
8350                     ; 1702 			ee_K[0][1]+=10;
8352  18bc ce001c        	ldw	x,_ee_K+2
8353  18bf 1c000a        	addw	x,#10
8354  18c2 cf001c        	ldw	_ee_K+2,x
8356  18c5 2024          	jra	L5253
8357  18c7               L3353:
8358                     ; 1704 		else if((mess[9]&0x0f)==0x04)
8360  18c7 b6c6          	ld	a,_mess+9
8361  18c9 a40f          	and	a,#15
8362  18cb a104          	cp	a,#4
8363  18cd 260b          	jrne	L7353
8364                     ; 1706 			ee_K[0][1]--;
8366  18cf ce001c        	ldw	x,_ee_K+2
8367  18d2 1d0001        	subw	x,#1
8368  18d5 cf001c        	ldw	_ee_K+2,x
8370  18d8 2011          	jra	L5253
8371  18da               L7353:
8372                     ; 1708 		else if((mess[9]&0x0f)==0x05)
8374  18da b6c6          	ld	a,_mess+9
8375  18dc a40f          	and	a,#15
8376  18de a105          	cp	a,#5
8377  18e0 2609          	jrne	L5253
8378                     ; 1710 			ee_K[0][1]-=10;
8380  18e2 ce001c        	ldw	x,_ee_K+2
8381  18e5 1d000a        	subw	x,#10
8382  18e8 cf001c        	ldw	_ee_K+2,x
8383  18eb               L5253:
8384                     ; 1712 		granee(&ee_K[0][1],50,3000);									
8386  18eb ae0bb8        	ldw	x,#3000
8387  18ee 89            	pushw	x
8388  18ef ae0032        	ldw	x,#50
8389  18f2 89            	pushw	x
8390  18f3 ae001c        	ldw	x,#_ee_K+2
8391  18f6 cd00f2        	call	_granee
8393  18f9 5b04          	addw	sp,#4
8395  18fb acb91ab9      	jpf	L5453
8396  18ff               L1253:
8397                     ; 1714 	else if((mess[9]&0xf0)==0x10)
8399  18ff b6c6          	ld	a,_mess+9
8400  1901 a4f0          	and	a,#240
8401  1903 a110          	cp	a,#16
8402  1905 2673          	jrne	L7453
8403                     ; 1716 		if((mess[9]&0x0f)==0x01)
8405  1907 b6c6          	ld	a,_mess+9
8406  1909 a40f          	and	a,#15
8407  190b a101          	cp	a,#1
8408  190d 260d          	jrne	L1553
8409                     ; 1718 			ee_K[1][0]=adc_buff_[1];
8411  190f ce0103        	ldw	x,_adc_buff_+2
8412  1912 89            	pushw	x
8413  1913 ae001e        	ldw	x,#_ee_K+4
8414  1916 cd0000        	call	c_eewrw
8416  1919 85            	popw	x
8418  191a 204a          	jra	L3553
8419  191c               L1553:
8420                     ; 1720 		else if((mess[9]&0x0f)==0x02)
8422  191c b6c6          	ld	a,_mess+9
8423  191e a40f          	and	a,#15
8424  1920 a102          	cp	a,#2
8425  1922 260b          	jrne	L5553
8426                     ; 1722 			ee_K[1][1]++;
8428  1924 ce0020        	ldw	x,_ee_K+6
8429  1927 1c0001        	addw	x,#1
8430  192a cf0020        	ldw	_ee_K+6,x
8432  192d 2037          	jra	L3553
8433  192f               L5553:
8434                     ; 1724 		else if((mess[9]&0x0f)==0x03)
8436  192f b6c6          	ld	a,_mess+9
8437  1931 a40f          	and	a,#15
8438  1933 a103          	cp	a,#3
8439  1935 260b          	jrne	L1653
8440                     ; 1726 			ee_K[1][1]+=10;
8442  1937 ce0020        	ldw	x,_ee_K+6
8443  193a 1c000a        	addw	x,#10
8444  193d cf0020        	ldw	_ee_K+6,x
8446  1940 2024          	jra	L3553
8447  1942               L1653:
8448                     ; 1728 		else if((mess[9]&0x0f)==0x04)
8450  1942 b6c6          	ld	a,_mess+9
8451  1944 a40f          	and	a,#15
8452  1946 a104          	cp	a,#4
8453  1948 260b          	jrne	L5653
8454                     ; 1730 			ee_K[1][1]--;
8456  194a ce0020        	ldw	x,_ee_K+6
8457  194d 1d0001        	subw	x,#1
8458  1950 cf0020        	ldw	_ee_K+6,x
8460  1953 2011          	jra	L3553
8461  1955               L5653:
8462                     ; 1732 		else if((mess[9]&0x0f)==0x05)
8464  1955 b6c6          	ld	a,_mess+9
8465  1957 a40f          	and	a,#15
8466  1959 a105          	cp	a,#5
8467  195b 2609          	jrne	L3553
8468                     ; 1734 			ee_K[1][1]-=10;
8470  195d ce0020        	ldw	x,_ee_K+6
8471  1960 1d000a        	subw	x,#10
8472  1963 cf0020        	ldw	_ee_K+6,x
8473  1966               L3553:
8474                     ; 1739 		granee(&ee_K[1][1],10,30000);
8476  1966 ae7530        	ldw	x,#30000
8477  1969 89            	pushw	x
8478  196a ae000a        	ldw	x,#10
8479  196d 89            	pushw	x
8480  196e ae0020        	ldw	x,#_ee_K+6
8481  1971 cd00f2        	call	_granee
8483  1974 5b04          	addw	sp,#4
8485  1976 acb91ab9      	jpf	L5453
8486  197a               L7453:
8487                     ; 1743 	else if((mess[9]&0xf0)==0x00)
8489  197a b6c6          	ld	a,_mess+9
8490  197c a5f0          	bcp	a,#240
8491  197e 2673          	jrne	L5753
8492                     ; 1745 		if((mess[9]&0x0f)==0x01)
8494  1980 b6c6          	ld	a,_mess+9
8495  1982 a40f          	and	a,#15
8496  1984 a101          	cp	a,#1
8497  1986 260d          	jrne	L7753
8498                     ; 1747 			ee_K[2][0]=adc_buff_[2];
8500  1988 ce0105        	ldw	x,_adc_buff_+4
8501  198b 89            	pushw	x
8502  198c ae0022        	ldw	x,#_ee_K+8
8503  198f cd0000        	call	c_eewrw
8505  1992 85            	popw	x
8507  1993 204a          	jra	L1063
8508  1995               L7753:
8509                     ; 1749 		else if((mess[9]&0x0f)==0x02)
8511  1995 b6c6          	ld	a,_mess+9
8512  1997 a40f          	and	a,#15
8513  1999 a102          	cp	a,#2
8514  199b 260b          	jrne	L3063
8515                     ; 1751 			ee_K[2][1]++;
8517  199d ce0024        	ldw	x,_ee_K+10
8518  19a0 1c0001        	addw	x,#1
8519  19a3 cf0024        	ldw	_ee_K+10,x
8521  19a6 2037          	jra	L1063
8522  19a8               L3063:
8523                     ; 1753 		else if((mess[9]&0x0f)==0x03)
8525  19a8 b6c6          	ld	a,_mess+9
8526  19aa a40f          	and	a,#15
8527  19ac a103          	cp	a,#3
8528  19ae 260b          	jrne	L7063
8529                     ; 1755 			ee_K[2][1]+=10;
8531  19b0 ce0024        	ldw	x,_ee_K+10
8532  19b3 1c000a        	addw	x,#10
8533  19b6 cf0024        	ldw	_ee_K+10,x
8535  19b9 2024          	jra	L1063
8536  19bb               L7063:
8537                     ; 1757 		else if((mess[9]&0x0f)==0x04)
8539  19bb b6c6          	ld	a,_mess+9
8540  19bd a40f          	and	a,#15
8541  19bf a104          	cp	a,#4
8542  19c1 260b          	jrne	L3163
8543                     ; 1759 			ee_K[2][1]--;
8545  19c3 ce0024        	ldw	x,_ee_K+10
8546  19c6 1d0001        	subw	x,#1
8547  19c9 cf0024        	ldw	_ee_K+10,x
8549  19cc 2011          	jra	L1063
8550  19ce               L3163:
8551                     ; 1761 		else if((mess[9]&0x0f)==0x05)
8553  19ce b6c6          	ld	a,_mess+9
8554  19d0 a40f          	and	a,#15
8555  19d2 a105          	cp	a,#5
8556  19d4 2609          	jrne	L1063
8557                     ; 1763 			ee_K[2][1]-=10;
8559  19d6 ce0024        	ldw	x,_ee_K+10
8560  19d9 1d000a        	subw	x,#10
8561  19dc cf0024        	ldw	_ee_K+10,x
8562  19df               L1063:
8563                     ; 1768 		granee(&ee_K[2][1],10,30000);
8565  19df ae7530        	ldw	x,#30000
8566  19e2 89            	pushw	x
8567  19e3 ae000a        	ldw	x,#10
8568  19e6 89            	pushw	x
8569  19e7 ae0024        	ldw	x,#_ee_K+10
8570  19ea cd00f2        	call	_granee
8572  19ed 5b04          	addw	sp,#4
8574  19ef acb91ab9      	jpf	L5453
8575  19f3               L5753:
8576                     ; 1772 	else if((mess[9]&0xf0)==0x30)
8578  19f3 b6c6          	ld	a,_mess+9
8579  19f5 a4f0          	and	a,#240
8580  19f7 a130          	cp	a,#48
8581  19f9 265c          	jrne	L3263
8582                     ; 1774 		if((mess[9]&0x0f)==0x02)
8584  19fb b6c6          	ld	a,_mess+9
8585  19fd a40f          	and	a,#15
8586  19ff a102          	cp	a,#2
8587  1a01 260b          	jrne	L5263
8588                     ; 1776 			ee_K[3][1]++;
8590  1a03 ce0028        	ldw	x,_ee_K+14
8591  1a06 1c0001        	addw	x,#1
8592  1a09 cf0028        	ldw	_ee_K+14,x
8594  1a0c 2037          	jra	L7263
8595  1a0e               L5263:
8596                     ; 1778 		else if((mess[9]&0x0f)==0x03)
8598  1a0e b6c6          	ld	a,_mess+9
8599  1a10 a40f          	and	a,#15
8600  1a12 a103          	cp	a,#3
8601  1a14 260b          	jrne	L1363
8602                     ; 1780 			ee_K[3][1]+=10;
8604  1a16 ce0028        	ldw	x,_ee_K+14
8605  1a19 1c000a        	addw	x,#10
8606  1a1c cf0028        	ldw	_ee_K+14,x
8608  1a1f 2024          	jra	L7263
8609  1a21               L1363:
8610                     ; 1782 		else if((mess[9]&0x0f)==0x04)
8612  1a21 b6c6          	ld	a,_mess+9
8613  1a23 a40f          	and	a,#15
8614  1a25 a104          	cp	a,#4
8615  1a27 260b          	jrne	L5363
8616                     ; 1784 			ee_K[3][1]--;
8618  1a29 ce0028        	ldw	x,_ee_K+14
8619  1a2c 1d0001        	subw	x,#1
8620  1a2f cf0028        	ldw	_ee_K+14,x
8622  1a32 2011          	jra	L7263
8623  1a34               L5363:
8624                     ; 1786 		else if((mess[9]&0x0f)==0x05)
8626  1a34 b6c6          	ld	a,_mess+9
8627  1a36 a40f          	and	a,#15
8628  1a38 a105          	cp	a,#5
8629  1a3a 2609          	jrne	L7263
8630                     ; 1788 			ee_K[3][1]-=10;
8632  1a3c ce0028        	ldw	x,_ee_K+14
8633  1a3f 1d000a        	subw	x,#10
8634  1a42 cf0028        	ldw	_ee_K+14,x
8635  1a45               L7263:
8636                     ; 1790 		granee(&ee_K[3][1],300,517);									
8638  1a45 ae0205        	ldw	x,#517
8639  1a48 89            	pushw	x
8640  1a49 ae012c        	ldw	x,#300
8641  1a4c 89            	pushw	x
8642  1a4d ae0028        	ldw	x,#_ee_K+14
8643  1a50 cd00f2        	call	_granee
8645  1a53 5b04          	addw	sp,#4
8647  1a55 2062          	jra	L5453
8648  1a57               L3263:
8649                     ; 1793 	else if((mess[9]&0xf0)==0x50)
8651  1a57 b6c6          	ld	a,_mess+9
8652  1a59 a4f0          	and	a,#240
8653  1a5b a150          	cp	a,#80
8654  1a5d 265a          	jrne	L5453
8655                     ; 1795 		if((mess[9]&0x0f)==0x02)
8657  1a5f b6c6          	ld	a,_mess+9
8658  1a61 a40f          	and	a,#15
8659  1a63 a102          	cp	a,#2
8660  1a65 260b          	jrne	L7463
8661                     ; 1797 			ee_K[4][1]++;
8663  1a67 ce002c        	ldw	x,_ee_K+18
8664  1a6a 1c0001        	addw	x,#1
8665  1a6d cf002c        	ldw	_ee_K+18,x
8667  1a70 2037          	jra	L1563
8668  1a72               L7463:
8669                     ; 1799 		else if((mess[9]&0x0f)==0x03)
8671  1a72 b6c6          	ld	a,_mess+9
8672  1a74 a40f          	and	a,#15
8673  1a76 a103          	cp	a,#3
8674  1a78 260b          	jrne	L3563
8675                     ; 1801 			ee_K[4][1]+=10;
8677  1a7a ce002c        	ldw	x,_ee_K+18
8678  1a7d 1c000a        	addw	x,#10
8679  1a80 cf002c        	ldw	_ee_K+18,x
8681  1a83 2024          	jra	L1563
8682  1a85               L3563:
8683                     ; 1803 		else if((mess[9]&0x0f)==0x04)
8685  1a85 b6c6          	ld	a,_mess+9
8686  1a87 a40f          	and	a,#15
8687  1a89 a104          	cp	a,#4
8688  1a8b 260b          	jrne	L7563
8689                     ; 1805 			ee_K[4][1]--;
8691  1a8d ce002c        	ldw	x,_ee_K+18
8692  1a90 1d0001        	subw	x,#1
8693  1a93 cf002c        	ldw	_ee_K+18,x
8695  1a96 2011          	jra	L1563
8696  1a98               L7563:
8697                     ; 1807 		else if((mess[9]&0x0f)==0x05)
8699  1a98 b6c6          	ld	a,_mess+9
8700  1a9a a40f          	and	a,#15
8701  1a9c a105          	cp	a,#5
8702  1a9e 2609          	jrne	L1563
8703                     ; 1809 			ee_K[4][1]-=10;
8705  1aa0 ce002c        	ldw	x,_ee_K+18
8706  1aa3 1d000a        	subw	x,#10
8707  1aa6 cf002c        	ldw	_ee_K+18,x
8708  1aa9               L1563:
8709                     ; 1811 		granee(&ee_K[4][1],10,30000);									
8711  1aa9 ae7530        	ldw	x,#30000
8712  1aac 89            	pushw	x
8713  1aad ae000a        	ldw	x,#10
8714  1ab0 89            	pushw	x
8715  1ab1 ae002c        	ldw	x,#_ee_K+18
8716  1ab4 cd00f2        	call	_granee
8718  1ab7 5b04          	addw	sp,#4
8719  1ab9               L5453:
8720                     ; 1814 	link_cnt=0;
8722  1ab9 5f            	clrw	x
8723  1aba bf61          	ldw	_link_cnt,x
8724                     ; 1815      link=ON;
8726  1abc 35550063      	mov	_link,#85
8727                     ; 1816      if(res_fl_)
8729  1ac0 725d000a      	tnz	_res_fl_
8730  1ac4 2603          	jrne	L412
8731  1ac6 cc1de6        	jp	L7243
8732  1ac9               L412:
8733                     ; 1818       	res_fl_=0;
8735  1ac9 4f            	clr	a
8736  1aca ae000a        	ldw	x,#_res_fl_
8737  1acd cd0000        	call	c_eewrc
8739  1ad0 ace61de6      	jpf	L7243
8740  1ad4               L7153:
8741                     ; 1824 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8743  1ad4 b6c3          	ld	a,_mess+6
8744  1ad6 a1ff          	cp	a,#255
8745  1ad8 2703          	jreq	L612
8746  1ada cc1b68        	jp	L1763
8747  1add               L612:
8749  1add b6c4          	ld	a,_mess+7
8750  1adf a1ff          	cp	a,#255
8751  1ae1 2703          	jreq	L022
8752  1ae3 cc1b68        	jp	L1763
8753  1ae6               L022:
8755  1ae6 b6c5          	ld	a,_mess+8
8756  1ae8 a162          	cp	a,#98
8757  1aea 267c          	jrne	L1763
8758                     ; 1827 	tempSS=mess[9]+(mess[10]*256);
8760  1aec b6c7          	ld	a,_mess+10
8761  1aee 5f            	clrw	x
8762  1aef 97            	ld	xl,a
8763  1af0 4f            	clr	a
8764  1af1 02            	rlwa	x,a
8765  1af2 01            	rrwa	x,a
8766  1af3 bbc6          	add	a,_mess+9
8767  1af5 2401          	jrnc	L661
8768  1af7 5c            	incw	x
8769  1af8               L661:
8770  1af8 02            	rlwa	x,a
8771  1af9 1f03          	ldw	(OFST-4,sp),x
8772  1afb 01            	rrwa	x,a
8773                     ; 1828 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8775  1afc ce0014        	ldw	x,_ee_Umax
8776  1aff 1303          	cpw	x,(OFST-4,sp)
8777  1b01 270a          	jreq	L3763
8780  1b03 1e03          	ldw	x,(OFST-4,sp)
8781  1b05 89            	pushw	x
8782  1b06 ae0014        	ldw	x,#_ee_Umax
8783  1b09 cd0000        	call	c_eewrw
8785  1b0c 85            	popw	x
8786  1b0d               L3763:
8787                     ; 1829 	tempSS=mess[11]+(mess[12]*256);
8789  1b0d b6c9          	ld	a,_mess+12
8790  1b0f 5f            	clrw	x
8791  1b10 97            	ld	xl,a
8792  1b11 4f            	clr	a
8793  1b12 02            	rlwa	x,a
8794  1b13 01            	rrwa	x,a
8795  1b14 bbc8          	add	a,_mess+11
8796  1b16 2401          	jrnc	L071
8797  1b18 5c            	incw	x
8798  1b19               L071:
8799  1b19 02            	rlwa	x,a
8800  1b1a 1f03          	ldw	(OFST-4,sp),x
8801  1b1c 01            	rrwa	x,a
8802                     ; 1830 	if(ee_dU!=tempSS) ee_dU=tempSS;
8804  1b1d ce0012        	ldw	x,_ee_dU
8805  1b20 1303          	cpw	x,(OFST-4,sp)
8806  1b22 270a          	jreq	L5763
8809  1b24 1e03          	ldw	x,(OFST-4,sp)
8810  1b26 89            	pushw	x
8811  1b27 ae0012        	ldw	x,#_ee_dU
8812  1b2a cd0000        	call	c_eewrw
8814  1b2d 85            	popw	x
8815  1b2e               L5763:
8816                     ; 1831 	if((mess[13]&0x0f)==0x5)
8818  1b2e b6ca          	ld	a,_mess+13
8819  1b30 a40f          	and	a,#15
8820  1b32 a105          	cp	a,#5
8821  1b34 261a          	jrne	L7763
8822                     ; 1833 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8824  1b36 ce0006        	ldw	x,_ee_AVT_MODE
8825  1b39 a30055        	cpw	x,#85
8826  1b3c 2603          	jrne	L222
8827  1b3e cc1de6        	jp	L7243
8828  1b41               L222:
8831  1b41 ae0055        	ldw	x,#85
8832  1b44 89            	pushw	x
8833  1b45 ae0006        	ldw	x,#_ee_AVT_MODE
8834  1b48 cd0000        	call	c_eewrw
8836  1b4b 85            	popw	x
8837  1b4c ace61de6      	jpf	L7243
8838  1b50               L7763:
8839                     ; 1835 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8841  1b50 ce0006        	ldw	x,_ee_AVT_MODE
8842  1b53 a30055        	cpw	x,#85
8843  1b56 2703          	jreq	L422
8844  1b58 cc1de6        	jp	L7243
8845  1b5b               L422:
8848  1b5b 5f            	clrw	x
8849  1b5c 89            	pushw	x
8850  1b5d ae0006        	ldw	x,#_ee_AVT_MODE
8851  1b60 cd0000        	call	c_eewrw
8853  1b63 85            	popw	x
8854  1b64 ace61de6      	jpf	L7243
8855  1b68               L1763:
8856                     ; 1838 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8858  1b68 b6c3          	ld	a,_mess+6
8859  1b6a a1ff          	cp	a,#255
8860  1b6c 2703          	jreq	L622
8861  1b6e cc1c4c        	jp	L1173
8862  1b71               L622:
8864  1b71 b6c4          	ld	a,_mess+7
8865  1b73 a1ff          	cp	a,#255
8866  1b75 2703          	jreq	L032
8867  1b77 cc1c4c        	jp	L1173
8868  1b7a               L032:
8870  1b7a b6c5          	ld	a,_mess+8
8871  1b7c a126          	cp	a,#38
8872  1b7e 2709          	jreq	L3173
8874  1b80 b6c5          	ld	a,_mess+8
8875  1b82 a129          	cp	a,#41
8876  1b84 2703          	jreq	L232
8877  1b86 cc1c4c        	jp	L1173
8878  1b89               L232:
8879  1b89               L3173:
8880                     ; 1841 	tempSS=mess[9]+(mess[10]*256);
8882  1b89 b6c7          	ld	a,_mess+10
8883  1b8b 5f            	clrw	x
8884  1b8c 97            	ld	xl,a
8885  1b8d 4f            	clr	a
8886  1b8e 02            	rlwa	x,a
8887  1b8f 01            	rrwa	x,a
8888  1b90 bbc6          	add	a,_mess+9
8889  1b92 2401          	jrnc	L271
8890  1b94 5c            	incw	x
8891  1b95               L271:
8892  1b95 02            	rlwa	x,a
8893  1b96 1f03          	ldw	(OFST-4,sp),x
8894  1b98 01            	rrwa	x,a
8895                     ; 1843 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
8897  1b99 ce000c        	ldw	x,_ee_UAVT
8898  1b9c 1303          	cpw	x,(OFST-4,sp)
8899  1b9e 270a          	jreq	L5173
8902  1ba0 1e03          	ldw	x,(OFST-4,sp)
8903  1ba2 89            	pushw	x
8904  1ba3 ae000c        	ldw	x,#_ee_UAVT
8905  1ba6 cd0000        	call	c_eewrw
8907  1ba9 85            	popw	x
8908  1baa               L5173:
8909                     ; 1844 	tempSS=(signed short)mess[11];
8911  1baa b6c8          	ld	a,_mess+11
8912  1bac 5f            	clrw	x
8913  1bad 97            	ld	xl,a
8914  1bae 1f03          	ldw	(OFST-4,sp),x
8915                     ; 1845 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8917  1bb0 ce0010        	ldw	x,_ee_tmax
8918  1bb3 1303          	cpw	x,(OFST-4,sp)
8919  1bb5 270a          	jreq	L7173
8922  1bb7 1e03          	ldw	x,(OFST-4,sp)
8923  1bb9 89            	pushw	x
8924  1bba ae0010        	ldw	x,#_ee_tmax
8925  1bbd cd0000        	call	c_eewrw
8927  1bc0 85            	popw	x
8928  1bc1               L7173:
8929                     ; 1846 	tempSS=(signed short)mess[12];
8931  1bc1 b6c9          	ld	a,_mess+12
8932  1bc3 5f            	clrw	x
8933  1bc4 97            	ld	xl,a
8934  1bc5 1f03          	ldw	(OFST-4,sp),x
8935                     ; 1847 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8937  1bc7 ce000e        	ldw	x,_ee_tsign
8938  1bca 1303          	cpw	x,(OFST-4,sp)
8939  1bcc 270a          	jreq	L1273
8942  1bce 1e03          	ldw	x,(OFST-4,sp)
8943  1bd0 89            	pushw	x
8944  1bd1 ae000e        	ldw	x,#_ee_tsign
8945  1bd4 cd0000        	call	c_eewrw
8947  1bd7 85            	popw	x
8948  1bd8               L1273:
8949                     ; 1850 	if(mess[8]==MEM_KF1)
8951  1bd8 b6c5          	ld	a,_mess+8
8952  1bda a126          	cp	a,#38
8953  1bdc 2623          	jrne	L3273
8954                     ; 1852 		if(ee_DEVICE!=0)ee_DEVICE=0;
8956  1bde ce0004        	ldw	x,_ee_DEVICE
8957  1be1 2709          	jreq	L5273
8960  1be3 5f            	clrw	x
8961  1be4 89            	pushw	x
8962  1be5 ae0004        	ldw	x,#_ee_DEVICE
8963  1be8 cd0000        	call	c_eewrw
8965  1beb 85            	popw	x
8966  1bec               L5273:
8967                     ; 1853 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8969  1bec b6ca          	ld	a,_mess+13
8970  1bee 5f            	clrw	x
8971  1bef 97            	ld	xl,a
8972  1bf0 c30016        	cpw	x,_ee_TZAS
8973  1bf3 270c          	jreq	L3273
8976  1bf5 b6ca          	ld	a,_mess+13
8977  1bf7 5f            	clrw	x
8978  1bf8 97            	ld	xl,a
8979  1bf9 89            	pushw	x
8980  1bfa ae0016        	ldw	x,#_ee_TZAS
8981  1bfd cd0000        	call	c_eewrw
8983  1c00 85            	popw	x
8984  1c01               L3273:
8985                     ; 1855 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8987  1c01 b6c5          	ld	a,_mess+8
8988  1c03 a129          	cp	a,#41
8989  1c05 2703          	jreq	L432
8990  1c07 cc1de6        	jp	L7243
8991  1c0a               L432:
8992                     ; 1857 		if(ee_DEVICE!=1)ee_DEVICE=1;
8994  1c0a ce0004        	ldw	x,_ee_DEVICE
8995  1c0d a30001        	cpw	x,#1
8996  1c10 270b          	jreq	L3373
8999  1c12 ae0001        	ldw	x,#1
9000  1c15 89            	pushw	x
9001  1c16 ae0004        	ldw	x,#_ee_DEVICE
9002  1c19 cd0000        	call	c_eewrw
9004  1c1c 85            	popw	x
9005  1c1d               L3373:
9006                     ; 1858 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
9008  1c1d b6ca          	ld	a,_mess+13
9009  1c1f 5f            	clrw	x
9010  1c20 97            	ld	xl,a
9011  1c21 c30002        	cpw	x,_ee_IMAXVENT
9012  1c24 270c          	jreq	L5373
9015  1c26 b6ca          	ld	a,_mess+13
9016  1c28 5f            	clrw	x
9017  1c29 97            	ld	xl,a
9018  1c2a 89            	pushw	x
9019  1c2b ae0002        	ldw	x,#_ee_IMAXVENT
9020  1c2e cd0000        	call	c_eewrw
9022  1c31 85            	popw	x
9023  1c32               L5373:
9024                     ; 1859 			if(ee_TZAS!=3) ee_TZAS=3;
9026  1c32 ce0016        	ldw	x,_ee_TZAS
9027  1c35 a30003        	cpw	x,#3
9028  1c38 2603          	jrne	L632
9029  1c3a cc1de6        	jp	L7243
9030  1c3d               L632:
9033  1c3d ae0003        	ldw	x,#3
9034  1c40 89            	pushw	x
9035  1c41 ae0016        	ldw	x,#_ee_TZAS
9036  1c44 cd0000        	call	c_eewrw
9038  1c47 85            	popw	x
9039  1c48 ace61de6      	jpf	L7243
9040  1c4c               L1173:
9041                     ; 1863 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
9043  1c4c b6c3          	ld	a,_mess+6
9044  1c4e c100f9        	cp	a,_adress
9045  1c51 262d          	jrne	L3473
9047  1c53 b6c4          	ld	a,_mess+7
9048  1c55 c100f9        	cp	a,_adress
9049  1c58 2626          	jrne	L3473
9051  1c5a b6c5          	ld	a,_mess+8
9052  1c5c a116          	cp	a,#22
9053  1c5e 2620          	jrne	L3473
9055  1c60 b6c6          	ld	a,_mess+9
9056  1c62 a163          	cp	a,#99
9057  1c64 261a          	jrne	L3473
9058                     ; 1865 	flags&=0b11100001;
9060  1c66 b605          	ld	a,_flags
9061  1c68 a4e1          	and	a,#225
9062  1c6a b705          	ld	_flags,a
9063                     ; 1866 	tsign_cnt=0;
9065  1c6c 5f            	clrw	x
9066  1c6d bf4f          	ldw	_tsign_cnt,x
9067                     ; 1867 	tmax_cnt=0;
9069  1c6f 5f            	clrw	x
9070  1c70 bf4d          	ldw	_tmax_cnt,x
9071                     ; 1868 	umax_cnt=0;
9073  1c72 5f            	clrw	x
9074  1c73 bf66          	ldw	_umax_cnt,x
9075                     ; 1869 	umin_cnt=0;
9077  1c75 5f            	clrw	x
9078  1c76 bf64          	ldw	_umin_cnt,x
9079                     ; 1870 	led_drv_cnt=30;
9081  1c78 351e0016      	mov	_led_drv_cnt,#30
9083  1c7c ace61de6      	jpf	L7243
9084  1c80               L3473:
9085                     ; 1873 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
9087  1c80 b6c3          	ld	a,_mess+6
9088  1c82 c100f9        	cp	a,_adress
9089  1c85 2620          	jrne	L7473
9091  1c87 b6c4          	ld	a,_mess+7
9092  1c89 c100f9        	cp	a,_adress
9093  1c8c 2619          	jrne	L7473
9095  1c8e b6c5          	ld	a,_mess+8
9096  1c90 a116          	cp	a,#22
9097  1c92 2613          	jrne	L7473
9099  1c94 b6c6          	ld	a,_mess+9
9100  1c96 a164          	cp	a,#100
9101  1c98 260d          	jrne	L7473
9102                     ; 1875 	vent_resurs=0;
9104  1c9a 5f            	clrw	x
9105  1c9b 89            	pushw	x
9106  1c9c ae0000        	ldw	x,#_vent_resurs
9107  1c9f cd0000        	call	c_eewrw
9109  1ca2 85            	popw	x
9111  1ca3 ace61de6      	jpf	L7243
9112  1ca7               L7473:
9113                     ; 1879 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
9115  1ca7 b6c3          	ld	a,_mess+6
9116  1ca9 a1ff          	cp	a,#255
9117  1cab 265f          	jrne	L3573
9119  1cad b6c4          	ld	a,_mess+7
9120  1caf a1ff          	cp	a,#255
9121  1cb1 2659          	jrne	L3573
9123  1cb3 b6c5          	ld	a,_mess+8
9124  1cb5 a116          	cp	a,#22
9125  1cb7 2653          	jrne	L3573
9127  1cb9 b6c6          	ld	a,_mess+9
9128  1cbb a116          	cp	a,#22
9129  1cbd 264d          	jrne	L3573
9130                     ; 1881 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9132  1cbf b6c7          	ld	a,_mess+10
9133  1cc1 a155          	cp	a,#85
9134  1cc3 260f          	jrne	L5573
9136  1cc5 b6c8          	ld	a,_mess+11
9137  1cc7 a155          	cp	a,#85
9138  1cc9 2609          	jrne	L5573
9141  1ccb be5e          	ldw	x,__x_
9142  1ccd 1c0001        	addw	x,#1
9143  1cd0 bf5e          	ldw	__x_,x
9145  1cd2 2024          	jra	L7573
9146  1cd4               L5573:
9147                     ; 1882 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9149  1cd4 b6c7          	ld	a,_mess+10
9150  1cd6 a166          	cp	a,#102
9151  1cd8 260f          	jrne	L1673
9153  1cda b6c8          	ld	a,_mess+11
9154  1cdc a166          	cp	a,#102
9155  1cde 2609          	jrne	L1673
9158  1ce0 be5e          	ldw	x,__x_
9159  1ce2 1d0001        	subw	x,#1
9160  1ce5 bf5e          	ldw	__x_,x
9162  1ce7 200f          	jra	L7573
9163  1ce9               L1673:
9164                     ; 1883 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9166  1ce9 b6c7          	ld	a,_mess+10
9167  1ceb a177          	cp	a,#119
9168  1ced 2609          	jrne	L7573
9170  1cef b6c8          	ld	a,_mess+11
9171  1cf1 a177          	cp	a,#119
9172  1cf3 2603          	jrne	L7573
9175  1cf5 5f            	clrw	x
9176  1cf6 bf5e          	ldw	__x_,x
9177  1cf8               L7573:
9178                     ; 1884      gran(&_x_,-XMAX,XMAX);
9180  1cf8 ae0019        	ldw	x,#25
9181  1cfb 89            	pushw	x
9182  1cfc aeffe7        	ldw	x,#65511
9183  1cff 89            	pushw	x
9184  1d00 ae005e        	ldw	x,#__x_
9185  1d03 cd00d1        	call	_gran
9187  1d06 5b04          	addw	sp,#4
9189  1d08 ace61de6      	jpf	L7243
9190  1d0c               L3573:
9191                     ; 1886 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9193  1d0c b6c3          	ld	a,_mess+6
9194  1d0e c100f9        	cp	a,_adress
9195  1d11 2635          	jrne	L1773
9197  1d13 b6c4          	ld	a,_mess+7
9198  1d15 c100f9        	cp	a,_adress
9199  1d18 262e          	jrne	L1773
9201  1d1a b6c5          	ld	a,_mess+8
9202  1d1c a116          	cp	a,#22
9203  1d1e 2628          	jrne	L1773
9205  1d20 b6c6          	ld	a,_mess+9
9206  1d22 b1c7          	cp	a,_mess+10
9207  1d24 2622          	jrne	L1773
9209  1d26 b6c6          	ld	a,_mess+9
9210  1d28 a1ee          	cp	a,#238
9211  1d2a 261c          	jrne	L1773
9212                     ; 1888 	rotor_int++;
9214  1d2c be17          	ldw	x,_rotor_int
9215  1d2e 1c0001        	addw	x,#1
9216  1d31 bf17          	ldw	_rotor_int,x
9217                     ; 1889      tempI=pwm_u;
9219                     ; 1891 	UU_AVT=Un;
9221  1d33 ce0010        	ldw	x,_Un
9222  1d36 89            	pushw	x
9223  1d37 ae0008        	ldw	x,#_UU_AVT
9224  1d3a cd0000        	call	c_eewrw
9226  1d3d 85            	popw	x
9227                     ; 1892 	delay_ms(100);
9229  1d3e ae0064        	ldw	x,#100
9230  1d41 cd011d        	call	_delay_ms
9233  1d44 ace61de6      	jpf	L7243
9234  1d48               L1773:
9235                     ; 1898 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9237  1d48 b6c4          	ld	a,_mess+7
9238  1d4a a1da          	cp	a,#218
9239  1d4c 2653          	jrne	L5773
9241  1d4e b6c3          	ld	a,_mess+6
9242  1d50 c100f9        	cp	a,_adress
9243  1d53 274c          	jreq	L5773
9245  1d55 b6c3          	ld	a,_mess+6
9246  1d57 a106          	cp	a,#6
9247  1d59 2446          	jruge	L5773
9248                     ; 1900 	i_main_bps_cnt[mess[6]]=0;
9250  1d5b b6c3          	ld	a,_mess+6
9251  1d5d 5f            	clrw	x
9252  1d5e 97            	ld	xl,a
9253  1d5f 6f09          	clr	(_i_main_bps_cnt,x)
9254                     ; 1901 	i_main_flag[mess[6]]=1;
9256  1d61 b6c3          	ld	a,_mess+6
9257  1d63 5f            	clrw	x
9258  1d64 97            	ld	xl,a
9259  1d65 a601          	ld	a,#1
9260  1d67 e714          	ld	(_i_main_flag,x),a
9261                     ; 1902 	if(bMAIN)
9263                     	btst	_bMAIN
9264  1d6e 2476          	jruge	L7243
9265                     ; 1904 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9267  1d70 b6c6          	ld	a,_mess+9
9268  1d72 5f            	clrw	x
9269  1d73 97            	ld	xl,a
9270  1d74 4f            	clr	a
9271  1d75 02            	rlwa	x,a
9272  1d76 1f01          	ldw	(OFST-6,sp),x
9273  1d78 b6c5          	ld	a,_mess+8
9274  1d7a 5f            	clrw	x
9275  1d7b 97            	ld	xl,a
9276  1d7c 72fb01        	addw	x,(OFST-6,sp)
9277  1d7f b6c3          	ld	a,_mess+6
9278  1d81 905f          	clrw	y
9279  1d83 9097          	ld	yl,a
9280  1d85 9058          	sllw	y
9281  1d87 90ef1a        	ldw	(_i_main,y),x
9282                     ; 1905 		i_main[adress]=I;
9284  1d8a c600f9        	ld	a,_adress
9285  1d8d 5f            	clrw	x
9286  1d8e 97            	ld	xl,a
9287  1d8f 58            	sllw	x
9288  1d90 90ce0012      	ldw	y,_I
9289  1d94 ef1a          	ldw	(_i_main,x),y
9290                     ; 1906      	i_main_flag[adress]=1;
9292  1d96 c600f9        	ld	a,_adress
9293  1d99 5f            	clrw	x
9294  1d9a 97            	ld	xl,a
9295  1d9b a601          	ld	a,#1
9296  1d9d e714          	ld	(_i_main_flag,x),a
9297  1d9f 2045          	jra	L7243
9298  1da1               L5773:
9299                     ; 1910 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9301  1da1 b6c4          	ld	a,_mess+7
9302  1da3 a1db          	cp	a,#219
9303  1da5 263f          	jrne	L7243
9305  1da7 b6c3          	ld	a,_mess+6
9306  1da9 c100f9        	cp	a,_adress
9307  1dac 2738          	jreq	L7243
9309  1dae b6c3          	ld	a,_mess+6
9310  1db0 a106          	cp	a,#6
9311  1db2 2432          	jruge	L7243
9312                     ; 1912 	i_main_bps_cnt[mess[6]]=0;
9314  1db4 b6c3          	ld	a,_mess+6
9315  1db6 5f            	clrw	x
9316  1db7 97            	ld	xl,a
9317  1db8 6f09          	clr	(_i_main_bps_cnt,x)
9318                     ; 1913 	i_main_flag[mess[6]]=1;		
9320  1dba b6c3          	ld	a,_mess+6
9321  1dbc 5f            	clrw	x
9322  1dbd 97            	ld	xl,a
9323  1dbe a601          	ld	a,#1
9324  1dc0 e714          	ld	(_i_main_flag,x),a
9325                     ; 1914 	if(bMAIN)
9327                     	btst	_bMAIN
9328  1dc7 241d          	jruge	L7243
9329                     ; 1916 		if(mess[9]==0)i_main_flag[i]=1;
9331  1dc9 3dc6          	tnz	_mess+9
9332  1dcb 260a          	jrne	L7004
9335  1dcd 7b07          	ld	a,(OFST+0,sp)
9336  1dcf 5f            	clrw	x
9337  1dd0 97            	ld	xl,a
9338  1dd1 a601          	ld	a,#1
9339  1dd3 e714          	ld	(_i_main_flag,x),a
9341  1dd5 2006          	jra	L1104
9342  1dd7               L7004:
9343                     ; 1917 		else i_main_flag[i]=0;
9345  1dd7 7b07          	ld	a,(OFST+0,sp)
9346  1dd9 5f            	clrw	x
9347  1dda 97            	ld	xl,a
9348  1ddb 6f14          	clr	(_i_main_flag,x)
9349  1ddd               L1104:
9350                     ; 1918 		i_main_flag[adress]=1;
9352  1ddd c600f9        	ld	a,_adress
9353  1de0 5f            	clrw	x
9354  1de1 97            	ld	xl,a
9355  1de2 a601          	ld	a,#1
9356  1de4 e714          	ld	(_i_main_flag,x),a
9357  1de6               L7243:
9358                     ; 1924 can_in_an_end:
9358                     ; 1925 bCAN_RX=0;
9360  1de6 3f04          	clr	_bCAN_RX
9361                     ; 1926 }   
9364  1de8 5b07          	addw	sp,#7
9365  1dea 81            	ret
9388                     ; 1929 void t4_init(void){
9389                     	switch	.text
9390  1deb               _t4_init:
9394                     ; 1930 	TIM4->PSCR = 4;
9396  1deb 35045345      	mov	21317,#4
9397                     ; 1931 	TIM4->ARR= 61;
9399  1def 353d5346      	mov	21318,#61
9400                     ; 1932 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9402  1df3 72105341      	bset	21313,#0
9403                     ; 1934 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9405  1df7 35855340      	mov	21312,#133
9406                     ; 1936 }
9409  1dfb 81            	ret
9432                     ; 1939 void t1_init(void)
9432                     ; 1940 {
9433                     	switch	.text
9434  1dfc               _t1_init:
9438                     ; 1941 TIM1->ARRH= 0x03;
9440  1dfc 35035262      	mov	21090,#3
9441                     ; 1942 TIM1->ARRL= 0xff;
9443  1e00 35ff5263      	mov	21091,#255
9444                     ; 1943 TIM1->CCR1H= 0x00;	
9446  1e04 725f5265      	clr	21093
9447                     ; 1944 TIM1->CCR1L= 0xff;
9449  1e08 35ff5266      	mov	21094,#255
9450                     ; 1945 TIM1->CCR2H= 0x00;	
9452  1e0c 725f5267      	clr	21095
9453                     ; 1946 TIM1->CCR2L= 0x00;
9455  1e10 725f5268      	clr	21096
9456                     ; 1947 TIM1->CCR3H= 0x00;	
9458  1e14 725f5269      	clr	21097
9459                     ; 1948 TIM1->CCR3L= 0x64;
9461  1e18 3564526a      	mov	21098,#100
9462                     ; 1950 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9464  1e1c 35685258      	mov	21080,#104
9465                     ; 1951 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9467  1e20 35685259      	mov	21081,#104
9468                     ; 1952 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9470  1e24 3568525a      	mov	21082,#104
9471                     ; 1953 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9473  1e28 3511525c      	mov	21084,#17
9474                     ; 1954 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9476  1e2c 3501525d      	mov	21085,#1
9477                     ; 1955 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9479  1e30 35815250      	mov	21072,#129
9480                     ; 1956 TIM1->BKR|= TIM1_BKR_AOE;
9482  1e34 721c526d      	bset	21101,#6
9483                     ; 1957 }
9486  1e38 81            	ret
9511                     ; 1961 void adc2_init(void)
9511                     ; 1962 {
9512                     	switch	.text
9513  1e39               _adc2_init:
9517                     ; 1963 adc_plazma[0]++;
9519  1e39 beaf          	ldw	x,_adc_plazma
9520  1e3b 1c0001        	addw	x,#1
9521  1e3e bfaf          	ldw	_adc_plazma,x
9522                     ; 1987 GPIOB->DDR&=~(1<<4);
9524  1e40 72195007      	bres	20487,#4
9525                     ; 1988 GPIOB->CR1&=~(1<<4);
9527  1e44 72195008      	bres	20488,#4
9528                     ; 1989 GPIOB->CR2&=~(1<<4);
9530  1e48 72195009      	bres	20489,#4
9531                     ; 1991 GPIOB->DDR&=~(1<<5);
9533  1e4c 721b5007      	bres	20487,#5
9534                     ; 1992 GPIOB->CR1&=~(1<<5);
9536  1e50 721b5008      	bres	20488,#5
9537                     ; 1993 GPIOB->CR2&=~(1<<5);
9539  1e54 721b5009      	bres	20489,#5
9540                     ; 1995 GPIOB->DDR&=~(1<<6);
9542  1e58 721d5007      	bres	20487,#6
9543                     ; 1996 GPIOB->CR1&=~(1<<6);
9545  1e5c 721d5008      	bres	20488,#6
9546                     ; 1997 GPIOB->CR2&=~(1<<6);
9548  1e60 721d5009      	bres	20489,#6
9549                     ; 1999 GPIOB->DDR&=~(1<<7);
9551  1e64 721f5007      	bres	20487,#7
9552                     ; 2000 GPIOB->CR1&=~(1<<7);
9554  1e68 721f5008      	bres	20488,#7
9555                     ; 2001 GPIOB->CR2&=~(1<<7);
9557  1e6c 721f5009      	bres	20489,#7
9558                     ; 2003 GPIOB->DDR&=~(1<<2);
9560  1e70 72155007      	bres	20487,#2
9561                     ; 2004 GPIOB->CR1&=~(1<<2);
9563  1e74 72155008      	bres	20488,#2
9564                     ; 2005 GPIOB->CR2&=~(1<<2);
9566  1e78 72155009      	bres	20489,#2
9567                     ; 2014 ADC2->TDRL=0xff;
9569  1e7c 35ff5407      	mov	21511,#255
9570                     ; 2016 ADC2->CR2=0x08;
9572  1e80 35085402      	mov	21506,#8
9573                     ; 2017 ADC2->CR1=0x40;
9575  1e84 35405401      	mov	21505,#64
9576                     ; 2020 	if(adc_ch==5)ADC2->CSR=0x22;
9578  1e88 b6bc          	ld	a,_adc_ch
9579  1e8a a105          	cp	a,#5
9580  1e8c 2606          	jrne	L3404
9583  1e8e 35225400      	mov	21504,#34
9585  1e92 2007          	jra	L5404
9586  1e94               L3404:
9587                     ; 2021 	else ADC2->CSR=0x20+adc_ch+3;
9589  1e94 b6bc          	ld	a,_adc_ch
9590  1e96 ab23          	add	a,#35
9591  1e98 c75400        	ld	21504,a
9592  1e9b               L5404:
9593                     ; 2023 	ADC2->CR1|=1;
9595  1e9b 72105401      	bset	21505,#0
9596                     ; 2024 	ADC2->CR1|=1;
9598  1e9f 72105401      	bset	21505,#0
9599                     ; 2027 adc_plazma[1]=adc_ch;
9601  1ea3 b6bc          	ld	a,_adc_ch
9602  1ea5 5f            	clrw	x
9603  1ea6 97            	ld	xl,a
9604  1ea7 bfb1          	ldw	_adc_plazma+2,x
9605                     ; 2028 }
9608  1ea9 81            	ret
9644                     ; 2036 @far @interrupt void TIM4_UPD_Interrupt (void) 
9644                     ; 2037 {
9646                     	switch	.text
9647  1eaa               f_TIM4_UPD_Interrupt:
9651                     ; 2038 TIM4->SR1&=~TIM4_SR1_UIF;
9653  1eaa 72115342      	bres	21314,#0
9654                     ; 2040 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9656  1eae 3c08          	inc	_pwm_vent_cnt
9657  1eb0 b608          	ld	a,_pwm_vent_cnt
9658  1eb2 a10a          	cp	a,#10
9659  1eb4 2502          	jrult	L7504
9662  1eb6 3f08          	clr	_pwm_vent_cnt
9663  1eb8               L7504:
9664                     ; 2041 GPIOB->ODR|=(1<<3);
9666  1eb8 72165005      	bset	20485,#3
9667                     ; 2042 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9669  1ebc b608          	ld	a,_pwm_vent_cnt
9670  1ebe a105          	cp	a,#5
9671  1ec0 2504          	jrult	L1604
9674  1ec2 72175005      	bres	20485,#3
9675  1ec6               L1604:
9676                     ; 2046 if(++t0_cnt00>=10)
9678  1ec6 9c            	rvf
9679  1ec7 ce0000        	ldw	x,_t0_cnt00
9680  1eca 1c0001        	addw	x,#1
9681  1ecd cf0000        	ldw	_t0_cnt00,x
9682  1ed0 a3000a        	cpw	x,#10
9683  1ed3 2f08          	jrslt	L3604
9684                     ; 2048 	t0_cnt00=0;
9686  1ed5 5f            	clrw	x
9687  1ed6 cf0000        	ldw	_t0_cnt00,x
9688                     ; 2049 	b1000Hz=1;
9690  1ed9 72100004      	bset	_b1000Hz
9691  1edd               L3604:
9692                     ; 2052 if(++t0_cnt0>=100)
9694  1edd 9c            	rvf
9695  1ede ce0002        	ldw	x,_t0_cnt0
9696  1ee1 1c0001        	addw	x,#1
9697  1ee4 cf0002        	ldw	_t0_cnt0,x
9698  1ee7 a30064        	cpw	x,#100
9699  1eea 2f54          	jrslt	L5604
9700                     ; 2054 	t0_cnt0=0;
9702  1eec 5f            	clrw	x
9703  1eed cf0002        	ldw	_t0_cnt0,x
9704                     ; 2055 	b100Hz=1;
9706  1ef0 72100009      	bset	_b100Hz
9707                     ; 2057 	if(++t0_cnt1>=10)
9709  1ef4 725c0004      	inc	_t0_cnt1
9710  1ef8 c60004        	ld	a,_t0_cnt1
9711  1efb a10a          	cp	a,#10
9712  1efd 2508          	jrult	L7604
9713                     ; 2059 		t0_cnt1=0;
9715  1eff 725f0004      	clr	_t0_cnt1
9716                     ; 2060 		b10Hz=1;
9718  1f03 72100008      	bset	_b10Hz
9719  1f07               L7604:
9720                     ; 2063 	if(++t0_cnt2>=20)
9722  1f07 725c0005      	inc	_t0_cnt2
9723  1f0b c60005        	ld	a,_t0_cnt2
9724  1f0e a114          	cp	a,#20
9725  1f10 2508          	jrult	L1704
9726                     ; 2065 		t0_cnt2=0;
9728  1f12 725f0005      	clr	_t0_cnt2
9729                     ; 2066 		b5Hz=1;
9731  1f16 72100007      	bset	_b5Hz
9732  1f1a               L1704:
9733                     ; 2070 	if(++t0_cnt4>=50)
9735  1f1a 725c0007      	inc	_t0_cnt4
9736  1f1e c60007        	ld	a,_t0_cnt4
9737  1f21 a132          	cp	a,#50
9738  1f23 2508          	jrult	L3704
9739                     ; 2072 		t0_cnt4=0;
9741  1f25 725f0007      	clr	_t0_cnt4
9742                     ; 2073 		b2Hz=1;
9744  1f29 72100006      	bset	_b2Hz
9745  1f2d               L3704:
9746                     ; 2076 	if(++t0_cnt3>=100)
9748  1f2d 725c0006      	inc	_t0_cnt3
9749  1f31 c60006        	ld	a,_t0_cnt3
9750  1f34 a164          	cp	a,#100
9751  1f36 2508          	jrult	L5604
9752                     ; 2078 		t0_cnt3=0;
9754  1f38 725f0006      	clr	_t0_cnt3
9755                     ; 2079 		b1Hz=1;
9757  1f3c 72100005      	bset	_b1Hz
9758  1f40               L5604:
9759                     ; 2085 }
9762  1f40 80            	iret
9787                     ; 2088 @far @interrupt void CAN_RX_Interrupt (void) 
9787                     ; 2089 {
9788                     	switch	.text
9789  1f41               f_CAN_RX_Interrupt:
9793                     ; 2091 CAN->PSR= 7;									// page 7 - read messsage
9795  1f41 35075427      	mov	21543,#7
9796                     ; 2093 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9798  1f45 ae000e        	ldw	x,#14
9799  1f48               L252:
9800  1f48 d65427        	ld	a,(21543,x)
9801  1f4b e7bc          	ld	(_mess-1,x),a
9802  1f4d 5a            	decw	x
9803  1f4e 26f8          	jrne	L252
9804                     ; 2104 bCAN_RX=1;
9806  1f50 35010004      	mov	_bCAN_RX,#1
9807                     ; 2105 CAN->RFR|=(1<<5);
9809  1f54 721a5424      	bset	21540,#5
9810                     ; 2107 }
9813  1f58 80            	iret
9836                     ; 2110 @far @interrupt void CAN_TX_Interrupt (void) 
9836                     ; 2111 {
9837                     	switch	.text
9838  1f59               f_CAN_TX_Interrupt:
9842                     ; 2112 if((CAN->TSR)&(1<<0))
9844  1f59 c65422        	ld	a,21538
9845  1f5c a501          	bcp	a,#1
9846  1f5e 2708          	jreq	L7114
9847                     ; 2114 	bTX_FREE=1;	
9849  1f60 35010003      	mov	_bTX_FREE,#1
9850                     ; 2116 	CAN->TSR|=(1<<0);
9852  1f64 72105422      	bset	21538,#0
9853  1f68               L7114:
9854                     ; 2118 }
9857  1f68 80            	iret
9937                     ; 2121 @far @interrupt void ADC2_EOC_Interrupt (void) {
9938                     	switch	.text
9939  1f69               f_ADC2_EOC_Interrupt:
9941       0000000d      OFST:	set	13
9942  1f69 be00          	ldw	x,c_x
9943  1f6b 89            	pushw	x
9944  1f6c be00          	ldw	x,c_y
9945  1f6e 89            	pushw	x
9946  1f6f be02          	ldw	x,c_lreg+2
9947  1f71 89            	pushw	x
9948  1f72 be00          	ldw	x,c_lreg
9949  1f74 89            	pushw	x
9950  1f75 520d          	subw	sp,#13
9953                     ; 2126 adc_plazma[2]++;
9955  1f77 beb3          	ldw	x,_adc_plazma+4
9956  1f79 1c0001        	addw	x,#1
9957  1f7c bfb3          	ldw	_adc_plazma+4,x
9958                     ; 2133 ADC2->CSR&=~(1<<7);
9960  1f7e 721f5400      	bres	21504,#7
9961                     ; 2135 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9963  1f82 c65405        	ld	a,21509
9964  1f85 b703          	ld	c_lreg+3,a
9965  1f87 3f02          	clr	c_lreg+2
9966  1f89 3f01          	clr	c_lreg+1
9967  1f8b 3f00          	clr	c_lreg
9968  1f8d 96            	ldw	x,sp
9969  1f8e 1c0001        	addw	x,#OFST-12
9970  1f91 cd0000        	call	c_rtol
9972  1f94 c65404        	ld	a,21508
9973  1f97 5f            	clrw	x
9974  1f98 97            	ld	xl,a
9975  1f99 90ae0100      	ldw	y,#256
9976  1f9d cd0000        	call	c_umul
9978  1fa0 96            	ldw	x,sp
9979  1fa1 1c0001        	addw	x,#OFST-12
9980  1fa4 cd0000        	call	c_ladd
9982  1fa7 96            	ldw	x,sp
9983  1fa8 1c000a        	addw	x,#OFST-3
9984  1fab cd0000        	call	c_rtol
9986                     ; 2140 if(adr_drv_stat==1)
9988  1fae b602          	ld	a,_adr_drv_stat
9989  1fb0 a101          	cp	a,#1
9990  1fb2 260b          	jrne	L7514
9991                     ; 2142 	adr_drv_stat=2;
9993  1fb4 35020002      	mov	_adr_drv_stat,#2
9994                     ; 2143 	adc_buff_[0]=temp_adc;
9996  1fb8 1e0c          	ldw	x,(OFST-1,sp)
9997  1fba cf0101        	ldw	_adc_buff_,x
9999  1fbd 2020          	jra	L1614
10000  1fbf               L7514:
10001                     ; 2146 else if(adr_drv_stat==3)
10003  1fbf b602          	ld	a,_adr_drv_stat
10004  1fc1 a103          	cp	a,#3
10005  1fc3 260b          	jrne	L3614
10006                     ; 2148 	adr_drv_stat=4;
10008  1fc5 35040002      	mov	_adr_drv_stat,#4
10009                     ; 2149 	adc_buff_[1]=temp_adc;
10011  1fc9 1e0c          	ldw	x,(OFST-1,sp)
10012  1fcb cf0103        	ldw	_adc_buff_+2,x
10014  1fce 200f          	jra	L1614
10015  1fd0               L3614:
10016                     ; 2152 else if(adr_drv_stat==5)
10018  1fd0 b602          	ld	a,_adr_drv_stat
10019  1fd2 a105          	cp	a,#5
10020  1fd4 2609          	jrne	L1614
10021                     ; 2154 	adr_drv_stat=6;
10023  1fd6 35060002      	mov	_adr_drv_stat,#6
10024                     ; 2155 	adc_buff_[9]=temp_adc;
10026  1fda 1e0c          	ldw	x,(OFST-1,sp)
10027  1fdc cf0113        	ldw	_adc_buff_+18,x
10028  1fdf               L1614:
10029                     ; 2158 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
10031  1fdf b6ad          	ld	a,_adc_cnt_cnt
10032  1fe1 5f            	clrw	x
10033  1fe2 97            	ld	xl,a
10034  1fe3 58            	sllw	x
10035  1fe4 1f03          	ldw	(OFST-10,sp),x
10036  1fe6 b6bc          	ld	a,_adc_ch
10037  1fe8 97            	ld	xl,a
10038  1fe9 a610          	ld	a,#16
10039  1feb 42            	mul	x,a
10040  1fec 72fb03        	addw	x,(OFST-10,sp)
10041  1fef 160c          	ldw	y,(OFST-1,sp)
10042  1ff1 df0058        	ldw	(_adc_buff_buff,x),y
10043                     ; 2160 adc_ch++;
10045  1ff4 3cbc          	inc	_adc_ch
10046                     ; 2161 if(adc_ch>=6)
10048  1ff6 b6bc          	ld	a,_adc_ch
10049  1ff8 a106          	cp	a,#6
10050  1ffa 2516          	jrult	L1714
10051                     ; 2163 	adc_ch=0;
10053  1ffc 3fbc          	clr	_adc_ch
10054                     ; 2164 	adc_cnt_cnt++;
10056  1ffe 3cad          	inc	_adc_cnt_cnt
10057                     ; 2165 	if(adc_cnt_cnt>=8)
10059  2000 b6ad          	ld	a,_adc_cnt_cnt
10060  2002 a108          	cp	a,#8
10061  2004 250c          	jrult	L1714
10062                     ; 2167 		adc_cnt_cnt=0;
10064  2006 3fad          	clr	_adc_cnt_cnt
10065                     ; 2168 		adc_cnt++;
10067  2008 3cbb          	inc	_adc_cnt
10068                     ; 2169 		if(adc_cnt>=16)
10070  200a b6bb          	ld	a,_adc_cnt
10071  200c a110          	cp	a,#16
10072  200e 2502          	jrult	L1714
10073                     ; 2171 			adc_cnt=0;
10075  2010 3fbb          	clr	_adc_cnt
10076  2012               L1714:
10077                     ; 2175 if(adc_cnt_cnt==0)
10079  2012 3dad          	tnz	_adc_cnt_cnt
10080  2014 2660          	jrne	L7714
10081                     ; 2179 	tempSS=0;
10083  2016 ae0000        	ldw	x,#0
10084  2019 1f07          	ldw	(OFST-6,sp),x
10085  201b ae0000        	ldw	x,#0
10086  201e 1f05          	ldw	(OFST-8,sp),x
10087                     ; 2180 	for(i=0;i<8;i++)
10089  2020 0f09          	clr	(OFST-4,sp)
10090  2022               L1024:
10091                     ; 2182 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
10093  2022 7b09          	ld	a,(OFST-4,sp)
10094  2024 5f            	clrw	x
10095  2025 97            	ld	xl,a
10096  2026 58            	sllw	x
10097  2027 1f03          	ldw	(OFST-10,sp),x
10098  2029 b6bc          	ld	a,_adc_ch
10099  202b 97            	ld	xl,a
10100  202c a610          	ld	a,#16
10101  202e 42            	mul	x,a
10102  202f 72fb03        	addw	x,(OFST-10,sp)
10103  2032 de0058        	ldw	x,(_adc_buff_buff,x)
10104  2035 cd0000        	call	c_itolx
10106  2038 96            	ldw	x,sp
10107  2039 1c0005        	addw	x,#OFST-8
10108  203c cd0000        	call	c_lgadd
10110                     ; 2180 	for(i=0;i<8;i++)
10112  203f 0c09          	inc	(OFST-4,sp)
10115  2041 7b09          	ld	a,(OFST-4,sp)
10116  2043 a108          	cp	a,#8
10117  2045 25db          	jrult	L1024
10118                     ; 2184 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
10120  2047 96            	ldw	x,sp
10121  2048 1c0005        	addw	x,#OFST-8
10122  204b cd0000        	call	c_ltor
10124  204e a603          	ld	a,#3
10125  2050 cd0000        	call	c_lrsh
10127  2053 be02          	ldw	x,c_lreg+2
10128  2055 b6bb          	ld	a,_adc_cnt
10129  2057 905f          	clrw	y
10130  2059 9097          	ld	yl,a
10131  205b 9058          	sllw	y
10132  205d 1703          	ldw	(OFST-10,sp),y
10133  205f b6bc          	ld	a,_adc_ch
10134  2061 905f          	clrw	y
10135  2063 9097          	ld	yl,a
10136  2065 9058          	sllw	y
10137  2067 9058          	sllw	y
10138  2069 9058          	sllw	y
10139  206b 9058          	sllw	y
10140  206d 9058          	sllw	y
10141  206f 72f903        	addw	y,(OFST-10,sp)
10142  2072 90df0115      	ldw	(_adc_buff,y),x
10143  2076               L7714:
10144                     ; 2188 if((adc_cnt&0x03)==0)
10146  2076 b6bb          	ld	a,_adc_cnt
10147  2078 a503          	bcp	a,#3
10148  207a 264b          	jrne	L7024
10149                     ; 2192 	tempSS=0;
10151  207c ae0000        	ldw	x,#0
10152  207f 1f07          	ldw	(OFST-6,sp),x
10153  2081 ae0000        	ldw	x,#0
10154  2084 1f05          	ldw	(OFST-8,sp),x
10155                     ; 2193 	for(i=0;i<16;i++)
10157  2086 0f09          	clr	(OFST-4,sp)
10158  2088               L1124:
10159                     ; 2195 		tempSS+=(signed long)adc_buff[adc_ch][i];
10161  2088 7b09          	ld	a,(OFST-4,sp)
10162  208a 5f            	clrw	x
10163  208b 97            	ld	xl,a
10164  208c 58            	sllw	x
10165  208d 1f03          	ldw	(OFST-10,sp),x
10166  208f b6bc          	ld	a,_adc_ch
10167  2091 97            	ld	xl,a
10168  2092 a620          	ld	a,#32
10169  2094 42            	mul	x,a
10170  2095 72fb03        	addw	x,(OFST-10,sp)
10171  2098 de0115        	ldw	x,(_adc_buff,x)
10172  209b cd0000        	call	c_itolx
10174  209e 96            	ldw	x,sp
10175  209f 1c0005        	addw	x,#OFST-8
10176  20a2 cd0000        	call	c_lgadd
10178                     ; 2193 	for(i=0;i<16;i++)
10180  20a5 0c09          	inc	(OFST-4,sp)
10183  20a7 7b09          	ld	a,(OFST-4,sp)
10184  20a9 a110          	cp	a,#16
10185  20ab 25db          	jrult	L1124
10186                     ; 2197 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
10188  20ad 96            	ldw	x,sp
10189  20ae 1c0005        	addw	x,#OFST-8
10190  20b1 cd0000        	call	c_ltor
10192  20b4 a604          	ld	a,#4
10193  20b6 cd0000        	call	c_lrsh
10195  20b9 be02          	ldw	x,c_lreg+2
10196  20bb b6bc          	ld	a,_adc_ch
10197  20bd 905f          	clrw	y
10198  20bf 9097          	ld	yl,a
10199  20c1 9058          	sllw	y
10200  20c3 90df0101      	ldw	(_adc_buff_,y),x
10201  20c7               L7024:
10202                     ; 2204 if(adc_ch==0)adc_buff_5=temp_adc;
10204  20c7 3dbc          	tnz	_adc_ch
10205  20c9 2605          	jrne	L7124
10208  20cb 1e0c          	ldw	x,(OFST-1,sp)
10209  20cd cf00ff        	ldw	_adc_buff_5,x
10210  20d0               L7124:
10211                     ; 2205 if(adc_ch==2)adc_buff_1=temp_adc;
10213  20d0 b6bc          	ld	a,_adc_ch
10214  20d2 a102          	cp	a,#2
10215  20d4 2605          	jrne	L1224
10218  20d6 1e0c          	ldw	x,(OFST-1,sp)
10219  20d8 cf00fd        	ldw	_adc_buff_1,x
10220  20db               L1224:
10221                     ; 2207 adc_plazma_short++;
10223  20db beb9          	ldw	x,_adc_plazma_short
10224  20dd 1c0001        	addw	x,#1
10225  20e0 bfb9          	ldw	_adc_plazma_short,x
10226                     ; 2209 }
10229  20e2 5b0d          	addw	sp,#13
10230  20e4 85            	popw	x
10231  20e5 bf00          	ldw	c_lreg,x
10232  20e7 85            	popw	x
10233  20e8 bf02          	ldw	c_lreg+2,x
10234  20ea 85            	popw	x
10235  20eb bf00          	ldw	c_y,x
10236  20ed 85            	popw	x
10237  20ee bf00          	ldw	c_x,x
10238  20f0 80            	iret
10299                     ; 2218 main()
10299                     ; 2219 {
10301                     	switch	.text
10302  20f1               _main:
10306                     ; 2221 CLK->ECKR|=1;
10308  20f1 721050c1      	bset	20673,#0
10310  20f5               L5324:
10311                     ; 2222 while((CLK->ECKR & 2) == 0);
10313  20f5 c650c1        	ld	a,20673
10314  20f8 a502          	bcp	a,#2
10315  20fa 27f9          	jreq	L5324
10316                     ; 2223 CLK->SWCR|=2;
10318  20fc 721250c5      	bset	20677,#1
10319                     ; 2224 CLK->SWR=0xB4;
10321  2100 35b450c4      	mov	20676,#180
10322                     ; 2226 delay_ms(200);
10324  2104 ae00c8        	ldw	x,#200
10325  2107 cd011d        	call	_delay_ms
10327                     ; 2227 FLASH_DUKR=0xae;
10329  210a 35ae5064      	mov	_FLASH_DUKR,#174
10330                     ; 2228 FLASH_DUKR=0x56;
10332  210e 35565064      	mov	_FLASH_DUKR,#86
10333                     ; 2229 enableInterrupts();
10336  2112 9a            rim
10338                     ; 2232 adr_drv_v3();
10341  2113 cd11be        	call	_adr_drv_v3
10343                     ; 2236 t4_init();
10345  2116 cd1deb        	call	_t4_init
10347                     ; 2238 		GPIOG->DDR|=(1<<0);
10349  2119 72105020      	bset	20512,#0
10350                     ; 2239 		GPIOG->CR1|=(1<<0);
10352  211d 72105021      	bset	20513,#0
10353                     ; 2240 		GPIOG->CR2&=~(1<<0);	
10355  2121 72115022      	bres	20514,#0
10356                     ; 2243 		GPIOG->DDR&=~(1<<1);
10358  2125 72135020      	bres	20512,#1
10359                     ; 2244 		GPIOG->CR1|=(1<<1);
10361  2129 72125021      	bset	20513,#1
10362                     ; 2245 		GPIOG->CR2&=~(1<<1);
10364  212d 72135022      	bres	20514,#1
10365                     ; 2247 init_CAN();
10367  2131 cd1505        	call	_init_CAN
10369                     ; 2252 GPIOC->DDR|=(1<<1);
10371  2134 7212500c      	bset	20492,#1
10372                     ; 2253 GPIOC->CR1|=(1<<1);
10374  2138 7212500d      	bset	20493,#1
10375                     ; 2254 GPIOC->CR2|=(1<<1);
10377  213c 7212500e      	bset	20494,#1
10378                     ; 2256 GPIOC->DDR|=(1<<2);
10380  2140 7214500c      	bset	20492,#2
10381                     ; 2257 GPIOC->CR1|=(1<<2);
10383  2144 7214500d      	bset	20493,#2
10384                     ; 2258 GPIOC->CR2|=(1<<2);
10386  2148 7214500e      	bset	20494,#2
10387                     ; 2265 t1_init();
10389  214c cd1dfc        	call	_t1_init
10391                     ; 2267 GPIOA->DDR|=(1<<5);
10393  214f 721a5002      	bset	20482,#5
10394                     ; 2268 GPIOA->CR1|=(1<<5);
10396  2153 721a5003      	bset	20483,#5
10397                     ; 2269 GPIOA->CR2&=~(1<<5);
10399  2157 721b5004      	bres	20484,#5
10400                     ; 2275 GPIOB->DDR&=~(1<<3);
10402  215b 72175007      	bres	20487,#3
10403                     ; 2276 GPIOB->CR1&=~(1<<3);
10405  215f 72175008      	bres	20488,#3
10406                     ; 2277 GPIOB->CR2&=~(1<<3);
10408  2163 72175009      	bres	20489,#3
10409                     ; 2279 GPIOC->DDR|=(1<<3);
10411  2167 7216500c      	bset	20492,#3
10412                     ; 2280 GPIOC->CR1|=(1<<3);
10414  216b 7216500d      	bset	20493,#3
10415                     ; 2281 GPIOC->CR2|=(1<<3);
10417  216f 7216500e      	bset	20494,#3
10418                     ; 2284 if(bps_class==bpsIPS) 
10420  2173 b604          	ld	a,_bps_class
10421  2175 a101          	cp	a,#1
10422  2177               L3424:
10423                     ; 2292 	if(b1000Hz)
10425                     	btst	_b1000Hz
10426  217c 2407          	jruge	L7424
10427                     ; 2294 		b1000Hz=0;
10429  217e 72110004      	bres	_b1000Hz
10430                     ; 2296 		adc2_init();
10432  2182 cd1e39        	call	_adc2_init
10434  2185               L7424:
10435                     ; 2299 	if(bCAN_RX)
10437  2185 3d04          	tnz	_bCAN_RX
10438  2187 2705          	jreq	L1524
10439                     ; 2301 		bCAN_RX=0;
10441  2189 3f04          	clr	_bCAN_RX
10442                     ; 2302 		can_in_an();	
10444  218b cd1710        	call	_can_in_an
10446  218e               L1524:
10447                     ; 2304 	if(b100Hz)
10449                     	btst	_b100Hz
10450  2193 2407          	jruge	L3524
10451                     ; 2306 		b100Hz=0;
10453  2195 72110009      	bres	_b100Hz
10454                     ; 2316 		can_tx_hndl();
10456  2199 cd15f8        	call	_can_tx_hndl
10458  219c               L3524:
10459                     ; 2319 	if(b10Hz)
10461                     	btst	_b10Hz
10462  21a1 2428          	jruge	L5524
10463                     ; 2321 		b10Hz=0;
10465  21a3 72110008      	bres	_b10Hz
10466                     ; 2323 		matemat();
10468  21a7 cd0c77        	call	_matemat
10470                     ; 2324 		led_drv(); 
10472  21aa cd0805        	call	_led_drv
10474                     ; 2325 	  link_drv();
10476  21ad cd08f3        	call	_link_drv
10478                     ; 2327 	  JP_drv();
10480  21b0 cd0868        	call	_JP_drv
10482                     ; 2328 	  flags_drv();
10484  21b3 cd1173        	call	_flags_drv
10486                     ; 2329 		net_drv();
10488  21b6 cd1662        	call	_net_drv
10490                     ; 2330 		if(main_cnt<100)main_cnt++;
10492  21b9 9c            	rvf
10493  21ba ce0255        	ldw	x,_main_cnt
10494  21bd a30064        	cpw	x,#100
10495  21c0 2e09          	jrsge	L5524
10498  21c2 ce0255        	ldw	x,_main_cnt
10499  21c5 1c0001        	addw	x,#1
10500  21c8 cf0255        	ldw	_main_cnt,x
10501  21cb               L5524:
10502                     ; 2333 	if(b5Hz)
10504                     	btst	_b5Hz
10505  21d0 240d          	jruge	L1624
10506                     ; 2335 		b5Hz=0;
10508  21d2 72110007      	bres	_b5Hz
10509                     ; 2337 		pwr_drv();		//воздействие на силу
10511  21d6 cd0ab0        	call	_pwr_drv
10513                     ; 2338 		led_hndl();
10515  21d9 cd015f        	call	_led_hndl
10517                     ; 2340 		vent_drv();
10519  21dc cd094b        	call	_vent_drv
10521  21df               L1624:
10522                     ; 2343 	if(b2Hz)
10524                     	btst	_b2Hz
10525  21e4 2404          	jruge	L3624
10526                     ; 2345 		b2Hz=0;
10528  21e6 72110006      	bres	_b2Hz
10529  21ea               L3624:
10530                     ; 2354 	if(b1Hz)
10532                     	btst	_b1Hz
10533  21ef 2486          	jruge	L3424
10534                     ; 2356 		b1Hz=0;
10536  21f1 72110005      	bres	_b1Hz
10537                     ; 2358 	  pwr_hndl();		//вычисление воздействий на силу
10539  21f5 cd0af7        	call	_pwr_hndl
10541                     ; 2359 		temper_drv();			//вычисление аварий температуры
10543  21f8 cd0e9d        	call	_temper_drv
10545                     ; 2361           x_drv();
10547  21fb cd105a        	call	_x_drv
10549                     ; 2362           if(main_cnt<1000)main_cnt++;
10551  21fe 9c            	rvf
10552  21ff ce0255        	ldw	x,_main_cnt
10553  2202 a303e8        	cpw	x,#1000
10554  2205 2e09          	jrsge	L7624
10557  2207 ce0255        	ldw	x,_main_cnt
10558  220a 1c0001        	addw	x,#1
10559  220d cf0255        	ldw	_main_cnt,x
10560  2210               L7624:
10561                     ; 2363   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10563  2210 b663          	ld	a,_link
10564  2212 a1aa          	cp	a,#170
10565  2214 2706          	jreq	L3724
10567  2216 b64a          	ld	a,_jp_mode
10568  2218 a103          	cp	a,#3
10569  221a 2603          	jrne	L1724
10570  221c               L3724:
10573  221c cd10d4        	call	_apv_hndl
10575  221f               L1724:
10576                     ; 2366   		can_error_cnt++;
10578  221f 3c69          	inc	_can_error_cnt
10579                     ; 2367   		if(can_error_cnt>=10)
10581  2221 b669          	ld	a,_can_error_cnt
10582  2223 a10a          	cp	a,#10
10583  2225 2505          	jrult	L5724
10584                     ; 2369   			can_error_cnt=0;
10586  2227 3f69          	clr	_can_error_cnt
10587                     ; 2370 			init_CAN();
10589  2229 cd1505        	call	_init_CAN
10591  222c               L5724:
10592                     ; 2374 		volum_u_main_drv();
10594  222c cd13ae        	call	_volum_u_main_drv
10596                     ; 2376 		pwm_stat++;
10598  222f 3c07          	inc	_pwm_stat
10599                     ; 2377 		if(pwm_stat>=10)pwm_stat=0;
10601  2231 b607          	ld	a,_pwm_stat
10602  2233 a10a          	cp	a,#10
10603  2235 2502          	jrult	L7724
10606  2237 3f07          	clr	_pwm_stat
10607  2239               L7724:
10608                     ; 2378 adc_plazma_short++;
10610  2239 beb9          	ldw	x,_adc_plazma_short
10611  223b 1c0001        	addw	x,#1
10612  223e bfb9          	ldw	_adc_plazma_short,x
10613                     ; 2380 		vent_resurs_hndl();
10615  2240 cd0000        	call	_vent_resurs_hndl
10617  2243 ac772177      	jpf	L3424
11826                     	xdef	_main
11827                     	xdef	f_ADC2_EOC_Interrupt
11828                     	xdef	f_CAN_TX_Interrupt
11829                     	xdef	f_CAN_RX_Interrupt
11830                     	xdef	f_TIM4_UPD_Interrupt
11831                     	xdef	_adc2_init
11832                     	xdef	_t1_init
11833                     	xdef	_t4_init
11834                     	xdef	_can_in_an
11835                     	xdef	_net_drv
11836                     	xdef	_can_tx_hndl
11837                     	xdef	_can_transmit
11838                     	xdef	_init_CAN
11839                     	xdef	_volum_u_main_drv
11840                     	xdef	_adr_drv_v3
11841                     	xdef	_adr_drv_v4
11842                     	xdef	_flags_drv
11843                     	xdef	_apv_hndl
11844                     	xdef	_apv_stop
11845                     	xdef	_apv_start
11846                     	xdef	_x_drv
11847                     	xdef	_u_drv
11848                     	xdef	_temper_drv
11849                     	xdef	_matemat
11850                     	xdef	_pwr_hndl
11851                     	xdef	_pwr_drv
11852                     	xdef	_vent_drv
11853                     	xdef	_link_drv
11854                     	xdef	_JP_drv
11855                     	xdef	_led_drv
11856                     	xdef	_led_hndl
11857                     	xdef	_delay_ms
11858                     	xdef	_granee
11859                     	xdef	_gran
11860                     	xdef	_vent_resurs_hndl
11861                     	switch	.ubsct
11862  0001               _vent_resurs_tx_cnt:
11863  0001 00            	ds.b	1
11864                     	xdef	_vent_resurs_tx_cnt
11865                     	switch	.bss
11866  0000               _vent_resurs_buff:
11867  0000 00000000      	ds.b	4
11868                     	xdef	_vent_resurs_buff
11869                     	switch	.ubsct
11870  0002               _vent_resurs_sec_cnt:
11871  0002 0000          	ds.b	2
11872                     	xdef	_vent_resurs_sec_cnt
11873                     .eeprom:	section	.data
11874  0000               _vent_resurs:
11875  0000 0000          	ds.b	2
11876                     	xdef	_vent_resurs
11877  0002               _ee_IMAXVENT:
11878  0002 0000          	ds.b	2
11879                     	xdef	_ee_IMAXVENT
11880                     	switch	.ubsct
11881  0004               _bps_class:
11882  0004 00            	ds.b	1
11883                     	xdef	_bps_class
11884  0005               _vent_pwm:
11885  0005 0000          	ds.b	2
11886                     	xdef	_vent_pwm
11887  0007               _pwm_stat:
11888  0007 00            	ds.b	1
11889                     	xdef	_pwm_stat
11890  0008               _pwm_vent_cnt:
11891  0008 00            	ds.b	1
11892                     	xdef	_pwm_vent_cnt
11893                     	switch	.eeprom
11894  0004               _ee_DEVICE:
11895  0004 0000          	ds.b	2
11896                     	xdef	_ee_DEVICE
11897  0006               _ee_AVT_MODE:
11898  0006 0000          	ds.b	2
11899                     	xdef	_ee_AVT_MODE
11900                     	switch	.ubsct
11901  0009               _i_main_bps_cnt:
11902  0009 000000000000  	ds.b	6
11903                     	xdef	_i_main_bps_cnt
11904  000f               _i_main_sigma:
11905  000f 0000          	ds.b	2
11906                     	xdef	_i_main_sigma
11907  0011               _i_main_num_of_bps:
11908  0011 00            	ds.b	1
11909                     	xdef	_i_main_num_of_bps
11910  0012               _i_main_avg:
11911  0012 0000          	ds.b	2
11912                     	xdef	_i_main_avg
11913  0014               _i_main_flag:
11914  0014 000000000000  	ds.b	6
11915                     	xdef	_i_main_flag
11916  001a               _i_main:
11917  001a 000000000000  	ds.b	12
11918                     	xdef	_i_main
11919  0026               _x:
11920  0026 000000000000  	ds.b	12
11921                     	xdef	_x
11922                     	xdef	_volum_u_main_
11923                     	switch	.eeprom
11924  0008               _UU_AVT:
11925  0008 0000          	ds.b	2
11926                     	xdef	_UU_AVT
11927                     	switch	.ubsct
11928  0032               _cnt_net_drv:
11929  0032 00            	ds.b	1
11930                     	xdef	_cnt_net_drv
11931                     	switch	.bit
11932  0001               _bMAIN:
11933  0001 00            	ds.b	1
11934                     	xdef	_bMAIN
11935                     	switch	.ubsct
11936  0033               _plazma_int:
11937  0033 000000000000  	ds.b	6
11938                     	xdef	_plazma_int
11939                     	xdef	_rotor_int
11940  0039               _led_green_buff:
11941  0039 00000000      	ds.b	4
11942                     	xdef	_led_green_buff
11943  003d               _led_red_buff:
11944  003d 00000000      	ds.b	4
11945                     	xdef	_led_red_buff
11946                     	xdef	_led_drv_cnt
11947                     	xdef	_led_green
11948                     	xdef	_led_red
11949  0041               _res_fl_cnt:
11950  0041 00            	ds.b	1
11951                     	xdef	_res_fl_cnt
11952                     	xdef	_bRES_
11953                     	xdef	_bRES
11954                     	switch	.eeprom
11955  000a               _res_fl_:
11956  000a 00            	ds.b	1
11957                     	xdef	_res_fl_
11958  000b               _res_fl:
11959  000b 00            	ds.b	1
11960                     	xdef	_res_fl
11961                     	switch	.ubsct
11962  0042               _cnt_apv_off:
11963  0042 00            	ds.b	1
11964                     	xdef	_cnt_apv_off
11965                     	switch	.bit
11966  0002               _bAPV:
11967  0002 00            	ds.b	1
11968                     	xdef	_bAPV
11969                     	switch	.ubsct
11970  0043               _apv_cnt_:
11971  0043 0000          	ds.b	2
11972                     	xdef	_apv_cnt_
11973  0045               _apv_cnt:
11974  0045 000000        	ds.b	3
11975                     	xdef	_apv_cnt
11976                     	xdef	_bBL_IPS
11977                     	switch	.bit
11978  0003               _bBL:
11979  0003 00            	ds.b	1
11980                     	xdef	_bBL
11981                     	switch	.ubsct
11982  0048               _cnt_JP1:
11983  0048 00            	ds.b	1
11984                     	xdef	_cnt_JP1
11985  0049               _cnt_JP0:
11986  0049 00            	ds.b	1
11987                     	xdef	_cnt_JP0
11988  004a               _jp_mode:
11989  004a 00            	ds.b	1
11990                     	xdef	_jp_mode
11991  004b               _pwm_u_:
11992  004b 0000          	ds.b	2
11993                     	xdef	_pwm_u_
11994                     	xdef	_pwm_i
11995                     	xdef	_pwm_u
11996  004d               _tmax_cnt:
11997  004d 0000          	ds.b	2
11998                     	xdef	_tmax_cnt
11999  004f               _tsign_cnt:
12000  004f 0000          	ds.b	2
12001                     	xdef	_tsign_cnt
12002                     	switch	.eeprom
12003  000c               _ee_UAVT:
12004  000c 0000          	ds.b	2
12005                     	xdef	_ee_UAVT
12006  000e               _ee_tsign:
12007  000e 0000          	ds.b	2
12008                     	xdef	_ee_tsign
12009  0010               _ee_tmax:
12010  0010 0000          	ds.b	2
12011                     	xdef	_ee_tmax
12012  0012               _ee_dU:
12013  0012 0000          	ds.b	2
12014                     	xdef	_ee_dU
12015  0014               _ee_Umax:
12016  0014 0000          	ds.b	2
12017                     	xdef	_ee_Umax
12018  0016               _ee_TZAS:
12019  0016 0000          	ds.b	2
12020                     	xdef	_ee_TZAS
12021                     	switch	.ubsct
12022  0051               _main_cnt1:
12023  0051 0000          	ds.b	2
12024                     	xdef	_main_cnt1
12025  0053               _off_bp_cnt:
12026  0053 00            	ds.b	1
12027                     	xdef	_off_bp_cnt
12028                     	xdef	_vol_i_temp_avar
12029  0054               _flags_tu_cnt_off:
12030  0054 00            	ds.b	1
12031                     	xdef	_flags_tu_cnt_off
12032  0055               _flags_tu_cnt_on:
12033  0055 00            	ds.b	1
12034                     	xdef	_flags_tu_cnt_on
12035  0056               _vol_i_temp:
12036  0056 0000          	ds.b	2
12037                     	xdef	_vol_i_temp
12038  0058               _vol_u_temp:
12039  0058 0000          	ds.b	2
12040                     	xdef	_vol_u_temp
12041                     	switch	.eeprom
12042  0018               __x_ee_:
12043  0018 0000          	ds.b	2
12044                     	xdef	__x_ee_
12045                     	switch	.ubsct
12046  005a               __x_cnt:
12047  005a 0000          	ds.b	2
12048                     	xdef	__x_cnt
12049  005c               __x__:
12050  005c 0000          	ds.b	2
12051                     	xdef	__x__
12052  005e               __x_:
12053  005e 0000          	ds.b	2
12054                     	xdef	__x_
12055  0060               _flags_tu:
12056  0060 00            	ds.b	1
12057                     	xdef	_flags_tu
12058                     	xdef	_flags
12059  0061               _link_cnt:
12060  0061 0000          	ds.b	2
12061                     	xdef	_link_cnt
12062  0063               _link:
12063  0063 00            	ds.b	1
12064                     	xdef	_link
12065  0064               _umin_cnt:
12066  0064 0000          	ds.b	2
12067                     	xdef	_umin_cnt
12068  0066               _umax_cnt:
12069  0066 0000          	ds.b	2
12070                     	xdef	_umax_cnt
12071                     	switch	.eeprom
12072  001a               _ee_K:
12073  001a 000000000000  	ds.b	20
12074                     	xdef	_ee_K
12075                     	switch	.ubsct
12076  0068               _T:
12077  0068 00            	ds.b	1
12078                     	xdef	_T
12079                     	switch	.bss
12080  0004               _Uin:
12081  0004 0000          	ds.b	2
12082                     	xdef	_Uin
12083  0006               _Usum:
12084  0006 0000          	ds.b	2
12085                     	xdef	_Usum
12086  0008               _U_out_const:
12087  0008 0000          	ds.b	2
12088                     	xdef	_U_out_const
12089  000a               _Unecc:
12090  000a 0000          	ds.b	2
12091                     	xdef	_Unecc
12092  000c               _Udb:
12093  000c 0000          	ds.b	2
12094                     	xdef	_Udb
12095  000e               _Ui:
12096  000e 0000          	ds.b	2
12097                     	xdef	_Ui
12098  0010               _Un:
12099  0010 0000          	ds.b	2
12100                     	xdef	_Un
12101  0012               _I:
12102  0012 0000          	ds.b	2
12103                     	xdef	_I
12104                     	switch	.ubsct
12105  0069               _can_error_cnt:
12106  0069 00            	ds.b	1
12107                     	xdef	_can_error_cnt
12108                     	xdef	_bCAN_RX
12109  006a               _tx_busy_cnt:
12110  006a 00            	ds.b	1
12111                     	xdef	_tx_busy_cnt
12112                     	xdef	_bTX_FREE
12113  006b               _can_buff_rd_ptr:
12114  006b 00            	ds.b	1
12115                     	xdef	_can_buff_rd_ptr
12116  006c               _can_buff_wr_ptr:
12117  006c 00            	ds.b	1
12118                     	xdef	_can_buff_wr_ptr
12119  006d               _can_out_buff:
12120  006d 000000000000  	ds.b	64
12121                     	xdef	_can_out_buff
12122                     	switch	.bss
12123  0014               _pwm_u_buff_cnt:
12124  0014 00            	ds.b	1
12125                     	xdef	_pwm_u_buff_cnt
12126  0015               _pwm_u_buff_ptr:
12127  0015 00            	ds.b	1
12128                     	xdef	_pwm_u_buff_ptr
12129  0016               _pwm_u_buff_:
12130  0016 0000          	ds.b	2
12131                     	xdef	_pwm_u_buff_
12132  0018               _pwm_u_buff:
12133  0018 000000000000  	ds.b	64
12134                     	xdef	_pwm_u_buff
12135                     	switch	.ubsct
12136  00ad               _adc_cnt_cnt:
12137  00ad 00            	ds.b	1
12138                     	xdef	_adc_cnt_cnt
12139                     	switch	.bss
12140  0058               _adc_buff_buff:
12141  0058 000000000000  	ds.b	160
12142                     	xdef	_adc_buff_buff
12143  00f8               _adress_error:
12144  00f8 00            	ds.b	1
12145                     	xdef	_adress_error
12146  00f9               _adress:
12147  00f9 00            	ds.b	1
12148                     	xdef	_adress
12149  00fa               _adr:
12150  00fa 000000        	ds.b	3
12151                     	xdef	_adr
12152                     	xdef	_adr_drv_stat
12153                     	xdef	_led_ind
12154                     	switch	.ubsct
12155  00ae               _led_ind_cnt:
12156  00ae 00            	ds.b	1
12157                     	xdef	_led_ind_cnt
12158  00af               _adc_plazma:
12159  00af 000000000000  	ds.b	10
12160                     	xdef	_adc_plazma
12161  00b9               _adc_plazma_short:
12162  00b9 0000          	ds.b	2
12163                     	xdef	_adc_plazma_short
12164  00bb               _adc_cnt:
12165  00bb 00            	ds.b	1
12166                     	xdef	_adc_cnt
12167  00bc               _adc_ch:
12168  00bc 00            	ds.b	1
12169                     	xdef	_adc_ch
12170                     	switch	.bss
12171  00fd               _adc_buff_1:
12172  00fd 0000          	ds.b	2
12173                     	xdef	_adc_buff_1
12174  00ff               _adc_buff_5:
12175  00ff 0000          	ds.b	2
12176                     	xdef	_adc_buff_5
12177  0101               _adc_buff_:
12178  0101 000000000000  	ds.b	20
12179                     	xdef	_adc_buff_
12180  0115               _adc_buff:
12181  0115 000000000000  	ds.b	320
12182                     	xdef	_adc_buff
12183  0255               _main_cnt:
12184  0255 0000          	ds.b	2
12185                     	xdef	_main_cnt
12186                     	switch	.ubsct
12187  00bd               _mess:
12188  00bd 000000000000  	ds.b	14
12189                     	xdef	_mess
12190                     	switch	.bit
12191  0004               _b1000Hz:
12192  0004 00            	ds.b	1
12193                     	xdef	_b1000Hz
12194  0005               _b1Hz:
12195  0005 00            	ds.b	1
12196                     	xdef	_b1Hz
12197  0006               _b2Hz:
12198  0006 00            	ds.b	1
12199                     	xdef	_b2Hz
12200  0007               _b5Hz:
12201  0007 00            	ds.b	1
12202                     	xdef	_b5Hz
12203  0008               _b10Hz:
12204  0008 00            	ds.b	1
12205                     	xdef	_b10Hz
12206  0009               _b100Hz:
12207  0009 00            	ds.b	1
12208                     	xdef	_b100Hz
12209                     	xdef	_t0_cnt4
12210                     	xdef	_t0_cnt3
12211                     	xdef	_t0_cnt2
12212                     	xdef	_t0_cnt1
12213                     	xdef	_t0_cnt0
12214                     	xdef	_t0_cnt00
12215                     	xref	_abs
12216                     	xdef	_bVENT_BLOCK
12217                     	xref.b	c_lreg
12218                     	xref.b	c_x
12219                     	xref.b	c_y
12239                     	xref	c_lrsh
12240                     	xref	c_umul
12241                     	xref	c_lgmul
12242                     	xref	c_lgsub
12243                     	xref	c_lgrsh
12244                     	xref	c_lgadd
12245                     	xref	c_ladd
12246                     	xref	c_lsbc
12247                     	xref	c_idiv
12248                     	xref	c_ldiv
12249                     	xref	c_itolx
12250                     	xref	c_eewrc
12251                     	xref	c_imul
12252                     	xref	c_ltor
12253                     	xref	c_lgadc
12254                     	xref	c_rtol
12255                     	xref	c_vmul
12256                     	xref	c_eewrw
12257                     	xref	c_lcmp
12258                     	xref	c_uitolx
12259                     	end
