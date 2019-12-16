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
2196  000c               _vol_i_temp_avar:
2197  000c 0000          	dc.w	0
2198  000e               _pwm_u:
2199  000e 00c8          	dc.w	200
2200  0010               _pwm_i:
2201  0010 0032          	dc.w	50
2202                     .bit:	section	.data,bit
2203  0000               _bBL:
2204  0000 01            	dc.b	1
2205  0001               _bBL_IPS:
2206  0001 00            	dc.b	0
2207                     	bsct
2208  0012               _bRES:
2209  0012 00            	dc.b	0
2210  0013               _bRES_:
2211  0013 00            	dc.b	0
2212  0014               _led_red:
2213  0014 00000000      	dc.l	0
2214  0018               _led_green:
2215  0018 03030303      	dc.l	50529027
2216  001c               _led_drv_cnt:
2217  001c 1e            	dc.b	30
2218  001d               _rotor_int:
2219  001d 007b          	dc.w	123
2220  001f               _volum_u_main_:
2221  001f 02bc          	dc.w	700
2266                     .const:	section	.text
2267  0000               L6:
2268  0000 0000ea60      	dc.l	60000
2269                     ; 178 void vent_resurs_hndl(void)
2269                     ; 179 {
2270                     	scross	off
2271                     	switch	.text
2272  0000               _vent_resurs_hndl:
2274  0000 88            	push	a
2275       00000001      OFST:	set	1
2278                     ; 181 if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
2280  0001 3d00          	tnz	_bVENT_BLOCK
2281  0003 2607          	jrne	L7441
2284  0005 be02          	ldw	x,_vent_resurs_sec_cnt
2285  0007 1c0001        	addw	x,#1
2286  000a bf02          	ldw	_vent_resurs_sec_cnt,x
2287  000c               L7441:
2288                     ; 182 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2290  000c be02          	ldw	x,_vent_resurs_sec_cnt
2291  000e a30e11        	cpw	x,#3601
2292  0011 251b          	jrult	L1541
2293                     ; 184 	if(vent_resurs<60000)vent_resurs++;
2295  0013 9c            	rvf
2296  0014 ce0000        	ldw	x,_vent_resurs
2297  0017 cd0000        	call	c_uitolx
2299  001a ae0000        	ldw	x,#L6
2300  001d cd0000        	call	c_lcmp
2302  0020 2e09          	jrsge	L3541
2305  0022 ce0000        	ldw	x,_vent_resurs
2306  0025 1c0001        	addw	x,#1
2307  0028 cf0000        	ldw	_vent_resurs,x
2308  002b               L3541:
2309                     ; 185 	vent_resurs_sec_cnt=0;
2311  002b 5f            	clrw	x
2312  002c bf02          	ldw	_vent_resurs_sec_cnt,x
2313  002e               L1541:
2314                     ; 190 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2316  002e c60001        	ld	a,_vent_resurs+1
2317  0031 a40f          	and	a,#15
2318  0033 c70000        	ld	_vent_resurs_buff,a
2319                     ; 191 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2321  0036 c60001        	ld	a,_vent_resurs+1
2322  0039 a4f0          	and	a,#240
2323  003b 4e            	swap	a
2324  003c a40f          	and	a,#15
2325  003e aa40          	or	a,#64
2326  0040 c70001        	ld	_vent_resurs_buff+1,a
2327                     ; 192 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2329  0043 c60000        	ld	a,_vent_resurs
2330  0046 97            	ld	xl,a
2331  0047 c60001        	ld	a,_vent_resurs+1
2332  004a 9f            	ld	a,xl
2333  004b a40f          	and	a,#15
2334  004d 97            	ld	xl,a
2335  004e 4f            	clr	a
2336  004f 02            	rlwa	x,a
2337  0050 4f            	clr	a
2338  0051 01            	rrwa	x,a
2339  0052 9f            	ld	a,xl
2340  0053 aa80          	or	a,#128
2341  0055 c70002        	ld	_vent_resurs_buff+2,a
2342                     ; 193 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2344  0058 c60000        	ld	a,_vent_resurs
2345  005b 97            	ld	xl,a
2346  005c c60001        	ld	a,_vent_resurs+1
2347  005f 9f            	ld	a,xl
2348  0060 a4f0          	and	a,#240
2349  0062 97            	ld	xl,a
2350  0063 4f            	clr	a
2351  0064 02            	rlwa	x,a
2352  0065 01            	rrwa	x,a
2353  0066 4f            	clr	a
2354  0067 41            	exg	a,xl
2355  0068 4e            	swap	a
2356  0069 a40f          	and	a,#15
2357  006b 02            	rlwa	x,a
2358  006c 9f            	ld	a,xl
2359  006d aac0          	or	a,#192
2360  006f c70003        	ld	_vent_resurs_buff+3,a
2361                     ; 195 temp=vent_resurs_buff[0]&0x0f;
2363  0072 c60000        	ld	a,_vent_resurs_buff
2364  0075 a40f          	and	a,#15
2365  0077 6b01          	ld	(OFST+0,sp),a
2366                     ; 196 temp^=vent_resurs_buff[1]&0x0f;
2368  0079 c60001        	ld	a,_vent_resurs_buff+1
2369  007c a40f          	and	a,#15
2370  007e 1801          	xor	a,(OFST+0,sp)
2371  0080 6b01          	ld	(OFST+0,sp),a
2372                     ; 197 temp^=vent_resurs_buff[2]&0x0f;
2374  0082 c60002        	ld	a,_vent_resurs_buff+2
2375  0085 a40f          	and	a,#15
2376  0087 1801          	xor	a,(OFST+0,sp)
2377  0089 6b01          	ld	(OFST+0,sp),a
2378                     ; 198 temp^=vent_resurs_buff[3]&0x0f;
2380  008b c60003        	ld	a,_vent_resurs_buff+3
2381  008e a40f          	and	a,#15
2382  0090 1801          	xor	a,(OFST+0,sp)
2383  0092 6b01          	ld	(OFST+0,sp),a
2384                     ; 200 vent_resurs_buff[0]|=(temp&0x03)<<4;
2386  0094 7b01          	ld	a,(OFST+0,sp)
2387  0096 a403          	and	a,#3
2388  0098 97            	ld	xl,a
2389  0099 a610          	ld	a,#16
2390  009b 42            	mul	x,a
2391  009c 9f            	ld	a,xl
2392  009d ca0000        	or	a,_vent_resurs_buff
2393  00a0 c70000        	ld	_vent_resurs_buff,a
2394                     ; 201 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2396  00a3 7b01          	ld	a,(OFST+0,sp)
2397  00a5 a40c          	and	a,#12
2398  00a7 48            	sll	a
2399  00a8 48            	sll	a
2400  00a9 ca0001        	or	a,_vent_resurs_buff+1
2401  00ac c70001        	ld	_vent_resurs_buff+1,a
2402                     ; 202 vent_resurs_buff[2]|=(temp&0x30);
2404  00af 7b01          	ld	a,(OFST+0,sp)
2405  00b1 a430          	and	a,#48
2406  00b3 ca0002        	or	a,_vent_resurs_buff+2
2407  00b6 c70002        	ld	_vent_resurs_buff+2,a
2408                     ; 203 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2410  00b9 7b01          	ld	a,(OFST+0,sp)
2411  00bb a4c0          	and	a,#192
2412  00bd 44            	srl	a
2413  00be 44            	srl	a
2414  00bf ca0003        	or	a,_vent_resurs_buff+3
2415  00c2 c70003        	ld	_vent_resurs_buff+3,a
2416                     ; 206 vent_resurs_tx_cnt++;
2418  00c5 3c01          	inc	_vent_resurs_tx_cnt
2419                     ; 207 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2421  00c7 b601          	ld	a,_vent_resurs_tx_cnt
2422  00c9 a104          	cp	a,#4
2423  00cb 2502          	jrult	L5541
2426  00cd 3f01          	clr	_vent_resurs_tx_cnt
2427  00cf               L5541:
2428                     ; 210 }
2431  00cf 84            	pop	a
2432  00d0 81            	ret
2485                     ; 213 void gran(signed short *adr, signed short min, signed short max)
2485                     ; 214 {
2486                     	switch	.text
2487  00d1               _gran:
2489  00d1 89            	pushw	x
2490       00000000      OFST:	set	0
2493                     ; 215 if (*adr<min) *adr=min;
2495  00d2 9c            	rvf
2496  00d3 9093          	ldw	y,x
2497  00d5 51            	exgw	x,y
2498  00d6 fe            	ldw	x,(x)
2499  00d7 1305          	cpw	x,(OFST+5,sp)
2500  00d9 51            	exgw	x,y
2501  00da 2e03          	jrsge	L5051
2504  00dc 1605          	ldw	y,(OFST+5,sp)
2505  00de ff            	ldw	(x),y
2506  00df               L5051:
2507                     ; 216 if (*adr>max) *adr=max; 
2509  00df 9c            	rvf
2510  00e0 1e01          	ldw	x,(OFST+1,sp)
2511  00e2 9093          	ldw	y,x
2512  00e4 51            	exgw	x,y
2513  00e5 fe            	ldw	x,(x)
2514  00e6 1307          	cpw	x,(OFST+7,sp)
2515  00e8 51            	exgw	x,y
2516  00e9 2d05          	jrsle	L7051
2519  00eb 1e01          	ldw	x,(OFST+1,sp)
2520  00ed 1607          	ldw	y,(OFST+7,sp)
2521  00ef ff            	ldw	(x),y
2522  00f0               L7051:
2523                     ; 217 } 
2526  00f0 85            	popw	x
2527  00f1 81            	ret
2580                     ; 220 void granee(@eeprom signed short *adr, signed short min, signed short max)
2580                     ; 221 {
2581                     	switch	.text
2582  00f2               _granee:
2584  00f2 89            	pushw	x
2585       00000000      OFST:	set	0
2588                     ; 222 if (*adr<min) *adr=min;
2590  00f3 9c            	rvf
2591  00f4 9093          	ldw	y,x
2592  00f6 51            	exgw	x,y
2593  00f7 fe            	ldw	x,(x)
2594  00f8 1305          	cpw	x,(OFST+5,sp)
2595  00fa 51            	exgw	x,y
2596  00fb 2e09          	jrsge	L7351
2599  00fd 1e05          	ldw	x,(OFST+5,sp)
2600  00ff 89            	pushw	x
2601  0100 1e03          	ldw	x,(OFST+3,sp)
2602  0102 cd0000        	call	c_eewrw
2604  0105 85            	popw	x
2605  0106               L7351:
2606                     ; 223 if (*adr>max) *adr=max; 
2608  0106 9c            	rvf
2609  0107 1e01          	ldw	x,(OFST+1,sp)
2610  0109 9093          	ldw	y,x
2611  010b 51            	exgw	x,y
2612  010c fe            	ldw	x,(x)
2613  010d 1307          	cpw	x,(OFST+7,sp)
2614  010f 51            	exgw	x,y
2615  0110 2d09          	jrsle	L1451
2618  0112 1e07          	ldw	x,(OFST+7,sp)
2619  0114 89            	pushw	x
2620  0115 1e03          	ldw	x,(OFST+3,sp)
2621  0117 cd0000        	call	c_eewrw
2623  011a 85            	popw	x
2624  011b               L1451:
2625                     ; 224 }
2628  011b 85            	popw	x
2629  011c 81            	ret
2690                     ; 227 long delay_ms(short in)
2690                     ; 228 {
2691                     	switch	.text
2692  011d               _delay_ms:
2694  011d 520c          	subw	sp,#12
2695       0000000c      OFST:	set	12
2698                     ; 231 i=((long)in)*100UL;
2700  011f 90ae0064      	ldw	y,#100
2701  0123 cd0000        	call	c_vmul
2703  0126 96            	ldw	x,sp
2704  0127 1c0005        	addw	x,#OFST-7
2705  012a cd0000        	call	c_rtol
2707                     ; 233 for(ii=0;ii<i;ii++)
2709  012d ae0000        	ldw	x,#0
2710  0130 1f0b          	ldw	(OFST-1,sp),x
2711  0132 ae0000        	ldw	x,#0
2712  0135 1f09          	ldw	(OFST-3,sp),x
2714  0137 2012          	jra	L1061
2715  0139               L5751:
2716                     ; 235 		iii++;
2718  0139 96            	ldw	x,sp
2719  013a 1c0001        	addw	x,#OFST-11
2720  013d a601          	ld	a,#1
2721  013f cd0000        	call	c_lgadc
2723                     ; 233 for(ii=0;ii<i;ii++)
2725  0142 96            	ldw	x,sp
2726  0143 1c0009        	addw	x,#OFST-3
2727  0146 a601          	ld	a,#1
2728  0148 cd0000        	call	c_lgadc
2730  014b               L1061:
2733  014b 9c            	rvf
2734  014c 96            	ldw	x,sp
2735  014d 1c0009        	addw	x,#OFST-3
2736  0150 cd0000        	call	c_ltor
2738  0153 96            	ldw	x,sp
2739  0154 1c0005        	addw	x,#OFST-7
2740  0157 cd0000        	call	c_lcmp
2742  015a 2fdd          	jrslt	L5751
2743                     ; 238 }
2746  015c 5b0c          	addw	sp,#12
2747  015e 81            	ret
2783                     ; 241 void led_hndl(void)
2783                     ; 242 {
2784                     	switch	.text
2785  015f               _led_hndl:
2789                     ; 243 if(adress_error)
2791  015f 725d0004      	tnz	_adress_error
2792  0163 2718          	jreq	L5161
2793                     ; 245 	led_red=0x55555555L;
2795  0165 ae5555        	ldw	x,#21845
2796  0168 bf16          	ldw	_led_red+2,x
2797  016a ae5555        	ldw	x,#21845
2798  016d bf14          	ldw	_led_red,x
2799                     ; 246 	led_green=0x55555555L;
2801  016f ae5555        	ldw	x,#21845
2802  0172 bf1a          	ldw	_led_green+2,x
2803  0174 ae5555        	ldw	x,#21845
2804  0177 bf18          	ldw	_led_green,x
2806  0179 ace107e1      	jpf	L7161
2807  017d               L5161:
2808                     ; 262 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2810  017d 3d04          	tnz	_bps_class
2811  017f 2703          	jreq	L02
2812  0181 cc0434        	jp	L1261
2813  0184               L02:
2814                     ; 264 	if(jp_mode!=jp3)
2816  0184 b64a          	ld	a,_jp_mode
2817  0186 a103          	cp	a,#3
2818  0188 2603          	jrne	L22
2819  018a cc0330        	jp	L3261
2820  018d               L22:
2821                     ; 266 		if(main_cnt1<(5*ee_TZAS))
2823  018d 9c            	rvf
2824  018e ce0016        	ldw	x,_ee_TZAS
2825  0191 90ae0005      	ldw	y,#5
2826  0195 cd0000        	call	c_imul
2828  0198 b34f          	cpw	x,_main_cnt1
2829  019a 2d18          	jrsle	L5261
2830                     ; 268 			led_red=0x00000000L;
2832  019c ae0000        	ldw	x,#0
2833  019f bf16          	ldw	_led_red+2,x
2834  01a1 ae0000        	ldw	x,#0
2835  01a4 bf14          	ldw	_led_red,x
2836                     ; 269 			led_green=0x03030303L;
2838  01a6 ae0303        	ldw	x,#771
2839  01a9 bf1a          	ldw	_led_green+2,x
2840  01ab ae0303        	ldw	x,#771
2841  01ae bf18          	ldw	_led_green,x
2843  01b0 acf102f1      	jpf	L7261
2844  01b4               L5261:
2845                     ; 272 		else if((link==ON)&&(flags_tu&0b10000000))
2847  01b4 b663          	ld	a,_link
2848  01b6 a155          	cp	a,#85
2849  01b8 261e          	jrne	L1361
2851  01ba b660          	ld	a,_flags_tu
2852  01bc a580          	bcp	a,#128
2853  01be 2718          	jreq	L1361
2854                     ; 274 			led_red=0x00055555L;
2856  01c0 ae5555        	ldw	x,#21845
2857  01c3 bf16          	ldw	_led_red+2,x
2858  01c5 ae0005        	ldw	x,#5
2859  01c8 bf14          	ldw	_led_red,x
2860                     ; 275 			led_green=0xffffffffL;
2862  01ca aeffff        	ldw	x,#65535
2863  01cd bf1a          	ldw	_led_green+2,x
2864  01cf aeffff        	ldw	x,#-1
2865  01d2 bf18          	ldw	_led_green,x
2867  01d4 acf102f1      	jpf	L7261
2868  01d8               L1361:
2869                     ; 278 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2871  01d8 9c            	rvf
2872  01d9 ce0016        	ldw	x,_ee_TZAS
2873  01dc 90ae0005      	ldw	y,#5
2874  01e0 cd0000        	call	c_imul
2876  01e3 b34f          	cpw	x,_main_cnt1
2877  01e5 2e37          	jrsge	L5361
2879  01e7 9c            	rvf
2880  01e8 ce0016        	ldw	x,_ee_TZAS
2881  01eb 90ae0005      	ldw	y,#5
2882  01ef cd0000        	call	c_imul
2884  01f2 1c0064        	addw	x,#100
2885  01f5 b34f          	cpw	x,_main_cnt1
2886  01f7 2d25          	jrsle	L5361
2888  01f9 ce0006        	ldw	x,_ee_AVT_MODE
2889  01fc a30055        	cpw	x,#85
2890  01ff 271d          	jreq	L5361
2892  0201 ce0004        	ldw	x,_ee_DEVICE
2893  0204 2618          	jrne	L5361
2894                     ; 280 			led_red=0x00000000L;
2896  0206 ae0000        	ldw	x,#0
2897  0209 bf16          	ldw	_led_red+2,x
2898  020b ae0000        	ldw	x,#0
2899  020e bf14          	ldw	_led_red,x
2900                     ; 281 			led_green=0xffffffffL;	
2902  0210 aeffff        	ldw	x,#65535
2903  0213 bf1a          	ldw	_led_green+2,x
2904  0215 aeffff        	ldw	x,#-1
2905  0218 bf18          	ldw	_led_green,x
2907  021a acf102f1      	jpf	L7261
2908  021e               L5361:
2909                     ; 284 		else  if(link==OFF)
2911  021e b663          	ld	a,_link
2912  0220 a1aa          	cp	a,#170
2913  0222 2618          	jrne	L1461
2914                     ; 286 			led_red=0x55555555L;
2916  0224 ae5555        	ldw	x,#21845
2917  0227 bf16          	ldw	_led_red+2,x
2918  0229 ae5555        	ldw	x,#21845
2919  022c bf14          	ldw	_led_red,x
2920                     ; 287 			led_green=0xffffffffL;
2922  022e aeffff        	ldw	x,#65535
2923  0231 bf1a          	ldw	_led_green+2,x
2924  0233 aeffff        	ldw	x,#-1
2925  0236 bf18          	ldw	_led_green,x
2927  0238 acf102f1      	jpf	L7261
2928  023c               L1461:
2929                     ; 290 		else if((link==ON)&&((flags&0b00111110)==0))
2931  023c b663          	ld	a,_link
2932  023e a155          	cp	a,#85
2933  0240 261d          	jrne	L5461
2935  0242 b60b          	ld	a,_flags
2936  0244 a53e          	bcp	a,#62
2937  0246 2617          	jrne	L5461
2938                     ; 292 			led_red=0x00000000L;
2940  0248 ae0000        	ldw	x,#0
2941  024b bf16          	ldw	_led_red+2,x
2942  024d ae0000        	ldw	x,#0
2943  0250 bf14          	ldw	_led_red,x
2944                     ; 293 			led_green=0xffffffffL;
2946  0252 aeffff        	ldw	x,#65535
2947  0255 bf1a          	ldw	_led_green+2,x
2948  0257 aeffff        	ldw	x,#-1
2949  025a bf18          	ldw	_led_green,x
2951  025c cc02f1        	jra	L7261
2952  025f               L5461:
2953                     ; 296 		else if((flags&0b00111110)==0b00000100)
2955  025f b60b          	ld	a,_flags
2956  0261 a43e          	and	a,#62
2957  0263 a104          	cp	a,#4
2958  0265 2616          	jrne	L1561
2959                     ; 298 			led_red=0x00010001L;
2961  0267 ae0001        	ldw	x,#1
2962  026a bf16          	ldw	_led_red+2,x
2963  026c ae0001        	ldw	x,#1
2964  026f bf14          	ldw	_led_red,x
2965                     ; 299 			led_green=0xffffffffL;	
2967  0271 aeffff        	ldw	x,#65535
2968  0274 bf1a          	ldw	_led_green+2,x
2969  0276 aeffff        	ldw	x,#-1
2970  0279 bf18          	ldw	_led_green,x
2972  027b 2074          	jra	L7261
2973  027d               L1561:
2974                     ; 301 		else if(flags&0b00000010)
2976  027d b60b          	ld	a,_flags
2977  027f a502          	bcp	a,#2
2978  0281 2716          	jreq	L5561
2979                     ; 303 			led_red=0x00010001L;
2981  0283 ae0001        	ldw	x,#1
2982  0286 bf16          	ldw	_led_red+2,x
2983  0288 ae0001        	ldw	x,#1
2984  028b bf14          	ldw	_led_red,x
2985                     ; 304 			led_green=0x00000000L;	
2987  028d ae0000        	ldw	x,#0
2988  0290 bf1a          	ldw	_led_green+2,x
2989  0292 ae0000        	ldw	x,#0
2990  0295 bf18          	ldw	_led_green,x
2992  0297 2058          	jra	L7261
2993  0299               L5561:
2994                     ; 306 		else if(flags&0b00001000)
2996  0299 b60b          	ld	a,_flags
2997  029b a508          	bcp	a,#8
2998  029d 2716          	jreq	L1661
2999                     ; 308 			led_red=0x00090009L;
3001  029f ae0009        	ldw	x,#9
3002  02a2 bf16          	ldw	_led_red+2,x
3003  02a4 ae0009        	ldw	x,#9
3004  02a7 bf14          	ldw	_led_red,x
3005                     ; 309 			led_green=0x00000000L;	
3007  02a9 ae0000        	ldw	x,#0
3008  02ac bf1a          	ldw	_led_green+2,x
3009  02ae ae0000        	ldw	x,#0
3010  02b1 bf18          	ldw	_led_green,x
3012  02b3 203c          	jra	L7261
3013  02b5               L1661:
3014                     ; 311 		else if(flags&0b00010000)
3016  02b5 b60b          	ld	a,_flags
3017  02b7 a510          	bcp	a,#16
3018  02b9 2716          	jreq	L5661
3019                     ; 313 			led_red=0x00490049L;
3021  02bb ae0049        	ldw	x,#73
3022  02be bf16          	ldw	_led_red+2,x
3023  02c0 ae0049        	ldw	x,#73
3024  02c3 bf14          	ldw	_led_red,x
3025                     ; 314 			led_green=0x00000000L;	
3027  02c5 ae0000        	ldw	x,#0
3028  02c8 bf1a          	ldw	_led_green+2,x
3029  02ca ae0000        	ldw	x,#0
3030  02cd bf18          	ldw	_led_green,x
3032  02cf 2020          	jra	L7261
3033  02d1               L5661:
3034                     ; 317 		else if((link==ON)&&(flags&0b00100000))
3036  02d1 b663          	ld	a,_link
3037  02d3 a155          	cp	a,#85
3038  02d5 261a          	jrne	L7261
3040  02d7 b60b          	ld	a,_flags
3041  02d9 a520          	bcp	a,#32
3042  02db 2714          	jreq	L7261
3043                     ; 319 			led_red=0x00000000L;
3045  02dd ae0000        	ldw	x,#0
3046  02e0 bf16          	ldw	_led_red+2,x
3047  02e2 ae0000        	ldw	x,#0
3048  02e5 bf14          	ldw	_led_red,x
3049                     ; 320 			led_green=0x00030003L;
3051  02e7 ae0003        	ldw	x,#3
3052  02ea bf1a          	ldw	_led_green+2,x
3053  02ec ae0003        	ldw	x,#3
3054  02ef bf18          	ldw	_led_green,x
3055  02f1               L7261:
3056                     ; 323 		if((jp_mode==jp1))
3058  02f1 b64a          	ld	a,_jp_mode
3059  02f3 a101          	cp	a,#1
3060  02f5 2618          	jrne	L3761
3061                     ; 325 			led_red=0x00000000L;
3063  02f7 ae0000        	ldw	x,#0
3064  02fa bf16          	ldw	_led_red+2,x
3065  02fc ae0000        	ldw	x,#0
3066  02ff bf14          	ldw	_led_red,x
3067                     ; 326 			led_green=0x33333333L;
3069  0301 ae3333        	ldw	x,#13107
3070  0304 bf1a          	ldw	_led_green+2,x
3071  0306 ae3333        	ldw	x,#13107
3072  0309 bf18          	ldw	_led_green,x
3074  030b ace107e1      	jpf	L7161
3075  030f               L3761:
3076                     ; 328 		else if((jp_mode==jp2))
3078  030f b64a          	ld	a,_jp_mode
3079  0311 a102          	cp	a,#2
3080  0313 2703          	jreq	L42
3081  0315 cc07e1        	jp	L7161
3082  0318               L42:
3083                     ; 330 			led_red=0xccccccccL;
3085  0318 aecccc        	ldw	x,#52428
3086  031b bf16          	ldw	_led_red+2,x
3087  031d aecccc        	ldw	x,#-13108
3088  0320 bf14          	ldw	_led_red,x
3089                     ; 331 			led_green=0x00000000L;
3091  0322 ae0000        	ldw	x,#0
3092  0325 bf1a          	ldw	_led_green+2,x
3093  0327 ae0000        	ldw	x,#0
3094  032a bf18          	ldw	_led_green,x
3095  032c ace107e1      	jpf	L7161
3096  0330               L3261:
3097                     ; 334 	else if(jp_mode==jp3)
3099  0330 b64a          	ld	a,_jp_mode
3100  0332 a103          	cp	a,#3
3101  0334 2703          	jreq	L62
3102  0336 cc07e1        	jp	L7161
3103  0339               L62:
3104                     ; 336 		if(main_cnt1<(5*ee_TZAS))
3106  0339 9c            	rvf
3107  033a ce0016        	ldw	x,_ee_TZAS
3108  033d 90ae0005      	ldw	y,#5
3109  0341 cd0000        	call	c_imul
3111  0344 b34f          	cpw	x,_main_cnt1
3112  0346 2d18          	jrsle	L5071
3113                     ; 338 			led_red=0x00000000L;
3115  0348 ae0000        	ldw	x,#0
3116  034b bf16          	ldw	_led_red+2,x
3117  034d ae0000        	ldw	x,#0
3118  0350 bf14          	ldw	_led_red,x
3119                     ; 339 			led_green=0x03030303L;
3121  0352 ae0303        	ldw	x,#771
3122  0355 bf1a          	ldw	_led_green+2,x
3123  0357 ae0303        	ldw	x,#771
3124  035a bf18          	ldw	_led_green,x
3126  035c ace107e1      	jpf	L7161
3127  0360               L5071:
3128                     ; 341 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3130  0360 9c            	rvf
3131  0361 ce0016        	ldw	x,_ee_TZAS
3132  0364 90ae0005      	ldw	y,#5
3133  0368 cd0000        	call	c_imul
3135  036b b34f          	cpw	x,_main_cnt1
3136  036d 2e2a          	jrsge	L1171
3138  036f 9c            	rvf
3139  0370 ce0016        	ldw	x,_ee_TZAS
3140  0373 90ae0005      	ldw	y,#5
3141  0377 cd0000        	call	c_imul
3143  037a 1c0046        	addw	x,#70
3144  037d b34f          	cpw	x,_main_cnt1
3145  037f 2d18          	jrsle	L1171
3146                     ; 343 			led_red=0x00000000L;
3148  0381 ae0000        	ldw	x,#0
3149  0384 bf16          	ldw	_led_red+2,x
3150  0386 ae0000        	ldw	x,#0
3151  0389 bf14          	ldw	_led_red,x
3152                     ; 344 			led_green=0xffffffffL;	
3154  038b aeffff        	ldw	x,#65535
3155  038e bf1a          	ldw	_led_green+2,x
3156  0390 aeffff        	ldw	x,#-1
3157  0393 bf18          	ldw	_led_green,x
3159  0395 ace107e1      	jpf	L7161
3160  0399               L1171:
3161                     ; 347 		else if((flags&0b00011110)==0)
3163  0399 b60b          	ld	a,_flags
3164  039b a51e          	bcp	a,#30
3165  039d 2618          	jrne	L5171
3166                     ; 349 			led_red=0x00000000L;
3168  039f ae0000        	ldw	x,#0
3169  03a2 bf16          	ldw	_led_red+2,x
3170  03a4 ae0000        	ldw	x,#0
3171  03a7 bf14          	ldw	_led_red,x
3172                     ; 350 			led_green=0xffffffffL;
3174  03a9 aeffff        	ldw	x,#65535
3175  03ac bf1a          	ldw	_led_green+2,x
3176  03ae aeffff        	ldw	x,#-1
3177  03b1 bf18          	ldw	_led_green,x
3179  03b3 ace107e1      	jpf	L7161
3180  03b7               L5171:
3181                     ; 354 		else if((flags&0b00111110)==0b00000100)
3183  03b7 b60b          	ld	a,_flags
3184  03b9 a43e          	and	a,#62
3185  03bb a104          	cp	a,#4
3186  03bd 2618          	jrne	L1271
3187                     ; 356 			led_red=0x00010001L;
3189  03bf ae0001        	ldw	x,#1
3190  03c2 bf16          	ldw	_led_red+2,x
3191  03c4 ae0001        	ldw	x,#1
3192  03c7 bf14          	ldw	_led_red,x
3193                     ; 357 			led_green=0xffffffffL;	
3195  03c9 aeffff        	ldw	x,#65535
3196  03cc bf1a          	ldw	_led_green+2,x
3197  03ce aeffff        	ldw	x,#-1
3198  03d1 bf18          	ldw	_led_green,x
3200  03d3 ace107e1      	jpf	L7161
3201  03d7               L1271:
3202                     ; 359 		else if(flags&0b00000010)
3204  03d7 b60b          	ld	a,_flags
3205  03d9 a502          	bcp	a,#2
3206  03db 2718          	jreq	L5271
3207                     ; 361 			led_red=0x00010001L;
3209  03dd ae0001        	ldw	x,#1
3210  03e0 bf16          	ldw	_led_red+2,x
3211  03e2 ae0001        	ldw	x,#1
3212  03e5 bf14          	ldw	_led_red,x
3213                     ; 362 			led_green=0x00000000L;	
3215  03e7 ae0000        	ldw	x,#0
3216  03ea bf1a          	ldw	_led_green+2,x
3217  03ec ae0000        	ldw	x,#0
3218  03ef bf18          	ldw	_led_green,x
3220  03f1 ace107e1      	jpf	L7161
3221  03f5               L5271:
3222                     ; 364 		else if(flags&0b00001000)
3224  03f5 b60b          	ld	a,_flags
3225  03f7 a508          	bcp	a,#8
3226  03f9 2718          	jreq	L1371
3227                     ; 366 			led_red=0x00090009L;
3229  03fb ae0009        	ldw	x,#9
3230  03fe bf16          	ldw	_led_red+2,x
3231  0400 ae0009        	ldw	x,#9
3232  0403 bf14          	ldw	_led_red,x
3233                     ; 367 			led_green=0x00000000L;	
3235  0405 ae0000        	ldw	x,#0
3236  0408 bf1a          	ldw	_led_green+2,x
3237  040a ae0000        	ldw	x,#0
3238  040d bf18          	ldw	_led_green,x
3240  040f ace107e1      	jpf	L7161
3241  0413               L1371:
3242                     ; 369 		else if(flags&0b00010000)
3244  0413 b60b          	ld	a,_flags
3245  0415 a510          	bcp	a,#16
3246  0417 2603          	jrne	L03
3247  0419 cc07e1        	jp	L7161
3248  041c               L03:
3249                     ; 371 			led_red=0x00490049L;
3251  041c ae0049        	ldw	x,#73
3252  041f bf16          	ldw	_led_red+2,x
3253  0421 ae0049        	ldw	x,#73
3254  0424 bf14          	ldw	_led_red,x
3255                     ; 372 			led_green=0xffffffffL;	
3257  0426 aeffff        	ldw	x,#65535
3258  0429 bf1a          	ldw	_led_green+2,x
3259  042b aeffff        	ldw	x,#-1
3260  042e bf18          	ldw	_led_green,x
3261  0430 ace107e1      	jpf	L7161
3262  0434               L1261:
3263                     ; 376 else if(bps_class==bpsIPS)	//если блок ИПСный
3265  0434 b604          	ld	a,_bps_class
3266  0436 a101          	cp	a,#1
3267  0438 2703          	jreq	L23
3268  043a cc07e1        	jp	L7161
3269  043d               L23:
3270                     ; 378 	if(jp_mode!=jp3)
3272  043d b64a          	ld	a,_jp_mode
3273  043f a103          	cp	a,#3
3274  0441 2603          	jrne	L43
3275  0443 cc06ed        	jp	L3471
3276  0446               L43:
3277                     ; 380 		if(main_cnt1<(5*ee_TZAS))
3279  0446 9c            	rvf
3280  0447 ce0016        	ldw	x,_ee_TZAS
3281  044a 90ae0005      	ldw	y,#5
3282  044e cd0000        	call	c_imul
3284  0451 b34f          	cpw	x,_main_cnt1
3285  0453 2d18          	jrsle	L5471
3286                     ; 382 			led_red=0x00000000L;
3288  0455 ae0000        	ldw	x,#0
3289  0458 bf16          	ldw	_led_red+2,x
3290  045a ae0000        	ldw	x,#0
3291  045d bf14          	ldw	_led_red,x
3292                     ; 383 			led_green=0x03030303L;
3294  045f ae0303        	ldw	x,#771
3295  0462 bf1a          	ldw	_led_green+2,x
3296  0464 ae0303        	ldw	x,#771
3297  0467 bf18          	ldw	_led_green,x
3299  0469 acae06ae      	jpf	L7471
3300  046d               L5471:
3301                     ; 386 		else if((link==ON)&&(flags_tu&0b10000000))
3303  046d b663          	ld	a,_link
3304  046f a155          	cp	a,#85
3305  0471 261e          	jrne	L1571
3307  0473 b660          	ld	a,_flags_tu
3308  0475 a580          	bcp	a,#128
3309  0477 2718          	jreq	L1571
3310                     ; 388 			led_red=0x00055555L;
3312  0479 ae5555        	ldw	x,#21845
3313  047c bf16          	ldw	_led_red+2,x
3314  047e ae0005        	ldw	x,#5
3315  0481 bf14          	ldw	_led_red,x
3316                     ; 389 			led_green=0xffffffffL;
3318  0483 aeffff        	ldw	x,#65535
3319  0486 bf1a          	ldw	_led_green+2,x
3320  0488 aeffff        	ldw	x,#-1
3321  048b bf18          	ldw	_led_green,x
3323  048d acae06ae      	jpf	L7471
3324  0491               L1571:
3325                     ; 392 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3327  0491 9c            	rvf
3328  0492 ce0016        	ldw	x,_ee_TZAS
3329  0495 90ae0005      	ldw	y,#5
3330  0499 cd0000        	call	c_imul
3332  049c b34f          	cpw	x,_main_cnt1
3333  049e 2e37          	jrsge	L5571
3335  04a0 9c            	rvf
3336  04a1 ce0016        	ldw	x,_ee_TZAS
3337  04a4 90ae0005      	ldw	y,#5
3338  04a8 cd0000        	call	c_imul
3340  04ab 1c0064        	addw	x,#100
3341  04ae b34f          	cpw	x,_main_cnt1
3342  04b0 2d25          	jrsle	L5571
3344  04b2 ce0006        	ldw	x,_ee_AVT_MODE
3345  04b5 a30055        	cpw	x,#85
3346  04b8 271d          	jreq	L5571
3348  04ba ce0004        	ldw	x,_ee_DEVICE
3349  04bd 2618          	jrne	L5571
3350                     ; 394 			led_red=0x00000000L;
3352  04bf ae0000        	ldw	x,#0
3353  04c2 bf16          	ldw	_led_red+2,x
3354  04c4 ae0000        	ldw	x,#0
3355  04c7 bf14          	ldw	_led_red,x
3356                     ; 395 			led_green=0xffffffffL;	
3358  04c9 aeffff        	ldw	x,#65535
3359  04cc bf1a          	ldw	_led_green+2,x
3360  04ce aeffff        	ldw	x,#-1
3361  04d1 bf18          	ldw	_led_green,x
3363  04d3 acae06ae      	jpf	L7471
3364  04d7               L5571:
3365                     ; 398 		else  if(link==OFF)
3367  04d7 b663          	ld	a,_link
3368  04d9 a1aa          	cp	a,#170
3369  04db 2703          	jreq	L63
3370  04dd cc05f9        	jp	L1671
3371  04e0               L63:
3372                     ; 400 			if((flags&0b00011110)==0)
3374  04e0 b60b          	ld	a,_flags
3375  04e2 a51e          	bcp	a,#30
3376  04e4 262d          	jrne	L3671
3377                     ; 402 				led_red=0x00000000L;
3379  04e6 ae0000        	ldw	x,#0
3380  04e9 bf16          	ldw	_led_red+2,x
3381  04eb ae0000        	ldw	x,#0
3382  04ee bf14          	ldw	_led_red,x
3383                     ; 403 				if(bMAIN)led_green=0xfffffff5L;
3385                     	btst	_bMAIN
3386  04f5 240e          	jruge	L5671
3389  04f7 aefff5        	ldw	x,#65525
3390  04fa bf1a          	ldw	_led_green+2,x
3391  04fc aeffff        	ldw	x,#-1
3392  04ff bf18          	ldw	_led_green,x
3394  0501 acae06ae      	jpf	L7471
3395  0505               L5671:
3396                     ; 404 				else led_green=0xffffffffL;
3398  0505 aeffff        	ldw	x,#65535
3399  0508 bf1a          	ldw	_led_green+2,x
3400  050a aeffff        	ldw	x,#-1
3401  050d bf18          	ldw	_led_green,x
3402  050f acae06ae      	jpf	L7471
3403  0513               L3671:
3404                     ; 407 			else if((flags&0b00111110)==0b00000100)
3406  0513 b60b          	ld	a,_flags
3407  0515 a43e          	and	a,#62
3408  0517 a104          	cp	a,#4
3409  0519 262d          	jrne	L3771
3410                     ; 409 				led_red=0x00010001L;
3412  051b ae0001        	ldw	x,#1
3413  051e bf16          	ldw	_led_red+2,x
3414  0520 ae0001        	ldw	x,#1
3415  0523 bf14          	ldw	_led_red,x
3416                     ; 410 				if(bMAIN)led_green=0xfffffff5L;
3418                     	btst	_bMAIN
3419  052a 240e          	jruge	L5771
3422  052c aefff5        	ldw	x,#65525
3423  052f bf1a          	ldw	_led_green+2,x
3424  0531 aeffff        	ldw	x,#-1
3425  0534 bf18          	ldw	_led_green,x
3427  0536 acae06ae      	jpf	L7471
3428  053a               L5771:
3429                     ; 411 				else led_green=0xffffffffL;	
3431  053a aeffff        	ldw	x,#65535
3432  053d bf1a          	ldw	_led_green+2,x
3433  053f aeffff        	ldw	x,#-1
3434  0542 bf18          	ldw	_led_green,x
3435  0544 acae06ae      	jpf	L7471
3436  0548               L3771:
3437                     ; 413 			else if(flags&0b00000010)
3439  0548 b60b          	ld	a,_flags
3440  054a a502          	bcp	a,#2
3441  054c 272d          	jreq	L3002
3442                     ; 415 				led_red=0x00010001L;
3444  054e ae0001        	ldw	x,#1
3445  0551 bf16          	ldw	_led_red+2,x
3446  0553 ae0001        	ldw	x,#1
3447  0556 bf14          	ldw	_led_red,x
3448                     ; 416 				if(bMAIN)led_green=0x00000005L;
3450                     	btst	_bMAIN
3451  055d 240e          	jruge	L5002
3454  055f ae0005        	ldw	x,#5
3455  0562 bf1a          	ldw	_led_green+2,x
3456  0564 ae0000        	ldw	x,#0
3457  0567 bf18          	ldw	_led_green,x
3459  0569 acae06ae      	jpf	L7471
3460  056d               L5002:
3461                     ; 417 				else led_green=0x00000000L;
3463  056d ae0000        	ldw	x,#0
3464  0570 bf1a          	ldw	_led_green+2,x
3465  0572 ae0000        	ldw	x,#0
3466  0575 bf18          	ldw	_led_green,x
3467  0577 acae06ae      	jpf	L7471
3468  057b               L3002:
3469                     ; 419 			else if(flags&0b00001000)
3471  057b b60b          	ld	a,_flags
3472  057d a508          	bcp	a,#8
3473  057f 272d          	jreq	L3102
3474                     ; 421 				led_red=0x00090009L;
3476  0581 ae0009        	ldw	x,#9
3477  0584 bf16          	ldw	_led_red+2,x
3478  0586 ae0009        	ldw	x,#9
3479  0589 bf14          	ldw	_led_red,x
3480                     ; 422 				if(bMAIN)led_green=0x00000005L;
3482                     	btst	_bMAIN
3483  0590 240e          	jruge	L5102
3486  0592 ae0005        	ldw	x,#5
3487  0595 bf1a          	ldw	_led_green+2,x
3488  0597 ae0000        	ldw	x,#0
3489  059a bf18          	ldw	_led_green,x
3491  059c acae06ae      	jpf	L7471
3492  05a0               L5102:
3493                     ; 423 				else led_green=0x00000000L;	
3495  05a0 ae0000        	ldw	x,#0
3496  05a3 bf1a          	ldw	_led_green+2,x
3497  05a5 ae0000        	ldw	x,#0
3498  05a8 bf18          	ldw	_led_green,x
3499  05aa acae06ae      	jpf	L7471
3500  05ae               L3102:
3501                     ; 425 			else if(flags&0b00010000)
3503  05ae b60b          	ld	a,_flags
3504  05b0 a510          	bcp	a,#16
3505  05b2 272d          	jreq	L3202
3506                     ; 427 				led_red=0x00490049L;
3508  05b4 ae0049        	ldw	x,#73
3509  05b7 bf16          	ldw	_led_red+2,x
3510  05b9 ae0049        	ldw	x,#73
3511  05bc bf14          	ldw	_led_red,x
3512                     ; 428 				if(bMAIN)led_green=0x00000005L;
3514                     	btst	_bMAIN
3515  05c3 240e          	jruge	L5202
3518  05c5 ae0005        	ldw	x,#5
3519  05c8 bf1a          	ldw	_led_green+2,x
3520  05ca ae0000        	ldw	x,#0
3521  05cd bf18          	ldw	_led_green,x
3523  05cf acae06ae      	jpf	L7471
3524  05d3               L5202:
3525                     ; 429 				else led_green=0x00000000L;	
3527  05d3 ae0000        	ldw	x,#0
3528  05d6 bf1a          	ldw	_led_green+2,x
3529  05d8 ae0000        	ldw	x,#0
3530  05db bf18          	ldw	_led_green,x
3531  05dd acae06ae      	jpf	L7471
3532  05e1               L3202:
3533                     ; 433 				led_red=0x55555555L;
3535  05e1 ae5555        	ldw	x,#21845
3536  05e4 bf16          	ldw	_led_red+2,x
3537  05e6 ae5555        	ldw	x,#21845
3538  05e9 bf14          	ldw	_led_red,x
3539                     ; 434 				led_green=0xffffffffL;
3541  05eb aeffff        	ldw	x,#65535
3542  05ee bf1a          	ldw	_led_green+2,x
3543  05f0 aeffff        	ldw	x,#-1
3544  05f3 bf18          	ldw	_led_green,x
3545  05f5 acae06ae      	jpf	L7471
3546  05f9               L1671:
3547                     ; 450 		else if((link==ON)&&((flags&0b00111110)==0))
3549  05f9 b663          	ld	a,_link
3550  05fb a155          	cp	a,#85
3551  05fd 261d          	jrne	L5302
3553  05ff b60b          	ld	a,_flags
3554  0601 a53e          	bcp	a,#62
3555  0603 2617          	jrne	L5302
3556                     ; 452 			led_red=0x00000000L;
3558  0605 ae0000        	ldw	x,#0
3559  0608 bf16          	ldw	_led_red+2,x
3560  060a ae0000        	ldw	x,#0
3561  060d bf14          	ldw	_led_red,x
3562                     ; 453 			led_green=0xffffffffL;
3564  060f aeffff        	ldw	x,#65535
3565  0612 bf1a          	ldw	_led_green+2,x
3566  0614 aeffff        	ldw	x,#-1
3567  0617 bf18          	ldw	_led_green,x
3569  0619 cc06ae        	jra	L7471
3570  061c               L5302:
3571                     ; 456 		else if((flags&0b00111110)==0b00000100)
3573  061c b60b          	ld	a,_flags
3574  061e a43e          	and	a,#62
3575  0620 a104          	cp	a,#4
3576  0622 2616          	jrne	L1402
3577                     ; 458 			led_red=0x00010001L;
3579  0624 ae0001        	ldw	x,#1
3580  0627 bf16          	ldw	_led_red+2,x
3581  0629 ae0001        	ldw	x,#1
3582  062c bf14          	ldw	_led_red,x
3583                     ; 459 			led_green=0xffffffffL;	
3585  062e aeffff        	ldw	x,#65535
3586  0631 bf1a          	ldw	_led_green+2,x
3587  0633 aeffff        	ldw	x,#-1
3588  0636 bf18          	ldw	_led_green,x
3590  0638 2074          	jra	L7471
3591  063a               L1402:
3592                     ; 461 		else if(flags&0b00000010)
3594  063a b60b          	ld	a,_flags
3595  063c a502          	bcp	a,#2
3596  063e 2716          	jreq	L5402
3597                     ; 463 			led_red=0x00010001L;
3599  0640 ae0001        	ldw	x,#1
3600  0643 bf16          	ldw	_led_red+2,x
3601  0645 ae0001        	ldw	x,#1
3602  0648 bf14          	ldw	_led_red,x
3603                     ; 464 			led_green=0x00000000L;	
3605  064a ae0000        	ldw	x,#0
3606  064d bf1a          	ldw	_led_green+2,x
3607  064f ae0000        	ldw	x,#0
3608  0652 bf18          	ldw	_led_green,x
3610  0654 2058          	jra	L7471
3611  0656               L5402:
3612                     ; 466 		else if(flags&0b00001000)
3614  0656 b60b          	ld	a,_flags
3615  0658 a508          	bcp	a,#8
3616  065a 2716          	jreq	L1502
3617                     ; 468 			led_red=0x00090009L;
3619  065c ae0009        	ldw	x,#9
3620  065f bf16          	ldw	_led_red+2,x
3621  0661 ae0009        	ldw	x,#9
3622  0664 bf14          	ldw	_led_red,x
3623                     ; 469 			led_green=0x00000000L;	
3625  0666 ae0000        	ldw	x,#0
3626  0669 bf1a          	ldw	_led_green+2,x
3627  066b ae0000        	ldw	x,#0
3628  066e bf18          	ldw	_led_green,x
3630  0670 203c          	jra	L7471
3631  0672               L1502:
3632                     ; 471 		else if(flags&0b00010000)
3634  0672 b60b          	ld	a,_flags
3635  0674 a510          	bcp	a,#16
3636  0676 2716          	jreq	L5502
3637                     ; 473 			led_red=0x00490049L;
3639  0678 ae0049        	ldw	x,#73
3640  067b bf16          	ldw	_led_red+2,x
3641  067d ae0049        	ldw	x,#73
3642  0680 bf14          	ldw	_led_red,x
3643                     ; 474 			led_green=0x00000000L;	
3645  0682 ae0000        	ldw	x,#0
3646  0685 bf1a          	ldw	_led_green+2,x
3647  0687 ae0000        	ldw	x,#0
3648  068a bf18          	ldw	_led_green,x
3650  068c 2020          	jra	L7471
3651  068e               L5502:
3652                     ; 477 		else if((link==ON)&&(flags&0b00100000))
3654  068e b663          	ld	a,_link
3655  0690 a155          	cp	a,#85
3656  0692 261a          	jrne	L7471
3658  0694 b60b          	ld	a,_flags
3659  0696 a520          	bcp	a,#32
3660  0698 2714          	jreq	L7471
3661                     ; 479 			led_red=0x00000000L;
3663  069a ae0000        	ldw	x,#0
3664  069d bf16          	ldw	_led_red+2,x
3665  069f ae0000        	ldw	x,#0
3666  06a2 bf14          	ldw	_led_red,x
3667                     ; 480 			led_green=0x00030003L;
3669  06a4 ae0003        	ldw	x,#3
3670  06a7 bf1a          	ldw	_led_green+2,x
3671  06a9 ae0003        	ldw	x,#3
3672  06ac bf18          	ldw	_led_green,x
3673  06ae               L7471:
3674                     ; 483 		if((jp_mode==jp1))
3676  06ae b64a          	ld	a,_jp_mode
3677  06b0 a101          	cp	a,#1
3678  06b2 2618          	jrne	L3602
3679                     ; 485 			led_red=0x00000000L;
3681  06b4 ae0000        	ldw	x,#0
3682  06b7 bf16          	ldw	_led_red+2,x
3683  06b9 ae0000        	ldw	x,#0
3684  06bc bf14          	ldw	_led_red,x
3685                     ; 486 			led_green=0x33333333L;
3687  06be ae3333        	ldw	x,#13107
3688  06c1 bf1a          	ldw	_led_green+2,x
3689  06c3 ae3333        	ldw	x,#13107
3690  06c6 bf18          	ldw	_led_green,x
3692  06c8 ace107e1      	jpf	L7161
3693  06cc               L3602:
3694                     ; 488 		else if((jp_mode==jp2))
3696  06cc b64a          	ld	a,_jp_mode
3697  06ce a102          	cp	a,#2
3698  06d0 2703          	jreq	L04
3699  06d2 cc07e1        	jp	L7161
3700  06d5               L04:
3701                     ; 492 			led_red=0xccccccccL;
3703  06d5 aecccc        	ldw	x,#52428
3704  06d8 bf16          	ldw	_led_red+2,x
3705  06da aecccc        	ldw	x,#-13108
3706  06dd bf14          	ldw	_led_red,x
3707                     ; 493 			led_green=0x00000000L;
3709  06df ae0000        	ldw	x,#0
3710  06e2 bf1a          	ldw	_led_green+2,x
3711  06e4 ae0000        	ldw	x,#0
3712  06e7 bf18          	ldw	_led_green,x
3713  06e9 ace107e1      	jpf	L7161
3714  06ed               L3471:
3715                     ; 496 	else if(jp_mode==jp3)
3717  06ed b64a          	ld	a,_jp_mode
3718  06ef a103          	cp	a,#3
3719  06f1 2703          	jreq	L24
3720  06f3 cc07e1        	jp	L7161
3721  06f6               L24:
3722                     ; 498 		if(main_cnt1<(5*ee_TZAS))
3724  06f6 9c            	rvf
3725  06f7 ce0016        	ldw	x,_ee_TZAS
3726  06fa 90ae0005      	ldw	y,#5
3727  06fe cd0000        	call	c_imul
3729  0701 b34f          	cpw	x,_main_cnt1
3730  0703 2d18          	jrsle	L5702
3731                     ; 500 			led_red=0x00000000L;
3733  0705 ae0000        	ldw	x,#0
3734  0708 bf16          	ldw	_led_red+2,x
3735  070a ae0000        	ldw	x,#0
3736  070d bf14          	ldw	_led_red,x
3737                     ; 501 			led_green=0x03030303L;
3739  070f ae0303        	ldw	x,#771
3740  0712 bf1a          	ldw	_led_green+2,x
3741  0714 ae0303        	ldw	x,#771
3742  0717 bf18          	ldw	_led_green,x
3744  0719 ace107e1      	jpf	L7161
3745  071d               L5702:
3746                     ; 503 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3748  071d 9c            	rvf
3749  071e ce0016        	ldw	x,_ee_TZAS
3750  0721 90ae0005      	ldw	y,#5
3751  0725 cd0000        	call	c_imul
3753  0728 b34f          	cpw	x,_main_cnt1
3754  072a 2e29          	jrsge	L1012
3756  072c 9c            	rvf
3757  072d ce0016        	ldw	x,_ee_TZAS
3758  0730 90ae0005      	ldw	y,#5
3759  0734 cd0000        	call	c_imul
3761  0737 1c0046        	addw	x,#70
3762  073a b34f          	cpw	x,_main_cnt1
3763  073c 2d17          	jrsle	L1012
3764                     ; 505 			led_red=0x00000000L;
3766  073e ae0000        	ldw	x,#0
3767  0741 bf16          	ldw	_led_red+2,x
3768  0743 ae0000        	ldw	x,#0
3769  0746 bf14          	ldw	_led_red,x
3770                     ; 506 			led_green=0xffffffffL;	
3772  0748 aeffff        	ldw	x,#65535
3773  074b bf1a          	ldw	_led_green+2,x
3774  074d aeffff        	ldw	x,#-1
3775  0750 bf18          	ldw	_led_green,x
3777  0752 cc07e1        	jra	L7161
3778  0755               L1012:
3779                     ; 509 		else if((flags&0b00011110)==0)
3781  0755 b60b          	ld	a,_flags
3782  0757 a51e          	bcp	a,#30
3783  0759 2616          	jrne	L5012
3784                     ; 511 			led_red=0x00000000L;
3786  075b ae0000        	ldw	x,#0
3787  075e bf16          	ldw	_led_red+2,x
3788  0760 ae0000        	ldw	x,#0
3789  0763 bf14          	ldw	_led_red,x
3790                     ; 512 			led_green=0xffffffffL;
3792  0765 aeffff        	ldw	x,#65535
3793  0768 bf1a          	ldw	_led_green+2,x
3794  076a aeffff        	ldw	x,#-1
3795  076d bf18          	ldw	_led_green,x
3797  076f 2070          	jra	L7161
3798  0771               L5012:
3799                     ; 516 		else if((flags&0b00111110)==0b00000100)
3801  0771 b60b          	ld	a,_flags
3802  0773 a43e          	and	a,#62
3803  0775 a104          	cp	a,#4
3804  0777 2616          	jrne	L1112
3805                     ; 518 			led_red=0x00010001L;
3807  0779 ae0001        	ldw	x,#1
3808  077c bf16          	ldw	_led_red+2,x
3809  077e ae0001        	ldw	x,#1
3810  0781 bf14          	ldw	_led_red,x
3811                     ; 519 			led_green=0xffffffffL;	
3813  0783 aeffff        	ldw	x,#65535
3814  0786 bf1a          	ldw	_led_green+2,x
3815  0788 aeffff        	ldw	x,#-1
3816  078b bf18          	ldw	_led_green,x
3818  078d 2052          	jra	L7161
3819  078f               L1112:
3820                     ; 521 		else if(flags&0b00000010)
3822  078f b60b          	ld	a,_flags
3823  0791 a502          	bcp	a,#2
3824  0793 2716          	jreq	L5112
3825                     ; 523 			led_red=0x00010001L;
3827  0795 ae0001        	ldw	x,#1
3828  0798 bf16          	ldw	_led_red+2,x
3829  079a ae0001        	ldw	x,#1
3830  079d bf14          	ldw	_led_red,x
3831                     ; 524 			led_green=0x00000000L;	
3833  079f ae0000        	ldw	x,#0
3834  07a2 bf1a          	ldw	_led_green+2,x
3835  07a4 ae0000        	ldw	x,#0
3836  07a7 bf18          	ldw	_led_green,x
3838  07a9 2036          	jra	L7161
3839  07ab               L5112:
3840                     ; 526 		else if(flags&0b00001000)
3842  07ab b60b          	ld	a,_flags
3843  07ad a508          	bcp	a,#8
3844  07af 2716          	jreq	L1212
3845                     ; 528 			led_red=0x00090009L;
3847  07b1 ae0009        	ldw	x,#9
3848  07b4 bf16          	ldw	_led_red+2,x
3849  07b6 ae0009        	ldw	x,#9
3850  07b9 bf14          	ldw	_led_red,x
3851                     ; 529 			led_green=0x00000000L;	
3853  07bb ae0000        	ldw	x,#0
3854  07be bf1a          	ldw	_led_green+2,x
3855  07c0 ae0000        	ldw	x,#0
3856  07c3 bf18          	ldw	_led_green,x
3858  07c5 201a          	jra	L7161
3859  07c7               L1212:
3860                     ; 531 		else if(flags&0b00010000)
3862  07c7 b60b          	ld	a,_flags
3863  07c9 a510          	bcp	a,#16
3864  07cb 2714          	jreq	L7161
3865                     ; 533 			led_red=0x00490049L;
3867  07cd ae0049        	ldw	x,#73
3868  07d0 bf16          	ldw	_led_red+2,x
3869  07d2 ae0049        	ldw	x,#73
3870  07d5 bf14          	ldw	_led_red,x
3871                     ; 534 			led_green=0xffffffffL;	
3873  07d7 aeffff        	ldw	x,#65535
3874  07da bf1a          	ldw	_led_green+2,x
3875  07dc aeffff        	ldw	x,#-1
3876  07df bf18          	ldw	_led_green,x
3877  07e1               L7161:
3878                     ; 538 }
3881  07e1 81            	ret
3909                     ; 541 void led_drv(void)
3909                     ; 542 {
3910                     	switch	.text
3911  07e2               _led_drv:
3915                     ; 544 GPIOA->DDR|=(1<<4);
3917  07e2 72185002      	bset	20482,#4
3918                     ; 545 GPIOA->CR1|=(1<<4);
3920  07e6 72185003      	bset	20483,#4
3921                     ; 546 GPIOA->CR2&=~(1<<4);
3923  07ea 72195004      	bres	20484,#4
3924                     ; 547 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3926  07ee b640          	ld	a,_led_red_buff+3
3927  07f0 a501          	bcp	a,#1
3928  07f2 2706          	jreq	L7312
3931  07f4 72185000      	bset	20480,#4
3933  07f8 2004          	jra	L1412
3934  07fa               L7312:
3935                     ; 548 else GPIOA->ODR&=~(1<<4); 
3937  07fa 72195000      	bres	20480,#4
3938  07fe               L1412:
3939                     ; 551 GPIOA->DDR|=(1<<5);
3941  07fe 721a5002      	bset	20482,#5
3942                     ; 552 GPIOA->CR1|=(1<<5);
3944  0802 721a5003      	bset	20483,#5
3945                     ; 553 GPIOA->CR2&=~(1<<5);	
3947  0806 721b5004      	bres	20484,#5
3948                     ; 554 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3950  080a b63c          	ld	a,_led_green_buff+3
3951  080c a501          	bcp	a,#1
3952  080e 2706          	jreq	L3412
3955  0810 721a5000      	bset	20480,#5
3957  0814 2004          	jra	L5412
3958  0816               L3412:
3959                     ; 555 else GPIOA->ODR&=~(1<<5);
3961  0816 721b5000      	bres	20480,#5
3962  081a               L5412:
3963                     ; 558 led_red_buff>>=1;
3965  081a 373d          	sra	_led_red_buff
3966  081c 363e          	rrc	_led_red_buff+1
3967  081e 363f          	rrc	_led_red_buff+2
3968  0820 3640          	rrc	_led_red_buff+3
3969                     ; 559 led_green_buff>>=1;
3971  0822 3739          	sra	_led_green_buff
3972  0824 363a          	rrc	_led_green_buff+1
3973  0826 363b          	rrc	_led_green_buff+2
3974  0828 363c          	rrc	_led_green_buff+3
3975                     ; 560 if(++led_drv_cnt>32)
3977  082a 3c1c          	inc	_led_drv_cnt
3978  082c b61c          	ld	a,_led_drv_cnt
3979  082e a121          	cp	a,#33
3980  0830 2512          	jrult	L7412
3981                     ; 562 	led_drv_cnt=0;
3983  0832 3f1c          	clr	_led_drv_cnt
3984                     ; 563 	led_red_buff=led_red;
3986  0834 be16          	ldw	x,_led_red+2
3987  0836 bf3f          	ldw	_led_red_buff+2,x
3988  0838 be14          	ldw	x,_led_red
3989  083a bf3d          	ldw	_led_red_buff,x
3990                     ; 564 	led_green_buff=led_green;
3992  083c be1a          	ldw	x,_led_green+2
3993  083e bf3b          	ldw	_led_green_buff+2,x
3994  0840 be18          	ldw	x,_led_green
3995  0842 bf39          	ldw	_led_green_buff,x
3996  0844               L7412:
3997                     ; 570 } 
4000  0844 81            	ret
4026                     ; 573 void JP_drv(void)
4026                     ; 574 {
4027                     	switch	.text
4028  0845               _JP_drv:
4032                     ; 576 GPIOD->DDR&=~(1<<6);
4034  0845 721d5011      	bres	20497,#6
4035                     ; 577 GPIOD->CR1|=(1<<6);
4037  0849 721c5012      	bset	20498,#6
4038                     ; 578 GPIOD->CR2&=~(1<<6);
4040  084d 721d5013      	bres	20499,#6
4041                     ; 580 GPIOD->DDR&=~(1<<7);
4043  0851 721f5011      	bres	20497,#7
4044                     ; 581 GPIOD->CR1|=(1<<7);
4046  0855 721e5012      	bset	20498,#7
4047                     ; 582 GPIOD->CR2&=~(1<<7);
4049  0859 721f5013      	bres	20499,#7
4050                     ; 584 if(GPIOD->IDR&(1<<6))
4052  085d c65010        	ld	a,20496
4053  0860 a540          	bcp	a,#64
4054  0862 270a          	jreq	L1612
4055                     ; 586 	if(cnt_JP0<10)
4057  0864 b649          	ld	a,_cnt_JP0
4058  0866 a10a          	cp	a,#10
4059  0868 2411          	jruge	L5612
4060                     ; 588 		cnt_JP0++;
4062  086a 3c49          	inc	_cnt_JP0
4063  086c 200d          	jra	L5612
4064  086e               L1612:
4065                     ; 591 else if(!(GPIOD->IDR&(1<<6)))
4067  086e c65010        	ld	a,20496
4068  0871 a540          	bcp	a,#64
4069  0873 2606          	jrne	L5612
4070                     ; 593 	if(cnt_JP0)
4072  0875 3d49          	tnz	_cnt_JP0
4073  0877 2702          	jreq	L5612
4074                     ; 595 		cnt_JP0--;
4076  0879 3a49          	dec	_cnt_JP0
4077  087b               L5612:
4078                     ; 599 if(GPIOD->IDR&(1<<7))
4080  087b c65010        	ld	a,20496
4081  087e a580          	bcp	a,#128
4082  0880 270a          	jreq	L3712
4083                     ; 601 	if(cnt_JP1<10)
4085  0882 b648          	ld	a,_cnt_JP1
4086  0884 a10a          	cp	a,#10
4087  0886 2411          	jruge	L7712
4088                     ; 603 		cnt_JP1++;
4090  0888 3c48          	inc	_cnt_JP1
4091  088a 200d          	jra	L7712
4092  088c               L3712:
4093                     ; 606 else if(!(GPIOD->IDR&(1<<7)))
4095  088c c65010        	ld	a,20496
4096  088f a580          	bcp	a,#128
4097  0891 2606          	jrne	L7712
4098                     ; 608 	if(cnt_JP1)
4100  0893 3d48          	tnz	_cnt_JP1
4101  0895 2702          	jreq	L7712
4102                     ; 610 		cnt_JP1--;
4104  0897 3a48          	dec	_cnt_JP1
4105  0899               L7712:
4106                     ; 615 if((cnt_JP0==10)&&(cnt_JP1==10))
4108  0899 b649          	ld	a,_cnt_JP0
4109  089b a10a          	cp	a,#10
4110  089d 2608          	jrne	L5022
4112  089f b648          	ld	a,_cnt_JP1
4113  08a1 a10a          	cp	a,#10
4114  08a3 2602          	jrne	L5022
4115                     ; 617 	jp_mode=jp0;
4117  08a5 3f4a          	clr	_jp_mode
4118  08a7               L5022:
4119                     ; 619 if((cnt_JP0==0)&&(cnt_JP1==10))
4121  08a7 3d49          	tnz	_cnt_JP0
4122  08a9 260a          	jrne	L7022
4124  08ab b648          	ld	a,_cnt_JP1
4125  08ad a10a          	cp	a,#10
4126  08af 2604          	jrne	L7022
4127                     ; 621 	jp_mode=jp1;
4129  08b1 3501004a      	mov	_jp_mode,#1
4130  08b5               L7022:
4131                     ; 623 if((cnt_JP0==10)&&(cnt_JP1==0))
4133  08b5 b649          	ld	a,_cnt_JP0
4134  08b7 a10a          	cp	a,#10
4135  08b9 2608          	jrne	L1122
4137  08bb 3d48          	tnz	_cnt_JP1
4138  08bd 2604          	jrne	L1122
4139                     ; 625 	jp_mode=jp2;
4141  08bf 3502004a      	mov	_jp_mode,#2
4142  08c3               L1122:
4143                     ; 627 if((cnt_JP0==0)&&(cnt_JP1==0))
4145  08c3 3d49          	tnz	_cnt_JP0
4146  08c5 2608          	jrne	L3122
4148  08c7 3d48          	tnz	_cnt_JP1
4149  08c9 2604          	jrne	L3122
4150                     ; 629 	jp_mode=jp3;
4152  08cb 3503004a      	mov	_jp_mode,#3
4153  08cf               L3122:
4154                     ; 632 }
4157  08cf 81            	ret
4189                     ; 635 void link_drv(void)		//10Hz
4189                     ; 636 {
4190                     	switch	.text
4191  08d0               _link_drv:
4195                     ; 637 if(jp_mode!=jp3)
4197  08d0 b64a          	ld	a,_jp_mode
4198  08d2 a103          	cp	a,#3
4199  08d4 274d          	jreq	L5222
4200                     ; 639 	if(link_cnt<602)link_cnt++;
4202  08d6 9c            	rvf
4203  08d7 be61          	ldw	x,_link_cnt
4204  08d9 a3025a        	cpw	x,#602
4205  08dc 2e07          	jrsge	L7222
4208  08de be61          	ldw	x,_link_cnt
4209  08e0 1c0001        	addw	x,#1
4210  08e3 bf61          	ldw	_link_cnt,x
4211  08e5               L7222:
4212                     ; 640 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4214  08e5 be61          	ldw	x,_link_cnt
4215  08e7 a3024e        	cpw	x,#590
4216  08ea 2606          	jrne	L1322
4219  08ec b60b          	ld	a,_flags
4220  08ee a4c1          	and	a,#193
4221  08f0 b70b          	ld	_flags,a
4222  08f2               L1322:
4223                     ; 641 	if(link_cnt==600)
4225  08f2 be61          	ldw	x,_link_cnt
4226  08f4 a30258        	cpw	x,#600
4227  08f7 262e          	jrne	L3422
4228                     ; 643 		link=OFF;
4230  08f9 35aa0063      	mov	_link,#170
4231                     ; 648 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4233  08fd b604          	ld	a,_bps_class
4234  08ff a101          	cp	a,#1
4235  0901 2606          	jrne	L5322
4238  0903 72100002      	bset	_bMAIN
4240  0907 2004          	jra	L7322
4241  0909               L5322:
4242                     ; 649 		else bMAIN=0;
4244  0909 72110002      	bres	_bMAIN
4245  090d               L7322:
4246                     ; 651 		cnt_net_drv=0;
4248  090d 3f32          	clr	_cnt_net_drv
4249                     ; 652     		if(!res_fl_)
4251  090f 725d000a      	tnz	_res_fl_
4252  0913 2612          	jrne	L3422
4253                     ; 654 	    		bRES_=1;
4255  0915 35010013      	mov	_bRES_,#1
4256                     ; 655 	    		res_fl_=1;
4258  0919 a601          	ld	a,#1
4259  091b ae000a        	ldw	x,#_res_fl_
4260  091e cd0000        	call	c_eewrc
4262  0921 2004          	jra	L3422
4263  0923               L5222:
4264                     ; 659 else link=OFF;	
4266  0923 35aa0063      	mov	_link,#170
4267  0927               L3422:
4268                     ; 660 } 
4271  0927 81            	ret
4341                     	switch	.const
4342  0004               L45:
4343  0004 0000000b      	dc.l	11
4344  0008               L65:
4345  0008 00000001      	dc.l	1
4346                     ; 664 void vent_drv(void)
4346                     ; 665 {
4347                     	switch	.text
4348  0928               _vent_drv:
4350  0928 520e          	subw	sp,#14
4351       0000000e      OFST:	set	14
4354                     ; 668 	short vent_pwm_i_necc=400;
4356  092a ae0190        	ldw	x,#400
4357  092d 1f07          	ldw	(OFST-7,sp),x
4358                     ; 669 	short vent_pwm_t_necc=400;
4360  092f ae0190        	ldw	x,#400
4361  0932 1f09          	ldw	(OFST-5,sp),x
4362                     ; 670 	short vent_pwm_max_necc=400;
4364                     ; 675 	tempSL=36000L/(signed long)ee_Umax;
4366  0934 ce0014        	ldw	x,_ee_Umax
4367  0937 cd0000        	call	c_itolx
4369  093a 96            	ldw	x,sp
4370  093b 1c0001        	addw	x,#OFST-13
4371  093e cd0000        	call	c_rtol
4373  0941 ae8ca0        	ldw	x,#36000
4374  0944 bf02          	ldw	c_lreg+2,x
4375  0946 ae0000        	ldw	x,#0
4376  0949 bf00          	ldw	c_lreg,x
4377  094b 96            	ldw	x,sp
4378  094c 1c0001        	addw	x,#OFST-13
4379  094f cd0000        	call	c_ldiv
4381  0952 96            	ldw	x,sp
4382  0953 1c000b        	addw	x,#OFST-3
4383  0956 cd0000        	call	c_rtol
4385                     ; 676 	tempSL=(signed long)I/tempSL;
4387  0959 be6f          	ldw	x,_I
4388  095b cd0000        	call	c_itolx
4390  095e 96            	ldw	x,sp
4391  095f 1c000b        	addw	x,#OFST-3
4392  0962 cd0000        	call	c_ldiv
4394  0965 96            	ldw	x,sp
4395  0966 1c000b        	addw	x,#OFST-3
4396  0969 cd0000        	call	c_rtol
4398                     ; 678 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4400  096c ce0004        	ldw	x,_ee_DEVICE
4401  096f a30001        	cpw	x,#1
4402  0972 2613          	jrne	L7722
4405  0974 be6f          	ldw	x,_I
4406  0976 90ce0002      	ldw	y,_ee_IMAXVENT
4407  097a cd0000        	call	c_idiv
4409  097d cd0000        	call	c_itolx
4411  0980 96            	ldw	x,sp
4412  0981 1c000b        	addw	x,#OFST-3
4413  0984 cd0000        	call	c_rtol
4415  0987               L7722:
4416                     ; 680 	if(tempSL>10)vent_pwm_i_necc=1000;
4418  0987 9c            	rvf
4419  0988 96            	ldw	x,sp
4420  0989 1c000b        	addw	x,#OFST-3
4421  098c cd0000        	call	c_ltor
4423  098f ae0004        	ldw	x,#L45
4424  0992 cd0000        	call	c_lcmp
4426  0995 2f07          	jrslt	L1032
4429  0997 ae03e8        	ldw	x,#1000
4430  099a 1f07          	ldw	(OFST-7,sp),x
4432  099c 2025          	jra	L3032
4433  099e               L1032:
4434                     ; 681 	else if(tempSL<1)vent_pwm_i_necc=400;
4436  099e 9c            	rvf
4437  099f 96            	ldw	x,sp
4438  09a0 1c000b        	addw	x,#OFST-3
4439  09a3 cd0000        	call	c_ltor
4441  09a6 ae0008        	ldw	x,#L65
4442  09a9 cd0000        	call	c_lcmp
4444  09ac 2e07          	jrsge	L5032
4447  09ae ae0190        	ldw	x,#400
4448  09b1 1f07          	ldw	(OFST-7,sp),x
4450  09b3 200e          	jra	L3032
4451  09b5               L5032:
4452                     ; 682 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4454  09b5 1e0d          	ldw	x,(OFST-1,sp)
4455  09b7 90ae003c      	ldw	y,#60
4456  09bb cd0000        	call	c_imul
4458  09be 1c0190        	addw	x,#400
4459  09c1 1f07          	ldw	(OFST-7,sp),x
4460  09c3               L3032:
4461                     ; 683 	gran(&vent_pwm_i_necc,400,1000);
4463  09c3 ae03e8        	ldw	x,#1000
4464  09c6 89            	pushw	x
4465  09c7 ae0190        	ldw	x,#400
4466  09ca 89            	pushw	x
4467  09cb 96            	ldw	x,sp
4468  09cc 1c000b        	addw	x,#OFST-3
4469  09cf cd00d1        	call	_gran
4471  09d2 5b04          	addw	sp,#4
4472                     ; 685 	tempSL=(signed long)T;
4474  09d4 b668          	ld	a,_T
4475  09d6 b703          	ld	c_lreg+3,a
4476  09d8 48            	sll	a
4477  09d9 4f            	clr	a
4478  09da a200          	sbc	a,#0
4479  09dc b702          	ld	c_lreg+2,a
4480  09de b701          	ld	c_lreg+1,a
4481  09e0 b700          	ld	c_lreg,a
4482  09e2 96            	ldw	x,sp
4483  09e3 1c000b        	addw	x,#OFST-3
4484  09e6 cd0000        	call	c_rtol
4486                     ; 686 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4488  09e9 9c            	rvf
4489  09ea ce000e        	ldw	x,_ee_tsign
4490  09ed cd0000        	call	c_itolx
4492  09f0 a61e          	ld	a,#30
4493  09f2 cd0000        	call	c_lsbc
4495  09f5 96            	ldw	x,sp
4496  09f6 1c000b        	addw	x,#OFST-3
4497  09f9 cd0000        	call	c_lcmp
4499  09fc 2f07          	jrslt	L1132
4502  09fe ae0190        	ldw	x,#400
4503  0a01 1f09          	ldw	(OFST-5,sp),x
4505  0a03 2030          	jra	L3132
4506  0a05               L1132:
4507                     ; 687 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4509  0a05 9c            	rvf
4510  0a06 ce000e        	ldw	x,_ee_tsign
4511  0a09 cd0000        	call	c_itolx
4513  0a0c 96            	ldw	x,sp
4514  0a0d 1c000b        	addw	x,#OFST-3
4515  0a10 cd0000        	call	c_lcmp
4517  0a13 2c07          	jrsgt	L5132
4520  0a15 ae03e8        	ldw	x,#1000
4521  0a18 1f09          	ldw	(OFST-5,sp),x
4523  0a1a 2019          	jra	L3132
4524  0a1c               L5132:
4525                     ; 688 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4527  0a1c ce000e        	ldw	x,_ee_tsign
4528  0a1f 1d001e        	subw	x,#30
4529  0a22 1f03          	ldw	(OFST-11,sp),x
4530  0a24 1e0d          	ldw	x,(OFST-1,sp)
4531  0a26 72f003        	subw	x,(OFST-11,sp)
4532  0a29 90ae0014      	ldw	y,#20
4533  0a2d cd0000        	call	c_imul
4535  0a30 1c0190        	addw	x,#400
4536  0a33 1f09          	ldw	(OFST-5,sp),x
4537  0a35               L3132:
4538                     ; 689 	gran(&vent_pwm_t_necc,400,1000);
4540  0a35 ae03e8        	ldw	x,#1000
4541  0a38 89            	pushw	x
4542  0a39 ae0190        	ldw	x,#400
4543  0a3c 89            	pushw	x
4544  0a3d 96            	ldw	x,sp
4545  0a3e 1c000d        	addw	x,#OFST-1
4546  0a41 cd00d1        	call	_gran
4548  0a44 5b04          	addw	sp,#4
4549                     ; 691 	vent_pwm_max_necc=vent_pwm_i_necc;
4551  0a46 1e07          	ldw	x,(OFST-7,sp)
4552  0a48 1f05          	ldw	(OFST-9,sp),x
4553                     ; 692 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4555  0a4a 9c            	rvf
4556  0a4b 1e09          	ldw	x,(OFST-5,sp)
4557  0a4d 1307          	cpw	x,(OFST-7,sp)
4558  0a4f 2d04          	jrsle	L1232
4561  0a51 1e09          	ldw	x,(OFST-5,sp)
4562  0a53 1f05          	ldw	(OFST-9,sp),x
4563  0a55               L1232:
4564                     ; 694 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4566  0a55 9c            	rvf
4567  0a56 be05          	ldw	x,_vent_pwm
4568  0a58 1305          	cpw	x,(OFST-9,sp)
4569  0a5a 2e07          	jrsge	L3232
4572  0a5c be05          	ldw	x,_vent_pwm
4573  0a5e 1c000a        	addw	x,#10
4574  0a61 bf05          	ldw	_vent_pwm,x
4575  0a63               L3232:
4576                     ; 695 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4578  0a63 9c            	rvf
4579  0a64 be05          	ldw	x,_vent_pwm
4580  0a66 1305          	cpw	x,(OFST-9,sp)
4581  0a68 2d07          	jrsle	L5232
4584  0a6a be05          	ldw	x,_vent_pwm
4585  0a6c 1d000a        	subw	x,#10
4586  0a6f bf05          	ldw	_vent_pwm,x
4587  0a71               L5232:
4588                     ; 696 	gran(&vent_pwm,400,1000);
4590  0a71 ae03e8        	ldw	x,#1000
4591  0a74 89            	pushw	x
4592  0a75 ae0190        	ldw	x,#400
4593  0a78 89            	pushw	x
4594  0a79 ae0005        	ldw	x,#_vent_pwm
4595  0a7c cd00d1        	call	_gran
4597  0a7f 5b04          	addw	sp,#4
4598                     ; 700 	if(bVENT_BLOCK)vent_pwm=0;
4600  0a81 3d00          	tnz	_bVENT_BLOCK
4601  0a83 2703          	jreq	L7232
4604  0a85 5f            	clrw	x
4605  0a86 bf05          	ldw	_vent_pwm,x
4606  0a88               L7232:
4607                     ; 701 }
4610  0a88 5b0e          	addw	sp,#14
4611  0a8a 81            	ret
4646                     ; 706 void pwr_drv(void)
4646                     ; 707 {
4647                     	switch	.text
4648  0a8b               _pwr_drv:
4652                     ; 711 BLOCK_INIT
4654  0a8b 72145007      	bset	20487,#2
4657  0a8f 72145008      	bset	20488,#2
4660  0a93 72155009      	bres	20489,#2
4661                     ; 713 if(main_cnt1<1500)main_cnt1++;
4663  0a97 9c            	rvf
4664  0a98 be4f          	ldw	x,_main_cnt1
4665  0a9a a305dc        	cpw	x,#1500
4666  0a9d 2e07          	jrsge	L1432
4669  0a9f be4f          	ldw	x,_main_cnt1
4670  0aa1 1c0001        	addw	x,#1
4671  0aa4 bf4f          	ldw	_main_cnt1,x
4672  0aa6               L1432:
4673                     ; 720 if((ee_DEVICE))
4675  0aa6 ce0004        	ldw	x,_ee_DEVICE
4676  0aa9 2727          	jreq	L3432
4677                     ; 722 	if(bBL)
4679                     	btst	_bBL
4680  0ab0 240c          	jruge	L5432
4681                     ; 724 		BLOCK_ON
4683  0ab2 72145005      	bset	20485,#2
4686  0ab6 35010000      	mov	_bVENT_BLOCK,#1
4688  0aba ac900b90      	jpf	L3532
4689  0abe               L5432:
4690                     ; 726 	else if(!bBL)
4692                     	btst	_bBL
4693  0ac3 2403          	jruge	L26
4694  0ac5 cc0b90        	jp	L3532
4695  0ac8               L26:
4696                     ; 728 		BLOCK_OFF
4698  0ac8 72155005      	bres	20485,#2
4701  0acc 3f00          	clr	_bVENT_BLOCK
4702  0ace ac900b90      	jpf	L3532
4703  0ad2               L3432:
4704                     ; 731 else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4706  0ad2 9c            	rvf
4707  0ad3 ce0016        	ldw	x,_ee_TZAS
4708  0ad6 90ae0005      	ldw	y,#5
4709  0ada cd0000        	call	c_imul
4711  0add b34f          	cpw	x,_main_cnt1
4712  0adf 2d12          	jrsle	L5532
4714  0ae1 b604          	ld	a,_bps_class
4715  0ae3 a101          	cp	a,#1
4716  0ae5 270c          	jreq	L5532
4717                     ; 733 	BLOCK_ON
4719  0ae7 72145005      	bset	20485,#2
4722  0aeb 35010000      	mov	_bVENT_BLOCK,#1
4724  0aef ac900b90      	jpf	L3532
4725  0af3               L5532:
4726                     ; 736 else if(bps_class==bpsIPS)
4728  0af3 b604          	ld	a,_bps_class
4729  0af5 a101          	cp	a,#1
4730  0af7 2621          	jrne	L1632
4731                     ; 739 		if(bBL_IPS)
4733                     	btst	_bBL_IPS
4734  0afe 240b          	jruge	L3632
4735                     ; 741 			 BLOCK_ON
4737  0b00 72145005      	bset	20485,#2
4740  0b04 35010000      	mov	_bVENT_BLOCK,#1
4742  0b08 cc0b90        	jra	L3532
4743  0b0b               L3632:
4744                     ; 744 		else if(!bBL_IPS)
4746                     	btst	_bBL_IPS
4747  0b10 257e          	jrult	L3532
4748                     ; 746 			  BLOCK_OFF
4750  0b12 72155005      	bres	20485,#2
4753  0b16 3f00          	clr	_bVENT_BLOCK
4754  0b18 2076          	jra	L3532
4755  0b1a               L1632:
4756                     ; 750 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4758  0b1a 9c            	rvf
4759  0b1b ce0016        	ldw	x,_ee_TZAS
4760  0b1e 90ae0005      	ldw	y,#5
4761  0b22 cd0000        	call	c_imul
4763  0b25 b34f          	cpw	x,_main_cnt1
4764  0b27 2e49          	jrsge	L3732
4766  0b29 9c            	rvf
4767  0b2a ce0016        	ldw	x,_ee_TZAS
4768  0b2d 90ae0005      	ldw	y,#5
4769  0b31 cd0000        	call	c_imul
4771  0b34 1c0046        	addw	x,#70
4772  0b37 b34f          	cpw	x,_main_cnt1
4773  0b39 2d37          	jrsle	L3732
4774                     ; 752 	if(bps_class==bpsIPS)
4776  0b3b b604          	ld	a,_bps_class
4777  0b3d a101          	cp	a,#1
4778  0b3f 2608          	jrne	L5732
4779                     ; 754 		  BLOCK_OFF
4781  0b41 72155005      	bres	20485,#2
4784  0b45 3f00          	clr	_bVENT_BLOCK
4786  0b47 2047          	jra	L3532
4787  0b49               L5732:
4788                     ; 757 	else if(bps_class==bpsIBEP)
4790  0b49 3d04          	tnz	_bps_class
4791  0b4b 2643          	jrne	L3532
4792                     ; 759 		if(ee_DEVICE)
4794  0b4d ce0004        	ldw	x,_ee_DEVICE
4795  0b50 2718          	jreq	L3042
4796                     ; 761 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4798  0b52 b60b          	ld	a,_flags
4799  0b54 a520          	bcp	a,#32
4800  0b56 270a          	jreq	L5042
4803  0b58 72145005      	bset	20485,#2
4806  0b5c 35010000      	mov	_bVENT_BLOCK,#1
4808  0b60 202e          	jra	L3532
4809  0b62               L5042:
4810                     ; 762 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4812  0b62 72155005      	bres	20485,#2
4815  0b66 3f00          	clr	_bVENT_BLOCK
4816  0b68 2026          	jra	L3532
4817  0b6a               L3042:
4818                     ; 766 			BLOCK_OFF
4820  0b6a 72155005      	bres	20485,#2
4823  0b6e 3f00          	clr	_bVENT_BLOCK
4824  0b70 201e          	jra	L3532
4825  0b72               L3732:
4826                     ; 771 else if(bBL)
4828                     	btst	_bBL
4829  0b77 240a          	jruge	L5142
4830                     ; 773 	BLOCK_ON
4832  0b79 72145005      	bset	20485,#2
4835  0b7d 35010000      	mov	_bVENT_BLOCK,#1
4837  0b81 200d          	jra	L3532
4838  0b83               L5142:
4839                     ; 776 else if(!bBL)
4841                     	btst	_bBL
4842  0b88 2506          	jrult	L3532
4843                     ; 778 	BLOCK_OFF
4845  0b8a 72155005      	bres	20485,#2
4848  0b8e 3f00          	clr	_bVENT_BLOCK
4849  0b90               L3532:
4850                     ; 782 gran(&pwm_u,2,1020);
4852  0b90 ae03fc        	ldw	x,#1020
4853  0b93 89            	pushw	x
4854  0b94 ae0002        	ldw	x,#2
4855  0b97 89            	pushw	x
4856  0b98 ae000e        	ldw	x,#_pwm_u
4857  0b9b cd00d1        	call	_gran
4859  0b9e 5b04          	addw	sp,#4
4860                     ; 783 gran(&pwm_i,2,1020);
4862  0ba0 ae03fc        	ldw	x,#1020
4863  0ba3 89            	pushw	x
4864  0ba4 ae0002        	ldw	x,#2
4865  0ba7 89            	pushw	x
4866  0ba8 ae0010        	ldw	x,#_pwm_i
4867  0bab cd00d1        	call	_gran
4869  0bae 5b04          	addw	sp,#4
4870                     ; 785 if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
4872  0bb0 ce0004        	ldw	x,_ee_DEVICE
4873  0bb3 2617          	jrne	L3242
4875  0bb5 9c            	rvf
4876  0bb6 ce0016        	ldw	x,_ee_TZAS
4877  0bb9 90ae0005      	ldw	y,#5
4878  0bbd cd0000        	call	c_imul
4880  0bc0 1c0032        	addw	x,#50
4881  0bc3 b34f          	cpw	x,_main_cnt1
4882  0bc5 2d05          	jrsle	L3242
4885  0bc7 ae000a        	ldw	x,#10
4886  0bca bf0e          	ldw	_pwm_u,x
4887  0bcc               L3242:
4888                     ; 795 TIM1->CCR2H= (char)(pwm_u/256);	
4890  0bcc be0e          	ldw	x,_pwm_u
4891  0bce 90ae0100      	ldw	y,#256
4892  0bd2 cd0000        	call	c_idiv
4894  0bd5 9f            	ld	a,xl
4895  0bd6 c75267        	ld	21095,a
4896                     ; 796 TIM1->CCR2L= (char)pwm_u;
4898  0bd9 55000f5268    	mov	21096,_pwm_u+1
4899                     ; 798 TIM1->CCR1H= (char)(pwm_i/256);	
4901  0bde be10          	ldw	x,_pwm_i
4902  0be0 90ae0100      	ldw	y,#256
4903  0be4 cd0000        	call	c_idiv
4905  0be7 9f            	ld	a,xl
4906  0be8 c75265        	ld	21093,a
4907                     ; 799 TIM1->CCR1L= (char)pwm_i;
4909  0beb 5500115266    	mov	21094,_pwm_i+1
4910                     ; 801 TIM1->CCR3H= (char)(vent_pwm/256);	
4912  0bf0 be05          	ldw	x,_vent_pwm
4913  0bf2 90ae0100      	ldw	y,#256
4914  0bf6 cd0000        	call	c_idiv
4916  0bf9 9f            	ld	a,xl
4917  0bfa c75269        	ld	21097,a
4918                     ; 802 TIM1->CCR3L= (char)vent_pwm;
4920  0bfd 550006526a    	mov	21098,_vent_pwm+1
4921                     ; 803 }
4924  0c02 81            	ret
4963                     ; 808 void pwr_hndl(void)				
4963                     ; 809 {
4964                     	switch	.text
4965  0c03               _pwr_hndl:
4969                     ; 810 if(jp_mode==jp3)
4971  0c03 b64a          	ld	a,_jp_mode
4972  0c05 a103          	cp	a,#3
4973  0c07 2646          	jrne	L5342
4974                     ; 812 	if((flags&0b00001010)==0)
4976  0c09 b60b          	ld	a,_flags
4977  0c0b a50a          	bcp	a,#10
4978  0c0d 2629          	jrne	L7342
4979                     ; 814 		pwm_u=500;
4981  0c0f ae01f4        	ldw	x,#500
4982  0c12 bf0e          	ldw	_pwm_u,x
4983                     ; 815 		if(pwm_i<1020)
4985  0c14 9c            	rvf
4986  0c15 be10          	ldw	x,_pwm_i
4987  0c17 a303fc        	cpw	x,#1020
4988  0c1a 2e14          	jrsge	L1442
4989                     ; 817 			pwm_i+=30;
4991  0c1c be10          	ldw	x,_pwm_i
4992  0c1e 1c001e        	addw	x,#30
4993  0c21 bf10          	ldw	_pwm_i,x
4994                     ; 818 			if(pwm_i>1020)pwm_i=1020;
4996  0c23 9c            	rvf
4997  0c24 be10          	ldw	x,_pwm_i
4998  0c26 a303fd        	cpw	x,#1021
4999  0c29 2f05          	jrslt	L1442
5002  0c2b ae03fc        	ldw	x,#1020
5003  0c2e bf10          	ldw	_pwm_i,x
5004  0c30               L1442:
5005                     ; 820 		bBL=0;
5007  0c30 72110000      	bres	_bBL
5009  0c34 acff0dff      	jpf	L1542
5010  0c38               L7342:
5011                     ; 822 	else if(flags&0b00001010)
5013  0c38 b60b          	ld	a,_flags
5014  0c3a a50a          	bcp	a,#10
5015  0c3c 2603          	jrne	L66
5016  0c3e cc0dff        	jp	L1542
5017  0c41               L66:
5018                     ; 824 		pwm_u=0;
5020  0c41 5f            	clrw	x
5021  0c42 bf0e          	ldw	_pwm_u,x
5022                     ; 825 		pwm_i=0;
5024  0c44 5f            	clrw	x
5025  0c45 bf10          	ldw	_pwm_i,x
5026                     ; 826 		bBL=1;
5028  0c47 72100000      	bset	_bBL
5029  0c4b acff0dff      	jpf	L1542
5030  0c4f               L5342:
5031                     ; 830 else if(jp_mode==jp2)
5033  0c4f b64a          	ld	a,_jp_mode
5034  0c51 a102          	cp	a,#2
5035  0c53 2627          	jrne	L3542
5036                     ; 832 	pwm_u=0;
5038  0c55 5f            	clrw	x
5039  0c56 bf0e          	ldw	_pwm_u,x
5040                     ; 834 	if(pwm_i<1020)
5042  0c58 9c            	rvf
5043  0c59 be10          	ldw	x,_pwm_i
5044  0c5b a303fc        	cpw	x,#1020
5045  0c5e 2e14          	jrsge	L5542
5046                     ; 836 		pwm_i+=30;
5048  0c60 be10          	ldw	x,_pwm_i
5049  0c62 1c001e        	addw	x,#30
5050  0c65 bf10          	ldw	_pwm_i,x
5051                     ; 837 		if(pwm_i>1020)pwm_i=1020;
5053  0c67 9c            	rvf
5054  0c68 be10          	ldw	x,_pwm_i
5055  0c6a a303fd        	cpw	x,#1021
5056  0c6d 2f05          	jrslt	L5542
5059  0c6f ae03fc        	ldw	x,#1020
5060  0c72 bf10          	ldw	_pwm_i,x
5061  0c74               L5542:
5062                     ; 839 	bBL=0;
5064  0c74 72110000      	bres	_bBL
5066  0c78 acff0dff      	jpf	L1542
5067  0c7c               L3542:
5068                     ; 841 else if(jp_mode==jp1)
5070  0c7c b64a          	ld	a,_jp_mode
5071  0c7e a101          	cp	a,#1
5072  0c80 2629          	jrne	L3642
5073                     ; 843 	pwm_u=0x3ff;
5075  0c82 ae03ff        	ldw	x,#1023
5076  0c85 bf0e          	ldw	_pwm_u,x
5077                     ; 845 	if(pwm_i<1020)
5079  0c87 9c            	rvf
5080  0c88 be10          	ldw	x,_pwm_i
5081  0c8a a303fc        	cpw	x,#1020
5082  0c8d 2e14          	jrsge	L5642
5083                     ; 847 		pwm_i+=30;
5085  0c8f be10          	ldw	x,_pwm_i
5086  0c91 1c001e        	addw	x,#30
5087  0c94 bf10          	ldw	_pwm_i,x
5088                     ; 848 		if(pwm_i>1020)pwm_i=1020;
5090  0c96 9c            	rvf
5091  0c97 be10          	ldw	x,_pwm_i
5092  0c99 a303fd        	cpw	x,#1021
5093  0c9c 2f05          	jrslt	L5642
5096  0c9e ae03fc        	ldw	x,#1020
5097  0ca1 bf10          	ldw	_pwm_i,x
5098  0ca3               L5642:
5099                     ; 850 	bBL=0;
5101  0ca3 72110000      	bres	_bBL
5103  0ca7 acff0dff      	jpf	L1542
5104  0cab               L3642:
5105                     ; 853 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
5107                     	btst	_bMAIN
5108  0cb0 242e          	jruge	L3742
5110  0cb2 b663          	ld	a,_link
5111  0cb4 a155          	cp	a,#85
5112  0cb6 2628          	jrne	L3742
5113                     ; 855 	pwm_u=volum_u_main_;
5115  0cb8 be1f          	ldw	x,_volum_u_main_
5116  0cba bf0e          	ldw	_pwm_u,x
5117                     ; 857 	if(pwm_i<1020)
5119  0cbc 9c            	rvf
5120  0cbd be10          	ldw	x,_pwm_i
5121  0cbf a303fc        	cpw	x,#1020
5122  0cc2 2e14          	jrsge	L5742
5123                     ; 859 		pwm_i+=30;
5125  0cc4 be10          	ldw	x,_pwm_i
5126  0cc6 1c001e        	addw	x,#30
5127  0cc9 bf10          	ldw	_pwm_i,x
5128                     ; 860 		if(pwm_i>1020)pwm_i=1020;
5130  0ccb 9c            	rvf
5131  0ccc be10          	ldw	x,_pwm_i
5132  0cce a303fd        	cpw	x,#1021
5133  0cd1 2f05          	jrslt	L5742
5136  0cd3 ae03fc        	ldw	x,#1020
5137  0cd6 bf10          	ldw	_pwm_i,x
5138  0cd8               L5742:
5139                     ; 862 	bBL_IPS=0;
5141  0cd8 72110001      	bres	_bBL_IPS
5143  0cdc acff0dff      	jpf	L1542
5144  0ce0               L3742:
5145                     ; 865 else if(link==OFF)
5147  0ce0 b663          	ld	a,_link
5148  0ce2 a1aa          	cp	a,#170
5149  0ce4 266f          	jrne	L3052
5150                     ; 874  	if(ee_DEVICE)
5152  0ce6 ce0004        	ldw	x,_ee_DEVICE
5153  0ce9 270e          	jreq	L5052
5154                     ; 876 		pwm_u=0x00;
5156  0ceb 5f            	clrw	x
5157  0cec bf0e          	ldw	_pwm_u,x
5158                     ; 877 		pwm_i=0x00;
5160  0cee 5f            	clrw	x
5161  0cef bf10          	ldw	_pwm_i,x
5162                     ; 878 		bBL=1;
5164  0cf1 72100000      	bset	_bBL
5166  0cf5 acff0dff      	jpf	L1542
5167  0cf9               L5052:
5168                     ; 882 		if((flags&0b00011010)==0)
5170  0cf9 b60b          	ld	a,_flags
5171  0cfb a51a          	bcp	a,#26
5172  0cfd 263b          	jrne	L1152
5173                     ; 884 			pwm_u=ee_U_AVT;
5175  0cff ce000c        	ldw	x,_ee_U_AVT
5176  0d02 bf0e          	ldw	_pwm_u,x
5177                     ; 885 			gran(&pwm_u,0,1020);
5179  0d04 ae03fc        	ldw	x,#1020
5180  0d07 89            	pushw	x
5181  0d08 5f            	clrw	x
5182  0d09 89            	pushw	x
5183  0d0a ae000e        	ldw	x,#_pwm_u
5184  0d0d cd00d1        	call	_gran
5186  0d10 5b04          	addw	sp,#4
5187                     ; 887 			if(pwm_i<1020)
5189  0d12 9c            	rvf
5190  0d13 be10          	ldw	x,_pwm_i
5191  0d15 a303fc        	cpw	x,#1020
5192  0d18 2e14          	jrsge	L3152
5193                     ; 889 				pwm_i+=30;
5195  0d1a be10          	ldw	x,_pwm_i
5196  0d1c 1c001e        	addw	x,#30
5197  0d1f bf10          	ldw	_pwm_i,x
5198                     ; 890 				if(pwm_i>1020)pwm_i=1020;
5200  0d21 9c            	rvf
5201  0d22 be10          	ldw	x,_pwm_i
5202  0d24 a303fd        	cpw	x,#1021
5203  0d27 2f05          	jrslt	L3152
5206  0d29 ae03fc        	ldw	x,#1020
5207  0d2c bf10          	ldw	_pwm_i,x
5208  0d2e               L3152:
5209                     ; 892 			bBL=0;
5211  0d2e 72110000      	bres	_bBL
5212                     ; 893 			bBL_IPS=0;
5214  0d32 72110001      	bres	_bBL_IPS
5216  0d36 acff0dff      	jpf	L1542
5217  0d3a               L1152:
5218                     ; 895 		else if(flags&0b00011010)
5220  0d3a b60b          	ld	a,_flags
5221  0d3c a51a          	bcp	a,#26
5222  0d3e 2603          	jrne	L07
5223  0d40 cc0dff        	jp	L1542
5224  0d43               L07:
5225                     ; 897 			pwm_u=0;
5227  0d43 5f            	clrw	x
5228  0d44 bf0e          	ldw	_pwm_u,x
5229                     ; 898 			pwm_i=0;
5231  0d46 5f            	clrw	x
5232  0d47 bf10          	ldw	_pwm_i,x
5233                     ; 899 			bBL=1;
5235  0d49 72100000      	bset	_bBL
5236                     ; 900 			bBL_IPS=1;
5238  0d4d 72100001      	bset	_bBL_IPS
5239  0d51 acff0dff      	jpf	L1542
5240  0d55               L3052:
5241                     ; 909 else	if(link==ON)				//если есть связьvol_i_temp_avar
5243  0d55 b663          	ld	a,_link
5244  0d57 a155          	cp	a,#85
5245  0d59 2703          	jreq	L27
5246  0d5b cc0dff        	jp	L1542
5247  0d5e               L27:
5248                     ; 911 	if((flags&0b00100000)==0)	//если нет блокировки извне
5250  0d5e b60b          	ld	a,_flags
5251  0d60 a520          	bcp	a,#32
5252  0d62 2703cc0def    	jrne	L7252
5253                     ; 913 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
5255  0d67 b60b          	ld	a,_flags
5256  0d69 a41e          	and	a,#30
5257  0d6b a104          	cp	a,#4
5258  0d6d 2630          	jrne	L1352
5259                     ; 915 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5261  0d6f be5e          	ldw	x,__x_
5262  0d71 72bb0058      	addw	x,_vol_u_temp
5263  0d75 bf0e          	ldw	_pwm_u,x
5264                     ; 916 			if(!ee_DEVICE)
5266  0d77 ce0004        	ldw	x,_ee_DEVICE
5267  0d7a 261b          	jrne	L3352
5268                     ; 918 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
5270  0d7c be10          	ldw	x,_pwm_i
5271  0d7e b30c          	cpw	x,_vol_i_temp_avar
5272  0d80 240f          	jruge	L5352
5275  0d82 be0c          	ldw	x,_vol_i_temp_avar
5276  0d84 90ae001e      	ldw	y,#30
5277  0d88 65            	divw	x,y
5278  0d89 72bb0010      	addw	x,_pwm_i
5279  0d8d bf10          	ldw	_pwm_i,x
5281  0d8f 200a          	jra	L1452
5282  0d91               L5352:
5283                     ; 919 				else	pwm_i=vol_i_temp_avar;
5285  0d91 be0c          	ldw	x,_vol_i_temp_avar
5286  0d93 bf10          	ldw	_pwm_i,x
5287  0d95 2004          	jra	L1452
5288  0d97               L3352:
5289                     ; 921 			else pwm_i=vol_i_temp_avar;
5291  0d97 be0c          	ldw	x,_vol_i_temp_avar
5292  0d99 bf10          	ldw	_pwm_i,x
5293  0d9b               L1452:
5294                     ; 923 			bBL=0;
5296  0d9b 72110000      	bres	_bBL
5297  0d9f               L1352:
5298                     ; 925 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5300  0d9f b60b          	ld	a,_flags
5301  0da1 a51a          	bcp	a,#26
5302  0da3 2706          	jreq	L5452
5304  0da5 b60b          	ld	a,_flags
5305  0da7 a540          	bcp	a,#64
5306  0da9 2732          	jreq	L3452
5307  0dab               L5452:
5308                     ; 927 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5310  0dab be5e          	ldw	x,__x_
5311  0dad 72bb0058      	addw	x,_vol_u_temp
5312  0db1 bf0e          	ldw	_pwm_u,x
5313                     ; 929 			if(!ee_DEVICE)
5315  0db3 ce0004        	ldw	x,_ee_DEVICE
5316  0db6 261b          	jrne	L7452
5317                     ; 931 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
5319  0db8 be10          	ldw	x,_pwm_i
5320  0dba b356          	cpw	x,_vol_i_temp
5321  0dbc 240f          	jruge	L1552
5324  0dbe be56          	ldw	x,_vol_i_temp
5325  0dc0 90ae001e      	ldw	y,#30
5326  0dc4 65            	divw	x,y
5327  0dc5 72bb0010      	addw	x,_pwm_i
5328  0dc9 bf10          	ldw	_pwm_i,x
5330  0dcb 200a          	jra	L5552
5331  0dcd               L1552:
5332                     ; 932 				else	pwm_i=vol_i_temp;
5334  0dcd be56          	ldw	x,_vol_i_temp
5335  0dcf bf10          	ldw	_pwm_i,x
5336  0dd1 2004          	jra	L5552
5337  0dd3               L7452:
5338                     ; 934 			else pwm_i=vol_i_temp;			
5340  0dd3 be56          	ldw	x,_vol_i_temp
5341  0dd5 bf10          	ldw	_pwm_i,x
5342  0dd7               L5552:
5343                     ; 935 			bBL=0;
5345  0dd7 72110000      	bres	_bBL
5347  0ddb 2022          	jra	L1542
5348  0ddd               L3452:
5349                     ; 937 		else if(flags&0b00011010)					//если есть аварии
5351  0ddd b60b          	ld	a,_flags
5352  0ddf a51a          	bcp	a,#26
5353  0de1 271c          	jreq	L1542
5354                     ; 939 			pwm_u=0;								//то полный стоп
5356  0de3 5f            	clrw	x
5357  0de4 bf0e          	ldw	_pwm_u,x
5358                     ; 940 			pwm_i=0;
5360  0de6 5f            	clrw	x
5361  0de7 bf10          	ldw	_pwm_i,x
5362                     ; 941 			bBL=1;
5364  0de9 72100000      	bset	_bBL
5365  0ded 2010          	jra	L1542
5366  0def               L7252:
5367                     ; 944 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5369  0def b60b          	ld	a,_flags
5370  0df1 a520          	bcp	a,#32
5371  0df3 270a          	jreq	L1542
5372                     ; 946 		pwm_u=0;
5374  0df5 5f            	clrw	x
5375  0df6 bf0e          	ldw	_pwm_u,x
5376                     ; 947 	    	pwm_i=0;
5378  0df8 5f            	clrw	x
5379  0df9 bf10          	ldw	_pwm_i,x
5380                     ; 948 		bBL=1;
5382  0dfb 72100000      	bset	_bBL
5383  0dff               L1542:
5384                     ; 954 }
5387  0dff 81            	ret
5432                     	switch	.const
5433  000c               L67:
5434  000c 00000258      	dc.l	600
5435  0010               L001:
5436  0010 000003e8      	dc.l	1000
5437                     ; 957 void matemat(void)
5437                     ; 958 {
5438                     	switch	.text
5439  0e00               _matemat:
5441  0e00 5208          	subw	sp,#8
5442       00000008      OFST:	set	8
5445                     ; 979 temp_SL=adc_buff_[4];
5447  0e02 ce0011        	ldw	x,_adc_buff_+8
5448  0e05 cd0000        	call	c_itolx
5450  0e08 96            	ldw	x,sp
5451  0e09 1c0005        	addw	x,#OFST-3
5452  0e0c cd0000        	call	c_rtol
5454                     ; 980 temp_SL-=ee_K[0][0];
5456  0e0f ce001a        	ldw	x,_ee_K
5457  0e12 cd0000        	call	c_itolx
5459  0e15 96            	ldw	x,sp
5460  0e16 1c0005        	addw	x,#OFST-3
5461  0e19 cd0000        	call	c_lgsub
5463                     ; 981 if(temp_SL<0) temp_SL=0;
5465  0e1c 9c            	rvf
5466  0e1d 0d05          	tnz	(OFST-3,sp)
5467  0e1f 2e0a          	jrsge	L5062
5470  0e21 ae0000        	ldw	x,#0
5471  0e24 1f07          	ldw	(OFST-1,sp),x
5472  0e26 ae0000        	ldw	x,#0
5473  0e29 1f05          	ldw	(OFST-3,sp),x
5474  0e2b               L5062:
5475                     ; 982 temp_SL*=ee_K[0][1];
5477  0e2b ce001c        	ldw	x,_ee_K+2
5478  0e2e cd0000        	call	c_itolx
5480  0e31 96            	ldw	x,sp
5481  0e32 1c0005        	addw	x,#OFST-3
5482  0e35 cd0000        	call	c_lgmul
5484                     ; 983 temp_SL/=600;
5486  0e38 96            	ldw	x,sp
5487  0e39 1c0005        	addw	x,#OFST-3
5488  0e3c cd0000        	call	c_ltor
5490  0e3f ae000c        	ldw	x,#L67
5491  0e42 cd0000        	call	c_ldiv
5493  0e45 96            	ldw	x,sp
5494  0e46 1c0005        	addw	x,#OFST-3
5495  0e49 cd0000        	call	c_rtol
5497                     ; 984 I=(signed short)temp_SL;
5499  0e4c 1e07          	ldw	x,(OFST-1,sp)
5500  0e4e bf6f          	ldw	_I,x
5501                     ; 989 temp_SL=(signed long)adc_buff_[1];
5503  0e50 ce000b        	ldw	x,_adc_buff_+2
5504  0e53 cd0000        	call	c_itolx
5506  0e56 96            	ldw	x,sp
5507  0e57 1c0005        	addw	x,#OFST-3
5508  0e5a cd0000        	call	c_rtol
5510                     ; 991 if(temp_SL<0) temp_SL=0;
5512  0e5d 9c            	rvf
5513  0e5e 0d05          	tnz	(OFST-3,sp)
5514  0e60 2e0a          	jrsge	L7062
5517  0e62 ae0000        	ldw	x,#0
5518  0e65 1f07          	ldw	(OFST-1,sp),x
5519  0e67 ae0000        	ldw	x,#0
5520  0e6a 1f05          	ldw	(OFST-3,sp),x
5521  0e6c               L7062:
5522                     ; 992 temp_SL*=(signed long)ee_K[2][1];
5524  0e6c ce0024        	ldw	x,_ee_K+10
5525  0e6f cd0000        	call	c_itolx
5527  0e72 96            	ldw	x,sp
5528  0e73 1c0005        	addw	x,#OFST-3
5529  0e76 cd0000        	call	c_lgmul
5531                     ; 993 temp_SL/=1000L;
5533  0e79 96            	ldw	x,sp
5534  0e7a 1c0005        	addw	x,#OFST-3
5535  0e7d cd0000        	call	c_ltor
5537  0e80 ae0010        	ldw	x,#L001
5538  0e83 cd0000        	call	c_ldiv
5540  0e86 96            	ldw	x,sp
5541  0e87 1c0005        	addw	x,#OFST-3
5542  0e8a cd0000        	call	c_rtol
5544                     ; 994 Ui=(unsigned short)temp_SL;
5546  0e8d 1e07          	ldw	x,(OFST-1,sp)
5547  0e8f bf6b          	ldw	_Ui,x
5548                     ; 1001 temp_SL=adc_buff_[3];
5550  0e91 ce000f        	ldw	x,_adc_buff_+6
5551  0e94 cd0000        	call	c_itolx
5553  0e97 96            	ldw	x,sp
5554  0e98 1c0005        	addw	x,#OFST-3
5555  0e9b cd0000        	call	c_rtol
5557                     ; 1003 if(temp_SL<0) temp_SL=0;
5559  0e9e 9c            	rvf
5560  0e9f 0d05          	tnz	(OFST-3,sp)
5561  0ea1 2e0a          	jrsge	L1162
5564  0ea3 ae0000        	ldw	x,#0
5565  0ea6 1f07          	ldw	(OFST-1,sp),x
5566  0ea8 ae0000        	ldw	x,#0
5567  0eab 1f05          	ldw	(OFST-3,sp),x
5568  0ead               L1162:
5569                     ; 1004 temp_SL*=ee_K[1][1];
5571  0ead ce0020        	ldw	x,_ee_K+6
5572  0eb0 cd0000        	call	c_itolx
5574  0eb3 96            	ldw	x,sp
5575  0eb4 1c0005        	addw	x,#OFST-3
5576  0eb7 cd0000        	call	c_lgmul
5578                     ; 1005 temp_SL/=1000;
5580  0eba 96            	ldw	x,sp
5581  0ebb 1c0005        	addw	x,#OFST-3
5582  0ebe cd0000        	call	c_ltor
5584  0ec1 ae0010        	ldw	x,#L001
5585  0ec4 cd0000        	call	c_ldiv
5587  0ec7 96            	ldw	x,sp
5588  0ec8 1c0005        	addw	x,#OFST-3
5589  0ecb cd0000        	call	c_rtol
5591                     ; 1006 Un=(unsigned short)temp_SL;
5593  0ece 1e07          	ldw	x,(OFST-1,sp)
5594  0ed0 bf6d          	ldw	_Un,x
5595                     ; 1009 temp_SL=adc_buff_[2];
5597  0ed2 ce000d        	ldw	x,_adc_buff_+4
5598  0ed5 cd0000        	call	c_itolx
5600  0ed8 96            	ldw	x,sp
5601  0ed9 1c0005        	addw	x,#OFST-3
5602  0edc cd0000        	call	c_rtol
5604                     ; 1010 temp_SL*=ee_K[3][1];
5606  0edf ce0028        	ldw	x,_ee_K+14
5607  0ee2 cd0000        	call	c_itolx
5609  0ee5 96            	ldw	x,sp
5610  0ee6 1c0005        	addw	x,#OFST-3
5611  0ee9 cd0000        	call	c_lgmul
5613                     ; 1011 temp_SL/=1000;
5615  0eec 96            	ldw	x,sp
5616  0eed 1c0005        	addw	x,#OFST-3
5617  0ef0 cd0000        	call	c_ltor
5619  0ef3 ae0010        	ldw	x,#L001
5620  0ef6 cd0000        	call	c_ldiv
5622  0ef9 96            	ldw	x,sp
5623  0efa 1c0005        	addw	x,#OFST-3
5624  0efd cd0000        	call	c_rtol
5626                     ; 1012 T=(signed short)(temp_SL-273L);
5628  0f00 7b08          	ld	a,(OFST+0,sp)
5629  0f02 5f            	clrw	x
5630  0f03 4d            	tnz	a
5631  0f04 2a01          	jrpl	L201
5632  0f06 53            	cplw	x
5633  0f07               L201:
5634  0f07 97            	ld	xl,a
5635  0f08 1d0111        	subw	x,#273
5636  0f0b 01            	rrwa	x,a
5637  0f0c b768          	ld	_T,a
5638  0f0e 02            	rlwa	x,a
5639                     ; 1013 if(T<-30)T=-30;
5641  0f0f 9c            	rvf
5642  0f10 b668          	ld	a,_T
5643  0f12 a1e2          	cp	a,#226
5644  0f14 2e04          	jrsge	L3162
5647  0f16 35e20068      	mov	_T,#226
5648  0f1a               L3162:
5649                     ; 1014 if(T>120)T=120;
5651  0f1a 9c            	rvf
5652  0f1b b668          	ld	a,_T
5653  0f1d a179          	cp	a,#121
5654  0f1f 2f04          	jrslt	L5162
5657  0f21 35780068      	mov	_T,#120
5658  0f25               L5162:
5659                     ; 1016 Udb=flags;
5661  0f25 b60b          	ld	a,_flags
5662  0f27 5f            	clrw	x
5663  0f28 97            	ld	xl,a
5664  0f29 bf69          	ldw	_Udb,x
5665                     ; 1022 temp_SL=(signed long)(T-ee_tsign);
5667  0f2b 5f            	clrw	x
5668  0f2c b668          	ld	a,_T
5669  0f2e 2a01          	jrpl	L401
5670  0f30 53            	cplw	x
5671  0f31               L401:
5672  0f31 97            	ld	xl,a
5673  0f32 72b0000e      	subw	x,_ee_tsign
5674  0f36 cd0000        	call	c_itolx
5676  0f39 96            	ldw	x,sp
5677  0f3a 1c0005        	addw	x,#OFST-3
5678  0f3d cd0000        	call	c_rtol
5680                     ; 1023 temp_SL*=1000L;
5682  0f40 ae03e8        	ldw	x,#1000
5683  0f43 bf02          	ldw	c_lreg+2,x
5684  0f45 ae0000        	ldw	x,#0
5685  0f48 bf00          	ldw	c_lreg,x
5686  0f4a 96            	ldw	x,sp
5687  0f4b 1c0005        	addw	x,#OFST-3
5688  0f4e cd0000        	call	c_lgmul
5690                     ; 1024 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5692  0f51 ce0010        	ldw	x,_ee_tmax
5693  0f54 72b0000e      	subw	x,_ee_tsign
5694  0f58 cd0000        	call	c_itolx
5696  0f5b 96            	ldw	x,sp
5697  0f5c 1c0001        	addw	x,#OFST-7
5698  0f5f cd0000        	call	c_rtol
5700  0f62 96            	ldw	x,sp
5701  0f63 1c0005        	addw	x,#OFST-3
5702  0f66 cd0000        	call	c_ltor
5704  0f69 96            	ldw	x,sp
5705  0f6a 1c0001        	addw	x,#OFST-7
5706  0f6d cd0000        	call	c_ldiv
5708  0f70 96            	ldw	x,sp
5709  0f71 1c0005        	addw	x,#OFST-3
5710  0f74 cd0000        	call	c_rtol
5712                     ; 1026 vol_i_temp_avar=(unsigned short)temp_SL; 
5714  0f77 1e07          	ldw	x,(OFST-1,sp)
5715  0f79 bf0c          	ldw	_vol_i_temp_avar,x
5716                     ; 1028 }
5719  0f7b 5b08          	addw	sp,#8
5720  0f7d 81            	ret
5751                     ; 1031 void temper_drv(void)		//1 Hz
5751                     ; 1032 {
5752                     	switch	.text
5753  0f7e               _temper_drv:
5757                     ; 1034 if(T>ee_tsign) tsign_cnt++;
5759  0f7e 9c            	rvf
5760  0f7f 5f            	clrw	x
5761  0f80 b668          	ld	a,_T
5762  0f82 2a01          	jrpl	L011
5763  0f84 53            	cplw	x
5764  0f85               L011:
5765  0f85 97            	ld	xl,a
5766  0f86 c3000e        	cpw	x,_ee_tsign
5767  0f89 2d09          	jrsle	L7262
5770  0f8b be4d          	ldw	x,_tsign_cnt
5771  0f8d 1c0001        	addw	x,#1
5772  0f90 bf4d          	ldw	_tsign_cnt,x
5774  0f92 201d          	jra	L1362
5775  0f94               L7262:
5776                     ; 1035 else if (T<(ee_tsign-1)) tsign_cnt--;
5778  0f94 9c            	rvf
5779  0f95 ce000e        	ldw	x,_ee_tsign
5780  0f98 5a            	decw	x
5781  0f99 905f          	clrw	y
5782  0f9b b668          	ld	a,_T
5783  0f9d 2a02          	jrpl	L211
5784  0f9f 9053          	cplw	y
5785  0fa1               L211:
5786  0fa1 9097          	ld	yl,a
5787  0fa3 90bf00        	ldw	c_y,y
5788  0fa6 b300          	cpw	x,c_y
5789  0fa8 2d07          	jrsle	L1362
5792  0faa be4d          	ldw	x,_tsign_cnt
5793  0fac 1d0001        	subw	x,#1
5794  0faf bf4d          	ldw	_tsign_cnt,x
5795  0fb1               L1362:
5796                     ; 1037 gran(&tsign_cnt,0,60);
5798  0fb1 ae003c        	ldw	x,#60
5799  0fb4 89            	pushw	x
5800  0fb5 5f            	clrw	x
5801  0fb6 89            	pushw	x
5802  0fb7 ae004d        	ldw	x,#_tsign_cnt
5803  0fba cd00d1        	call	_gran
5805  0fbd 5b04          	addw	sp,#4
5806                     ; 1039 if(tsign_cnt>=55)
5808  0fbf 9c            	rvf
5809  0fc0 be4d          	ldw	x,_tsign_cnt
5810  0fc2 a30037        	cpw	x,#55
5811  0fc5 2f16          	jrslt	L5362
5812                     ; 1041 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5814  0fc7 3d4a          	tnz	_jp_mode
5815  0fc9 2606          	jrne	L3462
5817  0fcb b60b          	ld	a,_flags
5818  0fcd a540          	bcp	a,#64
5819  0fcf 2706          	jreq	L1462
5820  0fd1               L3462:
5822  0fd1 b64a          	ld	a,_jp_mode
5823  0fd3 a103          	cp	a,#3
5824  0fd5 2612          	jrne	L5462
5825  0fd7               L1462:
5828  0fd7 7214000b      	bset	_flags,#2
5829  0fdb 200c          	jra	L5462
5830  0fdd               L5362:
5831                     ; 1043 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5833  0fdd 9c            	rvf
5834  0fde be4d          	ldw	x,_tsign_cnt
5835  0fe0 a30006        	cpw	x,#6
5836  0fe3 2e04          	jrsge	L5462
5839  0fe5 7215000b      	bres	_flags,#2
5840  0fe9               L5462:
5841                     ; 1048 if(T>ee_tmax) tmax_cnt++;
5843  0fe9 9c            	rvf
5844  0fea 5f            	clrw	x
5845  0feb b668          	ld	a,_T
5846  0fed 2a01          	jrpl	L411
5847  0fef 53            	cplw	x
5848  0ff0               L411:
5849  0ff0 97            	ld	xl,a
5850  0ff1 c30010        	cpw	x,_ee_tmax
5851  0ff4 2d09          	jrsle	L1562
5854  0ff6 be4b          	ldw	x,_tmax_cnt
5855  0ff8 1c0001        	addw	x,#1
5856  0ffb bf4b          	ldw	_tmax_cnt,x
5858  0ffd 201d          	jra	L3562
5859  0fff               L1562:
5860                     ; 1049 else if (T<(ee_tmax-1)) tmax_cnt--;
5862  0fff 9c            	rvf
5863  1000 ce0010        	ldw	x,_ee_tmax
5864  1003 5a            	decw	x
5865  1004 905f          	clrw	y
5866  1006 b668          	ld	a,_T
5867  1008 2a02          	jrpl	L611
5868  100a 9053          	cplw	y
5869  100c               L611:
5870  100c 9097          	ld	yl,a
5871  100e 90bf00        	ldw	c_y,y
5872  1011 b300          	cpw	x,c_y
5873  1013 2d07          	jrsle	L3562
5876  1015 be4b          	ldw	x,_tmax_cnt
5877  1017 1d0001        	subw	x,#1
5878  101a bf4b          	ldw	_tmax_cnt,x
5879  101c               L3562:
5880                     ; 1051 gran(&tmax_cnt,0,60);
5882  101c ae003c        	ldw	x,#60
5883  101f 89            	pushw	x
5884  1020 5f            	clrw	x
5885  1021 89            	pushw	x
5886  1022 ae004b        	ldw	x,#_tmax_cnt
5887  1025 cd00d1        	call	_gran
5889  1028 5b04          	addw	sp,#4
5890                     ; 1053 if(tmax_cnt>=55)
5892  102a 9c            	rvf
5893  102b be4b          	ldw	x,_tmax_cnt
5894  102d a30037        	cpw	x,#55
5895  1030 2f16          	jrslt	L7562
5896                     ; 1055 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5898  1032 3d4a          	tnz	_jp_mode
5899  1034 2606          	jrne	L5662
5901  1036 b60b          	ld	a,_flags
5902  1038 a540          	bcp	a,#64
5903  103a 2706          	jreq	L3662
5904  103c               L5662:
5906  103c b64a          	ld	a,_jp_mode
5907  103e a103          	cp	a,#3
5908  1040 2612          	jrne	L7662
5909  1042               L3662:
5912  1042 7212000b      	bset	_flags,#1
5913  1046 200c          	jra	L7662
5914  1048               L7562:
5915                     ; 1057 else if (tmax_cnt<=5) flags&=0b11111101;
5917  1048 9c            	rvf
5918  1049 be4b          	ldw	x,_tmax_cnt
5919  104b a30006        	cpw	x,#6
5920  104e 2e04          	jrsge	L7662
5923  1050 7213000b      	bres	_flags,#1
5924  1054               L7662:
5925                     ; 1060 } 
5928  1054 81            	ret
5960                     ; 1063 void u_drv(void)		//1Hz
5960                     ; 1064 { 
5961                     	switch	.text
5962  1055               _u_drv:
5966                     ; 1065 if(jp_mode!=jp3)
5968  1055 b64a          	ld	a,_jp_mode
5969  1057 a103          	cp	a,#3
5970  1059 2770          	jreq	L3072
5971                     ; 1067 	if(Ui>ee_Umax)umax_cnt++;
5973  105b 9c            	rvf
5974  105c be6b          	ldw	x,_Ui
5975  105e c30014        	cpw	x,_ee_Umax
5976  1061 2d09          	jrsle	L5072
5979  1063 be66          	ldw	x,_umax_cnt
5980  1065 1c0001        	addw	x,#1
5981  1068 bf66          	ldw	_umax_cnt,x
5983  106a 2003          	jra	L7072
5984  106c               L5072:
5985                     ; 1068 	else umax_cnt=0;
5987  106c 5f            	clrw	x
5988  106d bf66          	ldw	_umax_cnt,x
5989  106f               L7072:
5990                     ; 1069 	gran(&umax_cnt,0,10);
5992  106f ae000a        	ldw	x,#10
5993  1072 89            	pushw	x
5994  1073 5f            	clrw	x
5995  1074 89            	pushw	x
5996  1075 ae0066        	ldw	x,#_umax_cnt
5997  1078 cd00d1        	call	_gran
5999  107b 5b04          	addw	sp,#4
6000                     ; 1070 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
6002  107d 9c            	rvf
6003  107e be66          	ldw	x,_umax_cnt
6004  1080 a3000a        	cpw	x,#10
6005  1083 2f04          	jrslt	L1172
6008  1085 7216000b      	bset	_flags,#3
6009  1089               L1172:
6010                     ; 1073 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6012  1089 9c            	rvf
6013  108a be6b          	ldw	x,_Ui
6014  108c b36d          	cpw	x,_Un
6015  108e 2e1c          	jrsge	L3172
6017  1090 9c            	rvf
6018  1091 be6d          	ldw	x,_Un
6019  1093 72b0006b      	subw	x,_Ui
6020  1097 c30012        	cpw	x,_ee_dU
6021  109a 2d10          	jrsle	L3172
6023  109c c65005        	ld	a,20485
6024  109f a504          	bcp	a,#4
6025  10a1 2609          	jrne	L3172
6028  10a3 be64          	ldw	x,_umin_cnt
6029  10a5 1c0001        	addw	x,#1
6030  10a8 bf64          	ldw	_umin_cnt,x
6032  10aa 2003          	jra	L5172
6033  10ac               L3172:
6034                     ; 1074 	else umin_cnt=0;
6036  10ac 5f            	clrw	x
6037  10ad bf64          	ldw	_umin_cnt,x
6038  10af               L5172:
6039                     ; 1075 	gran(&umin_cnt,0,10);	
6041  10af ae000a        	ldw	x,#10
6042  10b2 89            	pushw	x
6043  10b3 5f            	clrw	x
6044  10b4 89            	pushw	x
6045  10b5 ae0064        	ldw	x,#_umin_cnt
6046  10b8 cd00d1        	call	_gran
6048  10bb 5b04          	addw	sp,#4
6049                     ; 1076 	if(umin_cnt>=10)flags|=0b00010000;	  
6051  10bd 9c            	rvf
6052  10be be64          	ldw	x,_umin_cnt
6053  10c0 a3000a        	cpw	x,#10
6054  10c3 2f6f          	jrslt	L1272
6057  10c5 7218000b      	bset	_flags,#4
6058  10c9 2069          	jra	L1272
6059  10cb               L3072:
6060                     ; 1078 else if(jp_mode==jp3)
6062  10cb b64a          	ld	a,_jp_mode
6063  10cd a103          	cp	a,#3
6064  10cf 2663          	jrne	L1272
6065                     ; 1080 	if(Ui>700)umax_cnt++;
6067  10d1 9c            	rvf
6068  10d2 be6b          	ldw	x,_Ui
6069  10d4 a302bd        	cpw	x,#701
6070  10d7 2f09          	jrslt	L5272
6073  10d9 be66          	ldw	x,_umax_cnt
6074  10db 1c0001        	addw	x,#1
6075  10de bf66          	ldw	_umax_cnt,x
6077  10e0 2003          	jra	L7272
6078  10e2               L5272:
6079                     ; 1081 	else umax_cnt=0;
6081  10e2 5f            	clrw	x
6082  10e3 bf66          	ldw	_umax_cnt,x
6083  10e5               L7272:
6084                     ; 1082 	gran(&umax_cnt,0,10);
6086  10e5 ae000a        	ldw	x,#10
6087  10e8 89            	pushw	x
6088  10e9 5f            	clrw	x
6089  10ea 89            	pushw	x
6090  10eb ae0066        	ldw	x,#_umax_cnt
6091  10ee cd00d1        	call	_gran
6093  10f1 5b04          	addw	sp,#4
6094                     ; 1083 	if(umax_cnt>=10)flags|=0b00001000;
6096  10f3 9c            	rvf
6097  10f4 be66          	ldw	x,_umax_cnt
6098  10f6 a3000a        	cpw	x,#10
6099  10f9 2f04          	jrslt	L1372
6102  10fb 7216000b      	bset	_flags,#3
6103  10ff               L1372:
6104                     ; 1086 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6106  10ff 9c            	rvf
6107  1100 be6b          	ldw	x,_Ui
6108  1102 a300c8        	cpw	x,#200
6109  1105 2e10          	jrsge	L3372
6111  1107 c65005        	ld	a,20485
6112  110a a504          	bcp	a,#4
6113  110c 2609          	jrne	L3372
6116  110e be64          	ldw	x,_umin_cnt
6117  1110 1c0001        	addw	x,#1
6118  1113 bf64          	ldw	_umin_cnt,x
6120  1115 2003          	jra	L5372
6121  1117               L3372:
6122                     ; 1087 	else umin_cnt=0;
6124  1117 5f            	clrw	x
6125  1118 bf64          	ldw	_umin_cnt,x
6126  111a               L5372:
6127                     ; 1088 	gran(&umin_cnt,0,10);	
6129  111a ae000a        	ldw	x,#10
6130  111d 89            	pushw	x
6131  111e 5f            	clrw	x
6132  111f 89            	pushw	x
6133  1120 ae0064        	ldw	x,#_umin_cnt
6134  1123 cd00d1        	call	_gran
6136  1126 5b04          	addw	sp,#4
6137                     ; 1089 	if(umin_cnt>=10)flags|=0b00010000;	  
6139  1128 9c            	rvf
6140  1129 be64          	ldw	x,_umin_cnt
6141  112b a3000a        	cpw	x,#10
6142  112e 2f04          	jrslt	L1272
6145  1130 7218000b      	bset	_flags,#4
6146  1134               L1272:
6147                     ; 1091 }
6150  1134 81            	ret
6177                     ; 1094 void x_drv(void)
6177                     ; 1095 {
6178                     	switch	.text
6179  1135               _x_drv:
6183                     ; 1096 if(_x__==_x_)
6185  1135 be5c          	ldw	x,__x__
6186  1137 b35e          	cpw	x,__x_
6187  1139 262a          	jrne	L1572
6188                     ; 1098 	if(_x_cnt<60)
6190  113b 9c            	rvf
6191  113c be5a          	ldw	x,__x_cnt
6192  113e a3003c        	cpw	x,#60
6193  1141 2e25          	jrsge	L1672
6194                     ; 1100 		_x_cnt++;
6196  1143 be5a          	ldw	x,__x_cnt
6197  1145 1c0001        	addw	x,#1
6198  1148 bf5a          	ldw	__x_cnt,x
6199                     ; 1101 		if(_x_cnt>=60)
6201  114a 9c            	rvf
6202  114b be5a          	ldw	x,__x_cnt
6203  114d a3003c        	cpw	x,#60
6204  1150 2f16          	jrslt	L1672
6205                     ; 1103 			if(_x_ee_!=_x_)_x_ee_=_x_;
6207  1152 ce0018        	ldw	x,__x_ee_
6208  1155 b35e          	cpw	x,__x_
6209  1157 270f          	jreq	L1672
6212  1159 be5e          	ldw	x,__x_
6213  115b 89            	pushw	x
6214  115c ae0018        	ldw	x,#__x_ee_
6215  115f cd0000        	call	c_eewrw
6217  1162 85            	popw	x
6218  1163 2003          	jra	L1672
6219  1165               L1572:
6220                     ; 1108 else _x_cnt=0;
6222  1165 5f            	clrw	x
6223  1166 bf5a          	ldw	__x_cnt,x
6224  1168               L1672:
6225                     ; 1110 if(_x_cnt>60) _x_cnt=0;	
6227  1168 9c            	rvf
6228  1169 be5a          	ldw	x,__x_cnt
6229  116b a3003d        	cpw	x,#61
6230  116e 2f03          	jrslt	L3672
6233  1170 5f            	clrw	x
6234  1171 bf5a          	ldw	__x_cnt,x
6235  1173               L3672:
6236                     ; 1112 _x__=_x_;
6238  1173 be5e          	ldw	x,__x_
6239  1175 bf5c          	ldw	__x__,x
6240                     ; 1113 }
6243  1177 81            	ret
6269                     ; 1116 void apv_start(void)
6269                     ; 1117 {
6270                     	switch	.text
6271  1178               _apv_start:
6275                     ; 1118 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6277  1178 3d45          	tnz	_apv_cnt
6278  117a 2624          	jrne	L5772
6280  117c 3d46          	tnz	_apv_cnt+1
6281  117e 2620          	jrne	L5772
6283  1180 3d47          	tnz	_apv_cnt+2
6284  1182 261c          	jrne	L5772
6286                     	btst	_bAPV
6287  1189 2515          	jrult	L5772
6288                     ; 1120 	apv_cnt[0]=60;
6290  118b 353c0045      	mov	_apv_cnt,#60
6291                     ; 1121 	apv_cnt[1]=60;
6293  118f 353c0046      	mov	_apv_cnt+1,#60
6294                     ; 1122 	apv_cnt[2]=60;
6296  1193 353c0047      	mov	_apv_cnt+2,#60
6297                     ; 1123 	apv_cnt_=3600;
6299  1197 ae0e10        	ldw	x,#3600
6300  119a bf43          	ldw	_apv_cnt_,x
6301                     ; 1124 	bAPV=1;	
6303  119c 72100003      	bset	_bAPV
6304  11a0               L5772:
6305                     ; 1126 }
6308  11a0 81            	ret
6334                     ; 1129 void apv_stop(void)
6334                     ; 1130 {
6335                     	switch	.text
6336  11a1               _apv_stop:
6340                     ; 1131 apv_cnt[0]=0;
6342  11a1 3f45          	clr	_apv_cnt
6343                     ; 1132 apv_cnt[1]=0;
6345  11a3 3f46          	clr	_apv_cnt+1
6346                     ; 1133 apv_cnt[2]=0;
6348  11a5 3f47          	clr	_apv_cnt+2
6349                     ; 1134 apv_cnt_=0;	
6351  11a7 5f            	clrw	x
6352  11a8 bf43          	ldw	_apv_cnt_,x
6353                     ; 1135 bAPV=0;
6355  11aa 72110003      	bres	_bAPV
6356                     ; 1136 }
6359  11ae 81            	ret
6394                     ; 1140 void apv_hndl(void)
6394                     ; 1141 {
6395                     	switch	.text
6396  11af               _apv_hndl:
6400                     ; 1142 if(apv_cnt[0])
6402  11af 3d45          	tnz	_apv_cnt
6403  11b1 271e          	jreq	L7103
6404                     ; 1144 	apv_cnt[0]--;
6406  11b3 3a45          	dec	_apv_cnt
6407                     ; 1145 	if(apv_cnt[0]==0)
6409  11b5 3d45          	tnz	_apv_cnt
6410  11b7 265a          	jrne	L3203
6411                     ; 1147 		flags&=0b11100001;
6413  11b9 b60b          	ld	a,_flags
6414  11bb a4e1          	and	a,#225
6415  11bd b70b          	ld	_flags,a
6416                     ; 1148 		tsign_cnt=0;
6418  11bf 5f            	clrw	x
6419  11c0 bf4d          	ldw	_tsign_cnt,x
6420                     ; 1149 		tmax_cnt=0;
6422  11c2 5f            	clrw	x
6423  11c3 bf4b          	ldw	_tmax_cnt,x
6424                     ; 1150 		umax_cnt=0;
6426  11c5 5f            	clrw	x
6427  11c6 bf66          	ldw	_umax_cnt,x
6428                     ; 1151 		umin_cnt=0;
6430  11c8 5f            	clrw	x
6431  11c9 bf64          	ldw	_umin_cnt,x
6432                     ; 1153 		led_drv_cnt=30;
6434  11cb 351e001c      	mov	_led_drv_cnt,#30
6435  11cf 2042          	jra	L3203
6436  11d1               L7103:
6437                     ; 1156 else if(apv_cnt[1])
6439  11d1 3d46          	tnz	_apv_cnt+1
6440  11d3 271e          	jreq	L5203
6441                     ; 1158 	apv_cnt[1]--;
6443  11d5 3a46          	dec	_apv_cnt+1
6444                     ; 1159 	if(apv_cnt[1]==0)
6446  11d7 3d46          	tnz	_apv_cnt+1
6447  11d9 2638          	jrne	L3203
6448                     ; 1161 		flags&=0b11100001;
6450  11db b60b          	ld	a,_flags
6451  11dd a4e1          	and	a,#225
6452  11df b70b          	ld	_flags,a
6453                     ; 1162 		tsign_cnt=0;
6455  11e1 5f            	clrw	x
6456  11e2 bf4d          	ldw	_tsign_cnt,x
6457                     ; 1163 		tmax_cnt=0;
6459  11e4 5f            	clrw	x
6460  11e5 bf4b          	ldw	_tmax_cnt,x
6461                     ; 1164 		umax_cnt=0;
6463  11e7 5f            	clrw	x
6464  11e8 bf66          	ldw	_umax_cnt,x
6465                     ; 1165 		umin_cnt=0;
6467  11ea 5f            	clrw	x
6468  11eb bf64          	ldw	_umin_cnt,x
6469                     ; 1167 		led_drv_cnt=30;
6471  11ed 351e001c      	mov	_led_drv_cnt,#30
6472  11f1 2020          	jra	L3203
6473  11f3               L5203:
6474                     ; 1170 else if(apv_cnt[2])
6476  11f3 3d47          	tnz	_apv_cnt+2
6477  11f5 271c          	jreq	L3203
6478                     ; 1172 	apv_cnt[2]--;
6480  11f7 3a47          	dec	_apv_cnt+2
6481                     ; 1173 	if(apv_cnt[2]==0)
6483  11f9 3d47          	tnz	_apv_cnt+2
6484  11fb 2616          	jrne	L3203
6485                     ; 1175 		flags&=0b11100001;
6487  11fd b60b          	ld	a,_flags
6488  11ff a4e1          	and	a,#225
6489  1201 b70b          	ld	_flags,a
6490                     ; 1176 		tsign_cnt=0;
6492  1203 5f            	clrw	x
6493  1204 bf4d          	ldw	_tsign_cnt,x
6494                     ; 1177 		tmax_cnt=0;
6496  1206 5f            	clrw	x
6497  1207 bf4b          	ldw	_tmax_cnt,x
6498                     ; 1178 		umax_cnt=0;
6500  1209 5f            	clrw	x
6501  120a bf66          	ldw	_umax_cnt,x
6502                     ; 1179 		umin_cnt=0;          
6504  120c 5f            	clrw	x
6505  120d bf64          	ldw	_umin_cnt,x
6506                     ; 1181 		led_drv_cnt=30;
6508  120f 351e001c      	mov	_led_drv_cnt,#30
6509  1213               L3203:
6510                     ; 1185 if(apv_cnt_)
6512  1213 be43          	ldw	x,_apv_cnt_
6513  1215 2712          	jreq	L7303
6514                     ; 1187 	apv_cnt_--;
6516  1217 be43          	ldw	x,_apv_cnt_
6517  1219 1d0001        	subw	x,#1
6518  121c bf43          	ldw	_apv_cnt_,x
6519                     ; 1188 	if(apv_cnt_==0) 
6521  121e be43          	ldw	x,_apv_cnt_
6522  1220 2607          	jrne	L7303
6523                     ; 1190 		bAPV=0;
6525  1222 72110003      	bres	_bAPV
6526                     ; 1191 		apv_start();
6528  1226 cd1178        	call	_apv_start
6530  1229               L7303:
6531                     ; 1195 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6533  1229 be64          	ldw	x,_umin_cnt
6534  122b 261e          	jrne	L3403
6536  122d be66          	ldw	x,_umax_cnt
6537  122f 261a          	jrne	L3403
6539  1231 c65005        	ld	a,20485
6540  1234 a504          	bcp	a,#4
6541  1236 2613          	jrne	L3403
6542                     ; 1197 	if(cnt_apv_off<20)
6544  1238 b642          	ld	a,_cnt_apv_off
6545  123a a114          	cp	a,#20
6546  123c 240f          	jruge	L1503
6547                     ; 1199 		cnt_apv_off++;
6549  123e 3c42          	inc	_cnt_apv_off
6550                     ; 1200 		if(cnt_apv_off>=20)
6552  1240 b642          	ld	a,_cnt_apv_off
6553  1242 a114          	cp	a,#20
6554  1244 2507          	jrult	L1503
6555                     ; 1202 			apv_stop();
6557  1246 cd11a1        	call	_apv_stop
6559  1249 2002          	jra	L1503
6560  124b               L3403:
6561                     ; 1206 else cnt_apv_off=0;	
6563  124b 3f42          	clr	_cnt_apv_off
6564  124d               L1503:
6565                     ; 1208 }
6568  124d 81            	ret
6571                     	switch	.ubsct
6572  0000               L3503_flags_old:
6573  0000 00            	ds.b	1
6609                     ; 1211 void flags_drv(void)
6609                     ; 1212 {
6610                     	switch	.text
6611  124e               _flags_drv:
6615                     ; 1214 if(jp_mode!=jp3) 
6617  124e b64a          	ld	a,_jp_mode
6618  1250 a103          	cp	a,#3
6619  1252 2723          	jreq	L3703
6620                     ; 1216 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6622  1254 b60b          	ld	a,_flags
6623  1256 a508          	bcp	a,#8
6624  1258 2706          	jreq	L1013
6626  125a b600          	ld	a,L3503_flags_old
6627  125c a508          	bcp	a,#8
6628  125e 270c          	jreq	L7703
6629  1260               L1013:
6631  1260 b60b          	ld	a,_flags
6632  1262 a510          	bcp	a,#16
6633  1264 2726          	jreq	L5013
6635  1266 b600          	ld	a,L3503_flags_old
6636  1268 a510          	bcp	a,#16
6637  126a 2620          	jrne	L5013
6638  126c               L7703:
6639                     ; 1218     		if(link==OFF)apv_start();
6641  126c b663          	ld	a,_link
6642  126e a1aa          	cp	a,#170
6643  1270 261a          	jrne	L5013
6646  1272 cd1178        	call	_apv_start
6648  1275 2015          	jra	L5013
6649  1277               L3703:
6650                     ; 1221 else if(jp_mode==jp3) 
6652  1277 b64a          	ld	a,_jp_mode
6653  1279 a103          	cp	a,#3
6654  127b 260f          	jrne	L5013
6655                     ; 1223 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6657  127d b60b          	ld	a,_flags
6658  127f a508          	bcp	a,#8
6659  1281 2709          	jreq	L5013
6661  1283 b600          	ld	a,L3503_flags_old
6662  1285 a508          	bcp	a,#8
6663  1287 2603          	jrne	L5013
6664                     ; 1225     		apv_start();
6666  1289 cd1178        	call	_apv_start
6668  128c               L5013:
6669                     ; 1228 flags_old=flags;
6671  128c 450b00        	mov	L3503_flags_old,_flags
6672                     ; 1230 } 
6675  128f 81            	ret
6710                     ; 1367 void adr_drv_v4(char in)
6710                     ; 1368 {
6711                     	switch	.text
6712  1290               _adr_drv_v4:
6716                     ; 1369 if(adress!=in)adress=in;
6718  1290 c10005        	cp	a,_adress
6719  1293 2703          	jreq	L1313
6722  1295 c70005        	ld	_adress,a
6723  1298               L1313:
6724                     ; 1370 }
6727  1298 81            	ret
6756                     ; 1373 void adr_drv_v3(void)
6756                     ; 1374 {
6757                     	switch	.text
6758  1299               _adr_drv_v3:
6760  1299 88            	push	a
6761       00000001      OFST:	set	1
6764                     ; 1380 GPIOB->DDR&=~(1<<0);
6766  129a 72115007      	bres	20487,#0
6767                     ; 1381 GPIOB->CR1&=~(1<<0);
6769  129e 72115008      	bres	20488,#0
6770                     ; 1382 GPIOB->CR2&=~(1<<0);
6772  12a2 72115009      	bres	20489,#0
6773                     ; 1383 ADC2->CR2=0x08;
6775  12a6 35085402      	mov	21506,#8
6776                     ; 1384 ADC2->CR1=0x40;
6778  12aa 35405401      	mov	21505,#64
6779                     ; 1385 ADC2->CSR=0x20+0;
6781  12ae 35205400      	mov	21504,#32
6782                     ; 1386 ADC2->CR1|=1;
6784  12b2 72105401      	bset	21505,#0
6785                     ; 1387 ADC2->CR1|=1;
6787  12b6 72105401      	bset	21505,#0
6788                     ; 1388 adr_drv_stat=1;
6790  12ba 35010008      	mov	_adr_drv_stat,#1
6791  12be               L3413:
6792                     ; 1389 while(adr_drv_stat==1);
6795  12be b608          	ld	a,_adr_drv_stat
6796  12c0 a101          	cp	a,#1
6797  12c2 27fa          	jreq	L3413
6798                     ; 1391 GPIOB->DDR&=~(1<<1);
6800  12c4 72135007      	bres	20487,#1
6801                     ; 1392 GPIOB->CR1&=~(1<<1);
6803  12c8 72135008      	bres	20488,#1
6804                     ; 1393 GPIOB->CR2&=~(1<<1);
6806  12cc 72135009      	bres	20489,#1
6807                     ; 1394 ADC2->CR2=0x08;
6809  12d0 35085402      	mov	21506,#8
6810                     ; 1395 ADC2->CR1=0x40;
6812  12d4 35405401      	mov	21505,#64
6813                     ; 1396 ADC2->CSR=0x20+1;
6815  12d8 35215400      	mov	21504,#33
6816                     ; 1397 ADC2->CR1|=1;
6818  12dc 72105401      	bset	21505,#0
6819                     ; 1398 ADC2->CR1|=1;
6821  12e0 72105401      	bset	21505,#0
6822                     ; 1399 adr_drv_stat=3;
6824  12e4 35030008      	mov	_adr_drv_stat,#3
6825  12e8               L1513:
6826                     ; 1400 while(adr_drv_stat==3);
6829  12e8 b608          	ld	a,_adr_drv_stat
6830  12ea a103          	cp	a,#3
6831  12ec 27fa          	jreq	L1513
6832                     ; 1402 GPIOE->DDR&=~(1<<6);
6834  12ee 721d5016      	bres	20502,#6
6835                     ; 1403 GPIOE->CR1&=~(1<<6);
6837  12f2 721d5017      	bres	20503,#6
6838                     ; 1404 GPIOE->CR2&=~(1<<6);
6840  12f6 721d5018      	bres	20504,#6
6841                     ; 1405 ADC2->CR2=0x08;
6843  12fa 35085402      	mov	21506,#8
6844                     ; 1406 ADC2->CR1=0x40;
6846  12fe 35405401      	mov	21505,#64
6847                     ; 1407 ADC2->CSR=0x20+9;
6849  1302 35295400      	mov	21504,#41
6850                     ; 1408 ADC2->CR1|=1;
6852  1306 72105401      	bset	21505,#0
6853                     ; 1409 ADC2->CR1|=1;
6855  130a 72105401      	bset	21505,#0
6856                     ; 1410 adr_drv_stat=5;
6858  130e 35050008      	mov	_adr_drv_stat,#5
6859  1312               L7513:
6860                     ; 1411 while(adr_drv_stat==5);
6863  1312 b608          	ld	a,_adr_drv_stat
6864  1314 a105          	cp	a,#5
6865  1316 27fa          	jreq	L7513
6866                     ; 1415 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6868  1318 9c            	rvf
6869  1319 ce0009        	ldw	x,_adc_buff_
6870  131c a3022a        	cpw	x,#554
6871  131f 2f0f          	jrslt	L5613
6873  1321 9c            	rvf
6874  1322 ce0009        	ldw	x,_adc_buff_
6875  1325 a30253        	cpw	x,#595
6876  1328 2e06          	jrsge	L5613
6879  132a 725f0006      	clr	_adr
6881  132e 204c          	jra	L7613
6882  1330               L5613:
6883                     ; 1416 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6885  1330 9c            	rvf
6886  1331 ce0009        	ldw	x,_adc_buff_
6887  1334 a3036d        	cpw	x,#877
6888  1337 2f0f          	jrslt	L1713
6890  1339 9c            	rvf
6891  133a ce0009        	ldw	x,_adc_buff_
6892  133d a30396        	cpw	x,#918
6893  1340 2e06          	jrsge	L1713
6896  1342 35010006      	mov	_adr,#1
6898  1346 2034          	jra	L7613
6899  1348               L1713:
6900                     ; 1417 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6902  1348 9c            	rvf
6903  1349 ce0009        	ldw	x,_adc_buff_
6904  134c a302a3        	cpw	x,#675
6905  134f 2f0f          	jrslt	L5713
6907  1351 9c            	rvf
6908  1352 ce0009        	ldw	x,_adc_buff_
6909  1355 a302cc        	cpw	x,#716
6910  1358 2e06          	jrsge	L5713
6913  135a 35020006      	mov	_adr,#2
6915  135e 201c          	jra	L7613
6916  1360               L5713:
6917                     ; 1418 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6919  1360 9c            	rvf
6920  1361 ce0009        	ldw	x,_adc_buff_
6921  1364 a303e3        	cpw	x,#995
6922  1367 2f0f          	jrslt	L1023
6924  1369 9c            	rvf
6925  136a ce0009        	ldw	x,_adc_buff_
6926  136d a3040c        	cpw	x,#1036
6927  1370 2e06          	jrsge	L1023
6930  1372 35030006      	mov	_adr,#3
6932  1376 2004          	jra	L7613
6933  1378               L1023:
6934                     ; 1419 else adr[0]=5;
6936  1378 35050006      	mov	_adr,#5
6937  137c               L7613:
6938                     ; 1421 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6940  137c 9c            	rvf
6941  137d ce000b        	ldw	x,_adc_buff_+2
6942  1380 a3022a        	cpw	x,#554
6943  1383 2f0f          	jrslt	L5023
6945  1385 9c            	rvf
6946  1386 ce000b        	ldw	x,_adc_buff_+2
6947  1389 a30253        	cpw	x,#595
6948  138c 2e06          	jrsge	L5023
6951  138e 725f0007      	clr	_adr+1
6953  1392 204c          	jra	L7023
6954  1394               L5023:
6955                     ; 1422 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6957  1394 9c            	rvf
6958  1395 ce000b        	ldw	x,_adc_buff_+2
6959  1398 a3036d        	cpw	x,#877
6960  139b 2f0f          	jrslt	L1123
6962  139d 9c            	rvf
6963  139e ce000b        	ldw	x,_adc_buff_+2
6964  13a1 a30396        	cpw	x,#918
6965  13a4 2e06          	jrsge	L1123
6968  13a6 35010007      	mov	_adr+1,#1
6970  13aa 2034          	jra	L7023
6971  13ac               L1123:
6972                     ; 1423 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6974  13ac 9c            	rvf
6975  13ad ce000b        	ldw	x,_adc_buff_+2
6976  13b0 a302a3        	cpw	x,#675
6977  13b3 2f0f          	jrslt	L5123
6979  13b5 9c            	rvf
6980  13b6 ce000b        	ldw	x,_adc_buff_+2
6981  13b9 a302cc        	cpw	x,#716
6982  13bc 2e06          	jrsge	L5123
6985  13be 35020007      	mov	_adr+1,#2
6987  13c2 201c          	jra	L7023
6988  13c4               L5123:
6989                     ; 1424 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6991  13c4 9c            	rvf
6992  13c5 ce000b        	ldw	x,_adc_buff_+2
6993  13c8 a303e3        	cpw	x,#995
6994  13cb 2f0f          	jrslt	L1223
6996  13cd 9c            	rvf
6997  13ce ce000b        	ldw	x,_adc_buff_+2
6998  13d1 a3040c        	cpw	x,#1036
6999  13d4 2e06          	jrsge	L1223
7002  13d6 35030007      	mov	_adr+1,#3
7004  13da 2004          	jra	L7023
7005  13dc               L1223:
7006                     ; 1425 else adr[1]=5;
7008  13dc 35050007      	mov	_adr+1,#5
7009  13e0               L7023:
7010                     ; 1427 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
7012  13e0 9c            	rvf
7013  13e1 ce001b        	ldw	x,_adc_buff_+18
7014  13e4 a3022a        	cpw	x,#554
7015  13e7 2f0f          	jrslt	L5223
7017  13e9 9c            	rvf
7018  13ea ce001b        	ldw	x,_adc_buff_+18
7019  13ed a30253        	cpw	x,#595
7020  13f0 2e06          	jrsge	L5223
7023  13f2 725f0008      	clr	_adr+2
7025  13f6 204c          	jra	L7223
7026  13f8               L5223:
7027                     ; 1428 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
7029  13f8 9c            	rvf
7030  13f9 ce001b        	ldw	x,_adc_buff_+18
7031  13fc a3036d        	cpw	x,#877
7032  13ff 2f0f          	jrslt	L1323
7034  1401 9c            	rvf
7035  1402 ce001b        	ldw	x,_adc_buff_+18
7036  1405 a30396        	cpw	x,#918
7037  1408 2e06          	jrsge	L1323
7040  140a 35010008      	mov	_adr+2,#1
7042  140e 2034          	jra	L7223
7043  1410               L1323:
7044                     ; 1429 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
7046  1410 9c            	rvf
7047  1411 ce001b        	ldw	x,_adc_buff_+18
7048  1414 a302a3        	cpw	x,#675
7049  1417 2f0f          	jrslt	L5323
7051  1419 9c            	rvf
7052  141a ce001b        	ldw	x,_adc_buff_+18
7053  141d a302cc        	cpw	x,#716
7054  1420 2e06          	jrsge	L5323
7057  1422 35020008      	mov	_adr+2,#2
7059  1426 201c          	jra	L7223
7060  1428               L5323:
7061                     ; 1430 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
7063  1428 9c            	rvf
7064  1429 ce001b        	ldw	x,_adc_buff_+18
7065  142c a303e3        	cpw	x,#995
7066  142f 2f0f          	jrslt	L1423
7068  1431 9c            	rvf
7069  1432 ce001b        	ldw	x,_adc_buff_+18
7070  1435 a3040c        	cpw	x,#1036
7071  1438 2e06          	jrsge	L1423
7074  143a 35030008      	mov	_adr+2,#3
7076  143e 2004          	jra	L7223
7077  1440               L1423:
7078                     ; 1431 else adr[2]=5;
7080  1440 35050008      	mov	_adr+2,#5
7081  1444               L7223:
7082                     ; 1435 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
7084  1444 c60006        	ld	a,_adr
7085  1447 a105          	cp	a,#5
7086  1449 270e          	jreq	L7423
7088  144b c60007        	ld	a,_adr+1
7089  144e a105          	cp	a,#5
7090  1450 2707          	jreq	L7423
7092  1452 c60008        	ld	a,_adr+2
7093  1455 a105          	cp	a,#5
7094  1457 2606          	jrne	L5423
7095  1459               L7423:
7096                     ; 1438 	adress_error=1;
7098  1459 35010004      	mov	_adress_error,#1
7100  145d               L3523:
7101                     ; 1449 }
7104  145d 84            	pop	a
7105  145e 81            	ret
7106  145f               L5423:
7107                     ; 1442 	if(adr[2]&0x02) bps_class=bpsIPS;
7109  145f c60008        	ld	a,_adr+2
7110  1462 a502          	bcp	a,#2
7111  1464 2706          	jreq	L5523
7114  1466 35010004      	mov	_bps_class,#1
7116  146a 2002          	jra	L7523
7117  146c               L5523:
7118                     ; 1443 	else bps_class=bpsIBEP;
7120  146c 3f04          	clr	_bps_class
7121  146e               L7523:
7122                     ; 1445 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
7124  146e c60008        	ld	a,_adr+2
7125  1471 a401          	and	a,#1
7126  1473 97            	ld	xl,a
7127  1474 a610          	ld	a,#16
7128  1476 42            	mul	x,a
7129  1477 9f            	ld	a,xl
7130  1478 6b01          	ld	(OFST+0,sp),a
7131  147a c60007        	ld	a,_adr+1
7132  147d 48            	sll	a
7133  147e 48            	sll	a
7134  147f cb0006        	add	a,_adr
7135  1482 1b01          	add	a,(OFST+0,sp)
7136  1484 c70005        	ld	_adress,a
7137  1487 20d4          	jra	L3523
7181                     ; 1452 void volum_u_main_drv(void)
7181                     ; 1453 {
7182                     	switch	.text
7183  1489               _volum_u_main_drv:
7185  1489 88            	push	a
7186       00000001      OFST:	set	1
7189                     ; 1456 if(bMAIN)
7191                     	btst	_bMAIN
7192  148f 2503          	jrult	L241
7193  1491 cc15da        	jp	L7723
7194  1494               L241:
7195                     ; 1458 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7197  1494 9c            	rvf
7198  1495 ce0008        	ldw	x,_UU_AVT
7199  1498 1d000a        	subw	x,#10
7200  149b b36d          	cpw	x,_Un
7201  149d 2d09          	jrsle	L1033
7204  149f be1f          	ldw	x,_volum_u_main_
7205  14a1 1c0005        	addw	x,#5
7206  14a4 bf1f          	ldw	_volum_u_main_,x
7208  14a6 2036          	jra	L3033
7209  14a8               L1033:
7210                     ; 1459 	else if(Un<(UU_AVT-1))volum_u_main_++;
7212  14a8 9c            	rvf
7213  14a9 ce0008        	ldw	x,_UU_AVT
7214  14ac 5a            	decw	x
7215  14ad b36d          	cpw	x,_Un
7216  14af 2d09          	jrsle	L5033
7219  14b1 be1f          	ldw	x,_volum_u_main_
7220  14b3 1c0001        	addw	x,#1
7221  14b6 bf1f          	ldw	_volum_u_main_,x
7223  14b8 2024          	jra	L3033
7224  14ba               L5033:
7225                     ; 1460 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7227  14ba 9c            	rvf
7228  14bb ce0008        	ldw	x,_UU_AVT
7229  14be 1c000a        	addw	x,#10
7230  14c1 b36d          	cpw	x,_Un
7231  14c3 2e09          	jrsge	L1133
7234  14c5 be1f          	ldw	x,_volum_u_main_
7235  14c7 1d000a        	subw	x,#10
7236  14ca bf1f          	ldw	_volum_u_main_,x
7238  14cc 2010          	jra	L3033
7239  14ce               L1133:
7240                     ; 1461 	else if(Un>(UU_AVT+1))volum_u_main_--;
7242  14ce 9c            	rvf
7243  14cf ce0008        	ldw	x,_UU_AVT
7244  14d2 5c            	incw	x
7245  14d3 b36d          	cpw	x,_Un
7246  14d5 2e07          	jrsge	L3033
7249  14d7 be1f          	ldw	x,_volum_u_main_
7250  14d9 1d0001        	subw	x,#1
7251  14dc bf1f          	ldw	_volum_u_main_,x
7252  14de               L3033:
7253                     ; 1462 	if(volum_u_main_>1020)volum_u_main_=1020;
7255  14de 9c            	rvf
7256  14df be1f          	ldw	x,_volum_u_main_
7257  14e1 a303fd        	cpw	x,#1021
7258  14e4 2f05          	jrslt	L7133
7261  14e6 ae03fc        	ldw	x,#1020
7262  14e9 bf1f          	ldw	_volum_u_main_,x
7263  14eb               L7133:
7264                     ; 1463 	if(volum_u_main_<0)volum_u_main_=0;
7266  14eb 9c            	rvf
7267  14ec be1f          	ldw	x,_volum_u_main_
7268  14ee 2e03          	jrsge	L1233
7271  14f0 5f            	clrw	x
7272  14f1 bf1f          	ldw	_volum_u_main_,x
7273  14f3               L1233:
7274                     ; 1466 	i_main_sigma=0;
7276  14f3 5f            	clrw	x
7277  14f4 bf0f          	ldw	_i_main_sigma,x
7278                     ; 1467 	i_main_num_of_bps=0;
7280  14f6 3f11          	clr	_i_main_num_of_bps
7281                     ; 1468 	for(i=0;i<6;i++)
7283  14f8 0f01          	clr	(OFST+0,sp)
7284  14fa               L3233:
7285                     ; 1470 		if(i_main_flag[i])
7287  14fa 7b01          	ld	a,(OFST+0,sp)
7288  14fc 5f            	clrw	x
7289  14fd 97            	ld	xl,a
7290  14fe 6d14          	tnz	(_i_main_flag,x)
7291  1500 2719          	jreq	L1333
7292                     ; 1472 			i_main_sigma+=i_main[i];
7294  1502 7b01          	ld	a,(OFST+0,sp)
7295  1504 5f            	clrw	x
7296  1505 97            	ld	xl,a
7297  1506 58            	sllw	x
7298  1507 ee1a          	ldw	x,(_i_main,x)
7299  1509 72bb000f      	addw	x,_i_main_sigma
7300  150d bf0f          	ldw	_i_main_sigma,x
7301                     ; 1473 			i_main_flag[i]=1;
7303  150f 7b01          	ld	a,(OFST+0,sp)
7304  1511 5f            	clrw	x
7305  1512 97            	ld	xl,a
7306  1513 a601          	ld	a,#1
7307  1515 e714          	ld	(_i_main_flag,x),a
7308                     ; 1474 			i_main_num_of_bps++;
7310  1517 3c11          	inc	_i_main_num_of_bps
7312  1519 2006          	jra	L3333
7313  151b               L1333:
7314                     ; 1478 			i_main_flag[i]=0;	
7316  151b 7b01          	ld	a,(OFST+0,sp)
7317  151d 5f            	clrw	x
7318  151e 97            	ld	xl,a
7319  151f 6f14          	clr	(_i_main_flag,x)
7320  1521               L3333:
7321                     ; 1468 	for(i=0;i<6;i++)
7323  1521 0c01          	inc	(OFST+0,sp)
7326  1523 7b01          	ld	a,(OFST+0,sp)
7327  1525 a106          	cp	a,#6
7328  1527 25d1          	jrult	L3233
7329                     ; 1481 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7331  1529 be0f          	ldw	x,_i_main_sigma
7332  152b b611          	ld	a,_i_main_num_of_bps
7333  152d 905f          	clrw	y
7334  152f 9097          	ld	yl,a
7335  1531 cd0000        	call	c_idiv
7337  1534 bf12          	ldw	_i_main_avg,x
7338                     ; 1482 	for(i=0;i<6;i++)
7340  1536 0f01          	clr	(OFST+0,sp)
7341  1538               L5333:
7342                     ; 1484 		if(i_main_flag[i])
7344  1538 7b01          	ld	a,(OFST+0,sp)
7345  153a 5f            	clrw	x
7346  153b 97            	ld	xl,a
7347  153c 6d14          	tnz	(_i_main_flag,x)
7348  153e 2603cc15cf    	jreq	L3433
7349                     ; 1486 			if(i_main[i]<(i_main_avg-10))x[i]++;
7351  1543 9c            	rvf
7352  1544 7b01          	ld	a,(OFST+0,sp)
7353  1546 5f            	clrw	x
7354  1547 97            	ld	xl,a
7355  1548 58            	sllw	x
7356  1549 90be12        	ldw	y,_i_main_avg
7357  154c 72a2000a      	subw	y,#10
7358  1550 90bf00        	ldw	c_y,y
7359  1553 9093          	ldw	y,x
7360  1555 90ee1a        	ldw	y,(_i_main,y)
7361  1558 90b300        	cpw	y,c_y
7362  155b 2e11          	jrsge	L5433
7365  155d 7b01          	ld	a,(OFST+0,sp)
7366  155f 5f            	clrw	x
7367  1560 97            	ld	xl,a
7368  1561 58            	sllw	x
7369  1562 9093          	ldw	y,x
7370  1564 ee26          	ldw	x,(_x,x)
7371  1566 1c0001        	addw	x,#1
7372  1569 90ef26        	ldw	(_x,y),x
7374  156c 2029          	jra	L7433
7375  156e               L5433:
7376                     ; 1487 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7378  156e 9c            	rvf
7379  156f 7b01          	ld	a,(OFST+0,sp)
7380  1571 5f            	clrw	x
7381  1572 97            	ld	xl,a
7382  1573 58            	sllw	x
7383  1574 90be12        	ldw	y,_i_main_avg
7384  1577 72a9000a      	addw	y,#10
7385  157b 90bf00        	ldw	c_y,y
7386  157e 9093          	ldw	y,x
7387  1580 90ee1a        	ldw	y,(_i_main,y)
7388  1583 90b300        	cpw	y,c_y
7389  1586 2d0f          	jrsle	L7433
7392  1588 7b01          	ld	a,(OFST+0,sp)
7393  158a 5f            	clrw	x
7394  158b 97            	ld	xl,a
7395  158c 58            	sllw	x
7396  158d 9093          	ldw	y,x
7397  158f ee26          	ldw	x,(_x,x)
7398  1591 1d0001        	subw	x,#1
7399  1594 90ef26        	ldw	(_x,y),x
7400  1597               L7433:
7401                     ; 1488 			if(x[i]>100)x[i]=100;
7403  1597 9c            	rvf
7404  1598 7b01          	ld	a,(OFST+0,sp)
7405  159a 5f            	clrw	x
7406  159b 97            	ld	xl,a
7407  159c 58            	sllw	x
7408  159d 9093          	ldw	y,x
7409  159f 90ee26        	ldw	y,(_x,y)
7410  15a2 90a30065      	cpw	y,#101
7411  15a6 2f0b          	jrslt	L3533
7414  15a8 7b01          	ld	a,(OFST+0,sp)
7415  15aa 5f            	clrw	x
7416  15ab 97            	ld	xl,a
7417  15ac 58            	sllw	x
7418  15ad 90ae0064      	ldw	y,#100
7419  15b1 ef26          	ldw	(_x,x),y
7420  15b3               L3533:
7421                     ; 1489 			if(x[i]<-100)x[i]=-100;
7423  15b3 9c            	rvf
7424  15b4 7b01          	ld	a,(OFST+0,sp)
7425  15b6 5f            	clrw	x
7426  15b7 97            	ld	xl,a
7427  15b8 58            	sllw	x
7428  15b9 9093          	ldw	y,x
7429  15bb 90ee26        	ldw	y,(_x,y)
7430  15be 90a3ff9c      	cpw	y,#65436
7431  15c2 2e0b          	jrsge	L3433
7434  15c4 7b01          	ld	a,(OFST+0,sp)
7435  15c6 5f            	clrw	x
7436  15c7 97            	ld	xl,a
7437  15c8 58            	sllw	x
7438  15c9 90aeff9c      	ldw	y,#65436
7439  15cd ef26          	ldw	(_x,x),y
7440  15cf               L3433:
7441                     ; 1482 	for(i=0;i<6;i++)
7443  15cf 0c01          	inc	(OFST+0,sp)
7446  15d1 7b01          	ld	a,(OFST+0,sp)
7447  15d3 a106          	cp	a,#6
7448  15d5 2403cc1538    	jrult	L5333
7449  15da               L7723:
7450                     ; 1496 }
7453  15da 84            	pop	a
7454  15db 81            	ret
7477                     ; 1499 void init_CAN(void) {
7478                     	switch	.text
7479  15dc               _init_CAN:
7483                     ; 1500 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7485  15dc 72135420      	bres	21536,#1
7486                     ; 1501 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7488  15e0 72105420      	bset	21536,#0
7490  15e4               L1733:
7491                     ; 1502 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7493  15e4 c65421        	ld	a,21537
7494  15e7 a501          	bcp	a,#1
7495  15e9 27f9          	jreq	L1733
7496                     ; 1504 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7498  15eb 72185420      	bset	21536,#4
7499                     ; 1506 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7501  15ef 35025427      	mov	21543,#2
7502                     ; 1515 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7504  15f3 35135428      	mov	21544,#19
7505                     ; 1516 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7507  15f7 35c05429      	mov	21545,#192
7508                     ; 1517 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7510  15fb 357f542c      	mov	21548,#127
7511                     ; 1518 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7513  15ff 35e0542d      	mov	21549,#224
7514                     ; 1520 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7516  1603 35315430      	mov	21552,#49
7517                     ; 1521 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7519  1607 35c05431      	mov	21553,#192
7520                     ; 1522 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7522  160b 357f5434      	mov	21556,#127
7523                     ; 1523 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7525  160f 35e05435      	mov	21557,#224
7526                     ; 1527 	CAN->PSR= 6;									// set page 6
7528  1613 35065427      	mov	21543,#6
7529                     ; 1532 	CAN->Page.Config.FMR1&=~3;								//mask mode
7531  1617 c65430        	ld	a,21552
7532  161a a4fc          	and	a,#252
7533  161c c75430        	ld	21552,a
7534                     ; 1538 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7536  161f 35065432      	mov	21554,#6
7537                     ; 1539 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7539  1623 35605432      	mov	21554,#96
7540                     ; 1542 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7542  1627 72105432      	bset	21554,#0
7543                     ; 1543 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7545  162b 72185432      	bset	21554,#4
7546                     ; 1546 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7548  162f 35065427      	mov	21543,#6
7549                     ; 1548 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7551  1633 3509542c      	mov	21548,#9
7552                     ; 1549 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7554  1637 35e7542d      	mov	21549,#231
7555                     ; 1551 	CAN->IER|=(1<<1);
7557  163b 72125425      	bset	21541,#1
7558                     ; 1554 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7560  163f 72115420      	bres	21536,#0
7562  1643               L7733:
7563                     ; 1555 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7565  1643 c65421        	ld	a,21537
7566  1646 a501          	bcp	a,#1
7567  1648 26f9          	jrne	L7733
7568                     ; 1556 }
7571  164a 81            	ret
7679                     ; 1559 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7679                     ; 1560 {
7680                     	switch	.text
7681  164b               _can_transmit:
7683  164b 89            	pushw	x
7684       00000000      OFST:	set	0
7687                     ; 1562 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7689  164c b674          	ld	a,_can_buff_wr_ptr
7690  164e a104          	cp	a,#4
7691  1650 2502          	jrult	L1643
7694  1652 3f74          	clr	_can_buff_wr_ptr
7695  1654               L1643:
7696                     ; 1564 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7698  1654 b674          	ld	a,_can_buff_wr_ptr
7699  1656 97            	ld	xl,a
7700  1657 a610          	ld	a,#16
7701  1659 42            	mul	x,a
7702  165a 1601          	ldw	y,(OFST+1,sp)
7703  165c a606          	ld	a,#6
7704  165e               L051:
7705  165e 9054          	srlw	y
7706  1660 4a            	dec	a
7707  1661 26fb          	jrne	L051
7708  1663 909f          	ld	a,yl
7709  1665 e775          	ld	(_can_out_buff,x),a
7710                     ; 1565 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7712  1667 b674          	ld	a,_can_buff_wr_ptr
7713  1669 97            	ld	xl,a
7714  166a a610          	ld	a,#16
7715  166c 42            	mul	x,a
7716  166d 7b02          	ld	a,(OFST+2,sp)
7717  166f 48            	sll	a
7718  1670 48            	sll	a
7719  1671 e776          	ld	(_can_out_buff+1,x),a
7720                     ; 1567 can_out_buff[can_buff_wr_ptr][2]=data0;
7722  1673 b674          	ld	a,_can_buff_wr_ptr
7723  1675 97            	ld	xl,a
7724  1676 a610          	ld	a,#16
7725  1678 42            	mul	x,a
7726  1679 7b05          	ld	a,(OFST+5,sp)
7727  167b e777          	ld	(_can_out_buff+2,x),a
7728                     ; 1568 can_out_buff[can_buff_wr_ptr][3]=data1;
7730  167d b674          	ld	a,_can_buff_wr_ptr
7731  167f 97            	ld	xl,a
7732  1680 a610          	ld	a,#16
7733  1682 42            	mul	x,a
7734  1683 7b06          	ld	a,(OFST+6,sp)
7735  1685 e778          	ld	(_can_out_buff+3,x),a
7736                     ; 1569 can_out_buff[can_buff_wr_ptr][4]=data2;
7738  1687 b674          	ld	a,_can_buff_wr_ptr
7739  1689 97            	ld	xl,a
7740  168a a610          	ld	a,#16
7741  168c 42            	mul	x,a
7742  168d 7b07          	ld	a,(OFST+7,sp)
7743  168f e779          	ld	(_can_out_buff+4,x),a
7744                     ; 1570 can_out_buff[can_buff_wr_ptr][5]=data3;
7746  1691 b674          	ld	a,_can_buff_wr_ptr
7747  1693 97            	ld	xl,a
7748  1694 a610          	ld	a,#16
7749  1696 42            	mul	x,a
7750  1697 7b08          	ld	a,(OFST+8,sp)
7751  1699 e77a          	ld	(_can_out_buff+5,x),a
7752                     ; 1571 can_out_buff[can_buff_wr_ptr][6]=data4;
7754  169b b674          	ld	a,_can_buff_wr_ptr
7755  169d 97            	ld	xl,a
7756  169e a610          	ld	a,#16
7757  16a0 42            	mul	x,a
7758  16a1 7b09          	ld	a,(OFST+9,sp)
7759  16a3 e77b          	ld	(_can_out_buff+6,x),a
7760                     ; 1572 can_out_buff[can_buff_wr_ptr][7]=data5;
7762  16a5 b674          	ld	a,_can_buff_wr_ptr
7763  16a7 97            	ld	xl,a
7764  16a8 a610          	ld	a,#16
7765  16aa 42            	mul	x,a
7766  16ab 7b0a          	ld	a,(OFST+10,sp)
7767  16ad e77c          	ld	(_can_out_buff+7,x),a
7768                     ; 1573 can_out_buff[can_buff_wr_ptr][8]=data6;
7770  16af b674          	ld	a,_can_buff_wr_ptr
7771  16b1 97            	ld	xl,a
7772  16b2 a610          	ld	a,#16
7773  16b4 42            	mul	x,a
7774  16b5 7b0b          	ld	a,(OFST+11,sp)
7775  16b7 e77d          	ld	(_can_out_buff+8,x),a
7776                     ; 1574 can_out_buff[can_buff_wr_ptr][9]=data7;
7778  16b9 b674          	ld	a,_can_buff_wr_ptr
7779  16bb 97            	ld	xl,a
7780  16bc a610          	ld	a,#16
7781  16be 42            	mul	x,a
7782  16bf 7b0c          	ld	a,(OFST+12,sp)
7783  16c1 e77e          	ld	(_can_out_buff+9,x),a
7784                     ; 1576 can_buff_wr_ptr++;
7786  16c3 3c74          	inc	_can_buff_wr_ptr
7787                     ; 1577 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7789  16c5 b674          	ld	a,_can_buff_wr_ptr
7790  16c7 a104          	cp	a,#4
7791  16c9 2502          	jrult	L3643
7794  16cb 3f74          	clr	_can_buff_wr_ptr
7795  16cd               L3643:
7796                     ; 1578 } 
7799  16cd 85            	popw	x
7800  16ce 81            	ret
7829                     ; 1581 void can_tx_hndl(void)
7829                     ; 1582 {
7830                     	switch	.text
7831  16cf               _can_tx_hndl:
7835                     ; 1583 if(bTX_FREE)
7837  16cf 3d09          	tnz	_bTX_FREE
7838  16d1 2757          	jreq	L5743
7839                     ; 1585 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7841  16d3 b673          	ld	a,_can_buff_rd_ptr
7842  16d5 b174          	cp	a,_can_buff_wr_ptr
7843  16d7 275f          	jreq	L3053
7844                     ; 1587 		bTX_FREE=0;
7846  16d9 3f09          	clr	_bTX_FREE
7847                     ; 1589 		CAN->PSR= 0;
7849  16db 725f5427      	clr	21543
7850                     ; 1590 		CAN->Page.TxMailbox.MDLCR=8;
7852  16df 35085429      	mov	21545,#8
7853                     ; 1591 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7855  16e3 b673          	ld	a,_can_buff_rd_ptr
7856  16e5 97            	ld	xl,a
7857  16e6 a610          	ld	a,#16
7858  16e8 42            	mul	x,a
7859  16e9 e675          	ld	a,(_can_out_buff,x)
7860  16eb c7542a        	ld	21546,a
7861                     ; 1592 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7863  16ee b673          	ld	a,_can_buff_rd_ptr
7864  16f0 97            	ld	xl,a
7865  16f1 a610          	ld	a,#16
7866  16f3 42            	mul	x,a
7867  16f4 e676          	ld	a,(_can_out_buff+1,x)
7868  16f6 c7542b        	ld	21547,a
7869                     ; 1594 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7871  16f9 b673          	ld	a,_can_buff_rd_ptr
7872  16fb 97            	ld	xl,a
7873  16fc a610          	ld	a,#16
7874  16fe 42            	mul	x,a
7875  16ff 01            	rrwa	x,a
7876  1700 ab77          	add	a,#_can_out_buff+2
7877  1702 2401          	jrnc	L451
7878  1704 5c            	incw	x
7879  1705               L451:
7880  1705 5f            	clrw	x
7881  1706 97            	ld	xl,a
7882  1707 bf00          	ldw	c_x,x
7883  1709 ae0008        	ldw	x,#8
7884  170c               L651:
7885  170c 5a            	decw	x
7886  170d 92d600        	ld	a,([c_x],x)
7887  1710 d7542e        	ld	(21550,x),a
7888  1713 5d            	tnzw	x
7889  1714 26f6          	jrne	L651
7890                     ; 1596 		can_buff_rd_ptr++;
7892  1716 3c73          	inc	_can_buff_rd_ptr
7893                     ; 1597 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7895  1718 b673          	ld	a,_can_buff_rd_ptr
7896  171a a104          	cp	a,#4
7897  171c 2502          	jrult	L1053
7900  171e 3f73          	clr	_can_buff_rd_ptr
7901  1720               L1053:
7902                     ; 1599 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7904  1720 72105428      	bset	21544,#0
7905                     ; 1600 		CAN->IER|=(1<<0);
7907  1724 72105425      	bset	21541,#0
7908  1728 200e          	jra	L3053
7909  172a               L5743:
7910                     ; 1605 	tx_busy_cnt++;
7912  172a 3c72          	inc	_tx_busy_cnt
7913                     ; 1606 	if(tx_busy_cnt>=100)
7915  172c b672          	ld	a,_tx_busy_cnt
7916  172e a164          	cp	a,#100
7917  1730 2506          	jrult	L3053
7918                     ; 1608 		tx_busy_cnt=0;
7920  1732 3f72          	clr	_tx_busy_cnt
7921                     ; 1609 		bTX_FREE=1;
7923  1734 35010009      	mov	_bTX_FREE,#1
7924  1738               L3053:
7925                     ; 1612 }
7928  1738 81            	ret
7967                     ; 1615 void net_drv(void)
7967                     ; 1616 { 
7968                     	switch	.text
7969  1739               _net_drv:
7973                     ; 1618 if(bMAIN)
7975                     	btst	_bMAIN
7976  173e 2503          	jrult	L261
7977  1740 cc17e6        	jp	L7153
7978  1743               L261:
7979                     ; 1620 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7981  1743 3c32          	inc	_cnt_net_drv
7982  1745 b632          	ld	a,_cnt_net_drv
7983  1747 a107          	cp	a,#7
7984  1749 2502          	jrult	L1253
7987  174b 3f32          	clr	_cnt_net_drv
7988  174d               L1253:
7989                     ; 1622 	if(cnt_net_drv<=5) 
7991  174d b632          	ld	a,_cnt_net_drv
7992  174f a106          	cp	a,#6
7993  1751 244c          	jruge	L3253
7994                     ; 1624 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7996  1753 4be8          	push	#232
7997  1755 4be8          	push	#232
7998  1757 b632          	ld	a,_cnt_net_drv
7999  1759 5f            	clrw	x
8000  175a 97            	ld	xl,a
8001  175b 58            	sllw	x
8002  175c ee26          	ldw	x,(_x,x)
8003  175e 72bb001f      	addw	x,_volum_u_main_
8004  1762 90ae0100      	ldw	y,#256
8005  1766 cd0000        	call	c_idiv
8007  1769 9f            	ld	a,xl
8008  176a 88            	push	a
8009  176b b632          	ld	a,_cnt_net_drv
8010  176d 5f            	clrw	x
8011  176e 97            	ld	xl,a
8012  176f 58            	sllw	x
8013  1770 e627          	ld	a,(_x+1,x)
8014  1772 bb20          	add	a,_volum_u_main_+1
8015  1774 88            	push	a
8016  1775 4b00          	push	#0
8017  1777 4bed          	push	#237
8018  1779 3b0032        	push	_cnt_net_drv
8019  177c 3b0032        	push	_cnt_net_drv
8020  177f ae009e        	ldw	x,#158
8021  1782 cd164b        	call	_can_transmit
8023  1785 5b08          	addw	sp,#8
8024                     ; 1625 		i_main_bps_cnt[cnt_net_drv]++;
8026  1787 b632          	ld	a,_cnt_net_drv
8027  1789 5f            	clrw	x
8028  178a 97            	ld	xl,a
8029  178b 6c09          	inc	(_i_main_bps_cnt,x)
8030                     ; 1626 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
8032  178d b632          	ld	a,_cnt_net_drv
8033  178f 5f            	clrw	x
8034  1790 97            	ld	xl,a
8035  1791 e609          	ld	a,(_i_main_bps_cnt,x)
8036  1793 a10b          	cp	a,#11
8037  1795 254f          	jrult	L7153
8040  1797 b632          	ld	a,_cnt_net_drv
8041  1799 5f            	clrw	x
8042  179a 97            	ld	xl,a
8043  179b 6f14          	clr	(_i_main_flag,x)
8044  179d 2047          	jra	L7153
8045  179f               L3253:
8046                     ; 1628 	else if(cnt_net_drv==6)
8048  179f b632          	ld	a,_cnt_net_drv
8049  17a1 a106          	cp	a,#6
8050  17a3 2641          	jrne	L7153
8051                     ; 1630 		plazma_int[2]=pwm_u;
8053  17a5 be0e          	ldw	x,_pwm_u
8054  17a7 bf37          	ldw	_plazma_int+4,x
8055                     ; 1631 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8057  17a9 3b006b        	push	_Ui
8058  17ac 3b006c        	push	_Ui+1
8059  17af 3b006d        	push	_Un
8060  17b2 3b006e        	push	_Un+1
8061  17b5 3b006f        	push	_I
8062  17b8 3b0070        	push	_I+1
8063  17bb 4bda          	push	#218
8064  17bd 3b0005        	push	_adress
8065  17c0 ae018e        	ldw	x,#398
8066  17c3 cd164b        	call	_can_transmit
8068  17c6 5b08          	addw	sp,#8
8069                     ; 1632 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8071  17c8 3b0037        	push	_plazma_int+4
8072  17cb 3b0038        	push	_plazma_int+5
8073  17ce 3b005f        	push	__x_+1
8074  17d1 3b000b        	push	_flags
8075  17d4 4b00          	push	#0
8076  17d6 3b0068        	push	_T
8077  17d9 4bdb          	push	#219
8078  17db 3b0005        	push	_adress
8079  17de ae018e        	ldw	x,#398
8080  17e1 cd164b        	call	_can_transmit
8082  17e4 5b08          	addw	sp,#8
8083  17e6               L7153:
8084                     ; 1635 }
8087  17e6 81            	ret
8201                     ; 1638 void can_in_an(void)
8201                     ; 1639 {
8202                     	switch	.text
8203  17e7               _can_in_an:
8205  17e7 5205          	subw	sp,#5
8206       00000005      OFST:	set	5
8209                     ; 1649 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8211  17e9 b6ca          	ld	a,_mess+6
8212  17eb c10005        	cp	a,_adress
8213  17ee 2703          	jreq	L402
8214  17f0 cc190c        	jp	L7653
8215  17f3               L402:
8217  17f3 b6cb          	ld	a,_mess+7
8218  17f5 c10005        	cp	a,_adress
8219  17f8 2703          	jreq	L602
8220  17fa cc190c        	jp	L7653
8221  17fd               L602:
8223  17fd b6cc          	ld	a,_mess+8
8224  17ff a1ed          	cp	a,#237
8225  1801 2703          	jreq	L012
8226  1803 cc190c        	jp	L7653
8227  1806               L012:
8228                     ; 1652 	can_error_cnt=0;
8230  1806 3f71          	clr	_can_error_cnt
8231                     ; 1654 	bMAIN=0;
8233  1808 72110002      	bres	_bMAIN
8234                     ; 1655  	flags_tu=mess[9];
8236  180c 45cd60        	mov	_flags_tu,_mess+9
8237                     ; 1656  	if(flags_tu&0b00000001)
8239  180f b660          	ld	a,_flags_tu
8240  1811 a501          	bcp	a,#1
8241  1813 2706          	jreq	L1753
8242                     ; 1661  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8244  1815 721a000b      	bset	_flags,#5
8246  1819 200e          	jra	L3753
8247  181b               L1753:
8248                     ; 1672  				flags&=0b11011111; 
8250  181b 721b000b      	bres	_flags,#5
8251                     ; 1673  				off_bp_cnt=5*ee_TZAS;
8253  181f c60017        	ld	a,_ee_TZAS+1
8254  1822 97            	ld	xl,a
8255  1823 a605          	ld	a,#5
8256  1825 42            	mul	x,a
8257  1826 9f            	ld	a,xl
8258  1827 b753          	ld	_off_bp_cnt,a
8259  1829               L3753:
8260                     ; 1679  	if(flags_tu&0b00000010) flags|=0b01000000;
8262  1829 b660          	ld	a,_flags_tu
8263  182b a502          	bcp	a,#2
8264  182d 2706          	jreq	L5753
8267  182f 721c000b      	bset	_flags,#6
8269  1833 2004          	jra	L7753
8270  1835               L5753:
8271                     ; 1680  	else flags&=0b10111111; 
8273  1835 721d000b      	bres	_flags,#6
8274  1839               L7753:
8275                     ; 1682  	vol_u_temp=mess[10]+mess[11]*256;
8277  1839 b6cf          	ld	a,_mess+11
8278  183b 5f            	clrw	x
8279  183c 97            	ld	xl,a
8280  183d 4f            	clr	a
8281  183e 02            	rlwa	x,a
8282  183f 01            	rrwa	x,a
8283  1840 bbce          	add	a,_mess+10
8284  1842 2401          	jrnc	L661
8285  1844 5c            	incw	x
8286  1845               L661:
8287  1845 b759          	ld	_vol_u_temp+1,a
8288  1847 9f            	ld	a,xl
8289  1848 b758          	ld	_vol_u_temp,a
8290                     ; 1683  	vol_i_temp=mess[12]+mess[13]*256;  
8292  184a b6d1          	ld	a,_mess+13
8293  184c 5f            	clrw	x
8294  184d 97            	ld	xl,a
8295  184e 4f            	clr	a
8296  184f 02            	rlwa	x,a
8297  1850 01            	rrwa	x,a
8298  1851 bbd0          	add	a,_mess+12
8299  1853 2401          	jrnc	L071
8300  1855 5c            	incw	x
8301  1856               L071:
8302  1856 b757          	ld	_vol_i_temp+1,a
8303  1858 9f            	ld	a,xl
8304  1859 b756          	ld	_vol_i_temp,a
8305                     ; 1692 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8307  185b b601          	ld	a,_vent_resurs_tx_cnt
8308  185d a102          	cp	a,#2
8309  185f 2507          	jrult	L1063
8312  1861 ce0000        	ldw	x,_vent_resurs
8313  1864 bf37          	ldw	_plazma_int+4,x
8315  1866 2004          	jra	L3063
8316  1868               L1063:
8317                     ; 1693 	else plazma_int[2]=vent_resurs_sec_cnt;
8319  1868 be02          	ldw	x,_vent_resurs_sec_cnt
8320  186a bf37          	ldw	_plazma_int+4,x
8321  186c               L3063:
8322                     ; 1694  	rotor_int=flags_tu+(((short)flags)<<8);
8324  186c b60b          	ld	a,_flags
8325  186e 5f            	clrw	x
8326  186f 97            	ld	xl,a
8327  1870 4f            	clr	a
8328  1871 02            	rlwa	x,a
8329  1872 01            	rrwa	x,a
8330  1873 bb60          	add	a,_flags_tu
8331  1875 2401          	jrnc	L271
8332  1877 5c            	incw	x
8333  1878               L271:
8334  1878 b71e          	ld	_rotor_int+1,a
8335  187a 9f            	ld	a,xl
8336  187b b71d          	ld	_rotor_int,a
8337                     ; 1695 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8339  187d 3b006b        	push	_Ui
8340  1880 3b006c        	push	_Ui+1
8341  1883 3b006d        	push	_Un
8342  1886 3b006e        	push	_Un+1
8343  1889 3b006f        	push	_I
8344  188c 3b0070        	push	_I+1
8345  188f 4bda          	push	#218
8346  1891 3b0005        	push	_adress
8347  1894 ae018e        	ldw	x,#398
8348  1897 cd164b        	call	_can_transmit
8350  189a 5b08          	addw	sp,#8
8351                     ; 1696 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8353  189c 3b0037        	push	_plazma_int+4
8354  189f 3b0038        	push	_plazma_int+5
8355  18a2 3b005f        	push	__x_+1
8356  18a5 3b000b        	push	_flags
8357  18a8 b601          	ld	a,_vent_resurs_tx_cnt
8358  18aa 5f            	clrw	x
8359  18ab 97            	ld	xl,a
8360  18ac d60000        	ld	a,(_vent_resurs_buff,x)
8361  18af 88            	push	a
8362  18b0 3b0068        	push	_T
8363  18b3 4bdb          	push	#219
8364  18b5 3b0005        	push	_adress
8365  18b8 ae018e        	ldw	x,#398
8366  18bb cd164b        	call	_can_transmit
8368  18be 5b08          	addw	sp,#8
8369                     ; 1697      link_cnt=0;
8371  18c0 5f            	clrw	x
8372  18c1 bf61          	ldw	_link_cnt,x
8373                     ; 1698      link=ON;
8375  18c3 35550063      	mov	_link,#85
8376                     ; 1700      if(flags_tu&0b10000000)
8378  18c7 b660          	ld	a,_flags_tu
8379  18c9 a580          	bcp	a,#128
8380  18cb 2716          	jreq	L5063
8381                     ; 1702      	if(!res_fl)
8383  18cd 725d000b      	tnz	_res_fl
8384  18d1 2625          	jrne	L1163
8385                     ; 1704      		res_fl=1;
8387  18d3 a601          	ld	a,#1
8388  18d5 ae000b        	ldw	x,#_res_fl
8389  18d8 cd0000        	call	c_eewrc
8391                     ; 1705      		bRES=1;
8393  18db 35010012      	mov	_bRES,#1
8394                     ; 1706      		res_fl_cnt=0;
8396  18df 3f41          	clr	_res_fl_cnt
8397  18e1 2015          	jra	L1163
8398  18e3               L5063:
8399                     ; 1711      	if(main_cnt>20)
8401  18e3 9c            	rvf
8402  18e4 be51          	ldw	x,_main_cnt
8403  18e6 a30015        	cpw	x,#21
8404  18e9 2f0d          	jrslt	L1163
8405                     ; 1713     			if(res_fl)
8407  18eb 725d000b      	tnz	_res_fl
8408  18ef 2707          	jreq	L1163
8409                     ; 1715      			res_fl=0;
8411  18f1 4f            	clr	a
8412  18f2 ae000b        	ldw	x,#_res_fl
8413  18f5 cd0000        	call	c_eewrc
8415  18f8               L1163:
8416                     ; 1720       if(res_fl_)
8418  18f8 725d000a      	tnz	_res_fl_
8419  18fc 2603          	jrne	L212
8420  18fe cc1e57        	jp	L3353
8421  1901               L212:
8422                     ; 1722       	res_fl_=0;
8424  1901 4f            	clr	a
8425  1902 ae000a        	ldw	x,#_res_fl_
8426  1905 cd0000        	call	c_eewrc
8428  1908 ac571e57      	jpf	L3353
8429  190c               L7653:
8430                     ; 1725 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8432  190c b6ca          	ld	a,_mess+6
8433  190e c10005        	cp	a,_adress
8434  1911 2703          	jreq	L412
8435  1913 cc1b23        	jp	L3263
8436  1916               L412:
8438  1916 b6cb          	ld	a,_mess+7
8439  1918 c10005        	cp	a,_adress
8440  191b 2703          	jreq	L612
8441  191d cc1b23        	jp	L3263
8442  1920               L612:
8444  1920 b6cc          	ld	a,_mess+8
8445  1922 a1ee          	cp	a,#238
8446  1924 2703          	jreq	L022
8447  1926 cc1b23        	jp	L3263
8448  1929               L022:
8450  1929 b6cd          	ld	a,_mess+9
8451  192b b1ce          	cp	a,_mess+10
8452  192d 2703          	jreq	L222
8453  192f cc1b23        	jp	L3263
8454  1932               L222:
8455                     ; 1727 	rotor_int++;
8457  1932 be1d          	ldw	x,_rotor_int
8458  1934 1c0001        	addw	x,#1
8459  1937 bf1d          	ldw	_rotor_int,x
8460                     ; 1728 	if((mess[9]&0xf0)==0x20)
8462  1939 b6cd          	ld	a,_mess+9
8463  193b a4f0          	and	a,#240
8464  193d a120          	cp	a,#32
8465  193f 2673          	jrne	L5263
8466                     ; 1730 		if((mess[9]&0x0f)==0x01)
8468  1941 b6cd          	ld	a,_mess+9
8469  1943 a40f          	and	a,#15
8470  1945 a101          	cp	a,#1
8471  1947 260d          	jrne	L7263
8472                     ; 1732 			ee_K[0][0]=adc_buff_[4];
8474  1949 ce0011        	ldw	x,_adc_buff_+8
8475  194c 89            	pushw	x
8476  194d ae001a        	ldw	x,#_ee_K
8477  1950 cd0000        	call	c_eewrw
8479  1953 85            	popw	x
8481  1954 204a          	jra	L1363
8482  1956               L7263:
8483                     ; 1734 		else if((mess[9]&0x0f)==0x02)
8485  1956 b6cd          	ld	a,_mess+9
8486  1958 a40f          	and	a,#15
8487  195a a102          	cp	a,#2
8488  195c 260b          	jrne	L3363
8489                     ; 1736 			ee_K[0][1]++;
8491  195e ce001c        	ldw	x,_ee_K+2
8492  1961 1c0001        	addw	x,#1
8493  1964 cf001c        	ldw	_ee_K+2,x
8495  1967 2037          	jra	L1363
8496  1969               L3363:
8497                     ; 1738 		else if((mess[9]&0x0f)==0x03)
8499  1969 b6cd          	ld	a,_mess+9
8500  196b a40f          	and	a,#15
8501  196d a103          	cp	a,#3
8502  196f 260b          	jrne	L7363
8503                     ; 1740 			ee_K[0][1]+=10;
8505  1971 ce001c        	ldw	x,_ee_K+2
8506  1974 1c000a        	addw	x,#10
8507  1977 cf001c        	ldw	_ee_K+2,x
8509  197a 2024          	jra	L1363
8510  197c               L7363:
8511                     ; 1742 		else if((mess[9]&0x0f)==0x04)
8513  197c b6cd          	ld	a,_mess+9
8514  197e a40f          	and	a,#15
8515  1980 a104          	cp	a,#4
8516  1982 260b          	jrne	L3463
8517                     ; 1744 			ee_K[0][1]--;
8519  1984 ce001c        	ldw	x,_ee_K+2
8520  1987 1d0001        	subw	x,#1
8521  198a cf001c        	ldw	_ee_K+2,x
8523  198d 2011          	jra	L1363
8524  198f               L3463:
8525                     ; 1746 		else if((mess[9]&0x0f)==0x05)
8527  198f b6cd          	ld	a,_mess+9
8528  1991 a40f          	and	a,#15
8529  1993 a105          	cp	a,#5
8530  1995 2609          	jrne	L1363
8531                     ; 1748 			ee_K[0][1]-=10;
8533  1997 ce001c        	ldw	x,_ee_K+2
8534  199a 1d000a        	subw	x,#10
8535  199d cf001c        	ldw	_ee_K+2,x
8536  19a0               L1363:
8537                     ; 1750 		granee(&ee_K[0][1],10,30000);									
8539  19a0 ae7530        	ldw	x,#30000
8540  19a3 89            	pushw	x
8541  19a4 ae000a        	ldw	x,#10
8542  19a7 89            	pushw	x
8543  19a8 ae001c        	ldw	x,#_ee_K+2
8544  19ab cd00f2        	call	_granee
8546  19ae 5b04          	addw	sp,#4
8548  19b0 ac081b08      	jpf	L1563
8549  19b4               L5263:
8550                     ; 1752 	else if((mess[9]&0xf0)==0x10)
8552  19b4 b6cd          	ld	a,_mess+9
8553  19b6 a4f0          	and	a,#240
8554  19b8 a110          	cp	a,#16
8555  19ba 2673          	jrne	L3563
8556                     ; 1754 		if((mess[9]&0x0f)==0x01)
8558  19bc b6cd          	ld	a,_mess+9
8559  19be a40f          	and	a,#15
8560  19c0 a101          	cp	a,#1
8561  19c2 260d          	jrne	L5563
8562                     ; 1756 			ee_K[1][0]=adc_buff_[1];
8564  19c4 ce000b        	ldw	x,_adc_buff_+2
8565  19c7 89            	pushw	x
8566  19c8 ae001e        	ldw	x,#_ee_K+4
8567  19cb cd0000        	call	c_eewrw
8569  19ce 85            	popw	x
8571  19cf 204a          	jra	L7563
8572  19d1               L5563:
8573                     ; 1758 		else if((mess[9]&0x0f)==0x02)
8575  19d1 b6cd          	ld	a,_mess+9
8576  19d3 a40f          	and	a,#15
8577  19d5 a102          	cp	a,#2
8578  19d7 260b          	jrne	L1663
8579                     ; 1760 			ee_K[1][1]++;
8581  19d9 ce0020        	ldw	x,_ee_K+6
8582  19dc 1c0001        	addw	x,#1
8583  19df cf0020        	ldw	_ee_K+6,x
8585  19e2 2037          	jra	L7563
8586  19e4               L1663:
8587                     ; 1762 		else if((mess[9]&0x0f)==0x03)
8589  19e4 b6cd          	ld	a,_mess+9
8590  19e6 a40f          	and	a,#15
8591  19e8 a103          	cp	a,#3
8592  19ea 260b          	jrne	L5663
8593                     ; 1764 			ee_K[1][1]+=10;
8595  19ec ce0020        	ldw	x,_ee_K+6
8596  19ef 1c000a        	addw	x,#10
8597  19f2 cf0020        	ldw	_ee_K+6,x
8599  19f5 2024          	jra	L7563
8600  19f7               L5663:
8601                     ; 1766 		else if((mess[9]&0x0f)==0x04)
8603  19f7 b6cd          	ld	a,_mess+9
8604  19f9 a40f          	and	a,#15
8605  19fb a104          	cp	a,#4
8606  19fd 260b          	jrne	L1763
8607                     ; 1768 			ee_K[1][1]--;
8609  19ff ce0020        	ldw	x,_ee_K+6
8610  1a02 1d0001        	subw	x,#1
8611  1a05 cf0020        	ldw	_ee_K+6,x
8613  1a08 2011          	jra	L7563
8614  1a0a               L1763:
8615                     ; 1770 		else if((mess[9]&0x0f)==0x05)
8617  1a0a b6cd          	ld	a,_mess+9
8618  1a0c a40f          	and	a,#15
8619  1a0e a105          	cp	a,#5
8620  1a10 2609          	jrne	L7563
8621                     ; 1772 			ee_K[1][1]-=10;
8623  1a12 ce0020        	ldw	x,_ee_K+6
8624  1a15 1d000a        	subw	x,#10
8625  1a18 cf0020        	ldw	_ee_K+6,x
8626  1a1b               L7563:
8627                     ; 1777 		granee(&ee_K[1][1],10,30000);
8629  1a1b ae7530        	ldw	x,#30000
8630  1a1e 89            	pushw	x
8631  1a1f ae000a        	ldw	x,#10
8632  1a22 89            	pushw	x
8633  1a23 ae0020        	ldw	x,#_ee_K+6
8634  1a26 cd00f2        	call	_granee
8636  1a29 5b04          	addw	sp,#4
8638  1a2b ac081b08      	jpf	L1563
8639  1a2f               L3563:
8640                     ; 1781 	else if((mess[9]&0xf0)==0x00)
8642  1a2f b6cd          	ld	a,_mess+9
8643  1a31 a5f0          	bcp	a,#240
8644  1a33 2671          	jrne	L1073
8645                     ; 1783 		if((mess[9]&0x0f)==0x01)
8647  1a35 b6cd          	ld	a,_mess+9
8648  1a37 a40f          	and	a,#15
8649  1a39 a101          	cp	a,#1
8650  1a3b 260d          	jrne	L3073
8651                     ; 1785 			ee_K[2][0]=adc_buff_[2];
8653  1a3d ce000d        	ldw	x,_adc_buff_+4
8654  1a40 89            	pushw	x
8655  1a41 ae0022        	ldw	x,#_ee_K+8
8656  1a44 cd0000        	call	c_eewrw
8658  1a47 85            	popw	x
8660  1a48 204a          	jra	L5073
8661  1a4a               L3073:
8662                     ; 1787 		else if((mess[9]&0x0f)==0x02)
8664  1a4a b6cd          	ld	a,_mess+9
8665  1a4c a40f          	and	a,#15
8666  1a4e a102          	cp	a,#2
8667  1a50 260b          	jrne	L7073
8668                     ; 1789 			ee_K[2][1]++;
8670  1a52 ce0024        	ldw	x,_ee_K+10
8671  1a55 1c0001        	addw	x,#1
8672  1a58 cf0024        	ldw	_ee_K+10,x
8674  1a5b 2037          	jra	L5073
8675  1a5d               L7073:
8676                     ; 1791 		else if((mess[9]&0x0f)==0x03)
8678  1a5d b6cd          	ld	a,_mess+9
8679  1a5f a40f          	and	a,#15
8680  1a61 a103          	cp	a,#3
8681  1a63 260b          	jrne	L3173
8682                     ; 1793 			ee_K[2][1]+=10;
8684  1a65 ce0024        	ldw	x,_ee_K+10
8685  1a68 1c000a        	addw	x,#10
8686  1a6b cf0024        	ldw	_ee_K+10,x
8688  1a6e 2024          	jra	L5073
8689  1a70               L3173:
8690                     ; 1795 		else if((mess[9]&0x0f)==0x04)
8692  1a70 b6cd          	ld	a,_mess+9
8693  1a72 a40f          	and	a,#15
8694  1a74 a104          	cp	a,#4
8695  1a76 260b          	jrne	L7173
8696                     ; 1797 			ee_K[2][1]--;
8698  1a78 ce0024        	ldw	x,_ee_K+10
8699  1a7b 1d0001        	subw	x,#1
8700  1a7e cf0024        	ldw	_ee_K+10,x
8702  1a81 2011          	jra	L5073
8703  1a83               L7173:
8704                     ; 1799 		else if((mess[9]&0x0f)==0x05)
8706  1a83 b6cd          	ld	a,_mess+9
8707  1a85 a40f          	and	a,#15
8708  1a87 a105          	cp	a,#5
8709  1a89 2609          	jrne	L5073
8710                     ; 1801 			ee_K[2][1]-=10;
8712  1a8b ce0024        	ldw	x,_ee_K+10
8713  1a8e 1d000a        	subw	x,#10
8714  1a91 cf0024        	ldw	_ee_K+10,x
8715  1a94               L5073:
8716                     ; 1806 		granee(&ee_K[2][1],10,30000);
8718  1a94 ae7530        	ldw	x,#30000
8719  1a97 89            	pushw	x
8720  1a98 ae000a        	ldw	x,#10
8721  1a9b 89            	pushw	x
8722  1a9c ae0024        	ldw	x,#_ee_K+10
8723  1a9f cd00f2        	call	_granee
8725  1aa2 5b04          	addw	sp,#4
8727  1aa4 2062          	jra	L1563
8728  1aa6               L1073:
8729                     ; 1810 	else if((mess[9]&0xf0)==0x30)
8731  1aa6 b6cd          	ld	a,_mess+9
8732  1aa8 a4f0          	and	a,#240
8733  1aaa a130          	cp	a,#48
8734  1aac 265a          	jrne	L1563
8735                     ; 1812 		if((mess[9]&0x0f)==0x02)
8737  1aae b6cd          	ld	a,_mess+9
8738  1ab0 a40f          	and	a,#15
8739  1ab2 a102          	cp	a,#2
8740  1ab4 260b          	jrne	L1373
8741                     ; 1814 			ee_K[3][1]++;
8743  1ab6 ce0028        	ldw	x,_ee_K+14
8744  1ab9 1c0001        	addw	x,#1
8745  1abc cf0028        	ldw	_ee_K+14,x
8747  1abf 2037          	jra	L3373
8748  1ac1               L1373:
8749                     ; 1816 		else if((mess[9]&0x0f)==0x03)
8751  1ac1 b6cd          	ld	a,_mess+9
8752  1ac3 a40f          	and	a,#15
8753  1ac5 a103          	cp	a,#3
8754  1ac7 260b          	jrne	L5373
8755                     ; 1818 			ee_K[3][1]+=10;
8757  1ac9 ce0028        	ldw	x,_ee_K+14
8758  1acc 1c000a        	addw	x,#10
8759  1acf cf0028        	ldw	_ee_K+14,x
8761  1ad2 2024          	jra	L3373
8762  1ad4               L5373:
8763                     ; 1820 		else if((mess[9]&0x0f)==0x04)
8765  1ad4 b6cd          	ld	a,_mess+9
8766  1ad6 a40f          	and	a,#15
8767  1ad8 a104          	cp	a,#4
8768  1ada 260b          	jrne	L1473
8769                     ; 1822 			ee_K[3][1]--;
8771  1adc ce0028        	ldw	x,_ee_K+14
8772  1adf 1d0001        	subw	x,#1
8773  1ae2 cf0028        	ldw	_ee_K+14,x
8775  1ae5 2011          	jra	L3373
8776  1ae7               L1473:
8777                     ; 1824 		else if((mess[9]&0x0f)==0x05)
8779  1ae7 b6cd          	ld	a,_mess+9
8780  1ae9 a40f          	and	a,#15
8781  1aeb a105          	cp	a,#5
8782  1aed 2609          	jrne	L3373
8783                     ; 1826 			ee_K[3][1]-=10;
8785  1aef ce0028        	ldw	x,_ee_K+14
8786  1af2 1d000a        	subw	x,#10
8787  1af5 cf0028        	ldw	_ee_K+14,x
8788  1af8               L3373:
8789                     ; 1828 		granee(&ee_K[3][1],300,517);									
8791  1af8 ae0205        	ldw	x,#517
8792  1afb 89            	pushw	x
8793  1afc ae012c        	ldw	x,#300
8794  1aff 89            	pushw	x
8795  1b00 ae0028        	ldw	x,#_ee_K+14
8796  1b03 cd00f2        	call	_granee
8798  1b06 5b04          	addw	sp,#4
8799  1b08               L1563:
8800                     ; 1831 	link_cnt=0;
8802  1b08 5f            	clrw	x
8803  1b09 bf61          	ldw	_link_cnt,x
8804                     ; 1832      link=ON;
8806  1b0b 35550063      	mov	_link,#85
8807                     ; 1833      if(res_fl_)
8809  1b0f 725d000a      	tnz	_res_fl_
8810  1b13 2603          	jrne	L422
8811  1b15 cc1e57        	jp	L3353
8812  1b18               L422:
8813                     ; 1835       	res_fl_=0;
8815  1b18 4f            	clr	a
8816  1b19 ae000a        	ldw	x,#_res_fl_
8817  1b1c cd0000        	call	c_eewrc
8819  1b1f ac571e57      	jpf	L3353
8820  1b23               L3263:
8821                     ; 1841 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8823  1b23 b6ca          	ld	a,_mess+6
8824  1b25 a1ff          	cp	a,#255
8825  1b27 2703          	jreq	L622
8826  1b29 cc1bb7        	jp	L3573
8827  1b2c               L622:
8829  1b2c b6cb          	ld	a,_mess+7
8830  1b2e a1ff          	cp	a,#255
8831  1b30 2703          	jreq	L032
8832  1b32 cc1bb7        	jp	L3573
8833  1b35               L032:
8835  1b35 b6cc          	ld	a,_mess+8
8836  1b37 a162          	cp	a,#98
8837  1b39 267c          	jrne	L3573
8838                     ; 1844 	tempSS=mess[9]+(mess[10]*256);
8840  1b3b b6ce          	ld	a,_mess+10
8841  1b3d 5f            	clrw	x
8842  1b3e 97            	ld	xl,a
8843  1b3f 4f            	clr	a
8844  1b40 02            	rlwa	x,a
8845  1b41 01            	rrwa	x,a
8846  1b42 bbcd          	add	a,_mess+9
8847  1b44 2401          	jrnc	L471
8848  1b46 5c            	incw	x
8849  1b47               L471:
8850  1b47 02            	rlwa	x,a
8851  1b48 1f04          	ldw	(OFST-1,sp),x
8852  1b4a 01            	rrwa	x,a
8853                     ; 1845 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8855  1b4b ce0014        	ldw	x,_ee_Umax
8856  1b4e 1304          	cpw	x,(OFST-1,sp)
8857  1b50 270a          	jreq	L5573
8860  1b52 1e04          	ldw	x,(OFST-1,sp)
8861  1b54 89            	pushw	x
8862  1b55 ae0014        	ldw	x,#_ee_Umax
8863  1b58 cd0000        	call	c_eewrw
8865  1b5b 85            	popw	x
8866  1b5c               L5573:
8867                     ; 1846 	tempSS=mess[11]+(mess[12]*256);
8869  1b5c b6d0          	ld	a,_mess+12
8870  1b5e 5f            	clrw	x
8871  1b5f 97            	ld	xl,a
8872  1b60 4f            	clr	a
8873  1b61 02            	rlwa	x,a
8874  1b62 01            	rrwa	x,a
8875  1b63 bbcf          	add	a,_mess+11
8876  1b65 2401          	jrnc	L671
8877  1b67 5c            	incw	x
8878  1b68               L671:
8879  1b68 02            	rlwa	x,a
8880  1b69 1f04          	ldw	(OFST-1,sp),x
8881  1b6b 01            	rrwa	x,a
8882                     ; 1847 	if(ee_dU!=tempSS) ee_dU=tempSS;
8884  1b6c ce0012        	ldw	x,_ee_dU
8885  1b6f 1304          	cpw	x,(OFST-1,sp)
8886  1b71 270a          	jreq	L7573
8889  1b73 1e04          	ldw	x,(OFST-1,sp)
8890  1b75 89            	pushw	x
8891  1b76 ae0012        	ldw	x,#_ee_dU
8892  1b79 cd0000        	call	c_eewrw
8894  1b7c 85            	popw	x
8895  1b7d               L7573:
8896                     ; 1848 	if((mess[13]&0x0f)==0x5)
8898  1b7d b6d1          	ld	a,_mess+13
8899  1b7f a40f          	and	a,#15
8900  1b81 a105          	cp	a,#5
8901  1b83 261a          	jrne	L1673
8902                     ; 1850 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8904  1b85 ce0006        	ldw	x,_ee_AVT_MODE
8905  1b88 a30055        	cpw	x,#85
8906  1b8b 2603          	jrne	L232
8907  1b8d cc1e57        	jp	L3353
8908  1b90               L232:
8911  1b90 ae0055        	ldw	x,#85
8912  1b93 89            	pushw	x
8913  1b94 ae0006        	ldw	x,#_ee_AVT_MODE
8914  1b97 cd0000        	call	c_eewrw
8916  1b9a 85            	popw	x
8917  1b9b ac571e57      	jpf	L3353
8918  1b9f               L1673:
8919                     ; 1852 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8921  1b9f ce0006        	ldw	x,_ee_AVT_MODE
8922  1ba2 a30055        	cpw	x,#85
8923  1ba5 2703          	jreq	L432
8924  1ba7 cc1e57        	jp	L3353
8925  1baa               L432:
8928  1baa 5f            	clrw	x
8929  1bab 89            	pushw	x
8930  1bac ae0006        	ldw	x,#_ee_AVT_MODE
8931  1baf cd0000        	call	c_eewrw
8933  1bb2 85            	popw	x
8934  1bb3 ac571e57      	jpf	L3353
8935  1bb7               L3573:
8936                     ; 1855 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8938  1bb7 b6ca          	ld	a,_mess+6
8939  1bb9 a1ff          	cp	a,#255
8940  1bbb 2703          	jreq	L632
8941  1bbd cc1c8e        	jp	L3773
8942  1bc0               L632:
8944  1bc0 b6cb          	ld	a,_mess+7
8945  1bc2 a1ff          	cp	a,#255
8946  1bc4 2703          	jreq	L042
8947  1bc6 cc1c8e        	jp	L3773
8948  1bc9               L042:
8950  1bc9 b6cc          	ld	a,_mess+8
8951  1bcb a126          	cp	a,#38
8952  1bcd 2709          	jreq	L5773
8954  1bcf b6cc          	ld	a,_mess+8
8955  1bd1 a129          	cp	a,#41
8956  1bd3 2703          	jreq	L242
8957  1bd5 cc1c8e        	jp	L3773
8958  1bd8               L242:
8959  1bd8               L5773:
8960                     ; 1858 	tempSS=mess[9]+(mess[10]*256);
8962  1bd8 b6ce          	ld	a,_mess+10
8963  1bda 5f            	clrw	x
8964  1bdb 97            	ld	xl,a
8965  1bdc 4f            	clr	a
8966  1bdd 02            	rlwa	x,a
8967  1bde 01            	rrwa	x,a
8968  1bdf bbcd          	add	a,_mess+9
8969  1be1 2401          	jrnc	L002
8970  1be3 5c            	incw	x
8971  1be4               L002:
8972  1be4 02            	rlwa	x,a
8973  1be5 1f04          	ldw	(OFST-1,sp),x
8974  1be7 01            	rrwa	x,a
8975                     ; 1859 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8977  1be8 ce0010        	ldw	x,_ee_tmax
8978  1beb 1304          	cpw	x,(OFST-1,sp)
8979  1bed 270a          	jreq	L7773
8982  1bef 1e04          	ldw	x,(OFST-1,sp)
8983  1bf1 89            	pushw	x
8984  1bf2 ae0010        	ldw	x,#_ee_tmax
8985  1bf5 cd0000        	call	c_eewrw
8987  1bf8 85            	popw	x
8988  1bf9               L7773:
8989                     ; 1860 	tempSS=mess[11]+(mess[12]*256);
8991  1bf9 b6d0          	ld	a,_mess+12
8992  1bfb 5f            	clrw	x
8993  1bfc 97            	ld	xl,a
8994  1bfd 4f            	clr	a
8995  1bfe 02            	rlwa	x,a
8996  1bff 01            	rrwa	x,a
8997  1c00 bbcf          	add	a,_mess+11
8998  1c02 2401          	jrnc	L202
8999  1c04 5c            	incw	x
9000  1c05               L202:
9001  1c05 02            	rlwa	x,a
9002  1c06 1f04          	ldw	(OFST-1,sp),x
9003  1c08 01            	rrwa	x,a
9004                     ; 1861 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
9006  1c09 ce000e        	ldw	x,_ee_tsign
9007  1c0c 1304          	cpw	x,(OFST-1,sp)
9008  1c0e 270a          	jreq	L1004
9011  1c10 1e04          	ldw	x,(OFST-1,sp)
9012  1c12 89            	pushw	x
9013  1c13 ae000e        	ldw	x,#_ee_tsign
9014  1c16 cd0000        	call	c_eewrw
9016  1c19 85            	popw	x
9017  1c1a               L1004:
9018                     ; 1864 	if(mess[8]==MEM_KF1)
9020  1c1a b6cc          	ld	a,_mess+8
9021  1c1c a126          	cp	a,#38
9022  1c1e 2623          	jrne	L3004
9023                     ; 1866 		if(ee_DEVICE!=0)ee_DEVICE=0;
9025  1c20 ce0004        	ldw	x,_ee_DEVICE
9026  1c23 2709          	jreq	L5004
9029  1c25 5f            	clrw	x
9030  1c26 89            	pushw	x
9031  1c27 ae0004        	ldw	x,#_ee_DEVICE
9032  1c2a cd0000        	call	c_eewrw
9034  1c2d 85            	popw	x
9035  1c2e               L5004:
9036                     ; 1867 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
9038  1c2e b6d1          	ld	a,_mess+13
9039  1c30 5f            	clrw	x
9040  1c31 97            	ld	xl,a
9041  1c32 c30016        	cpw	x,_ee_TZAS
9042  1c35 270c          	jreq	L3004
9045  1c37 b6d1          	ld	a,_mess+13
9046  1c39 5f            	clrw	x
9047  1c3a 97            	ld	xl,a
9048  1c3b 89            	pushw	x
9049  1c3c ae0016        	ldw	x,#_ee_TZAS
9050  1c3f cd0000        	call	c_eewrw
9052  1c42 85            	popw	x
9053  1c43               L3004:
9054                     ; 1869 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
9056  1c43 b6cc          	ld	a,_mess+8
9057  1c45 a129          	cp	a,#41
9058  1c47 2703          	jreq	L442
9059  1c49 cc1e57        	jp	L3353
9060  1c4c               L442:
9061                     ; 1871 		if(ee_DEVICE!=1)ee_DEVICE=1;
9063  1c4c ce0004        	ldw	x,_ee_DEVICE
9064  1c4f a30001        	cpw	x,#1
9065  1c52 270b          	jreq	L3104
9068  1c54 ae0001        	ldw	x,#1
9069  1c57 89            	pushw	x
9070  1c58 ae0004        	ldw	x,#_ee_DEVICE
9071  1c5b cd0000        	call	c_eewrw
9073  1c5e 85            	popw	x
9074  1c5f               L3104:
9075                     ; 1872 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
9077  1c5f b6d1          	ld	a,_mess+13
9078  1c61 5f            	clrw	x
9079  1c62 97            	ld	xl,a
9080  1c63 c30002        	cpw	x,_ee_IMAXVENT
9081  1c66 270c          	jreq	L5104
9084  1c68 b6d1          	ld	a,_mess+13
9085  1c6a 5f            	clrw	x
9086  1c6b 97            	ld	xl,a
9087  1c6c 89            	pushw	x
9088  1c6d ae0002        	ldw	x,#_ee_IMAXVENT
9089  1c70 cd0000        	call	c_eewrw
9091  1c73 85            	popw	x
9092  1c74               L5104:
9093                     ; 1873 			if(ee_TZAS!=3) ee_TZAS=3;
9095  1c74 ce0016        	ldw	x,_ee_TZAS
9096  1c77 a30003        	cpw	x,#3
9097  1c7a 2603          	jrne	L642
9098  1c7c cc1e57        	jp	L3353
9099  1c7f               L642:
9102  1c7f ae0003        	ldw	x,#3
9103  1c82 89            	pushw	x
9104  1c83 ae0016        	ldw	x,#_ee_TZAS
9105  1c86 cd0000        	call	c_eewrw
9107  1c89 85            	popw	x
9108  1c8a ac571e57      	jpf	L3353
9109  1c8e               L3773:
9110                     ; 1877 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
9112  1c8e b6ca          	ld	a,_mess+6
9113  1c90 c10005        	cp	a,_adress
9114  1c93 262d          	jrne	L3204
9116  1c95 b6cb          	ld	a,_mess+7
9117  1c97 c10005        	cp	a,_adress
9118  1c9a 2626          	jrne	L3204
9120  1c9c b6cc          	ld	a,_mess+8
9121  1c9e a116          	cp	a,#22
9122  1ca0 2620          	jrne	L3204
9124  1ca2 b6cd          	ld	a,_mess+9
9125  1ca4 a163          	cp	a,#99
9126  1ca6 261a          	jrne	L3204
9127                     ; 1879 	flags&=0b11100001;
9129  1ca8 b60b          	ld	a,_flags
9130  1caa a4e1          	and	a,#225
9131  1cac b70b          	ld	_flags,a
9132                     ; 1880 	tsign_cnt=0;
9134  1cae 5f            	clrw	x
9135  1caf bf4d          	ldw	_tsign_cnt,x
9136                     ; 1881 	tmax_cnt=0;
9138  1cb1 5f            	clrw	x
9139  1cb2 bf4b          	ldw	_tmax_cnt,x
9140                     ; 1882 	umax_cnt=0;
9142  1cb4 5f            	clrw	x
9143  1cb5 bf66          	ldw	_umax_cnt,x
9144                     ; 1883 	umin_cnt=0;
9146  1cb7 5f            	clrw	x
9147  1cb8 bf64          	ldw	_umin_cnt,x
9148                     ; 1884 	led_drv_cnt=30;
9150  1cba 351e001c      	mov	_led_drv_cnt,#30
9152  1cbe ac571e57      	jpf	L3353
9153  1cc2               L3204:
9154                     ; 1887 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
9156  1cc2 b6ca          	ld	a,_mess+6
9157  1cc4 c10005        	cp	a,_adress
9158  1cc7 2620          	jrne	L7204
9160  1cc9 b6cb          	ld	a,_mess+7
9161  1ccb c10005        	cp	a,_adress
9162  1cce 2619          	jrne	L7204
9164  1cd0 b6cc          	ld	a,_mess+8
9165  1cd2 a116          	cp	a,#22
9166  1cd4 2613          	jrne	L7204
9168  1cd6 b6cd          	ld	a,_mess+9
9169  1cd8 a164          	cp	a,#100
9170  1cda 260d          	jrne	L7204
9171                     ; 1889 	vent_resurs=0;
9173  1cdc 5f            	clrw	x
9174  1cdd 89            	pushw	x
9175  1cde ae0000        	ldw	x,#_vent_resurs
9176  1ce1 cd0000        	call	c_eewrw
9178  1ce4 85            	popw	x
9180  1ce5 ac571e57      	jpf	L3353
9181  1ce9               L7204:
9182                     ; 1893 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
9184  1ce9 b6ca          	ld	a,_mess+6
9185  1ceb a1ff          	cp	a,#255
9186  1ced 265f          	jrne	L3304
9188  1cef b6cb          	ld	a,_mess+7
9189  1cf1 a1ff          	cp	a,#255
9190  1cf3 2659          	jrne	L3304
9192  1cf5 b6cc          	ld	a,_mess+8
9193  1cf7 a116          	cp	a,#22
9194  1cf9 2653          	jrne	L3304
9196  1cfb b6cd          	ld	a,_mess+9
9197  1cfd a116          	cp	a,#22
9198  1cff 264d          	jrne	L3304
9199                     ; 1895 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9201  1d01 b6ce          	ld	a,_mess+10
9202  1d03 a155          	cp	a,#85
9203  1d05 260f          	jrne	L5304
9205  1d07 b6cf          	ld	a,_mess+11
9206  1d09 a155          	cp	a,#85
9207  1d0b 2609          	jrne	L5304
9210  1d0d be5e          	ldw	x,__x_
9211  1d0f 1c0001        	addw	x,#1
9212  1d12 bf5e          	ldw	__x_,x
9214  1d14 2024          	jra	L7304
9215  1d16               L5304:
9216                     ; 1896 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9218  1d16 b6ce          	ld	a,_mess+10
9219  1d18 a166          	cp	a,#102
9220  1d1a 260f          	jrne	L1404
9222  1d1c b6cf          	ld	a,_mess+11
9223  1d1e a166          	cp	a,#102
9224  1d20 2609          	jrne	L1404
9227  1d22 be5e          	ldw	x,__x_
9228  1d24 1d0001        	subw	x,#1
9229  1d27 bf5e          	ldw	__x_,x
9231  1d29 200f          	jra	L7304
9232  1d2b               L1404:
9233                     ; 1897 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9235  1d2b b6ce          	ld	a,_mess+10
9236  1d2d a177          	cp	a,#119
9237  1d2f 2609          	jrne	L7304
9239  1d31 b6cf          	ld	a,_mess+11
9240  1d33 a177          	cp	a,#119
9241  1d35 2603          	jrne	L7304
9244  1d37 5f            	clrw	x
9245  1d38 bf5e          	ldw	__x_,x
9246  1d3a               L7304:
9247                     ; 1898      gran(&_x_,-XMAX,XMAX);
9249  1d3a ae0019        	ldw	x,#25
9250  1d3d 89            	pushw	x
9251  1d3e aeffe7        	ldw	x,#65511
9252  1d41 89            	pushw	x
9253  1d42 ae005e        	ldw	x,#__x_
9254  1d45 cd00d1        	call	_gran
9256  1d48 5b04          	addw	sp,#4
9258  1d4a ac571e57      	jpf	L3353
9259  1d4e               L3304:
9260                     ; 1900 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9262  1d4e b6ca          	ld	a,_mess+6
9263  1d50 c10005        	cp	a,_adress
9264  1d53 2665          	jrne	L1504
9266  1d55 b6cb          	ld	a,_mess+7
9267  1d57 c10005        	cp	a,_adress
9268  1d5a 265e          	jrne	L1504
9270  1d5c b6cc          	ld	a,_mess+8
9271  1d5e a116          	cp	a,#22
9272  1d60 2658          	jrne	L1504
9274  1d62 b6cd          	ld	a,_mess+9
9275  1d64 b1ce          	cp	a,_mess+10
9276  1d66 2652          	jrne	L1504
9278  1d68 b6cd          	ld	a,_mess+9
9279  1d6a a1ee          	cp	a,#238
9280  1d6c 264c          	jrne	L1504
9281                     ; 1902 	rotor_int++;
9283  1d6e be1d          	ldw	x,_rotor_int
9284  1d70 1c0001        	addw	x,#1
9285  1d73 bf1d          	ldw	_rotor_int,x
9286                     ; 1903      tempI=pwm_u;
9288  1d75 be0e          	ldw	x,_pwm_u
9289  1d77 1f04          	ldw	(OFST-1,sp),x
9290                     ; 1904 	ee_U_AVT=tempI;
9292  1d79 1e04          	ldw	x,(OFST-1,sp)
9293  1d7b 89            	pushw	x
9294  1d7c ae000c        	ldw	x,#_ee_U_AVT
9295  1d7f cd0000        	call	c_eewrw
9297  1d82 85            	popw	x
9298                     ; 1905 	UU_AVT=Un;
9300  1d83 be6d          	ldw	x,_Un
9301  1d85 89            	pushw	x
9302  1d86 ae0008        	ldw	x,#_UU_AVT
9303  1d89 cd0000        	call	c_eewrw
9305  1d8c 85            	popw	x
9306                     ; 1906 	delay_ms(100);
9308  1d8d ae0064        	ldw	x,#100
9309  1d90 cd011d        	call	_delay_ms
9311                     ; 1907 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9313  1d93 ce000c        	ldw	x,_ee_U_AVT
9314  1d96 1304          	cpw	x,(OFST-1,sp)
9315  1d98 2703          	jreq	L052
9316  1d9a cc1e57        	jp	L3353
9317  1d9d               L052:
9320  1d9d 4b00          	push	#0
9321  1d9f 4b00          	push	#0
9322  1da1 4b00          	push	#0
9323  1da3 4b00          	push	#0
9324  1da5 4bdd          	push	#221
9325  1da7 4bdd          	push	#221
9326  1da9 4b91          	push	#145
9327  1dab 3b0005        	push	_adress
9328  1dae ae018e        	ldw	x,#398
9329  1db1 cd164b        	call	_can_transmit
9331  1db4 5b08          	addw	sp,#8
9332  1db6 ac571e57      	jpf	L3353
9333  1dba               L1504:
9334                     ; 1912 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9336  1dba b6cb          	ld	a,_mess+7
9337  1dbc a1da          	cp	a,#218
9338  1dbe 2652          	jrne	L7504
9340  1dc0 b6ca          	ld	a,_mess+6
9341  1dc2 c10005        	cp	a,_adress
9342  1dc5 274b          	jreq	L7504
9344  1dc7 b6ca          	ld	a,_mess+6
9345  1dc9 a106          	cp	a,#6
9346  1dcb 2445          	jruge	L7504
9347                     ; 1914 	i_main_bps_cnt[mess[6]]=0;
9349  1dcd b6ca          	ld	a,_mess+6
9350  1dcf 5f            	clrw	x
9351  1dd0 97            	ld	xl,a
9352  1dd1 6f09          	clr	(_i_main_bps_cnt,x)
9353                     ; 1915 	i_main_flag[mess[6]]=1;
9355  1dd3 b6ca          	ld	a,_mess+6
9356  1dd5 5f            	clrw	x
9357  1dd6 97            	ld	xl,a
9358  1dd7 a601          	ld	a,#1
9359  1dd9 e714          	ld	(_i_main_flag,x),a
9360                     ; 1916 	if(bMAIN)
9362                     	btst	_bMAIN
9363  1de0 2475          	jruge	L3353
9364                     ; 1918 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9366  1de2 b6cd          	ld	a,_mess+9
9367  1de4 5f            	clrw	x
9368  1de5 97            	ld	xl,a
9369  1de6 4f            	clr	a
9370  1de7 02            	rlwa	x,a
9371  1de8 1f01          	ldw	(OFST-4,sp),x
9372  1dea b6cc          	ld	a,_mess+8
9373  1dec 5f            	clrw	x
9374  1ded 97            	ld	xl,a
9375  1dee 72fb01        	addw	x,(OFST-4,sp)
9376  1df1 b6ca          	ld	a,_mess+6
9377  1df3 905f          	clrw	y
9378  1df5 9097          	ld	yl,a
9379  1df7 9058          	sllw	y
9380  1df9 90ef1a        	ldw	(_i_main,y),x
9381                     ; 1919 		i_main[adress]=I;
9383  1dfc c60005        	ld	a,_adress
9384  1dff 5f            	clrw	x
9385  1e00 97            	ld	xl,a
9386  1e01 58            	sllw	x
9387  1e02 90be6f        	ldw	y,_I
9388  1e05 ef1a          	ldw	(_i_main,x),y
9389                     ; 1920      	i_main_flag[adress]=1;
9391  1e07 c60005        	ld	a,_adress
9392  1e0a 5f            	clrw	x
9393  1e0b 97            	ld	xl,a
9394  1e0c a601          	ld	a,#1
9395  1e0e e714          	ld	(_i_main_flag,x),a
9396  1e10 2045          	jra	L3353
9397  1e12               L7504:
9398                     ; 1924 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9400  1e12 b6cb          	ld	a,_mess+7
9401  1e14 a1db          	cp	a,#219
9402  1e16 263f          	jrne	L3353
9404  1e18 b6ca          	ld	a,_mess+6
9405  1e1a c10005        	cp	a,_adress
9406  1e1d 2738          	jreq	L3353
9408  1e1f b6ca          	ld	a,_mess+6
9409  1e21 a106          	cp	a,#6
9410  1e23 2432          	jruge	L3353
9411                     ; 1926 	i_main_bps_cnt[mess[6]]=0;
9413  1e25 b6ca          	ld	a,_mess+6
9414  1e27 5f            	clrw	x
9415  1e28 97            	ld	xl,a
9416  1e29 6f09          	clr	(_i_main_bps_cnt,x)
9417                     ; 1927 	i_main_flag[mess[6]]=1;		
9419  1e2b b6ca          	ld	a,_mess+6
9420  1e2d 5f            	clrw	x
9421  1e2e 97            	ld	xl,a
9422  1e2f a601          	ld	a,#1
9423  1e31 e714          	ld	(_i_main_flag,x),a
9424                     ; 1928 	if(bMAIN)
9426                     	btst	_bMAIN
9427  1e38 241d          	jruge	L3353
9428                     ; 1930 		if(mess[9]==0)i_main_flag[i]=1;
9430  1e3a 3dcd          	tnz	_mess+9
9431  1e3c 260a          	jrne	L1704
9434  1e3e 7b03          	ld	a,(OFST-2,sp)
9435  1e40 5f            	clrw	x
9436  1e41 97            	ld	xl,a
9437  1e42 a601          	ld	a,#1
9438  1e44 e714          	ld	(_i_main_flag,x),a
9440  1e46 2006          	jra	L3704
9441  1e48               L1704:
9442                     ; 1931 		else i_main_flag[i]=0;
9444  1e48 7b03          	ld	a,(OFST-2,sp)
9445  1e4a 5f            	clrw	x
9446  1e4b 97            	ld	xl,a
9447  1e4c 6f14          	clr	(_i_main_flag,x)
9448  1e4e               L3704:
9449                     ; 1932 		i_main_flag[adress]=1;
9451  1e4e c60005        	ld	a,_adress
9452  1e51 5f            	clrw	x
9453  1e52 97            	ld	xl,a
9454  1e53 a601          	ld	a,#1
9455  1e55 e714          	ld	(_i_main_flag,x),a
9456  1e57               L3353:
9457                     ; 1938 can_in_an_end:
9457                     ; 1939 bCAN_RX=0;
9459  1e57 3f0a          	clr	_bCAN_RX
9460                     ; 1940 }   
9463  1e59 5b05          	addw	sp,#5
9464  1e5b 81            	ret
9487                     ; 1943 void t4_init(void){
9488                     	switch	.text
9489  1e5c               _t4_init:
9493                     ; 1944 	TIM4->PSCR = 4;
9495  1e5c 35045345      	mov	21317,#4
9496                     ; 1945 	TIM4->ARR= 61;
9498  1e60 353d5346      	mov	21318,#61
9499                     ; 1946 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9501  1e64 72105341      	bset	21313,#0
9502                     ; 1948 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9504  1e68 35855340      	mov	21312,#133
9505                     ; 1950 }
9508  1e6c 81            	ret
9531                     ; 1953 void t1_init(void)
9531                     ; 1954 {
9532                     	switch	.text
9533  1e6d               _t1_init:
9537                     ; 1955 TIM1->ARRH= 0x03;
9539  1e6d 35035262      	mov	21090,#3
9540                     ; 1956 TIM1->ARRL= 0xff;
9542  1e71 35ff5263      	mov	21091,#255
9543                     ; 1957 TIM1->CCR1H= 0x00;	
9545  1e75 725f5265      	clr	21093
9546                     ; 1958 TIM1->CCR1L= 0xff;
9548  1e79 35ff5266      	mov	21094,#255
9549                     ; 1959 TIM1->CCR2H= 0x00;	
9551  1e7d 725f5267      	clr	21095
9552                     ; 1960 TIM1->CCR2L= 0x00;
9554  1e81 725f5268      	clr	21096
9555                     ; 1961 TIM1->CCR3H= 0x00;	
9557  1e85 725f5269      	clr	21097
9558                     ; 1962 TIM1->CCR3L= 0x64;
9560  1e89 3564526a      	mov	21098,#100
9561                     ; 1964 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9563  1e8d 35685258      	mov	21080,#104
9564                     ; 1965 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9566  1e91 35685259      	mov	21081,#104
9567                     ; 1966 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9569  1e95 3568525a      	mov	21082,#104
9570                     ; 1967 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9572  1e99 3511525c      	mov	21084,#17
9573                     ; 1968 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9575  1e9d 3501525d      	mov	21085,#1
9576                     ; 1969 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9578  1ea1 35815250      	mov	21072,#129
9579                     ; 1970 TIM1->BKR|= TIM1_BKR_AOE;
9581  1ea5 721c526d      	bset	21101,#6
9582                     ; 1971 }
9585  1ea9 81            	ret
9610                     ; 1975 void adc2_init(void)
9610                     ; 1976 {
9611                     	switch	.text
9612  1eaa               _adc2_init:
9616                     ; 1977 adc_plazma[0]++;
9618  1eaa beb6          	ldw	x,_adc_plazma
9619  1eac 1c0001        	addw	x,#1
9620  1eaf bfb6          	ldw	_adc_plazma,x
9621                     ; 2001 GPIOB->DDR&=~(1<<4);
9623  1eb1 72195007      	bres	20487,#4
9624                     ; 2002 GPIOB->CR1&=~(1<<4);
9626  1eb5 72195008      	bres	20488,#4
9627                     ; 2003 GPIOB->CR2&=~(1<<4);
9629  1eb9 72195009      	bres	20489,#4
9630                     ; 2005 GPIOB->DDR&=~(1<<5);
9632  1ebd 721b5007      	bres	20487,#5
9633                     ; 2006 GPIOB->CR1&=~(1<<5);
9635  1ec1 721b5008      	bres	20488,#5
9636                     ; 2007 GPIOB->CR2&=~(1<<5);
9638  1ec5 721b5009      	bres	20489,#5
9639                     ; 2009 GPIOB->DDR&=~(1<<6);
9641  1ec9 721d5007      	bres	20487,#6
9642                     ; 2010 GPIOB->CR1&=~(1<<6);
9644  1ecd 721d5008      	bres	20488,#6
9645                     ; 2011 GPIOB->CR2&=~(1<<6);
9647  1ed1 721d5009      	bres	20489,#6
9648                     ; 2013 GPIOB->DDR&=~(1<<7);
9650  1ed5 721f5007      	bres	20487,#7
9651                     ; 2014 GPIOB->CR1&=~(1<<7);
9653  1ed9 721f5008      	bres	20488,#7
9654                     ; 2015 GPIOB->CR2&=~(1<<7);
9656  1edd 721f5009      	bres	20489,#7
9657                     ; 2025 ADC2->TDRL=0xff;
9659  1ee1 35ff5407      	mov	21511,#255
9660                     ; 2027 ADC2->CR2=0x08;
9662  1ee5 35085402      	mov	21506,#8
9663                     ; 2028 ADC2->CR1=0x40;
9665  1ee9 35405401      	mov	21505,#64
9666                     ; 2031 	ADC2->CSR=0x20+adc_ch+3;
9668  1eed b6c3          	ld	a,_adc_ch
9669  1eef ab23          	add	a,#35
9670  1ef1 c75400        	ld	21504,a
9671                     ; 2033 	ADC2->CR1|=1;
9673  1ef4 72105401      	bset	21505,#0
9674                     ; 2034 	ADC2->CR1|=1;
9676  1ef8 72105401      	bset	21505,#0
9677                     ; 2037 adc_plazma[1]=adc_ch;
9679  1efc b6c3          	ld	a,_adc_ch
9680  1efe 5f            	clrw	x
9681  1eff 97            	ld	xl,a
9682  1f00 bfb8          	ldw	_adc_plazma+2,x
9683                     ; 2038 }
9686  1f02 81            	ret
9720                     ; 2047 @far @interrupt void TIM4_UPD_Interrupt (void) 
9720                     ; 2048 {
9722                     	switch	.text
9723  1f03               f_TIM4_UPD_Interrupt:
9727                     ; 2049 TIM4->SR1&=~TIM4_SR1_UIF;
9729  1f03 72115342      	bres	21314,#0
9730                     ; 2051 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9732  1f07 3c08          	inc	_pwm_vent_cnt
9733  1f09 b608          	ld	a,_pwm_vent_cnt
9734  1f0b a10a          	cp	a,#10
9735  1f0d 2502          	jrult	L5314
9738  1f0f 3f08          	clr	_pwm_vent_cnt
9739  1f11               L5314:
9740                     ; 2052 GPIOB->ODR|=(1<<3);
9742  1f11 72165005      	bset	20485,#3
9743                     ; 2053 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9745  1f15 b608          	ld	a,_pwm_vent_cnt
9746  1f17 a105          	cp	a,#5
9747  1f19 2504          	jrult	L7314
9750  1f1b 72175005      	bres	20485,#3
9751  1f1f               L7314:
9752                     ; 2058 if(++t0_cnt0>=100)
9754  1f1f 9c            	rvf
9755  1f20 be01          	ldw	x,_t0_cnt0
9756  1f22 1c0001        	addw	x,#1
9757  1f25 bf01          	ldw	_t0_cnt0,x
9758  1f27 a30064        	cpw	x,#100
9759  1f2a 2f3f          	jrslt	L1414
9760                     ; 2060 	t0_cnt0=0;
9762  1f2c 5f            	clrw	x
9763  1f2d bf01          	ldw	_t0_cnt0,x
9764                     ; 2061 	b100Hz=1;
9766  1f2f 72100008      	bset	_b100Hz
9767                     ; 2063 	if(++t0_cnt1>=10)
9769  1f33 3c03          	inc	_t0_cnt1
9770  1f35 b603          	ld	a,_t0_cnt1
9771  1f37 a10a          	cp	a,#10
9772  1f39 2506          	jrult	L3414
9773                     ; 2065 		t0_cnt1=0;
9775  1f3b 3f03          	clr	_t0_cnt1
9776                     ; 2066 		b10Hz=1;
9778  1f3d 72100007      	bset	_b10Hz
9779  1f41               L3414:
9780                     ; 2069 	if(++t0_cnt2>=20)
9782  1f41 3c04          	inc	_t0_cnt2
9783  1f43 b604          	ld	a,_t0_cnt2
9784  1f45 a114          	cp	a,#20
9785  1f47 2506          	jrult	L5414
9786                     ; 2071 		t0_cnt2=0;
9788  1f49 3f04          	clr	_t0_cnt2
9789                     ; 2072 		b5Hz=1;
9791  1f4b 72100006      	bset	_b5Hz
9792  1f4f               L5414:
9793                     ; 2076 	if(++t0_cnt4>=50)
9795  1f4f 3c06          	inc	_t0_cnt4
9796  1f51 b606          	ld	a,_t0_cnt4
9797  1f53 a132          	cp	a,#50
9798  1f55 2506          	jrult	L7414
9799                     ; 2078 		t0_cnt4=0;
9801  1f57 3f06          	clr	_t0_cnt4
9802                     ; 2079 		b2Hz=1;
9804  1f59 72100005      	bset	_b2Hz
9805  1f5d               L7414:
9806                     ; 2082 	if(++t0_cnt3>=100)
9808  1f5d 3c05          	inc	_t0_cnt3
9809  1f5f b605          	ld	a,_t0_cnt3
9810  1f61 a164          	cp	a,#100
9811  1f63 2506          	jrult	L1414
9812                     ; 2084 		t0_cnt3=0;
9814  1f65 3f05          	clr	_t0_cnt3
9815                     ; 2085 		b1Hz=1;
9817  1f67 72100004      	bset	_b1Hz
9818  1f6b               L1414:
9819                     ; 2091 }
9822  1f6b 80            	iret
9847                     ; 2094 @far @interrupt void CAN_RX_Interrupt (void) 
9847                     ; 2095 {
9848                     	switch	.text
9849  1f6c               f_CAN_RX_Interrupt:
9853                     ; 2097 CAN->PSR= 7;									// page 7 - read messsage
9855  1f6c 35075427      	mov	21543,#7
9856                     ; 2099 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9858  1f70 ae000e        	ldw	x,#14
9859  1f73               L462:
9860  1f73 d65427        	ld	a,(21543,x)
9861  1f76 e7c3          	ld	(_mess-1,x),a
9862  1f78 5a            	decw	x
9863  1f79 26f8          	jrne	L462
9864                     ; 2110 bCAN_RX=1;
9866  1f7b 3501000a      	mov	_bCAN_RX,#1
9867                     ; 2111 CAN->RFR|=(1<<5);
9869  1f7f 721a5424      	bset	21540,#5
9870                     ; 2113 }
9873  1f83 80            	iret
9896                     ; 2116 @far @interrupt void CAN_TX_Interrupt (void) 
9896                     ; 2117 {
9897                     	switch	.text
9898  1f84               f_CAN_TX_Interrupt:
9902                     ; 2118 if((CAN->TSR)&(1<<0))
9904  1f84 c65422        	ld	a,21538
9905  1f87 a501          	bcp	a,#1
9906  1f89 2708          	jreq	L3714
9907                     ; 2120 	bTX_FREE=1;	
9909  1f8b 35010009      	mov	_bTX_FREE,#1
9910                     ; 2122 	CAN->TSR|=(1<<0);
9912  1f8f 72105422      	bset	21538,#0
9913  1f93               L3714:
9914                     ; 2124 }
9917  1f93 80            	iret
9975                     ; 2127 @far @interrupt void ADC2_EOC_Interrupt (void) {
9976                     	switch	.text
9977  1f94               f_ADC2_EOC_Interrupt:
9979       00000009      OFST:	set	9
9980  1f94 be00          	ldw	x,c_x
9981  1f96 89            	pushw	x
9982  1f97 be00          	ldw	x,c_y
9983  1f99 89            	pushw	x
9984  1f9a be02          	ldw	x,c_lreg+2
9985  1f9c 89            	pushw	x
9986  1f9d be00          	ldw	x,c_lreg
9987  1f9f 89            	pushw	x
9988  1fa0 5209          	subw	sp,#9
9991                     ; 2132 adc_plazma[2]++;
9993  1fa2 beba          	ldw	x,_adc_plazma+4
9994  1fa4 1c0001        	addw	x,#1
9995  1fa7 bfba          	ldw	_adc_plazma+4,x
9996                     ; 2139 ADC2->CSR&=~(1<<7);
9998  1fa9 721f5400      	bres	21504,#7
9999                     ; 2141 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
10001  1fad c65405        	ld	a,21509
10002  1fb0 b703          	ld	c_lreg+3,a
10003  1fb2 3f02          	clr	c_lreg+2
10004  1fb4 3f01          	clr	c_lreg+1
10005  1fb6 3f00          	clr	c_lreg
10006  1fb8 96            	ldw	x,sp
10007  1fb9 1c0001        	addw	x,#OFST-8
10008  1fbc cd0000        	call	c_rtol
10010  1fbf c65404        	ld	a,21508
10011  1fc2 5f            	clrw	x
10012  1fc3 97            	ld	xl,a
10013  1fc4 90ae0100      	ldw	y,#256
10014  1fc8 cd0000        	call	c_umul
10016  1fcb 96            	ldw	x,sp
10017  1fcc 1c0001        	addw	x,#OFST-8
10018  1fcf cd0000        	call	c_ladd
10020  1fd2 96            	ldw	x,sp
10021  1fd3 1c0006        	addw	x,#OFST-3
10022  1fd6 cd0000        	call	c_rtol
10024                     ; 2146 if(adr_drv_stat==1)
10026  1fd9 b608          	ld	a,_adr_drv_stat
10027  1fdb a101          	cp	a,#1
10028  1fdd 260b          	jrne	L3224
10029                     ; 2148 	adr_drv_stat=2;
10031  1fdf 35020008      	mov	_adr_drv_stat,#2
10032                     ; 2149 	adc_buff_[0]=temp_adc;
10034  1fe3 1e08          	ldw	x,(OFST-1,sp)
10035  1fe5 cf0009        	ldw	_adc_buff_,x
10037  1fe8 2020          	jra	L5224
10038  1fea               L3224:
10039                     ; 2152 else if(adr_drv_stat==3)
10041  1fea b608          	ld	a,_adr_drv_stat
10042  1fec a103          	cp	a,#3
10043  1fee 260b          	jrne	L7224
10044                     ; 2154 	adr_drv_stat=4;
10046  1ff0 35040008      	mov	_adr_drv_stat,#4
10047                     ; 2155 	adc_buff_[1]=temp_adc;
10049  1ff4 1e08          	ldw	x,(OFST-1,sp)
10050  1ff6 cf000b        	ldw	_adc_buff_+2,x
10052  1ff9 200f          	jra	L5224
10053  1ffb               L7224:
10054                     ; 2158 else if(adr_drv_stat==5)
10056  1ffb b608          	ld	a,_adr_drv_stat
10057  1ffd a105          	cp	a,#5
10058  1fff 2609          	jrne	L5224
10059                     ; 2160 	adr_drv_stat=6;
10061  2001 35060008      	mov	_adr_drv_stat,#6
10062                     ; 2161 	adc_buff_[9]=temp_adc;
10064  2005 1e08          	ldw	x,(OFST-1,sp)
10065  2007 cf001b        	ldw	_adc_buff_+18,x
10066  200a               L5224:
10067                     ; 2164 adc_buff[adc_ch][adc_cnt]=temp_adc;
10069  200a b6c2          	ld	a,_adc_cnt
10070  200c 5f            	clrw	x
10071  200d 97            	ld	xl,a
10072  200e 58            	sllw	x
10073  200f 1f03          	ldw	(OFST-6,sp),x
10074  2011 b6c3          	ld	a,_adc_ch
10075  2013 97            	ld	xl,a
10076  2014 a620          	ld	a,#32
10077  2016 42            	mul	x,a
10078  2017 72fb03        	addw	x,(OFST-6,sp)
10079  201a 1608          	ldw	y,(OFST-1,sp)
10080  201c df001d        	ldw	(_adc_buff,x),y
10081                     ; 2170 adc_ch++;
10083  201f 3cc3          	inc	_adc_ch
10084                     ; 2171 if(adc_ch>=5)
10086  2021 b6c3          	ld	a,_adc_ch
10087  2023 a105          	cp	a,#5
10088  2025 250c          	jrult	L5324
10089                     ; 2174 	adc_ch=0;
10091  2027 3fc3          	clr	_adc_ch
10092                     ; 2175 	adc_cnt++;
10094  2029 3cc2          	inc	_adc_cnt
10095                     ; 2176 	if(adc_cnt>=16)
10097  202b b6c2          	ld	a,_adc_cnt
10098  202d a110          	cp	a,#16
10099  202f 2502          	jrult	L5324
10100                     ; 2178 		adc_cnt=0;
10102  2031 3fc2          	clr	_adc_cnt
10103  2033               L5324:
10104                     ; 2182 if((adc_cnt&0x03)==0)
10106  2033 b6c2          	ld	a,_adc_cnt
10107  2035 a503          	bcp	a,#3
10108  2037 264b          	jrne	L1424
10109                     ; 2186 	tempSS=0;
10111  2039 ae0000        	ldw	x,#0
10112  203c 1f08          	ldw	(OFST-1,sp),x
10113  203e ae0000        	ldw	x,#0
10114  2041 1f06          	ldw	(OFST-3,sp),x
10115                     ; 2187 	for(i=0;i<16;i++)
10117  2043 0f05          	clr	(OFST-4,sp)
10118  2045               L3424:
10119                     ; 2189 		tempSS+=(signed long)adc_buff[adc_ch][i];
10121  2045 7b05          	ld	a,(OFST-4,sp)
10122  2047 5f            	clrw	x
10123  2048 97            	ld	xl,a
10124  2049 58            	sllw	x
10125  204a 1f03          	ldw	(OFST-6,sp),x
10126  204c b6c3          	ld	a,_adc_ch
10127  204e 97            	ld	xl,a
10128  204f a620          	ld	a,#32
10129  2051 42            	mul	x,a
10130  2052 72fb03        	addw	x,(OFST-6,sp)
10131  2055 de001d        	ldw	x,(_adc_buff,x)
10132  2058 cd0000        	call	c_itolx
10134  205b 96            	ldw	x,sp
10135  205c 1c0006        	addw	x,#OFST-3
10136  205f cd0000        	call	c_lgadd
10138                     ; 2187 	for(i=0;i<16;i++)
10140  2062 0c05          	inc	(OFST-4,sp)
10143  2064 7b05          	ld	a,(OFST-4,sp)
10144  2066 a110          	cp	a,#16
10145  2068 25db          	jrult	L3424
10146                     ; 2191 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
10148  206a 96            	ldw	x,sp
10149  206b 1c0006        	addw	x,#OFST-3
10150  206e cd0000        	call	c_ltor
10152  2071 a604          	ld	a,#4
10153  2073 cd0000        	call	c_lrsh
10155  2076 be02          	ldw	x,c_lreg+2
10156  2078 b6c3          	ld	a,_adc_ch
10157  207a 905f          	clrw	y
10158  207c 9097          	ld	yl,a
10159  207e 9058          	sllw	y
10160  2080 90df0009      	ldw	(_adc_buff_,y),x
10161  2084               L1424:
10162                     ; 2202 adc_plazma_short++;
10164  2084 bec0          	ldw	x,_adc_plazma_short
10165  2086 1c0001        	addw	x,#1
10166  2089 bfc0          	ldw	_adc_plazma_short,x
10167                     ; 2217 }
10170  208b 5b09          	addw	sp,#9
10171  208d 85            	popw	x
10172  208e bf00          	ldw	c_lreg,x
10173  2090 85            	popw	x
10174  2091 bf02          	ldw	c_lreg+2,x
10175  2093 85            	popw	x
10176  2094 bf00          	ldw	c_y,x
10177  2096 85            	popw	x
10178  2097 bf00          	ldw	c_x,x
10179  2099 80            	iret
10243                     ; 2225 main()
10243                     ; 2226 {
10245                     	switch	.text
10246  209a               _main:
10250                     ; 2228 CLK->ECKR|=1;
10252  209a 721050c1      	bset	20673,#0
10254  209e               L3624:
10255                     ; 2229 while((CLK->ECKR & 2) == 0);
10257  209e c650c1        	ld	a,20673
10258  20a1 a502          	bcp	a,#2
10259  20a3 27f9          	jreq	L3624
10260                     ; 2230 CLK->SWCR|=2;
10262  20a5 721250c5      	bset	20677,#1
10263                     ; 2231 CLK->SWR=0xB4;
10265  20a9 35b450c4      	mov	20676,#180
10266                     ; 2233 delay_ms(200);
10268  20ad ae00c8        	ldw	x,#200
10269  20b0 cd011d        	call	_delay_ms
10271                     ; 2234 FLASH_DUKR=0xae;
10273  20b3 35ae5064      	mov	_FLASH_DUKR,#174
10274                     ; 2235 FLASH_DUKR=0x56;
10276  20b7 35565064      	mov	_FLASH_DUKR,#86
10277                     ; 2236 enableInterrupts();
10280  20bb 9a            rim
10282                     ; 2239 adr_drv_v3();
10285  20bc cd1299        	call	_adr_drv_v3
10287                     ; 2242 BLOCK_INIT
10289  20bf 72145007      	bset	20487,#2
10292  20c3 72145008      	bset	20488,#2
10295  20c7 72155009      	bres	20489,#2
10296                     ; 2244 t4_init();
10298  20cb cd1e5c        	call	_t4_init
10300                     ; 2246 		GPIOG->DDR|=(1<<0);
10302  20ce 72105020      	bset	20512,#0
10303                     ; 2247 		GPIOG->CR1|=(1<<0);
10305  20d2 72105021      	bset	20513,#0
10306                     ; 2248 		GPIOG->CR2&=~(1<<0);	
10308  20d6 72115022      	bres	20514,#0
10309                     ; 2251 		GPIOG->DDR&=~(1<<1);
10311  20da 72135020      	bres	20512,#1
10312                     ; 2252 		GPIOG->CR1|=(1<<1);
10314  20de 72125021      	bset	20513,#1
10315                     ; 2253 		GPIOG->CR2&=~(1<<1);
10317  20e2 72135022      	bres	20514,#1
10318                     ; 2255 init_CAN();
10320  20e6 cd15dc        	call	_init_CAN
10322                     ; 2260 GPIOC->DDR|=(1<<1);
10324  20e9 7212500c      	bset	20492,#1
10325                     ; 2261 GPIOC->CR1|=(1<<1);
10327  20ed 7212500d      	bset	20493,#1
10328                     ; 2262 GPIOC->CR2|=(1<<1);
10330  20f1 7212500e      	bset	20494,#1
10331                     ; 2264 GPIOC->DDR|=(1<<2);
10333  20f5 7214500c      	bset	20492,#2
10334                     ; 2265 GPIOC->CR1|=(1<<2);
10336  20f9 7214500d      	bset	20493,#2
10337                     ; 2266 GPIOC->CR2|=(1<<2);
10339  20fd 7214500e      	bset	20494,#2
10340                     ; 2273 t1_init();
10342  2101 cd1e6d        	call	_t1_init
10344                     ; 2275 GPIOA->DDR|=(1<<5);
10346  2104 721a5002      	bset	20482,#5
10347                     ; 2276 GPIOA->CR1|=(1<<5);
10349  2108 721a5003      	bset	20483,#5
10350                     ; 2277 GPIOA->CR2&=~(1<<5);
10352  210c 721b5004      	bres	20484,#5
10353                     ; 2283 GPIOB->DDR&=~(1<<3);
10355  2110 72175007      	bres	20487,#3
10356                     ; 2284 GPIOB->CR1&=~(1<<3);
10358  2114 72175008      	bres	20488,#3
10359                     ; 2285 GPIOB->CR2&=~(1<<3);
10361  2118 72175009      	bres	20489,#3
10362                     ; 2287 GPIOC->DDR|=(1<<3);
10364  211c 7216500c      	bset	20492,#3
10365                     ; 2288 GPIOC->CR1|=(1<<3);
10367  2120 7216500d      	bset	20493,#3
10368                     ; 2289 GPIOC->CR2|=(1<<3);
10370  2124 7216500e      	bset	20494,#3
10371                     ; 2292 if(bps_class==bpsIPS) 
10373  2128 b604          	ld	a,_bps_class
10374  212a a101          	cp	a,#1
10375  212c 260a          	jrne	L1724
10376                     ; 2294 	pwm_u=ee_U_AVT;
10378  212e ce000c        	ldw	x,_ee_U_AVT
10379  2131 bf0e          	ldw	_pwm_u,x
10380                     ; 2295 	volum_u_main_=ee_U_AVT;
10382  2133 ce000c        	ldw	x,_ee_U_AVT
10383  2136 bf1f          	ldw	_volum_u_main_,x
10384  2138               L1724:
10385                     ; 2302 	if(bCAN_RX)
10387  2138 3d0a          	tnz	_bCAN_RX
10388  213a 2705          	jreq	L5724
10389                     ; 2304 		bCAN_RX=0;
10391  213c 3f0a          	clr	_bCAN_RX
10392                     ; 2305 		can_in_an();	
10394  213e cd17e7        	call	_can_in_an
10396  2141               L5724:
10397                     ; 2307 	if(b100Hz)
10399                     	btst	_b100Hz
10400  2146 240a          	jruge	L7724
10401                     ; 2309 		b100Hz=0;
10403  2148 72110008      	bres	_b100Hz
10404                     ; 2318 		adc2_init();
10406  214c cd1eaa        	call	_adc2_init
10408                     ; 2319 		can_tx_hndl();
10410  214f cd16cf        	call	_can_tx_hndl
10412  2152               L7724:
10413                     ; 2322 	if(b10Hz)
10415                     	btst	_b10Hz
10416  2157 2419          	jruge	L1034
10417                     ; 2324 		b10Hz=0;
10419  2159 72110007      	bres	_b10Hz
10420                     ; 2326 		matemat();
10422  215d cd0e00        	call	_matemat
10424                     ; 2327 		led_drv(); 
10426  2160 cd07e2        	call	_led_drv
10428                     ; 2328 	  link_drv();
10430  2163 cd08d0        	call	_link_drv
10432                     ; 2329 	  pwr_hndl();		//вычисление воздействий на силу
10434  2166 cd0c03        	call	_pwr_hndl
10436                     ; 2330 	  JP_drv();
10438  2169 cd0845        	call	_JP_drv
10440                     ; 2331 	  flags_drv();
10442  216c cd124e        	call	_flags_drv
10444                     ; 2332 		net_drv();
10446  216f cd1739        	call	_net_drv
10448  2172               L1034:
10449                     ; 2335 	if(b5Hz)
10451                     	btst	_b5Hz
10452  2177 240d          	jruge	L3034
10453                     ; 2337 		b5Hz=0;
10455  2179 72110006      	bres	_b5Hz
10456                     ; 2339 		pwr_drv();		//воздействие на силу
10458  217d cd0a8b        	call	_pwr_drv
10460                     ; 2340 		led_hndl();
10462  2180 cd015f        	call	_led_hndl
10464                     ; 2342 		vent_drv();
10466  2183 cd0928        	call	_vent_drv
10468  2186               L3034:
10469                     ; 2345 	if(b2Hz)
10471                     	btst	_b2Hz
10472  218b 2404          	jruge	L5034
10473                     ; 2347 		b2Hz=0;
10475  218d 72110005      	bres	_b2Hz
10476  2191               L5034:
10477                     ; 2356 	if(b1Hz)
10479                     	btst	_b1Hz
10480  2196 24a0          	jruge	L1724
10481                     ; 2358 		b1Hz=0;
10483  2198 72110004      	bres	_b1Hz
10484                     ; 2360 		temper_drv();			//вычисление аварий температуры
10486  219c cd0f7e        	call	_temper_drv
10488                     ; 2361 		u_drv();
10490  219f cd1055        	call	_u_drv
10492                     ; 2362           x_drv();
10494  21a2 cd1135        	call	_x_drv
10496                     ; 2363           if(main_cnt<1000)main_cnt++;
10498  21a5 9c            	rvf
10499  21a6 be51          	ldw	x,_main_cnt
10500  21a8 a303e8        	cpw	x,#1000
10501  21ab 2e07          	jrsge	L1134
10504  21ad be51          	ldw	x,_main_cnt
10505  21af 1c0001        	addw	x,#1
10506  21b2 bf51          	ldw	_main_cnt,x
10507  21b4               L1134:
10508                     ; 2364   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10510  21b4 b663          	ld	a,_link
10511  21b6 a1aa          	cp	a,#170
10512  21b8 2706          	jreq	L5134
10514  21ba b64a          	ld	a,_jp_mode
10515  21bc a103          	cp	a,#3
10516  21be 2603          	jrne	L3134
10517  21c0               L5134:
10520  21c0 cd11af        	call	_apv_hndl
10522  21c3               L3134:
10523                     ; 2367   		can_error_cnt++;
10525  21c3 3c71          	inc	_can_error_cnt
10526                     ; 2368   		if(can_error_cnt>=10)
10528  21c5 b671          	ld	a,_can_error_cnt
10529  21c7 a10a          	cp	a,#10
10530  21c9 2505          	jrult	L7134
10531                     ; 2370   			can_error_cnt=0;
10533  21cb 3f71          	clr	_can_error_cnt
10534                     ; 2371 			init_CAN();
10536  21cd cd15dc        	call	_init_CAN
10538  21d0               L7134:
10539                     ; 2375 		volum_u_main_drv();
10541  21d0 cd1489        	call	_volum_u_main_drv
10543                     ; 2377 		pwm_stat++;
10545  21d3 3c07          	inc	_pwm_stat
10546                     ; 2378 		if(pwm_stat>=10)pwm_stat=0;
10548  21d5 b607          	ld	a,_pwm_stat
10549  21d7 a10a          	cp	a,#10
10550  21d9 2502          	jrult	L1234
10553  21db 3f07          	clr	_pwm_stat
10554  21dd               L1234:
10555                     ; 2379 adc_plazma_short++;
10557  21dd bec0          	ldw	x,_adc_plazma_short
10558  21df 1c0001        	addw	x,#1
10559  21e2 bfc0          	ldw	_adc_plazma_short,x
10560                     ; 2381 		vent_resurs_hndl();
10562  21e4 cd0000        	call	_vent_resurs_hndl
10564  21e7 ac382138      	jpf	L1724
11634                     	xdef	_main
11635                     	xdef	f_ADC2_EOC_Interrupt
11636                     	xdef	f_CAN_TX_Interrupt
11637                     	xdef	f_CAN_RX_Interrupt
11638                     	xdef	f_TIM4_UPD_Interrupt
11639                     	xdef	_adc2_init
11640                     	xdef	_t1_init
11641                     	xdef	_t4_init
11642                     	xdef	_can_in_an
11643                     	xdef	_net_drv
11644                     	xdef	_can_tx_hndl
11645                     	xdef	_can_transmit
11646                     	xdef	_init_CAN
11647                     	xdef	_volum_u_main_drv
11648                     	xdef	_adr_drv_v3
11649                     	xdef	_adr_drv_v4
11650                     	xdef	_flags_drv
11651                     	xdef	_apv_hndl
11652                     	xdef	_apv_stop
11653                     	xdef	_apv_start
11654                     	xdef	_x_drv
11655                     	xdef	_u_drv
11656                     	xdef	_temper_drv
11657                     	xdef	_matemat
11658                     	xdef	_pwr_hndl
11659                     	xdef	_pwr_drv
11660                     	xdef	_vent_drv
11661                     	xdef	_link_drv
11662                     	xdef	_JP_drv
11663                     	xdef	_led_drv
11664                     	xdef	_led_hndl
11665                     	xdef	_delay_ms
11666                     	xdef	_granee
11667                     	xdef	_gran
11668                     	xdef	_vent_resurs_hndl
11669                     	switch	.ubsct
11670  0001               _vent_resurs_tx_cnt:
11671  0001 00            	ds.b	1
11672                     	xdef	_vent_resurs_tx_cnt
11673                     	switch	.bss
11674  0000               _vent_resurs_buff:
11675  0000 00000000      	ds.b	4
11676                     	xdef	_vent_resurs_buff
11677                     	switch	.ubsct
11678  0002               _vent_resurs_sec_cnt:
11679  0002 0000          	ds.b	2
11680                     	xdef	_vent_resurs_sec_cnt
11681                     .eeprom:	section	.data
11682  0000               _vent_resurs:
11683  0000 0000          	ds.b	2
11684                     	xdef	_vent_resurs
11685  0002               _ee_IMAXVENT:
11686  0002 0000          	ds.b	2
11687                     	xdef	_ee_IMAXVENT
11688                     	switch	.ubsct
11689  0004               _bps_class:
11690  0004 00            	ds.b	1
11691                     	xdef	_bps_class
11692  0005               _vent_pwm:
11693  0005 0000          	ds.b	2
11694                     	xdef	_vent_pwm
11695  0007               _pwm_stat:
11696  0007 00            	ds.b	1
11697                     	xdef	_pwm_stat
11698  0008               _pwm_vent_cnt:
11699  0008 00            	ds.b	1
11700                     	xdef	_pwm_vent_cnt
11701                     	switch	.eeprom
11702  0004               _ee_DEVICE:
11703  0004 0000          	ds.b	2
11704                     	xdef	_ee_DEVICE
11705  0006               _ee_AVT_MODE:
11706  0006 0000          	ds.b	2
11707                     	xdef	_ee_AVT_MODE
11708                     	switch	.ubsct
11709  0009               _i_main_bps_cnt:
11710  0009 000000000000  	ds.b	6
11711                     	xdef	_i_main_bps_cnt
11712  000f               _i_main_sigma:
11713  000f 0000          	ds.b	2
11714                     	xdef	_i_main_sigma
11715  0011               _i_main_num_of_bps:
11716  0011 00            	ds.b	1
11717                     	xdef	_i_main_num_of_bps
11718  0012               _i_main_avg:
11719  0012 0000          	ds.b	2
11720                     	xdef	_i_main_avg
11721  0014               _i_main_flag:
11722  0014 000000000000  	ds.b	6
11723                     	xdef	_i_main_flag
11724  001a               _i_main:
11725  001a 000000000000  	ds.b	12
11726                     	xdef	_i_main
11727  0026               _x:
11728  0026 000000000000  	ds.b	12
11729                     	xdef	_x
11730                     	xdef	_volum_u_main_
11731                     	switch	.eeprom
11732  0008               _UU_AVT:
11733  0008 0000          	ds.b	2
11734                     	xdef	_UU_AVT
11735                     	switch	.ubsct
11736  0032               _cnt_net_drv:
11737  0032 00            	ds.b	1
11738                     	xdef	_cnt_net_drv
11739                     	switch	.bit
11740  0002               _bMAIN:
11741  0002 00            	ds.b	1
11742                     	xdef	_bMAIN
11743                     	switch	.ubsct
11744  0033               _plazma_int:
11745  0033 000000000000  	ds.b	6
11746                     	xdef	_plazma_int
11747                     	xdef	_rotor_int
11748  0039               _led_green_buff:
11749  0039 00000000      	ds.b	4
11750                     	xdef	_led_green_buff
11751  003d               _led_red_buff:
11752  003d 00000000      	ds.b	4
11753                     	xdef	_led_red_buff
11754                     	xdef	_led_drv_cnt
11755                     	xdef	_led_green
11756                     	xdef	_led_red
11757  0041               _res_fl_cnt:
11758  0041 00            	ds.b	1
11759                     	xdef	_res_fl_cnt
11760                     	xdef	_bRES_
11761                     	xdef	_bRES
11762                     	switch	.eeprom
11763  000a               _res_fl_:
11764  000a 00            	ds.b	1
11765                     	xdef	_res_fl_
11766  000b               _res_fl:
11767  000b 00            	ds.b	1
11768                     	xdef	_res_fl
11769                     	switch	.ubsct
11770  0042               _cnt_apv_off:
11771  0042 00            	ds.b	1
11772                     	xdef	_cnt_apv_off
11773                     	switch	.bit
11774  0003               _bAPV:
11775  0003 00            	ds.b	1
11776                     	xdef	_bAPV
11777                     	switch	.ubsct
11778  0043               _apv_cnt_:
11779  0043 0000          	ds.b	2
11780                     	xdef	_apv_cnt_
11781  0045               _apv_cnt:
11782  0045 000000        	ds.b	3
11783                     	xdef	_apv_cnt
11784                     	xdef	_bBL_IPS
11785                     	xdef	_bBL
11786  0048               _cnt_JP1:
11787  0048 00            	ds.b	1
11788                     	xdef	_cnt_JP1
11789  0049               _cnt_JP0:
11790  0049 00            	ds.b	1
11791                     	xdef	_cnt_JP0
11792  004a               _jp_mode:
11793  004a 00            	ds.b	1
11794                     	xdef	_jp_mode
11795                     	xdef	_pwm_i
11796                     	xdef	_pwm_u
11797  004b               _tmax_cnt:
11798  004b 0000          	ds.b	2
11799                     	xdef	_tmax_cnt
11800  004d               _tsign_cnt:
11801  004d 0000          	ds.b	2
11802                     	xdef	_tsign_cnt
11803                     	switch	.eeprom
11804  000c               _ee_U_AVT:
11805  000c 0000          	ds.b	2
11806                     	xdef	_ee_U_AVT
11807  000e               _ee_tsign:
11808  000e 0000          	ds.b	2
11809                     	xdef	_ee_tsign
11810  0010               _ee_tmax:
11811  0010 0000          	ds.b	2
11812                     	xdef	_ee_tmax
11813  0012               _ee_dU:
11814  0012 0000          	ds.b	2
11815                     	xdef	_ee_dU
11816  0014               _ee_Umax:
11817  0014 0000          	ds.b	2
11818                     	xdef	_ee_Umax
11819  0016               _ee_TZAS:
11820  0016 0000          	ds.b	2
11821                     	xdef	_ee_TZAS
11822                     	switch	.ubsct
11823  004f               _main_cnt1:
11824  004f 0000          	ds.b	2
11825                     	xdef	_main_cnt1
11826  0051               _main_cnt:
11827  0051 0000          	ds.b	2
11828                     	xdef	_main_cnt
11829  0053               _off_bp_cnt:
11830  0053 00            	ds.b	1
11831                     	xdef	_off_bp_cnt
11832                     	xdef	_vol_i_temp_avar
11833  0054               _flags_tu_cnt_off:
11834  0054 00            	ds.b	1
11835                     	xdef	_flags_tu_cnt_off
11836  0055               _flags_tu_cnt_on:
11837  0055 00            	ds.b	1
11838                     	xdef	_flags_tu_cnt_on
11839  0056               _vol_i_temp:
11840  0056 0000          	ds.b	2
11841                     	xdef	_vol_i_temp
11842  0058               _vol_u_temp:
11843  0058 0000          	ds.b	2
11844                     	xdef	_vol_u_temp
11845                     	switch	.eeprom
11846  0018               __x_ee_:
11847  0018 0000          	ds.b	2
11848                     	xdef	__x_ee_
11849                     	switch	.ubsct
11850  005a               __x_cnt:
11851  005a 0000          	ds.b	2
11852                     	xdef	__x_cnt
11853  005c               __x__:
11854  005c 0000          	ds.b	2
11855                     	xdef	__x__
11856  005e               __x_:
11857  005e 0000          	ds.b	2
11858                     	xdef	__x_
11859  0060               _flags_tu:
11860  0060 00            	ds.b	1
11861                     	xdef	_flags_tu
11862                     	xdef	_flags
11863  0061               _link_cnt:
11864  0061 0000          	ds.b	2
11865                     	xdef	_link_cnt
11866  0063               _link:
11867  0063 00            	ds.b	1
11868                     	xdef	_link
11869  0064               _umin_cnt:
11870  0064 0000          	ds.b	2
11871                     	xdef	_umin_cnt
11872  0066               _umax_cnt:
11873  0066 0000          	ds.b	2
11874                     	xdef	_umax_cnt
11875                     	switch	.eeprom
11876  001a               _ee_K:
11877  001a 000000000000  	ds.b	16
11878                     	xdef	_ee_K
11879                     	switch	.ubsct
11880  0068               _T:
11881  0068 00            	ds.b	1
11882                     	xdef	_T
11883  0069               _Udb:
11884  0069 0000          	ds.b	2
11885                     	xdef	_Udb
11886  006b               _Ui:
11887  006b 0000          	ds.b	2
11888                     	xdef	_Ui
11889  006d               _Un:
11890  006d 0000          	ds.b	2
11891                     	xdef	_Un
11892  006f               _I:
11893  006f 0000          	ds.b	2
11894                     	xdef	_I
11895  0071               _can_error_cnt:
11896  0071 00            	ds.b	1
11897                     	xdef	_can_error_cnt
11898                     	xdef	_bCAN_RX
11899  0072               _tx_busy_cnt:
11900  0072 00            	ds.b	1
11901                     	xdef	_tx_busy_cnt
11902                     	xdef	_bTX_FREE
11903  0073               _can_buff_rd_ptr:
11904  0073 00            	ds.b	1
11905                     	xdef	_can_buff_rd_ptr
11906  0074               _can_buff_wr_ptr:
11907  0074 00            	ds.b	1
11908                     	xdef	_can_buff_wr_ptr
11909  0075               _can_out_buff:
11910  0075 000000000000  	ds.b	64
11911                     	xdef	_can_out_buff
11912                     	switch	.bss
11913  0004               _adress_error:
11914  0004 00            	ds.b	1
11915                     	xdef	_adress_error
11916  0005               _adress:
11917  0005 00            	ds.b	1
11918                     	xdef	_adress
11919  0006               _adr:
11920  0006 000000        	ds.b	3
11921                     	xdef	_adr
11922                     	xdef	_adr_drv_stat
11923                     	xdef	_led_ind
11924                     	switch	.ubsct
11925  00b5               _led_ind_cnt:
11926  00b5 00            	ds.b	1
11927                     	xdef	_led_ind_cnt
11928  00b6               _adc_plazma:
11929  00b6 000000000000  	ds.b	10
11930                     	xdef	_adc_plazma
11931  00c0               _adc_plazma_short:
11932  00c0 0000          	ds.b	2
11933                     	xdef	_adc_plazma_short
11934  00c2               _adc_cnt:
11935  00c2 00            	ds.b	1
11936                     	xdef	_adc_cnt
11937  00c3               _adc_ch:
11938  00c3 00            	ds.b	1
11939                     	xdef	_adc_ch
11940                     	switch	.bss
11941  0009               _adc_buff_:
11942  0009 000000000000  	ds.b	20
11943                     	xdef	_adc_buff_
11944  001d               _adc_buff:
11945  001d 000000000000  	ds.b	320
11946                     	xdef	_adc_buff
11947                     	switch	.ubsct
11948  00c4               _mess:
11949  00c4 000000000000  	ds.b	14
11950                     	xdef	_mess
11951                     	switch	.bit
11952  0004               _b1Hz:
11953  0004 00            	ds.b	1
11954                     	xdef	_b1Hz
11955  0005               _b2Hz:
11956  0005 00            	ds.b	1
11957                     	xdef	_b2Hz
11958  0006               _b5Hz:
11959  0006 00            	ds.b	1
11960                     	xdef	_b5Hz
11961  0007               _b10Hz:
11962  0007 00            	ds.b	1
11963                     	xdef	_b10Hz
11964  0008               _b100Hz:
11965  0008 00            	ds.b	1
11966                     	xdef	_b100Hz
11967                     	xdef	_t0_cnt4
11968                     	xdef	_t0_cnt3
11969                     	xdef	_t0_cnt2
11970                     	xdef	_t0_cnt1
11971                     	xdef	_t0_cnt0
11972                     	xdef	_bVENT_BLOCK
11973                     	xref.b	c_lreg
11974                     	xref.b	c_x
11975                     	xref.b	c_y
11995                     	xref	c_lrsh
11996                     	xref	c_lgadd
11997                     	xref	c_ladd
11998                     	xref	c_umul
11999                     	xref	c_lgmul
12000                     	xref	c_lgsub
12001                     	xref	c_lsbc
12002                     	xref	c_idiv
12003                     	xref	c_ldiv
12004                     	xref	c_itolx
12005                     	xref	c_eewrc
12006                     	xref	c_imul
12007                     	xref	c_ltor
12008                     	xref	c_lgadc
12009                     	xref	c_rtol
12010                     	xref	c_vmul
12011                     	xref	c_eewrw
12012                     	xref	c_lcmp
12013                     	xref	c_uitolx
12014                     	end
