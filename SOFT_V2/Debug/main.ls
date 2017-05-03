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
2262                     .const:	section	.text
2263  0000               L6:
2264  0000 0000ea60      	dc.l	60000
2265                     ; 177 void vent_resurs_hndl(void)
2265                     ; 178 {
2266                     	scross	off
2267                     	switch	.text
2268  0000               _vent_resurs_hndl:
2270  0000 88            	push	a
2271       00000001      OFST:	set	1
2274                     ; 180 if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
2276  0001 3d00          	tnz	_bVENT_BLOCK
2277  0003 2607          	jrne	L7441
2280  0005 be02          	ldw	x,_vent_resurs_sec_cnt
2281  0007 1c0001        	addw	x,#1
2282  000a bf02          	ldw	_vent_resurs_sec_cnt,x
2283  000c               L7441:
2284                     ; 181 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2286  000c be02          	ldw	x,_vent_resurs_sec_cnt
2287  000e a30e11        	cpw	x,#3601
2288  0011 251b          	jrult	L1541
2289                     ; 183 	if(vent_resurs<60000)vent_resurs++;
2291  0013 9c            	rvf
2292  0014 ce0000        	ldw	x,_vent_resurs
2293  0017 cd0000        	call	c_uitolx
2295  001a ae0000        	ldw	x,#L6
2296  001d cd0000        	call	c_lcmp
2298  0020 2e09          	jrsge	L3541
2301  0022 ce0000        	ldw	x,_vent_resurs
2302  0025 1c0001        	addw	x,#1
2303  0028 cf0000        	ldw	_vent_resurs,x
2304  002b               L3541:
2305                     ; 184 	vent_resurs_sec_cnt=0;
2307  002b 5f            	clrw	x
2308  002c bf02          	ldw	_vent_resurs_sec_cnt,x
2309  002e               L1541:
2310                     ; 189 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2312  002e c60001        	ld	a,_vent_resurs+1
2313  0031 a40f          	and	a,#15
2314  0033 c70000        	ld	_vent_resurs_buff,a
2315                     ; 190 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2317  0036 c60001        	ld	a,_vent_resurs+1
2318  0039 a4f0          	and	a,#240
2319  003b 4e            	swap	a
2320  003c a40f          	and	a,#15
2321  003e aa40          	or	a,#64
2322  0040 c70001        	ld	_vent_resurs_buff+1,a
2323                     ; 191 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2325  0043 c60000        	ld	a,_vent_resurs
2326  0046 97            	ld	xl,a
2327  0047 c60001        	ld	a,_vent_resurs+1
2328  004a 9f            	ld	a,xl
2329  004b a40f          	and	a,#15
2330  004d 97            	ld	xl,a
2331  004e 4f            	clr	a
2332  004f 02            	rlwa	x,a
2333  0050 4f            	clr	a
2334  0051 01            	rrwa	x,a
2335  0052 9f            	ld	a,xl
2336  0053 aa80          	or	a,#128
2337  0055 c70002        	ld	_vent_resurs_buff+2,a
2338                     ; 192 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2340  0058 c60000        	ld	a,_vent_resurs
2341  005b 97            	ld	xl,a
2342  005c c60001        	ld	a,_vent_resurs+1
2343  005f 9f            	ld	a,xl
2344  0060 a4f0          	and	a,#240
2345  0062 97            	ld	xl,a
2346  0063 4f            	clr	a
2347  0064 02            	rlwa	x,a
2348  0065 01            	rrwa	x,a
2349  0066 4f            	clr	a
2350  0067 41            	exg	a,xl
2351  0068 4e            	swap	a
2352  0069 a40f          	and	a,#15
2353  006b 02            	rlwa	x,a
2354  006c 9f            	ld	a,xl
2355  006d aac0          	or	a,#192
2356  006f c70003        	ld	_vent_resurs_buff+3,a
2357                     ; 194 temp=vent_resurs_buff[0]&0x0f;
2359  0072 c60000        	ld	a,_vent_resurs_buff
2360  0075 a40f          	and	a,#15
2361  0077 6b01          	ld	(OFST+0,sp),a
2362                     ; 195 temp^=vent_resurs_buff[1]&0x0f;
2364  0079 c60001        	ld	a,_vent_resurs_buff+1
2365  007c a40f          	and	a,#15
2366  007e 1801          	xor	a,(OFST+0,sp)
2367  0080 6b01          	ld	(OFST+0,sp),a
2368                     ; 196 temp^=vent_resurs_buff[2]&0x0f;
2370  0082 c60002        	ld	a,_vent_resurs_buff+2
2371  0085 a40f          	and	a,#15
2372  0087 1801          	xor	a,(OFST+0,sp)
2373  0089 6b01          	ld	(OFST+0,sp),a
2374                     ; 197 temp^=vent_resurs_buff[3]&0x0f;
2376  008b c60003        	ld	a,_vent_resurs_buff+3
2377  008e a40f          	and	a,#15
2378  0090 1801          	xor	a,(OFST+0,sp)
2379  0092 6b01          	ld	(OFST+0,sp),a
2380                     ; 199 vent_resurs_buff[0]|=(temp&0x03)<<4;
2382  0094 7b01          	ld	a,(OFST+0,sp)
2383  0096 a403          	and	a,#3
2384  0098 97            	ld	xl,a
2385  0099 a610          	ld	a,#16
2386  009b 42            	mul	x,a
2387  009c 9f            	ld	a,xl
2388  009d ca0000        	or	a,_vent_resurs_buff
2389  00a0 c70000        	ld	_vent_resurs_buff,a
2390                     ; 200 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2392  00a3 7b01          	ld	a,(OFST+0,sp)
2393  00a5 a40c          	and	a,#12
2394  00a7 48            	sll	a
2395  00a8 48            	sll	a
2396  00a9 ca0001        	or	a,_vent_resurs_buff+1
2397  00ac c70001        	ld	_vent_resurs_buff+1,a
2398                     ; 201 vent_resurs_buff[2]|=(temp&0x30);
2400  00af 7b01          	ld	a,(OFST+0,sp)
2401  00b1 a430          	and	a,#48
2402  00b3 ca0002        	or	a,_vent_resurs_buff+2
2403  00b6 c70002        	ld	_vent_resurs_buff+2,a
2404                     ; 202 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2406  00b9 7b01          	ld	a,(OFST+0,sp)
2407  00bb a4c0          	and	a,#192
2408  00bd 44            	srl	a
2409  00be 44            	srl	a
2410  00bf ca0003        	or	a,_vent_resurs_buff+3
2411  00c2 c70003        	ld	_vent_resurs_buff+3,a
2412                     ; 205 vent_resurs_tx_cnt++;
2414  00c5 3c01          	inc	_vent_resurs_tx_cnt
2415                     ; 206 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2417  00c7 b601          	ld	a,_vent_resurs_tx_cnt
2418  00c9 a104          	cp	a,#4
2419  00cb 2502          	jrult	L5541
2422  00cd 3f01          	clr	_vent_resurs_tx_cnt
2423  00cf               L5541:
2424                     ; 209 }
2427  00cf 84            	pop	a
2428  00d0 81            	ret
2481                     ; 212 void gran(signed short *adr, signed short min, signed short max)
2481                     ; 213 {
2482                     	switch	.text
2483  00d1               _gran:
2485  00d1 89            	pushw	x
2486       00000000      OFST:	set	0
2489                     ; 214 if (*adr<min) *adr=min;
2491  00d2 9c            	rvf
2492  00d3 9093          	ldw	y,x
2493  00d5 51            	exgw	x,y
2494  00d6 fe            	ldw	x,(x)
2495  00d7 1305          	cpw	x,(OFST+5,sp)
2496  00d9 51            	exgw	x,y
2497  00da 2e03          	jrsge	L5051
2500  00dc 1605          	ldw	y,(OFST+5,sp)
2501  00de ff            	ldw	(x),y
2502  00df               L5051:
2503                     ; 215 if (*adr>max) *adr=max; 
2505  00df 9c            	rvf
2506  00e0 1e01          	ldw	x,(OFST+1,sp)
2507  00e2 9093          	ldw	y,x
2508  00e4 51            	exgw	x,y
2509  00e5 fe            	ldw	x,(x)
2510  00e6 1307          	cpw	x,(OFST+7,sp)
2511  00e8 51            	exgw	x,y
2512  00e9 2d05          	jrsle	L7051
2515  00eb 1e01          	ldw	x,(OFST+1,sp)
2516  00ed 1607          	ldw	y,(OFST+7,sp)
2517  00ef ff            	ldw	(x),y
2518  00f0               L7051:
2519                     ; 216 } 
2522  00f0 85            	popw	x
2523  00f1 81            	ret
2576                     ; 219 void granee(@eeprom signed short *adr, signed short min, signed short max)
2576                     ; 220 {
2577                     	switch	.text
2578  00f2               _granee:
2580  00f2 89            	pushw	x
2581       00000000      OFST:	set	0
2584                     ; 221 if (*adr<min) *adr=min;
2586  00f3 9c            	rvf
2587  00f4 9093          	ldw	y,x
2588  00f6 51            	exgw	x,y
2589  00f7 fe            	ldw	x,(x)
2590  00f8 1305          	cpw	x,(OFST+5,sp)
2591  00fa 51            	exgw	x,y
2592  00fb 2e09          	jrsge	L7351
2595  00fd 1e05          	ldw	x,(OFST+5,sp)
2596  00ff 89            	pushw	x
2597  0100 1e03          	ldw	x,(OFST+3,sp)
2598  0102 cd0000        	call	c_eewrw
2600  0105 85            	popw	x
2601  0106               L7351:
2602                     ; 222 if (*adr>max) *adr=max; 
2604  0106 9c            	rvf
2605  0107 1e01          	ldw	x,(OFST+1,sp)
2606  0109 9093          	ldw	y,x
2607  010b 51            	exgw	x,y
2608  010c fe            	ldw	x,(x)
2609  010d 1307          	cpw	x,(OFST+7,sp)
2610  010f 51            	exgw	x,y
2611  0110 2d09          	jrsle	L1451
2614  0112 1e07          	ldw	x,(OFST+7,sp)
2615  0114 89            	pushw	x
2616  0115 1e03          	ldw	x,(OFST+3,sp)
2617  0117 cd0000        	call	c_eewrw
2619  011a 85            	popw	x
2620  011b               L1451:
2621                     ; 223 }
2624  011b 85            	popw	x
2625  011c 81            	ret
2686                     ; 226 long delay_ms(short in)
2686                     ; 227 {
2687                     	switch	.text
2688  011d               _delay_ms:
2690  011d 520c          	subw	sp,#12
2691       0000000c      OFST:	set	12
2694                     ; 230 i=((long)in)*100UL;
2696  011f 90ae0064      	ldw	y,#100
2697  0123 cd0000        	call	c_vmul
2699  0126 96            	ldw	x,sp
2700  0127 1c0005        	addw	x,#OFST-7
2701  012a cd0000        	call	c_rtol
2703                     ; 232 for(ii=0;ii<i;ii++)
2705  012d ae0000        	ldw	x,#0
2706  0130 1f0b          	ldw	(OFST-1,sp),x
2707  0132 ae0000        	ldw	x,#0
2708  0135 1f09          	ldw	(OFST-3,sp),x
2710  0137 2012          	jra	L1061
2711  0139               L5751:
2712                     ; 234 		iii++;
2714  0139 96            	ldw	x,sp
2715  013a 1c0001        	addw	x,#OFST-11
2716  013d a601          	ld	a,#1
2717  013f cd0000        	call	c_lgadc
2719                     ; 232 for(ii=0;ii<i;ii++)
2721  0142 96            	ldw	x,sp
2722  0143 1c0009        	addw	x,#OFST-3
2723  0146 a601          	ld	a,#1
2724  0148 cd0000        	call	c_lgadc
2726  014b               L1061:
2729  014b 9c            	rvf
2730  014c 96            	ldw	x,sp
2731  014d 1c0009        	addw	x,#OFST-3
2732  0150 cd0000        	call	c_ltor
2734  0153 96            	ldw	x,sp
2735  0154 1c0005        	addw	x,#OFST-7
2736  0157 cd0000        	call	c_lcmp
2738  015a 2fdd          	jrslt	L5751
2739                     ; 237 }
2742  015c 5b0c          	addw	sp,#12
2743  015e 81            	ret
2779                     ; 240 void led_hndl(void)
2779                     ; 241 {
2780                     	switch	.text
2781  015f               _led_hndl:
2785                     ; 242 if(adress_error)
2787  015f 725d0004      	tnz	_adress_error
2788  0163 2718          	jreq	L5161
2789                     ; 244 	led_red=0x55555555L;
2791  0165 ae5555        	ldw	x,#21845
2792  0168 bf14          	ldw	_led_red+2,x
2793  016a ae5555        	ldw	x,#21845
2794  016d bf12          	ldw	_led_red,x
2795                     ; 245 	led_green=0x55555555L;
2797  016f ae5555        	ldw	x,#21845
2798  0172 bf18          	ldw	_led_green+2,x
2799  0174 ae5555        	ldw	x,#21845
2800  0177 bf16          	ldw	_led_green,x
2802  0179 ace107e1      	jpf	L7161
2803  017d               L5161:
2804                     ; 261 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2806  017d 3d04          	tnz	_bps_class
2807  017f 2703          	jreq	L02
2808  0181 cc0434        	jp	L1261
2809  0184               L02:
2810                     ; 263 	if(jp_mode!=jp3)
2812  0184 b64a          	ld	a,_jp_mode
2813  0186 a103          	cp	a,#3
2814  0188 2603          	jrne	L22
2815  018a cc0330        	jp	L3261
2816  018d               L22:
2817                     ; 265 		if(main_cnt1<(5*ee_TZAS))
2819  018d 9c            	rvf
2820  018e ce0016        	ldw	x,_ee_TZAS
2821  0191 90ae0005      	ldw	y,#5
2822  0195 cd0000        	call	c_imul
2824  0198 b34f          	cpw	x,_main_cnt1
2825  019a 2d18          	jrsle	L5261
2826                     ; 267 			led_red=0x00000000L;
2828  019c ae0000        	ldw	x,#0
2829  019f bf14          	ldw	_led_red+2,x
2830  01a1 ae0000        	ldw	x,#0
2831  01a4 bf12          	ldw	_led_red,x
2832                     ; 268 			led_green=0x03030303L;
2834  01a6 ae0303        	ldw	x,#771
2835  01a9 bf18          	ldw	_led_green+2,x
2836  01ab ae0303        	ldw	x,#771
2837  01ae bf16          	ldw	_led_green,x
2839  01b0 acf102f1      	jpf	L7261
2840  01b4               L5261:
2841                     ; 271 		else if((link==ON)&&(flags_tu&0b10000000))
2843  01b4 b662          	ld	a,_link
2844  01b6 a155          	cp	a,#85
2845  01b8 261e          	jrne	L1361
2847  01ba b660          	ld	a,_flags_tu
2848  01bc a580          	bcp	a,#128
2849  01be 2718          	jreq	L1361
2850                     ; 273 			led_red=0x00055555L;
2852  01c0 ae5555        	ldw	x,#21845
2853  01c3 bf14          	ldw	_led_red+2,x
2854  01c5 ae0005        	ldw	x,#5
2855  01c8 bf12          	ldw	_led_red,x
2856                     ; 274 			led_green=0xffffffffL;
2858  01ca aeffff        	ldw	x,#65535
2859  01cd bf18          	ldw	_led_green+2,x
2860  01cf aeffff        	ldw	x,#-1
2861  01d2 bf16          	ldw	_led_green,x
2863  01d4 acf102f1      	jpf	L7261
2864  01d8               L1361:
2865                     ; 277 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2867  01d8 9c            	rvf
2868  01d9 ce0016        	ldw	x,_ee_TZAS
2869  01dc 90ae0005      	ldw	y,#5
2870  01e0 cd0000        	call	c_imul
2872  01e3 b34f          	cpw	x,_main_cnt1
2873  01e5 2e37          	jrsge	L5361
2875  01e7 9c            	rvf
2876  01e8 ce0016        	ldw	x,_ee_TZAS
2877  01eb 90ae0005      	ldw	y,#5
2878  01ef cd0000        	call	c_imul
2880  01f2 1c0064        	addw	x,#100
2881  01f5 b34f          	cpw	x,_main_cnt1
2882  01f7 2d25          	jrsle	L5361
2884  01f9 ce0006        	ldw	x,_ee_AVT_MODE
2885  01fc a30055        	cpw	x,#85
2886  01ff 271d          	jreq	L5361
2888  0201 ce0004        	ldw	x,_ee_DEVICE
2889  0204 2618          	jrne	L5361
2890                     ; 279 			led_red=0x00000000L;
2892  0206 ae0000        	ldw	x,#0
2893  0209 bf14          	ldw	_led_red+2,x
2894  020b ae0000        	ldw	x,#0
2895  020e bf12          	ldw	_led_red,x
2896                     ; 280 			led_green=0xffffffffL;	
2898  0210 aeffff        	ldw	x,#65535
2899  0213 bf18          	ldw	_led_green+2,x
2900  0215 aeffff        	ldw	x,#-1
2901  0218 bf16          	ldw	_led_green,x
2903  021a acf102f1      	jpf	L7261
2904  021e               L5361:
2905                     ; 283 		else  if(link==OFF)
2907  021e b662          	ld	a,_link
2908  0220 a1aa          	cp	a,#170
2909  0222 2618          	jrne	L1461
2910                     ; 285 			led_red=0x55555555L;
2912  0224 ae5555        	ldw	x,#21845
2913  0227 bf14          	ldw	_led_red+2,x
2914  0229 ae5555        	ldw	x,#21845
2915  022c bf12          	ldw	_led_red,x
2916                     ; 286 			led_green=0xffffffffL;
2918  022e aeffff        	ldw	x,#65535
2919  0231 bf18          	ldw	_led_green+2,x
2920  0233 aeffff        	ldw	x,#-1
2921  0236 bf16          	ldw	_led_green,x
2923  0238 acf102f1      	jpf	L7261
2924  023c               L1461:
2925                     ; 289 		else if((link==ON)&&((flags&0b00111110)==0))
2927  023c b662          	ld	a,_link
2928  023e a155          	cp	a,#85
2929  0240 261d          	jrne	L5461
2931  0242 b60b          	ld	a,_flags
2932  0244 a53e          	bcp	a,#62
2933  0246 2617          	jrne	L5461
2934                     ; 291 			led_red=0x00000000L;
2936  0248 ae0000        	ldw	x,#0
2937  024b bf14          	ldw	_led_red+2,x
2938  024d ae0000        	ldw	x,#0
2939  0250 bf12          	ldw	_led_red,x
2940                     ; 292 			led_green=0xffffffffL;
2942  0252 aeffff        	ldw	x,#65535
2943  0255 bf18          	ldw	_led_green+2,x
2944  0257 aeffff        	ldw	x,#-1
2945  025a bf16          	ldw	_led_green,x
2947  025c cc02f1        	jra	L7261
2948  025f               L5461:
2949                     ; 295 		else if((flags&0b00111110)==0b00000100)
2951  025f b60b          	ld	a,_flags
2952  0261 a43e          	and	a,#62
2953  0263 a104          	cp	a,#4
2954  0265 2616          	jrne	L1561
2955                     ; 297 			led_red=0x00010001L;
2957  0267 ae0001        	ldw	x,#1
2958  026a bf14          	ldw	_led_red+2,x
2959  026c ae0001        	ldw	x,#1
2960  026f bf12          	ldw	_led_red,x
2961                     ; 298 			led_green=0xffffffffL;	
2963  0271 aeffff        	ldw	x,#65535
2964  0274 bf18          	ldw	_led_green+2,x
2965  0276 aeffff        	ldw	x,#-1
2966  0279 bf16          	ldw	_led_green,x
2968  027b 2074          	jra	L7261
2969  027d               L1561:
2970                     ; 300 		else if(flags&0b00000010)
2972  027d b60b          	ld	a,_flags
2973  027f a502          	bcp	a,#2
2974  0281 2716          	jreq	L5561
2975                     ; 302 			led_red=0x00010001L;
2977  0283 ae0001        	ldw	x,#1
2978  0286 bf14          	ldw	_led_red+2,x
2979  0288 ae0001        	ldw	x,#1
2980  028b bf12          	ldw	_led_red,x
2981                     ; 303 			led_green=0x00000000L;	
2983  028d ae0000        	ldw	x,#0
2984  0290 bf18          	ldw	_led_green+2,x
2985  0292 ae0000        	ldw	x,#0
2986  0295 bf16          	ldw	_led_green,x
2988  0297 2058          	jra	L7261
2989  0299               L5561:
2990                     ; 305 		else if(flags&0b00001000)
2992  0299 b60b          	ld	a,_flags
2993  029b a508          	bcp	a,#8
2994  029d 2716          	jreq	L1661
2995                     ; 307 			led_red=0x00090009L;
2997  029f ae0009        	ldw	x,#9
2998  02a2 bf14          	ldw	_led_red+2,x
2999  02a4 ae0009        	ldw	x,#9
3000  02a7 bf12          	ldw	_led_red,x
3001                     ; 308 			led_green=0x00000000L;	
3003  02a9 ae0000        	ldw	x,#0
3004  02ac bf18          	ldw	_led_green+2,x
3005  02ae ae0000        	ldw	x,#0
3006  02b1 bf16          	ldw	_led_green,x
3008  02b3 203c          	jra	L7261
3009  02b5               L1661:
3010                     ; 310 		else if(flags&0b00010000)
3012  02b5 b60b          	ld	a,_flags
3013  02b7 a510          	bcp	a,#16
3014  02b9 2716          	jreq	L5661
3015                     ; 312 			led_red=0x00490049L;
3017  02bb ae0049        	ldw	x,#73
3018  02be bf14          	ldw	_led_red+2,x
3019  02c0 ae0049        	ldw	x,#73
3020  02c3 bf12          	ldw	_led_red,x
3021                     ; 313 			led_green=0x00000000L;	
3023  02c5 ae0000        	ldw	x,#0
3024  02c8 bf18          	ldw	_led_green+2,x
3025  02ca ae0000        	ldw	x,#0
3026  02cd bf16          	ldw	_led_green,x
3028  02cf 2020          	jra	L7261
3029  02d1               L5661:
3030                     ; 316 		else if((link==ON)&&(flags&0b00100000))
3032  02d1 b662          	ld	a,_link
3033  02d3 a155          	cp	a,#85
3034  02d5 261a          	jrne	L7261
3036  02d7 b60b          	ld	a,_flags
3037  02d9 a520          	bcp	a,#32
3038  02db 2714          	jreq	L7261
3039                     ; 318 			led_red=0x00000000L;
3041  02dd ae0000        	ldw	x,#0
3042  02e0 bf14          	ldw	_led_red+2,x
3043  02e2 ae0000        	ldw	x,#0
3044  02e5 bf12          	ldw	_led_red,x
3045                     ; 319 			led_green=0x00030003L;
3047  02e7 ae0003        	ldw	x,#3
3048  02ea bf18          	ldw	_led_green+2,x
3049  02ec ae0003        	ldw	x,#3
3050  02ef bf16          	ldw	_led_green,x
3051  02f1               L7261:
3052                     ; 322 		if((jp_mode==jp1))
3054  02f1 b64a          	ld	a,_jp_mode
3055  02f3 a101          	cp	a,#1
3056  02f5 2618          	jrne	L3761
3057                     ; 324 			led_red=0x00000000L;
3059  02f7 ae0000        	ldw	x,#0
3060  02fa bf14          	ldw	_led_red+2,x
3061  02fc ae0000        	ldw	x,#0
3062  02ff bf12          	ldw	_led_red,x
3063                     ; 325 			led_green=0x33333333L;
3065  0301 ae3333        	ldw	x,#13107
3066  0304 bf18          	ldw	_led_green+2,x
3067  0306 ae3333        	ldw	x,#13107
3068  0309 bf16          	ldw	_led_green,x
3070  030b ace107e1      	jpf	L7161
3071  030f               L3761:
3072                     ; 327 		else if((jp_mode==jp2))
3074  030f b64a          	ld	a,_jp_mode
3075  0311 a102          	cp	a,#2
3076  0313 2703          	jreq	L42
3077  0315 cc07e1        	jp	L7161
3078  0318               L42:
3079                     ; 329 			led_red=0xccccccccL;
3081  0318 aecccc        	ldw	x,#52428
3082  031b bf14          	ldw	_led_red+2,x
3083  031d aecccc        	ldw	x,#-13108
3084  0320 bf12          	ldw	_led_red,x
3085                     ; 330 			led_green=0x00000000L;
3087  0322 ae0000        	ldw	x,#0
3088  0325 bf18          	ldw	_led_green+2,x
3089  0327 ae0000        	ldw	x,#0
3090  032a bf16          	ldw	_led_green,x
3091  032c ace107e1      	jpf	L7161
3092  0330               L3261:
3093                     ; 333 	else if(jp_mode==jp3)
3095  0330 b64a          	ld	a,_jp_mode
3096  0332 a103          	cp	a,#3
3097  0334 2703          	jreq	L62
3098  0336 cc07e1        	jp	L7161
3099  0339               L62:
3100                     ; 335 		if(main_cnt1<(5*ee_TZAS))
3102  0339 9c            	rvf
3103  033a ce0016        	ldw	x,_ee_TZAS
3104  033d 90ae0005      	ldw	y,#5
3105  0341 cd0000        	call	c_imul
3107  0344 b34f          	cpw	x,_main_cnt1
3108  0346 2d18          	jrsle	L5071
3109                     ; 337 			led_red=0x00000000L;
3111  0348 ae0000        	ldw	x,#0
3112  034b bf14          	ldw	_led_red+2,x
3113  034d ae0000        	ldw	x,#0
3114  0350 bf12          	ldw	_led_red,x
3115                     ; 338 			led_green=0x03030303L;
3117  0352 ae0303        	ldw	x,#771
3118  0355 bf18          	ldw	_led_green+2,x
3119  0357 ae0303        	ldw	x,#771
3120  035a bf16          	ldw	_led_green,x
3122  035c ace107e1      	jpf	L7161
3123  0360               L5071:
3124                     ; 340 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3126  0360 9c            	rvf
3127  0361 ce0016        	ldw	x,_ee_TZAS
3128  0364 90ae0005      	ldw	y,#5
3129  0368 cd0000        	call	c_imul
3131  036b b34f          	cpw	x,_main_cnt1
3132  036d 2e2a          	jrsge	L1171
3134  036f 9c            	rvf
3135  0370 ce0016        	ldw	x,_ee_TZAS
3136  0373 90ae0005      	ldw	y,#5
3137  0377 cd0000        	call	c_imul
3139  037a 1c0046        	addw	x,#70
3140  037d b34f          	cpw	x,_main_cnt1
3141  037f 2d18          	jrsle	L1171
3142                     ; 342 			led_red=0x00000000L;
3144  0381 ae0000        	ldw	x,#0
3145  0384 bf14          	ldw	_led_red+2,x
3146  0386 ae0000        	ldw	x,#0
3147  0389 bf12          	ldw	_led_red,x
3148                     ; 343 			led_green=0xffffffffL;	
3150  038b aeffff        	ldw	x,#65535
3151  038e bf18          	ldw	_led_green+2,x
3152  0390 aeffff        	ldw	x,#-1
3153  0393 bf16          	ldw	_led_green,x
3155  0395 ace107e1      	jpf	L7161
3156  0399               L1171:
3157                     ; 346 		else if((flags&0b00011110)==0)
3159  0399 b60b          	ld	a,_flags
3160  039b a51e          	bcp	a,#30
3161  039d 2618          	jrne	L5171
3162                     ; 348 			led_red=0x00000000L;
3164  039f ae0000        	ldw	x,#0
3165  03a2 bf14          	ldw	_led_red+2,x
3166  03a4 ae0000        	ldw	x,#0
3167  03a7 bf12          	ldw	_led_red,x
3168                     ; 349 			led_green=0xffffffffL;
3170  03a9 aeffff        	ldw	x,#65535
3171  03ac bf18          	ldw	_led_green+2,x
3172  03ae aeffff        	ldw	x,#-1
3173  03b1 bf16          	ldw	_led_green,x
3175  03b3 ace107e1      	jpf	L7161
3176  03b7               L5171:
3177                     ; 353 		else if((flags&0b00111110)==0b00000100)
3179  03b7 b60b          	ld	a,_flags
3180  03b9 a43e          	and	a,#62
3181  03bb a104          	cp	a,#4
3182  03bd 2618          	jrne	L1271
3183                     ; 355 			led_red=0x00010001L;
3185  03bf ae0001        	ldw	x,#1
3186  03c2 bf14          	ldw	_led_red+2,x
3187  03c4 ae0001        	ldw	x,#1
3188  03c7 bf12          	ldw	_led_red,x
3189                     ; 356 			led_green=0xffffffffL;	
3191  03c9 aeffff        	ldw	x,#65535
3192  03cc bf18          	ldw	_led_green+2,x
3193  03ce aeffff        	ldw	x,#-1
3194  03d1 bf16          	ldw	_led_green,x
3196  03d3 ace107e1      	jpf	L7161
3197  03d7               L1271:
3198                     ; 358 		else if(flags&0b00000010)
3200  03d7 b60b          	ld	a,_flags
3201  03d9 a502          	bcp	a,#2
3202  03db 2718          	jreq	L5271
3203                     ; 360 			led_red=0x00010001L;
3205  03dd ae0001        	ldw	x,#1
3206  03e0 bf14          	ldw	_led_red+2,x
3207  03e2 ae0001        	ldw	x,#1
3208  03e5 bf12          	ldw	_led_red,x
3209                     ; 361 			led_green=0x00000000L;	
3211  03e7 ae0000        	ldw	x,#0
3212  03ea bf18          	ldw	_led_green+2,x
3213  03ec ae0000        	ldw	x,#0
3214  03ef bf16          	ldw	_led_green,x
3216  03f1 ace107e1      	jpf	L7161
3217  03f5               L5271:
3218                     ; 363 		else if(flags&0b00001000)
3220  03f5 b60b          	ld	a,_flags
3221  03f7 a508          	bcp	a,#8
3222  03f9 2718          	jreq	L1371
3223                     ; 365 			led_red=0x00090009L;
3225  03fb ae0009        	ldw	x,#9
3226  03fe bf14          	ldw	_led_red+2,x
3227  0400 ae0009        	ldw	x,#9
3228  0403 bf12          	ldw	_led_red,x
3229                     ; 366 			led_green=0x00000000L;	
3231  0405 ae0000        	ldw	x,#0
3232  0408 bf18          	ldw	_led_green+2,x
3233  040a ae0000        	ldw	x,#0
3234  040d bf16          	ldw	_led_green,x
3236  040f ace107e1      	jpf	L7161
3237  0413               L1371:
3238                     ; 368 		else if(flags&0b00010000)
3240  0413 b60b          	ld	a,_flags
3241  0415 a510          	bcp	a,#16
3242  0417 2603          	jrne	L03
3243  0419 cc07e1        	jp	L7161
3244  041c               L03:
3245                     ; 370 			led_red=0x00490049L;
3247  041c ae0049        	ldw	x,#73
3248  041f bf14          	ldw	_led_red+2,x
3249  0421 ae0049        	ldw	x,#73
3250  0424 bf12          	ldw	_led_red,x
3251                     ; 371 			led_green=0xffffffffL;	
3253  0426 aeffff        	ldw	x,#65535
3254  0429 bf18          	ldw	_led_green+2,x
3255  042b aeffff        	ldw	x,#-1
3256  042e bf16          	ldw	_led_green,x
3257  0430 ace107e1      	jpf	L7161
3258  0434               L1261:
3259                     ; 375 else if(bps_class==bpsIPS)	//если блок ИПСный
3261  0434 b604          	ld	a,_bps_class
3262  0436 a101          	cp	a,#1
3263  0438 2703          	jreq	L23
3264  043a cc07e1        	jp	L7161
3265  043d               L23:
3266                     ; 377 	if(jp_mode!=jp3)
3268  043d b64a          	ld	a,_jp_mode
3269  043f a103          	cp	a,#3
3270  0441 2603          	jrne	L43
3271  0443 cc06ed        	jp	L3471
3272  0446               L43:
3273                     ; 379 		if(main_cnt1<(5*ee_TZAS))
3275  0446 9c            	rvf
3276  0447 ce0016        	ldw	x,_ee_TZAS
3277  044a 90ae0005      	ldw	y,#5
3278  044e cd0000        	call	c_imul
3280  0451 b34f          	cpw	x,_main_cnt1
3281  0453 2d18          	jrsle	L5471
3282                     ; 381 			led_red=0x00000000L;
3284  0455 ae0000        	ldw	x,#0
3285  0458 bf14          	ldw	_led_red+2,x
3286  045a ae0000        	ldw	x,#0
3287  045d bf12          	ldw	_led_red,x
3288                     ; 382 			led_green=0x03030303L;
3290  045f ae0303        	ldw	x,#771
3291  0462 bf18          	ldw	_led_green+2,x
3292  0464 ae0303        	ldw	x,#771
3293  0467 bf16          	ldw	_led_green,x
3295  0469 acae06ae      	jpf	L7471
3296  046d               L5471:
3297                     ; 385 		else if((link==ON)&&(flags_tu&0b10000000))
3299  046d b662          	ld	a,_link
3300  046f a155          	cp	a,#85
3301  0471 261e          	jrne	L1571
3303  0473 b660          	ld	a,_flags_tu
3304  0475 a580          	bcp	a,#128
3305  0477 2718          	jreq	L1571
3306                     ; 387 			led_red=0x00055555L;
3308  0479 ae5555        	ldw	x,#21845
3309  047c bf14          	ldw	_led_red+2,x
3310  047e ae0005        	ldw	x,#5
3311  0481 bf12          	ldw	_led_red,x
3312                     ; 388 			led_green=0xffffffffL;
3314  0483 aeffff        	ldw	x,#65535
3315  0486 bf18          	ldw	_led_green+2,x
3316  0488 aeffff        	ldw	x,#-1
3317  048b bf16          	ldw	_led_green,x
3319  048d acae06ae      	jpf	L7471
3320  0491               L1571:
3321                     ; 391 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3323  0491 9c            	rvf
3324  0492 ce0016        	ldw	x,_ee_TZAS
3325  0495 90ae0005      	ldw	y,#5
3326  0499 cd0000        	call	c_imul
3328  049c b34f          	cpw	x,_main_cnt1
3329  049e 2e37          	jrsge	L5571
3331  04a0 9c            	rvf
3332  04a1 ce0016        	ldw	x,_ee_TZAS
3333  04a4 90ae0005      	ldw	y,#5
3334  04a8 cd0000        	call	c_imul
3336  04ab 1c0064        	addw	x,#100
3337  04ae b34f          	cpw	x,_main_cnt1
3338  04b0 2d25          	jrsle	L5571
3340  04b2 ce0006        	ldw	x,_ee_AVT_MODE
3341  04b5 a30055        	cpw	x,#85
3342  04b8 271d          	jreq	L5571
3344  04ba ce0004        	ldw	x,_ee_DEVICE
3345  04bd 2618          	jrne	L5571
3346                     ; 393 			led_red=0x00000000L;
3348  04bf ae0000        	ldw	x,#0
3349  04c2 bf14          	ldw	_led_red+2,x
3350  04c4 ae0000        	ldw	x,#0
3351  04c7 bf12          	ldw	_led_red,x
3352                     ; 394 			led_green=0xffffffffL;	
3354  04c9 aeffff        	ldw	x,#65535
3355  04cc bf18          	ldw	_led_green+2,x
3356  04ce aeffff        	ldw	x,#-1
3357  04d1 bf16          	ldw	_led_green,x
3359  04d3 acae06ae      	jpf	L7471
3360  04d7               L5571:
3361                     ; 397 		else  if(link==OFF)
3363  04d7 b662          	ld	a,_link
3364  04d9 a1aa          	cp	a,#170
3365  04db 2703          	jreq	L63
3366  04dd cc05f9        	jp	L1671
3367  04e0               L63:
3368                     ; 399 			if((flags&0b00011110)==0)
3370  04e0 b60b          	ld	a,_flags
3371  04e2 a51e          	bcp	a,#30
3372  04e4 262d          	jrne	L3671
3373                     ; 401 				led_red=0x00000000L;
3375  04e6 ae0000        	ldw	x,#0
3376  04e9 bf14          	ldw	_led_red+2,x
3377  04eb ae0000        	ldw	x,#0
3378  04ee bf12          	ldw	_led_red,x
3379                     ; 402 				if(bMAIN)led_green=0xfffffff5L;
3381                     	btst	_bMAIN
3382  04f5 240e          	jruge	L5671
3385  04f7 aefff5        	ldw	x,#65525
3386  04fa bf18          	ldw	_led_green+2,x
3387  04fc aeffff        	ldw	x,#-1
3388  04ff bf16          	ldw	_led_green,x
3390  0501 acae06ae      	jpf	L7471
3391  0505               L5671:
3392                     ; 403 				else led_green=0xffffffffL;
3394  0505 aeffff        	ldw	x,#65535
3395  0508 bf18          	ldw	_led_green+2,x
3396  050a aeffff        	ldw	x,#-1
3397  050d bf16          	ldw	_led_green,x
3398  050f acae06ae      	jpf	L7471
3399  0513               L3671:
3400                     ; 406 			else if((flags&0b00111110)==0b00000100)
3402  0513 b60b          	ld	a,_flags
3403  0515 a43e          	and	a,#62
3404  0517 a104          	cp	a,#4
3405  0519 262d          	jrne	L3771
3406                     ; 408 				led_red=0x00010001L;
3408  051b ae0001        	ldw	x,#1
3409  051e bf14          	ldw	_led_red+2,x
3410  0520 ae0001        	ldw	x,#1
3411  0523 bf12          	ldw	_led_red,x
3412                     ; 409 				if(bMAIN)led_green=0xfffffff5L;
3414                     	btst	_bMAIN
3415  052a 240e          	jruge	L5771
3418  052c aefff5        	ldw	x,#65525
3419  052f bf18          	ldw	_led_green+2,x
3420  0531 aeffff        	ldw	x,#-1
3421  0534 bf16          	ldw	_led_green,x
3423  0536 acae06ae      	jpf	L7471
3424  053a               L5771:
3425                     ; 410 				else led_green=0xffffffffL;	
3427  053a aeffff        	ldw	x,#65535
3428  053d bf18          	ldw	_led_green+2,x
3429  053f aeffff        	ldw	x,#-1
3430  0542 bf16          	ldw	_led_green,x
3431  0544 acae06ae      	jpf	L7471
3432  0548               L3771:
3433                     ; 412 			else if(flags&0b00000010)
3435  0548 b60b          	ld	a,_flags
3436  054a a502          	bcp	a,#2
3437  054c 272d          	jreq	L3002
3438                     ; 414 				led_red=0x00010001L;
3440  054e ae0001        	ldw	x,#1
3441  0551 bf14          	ldw	_led_red+2,x
3442  0553 ae0001        	ldw	x,#1
3443  0556 bf12          	ldw	_led_red,x
3444                     ; 415 				if(bMAIN)led_green=0x00000005L;
3446                     	btst	_bMAIN
3447  055d 240e          	jruge	L5002
3450  055f ae0005        	ldw	x,#5
3451  0562 bf18          	ldw	_led_green+2,x
3452  0564 ae0000        	ldw	x,#0
3453  0567 bf16          	ldw	_led_green,x
3455  0569 acae06ae      	jpf	L7471
3456  056d               L5002:
3457                     ; 416 				else led_green=0x00000000L;
3459  056d ae0000        	ldw	x,#0
3460  0570 bf18          	ldw	_led_green+2,x
3461  0572 ae0000        	ldw	x,#0
3462  0575 bf16          	ldw	_led_green,x
3463  0577 acae06ae      	jpf	L7471
3464  057b               L3002:
3465                     ; 418 			else if(flags&0b00001000)
3467  057b b60b          	ld	a,_flags
3468  057d a508          	bcp	a,#8
3469  057f 272d          	jreq	L3102
3470                     ; 420 				led_red=0x00090009L;
3472  0581 ae0009        	ldw	x,#9
3473  0584 bf14          	ldw	_led_red+2,x
3474  0586 ae0009        	ldw	x,#9
3475  0589 bf12          	ldw	_led_red,x
3476                     ; 421 				if(bMAIN)led_green=0x00000005L;
3478                     	btst	_bMAIN
3479  0590 240e          	jruge	L5102
3482  0592 ae0005        	ldw	x,#5
3483  0595 bf18          	ldw	_led_green+2,x
3484  0597 ae0000        	ldw	x,#0
3485  059a bf16          	ldw	_led_green,x
3487  059c acae06ae      	jpf	L7471
3488  05a0               L5102:
3489                     ; 422 				else led_green=0x00000000L;	
3491  05a0 ae0000        	ldw	x,#0
3492  05a3 bf18          	ldw	_led_green+2,x
3493  05a5 ae0000        	ldw	x,#0
3494  05a8 bf16          	ldw	_led_green,x
3495  05aa acae06ae      	jpf	L7471
3496  05ae               L3102:
3497                     ; 424 			else if(flags&0b00010000)
3499  05ae b60b          	ld	a,_flags
3500  05b0 a510          	bcp	a,#16
3501  05b2 272d          	jreq	L3202
3502                     ; 426 				led_red=0x00490049L;
3504  05b4 ae0049        	ldw	x,#73
3505  05b7 bf14          	ldw	_led_red+2,x
3506  05b9 ae0049        	ldw	x,#73
3507  05bc bf12          	ldw	_led_red,x
3508                     ; 427 				if(bMAIN)led_green=0x00000005L;
3510                     	btst	_bMAIN
3511  05c3 240e          	jruge	L5202
3514  05c5 ae0005        	ldw	x,#5
3515  05c8 bf18          	ldw	_led_green+2,x
3516  05ca ae0000        	ldw	x,#0
3517  05cd bf16          	ldw	_led_green,x
3519  05cf acae06ae      	jpf	L7471
3520  05d3               L5202:
3521                     ; 428 				else led_green=0x00000000L;	
3523  05d3 ae0000        	ldw	x,#0
3524  05d6 bf18          	ldw	_led_green+2,x
3525  05d8 ae0000        	ldw	x,#0
3526  05db bf16          	ldw	_led_green,x
3527  05dd acae06ae      	jpf	L7471
3528  05e1               L3202:
3529                     ; 432 				led_red=0x55555555L;
3531  05e1 ae5555        	ldw	x,#21845
3532  05e4 bf14          	ldw	_led_red+2,x
3533  05e6 ae5555        	ldw	x,#21845
3534  05e9 bf12          	ldw	_led_red,x
3535                     ; 433 				led_green=0xffffffffL;
3537  05eb aeffff        	ldw	x,#65535
3538  05ee bf18          	ldw	_led_green+2,x
3539  05f0 aeffff        	ldw	x,#-1
3540  05f3 bf16          	ldw	_led_green,x
3541  05f5 acae06ae      	jpf	L7471
3542  05f9               L1671:
3543                     ; 449 		else if((link==ON)&&((flags&0b00111110)==0))
3545  05f9 b662          	ld	a,_link
3546  05fb a155          	cp	a,#85
3547  05fd 261d          	jrne	L5302
3549  05ff b60b          	ld	a,_flags
3550  0601 a53e          	bcp	a,#62
3551  0603 2617          	jrne	L5302
3552                     ; 451 			led_red=0x00000000L;
3554  0605 ae0000        	ldw	x,#0
3555  0608 bf14          	ldw	_led_red+2,x
3556  060a ae0000        	ldw	x,#0
3557  060d bf12          	ldw	_led_red,x
3558                     ; 452 			led_green=0xffffffffL;
3560  060f aeffff        	ldw	x,#65535
3561  0612 bf18          	ldw	_led_green+2,x
3562  0614 aeffff        	ldw	x,#-1
3563  0617 bf16          	ldw	_led_green,x
3565  0619 cc06ae        	jra	L7471
3566  061c               L5302:
3567                     ; 455 		else if((flags&0b00111110)==0b00000100)
3569  061c b60b          	ld	a,_flags
3570  061e a43e          	and	a,#62
3571  0620 a104          	cp	a,#4
3572  0622 2616          	jrne	L1402
3573                     ; 457 			led_red=0x00010001L;
3575  0624 ae0001        	ldw	x,#1
3576  0627 bf14          	ldw	_led_red+2,x
3577  0629 ae0001        	ldw	x,#1
3578  062c bf12          	ldw	_led_red,x
3579                     ; 458 			led_green=0xffffffffL;	
3581  062e aeffff        	ldw	x,#65535
3582  0631 bf18          	ldw	_led_green+2,x
3583  0633 aeffff        	ldw	x,#-1
3584  0636 bf16          	ldw	_led_green,x
3586  0638 2074          	jra	L7471
3587  063a               L1402:
3588                     ; 460 		else if(flags&0b00000010)
3590  063a b60b          	ld	a,_flags
3591  063c a502          	bcp	a,#2
3592  063e 2716          	jreq	L5402
3593                     ; 462 			led_red=0x00010001L;
3595  0640 ae0001        	ldw	x,#1
3596  0643 bf14          	ldw	_led_red+2,x
3597  0645 ae0001        	ldw	x,#1
3598  0648 bf12          	ldw	_led_red,x
3599                     ; 463 			led_green=0x00000000L;	
3601  064a ae0000        	ldw	x,#0
3602  064d bf18          	ldw	_led_green+2,x
3603  064f ae0000        	ldw	x,#0
3604  0652 bf16          	ldw	_led_green,x
3606  0654 2058          	jra	L7471
3607  0656               L5402:
3608                     ; 465 		else if(flags&0b00001000)
3610  0656 b60b          	ld	a,_flags
3611  0658 a508          	bcp	a,#8
3612  065a 2716          	jreq	L1502
3613                     ; 467 			led_red=0x00090009L;
3615  065c ae0009        	ldw	x,#9
3616  065f bf14          	ldw	_led_red+2,x
3617  0661 ae0009        	ldw	x,#9
3618  0664 bf12          	ldw	_led_red,x
3619                     ; 468 			led_green=0x00000000L;	
3621  0666 ae0000        	ldw	x,#0
3622  0669 bf18          	ldw	_led_green+2,x
3623  066b ae0000        	ldw	x,#0
3624  066e bf16          	ldw	_led_green,x
3626  0670 203c          	jra	L7471
3627  0672               L1502:
3628                     ; 470 		else if(flags&0b00010000)
3630  0672 b60b          	ld	a,_flags
3631  0674 a510          	bcp	a,#16
3632  0676 2716          	jreq	L5502
3633                     ; 472 			led_red=0x00490049L;
3635  0678 ae0049        	ldw	x,#73
3636  067b bf14          	ldw	_led_red+2,x
3637  067d ae0049        	ldw	x,#73
3638  0680 bf12          	ldw	_led_red,x
3639                     ; 473 			led_green=0x00000000L;	
3641  0682 ae0000        	ldw	x,#0
3642  0685 bf18          	ldw	_led_green+2,x
3643  0687 ae0000        	ldw	x,#0
3644  068a bf16          	ldw	_led_green,x
3646  068c 2020          	jra	L7471
3647  068e               L5502:
3648                     ; 476 		else if((link==ON)&&(flags&0b00100000))
3650  068e b662          	ld	a,_link
3651  0690 a155          	cp	a,#85
3652  0692 261a          	jrne	L7471
3654  0694 b60b          	ld	a,_flags
3655  0696 a520          	bcp	a,#32
3656  0698 2714          	jreq	L7471
3657                     ; 478 			led_red=0x00000000L;
3659  069a ae0000        	ldw	x,#0
3660  069d bf14          	ldw	_led_red+2,x
3661  069f ae0000        	ldw	x,#0
3662  06a2 bf12          	ldw	_led_red,x
3663                     ; 479 			led_green=0x00030003L;
3665  06a4 ae0003        	ldw	x,#3
3666  06a7 bf18          	ldw	_led_green+2,x
3667  06a9 ae0003        	ldw	x,#3
3668  06ac bf16          	ldw	_led_green,x
3669  06ae               L7471:
3670                     ; 482 		if((jp_mode==jp1))
3672  06ae b64a          	ld	a,_jp_mode
3673  06b0 a101          	cp	a,#1
3674  06b2 2618          	jrne	L3602
3675                     ; 484 			led_red=0x00000000L;
3677  06b4 ae0000        	ldw	x,#0
3678  06b7 bf14          	ldw	_led_red+2,x
3679  06b9 ae0000        	ldw	x,#0
3680  06bc bf12          	ldw	_led_red,x
3681                     ; 485 			led_green=0x33333333L;
3683  06be ae3333        	ldw	x,#13107
3684  06c1 bf18          	ldw	_led_green+2,x
3685  06c3 ae3333        	ldw	x,#13107
3686  06c6 bf16          	ldw	_led_green,x
3688  06c8 ace107e1      	jpf	L7161
3689  06cc               L3602:
3690                     ; 487 		else if((jp_mode==jp2))
3692  06cc b64a          	ld	a,_jp_mode
3693  06ce a102          	cp	a,#2
3694  06d0 2703          	jreq	L04
3695  06d2 cc07e1        	jp	L7161
3696  06d5               L04:
3697                     ; 491 			led_red=0xccccccccL;
3699  06d5 aecccc        	ldw	x,#52428
3700  06d8 bf14          	ldw	_led_red+2,x
3701  06da aecccc        	ldw	x,#-13108
3702  06dd bf12          	ldw	_led_red,x
3703                     ; 492 			led_green=0x00000000L;
3705  06df ae0000        	ldw	x,#0
3706  06e2 bf18          	ldw	_led_green+2,x
3707  06e4 ae0000        	ldw	x,#0
3708  06e7 bf16          	ldw	_led_green,x
3709  06e9 ace107e1      	jpf	L7161
3710  06ed               L3471:
3711                     ; 495 	else if(jp_mode==jp3)
3713  06ed b64a          	ld	a,_jp_mode
3714  06ef a103          	cp	a,#3
3715  06f1 2703          	jreq	L24
3716  06f3 cc07e1        	jp	L7161
3717  06f6               L24:
3718                     ; 497 		if(main_cnt1<(5*ee_TZAS))
3720  06f6 9c            	rvf
3721  06f7 ce0016        	ldw	x,_ee_TZAS
3722  06fa 90ae0005      	ldw	y,#5
3723  06fe cd0000        	call	c_imul
3725  0701 b34f          	cpw	x,_main_cnt1
3726  0703 2d18          	jrsle	L5702
3727                     ; 499 			led_red=0x00000000L;
3729  0705 ae0000        	ldw	x,#0
3730  0708 bf14          	ldw	_led_red+2,x
3731  070a ae0000        	ldw	x,#0
3732  070d bf12          	ldw	_led_red,x
3733                     ; 500 			led_green=0x03030303L;
3735  070f ae0303        	ldw	x,#771
3736  0712 bf18          	ldw	_led_green+2,x
3737  0714 ae0303        	ldw	x,#771
3738  0717 bf16          	ldw	_led_green,x
3740  0719 ace107e1      	jpf	L7161
3741  071d               L5702:
3742                     ; 502 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3744  071d 9c            	rvf
3745  071e ce0016        	ldw	x,_ee_TZAS
3746  0721 90ae0005      	ldw	y,#5
3747  0725 cd0000        	call	c_imul
3749  0728 b34f          	cpw	x,_main_cnt1
3750  072a 2e29          	jrsge	L1012
3752  072c 9c            	rvf
3753  072d ce0016        	ldw	x,_ee_TZAS
3754  0730 90ae0005      	ldw	y,#5
3755  0734 cd0000        	call	c_imul
3757  0737 1c0046        	addw	x,#70
3758  073a b34f          	cpw	x,_main_cnt1
3759  073c 2d17          	jrsle	L1012
3760                     ; 504 			led_red=0x00000000L;
3762  073e ae0000        	ldw	x,#0
3763  0741 bf14          	ldw	_led_red+2,x
3764  0743 ae0000        	ldw	x,#0
3765  0746 bf12          	ldw	_led_red,x
3766                     ; 505 			led_green=0xffffffffL;	
3768  0748 aeffff        	ldw	x,#65535
3769  074b bf18          	ldw	_led_green+2,x
3770  074d aeffff        	ldw	x,#-1
3771  0750 bf16          	ldw	_led_green,x
3773  0752 cc07e1        	jra	L7161
3774  0755               L1012:
3775                     ; 508 		else if((flags&0b00011110)==0)
3777  0755 b60b          	ld	a,_flags
3778  0757 a51e          	bcp	a,#30
3779  0759 2616          	jrne	L5012
3780                     ; 510 			led_red=0x00000000L;
3782  075b ae0000        	ldw	x,#0
3783  075e bf14          	ldw	_led_red+2,x
3784  0760 ae0000        	ldw	x,#0
3785  0763 bf12          	ldw	_led_red,x
3786                     ; 511 			led_green=0xffffffffL;
3788  0765 aeffff        	ldw	x,#65535
3789  0768 bf18          	ldw	_led_green+2,x
3790  076a aeffff        	ldw	x,#-1
3791  076d bf16          	ldw	_led_green,x
3793  076f 2070          	jra	L7161
3794  0771               L5012:
3795                     ; 515 		else if((flags&0b00111110)==0b00000100)
3797  0771 b60b          	ld	a,_flags
3798  0773 a43e          	and	a,#62
3799  0775 a104          	cp	a,#4
3800  0777 2616          	jrne	L1112
3801                     ; 517 			led_red=0x00010001L;
3803  0779 ae0001        	ldw	x,#1
3804  077c bf14          	ldw	_led_red+2,x
3805  077e ae0001        	ldw	x,#1
3806  0781 bf12          	ldw	_led_red,x
3807                     ; 518 			led_green=0xffffffffL;	
3809  0783 aeffff        	ldw	x,#65535
3810  0786 bf18          	ldw	_led_green+2,x
3811  0788 aeffff        	ldw	x,#-1
3812  078b bf16          	ldw	_led_green,x
3814  078d 2052          	jra	L7161
3815  078f               L1112:
3816                     ; 520 		else if(flags&0b00000010)
3818  078f b60b          	ld	a,_flags
3819  0791 a502          	bcp	a,#2
3820  0793 2716          	jreq	L5112
3821                     ; 522 			led_red=0x00010001L;
3823  0795 ae0001        	ldw	x,#1
3824  0798 bf14          	ldw	_led_red+2,x
3825  079a ae0001        	ldw	x,#1
3826  079d bf12          	ldw	_led_red,x
3827                     ; 523 			led_green=0x00000000L;	
3829  079f ae0000        	ldw	x,#0
3830  07a2 bf18          	ldw	_led_green+2,x
3831  07a4 ae0000        	ldw	x,#0
3832  07a7 bf16          	ldw	_led_green,x
3834  07a9 2036          	jra	L7161
3835  07ab               L5112:
3836                     ; 525 		else if(flags&0b00001000)
3838  07ab b60b          	ld	a,_flags
3839  07ad a508          	bcp	a,#8
3840  07af 2716          	jreq	L1212
3841                     ; 527 			led_red=0x00090009L;
3843  07b1 ae0009        	ldw	x,#9
3844  07b4 bf14          	ldw	_led_red+2,x
3845  07b6 ae0009        	ldw	x,#9
3846  07b9 bf12          	ldw	_led_red,x
3847                     ; 528 			led_green=0x00000000L;	
3849  07bb ae0000        	ldw	x,#0
3850  07be bf18          	ldw	_led_green+2,x
3851  07c0 ae0000        	ldw	x,#0
3852  07c3 bf16          	ldw	_led_green,x
3854  07c5 201a          	jra	L7161
3855  07c7               L1212:
3856                     ; 530 		else if(flags&0b00010000)
3858  07c7 b60b          	ld	a,_flags
3859  07c9 a510          	bcp	a,#16
3860  07cb 2714          	jreq	L7161
3861                     ; 532 			led_red=0x00490049L;
3863  07cd ae0049        	ldw	x,#73
3864  07d0 bf14          	ldw	_led_red+2,x
3865  07d2 ae0049        	ldw	x,#73
3866  07d5 bf12          	ldw	_led_red,x
3867                     ; 533 			led_green=0xffffffffL;	
3869  07d7 aeffff        	ldw	x,#65535
3870  07da bf18          	ldw	_led_green+2,x
3871  07dc aeffff        	ldw	x,#-1
3872  07df bf16          	ldw	_led_green,x
3873  07e1               L7161:
3874                     ; 537 }
3877  07e1 81            	ret
3905                     ; 540 void led_drv(void)
3905                     ; 541 {
3906                     	switch	.text
3907  07e2               _led_drv:
3911                     ; 543 GPIOA->DDR|=(1<<4);
3913  07e2 72185002      	bset	20482,#4
3914                     ; 544 GPIOA->CR1|=(1<<4);
3916  07e6 72185003      	bset	20483,#4
3917                     ; 545 GPIOA->CR2&=~(1<<4);
3919  07ea 72195004      	bres	20484,#4
3920                     ; 546 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3922  07ee b640          	ld	a,_led_red_buff+3
3923  07f0 a501          	bcp	a,#1
3924  07f2 2706          	jreq	L7312
3927  07f4 72185000      	bset	20480,#4
3929  07f8 2004          	jra	L1412
3930  07fa               L7312:
3931                     ; 547 else GPIOA->ODR&=~(1<<4); 
3933  07fa 72195000      	bres	20480,#4
3934  07fe               L1412:
3935                     ; 550 GPIOA->DDR|=(1<<5);
3937  07fe 721a5002      	bset	20482,#5
3938                     ; 551 GPIOA->CR1|=(1<<5);
3940  0802 721a5003      	bset	20483,#5
3941                     ; 552 GPIOA->CR2&=~(1<<5);	
3943  0806 721b5004      	bres	20484,#5
3944                     ; 553 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3946  080a b63c          	ld	a,_led_green_buff+3
3947  080c a501          	bcp	a,#1
3948  080e 2706          	jreq	L3412
3951  0810 721a5000      	bset	20480,#5
3953  0814 2004          	jra	L5412
3954  0816               L3412:
3955                     ; 554 else GPIOA->ODR&=~(1<<5);
3957  0816 721b5000      	bres	20480,#5
3958  081a               L5412:
3959                     ; 557 led_red_buff>>=1;
3961  081a 373d          	sra	_led_red_buff
3962  081c 363e          	rrc	_led_red_buff+1
3963  081e 363f          	rrc	_led_red_buff+2
3964  0820 3640          	rrc	_led_red_buff+3
3965                     ; 558 led_green_buff>>=1;
3967  0822 3739          	sra	_led_green_buff
3968  0824 363a          	rrc	_led_green_buff+1
3969  0826 363b          	rrc	_led_green_buff+2
3970  0828 363c          	rrc	_led_green_buff+3
3971                     ; 559 if(++led_drv_cnt>32)
3973  082a 3c1a          	inc	_led_drv_cnt
3974  082c b61a          	ld	a,_led_drv_cnt
3975  082e a121          	cp	a,#33
3976  0830 2512          	jrult	L7412
3977                     ; 561 	led_drv_cnt=0;
3979  0832 3f1a          	clr	_led_drv_cnt
3980                     ; 562 	led_red_buff=led_red;
3982  0834 be14          	ldw	x,_led_red+2
3983  0836 bf3f          	ldw	_led_red_buff+2,x
3984  0838 be12          	ldw	x,_led_red
3985  083a bf3d          	ldw	_led_red_buff,x
3986                     ; 563 	led_green_buff=led_green;
3988  083c be18          	ldw	x,_led_green+2
3989  083e bf3b          	ldw	_led_green_buff+2,x
3990  0840 be16          	ldw	x,_led_green
3991  0842 bf39          	ldw	_led_green_buff,x
3992  0844               L7412:
3993                     ; 569 } 
3996  0844 81            	ret
4022                     ; 572 void JP_drv(void)
4022                     ; 573 {
4023                     	switch	.text
4024  0845               _JP_drv:
4028                     ; 575 GPIOD->DDR&=~(1<<6);
4030  0845 721d5011      	bres	20497,#6
4031                     ; 576 GPIOD->CR1|=(1<<6);
4033  0849 721c5012      	bset	20498,#6
4034                     ; 577 GPIOD->CR2&=~(1<<6);
4036  084d 721d5013      	bres	20499,#6
4037                     ; 579 GPIOD->DDR&=~(1<<7);
4039  0851 721f5011      	bres	20497,#7
4040                     ; 580 GPIOD->CR1|=(1<<7);
4042  0855 721e5012      	bset	20498,#7
4043                     ; 581 GPIOD->CR2&=~(1<<7);
4045  0859 721f5013      	bres	20499,#7
4046                     ; 583 if(GPIOD->IDR&(1<<6))
4048  085d c65010        	ld	a,20496
4049  0860 a540          	bcp	a,#64
4050  0862 270a          	jreq	L1612
4051                     ; 585 	if(cnt_JP0<10)
4053  0864 b649          	ld	a,_cnt_JP0
4054  0866 a10a          	cp	a,#10
4055  0868 2411          	jruge	L5612
4056                     ; 587 		cnt_JP0++;
4058  086a 3c49          	inc	_cnt_JP0
4059  086c 200d          	jra	L5612
4060  086e               L1612:
4061                     ; 590 else if(!(GPIOD->IDR&(1<<6)))
4063  086e c65010        	ld	a,20496
4064  0871 a540          	bcp	a,#64
4065  0873 2606          	jrne	L5612
4066                     ; 592 	if(cnt_JP0)
4068  0875 3d49          	tnz	_cnt_JP0
4069  0877 2702          	jreq	L5612
4070                     ; 594 		cnt_JP0--;
4072  0879 3a49          	dec	_cnt_JP0
4073  087b               L5612:
4074                     ; 598 if(GPIOD->IDR&(1<<7))
4076  087b c65010        	ld	a,20496
4077  087e a580          	bcp	a,#128
4078  0880 270a          	jreq	L3712
4079                     ; 600 	if(cnt_JP1<10)
4081  0882 b648          	ld	a,_cnt_JP1
4082  0884 a10a          	cp	a,#10
4083  0886 2411          	jruge	L7712
4084                     ; 602 		cnt_JP1++;
4086  0888 3c48          	inc	_cnt_JP1
4087  088a 200d          	jra	L7712
4088  088c               L3712:
4089                     ; 605 else if(!(GPIOD->IDR&(1<<7)))
4091  088c c65010        	ld	a,20496
4092  088f a580          	bcp	a,#128
4093  0891 2606          	jrne	L7712
4094                     ; 607 	if(cnt_JP1)
4096  0893 3d48          	tnz	_cnt_JP1
4097  0895 2702          	jreq	L7712
4098                     ; 609 		cnt_JP1--;
4100  0897 3a48          	dec	_cnt_JP1
4101  0899               L7712:
4102                     ; 614 if((cnt_JP0==10)&&(cnt_JP1==10))
4104  0899 b649          	ld	a,_cnt_JP0
4105  089b a10a          	cp	a,#10
4106  089d 2608          	jrne	L5022
4108  089f b648          	ld	a,_cnt_JP1
4109  08a1 a10a          	cp	a,#10
4110  08a3 2602          	jrne	L5022
4111                     ; 616 	jp_mode=jp0;
4113  08a5 3f4a          	clr	_jp_mode
4114  08a7               L5022:
4115                     ; 618 if((cnt_JP0==0)&&(cnt_JP1==10))
4117  08a7 3d49          	tnz	_cnt_JP0
4118  08a9 260a          	jrne	L7022
4120  08ab b648          	ld	a,_cnt_JP1
4121  08ad a10a          	cp	a,#10
4122  08af 2604          	jrne	L7022
4123                     ; 620 	jp_mode=jp1;
4125  08b1 3501004a      	mov	_jp_mode,#1
4126  08b5               L7022:
4127                     ; 622 if((cnt_JP0==10)&&(cnt_JP1==0))
4129  08b5 b649          	ld	a,_cnt_JP0
4130  08b7 a10a          	cp	a,#10
4131  08b9 2608          	jrne	L1122
4133  08bb 3d48          	tnz	_cnt_JP1
4134  08bd 2604          	jrne	L1122
4135                     ; 624 	jp_mode=jp2;
4137  08bf 3502004a      	mov	_jp_mode,#2
4138  08c3               L1122:
4139                     ; 626 if((cnt_JP0==0)&&(cnt_JP1==0))
4141  08c3 3d49          	tnz	_cnt_JP0
4142  08c5 2608          	jrne	L3122
4144  08c7 3d48          	tnz	_cnt_JP1
4145  08c9 2604          	jrne	L3122
4146                     ; 628 	jp_mode=jp3;
4148  08cb 3503004a      	mov	_jp_mode,#3
4149  08cf               L3122:
4150                     ; 631 }
4153  08cf 81            	ret
4185                     ; 634 void link_drv(void)		//10Hz
4185                     ; 635 {
4186                     	switch	.text
4187  08d0               _link_drv:
4191                     ; 636 if(jp_mode!=jp3)
4193  08d0 b64a          	ld	a,_jp_mode
4194  08d2 a103          	cp	a,#3
4195  08d4 2744          	jreq	L5222
4196                     ; 638 	if(link_cnt<52)link_cnt++;
4198  08d6 b661          	ld	a,_link_cnt
4199  08d8 a134          	cp	a,#52
4200  08da 2402          	jruge	L7222
4203  08dc 3c61          	inc	_link_cnt
4204  08de               L7222:
4205                     ; 639 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4207  08de b661          	ld	a,_link_cnt
4208  08e0 a131          	cp	a,#49
4209  08e2 2606          	jrne	L1322
4212  08e4 b60b          	ld	a,_flags
4213  08e6 a4c1          	and	a,#193
4214  08e8 b70b          	ld	_flags,a
4215  08ea               L1322:
4216                     ; 640 	if(link_cnt==50)
4218  08ea b661          	ld	a,_link_cnt
4219  08ec a132          	cp	a,#50
4220  08ee 262e          	jrne	L3422
4221                     ; 642 		link=OFF;
4223  08f0 35aa0062      	mov	_link,#170
4224                     ; 647 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4226  08f4 b604          	ld	a,_bps_class
4227  08f6 a101          	cp	a,#1
4228  08f8 2606          	jrne	L5322
4231  08fa 72100001      	bset	_bMAIN
4233  08fe 2004          	jra	L7322
4234  0900               L5322:
4235                     ; 648 		else bMAIN=0;
4237  0900 72110001      	bres	_bMAIN
4238  0904               L7322:
4239                     ; 650 		cnt_net_drv=0;
4241  0904 3f32          	clr	_cnt_net_drv
4242                     ; 651     		if(!res_fl_)
4244  0906 725d000a      	tnz	_res_fl_
4245  090a 2612          	jrne	L3422
4246                     ; 653 	    		bRES_=1;
4248  090c 35010011      	mov	_bRES_,#1
4249                     ; 654 	    		res_fl_=1;
4251  0910 a601          	ld	a,#1
4252  0912 ae000a        	ldw	x,#_res_fl_
4253  0915 cd0000        	call	c_eewrc
4255  0918 2004          	jra	L3422
4256  091a               L5222:
4257                     ; 658 else link=OFF;	
4259  091a 35aa0062      	mov	_link,#170
4260  091e               L3422:
4261                     ; 659 } 
4264  091e 81            	ret
4334                     	switch	.const
4335  0004               L45:
4336  0004 0000000b      	dc.l	11
4337  0008               L65:
4338  0008 00000001      	dc.l	1
4339                     ; 663 void vent_drv(void)
4339                     ; 664 {
4340                     	switch	.text
4341  091f               _vent_drv:
4343  091f 520e          	subw	sp,#14
4344       0000000e      OFST:	set	14
4347                     ; 667 	short vent_pwm_i_necc=400;
4349  0921 ae0190        	ldw	x,#400
4350  0924 1f07          	ldw	(OFST-7,sp),x
4351                     ; 668 	short vent_pwm_t_necc=400;
4353  0926 ae0190        	ldw	x,#400
4354  0929 1f09          	ldw	(OFST-5,sp),x
4355                     ; 669 	short vent_pwm_max_necc=400;
4357                     ; 674 	tempSL=36000L/(signed long)ee_Umax;
4359  092b ce0014        	ldw	x,_ee_Umax
4360  092e cd0000        	call	c_itolx
4362  0931 96            	ldw	x,sp
4363  0932 1c0001        	addw	x,#OFST-13
4364  0935 cd0000        	call	c_rtol
4366  0938 ae8ca0        	ldw	x,#36000
4367  093b bf02          	ldw	c_lreg+2,x
4368  093d ae0000        	ldw	x,#0
4369  0940 bf00          	ldw	c_lreg,x
4370  0942 96            	ldw	x,sp
4371  0943 1c0001        	addw	x,#OFST-13
4372  0946 cd0000        	call	c_ldiv
4374  0949 96            	ldw	x,sp
4375  094a 1c000b        	addw	x,#OFST-3
4376  094d cd0000        	call	c_rtol
4378                     ; 675 	tempSL=(signed long)I/tempSL;
4380  0950 be6e          	ldw	x,_I
4381  0952 cd0000        	call	c_itolx
4383  0955 96            	ldw	x,sp
4384  0956 1c000b        	addw	x,#OFST-3
4385  0959 cd0000        	call	c_ldiv
4387  095c 96            	ldw	x,sp
4388  095d 1c000b        	addw	x,#OFST-3
4389  0960 cd0000        	call	c_rtol
4391                     ; 677 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4393  0963 ce0004        	ldw	x,_ee_DEVICE
4394  0966 a30001        	cpw	x,#1
4395  0969 2613          	jrne	L7722
4398  096b be6e          	ldw	x,_I
4399  096d 90ce0002      	ldw	y,_ee_IMAXVENT
4400  0971 cd0000        	call	c_idiv
4402  0974 cd0000        	call	c_itolx
4404  0977 96            	ldw	x,sp
4405  0978 1c000b        	addw	x,#OFST-3
4406  097b cd0000        	call	c_rtol
4408  097e               L7722:
4409                     ; 679 	if(tempSL>10)vent_pwm_i_necc=1000;
4411  097e 9c            	rvf
4412  097f 96            	ldw	x,sp
4413  0980 1c000b        	addw	x,#OFST-3
4414  0983 cd0000        	call	c_ltor
4416  0986 ae0004        	ldw	x,#L45
4417  0989 cd0000        	call	c_lcmp
4419  098c 2f07          	jrslt	L1032
4422  098e ae03e8        	ldw	x,#1000
4423  0991 1f07          	ldw	(OFST-7,sp),x
4425  0993 2025          	jra	L3032
4426  0995               L1032:
4427                     ; 680 	else if(tempSL<1)vent_pwm_i_necc=400;
4429  0995 9c            	rvf
4430  0996 96            	ldw	x,sp
4431  0997 1c000b        	addw	x,#OFST-3
4432  099a cd0000        	call	c_ltor
4434  099d ae0008        	ldw	x,#L65
4435  09a0 cd0000        	call	c_lcmp
4437  09a3 2e07          	jrsge	L5032
4440  09a5 ae0190        	ldw	x,#400
4441  09a8 1f07          	ldw	(OFST-7,sp),x
4443  09aa 200e          	jra	L3032
4444  09ac               L5032:
4445                     ; 681 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4447  09ac 1e0d          	ldw	x,(OFST-1,sp)
4448  09ae 90ae003c      	ldw	y,#60
4449  09b2 cd0000        	call	c_imul
4451  09b5 1c0190        	addw	x,#400
4452  09b8 1f07          	ldw	(OFST-7,sp),x
4453  09ba               L3032:
4454                     ; 682 	gran(&vent_pwm_i_necc,400,1000);
4456  09ba ae03e8        	ldw	x,#1000
4457  09bd 89            	pushw	x
4458  09be ae0190        	ldw	x,#400
4459  09c1 89            	pushw	x
4460  09c2 96            	ldw	x,sp
4461  09c3 1c000b        	addw	x,#OFST-3
4462  09c6 cd00d1        	call	_gran
4464  09c9 5b04          	addw	sp,#4
4465                     ; 684 	tempSL=(signed long)T;
4467  09cb b667          	ld	a,_T
4468  09cd b703          	ld	c_lreg+3,a
4469  09cf 48            	sll	a
4470  09d0 4f            	clr	a
4471  09d1 a200          	sbc	a,#0
4472  09d3 b702          	ld	c_lreg+2,a
4473  09d5 b701          	ld	c_lreg+1,a
4474  09d7 b700          	ld	c_lreg,a
4475  09d9 96            	ldw	x,sp
4476  09da 1c000b        	addw	x,#OFST-3
4477  09dd cd0000        	call	c_rtol
4479                     ; 685 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4481  09e0 9c            	rvf
4482  09e1 ce000e        	ldw	x,_ee_tsign
4483  09e4 cd0000        	call	c_itolx
4485  09e7 a61e          	ld	a,#30
4486  09e9 cd0000        	call	c_lsbc
4488  09ec 96            	ldw	x,sp
4489  09ed 1c000b        	addw	x,#OFST-3
4490  09f0 cd0000        	call	c_lcmp
4492  09f3 2f07          	jrslt	L1132
4495  09f5 ae0190        	ldw	x,#400
4496  09f8 1f09          	ldw	(OFST-5,sp),x
4498  09fa 2030          	jra	L3132
4499  09fc               L1132:
4500                     ; 686 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4502  09fc 9c            	rvf
4503  09fd ce000e        	ldw	x,_ee_tsign
4504  0a00 cd0000        	call	c_itolx
4506  0a03 96            	ldw	x,sp
4507  0a04 1c000b        	addw	x,#OFST-3
4508  0a07 cd0000        	call	c_lcmp
4510  0a0a 2c07          	jrsgt	L5132
4513  0a0c ae03e8        	ldw	x,#1000
4514  0a0f 1f09          	ldw	(OFST-5,sp),x
4516  0a11 2019          	jra	L3132
4517  0a13               L5132:
4518                     ; 687 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4520  0a13 ce000e        	ldw	x,_ee_tsign
4521  0a16 1d001e        	subw	x,#30
4522  0a19 1f03          	ldw	(OFST-11,sp),x
4523  0a1b 1e0d          	ldw	x,(OFST-1,sp)
4524  0a1d 72f003        	subw	x,(OFST-11,sp)
4525  0a20 90ae0014      	ldw	y,#20
4526  0a24 cd0000        	call	c_imul
4528  0a27 1c0190        	addw	x,#400
4529  0a2a 1f09          	ldw	(OFST-5,sp),x
4530  0a2c               L3132:
4531                     ; 688 	gran(&vent_pwm_t_necc,400,1000);
4533  0a2c ae03e8        	ldw	x,#1000
4534  0a2f 89            	pushw	x
4535  0a30 ae0190        	ldw	x,#400
4536  0a33 89            	pushw	x
4537  0a34 96            	ldw	x,sp
4538  0a35 1c000d        	addw	x,#OFST-1
4539  0a38 cd00d1        	call	_gran
4541  0a3b 5b04          	addw	sp,#4
4542                     ; 690 	vent_pwm_max_necc=vent_pwm_i_necc;
4544  0a3d 1e07          	ldw	x,(OFST-7,sp)
4545  0a3f 1f05          	ldw	(OFST-9,sp),x
4546                     ; 691 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4548  0a41 9c            	rvf
4549  0a42 1e09          	ldw	x,(OFST-5,sp)
4550  0a44 1307          	cpw	x,(OFST-7,sp)
4551  0a46 2d04          	jrsle	L1232
4554  0a48 1e09          	ldw	x,(OFST-5,sp)
4555  0a4a 1f05          	ldw	(OFST-9,sp),x
4556  0a4c               L1232:
4557                     ; 693 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4559  0a4c 9c            	rvf
4560  0a4d be05          	ldw	x,_vent_pwm
4561  0a4f 1305          	cpw	x,(OFST-9,sp)
4562  0a51 2e07          	jrsge	L3232
4565  0a53 be05          	ldw	x,_vent_pwm
4566  0a55 1c000a        	addw	x,#10
4567  0a58 bf05          	ldw	_vent_pwm,x
4568  0a5a               L3232:
4569                     ; 694 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4571  0a5a 9c            	rvf
4572  0a5b be05          	ldw	x,_vent_pwm
4573  0a5d 1305          	cpw	x,(OFST-9,sp)
4574  0a5f 2d07          	jrsle	L5232
4577  0a61 be05          	ldw	x,_vent_pwm
4578  0a63 1d000a        	subw	x,#10
4579  0a66 bf05          	ldw	_vent_pwm,x
4580  0a68               L5232:
4581                     ; 695 	gran(&vent_pwm,400,1000);
4583  0a68 ae03e8        	ldw	x,#1000
4584  0a6b 89            	pushw	x
4585  0a6c ae0190        	ldw	x,#400
4586  0a6f 89            	pushw	x
4587  0a70 ae0005        	ldw	x,#_vent_pwm
4588  0a73 cd00d1        	call	_gran
4590  0a76 5b04          	addw	sp,#4
4591                     ; 699 	if(bVENT_BLOCK)vent_pwm=0;
4593  0a78 3d00          	tnz	_bVENT_BLOCK
4594  0a7a 2703          	jreq	L7232
4597  0a7c 5f            	clrw	x
4598  0a7d bf05          	ldw	_vent_pwm,x
4599  0a7f               L7232:
4600                     ; 700 }
4603  0a7f 5b0e          	addw	sp,#14
4604  0a81 81            	ret
4639                     ; 705 void pwr_drv(void)
4639                     ; 706 {
4640                     	switch	.text
4641  0a82               _pwr_drv:
4645                     ; 710 BLOCK_INIT
4647  0a82 72145007      	bset	20487,#2
4650  0a86 72145008      	bset	20488,#2
4653  0a8a 72155009      	bres	20489,#2
4654                     ; 712 if(main_cnt1<1500)main_cnt1++;
4656  0a8e 9c            	rvf
4657  0a8f be4f          	ldw	x,_main_cnt1
4658  0a91 a305dc        	cpw	x,#1500
4659  0a94 2e07          	jrsge	L1432
4662  0a96 be4f          	ldw	x,_main_cnt1
4663  0a98 1c0001        	addw	x,#1
4664  0a9b bf4f          	ldw	_main_cnt1,x
4665  0a9d               L1432:
4666                     ; 714 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4668  0a9d 9c            	rvf
4669  0a9e ce0016        	ldw	x,_ee_TZAS
4670  0aa1 90ae0005      	ldw	y,#5
4671  0aa5 cd0000        	call	c_imul
4673  0aa8 b34f          	cpw	x,_main_cnt1
4674  0aaa 2d12          	jrsle	L3432
4676  0aac b604          	ld	a,_bps_class
4677  0aae a101          	cp	a,#1
4678  0ab0 270c          	jreq	L3432
4679                     ; 716 	BLOCK_ON
4681  0ab2 72145005      	bset	20485,#2
4684  0ab6 35010000      	mov	_bVENT_BLOCK,#1
4686  0aba ac5b0b5b      	jpf	L5432
4687  0abe               L3432:
4688                     ; 719 else if(bps_class==bpsIPS)
4690  0abe b604          	ld	a,_bps_class
4691  0ac0 a101          	cp	a,#1
4692  0ac2 2621          	jrne	L7432
4693                     ; 722 		if(bBL_IPS)
4695                     	btst	_bBL_IPS
4696  0ac9 240b          	jruge	L1532
4697                     ; 724 			 BLOCK_ON
4699  0acb 72145005      	bset	20485,#2
4702  0acf 35010000      	mov	_bVENT_BLOCK,#1
4704  0ad3 cc0b5b        	jra	L5432
4705  0ad6               L1532:
4706                     ; 727 		else if(!bBL_IPS)
4708                     	btst	_bBL_IPS
4709  0adb 257e          	jrult	L5432
4710                     ; 729 			  BLOCK_OFF
4712  0add 72155005      	bres	20485,#2
4715  0ae1 3f00          	clr	_bVENT_BLOCK
4716  0ae3 2076          	jra	L5432
4717  0ae5               L7432:
4718                     ; 733 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4720  0ae5 9c            	rvf
4721  0ae6 ce0016        	ldw	x,_ee_TZAS
4722  0ae9 90ae0005      	ldw	y,#5
4723  0aed cd0000        	call	c_imul
4725  0af0 b34f          	cpw	x,_main_cnt1
4726  0af2 2e49          	jrsge	L1632
4728  0af4 9c            	rvf
4729  0af5 ce0016        	ldw	x,_ee_TZAS
4730  0af8 90ae0005      	ldw	y,#5
4731  0afc cd0000        	call	c_imul
4733  0aff 1c0046        	addw	x,#70
4734  0b02 b34f          	cpw	x,_main_cnt1
4735  0b04 2d37          	jrsle	L1632
4736                     ; 735 	if(bps_class==bpsIPS)
4738  0b06 b604          	ld	a,_bps_class
4739  0b08 a101          	cp	a,#1
4740  0b0a 2608          	jrne	L3632
4741                     ; 737 		  BLOCK_OFF
4743  0b0c 72155005      	bres	20485,#2
4746  0b10 3f00          	clr	_bVENT_BLOCK
4748  0b12 2047          	jra	L5432
4749  0b14               L3632:
4750                     ; 740 	else if(bps_class==bpsIBEP)
4752  0b14 3d04          	tnz	_bps_class
4753  0b16 2643          	jrne	L5432
4754                     ; 742 		if(ee_DEVICE)
4756  0b18 ce0004        	ldw	x,_ee_DEVICE
4757  0b1b 2718          	jreq	L1732
4758                     ; 744 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4760  0b1d b60b          	ld	a,_flags
4761  0b1f a520          	bcp	a,#32
4762  0b21 270a          	jreq	L3732
4765  0b23 72145005      	bset	20485,#2
4768  0b27 35010000      	mov	_bVENT_BLOCK,#1
4770  0b2b 202e          	jra	L5432
4771  0b2d               L3732:
4772                     ; 745 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4774  0b2d 72155005      	bres	20485,#2
4777  0b31 3f00          	clr	_bVENT_BLOCK
4778  0b33 2026          	jra	L5432
4779  0b35               L1732:
4780                     ; 749 			BLOCK_OFF
4782  0b35 72155005      	bres	20485,#2
4785  0b39 3f00          	clr	_bVENT_BLOCK
4786  0b3b 201e          	jra	L5432
4787  0b3d               L1632:
4788                     ; 754 else if(bBL)
4790                     	btst	_bBL
4791  0b42 240a          	jruge	L3042
4792                     ; 756 	BLOCK_ON
4794  0b44 72145005      	bset	20485,#2
4797  0b48 35010000      	mov	_bVENT_BLOCK,#1
4799  0b4c 200d          	jra	L5432
4800  0b4e               L3042:
4801                     ; 759 else if(!bBL)
4803                     	btst	_bBL
4804  0b53 2506          	jrult	L5432
4805                     ; 761 	BLOCK_OFF
4807  0b55 72155005      	bres	20485,#2
4810  0b59 3f00          	clr	_bVENT_BLOCK
4811  0b5b               L5432:
4812                     ; 765 gran(&pwm_u,2,1020);
4814  0b5b ae03fc        	ldw	x,#1020
4815  0b5e 89            	pushw	x
4816  0b5f ae0002        	ldw	x,#2
4817  0b62 89            	pushw	x
4818  0b63 ae000c        	ldw	x,#_pwm_u
4819  0b66 cd00d1        	call	_gran
4821  0b69 5b04          	addw	sp,#4
4822                     ; 775 TIM1->CCR2H= (char)(pwm_u/256);	
4824  0b6b be0c          	ldw	x,_pwm_u
4825  0b6d 90ae0100      	ldw	y,#256
4826  0b71 cd0000        	call	c_idiv
4828  0b74 9f            	ld	a,xl
4829  0b75 c75267        	ld	21095,a
4830                     ; 776 TIM1->CCR2L= (char)pwm_u;
4832  0b78 55000d5268    	mov	21096,_pwm_u+1
4833                     ; 778 TIM1->CCR1H= (char)(pwm_i/256);	
4835  0b7d be0e          	ldw	x,_pwm_i
4836  0b7f 90ae0100      	ldw	y,#256
4837  0b83 cd0000        	call	c_idiv
4839  0b86 9f            	ld	a,xl
4840  0b87 c75265        	ld	21093,a
4841                     ; 779 TIM1->CCR1L= (char)pwm_i;
4843  0b8a 55000f5266    	mov	21094,_pwm_i+1
4844                     ; 781 TIM1->CCR3H= (char)(vent_pwm/256);	
4846  0b8f be05          	ldw	x,_vent_pwm
4847  0b91 90ae0100      	ldw	y,#256
4848  0b95 cd0000        	call	c_idiv
4850  0b98 9f            	ld	a,xl
4851  0b99 c75269        	ld	21097,a
4852                     ; 782 TIM1->CCR3L= (char)vent_pwm;
4854  0b9c 550006526a    	mov	21098,_vent_pwm+1
4855                     ; 783 }
4858  0ba1 81            	ret
4896                     ; 788 void pwr_hndl(void)				
4896                     ; 789 {
4897                     	switch	.text
4898  0ba2               _pwr_hndl:
4902                     ; 790 if(jp_mode==jp3)
4904  0ba2 b64a          	ld	a,_jp_mode
4905  0ba4 a103          	cp	a,#3
4906  0ba6 2627          	jrne	L1242
4907                     ; 792 	if((flags&0b00001010)==0)
4909  0ba8 b60b          	ld	a,_flags
4910  0baa a50a          	bcp	a,#10
4911  0bac 260d          	jrne	L3242
4912                     ; 794 		pwm_u=500;
4914  0bae ae01f4        	ldw	x,#500
4915  0bb1 bf0c          	ldw	_pwm_u,x
4916                     ; 796 		bBL=0;
4918  0bb3 72110003      	bres	_bBL
4920  0bb7 acbd0cbd      	jpf	L1342
4921  0bbb               L3242:
4922                     ; 798 	else if(flags&0b00001010)
4924  0bbb b60b          	ld	a,_flags
4925  0bbd a50a          	bcp	a,#10
4926  0bbf 2603          	jrne	L46
4927  0bc1 cc0cbd        	jp	L1342
4928  0bc4               L46:
4929                     ; 800 		pwm_u=0;
4931  0bc4 5f            	clrw	x
4932  0bc5 bf0c          	ldw	_pwm_u,x
4933                     ; 802 		bBL=1;
4935  0bc7 72100003      	bset	_bBL
4936  0bcb acbd0cbd      	jpf	L1342
4937  0bcf               L1242:
4938                     ; 806 else if(jp_mode==jp2)
4940  0bcf b64a          	ld	a,_jp_mode
4941  0bd1 a102          	cp	a,#2
4942  0bd3 2610          	jrne	L3342
4943                     ; 808 	pwm_u=0;
4945  0bd5 5f            	clrw	x
4946  0bd6 bf0c          	ldw	_pwm_u,x
4947                     ; 809 	pwm_i=0x3ff;
4949  0bd8 ae03ff        	ldw	x,#1023
4950  0bdb bf0e          	ldw	_pwm_i,x
4951                     ; 810 	bBL=0;
4953  0bdd 72110003      	bres	_bBL
4955  0be1 acbd0cbd      	jpf	L1342
4956  0be5               L3342:
4957                     ; 812 else if(jp_mode==jp1)
4959  0be5 b64a          	ld	a,_jp_mode
4960  0be7 a101          	cp	a,#1
4961  0be9 2612          	jrne	L7342
4962                     ; 814 	pwm_u=0x3ff;
4964  0beb ae03ff        	ldw	x,#1023
4965  0bee bf0c          	ldw	_pwm_u,x
4966                     ; 815 	pwm_i=0x3ff;
4968  0bf0 ae03ff        	ldw	x,#1023
4969  0bf3 bf0e          	ldw	_pwm_i,x
4970                     ; 816 	bBL=0;
4972  0bf5 72110003      	bres	_bBL
4974  0bf9 acbd0cbd      	jpf	L1342
4975  0bfd               L7342:
4976                     ; 819 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4978                     	btst	_bMAIN
4979  0c02 2417          	jruge	L3442
4981  0c04 b662          	ld	a,_link
4982  0c06 a155          	cp	a,#85
4983  0c08 2611          	jrne	L3442
4984                     ; 821 	pwm_u=volum_u_main_;
4986  0c0a be1d          	ldw	x,_volum_u_main_
4987  0c0c bf0c          	ldw	_pwm_u,x
4988                     ; 822 	pwm_i=0x3ff;
4990  0c0e ae03ff        	ldw	x,#1023
4991  0c11 bf0e          	ldw	_pwm_i,x
4992                     ; 823 	bBL_IPS=0;
4994  0c13 72110000      	bres	_bBL_IPS
4996  0c17 acbd0cbd      	jpf	L1342
4997  0c1b               L3442:
4998                     ; 826 else if(link==OFF)
5000  0c1b b662          	ld	a,_link
5001  0c1d a1aa          	cp	a,#170
5002  0c1f 2650          	jrne	L7442
5003                     ; 835  	if(ee_DEVICE)
5005  0c21 ce0004        	ldw	x,_ee_DEVICE
5006  0c24 270d          	jreq	L1542
5007                     ; 837 		pwm_u=0x00;
5009  0c26 5f            	clrw	x
5010  0c27 bf0c          	ldw	_pwm_u,x
5011                     ; 838 		pwm_i=0x00;
5013  0c29 5f            	clrw	x
5014  0c2a bf0e          	ldw	_pwm_i,x
5015                     ; 839 		bBL=1;
5017  0c2c 72100003      	bset	_bBL
5019  0c30 cc0cbd        	jra	L1342
5020  0c33               L1542:
5021                     ; 843 		if((flags&0b00011010)==0)
5023  0c33 b60b          	ld	a,_flags
5024  0c35 a51a          	bcp	a,#26
5025  0c37 2622          	jrne	L5542
5026                     ; 845 			pwm_u=ee_U_AVT;
5028  0c39 ce000c        	ldw	x,_ee_U_AVT
5029  0c3c bf0c          	ldw	_pwm_u,x
5030                     ; 846 			gran(&pwm_u,0,1020);
5032  0c3e ae03fc        	ldw	x,#1020
5033  0c41 89            	pushw	x
5034  0c42 5f            	clrw	x
5035  0c43 89            	pushw	x
5036  0c44 ae000c        	ldw	x,#_pwm_u
5037  0c47 cd00d1        	call	_gran
5039  0c4a 5b04          	addw	sp,#4
5040                     ; 847 		    	pwm_i=0x3ff;
5042  0c4c ae03ff        	ldw	x,#1023
5043  0c4f bf0e          	ldw	_pwm_i,x
5044                     ; 848 			bBL=0;
5046  0c51 72110003      	bres	_bBL
5047                     ; 849 			bBL_IPS=0;
5049  0c55 72110000      	bres	_bBL_IPS
5051  0c59 2062          	jra	L1342
5052  0c5b               L5542:
5053                     ; 851 		else if(flags&0b00011010)
5055  0c5b b60b          	ld	a,_flags
5056  0c5d a51a          	bcp	a,#26
5057  0c5f 275c          	jreq	L1342
5058                     ; 853 			pwm_u=0;
5060  0c61 5f            	clrw	x
5061  0c62 bf0c          	ldw	_pwm_u,x
5062                     ; 854 			pwm_i=0;
5064  0c64 5f            	clrw	x
5065  0c65 bf0e          	ldw	_pwm_i,x
5066                     ; 855 			bBL=1;
5068  0c67 72100003      	bset	_bBL
5069                     ; 856 			bBL_IPS=1;
5071  0c6b 72100000      	bset	_bBL_IPS
5072  0c6f 204c          	jra	L1342
5073  0c71               L7442:
5074                     ; 865 else	if(link==ON)				//если есть связь
5076  0c71 b662          	ld	a,_link
5077  0c73 a155          	cp	a,#85
5078  0c75 2646          	jrne	L1342
5079                     ; 867 	if((flags&0b00100000)==0)	//если нет блокировки извне
5081  0c77 b60b          	ld	a,_flags
5082  0c79 a520          	bcp	a,#32
5083  0c7b 2630          	jrne	L7642
5084                     ; 869 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5086  0c7d b60b          	ld	a,_flags
5087  0c7f a51a          	bcp	a,#26
5088  0c81 2706          	jreq	L3742
5090  0c83 b60b          	ld	a,_flags
5091  0c85 a540          	bcp	a,#64
5092  0c87 2712          	jreq	L1742
5093  0c89               L3742:
5094                     ; 871 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5096  0c89 be5e          	ldw	x,__x_
5097  0c8b 72bb0058      	addw	x,_vol_u_temp
5098  0c8f bf0c          	ldw	_pwm_u,x
5099                     ; 872 		    	pwm_i=vol_i_temp;
5101  0c91 be56          	ldw	x,_vol_i_temp
5102  0c93 bf0e          	ldw	_pwm_i,x
5103                     ; 873 			bBL=0;
5105  0c95 72110003      	bres	_bBL
5107  0c99 2022          	jra	L1342
5108  0c9b               L1742:
5109                     ; 875 		else if(flags&0b00011010)					//если есть аварии
5111  0c9b b60b          	ld	a,_flags
5112  0c9d a51a          	bcp	a,#26
5113  0c9f 271c          	jreq	L1342
5114                     ; 877 			pwm_u=0;								//то полный стоп
5116  0ca1 5f            	clrw	x
5117  0ca2 bf0c          	ldw	_pwm_u,x
5118                     ; 878 			pwm_i=0;
5120  0ca4 5f            	clrw	x
5121  0ca5 bf0e          	ldw	_pwm_i,x
5122                     ; 879 			bBL=1;
5124  0ca7 72100003      	bset	_bBL
5125  0cab 2010          	jra	L1342
5126  0cad               L7642:
5127                     ; 882 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5129  0cad b60b          	ld	a,_flags
5130  0caf a520          	bcp	a,#32
5131  0cb1 270a          	jreq	L1342
5132                     ; 884 		pwm_u=0;
5134  0cb3 5f            	clrw	x
5135  0cb4 bf0c          	ldw	_pwm_u,x
5136                     ; 885 	    	pwm_i=0;
5138  0cb6 5f            	clrw	x
5139  0cb7 bf0e          	ldw	_pwm_i,x
5140                     ; 886 		bBL=1;
5142  0cb9 72100003      	bset	_bBL
5143  0cbd               L1342:
5144                     ; 892 }
5147  0cbd 81            	ret
5189                     	switch	.const
5190  000c               L07:
5191  000c 00000258      	dc.l	600
5192  0010               L27:
5193  0010 000003e8      	dc.l	1000
5194  0014               L47:
5195  0014 00000708      	dc.l	1800
5196                     ; 895 void matemat(void)
5196                     ; 896 {
5197                     	switch	.text
5198  0cbe               _matemat:
5200  0cbe 5204          	subw	sp,#4
5201       00000004      OFST:	set	4
5204                     ; 917 temp_SL=adc_buff_[4];
5206  0cc0 ce0011        	ldw	x,_adc_buff_+8
5207  0cc3 cd0000        	call	c_itolx
5209  0cc6 96            	ldw	x,sp
5210  0cc7 1c0001        	addw	x,#OFST-3
5211  0cca cd0000        	call	c_rtol
5213                     ; 918 temp_SL-=ee_K[0][0];
5215  0ccd ce001a        	ldw	x,_ee_K
5216  0cd0 cd0000        	call	c_itolx
5218  0cd3 96            	ldw	x,sp
5219  0cd4 1c0001        	addw	x,#OFST-3
5220  0cd7 cd0000        	call	c_lgsub
5222                     ; 919 if(temp_SL<0) temp_SL=0;
5224  0cda 9c            	rvf
5225  0cdb 0d01          	tnz	(OFST-3,sp)
5226  0cdd 2e0a          	jrsge	L3252
5229  0cdf ae0000        	ldw	x,#0
5230  0ce2 1f03          	ldw	(OFST-1,sp),x
5231  0ce4 ae0000        	ldw	x,#0
5232  0ce7 1f01          	ldw	(OFST-3,sp),x
5233  0ce9               L3252:
5234                     ; 920 temp_SL*=ee_K[0][1];
5236  0ce9 ce001c        	ldw	x,_ee_K+2
5237  0cec cd0000        	call	c_itolx
5239  0cef 96            	ldw	x,sp
5240  0cf0 1c0001        	addw	x,#OFST-3
5241  0cf3 cd0000        	call	c_lgmul
5243                     ; 921 temp_SL/=600;
5245  0cf6 96            	ldw	x,sp
5246  0cf7 1c0001        	addw	x,#OFST-3
5247  0cfa cd0000        	call	c_ltor
5249  0cfd ae000c        	ldw	x,#L07
5250  0d00 cd0000        	call	c_ldiv
5252  0d03 96            	ldw	x,sp
5253  0d04 1c0001        	addw	x,#OFST-3
5254  0d07 cd0000        	call	c_rtol
5256                     ; 922 I=(signed short)temp_SL;
5258  0d0a 1e03          	ldw	x,(OFST-1,sp)
5259  0d0c bf6e          	ldw	_I,x
5260                     ; 927 temp_SL=(signed long)adc_buff_[1];
5262  0d0e ce000b        	ldw	x,_adc_buff_+2
5263  0d11 cd0000        	call	c_itolx
5265  0d14 96            	ldw	x,sp
5266  0d15 1c0001        	addw	x,#OFST-3
5267  0d18 cd0000        	call	c_rtol
5269                     ; 929 if(temp_SL<0) temp_SL=0;
5271  0d1b 9c            	rvf
5272  0d1c 0d01          	tnz	(OFST-3,sp)
5273  0d1e 2e0a          	jrsge	L5252
5276  0d20 ae0000        	ldw	x,#0
5277  0d23 1f03          	ldw	(OFST-1,sp),x
5278  0d25 ae0000        	ldw	x,#0
5279  0d28 1f01          	ldw	(OFST-3,sp),x
5280  0d2a               L5252:
5281                     ; 930 temp_SL*=(signed long)ee_K[2][1];
5283  0d2a ce0024        	ldw	x,_ee_K+10
5284  0d2d cd0000        	call	c_itolx
5286  0d30 96            	ldw	x,sp
5287  0d31 1c0001        	addw	x,#OFST-3
5288  0d34 cd0000        	call	c_lgmul
5290                     ; 931 temp_SL/=1000L;
5292  0d37 96            	ldw	x,sp
5293  0d38 1c0001        	addw	x,#OFST-3
5294  0d3b cd0000        	call	c_ltor
5296  0d3e ae0010        	ldw	x,#L27
5297  0d41 cd0000        	call	c_ldiv
5299  0d44 96            	ldw	x,sp
5300  0d45 1c0001        	addw	x,#OFST-3
5301  0d48 cd0000        	call	c_rtol
5303                     ; 932 Ui=(unsigned short)temp_SL;
5305  0d4b 1e03          	ldw	x,(OFST-1,sp)
5306  0d4d bf6a          	ldw	_Ui,x
5307                     ; 939 temp_SL=adc_buff_[3];
5309  0d4f ce000f        	ldw	x,_adc_buff_+6
5310  0d52 cd0000        	call	c_itolx
5312  0d55 96            	ldw	x,sp
5313  0d56 1c0001        	addw	x,#OFST-3
5314  0d59 cd0000        	call	c_rtol
5316                     ; 941 if(temp_SL<0) temp_SL=0;
5318  0d5c 9c            	rvf
5319  0d5d 0d01          	tnz	(OFST-3,sp)
5320  0d5f 2e0a          	jrsge	L7252
5323  0d61 ae0000        	ldw	x,#0
5324  0d64 1f03          	ldw	(OFST-1,sp),x
5325  0d66 ae0000        	ldw	x,#0
5326  0d69 1f01          	ldw	(OFST-3,sp),x
5327  0d6b               L7252:
5328                     ; 942 temp_SL*=ee_K[1][1];
5330  0d6b ce0020        	ldw	x,_ee_K+6
5331  0d6e cd0000        	call	c_itolx
5333  0d71 96            	ldw	x,sp
5334  0d72 1c0001        	addw	x,#OFST-3
5335  0d75 cd0000        	call	c_lgmul
5337                     ; 943 temp_SL/=1800;
5339  0d78 96            	ldw	x,sp
5340  0d79 1c0001        	addw	x,#OFST-3
5341  0d7c cd0000        	call	c_ltor
5343  0d7f ae0014        	ldw	x,#L47
5344  0d82 cd0000        	call	c_ldiv
5346  0d85 96            	ldw	x,sp
5347  0d86 1c0001        	addw	x,#OFST-3
5348  0d89 cd0000        	call	c_rtol
5350                     ; 944 Un=(unsigned short)temp_SL;
5352  0d8c 1e03          	ldw	x,(OFST-1,sp)
5353  0d8e bf6c          	ldw	_Un,x
5354                     ; 947 temp_SL=adc_buff_[2];
5356  0d90 ce000d        	ldw	x,_adc_buff_+4
5357  0d93 cd0000        	call	c_itolx
5359  0d96 96            	ldw	x,sp
5360  0d97 1c0001        	addw	x,#OFST-3
5361  0d9a cd0000        	call	c_rtol
5363                     ; 948 temp_SL*=ee_K[3][1];
5365  0d9d ce0028        	ldw	x,_ee_K+14
5366  0da0 cd0000        	call	c_itolx
5368  0da3 96            	ldw	x,sp
5369  0da4 1c0001        	addw	x,#OFST-3
5370  0da7 cd0000        	call	c_lgmul
5372                     ; 949 temp_SL/=1000;
5374  0daa 96            	ldw	x,sp
5375  0dab 1c0001        	addw	x,#OFST-3
5376  0dae cd0000        	call	c_ltor
5378  0db1 ae0010        	ldw	x,#L27
5379  0db4 cd0000        	call	c_ldiv
5381  0db7 96            	ldw	x,sp
5382  0db8 1c0001        	addw	x,#OFST-3
5383  0dbb cd0000        	call	c_rtol
5385                     ; 950 T=(signed short)(temp_SL-273L);
5387  0dbe 7b04          	ld	a,(OFST+0,sp)
5388  0dc0 5f            	clrw	x
5389  0dc1 4d            	tnz	a
5390  0dc2 2a01          	jrpl	L67
5391  0dc4 53            	cplw	x
5392  0dc5               L67:
5393  0dc5 97            	ld	xl,a
5394  0dc6 1d0111        	subw	x,#273
5395  0dc9 01            	rrwa	x,a
5396  0dca b767          	ld	_T,a
5397  0dcc 02            	rlwa	x,a
5398                     ; 951 if(T<-30)T=-30;
5400  0dcd 9c            	rvf
5401  0dce b667          	ld	a,_T
5402  0dd0 a1e2          	cp	a,#226
5403  0dd2 2e04          	jrsge	L1352
5406  0dd4 35e20067      	mov	_T,#226
5407  0dd8               L1352:
5408                     ; 952 if(T>120)T=120;
5410  0dd8 9c            	rvf
5411  0dd9 b667          	ld	a,_T
5412  0ddb a179          	cp	a,#121
5413  0ddd 2f04          	jrslt	L3352
5416  0ddf 35780067      	mov	_T,#120
5417  0de3               L3352:
5418                     ; 954 Udb=flags;
5420  0de3 b60b          	ld	a,_flags
5421  0de5 5f            	clrw	x
5422  0de6 97            	ld	xl,a
5423  0de7 bf68          	ldw	_Udb,x
5424                     ; 960 }
5427  0de9 5b04          	addw	sp,#4
5428  0deb 81            	ret
5459                     ; 963 void temper_drv(void)		//1 Hz
5459                     ; 964 {
5460                     	switch	.text
5461  0dec               _temper_drv:
5465                     ; 966 if(T>ee_tsign) tsign_cnt++;
5467  0dec 9c            	rvf
5468  0ded 5f            	clrw	x
5469  0dee b667          	ld	a,_T
5470  0df0 2a01          	jrpl	L201
5471  0df2 53            	cplw	x
5472  0df3               L201:
5473  0df3 97            	ld	xl,a
5474  0df4 c3000e        	cpw	x,_ee_tsign
5475  0df7 2d09          	jrsle	L5452
5478  0df9 be4d          	ldw	x,_tsign_cnt
5479  0dfb 1c0001        	addw	x,#1
5480  0dfe bf4d          	ldw	_tsign_cnt,x
5482  0e00 201d          	jra	L7452
5483  0e02               L5452:
5484                     ; 967 else if (T<(ee_tsign-1)) tsign_cnt--;
5486  0e02 9c            	rvf
5487  0e03 ce000e        	ldw	x,_ee_tsign
5488  0e06 5a            	decw	x
5489  0e07 905f          	clrw	y
5490  0e09 b667          	ld	a,_T
5491  0e0b 2a02          	jrpl	L401
5492  0e0d 9053          	cplw	y
5493  0e0f               L401:
5494  0e0f 9097          	ld	yl,a
5495  0e11 90bf00        	ldw	c_y,y
5496  0e14 b300          	cpw	x,c_y
5497  0e16 2d07          	jrsle	L7452
5500  0e18 be4d          	ldw	x,_tsign_cnt
5501  0e1a 1d0001        	subw	x,#1
5502  0e1d bf4d          	ldw	_tsign_cnt,x
5503  0e1f               L7452:
5504                     ; 969 gran(&tsign_cnt,0,60);
5506  0e1f ae003c        	ldw	x,#60
5507  0e22 89            	pushw	x
5508  0e23 5f            	clrw	x
5509  0e24 89            	pushw	x
5510  0e25 ae004d        	ldw	x,#_tsign_cnt
5511  0e28 cd00d1        	call	_gran
5513  0e2b 5b04          	addw	sp,#4
5514                     ; 971 if(tsign_cnt>=55)
5516  0e2d 9c            	rvf
5517  0e2e be4d          	ldw	x,_tsign_cnt
5518  0e30 a30037        	cpw	x,#55
5519  0e33 2f16          	jrslt	L3552
5520                     ; 973 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5522  0e35 3d4a          	tnz	_jp_mode
5523  0e37 2606          	jrne	L1652
5525  0e39 b60b          	ld	a,_flags
5526  0e3b a540          	bcp	a,#64
5527  0e3d 2706          	jreq	L7552
5528  0e3f               L1652:
5530  0e3f b64a          	ld	a,_jp_mode
5531  0e41 a103          	cp	a,#3
5532  0e43 2612          	jrne	L3652
5533  0e45               L7552:
5536  0e45 7214000b      	bset	_flags,#2
5537  0e49 200c          	jra	L3652
5538  0e4b               L3552:
5539                     ; 975 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5541  0e4b 9c            	rvf
5542  0e4c be4d          	ldw	x,_tsign_cnt
5543  0e4e a30006        	cpw	x,#6
5544  0e51 2e04          	jrsge	L3652
5547  0e53 7215000b      	bres	_flags,#2
5548  0e57               L3652:
5549                     ; 980 if(T>ee_tmax) tmax_cnt++;
5551  0e57 9c            	rvf
5552  0e58 5f            	clrw	x
5553  0e59 b667          	ld	a,_T
5554  0e5b 2a01          	jrpl	L601
5555  0e5d 53            	cplw	x
5556  0e5e               L601:
5557  0e5e 97            	ld	xl,a
5558  0e5f c30010        	cpw	x,_ee_tmax
5559  0e62 2d09          	jrsle	L7652
5562  0e64 be4b          	ldw	x,_tmax_cnt
5563  0e66 1c0001        	addw	x,#1
5564  0e69 bf4b          	ldw	_tmax_cnt,x
5566  0e6b 201d          	jra	L1752
5567  0e6d               L7652:
5568                     ; 981 else if (T<(ee_tmax-1)) tmax_cnt--;
5570  0e6d 9c            	rvf
5571  0e6e ce0010        	ldw	x,_ee_tmax
5572  0e71 5a            	decw	x
5573  0e72 905f          	clrw	y
5574  0e74 b667          	ld	a,_T
5575  0e76 2a02          	jrpl	L011
5576  0e78 9053          	cplw	y
5577  0e7a               L011:
5578  0e7a 9097          	ld	yl,a
5579  0e7c 90bf00        	ldw	c_y,y
5580  0e7f b300          	cpw	x,c_y
5581  0e81 2d07          	jrsle	L1752
5584  0e83 be4b          	ldw	x,_tmax_cnt
5585  0e85 1d0001        	subw	x,#1
5586  0e88 bf4b          	ldw	_tmax_cnt,x
5587  0e8a               L1752:
5588                     ; 983 gran(&tmax_cnt,0,60);
5590  0e8a ae003c        	ldw	x,#60
5591  0e8d 89            	pushw	x
5592  0e8e 5f            	clrw	x
5593  0e8f 89            	pushw	x
5594  0e90 ae004b        	ldw	x,#_tmax_cnt
5595  0e93 cd00d1        	call	_gran
5597  0e96 5b04          	addw	sp,#4
5598                     ; 985 if(tmax_cnt>=55)
5600  0e98 9c            	rvf
5601  0e99 be4b          	ldw	x,_tmax_cnt
5602  0e9b a30037        	cpw	x,#55
5603  0e9e 2f16          	jrslt	L5752
5604                     ; 987 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5606  0ea0 3d4a          	tnz	_jp_mode
5607  0ea2 2606          	jrne	L3062
5609  0ea4 b60b          	ld	a,_flags
5610  0ea6 a540          	bcp	a,#64
5611  0ea8 2706          	jreq	L1062
5612  0eaa               L3062:
5614  0eaa b64a          	ld	a,_jp_mode
5615  0eac a103          	cp	a,#3
5616  0eae 2612          	jrne	L5062
5617  0eb0               L1062:
5620  0eb0 7212000b      	bset	_flags,#1
5621  0eb4 200c          	jra	L5062
5622  0eb6               L5752:
5623                     ; 989 else if (tmax_cnt<=5) flags&=0b11111101;
5625  0eb6 9c            	rvf
5626  0eb7 be4b          	ldw	x,_tmax_cnt
5627  0eb9 a30006        	cpw	x,#6
5628  0ebc 2e04          	jrsge	L5062
5631  0ebe 7213000b      	bres	_flags,#1
5632  0ec2               L5062:
5633                     ; 992 } 
5636  0ec2 81            	ret
5668                     ; 995 void u_drv(void)		//1Hz
5668                     ; 996 { 
5669                     	switch	.text
5670  0ec3               _u_drv:
5674                     ; 997 if(jp_mode!=jp3)
5676  0ec3 b64a          	ld	a,_jp_mode
5677  0ec5 a103          	cp	a,#3
5678  0ec7 2770          	jreq	L1262
5679                     ; 999 	if(Ui>ee_Umax)umax_cnt++;
5681  0ec9 9c            	rvf
5682  0eca be6a          	ldw	x,_Ui
5683  0ecc c30014        	cpw	x,_ee_Umax
5684  0ecf 2d09          	jrsle	L3262
5687  0ed1 be65          	ldw	x,_umax_cnt
5688  0ed3 1c0001        	addw	x,#1
5689  0ed6 bf65          	ldw	_umax_cnt,x
5691  0ed8 2003          	jra	L5262
5692  0eda               L3262:
5693                     ; 1000 	else umax_cnt=0;
5695  0eda 5f            	clrw	x
5696  0edb bf65          	ldw	_umax_cnt,x
5697  0edd               L5262:
5698                     ; 1001 	gran(&umax_cnt,0,10);
5700  0edd ae000a        	ldw	x,#10
5701  0ee0 89            	pushw	x
5702  0ee1 5f            	clrw	x
5703  0ee2 89            	pushw	x
5704  0ee3 ae0065        	ldw	x,#_umax_cnt
5705  0ee6 cd00d1        	call	_gran
5707  0ee9 5b04          	addw	sp,#4
5708                     ; 1002 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5710  0eeb 9c            	rvf
5711  0eec be65          	ldw	x,_umax_cnt
5712  0eee a3000a        	cpw	x,#10
5713  0ef1 2f04          	jrslt	L7262
5716  0ef3 7216000b      	bset	_flags,#3
5717  0ef7               L7262:
5718                     ; 1005 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5720  0ef7 9c            	rvf
5721  0ef8 be6a          	ldw	x,_Ui
5722  0efa b36c          	cpw	x,_Un
5723  0efc 2e1c          	jrsge	L1362
5725  0efe 9c            	rvf
5726  0eff be6c          	ldw	x,_Un
5727  0f01 72b0006a      	subw	x,_Ui
5728  0f05 c30012        	cpw	x,_ee_dU
5729  0f08 2d10          	jrsle	L1362
5731  0f0a c65005        	ld	a,20485
5732  0f0d a504          	bcp	a,#4
5733  0f0f 2609          	jrne	L1362
5736  0f11 be63          	ldw	x,_umin_cnt
5737  0f13 1c0001        	addw	x,#1
5738  0f16 bf63          	ldw	_umin_cnt,x
5740  0f18 2003          	jra	L3362
5741  0f1a               L1362:
5742                     ; 1006 	else umin_cnt=0;
5744  0f1a 5f            	clrw	x
5745  0f1b bf63          	ldw	_umin_cnt,x
5746  0f1d               L3362:
5747                     ; 1007 	gran(&umin_cnt,0,10);	
5749  0f1d ae000a        	ldw	x,#10
5750  0f20 89            	pushw	x
5751  0f21 5f            	clrw	x
5752  0f22 89            	pushw	x
5753  0f23 ae0063        	ldw	x,#_umin_cnt
5754  0f26 cd00d1        	call	_gran
5756  0f29 5b04          	addw	sp,#4
5757                     ; 1008 	if(umin_cnt>=10)flags|=0b00010000;	  
5759  0f2b 9c            	rvf
5760  0f2c be63          	ldw	x,_umin_cnt
5761  0f2e a3000a        	cpw	x,#10
5762  0f31 2f6f          	jrslt	L7362
5765  0f33 7218000b      	bset	_flags,#4
5766  0f37 2069          	jra	L7362
5767  0f39               L1262:
5768                     ; 1010 else if(jp_mode==jp3)
5770  0f39 b64a          	ld	a,_jp_mode
5771  0f3b a103          	cp	a,#3
5772  0f3d 2663          	jrne	L7362
5773                     ; 1012 	if(Ui>700)umax_cnt++;
5775  0f3f 9c            	rvf
5776  0f40 be6a          	ldw	x,_Ui
5777  0f42 a302bd        	cpw	x,#701
5778  0f45 2f09          	jrslt	L3462
5781  0f47 be65          	ldw	x,_umax_cnt
5782  0f49 1c0001        	addw	x,#1
5783  0f4c bf65          	ldw	_umax_cnt,x
5785  0f4e 2003          	jra	L5462
5786  0f50               L3462:
5787                     ; 1013 	else umax_cnt=0;
5789  0f50 5f            	clrw	x
5790  0f51 bf65          	ldw	_umax_cnt,x
5791  0f53               L5462:
5792                     ; 1014 	gran(&umax_cnt,0,10);
5794  0f53 ae000a        	ldw	x,#10
5795  0f56 89            	pushw	x
5796  0f57 5f            	clrw	x
5797  0f58 89            	pushw	x
5798  0f59 ae0065        	ldw	x,#_umax_cnt
5799  0f5c cd00d1        	call	_gran
5801  0f5f 5b04          	addw	sp,#4
5802                     ; 1015 	if(umax_cnt>=10)flags|=0b00001000;
5804  0f61 9c            	rvf
5805  0f62 be65          	ldw	x,_umax_cnt
5806  0f64 a3000a        	cpw	x,#10
5807  0f67 2f04          	jrslt	L7462
5810  0f69 7216000b      	bset	_flags,#3
5811  0f6d               L7462:
5812                     ; 1018 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5814  0f6d 9c            	rvf
5815  0f6e be6a          	ldw	x,_Ui
5816  0f70 a300c8        	cpw	x,#200
5817  0f73 2e10          	jrsge	L1562
5819  0f75 c65005        	ld	a,20485
5820  0f78 a504          	bcp	a,#4
5821  0f7a 2609          	jrne	L1562
5824  0f7c be63          	ldw	x,_umin_cnt
5825  0f7e 1c0001        	addw	x,#1
5826  0f81 bf63          	ldw	_umin_cnt,x
5828  0f83 2003          	jra	L3562
5829  0f85               L1562:
5830                     ; 1019 	else umin_cnt=0;
5832  0f85 5f            	clrw	x
5833  0f86 bf63          	ldw	_umin_cnt,x
5834  0f88               L3562:
5835                     ; 1020 	gran(&umin_cnt,0,10);	
5837  0f88 ae000a        	ldw	x,#10
5838  0f8b 89            	pushw	x
5839  0f8c 5f            	clrw	x
5840  0f8d 89            	pushw	x
5841  0f8e ae0063        	ldw	x,#_umin_cnt
5842  0f91 cd00d1        	call	_gran
5844  0f94 5b04          	addw	sp,#4
5845                     ; 1021 	if(umin_cnt>=10)flags|=0b00010000;	  
5847  0f96 9c            	rvf
5848  0f97 be63          	ldw	x,_umin_cnt
5849  0f99 a3000a        	cpw	x,#10
5850  0f9c 2f04          	jrslt	L7362
5853  0f9e 7218000b      	bset	_flags,#4
5854  0fa2               L7362:
5855                     ; 1023 }
5858  0fa2 81            	ret
5885                     ; 1026 void x_drv(void)
5885                     ; 1027 {
5886                     	switch	.text
5887  0fa3               _x_drv:
5891                     ; 1028 if(_x__==_x_)
5893  0fa3 be5c          	ldw	x,__x__
5894  0fa5 b35e          	cpw	x,__x_
5895  0fa7 262a          	jrne	L7662
5896                     ; 1030 	if(_x_cnt<60)
5898  0fa9 9c            	rvf
5899  0faa be5a          	ldw	x,__x_cnt
5900  0fac a3003c        	cpw	x,#60
5901  0faf 2e25          	jrsge	L7762
5902                     ; 1032 		_x_cnt++;
5904  0fb1 be5a          	ldw	x,__x_cnt
5905  0fb3 1c0001        	addw	x,#1
5906  0fb6 bf5a          	ldw	__x_cnt,x
5907                     ; 1033 		if(_x_cnt>=60)
5909  0fb8 9c            	rvf
5910  0fb9 be5a          	ldw	x,__x_cnt
5911  0fbb a3003c        	cpw	x,#60
5912  0fbe 2f16          	jrslt	L7762
5913                     ; 1035 			if(_x_ee_!=_x_)_x_ee_=_x_;
5915  0fc0 ce0018        	ldw	x,__x_ee_
5916  0fc3 b35e          	cpw	x,__x_
5917  0fc5 270f          	jreq	L7762
5920  0fc7 be5e          	ldw	x,__x_
5921  0fc9 89            	pushw	x
5922  0fca ae0018        	ldw	x,#__x_ee_
5923  0fcd cd0000        	call	c_eewrw
5925  0fd0 85            	popw	x
5926  0fd1 2003          	jra	L7762
5927  0fd3               L7662:
5928                     ; 1040 else _x_cnt=0;
5930  0fd3 5f            	clrw	x
5931  0fd4 bf5a          	ldw	__x_cnt,x
5932  0fd6               L7762:
5933                     ; 1042 if(_x_cnt>60) _x_cnt=0;	
5935  0fd6 9c            	rvf
5936  0fd7 be5a          	ldw	x,__x_cnt
5937  0fd9 a3003d        	cpw	x,#61
5938  0fdc 2f03          	jrslt	L1072
5941  0fde 5f            	clrw	x
5942  0fdf bf5a          	ldw	__x_cnt,x
5943  0fe1               L1072:
5944                     ; 1044 _x__=_x_;
5946  0fe1 be5e          	ldw	x,__x_
5947  0fe3 bf5c          	ldw	__x__,x
5948                     ; 1045 }
5951  0fe5 81            	ret
5977                     ; 1048 void apv_start(void)
5977                     ; 1049 {
5978                     	switch	.text
5979  0fe6               _apv_start:
5983                     ; 1050 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5985  0fe6 3d45          	tnz	_apv_cnt
5986  0fe8 2624          	jrne	L3172
5988  0fea 3d46          	tnz	_apv_cnt+1
5989  0fec 2620          	jrne	L3172
5991  0fee 3d47          	tnz	_apv_cnt+2
5992  0ff0 261c          	jrne	L3172
5994                     	btst	_bAPV
5995  0ff7 2515          	jrult	L3172
5996                     ; 1052 	apv_cnt[0]=60;
5998  0ff9 353c0045      	mov	_apv_cnt,#60
5999                     ; 1053 	apv_cnt[1]=60;
6001  0ffd 353c0046      	mov	_apv_cnt+1,#60
6002                     ; 1054 	apv_cnt[2]=60;
6004  1001 353c0047      	mov	_apv_cnt+2,#60
6005                     ; 1055 	apv_cnt_=3600;
6007  1005 ae0e10        	ldw	x,#3600
6008  1008 bf43          	ldw	_apv_cnt_,x
6009                     ; 1056 	bAPV=1;	
6011  100a 72100002      	bset	_bAPV
6012  100e               L3172:
6013                     ; 1058 }
6016  100e 81            	ret
6042                     ; 1061 void apv_stop(void)
6042                     ; 1062 {
6043                     	switch	.text
6044  100f               _apv_stop:
6048                     ; 1063 apv_cnt[0]=0;
6050  100f 3f45          	clr	_apv_cnt
6051                     ; 1064 apv_cnt[1]=0;
6053  1011 3f46          	clr	_apv_cnt+1
6054                     ; 1065 apv_cnt[2]=0;
6056  1013 3f47          	clr	_apv_cnt+2
6057                     ; 1066 apv_cnt_=0;	
6059  1015 5f            	clrw	x
6060  1016 bf43          	ldw	_apv_cnt_,x
6061                     ; 1067 bAPV=0;
6063  1018 72110002      	bres	_bAPV
6064                     ; 1068 }
6067  101c 81            	ret
6102                     ; 1072 void apv_hndl(void)
6102                     ; 1073 {
6103                     	switch	.text
6104  101d               _apv_hndl:
6108                     ; 1074 if(apv_cnt[0])
6110  101d 3d45          	tnz	_apv_cnt
6111  101f 271e          	jreq	L5372
6112                     ; 1076 	apv_cnt[0]--;
6114  1021 3a45          	dec	_apv_cnt
6115                     ; 1077 	if(apv_cnt[0]==0)
6117  1023 3d45          	tnz	_apv_cnt
6118  1025 265a          	jrne	L1472
6119                     ; 1079 		flags&=0b11100001;
6121  1027 b60b          	ld	a,_flags
6122  1029 a4e1          	and	a,#225
6123  102b b70b          	ld	_flags,a
6124                     ; 1080 		tsign_cnt=0;
6126  102d 5f            	clrw	x
6127  102e bf4d          	ldw	_tsign_cnt,x
6128                     ; 1081 		tmax_cnt=0;
6130  1030 5f            	clrw	x
6131  1031 bf4b          	ldw	_tmax_cnt,x
6132                     ; 1082 		umax_cnt=0;
6134  1033 5f            	clrw	x
6135  1034 bf65          	ldw	_umax_cnt,x
6136                     ; 1083 		umin_cnt=0;
6138  1036 5f            	clrw	x
6139  1037 bf63          	ldw	_umin_cnt,x
6140                     ; 1085 		led_drv_cnt=30;
6142  1039 351e001a      	mov	_led_drv_cnt,#30
6143  103d 2042          	jra	L1472
6144  103f               L5372:
6145                     ; 1088 else if(apv_cnt[1])
6147  103f 3d46          	tnz	_apv_cnt+1
6148  1041 271e          	jreq	L3472
6149                     ; 1090 	apv_cnt[1]--;
6151  1043 3a46          	dec	_apv_cnt+1
6152                     ; 1091 	if(apv_cnt[1]==0)
6154  1045 3d46          	tnz	_apv_cnt+1
6155  1047 2638          	jrne	L1472
6156                     ; 1093 		flags&=0b11100001;
6158  1049 b60b          	ld	a,_flags
6159  104b a4e1          	and	a,#225
6160  104d b70b          	ld	_flags,a
6161                     ; 1094 		tsign_cnt=0;
6163  104f 5f            	clrw	x
6164  1050 bf4d          	ldw	_tsign_cnt,x
6165                     ; 1095 		tmax_cnt=0;
6167  1052 5f            	clrw	x
6168  1053 bf4b          	ldw	_tmax_cnt,x
6169                     ; 1096 		umax_cnt=0;
6171  1055 5f            	clrw	x
6172  1056 bf65          	ldw	_umax_cnt,x
6173                     ; 1097 		umin_cnt=0;
6175  1058 5f            	clrw	x
6176  1059 bf63          	ldw	_umin_cnt,x
6177                     ; 1099 		led_drv_cnt=30;
6179  105b 351e001a      	mov	_led_drv_cnt,#30
6180  105f 2020          	jra	L1472
6181  1061               L3472:
6182                     ; 1102 else if(apv_cnt[2])
6184  1061 3d47          	tnz	_apv_cnt+2
6185  1063 271c          	jreq	L1472
6186                     ; 1104 	apv_cnt[2]--;
6188  1065 3a47          	dec	_apv_cnt+2
6189                     ; 1105 	if(apv_cnt[2]==0)
6191  1067 3d47          	tnz	_apv_cnt+2
6192  1069 2616          	jrne	L1472
6193                     ; 1107 		flags&=0b11100001;
6195  106b b60b          	ld	a,_flags
6196  106d a4e1          	and	a,#225
6197  106f b70b          	ld	_flags,a
6198                     ; 1108 		tsign_cnt=0;
6200  1071 5f            	clrw	x
6201  1072 bf4d          	ldw	_tsign_cnt,x
6202                     ; 1109 		tmax_cnt=0;
6204  1074 5f            	clrw	x
6205  1075 bf4b          	ldw	_tmax_cnt,x
6206                     ; 1110 		umax_cnt=0;
6208  1077 5f            	clrw	x
6209  1078 bf65          	ldw	_umax_cnt,x
6210                     ; 1111 		umin_cnt=0;          
6212  107a 5f            	clrw	x
6213  107b bf63          	ldw	_umin_cnt,x
6214                     ; 1113 		led_drv_cnt=30;
6216  107d 351e001a      	mov	_led_drv_cnt,#30
6217  1081               L1472:
6218                     ; 1117 if(apv_cnt_)
6220  1081 be43          	ldw	x,_apv_cnt_
6221  1083 2712          	jreq	L5572
6222                     ; 1119 	apv_cnt_--;
6224  1085 be43          	ldw	x,_apv_cnt_
6225  1087 1d0001        	subw	x,#1
6226  108a bf43          	ldw	_apv_cnt_,x
6227                     ; 1120 	if(apv_cnt_==0) 
6229  108c be43          	ldw	x,_apv_cnt_
6230  108e 2607          	jrne	L5572
6231                     ; 1122 		bAPV=0;
6233  1090 72110002      	bres	_bAPV
6234                     ; 1123 		apv_start();
6236  1094 cd0fe6        	call	_apv_start
6238  1097               L5572:
6239                     ; 1127 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6241  1097 be63          	ldw	x,_umin_cnt
6242  1099 261e          	jrne	L1672
6244  109b be65          	ldw	x,_umax_cnt
6245  109d 261a          	jrne	L1672
6247  109f c65005        	ld	a,20485
6248  10a2 a504          	bcp	a,#4
6249  10a4 2613          	jrne	L1672
6250                     ; 1129 	if(cnt_apv_off<20)
6252  10a6 b642          	ld	a,_cnt_apv_off
6253  10a8 a114          	cp	a,#20
6254  10aa 240f          	jruge	L7672
6255                     ; 1131 		cnt_apv_off++;
6257  10ac 3c42          	inc	_cnt_apv_off
6258                     ; 1132 		if(cnt_apv_off>=20)
6260  10ae b642          	ld	a,_cnt_apv_off
6261  10b0 a114          	cp	a,#20
6262  10b2 2507          	jrult	L7672
6263                     ; 1134 			apv_stop();
6265  10b4 cd100f        	call	_apv_stop
6267  10b7 2002          	jra	L7672
6268  10b9               L1672:
6269                     ; 1138 else cnt_apv_off=0;	
6271  10b9 3f42          	clr	_cnt_apv_off
6272  10bb               L7672:
6273                     ; 1140 }
6276  10bb 81            	ret
6279                     	switch	.ubsct
6280  0000               L1772_flags_old:
6281  0000 00            	ds.b	1
6317                     ; 1143 void flags_drv(void)
6317                     ; 1144 {
6318                     	switch	.text
6319  10bc               _flags_drv:
6323                     ; 1146 if(jp_mode!=jp3) 
6325  10bc b64a          	ld	a,_jp_mode
6326  10be a103          	cp	a,#3
6327  10c0 2723          	jreq	L1103
6328                     ; 1148 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6330  10c2 b60b          	ld	a,_flags
6331  10c4 a508          	bcp	a,#8
6332  10c6 2706          	jreq	L7103
6334  10c8 b600          	ld	a,L1772_flags_old
6335  10ca a508          	bcp	a,#8
6336  10cc 270c          	jreq	L5103
6337  10ce               L7103:
6339  10ce b60b          	ld	a,_flags
6340  10d0 a510          	bcp	a,#16
6341  10d2 2726          	jreq	L3203
6343  10d4 b600          	ld	a,L1772_flags_old
6344  10d6 a510          	bcp	a,#16
6345  10d8 2620          	jrne	L3203
6346  10da               L5103:
6347                     ; 1150     		if(link==OFF)apv_start();
6349  10da b662          	ld	a,_link
6350  10dc a1aa          	cp	a,#170
6351  10de 261a          	jrne	L3203
6354  10e0 cd0fe6        	call	_apv_start
6356  10e3 2015          	jra	L3203
6357  10e5               L1103:
6358                     ; 1153 else if(jp_mode==jp3) 
6360  10e5 b64a          	ld	a,_jp_mode
6361  10e7 a103          	cp	a,#3
6362  10e9 260f          	jrne	L3203
6363                     ; 1155 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6365  10eb b60b          	ld	a,_flags
6366  10ed a508          	bcp	a,#8
6367  10ef 2709          	jreq	L3203
6369  10f1 b600          	ld	a,L1772_flags_old
6370  10f3 a508          	bcp	a,#8
6371  10f5 2603          	jrne	L3203
6372                     ; 1157     		apv_start();
6374  10f7 cd0fe6        	call	_apv_start
6376  10fa               L3203:
6377                     ; 1160 flags_old=flags;
6379  10fa 450b00        	mov	L1772_flags_old,_flags
6380                     ; 1162 } 
6383  10fd 81            	ret
6418                     ; 1299 void adr_drv_v4(char in)
6418                     ; 1300 {
6419                     	switch	.text
6420  10fe               _adr_drv_v4:
6424                     ; 1301 if(adress!=in)adress=in;
6426  10fe c10005        	cp	a,_adress
6427  1101 2703          	jreq	L7403
6430  1103 c70005        	ld	_adress,a
6431  1106               L7403:
6432                     ; 1302 }
6435  1106 81            	ret
6464                     ; 1305 void adr_drv_v3(void)
6464                     ; 1306 {
6465                     	switch	.text
6466  1107               _adr_drv_v3:
6468  1107 88            	push	a
6469       00000001      OFST:	set	1
6472                     ; 1312 GPIOB->DDR&=~(1<<0);
6474  1108 72115007      	bres	20487,#0
6475                     ; 1313 GPIOB->CR1&=~(1<<0);
6477  110c 72115008      	bres	20488,#0
6478                     ; 1314 GPIOB->CR2&=~(1<<0);
6480  1110 72115009      	bres	20489,#0
6481                     ; 1315 ADC2->CR2=0x08;
6483  1114 35085402      	mov	21506,#8
6484                     ; 1316 ADC2->CR1=0x40;
6486  1118 35405401      	mov	21505,#64
6487                     ; 1317 ADC2->CSR=0x20+0;
6489  111c 35205400      	mov	21504,#32
6490                     ; 1318 ADC2->CR1|=1;
6492  1120 72105401      	bset	21505,#0
6493                     ; 1319 ADC2->CR1|=1;
6495  1124 72105401      	bset	21505,#0
6496                     ; 1320 adr_drv_stat=1;
6498  1128 35010008      	mov	_adr_drv_stat,#1
6499  112c               L1603:
6500                     ; 1321 while(adr_drv_stat==1);
6503  112c b608          	ld	a,_adr_drv_stat
6504  112e a101          	cp	a,#1
6505  1130 27fa          	jreq	L1603
6506                     ; 1323 GPIOB->DDR&=~(1<<1);
6508  1132 72135007      	bres	20487,#1
6509                     ; 1324 GPIOB->CR1&=~(1<<1);
6511  1136 72135008      	bres	20488,#1
6512                     ; 1325 GPIOB->CR2&=~(1<<1);
6514  113a 72135009      	bres	20489,#1
6515                     ; 1326 ADC2->CR2=0x08;
6517  113e 35085402      	mov	21506,#8
6518                     ; 1327 ADC2->CR1=0x40;
6520  1142 35405401      	mov	21505,#64
6521                     ; 1328 ADC2->CSR=0x20+1;
6523  1146 35215400      	mov	21504,#33
6524                     ; 1329 ADC2->CR1|=1;
6526  114a 72105401      	bset	21505,#0
6527                     ; 1330 ADC2->CR1|=1;
6529  114e 72105401      	bset	21505,#0
6530                     ; 1331 adr_drv_stat=3;
6532  1152 35030008      	mov	_adr_drv_stat,#3
6533  1156               L7603:
6534                     ; 1332 while(adr_drv_stat==3);
6537  1156 b608          	ld	a,_adr_drv_stat
6538  1158 a103          	cp	a,#3
6539  115a 27fa          	jreq	L7603
6540                     ; 1334 GPIOE->DDR&=~(1<<6);
6542  115c 721d5016      	bres	20502,#6
6543                     ; 1335 GPIOE->CR1&=~(1<<6);
6545  1160 721d5017      	bres	20503,#6
6546                     ; 1336 GPIOE->CR2&=~(1<<6);
6548  1164 721d5018      	bres	20504,#6
6549                     ; 1337 ADC2->CR2=0x08;
6551  1168 35085402      	mov	21506,#8
6552                     ; 1338 ADC2->CR1=0x40;
6554  116c 35405401      	mov	21505,#64
6555                     ; 1339 ADC2->CSR=0x20+9;
6557  1170 35295400      	mov	21504,#41
6558                     ; 1340 ADC2->CR1|=1;
6560  1174 72105401      	bset	21505,#0
6561                     ; 1341 ADC2->CR1|=1;
6563  1178 72105401      	bset	21505,#0
6564                     ; 1342 adr_drv_stat=5;
6566  117c 35050008      	mov	_adr_drv_stat,#5
6567  1180               L5703:
6568                     ; 1343 while(adr_drv_stat==5);
6571  1180 b608          	ld	a,_adr_drv_stat
6572  1182 a105          	cp	a,#5
6573  1184 27fa          	jreq	L5703
6574                     ; 1347 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6576  1186 9c            	rvf
6577  1187 ce0009        	ldw	x,_adc_buff_
6578  118a a3022a        	cpw	x,#554
6579  118d 2f0f          	jrslt	L3013
6581  118f 9c            	rvf
6582  1190 ce0009        	ldw	x,_adc_buff_
6583  1193 a30253        	cpw	x,#595
6584  1196 2e06          	jrsge	L3013
6587  1198 725f0006      	clr	_adr
6589  119c 204c          	jra	L5013
6590  119e               L3013:
6591                     ; 1348 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6593  119e 9c            	rvf
6594  119f ce0009        	ldw	x,_adc_buff_
6595  11a2 a3036d        	cpw	x,#877
6596  11a5 2f0f          	jrslt	L7013
6598  11a7 9c            	rvf
6599  11a8 ce0009        	ldw	x,_adc_buff_
6600  11ab a30396        	cpw	x,#918
6601  11ae 2e06          	jrsge	L7013
6604  11b0 35010006      	mov	_adr,#1
6606  11b4 2034          	jra	L5013
6607  11b6               L7013:
6608                     ; 1349 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6610  11b6 9c            	rvf
6611  11b7 ce0009        	ldw	x,_adc_buff_
6612  11ba a302a3        	cpw	x,#675
6613  11bd 2f0f          	jrslt	L3113
6615  11bf 9c            	rvf
6616  11c0 ce0009        	ldw	x,_adc_buff_
6617  11c3 a302cc        	cpw	x,#716
6618  11c6 2e06          	jrsge	L3113
6621  11c8 35020006      	mov	_adr,#2
6623  11cc 201c          	jra	L5013
6624  11ce               L3113:
6625                     ; 1350 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6627  11ce 9c            	rvf
6628  11cf ce0009        	ldw	x,_adc_buff_
6629  11d2 a303e3        	cpw	x,#995
6630  11d5 2f0f          	jrslt	L7113
6632  11d7 9c            	rvf
6633  11d8 ce0009        	ldw	x,_adc_buff_
6634  11db a3040c        	cpw	x,#1036
6635  11de 2e06          	jrsge	L7113
6638  11e0 35030006      	mov	_adr,#3
6640  11e4 2004          	jra	L5013
6641  11e6               L7113:
6642                     ; 1351 else adr[0]=5;
6644  11e6 35050006      	mov	_adr,#5
6645  11ea               L5013:
6646                     ; 1353 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6648  11ea 9c            	rvf
6649  11eb ce000b        	ldw	x,_adc_buff_+2
6650  11ee a3022a        	cpw	x,#554
6651  11f1 2f0f          	jrslt	L3213
6653  11f3 9c            	rvf
6654  11f4 ce000b        	ldw	x,_adc_buff_+2
6655  11f7 a30253        	cpw	x,#595
6656  11fa 2e06          	jrsge	L3213
6659  11fc 725f0007      	clr	_adr+1
6661  1200 204c          	jra	L5213
6662  1202               L3213:
6663                     ; 1354 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6665  1202 9c            	rvf
6666  1203 ce000b        	ldw	x,_adc_buff_+2
6667  1206 a3036d        	cpw	x,#877
6668  1209 2f0f          	jrslt	L7213
6670  120b 9c            	rvf
6671  120c ce000b        	ldw	x,_adc_buff_+2
6672  120f a30396        	cpw	x,#918
6673  1212 2e06          	jrsge	L7213
6676  1214 35010007      	mov	_adr+1,#1
6678  1218 2034          	jra	L5213
6679  121a               L7213:
6680                     ; 1355 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6682  121a 9c            	rvf
6683  121b ce000b        	ldw	x,_adc_buff_+2
6684  121e a302a3        	cpw	x,#675
6685  1221 2f0f          	jrslt	L3313
6687  1223 9c            	rvf
6688  1224 ce000b        	ldw	x,_adc_buff_+2
6689  1227 a302cc        	cpw	x,#716
6690  122a 2e06          	jrsge	L3313
6693  122c 35020007      	mov	_adr+1,#2
6695  1230 201c          	jra	L5213
6696  1232               L3313:
6697                     ; 1356 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6699  1232 9c            	rvf
6700  1233 ce000b        	ldw	x,_adc_buff_+2
6701  1236 a303e3        	cpw	x,#995
6702  1239 2f0f          	jrslt	L7313
6704  123b 9c            	rvf
6705  123c ce000b        	ldw	x,_adc_buff_+2
6706  123f a3040c        	cpw	x,#1036
6707  1242 2e06          	jrsge	L7313
6710  1244 35030007      	mov	_adr+1,#3
6712  1248 2004          	jra	L5213
6713  124a               L7313:
6714                     ; 1357 else adr[1]=5;
6716  124a 35050007      	mov	_adr+1,#5
6717  124e               L5213:
6718                     ; 1359 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6720  124e 9c            	rvf
6721  124f ce001b        	ldw	x,_adc_buff_+18
6722  1252 a3022a        	cpw	x,#554
6723  1255 2f0f          	jrslt	L3413
6725  1257 9c            	rvf
6726  1258 ce001b        	ldw	x,_adc_buff_+18
6727  125b a30253        	cpw	x,#595
6728  125e 2e06          	jrsge	L3413
6731  1260 725f0008      	clr	_adr+2
6733  1264 204c          	jra	L5413
6734  1266               L3413:
6735                     ; 1360 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6737  1266 9c            	rvf
6738  1267 ce001b        	ldw	x,_adc_buff_+18
6739  126a a3036d        	cpw	x,#877
6740  126d 2f0f          	jrslt	L7413
6742  126f 9c            	rvf
6743  1270 ce001b        	ldw	x,_adc_buff_+18
6744  1273 a30396        	cpw	x,#918
6745  1276 2e06          	jrsge	L7413
6748  1278 35010008      	mov	_adr+2,#1
6750  127c 2034          	jra	L5413
6751  127e               L7413:
6752                     ; 1361 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6754  127e 9c            	rvf
6755  127f ce001b        	ldw	x,_adc_buff_+18
6756  1282 a302a3        	cpw	x,#675
6757  1285 2f0f          	jrslt	L3513
6759  1287 9c            	rvf
6760  1288 ce001b        	ldw	x,_adc_buff_+18
6761  128b a302cc        	cpw	x,#716
6762  128e 2e06          	jrsge	L3513
6765  1290 35020008      	mov	_adr+2,#2
6767  1294 201c          	jra	L5413
6768  1296               L3513:
6769                     ; 1362 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6771  1296 9c            	rvf
6772  1297 ce001b        	ldw	x,_adc_buff_+18
6773  129a a303e3        	cpw	x,#995
6774  129d 2f0f          	jrslt	L7513
6776  129f 9c            	rvf
6777  12a0 ce001b        	ldw	x,_adc_buff_+18
6778  12a3 a3040c        	cpw	x,#1036
6779  12a6 2e06          	jrsge	L7513
6782  12a8 35030008      	mov	_adr+2,#3
6784  12ac 2004          	jra	L5413
6785  12ae               L7513:
6786                     ; 1363 else adr[2]=5;
6788  12ae 35050008      	mov	_adr+2,#5
6789  12b2               L5413:
6790                     ; 1367 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6792  12b2 c60006        	ld	a,_adr
6793  12b5 a105          	cp	a,#5
6794  12b7 270e          	jreq	L5613
6796  12b9 c60007        	ld	a,_adr+1
6797  12bc a105          	cp	a,#5
6798  12be 2707          	jreq	L5613
6800  12c0 c60008        	ld	a,_adr+2
6801  12c3 a105          	cp	a,#5
6802  12c5 2606          	jrne	L3613
6803  12c7               L5613:
6804                     ; 1370 	adress_error=1;
6806  12c7 35010004      	mov	_adress_error,#1
6808  12cb               L1713:
6809                     ; 1381 }
6812  12cb 84            	pop	a
6813  12cc 81            	ret
6814  12cd               L3613:
6815                     ; 1374 	if(adr[2]&0x02) bps_class=bpsIPS;
6817  12cd c60008        	ld	a,_adr+2
6818  12d0 a502          	bcp	a,#2
6819  12d2 2706          	jreq	L3713
6822  12d4 35010004      	mov	_bps_class,#1
6824  12d8 2002          	jra	L5713
6825  12da               L3713:
6826                     ; 1375 	else bps_class=bpsIBEP;
6828  12da 3f04          	clr	_bps_class
6829  12dc               L5713:
6830                     ; 1377 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6832  12dc c60008        	ld	a,_adr+2
6833  12df a401          	and	a,#1
6834  12e1 97            	ld	xl,a
6835  12e2 a610          	ld	a,#16
6836  12e4 42            	mul	x,a
6837  12e5 9f            	ld	a,xl
6838  12e6 6b01          	ld	(OFST+0,sp),a
6839  12e8 c60007        	ld	a,_adr+1
6840  12eb 48            	sll	a
6841  12ec 48            	sll	a
6842  12ed cb0006        	add	a,_adr
6843  12f0 1b01          	add	a,(OFST+0,sp)
6844  12f2 c70005        	ld	_adress,a
6845  12f5 20d4          	jra	L1713
6889                     ; 1384 void volum_u_main_drv(void)
6889                     ; 1385 {
6890                     	switch	.text
6891  12f7               _volum_u_main_drv:
6893  12f7 88            	push	a
6894       00000001      OFST:	set	1
6897                     ; 1388 if(bMAIN)
6899                     	btst	_bMAIN
6900  12fd 2503          	jrult	L431
6901  12ff cc1448        	jp	L5123
6902  1302               L431:
6903                     ; 1390 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6905  1302 9c            	rvf
6906  1303 ce0008        	ldw	x,_UU_AVT
6907  1306 1d000a        	subw	x,#10
6908  1309 b36c          	cpw	x,_Un
6909  130b 2d09          	jrsle	L7123
6912  130d be1d          	ldw	x,_volum_u_main_
6913  130f 1c0005        	addw	x,#5
6914  1312 bf1d          	ldw	_volum_u_main_,x
6916  1314 2036          	jra	L1223
6917  1316               L7123:
6918                     ; 1391 	else if(Un<(UU_AVT-1))volum_u_main_++;
6920  1316 9c            	rvf
6921  1317 ce0008        	ldw	x,_UU_AVT
6922  131a 5a            	decw	x
6923  131b b36c          	cpw	x,_Un
6924  131d 2d09          	jrsle	L3223
6927  131f be1d          	ldw	x,_volum_u_main_
6928  1321 1c0001        	addw	x,#1
6929  1324 bf1d          	ldw	_volum_u_main_,x
6931  1326 2024          	jra	L1223
6932  1328               L3223:
6933                     ; 1392 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
6935  1328 9c            	rvf
6936  1329 ce0008        	ldw	x,_UU_AVT
6937  132c 1c000a        	addw	x,#10
6938  132f b36c          	cpw	x,_Un
6939  1331 2e09          	jrsge	L7223
6942  1333 be1d          	ldw	x,_volum_u_main_
6943  1335 1d000a        	subw	x,#10
6944  1338 bf1d          	ldw	_volum_u_main_,x
6946  133a 2010          	jra	L1223
6947  133c               L7223:
6948                     ; 1393 	else if(Un>(UU_AVT+1))volum_u_main_--;
6950  133c 9c            	rvf
6951  133d ce0008        	ldw	x,_UU_AVT
6952  1340 5c            	incw	x
6953  1341 b36c          	cpw	x,_Un
6954  1343 2e07          	jrsge	L1223
6957  1345 be1d          	ldw	x,_volum_u_main_
6958  1347 1d0001        	subw	x,#1
6959  134a bf1d          	ldw	_volum_u_main_,x
6960  134c               L1223:
6961                     ; 1394 	if(volum_u_main_>1020)volum_u_main_=1020;
6963  134c 9c            	rvf
6964  134d be1d          	ldw	x,_volum_u_main_
6965  134f a303fd        	cpw	x,#1021
6966  1352 2f05          	jrslt	L5323
6969  1354 ae03fc        	ldw	x,#1020
6970  1357 bf1d          	ldw	_volum_u_main_,x
6971  1359               L5323:
6972                     ; 1395 	if(volum_u_main_<0)volum_u_main_=0;
6974  1359 9c            	rvf
6975  135a be1d          	ldw	x,_volum_u_main_
6976  135c 2e03          	jrsge	L7323
6979  135e 5f            	clrw	x
6980  135f bf1d          	ldw	_volum_u_main_,x
6981  1361               L7323:
6982                     ; 1398 	i_main_sigma=0;
6984  1361 5f            	clrw	x
6985  1362 bf0f          	ldw	_i_main_sigma,x
6986                     ; 1399 	i_main_num_of_bps=0;
6988  1364 3f11          	clr	_i_main_num_of_bps
6989                     ; 1400 	for(i=0;i<6;i++)
6991  1366 0f01          	clr	(OFST+0,sp)
6992  1368               L1423:
6993                     ; 1402 		if(i_main_flag[i])
6995  1368 7b01          	ld	a,(OFST+0,sp)
6996  136a 5f            	clrw	x
6997  136b 97            	ld	xl,a
6998  136c 6d14          	tnz	(_i_main_flag,x)
6999  136e 2719          	jreq	L7423
7000                     ; 1404 			i_main_sigma+=i_main[i];
7002  1370 7b01          	ld	a,(OFST+0,sp)
7003  1372 5f            	clrw	x
7004  1373 97            	ld	xl,a
7005  1374 58            	sllw	x
7006  1375 ee1a          	ldw	x,(_i_main,x)
7007  1377 72bb000f      	addw	x,_i_main_sigma
7008  137b bf0f          	ldw	_i_main_sigma,x
7009                     ; 1405 			i_main_flag[i]=1;
7011  137d 7b01          	ld	a,(OFST+0,sp)
7012  137f 5f            	clrw	x
7013  1380 97            	ld	xl,a
7014  1381 a601          	ld	a,#1
7015  1383 e714          	ld	(_i_main_flag,x),a
7016                     ; 1406 			i_main_num_of_bps++;
7018  1385 3c11          	inc	_i_main_num_of_bps
7020  1387 2006          	jra	L1523
7021  1389               L7423:
7022                     ; 1410 			i_main_flag[i]=0;	
7024  1389 7b01          	ld	a,(OFST+0,sp)
7025  138b 5f            	clrw	x
7026  138c 97            	ld	xl,a
7027  138d 6f14          	clr	(_i_main_flag,x)
7028  138f               L1523:
7029                     ; 1400 	for(i=0;i<6;i++)
7031  138f 0c01          	inc	(OFST+0,sp)
7034  1391 7b01          	ld	a,(OFST+0,sp)
7035  1393 a106          	cp	a,#6
7036  1395 25d1          	jrult	L1423
7037                     ; 1413 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7039  1397 be0f          	ldw	x,_i_main_sigma
7040  1399 b611          	ld	a,_i_main_num_of_bps
7041  139b 905f          	clrw	y
7042  139d 9097          	ld	yl,a
7043  139f cd0000        	call	c_idiv
7045  13a2 bf12          	ldw	_i_main_avg,x
7046                     ; 1414 	for(i=0;i<6;i++)
7048  13a4 0f01          	clr	(OFST+0,sp)
7049  13a6               L3523:
7050                     ; 1416 		if(i_main_flag[i])
7052  13a6 7b01          	ld	a,(OFST+0,sp)
7053  13a8 5f            	clrw	x
7054  13a9 97            	ld	xl,a
7055  13aa 6d14          	tnz	(_i_main_flag,x)
7056  13ac 2603cc143d    	jreq	L1623
7057                     ; 1418 			if(i_main[i]<(i_main_avg-10))x[i]++;
7059  13b1 9c            	rvf
7060  13b2 7b01          	ld	a,(OFST+0,sp)
7061  13b4 5f            	clrw	x
7062  13b5 97            	ld	xl,a
7063  13b6 58            	sllw	x
7064  13b7 90be12        	ldw	y,_i_main_avg
7065  13ba 72a2000a      	subw	y,#10
7066  13be 90bf00        	ldw	c_y,y
7067  13c1 9093          	ldw	y,x
7068  13c3 90ee1a        	ldw	y,(_i_main,y)
7069  13c6 90b300        	cpw	y,c_y
7070  13c9 2e11          	jrsge	L3623
7073  13cb 7b01          	ld	a,(OFST+0,sp)
7074  13cd 5f            	clrw	x
7075  13ce 97            	ld	xl,a
7076  13cf 58            	sllw	x
7077  13d0 9093          	ldw	y,x
7078  13d2 ee26          	ldw	x,(_x,x)
7079  13d4 1c0001        	addw	x,#1
7080  13d7 90ef26        	ldw	(_x,y),x
7082  13da 2029          	jra	L5623
7083  13dc               L3623:
7084                     ; 1419 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7086  13dc 9c            	rvf
7087  13dd 7b01          	ld	a,(OFST+0,sp)
7088  13df 5f            	clrw	x
7089  13e0 97            	ld	xl,a
7090  13e1 58            	sllw	x
7091  13e2 90be12        	ldw	y,_i_main_avg
7092  13e5 72a9000a      	addw	y,#10
7093  13e9 90bf00        	ldw	c_y,y
7094  13ec 9093          	ldw	y,x
7095  13ee 90ee1a        	ldw	y,(_i_main,y)
7096  13f1 90b300        	cpw	y,c_y
7097  13f4 2d0f          	jrsle	L5623
7100  13f6 7b01          	ld	a,(OFST+0,sp)
7101  13f8 5f            	clrw	x
7102  13f9 97            	ld	xl,a
7103  13fa 58            	sllw	x
7104  13fb 9093          	ldw	y,x
7105  13fd ee26          	ldw	x,(_x,x)
7106  13ff 1d0001        	subw	x,#1
7107  1402 90ef26        	ldw	(_x,y),x
7108  1405               L5623:
7109                     ; 1420 			if(x[i]>100)x[i]=100;
7111  1405 9c            	rvf
7112  1406 7b01          	ld	a,(OFST+0,sp)
7113  1408 5f            	clrw	x
7114  1409 97            	ld	xl,a
7115  140a 58            	sllw	x
7116  140b 9093          	ldw	y,x
7117  140d 90ee26        	ldw	y,(_x,y)
7118  1410 90a30065      	cpw	y,#101
7119  1414 2f0b          	jrslt	L1723
7122  1416 7b01          	ld	a,(OFST+0,sp)
7123  1418 5f            	clrw	x
7124  1419 97            	ld	xl,a
7125  141a 58            	sllw	x
7126  141b 90ae0064      	ldw	y,#100
7127  141f ef26          	ldw	(_x,x),y
7128  1421               L1723:
7129                     ; 1421 			if(x[i]<-100)x[i]=-100;
7131  1421 9c            	rvf
7132  1422 7b01          	ld	a,(OFST+0,sp)
7133  1424 5f            	clrw	x
7134  1425 97            	ld	xl,a
7135  1426 58            	sllw	x
7136  1427 9093          	ldw	y,x
7137  1429 90ee26        	ldw	y,(_x,y)
7138  142c 90a3ff9c      	cpw	y,#65436
7139  1430 2e0b          	jrsge	L1623
7142  1432 7b01          	ld	a,(OFST+0,sp)
7143  1434 5f            	clrw	x
7144  1435 97            	ld	xl,a
7145  1436 58            	sllw	x
7146  1437 90aeff9c      	ldw	y,#65436
7147  143b ef26          	ldw	(_x,x),y
7148  143d               L1623:
7149                     ; 1414 	for(i=0;i<6;i++)
7151  143d 0c01          	inc	(OFST+0,sp)
7154  143f 7b01          	ld	a,(OFST+0,sp)
7155  1441 a106          	cp	a,#6
7156  1443 2403cc13a6    	jrult	L3523
7157  1448               L5123:
7158                     ; 1428 }
7161  1448 84            	pop	a
7162  1449 81            	ret
7185                     ; 1431 void init_CAN(void) {
7186                     	switch	.text
7187  144a               _init_CAN:
7191                     ; 1432 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7193  144a 72135420      	bres	21536,#1
7194                     ; 1433 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7196  144e 72105420      	bset	21536,#0
7198  1452               L7033:
7199                     ; 1434 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7201  1452 c65421        	ld	a,21537
7202  1455 a501          	bcp	a,#1
7203  1457 27f9          	jreq	L7033
7204                     ; 1436 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7206  1459 72185420      	bset	21536,#4
7207                     ; 1438 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7209  145d 35025427      	mov	21543,#2
7210                     ; 1447 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7212  1461 35135428      	mov	21544,#19
7213                     ; 1448 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7215  1465 35c05429      	mov	21545,#192
7216                     ; 1449 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7218  1469 357f542c      	mov	21548,#127
7219                     ; 1450 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7221  146d 35e0542d      	mov	21549,#224
7222                     ; 1452 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7224  1471 35315430      	mov	21552,#49
7225                     ; 1453 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7227  1475 35c05431      	mov	21553,#192
7228                     ; 1454 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7230  1479 357f5434      	mov	21556,#127
7231                     ; 1455 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7233  147d 35e05435      	mov	21557,#224
7234                     ; 1459 	CAN->PSR= 6;									// set page 6
7236  1481 35065427      	mov	21543,#6
7237                     ; 1464 	CAN->Page.Config.FMR1&=~3;								//mask mode
7239  1485 c65430        	ld	a,21552
7240  1488 a4fc          	and	a,#252
7241  148a c75430        	ld	21552,a
7242                     ; 1470 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7244  148d 35065432      	mov	21554,#6
7245                     ; 1471 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7247  1491 35605432      	mov	21554,#96
7248                     ; 1474 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7250  1495 72105432      	bset	21554,#0
7251                     ; 1475 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7253  1499 72185432      	bset	21554,#4
7254                     ; 1478 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7256  149d 35065427      	mov	21543,#6
7257                     ; 1480 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7259  14a1 3509542c      	mov	21548,#9
7260                     ; 1481 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7262  14a5 35e7542d      	mov	21549,#231
7263                     ; 1483 	CAN->IER|=(1<<1);
7265  14a9 72125425      	bset	21541,#1
7266                     ; 1486 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7268  14ad 72115420      	bres	21536,#0
7270  14b1               L5133:
7271                     ; 1487 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7273  14b1 c65421        	ld	a,21537
7274  14b4 a501          	bcp	a,#1
7275  14b6 26f9          	jrne	L5133
7276                     ; 1488 }
7279  14b8 81            	ret
7387                     ; 1491 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7387                     ; 1492 {
7388                     	switch	.text
7389  14b9               _can_transmit:
7391  14b9 89            	pushw	x
7392       00000000      OFST:	set	0
7395                     ; 1494 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7397  14ba b673          	ld	a,_can_buff_wr_ptr
7398  14bc a104          	cp	a,#4
7399  14be 2502          	jrult	L7733
7402  14c0 3f73          	clr	_can_buff_wr_ptr
7403  14c2               L7733:
7404                     ; 1496 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7406  14c2 b673          	ld	a,_can_buff_wr_ptr
7407  14c4 97            	ld	xl,a
7408  14c5 a610          	ld	a,#16
7409  14c7 42            	mul	x,a
7410  14c8 1601          	ldw	y,(OFST+1,sp)
7411  14ca a606          	ld	a,#6
7412  14cc               L241:
7413  14cc 9054          	srlw	y
7414  14ce 4a            	dec	a
7415  14cf 26fb          	jrne	L241
7416  14d1 909f          	ld	a,yl
7417  14d3 e774          	ld	(_can_out_buff,x),a
7418                     ; 1497 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7420  14d5 b673          	ld	a,_can_buff_wr_ptr
7421  14d7 97            	ld	xl,a
7422  14d8 a610          	ld	a,#16
7423  14da 42            	mul	x,a
7424  14db 7b02          	ld	a,(OFST+2,sp)
7425  14dd 48            	sll	a
7426  14de 48            	sll	a
7427  14df e775          	ld	(_can_out_buff+1,x),a
7428                     ; 1499 can_out_buff[can_buff_wr_ptr][2]=data0;
7430  14e1 b673          	ld	a,_can_buff_wr_ptr
7431  14e3 97            	ld	xl,a
7432  14e4 a610          	ld	a,#16
7433  14e6 42            	mul	x,a
7434  14e7 7b05          	ld	a,(OFST+5,sp)
7435  14e9 e776          	ld	(_can_out_buff+2,x),a
7436                     ; 1500 can_out_buff[can_buff_wr_ptr][3]=data1;
7438  14eb b673          	ld	a,_can_buff_wr_ptr
7439  14ed 97            	ld	xl,a
7440  14ee a610          	ld	a,#16
7441  14f0 42            	mul	x,a
7442  14f1 7b06          	ld	a,(OFST+6,sp)
7443  14f3 e777          	ld	(_can_out_buff+3,x),a
7444                     ; 1501 can_out_buff[can_buff_wr_ptr][4]=data2;
7446  14f5 b673          	ld	a,_can_buff_wr_ptr
7447  14f7 97            	ld	xl,a
7448  14f8 a610          	ld	a,#16
7449  14fa 42            	mul	x,a
7450  14fb 7b07          	ld	a,(OFST+7,sp)
7451  14fd e778          	ld	(_can_out_buff+4,x),a
7452                     ; 1502 can_out_buff[can_buff_wr_ptr][5]=data3;
7454  14ff b673          	ld	a,_can_buff_wr_ptr
7455  1501 97            	ld	xl,a
7456  1502 a610          	ld	a,#16
7457  1504 42            	mul	x,a
7458  1505 7b08          	ld	a,(OFST+8,sp)
7459  1507 e779          	ld	(_can_out_buff+5,x),a
7460                     ; 1503 can_out_buff[can_buff_wr_ptr][6]=data4;
7462  1509 b673          	ld	a,_can_buff_wr_ptr
7463  150b 97            	ld	xl,a
7464  150c a610          	ld	a,#16
7465  150e 42            	mul	x,a
7466  150f 7b09          	ld	a,(OFST+9,sp)
7467  1511 e77a          	ld	(_can_out_buff+6,x),a
7468                     ; 1504 can_out_buff[can_buff_wr_ptr][7]=data5;
7470  1513 b673          	ld	a,_can_buff_wr_ptr
7471  1515 97            	ld	xl,a
7472  1516 a610          	ld	a,#16
7473  1518 42            	mul	x,a
7474  1519 7b0a          	ld	a,(OFST+10,sp)
7475  151b e77b          	ld	(_can_out_buff+7,x),a
7476                     ; 1505 can_out_buff[can_buff_wr_ptr][8]=data6;
7478  151d b673          	ld	a,_can_buff_wr_ptr
7479  151f 97            	ld	xl,a
7480  1520 a610          	ld	a,#16
7481  1522 42            	mul	x,a
7482  1523 7b0b          	ld	a,(OFST+11,sp)
7483  1525 e77c          	ld	(_can_out_buff+8,x),a
7484                     ; 1506 can_out_buff[can_buff_wr_ptr][9]=data7;
7486  1527 b673          	ld	a,_can_buff_wr_ptr
7487  1529 97            	ld	xl,a
7488  152a a610          	ld	a,#16
7489  152c 42            	mul	x,a
7490  152d 7b0c          	ld	a,(OFST+12,sp)
7491  152f e77d          	ld	(_can_out_buff+9,x),a
7492                     ; 1508 can_buff_wr_ptr++;
7494  1531 3c73          	inc	_can_buff_wr_ptr
7495                     ; 1509 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7497  1533 b673          	ld	a,_can_buff_wr_ptr
7498  1535 a104          	cp	a,#4
7499  1537 2502          	jrult	L1043
7502  1539 3f73          	clr	_can_buff_wr_ptr
7503  153b               L1043:
7504                     ; 1510 } 
7507  153b 85            	popw	x
7508  153c 81            	ret
7537                     ; 1513 void can_tx_hndl(void)
7537                     ; 1514 {
7538                     	switch	.text
7539  153d               _can_tx_hndl:
7543                     ; 1515 if(bTX_FREE)
7545  153d 3d09          	tnz	_bTX_FREE
7546  153f 2757          	jreq	L3143
7547                     ; 1517 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7549  1541 b672          	ld	a,_can_buff_rd_ptr
7550  1543 b173          	cp	a,_can_buff_wr_ptr
7551  1545 275f          	jreq	L1243
7552                     ; 1519 		bTX_FREE=0;
7554  1547 3f09          	clr	_bTX_FREE
7555                     ; 1521 		CAN->PSR= 0;
7557  1549 725f5427      	clr	21543
7558                     ; 1522 		CAN->Page.TxMailbox.MDLCR=8;
7560  154d 35085429      	mov	21545,#8
7561                     ; 1523 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7563  1551 b672          	ld	a,_can_buff_rd_ptr
7564  1553 97            	ld	xl,a
7565  1554 a610          	ld	a,#16
7566  1556 42            	mul	x,a
7567  1557 e674          	ld	a,(_can_out_buff,x)
7568  1559 c7542a        	ld	21546,a
7569                     ; 1524 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7571  155c b672          	ld	a,_can_buff_rd_ptr
7572  155e 97            	ld	xl,a
7573  155f a610          	ld	a,#16
7574  1561 42            	mul	x,a
7575  1562 e675          	ld	a,(_can_out_buff+1,x)
7576  1564 c7542b        	ld	21547,a
7577                     ; 1526 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7579  1567 b672          	ld	a,_can_buff_rd_ptr
7580  1569 97            	ld	xl,a
7581  156a a610          	ld	a,#16
7582  156c 42            	mul	x,a
7583  156d 01            	rrwa	x,a
7584  156e ab76          	add	a,#_can_out_buff+2
7585  1570 2401          	jrnc	L641
7586  1572 5c            	incw	x
7587  1573               L641:
7588  1573 5f            	clrw	x
7589  1574 97            	ld	xl,a
7590  1575 bf00          	ldw	c_x,x
7591  1577 ae0008        	ldw	x,#8
7592  157a               L051:
7593  157a 5a            	decw	x
7594  157b 92d600        	ld	a,([c_x],x)
7595  157e d7542e        	ld	(21550,x),a
7596  1581 5d            	tnzw	x
7597  1582 26f6          	jrne	L051
7598                     ; 1528 		can_buff_rd_ptr++;
7600  1584 3c72          	inc	_can_buff_rd_ptr
7601                     ; 1529 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7603  1586 b672          	ld	a,_can_buff_rd_ptr
7604  1588 a104          	cp	a,#4
7605  158a 2502          	jrult	L7143
7608  158c 3f72          	clr	_can_buff_rd_ptr
7609  158e               L7143:
7610                     ; 1531 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7612  158e 72105428      	bset	21544,#0
7613                     ; 1532 		CAN->IER|=(1<<0);
7615  1592 72105425      	bset	21541,#0
7616  1596 200e          	jra	L1243
7617  1598               L3143:
7618                     ; 1537 	tx_busy_cnt++;
7620  1598 3c71          	inc	_tx_busy_cnt
7621                     ; 1538 	if(tx_busy_cnt>=100)
7623  159a b671          	ld	a,_tx_busy_cnt
7624  159c a164          	cp	a,#100
7625  159e 2506          	jrult	L1243
7626                     ; 1540 		tx_busy_cnt=0;
7628  15a0 3f71          	clr	_tx_busy_cnt
7629                     ; 1541 		bTX_FREE=1;
7631  15a2 35010009      	mov	_bTX_FREE,#1
7632  15a6               L1243:
7633                     ; 1544 }
7636  15a6 81            	ret
7675                     ; 1547 void net_drv(void)
7675                     ; 1548 { 
7676                     	switch	.text
7677  15a7               _net_drv:
7681                     ; 1550 if(bMAIN)
7683                     	btst	_bMAIN
7684  15ac 2503          	jrult	L451
7685  15ae cc1654        	jp	L5343
7686  15b1               L451:
7687                     ; 1552 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7689  15b1 3c32          	inc	_cnt_net_drv
7690  15b3 b632          	ld	a,_cnt_net_drv
7691  15b5 a107          	cp	a,#7
7692  15b7 2502          	jrult	L7343
7695  15b9 3f32          	clr	_cnt_net_drv
7696  15bb               L7343:
7697                     ; 1554 	if(cnt_net_drv<=5) 
7699  15bb b632          	ld	a,_cnt_net_drv
7700  15bd a106          	cp	a,#6
7701  15bf 244c          	jruge	L1443
7702                     ; 1556 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7704  15c1 4be8          	push	#232
7705  15c3 4be8          	push	#232
7706  15c5 b632          	ld	a,_cnt_net_drv
7707  15c7 5f            	clrw	x
7708  15c8 97            	ld	xl,a
7709  15c9 58            	sllw	x
7710  15ca ee26          	ldw	x,(_x,x)
7711  15cc 72bb001d      	addw	x,_volum_u_main_
7712  15d0 90ae0100      	ldw	y,#256
7713  15d4 cd0000        	call	c_idiv
7715  15d7 9f            	ld	a,xl
7716  15d8 88            	push	a
7717  15d9 b632          	ld	a,_cnt_net_drv
7718  15db 5f            	clrw	x
7719  15dc 97            	ld	xl,a
7720  15dd 58            	sllw	x
7721  15de e627          	ld	a,(_x+1,x)
7722  15e0 bb1e          	add	a,_volum_u_main_+1
7723  15e2 88            	push	a
7724  15e3 4b00          	push	#0
7725  15e5 4bed          	push	#237
7726  15e7 3b0032        	push	_cnt_net_drv
7727  15ea 3b0032        	push	_cnt_net_drv
7728  15ed ae009e        	ldw	x,#158
7729  15f0 cd14b9        	call	_can_transmit
7731  15f3 5b08          	addw	sp,#8
7732                     ; 1557 		i_main_bps_cnt[cnt_net_drv]++;
7734  15f5 b632          	ld	a,_cnt_net_drv
7735  15f7 5f            	clrw	x
7736  15f8 97            	ld	xl,a
7737  15f9 6c09          	inc	(_i_main_bps_cnt,x)
7738                     ; 1558 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7740  15fb b632          	ld	a,_cnt_net_drv
7741  15fd 5f            	clrw	x
7742  15fe 97            	ld	xl,a
7743  15ff e609          	ld	a,(_i_main_bps_cnt,x)
7744  1601 a10b          	cp	a,#11
7745  1603 254f          	jrult	L5343
7748  1605 b632          	ld	a,_cnt_net_drv
7749  1607 5f            	clrw	x
7750  1608 97            	ld	xl,a
7751  1609 6f14          	clr	(_i_main_flag,x)
7752  160b 2047          	jra	L5343
7753  160d               L1443:
7754                     ; 1560 	else if(cnt_net_drv==6)
7756  160d b632          	ld	a,_cnt_net_drv
7757  160f a106          	cp	a,#6
7758  1611 2641          	jrne	L5343
7759                     ; 1562 		plazma_int[2]=pwm_u;
7761  1613 be0c          	ldw	x,_pwm_u
7762  1615 bf37          	ldw	_plazma_int+4,x
7763                     ; 1563 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7765  1617 3b006a        	push	_Ui
7766  161a 3b006b        	push	_Ui+1
7767  161d 3b006c        	push	_Un
7768  1620 3b006d        	push	_Un+1
7769  1623 3b006e        	push	_I
7770  1626 3b006f        	push	_I+1
7771  1629 4bda          	push	#218
7772  162b 3b0005        	push	_adress
7773  162e ae018e        	ldw	x,#398
7774  1631 cd14b9        	call	_can_transmit
7776  1634 5b08          	addw	sp,#8
7777                     ; 1564 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7779  1636 3b0037        	push	_plazma_int+4
7780  1639 3b0038        	push	_plazma_int+5
7781  163c 3b005f        	push	__x_+1
7782  163f 3b000b        	push	_flags
7783  1642 4b00          	push	#0
7784  1644 3b0067        	push	_T
7785  1647 4bdb          	push	#219
7786  1649 3b0005        	push	_adress
7787  164c ae018e        	ldw	x,#398
7788  164f cd14b9        	call	_can_transmit
7790  1652 5b08          	addw	sp,#8
7791  1654               L5343:
7792                     ; 1567 }
7795  1654 81            	ret
7909                     ; 1570 void can_in_an(void)
7909                     ; 1571 {
7910                     	switch	.text
7911  1655               _can_in_an:
7913  1655 5205          	subw	sp,#5
7914       00000005      OFST:	set	5
7917                     ; 1581 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7919  1657 b6c9          	ld	a,_mess+6
7920  1659 c10005        	cp	a,_adress
7921  165c 2703          	jreq	L671
7922  165e cc1779        	jp	L5053
7923  1661               L671:
7925  1661 b6ca          	ld	a,_mess+7
7926  1663 c10005        	cp	a,_adress
7927  1666 2703          	jreq	L002
7928  1668 cc1779        	jp	L5053
7929  166b               L002:
7931  166b b6cb          	ld	a,_mess+8
7932  166d a1ed          	cp	a,#237
7933  166f 2703          	jreq	L202
7934  1671 cc1779        	jp	L5053
7935  1674               L202:
7936                     ; 1584 	can_error_cnt=0;
7938  1674 3f70          	clr	_can_error_cnt
7939                     ; 1586 	bMAIN=0;
7941  1676 72110001      	bres	_bMAIN
7942                     ; 1587  	flags_tu=mess[9];
7944  167a 45cc60        	mov	_flags_tu,_mess+9
7945                     ; 1588  	if(flags_tu&0b00000001)
7947  167d b660          	ld	a,_flags_tu
7948  167f a501          	bcp	a,#1
7949  1681 2706          	jreq	L7053
7950                     ; 1593  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7952  1683 721a000b      	bset	_flags,#5
7954  1687 200e          	jra	L1153
7955  1689               L7053:
7956                     ; 1604  				flags&=0b11011111; 
7958  1689 721b000b      	bres	_flags,#5
7959                     ; 1605  				off_bp_cnt=5*ee_TZAS;
7961  168d c60017        	ld	a,_ee_TZAS+1
7962  1690 97            	ld	xl,a
7963  1691 a605          	ld	a,#5
7964  1693 42            	mul	x,a
7965  1694 9f            	ld	a,xl
7966  1695 b753          	ld	_off_bp_cnt,a
7967  1697               L1153:
7968                     ; 1611  	if(flags_tu&0b00000010) flags|=0b01000000;
7970  1697 b660          	ld	a,_flags_tu
7971  1699 a502          	bcp	a,#2
7972  169b 2706          	jreq	L3153
7975  169d 721c000b      	bset	_flags,#6
7977  16a1 2004          	jra	L5153
7978  16a3               L3153:
7979                     ; 1612  	else flags&=0b10111111; 
7981  16a3 721d000b      	bres	_flags,#6
7982  16a7               L5153:
7983                     ; 1614  	vol_u_temp=mess[10]+mess[11]*256;
7985  16a7 b6ce          	ld	a,_mess+11
7986  16a9 5f            	clrw	x
7987  16aa 97            	ld	xl,a
7988  16ab 4f            	clr	a
7989  16ac 02            	rlwa	x,a
7990  16ad 01            	rrwa	x,a
7991  16ae bbcd          	add	a,_mess+10
7992  16b0 2401          	jrnc	L061
7993  16b2 5c            	incw	x
7994  16b3               L061:
7995  16b3 b759          	ld	_vol_u_temp+1,a
7996  16b5 9f            	ld	a,xl
7997  16b6 b758          	ld	_vol_u_temp,a
7998                     ; 1615  	vol_i_temp=mess[12]+mess[13]*256;  
8000  16b8 b6d0          	ld	a,_mess+13
8001  16ba 5f            	clrw	x
8002  16bb 97            	ld	xl,a
8003  16bc 4f            	clr	a
8004  16bd 02            	rlwa	x,a
8005  16be 01            	rrwa	x,a
8006  16bf bbcf          	add	a,_mess+12
8007  16c1 2401          	jrnc	L261
8008  16c3 5c            	incw	x
8009  16c4               L261:
8010  16c4 b757          	ld	_vol_i_temp+1,a
8011  16c6 9f            	ld	a,xl
8012  16c7 b756          	ld	_vol_i_temp,a
8013                     ; 1624 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8015  16c9 b601          	ld	a,_vent_resurs_tx_cnt
8016  16cb a102          	cp	a,#2
8017  16cd 2507          	jrult	L7153
8020  16cf ce0000        	ldw	x,_vent_resurs
8021  16d2 bf37          	ldw	_plazma_int+4,x
8023  16d4 2004          	jra	L1253
8024  16d6               L7153:
8025                     ; 1625 	else plazma_int[2]=vent_resurs_sec_cnt;
8027  16d6 be02          	ldw	x,_vent_resurs_sec_cnt
8028  16d8 bf37          	ldw	_plazma_int+4,x
8029  16da               L1253:
8030                     ; 1626  	rotor_int=flags_tu+(((short)flags)<<8);
8032  16da b60b          	ld	a,_flags
8033  16dc 5f            	clrw	x
8034  16dd 97            	ld	xl,a
8035  16de 4f            	clr	a
8036  16df 02            	rlwa	x,a
8037  16e0 01            	rrwa	x,a
8038  16e1 bb60          	add	a,_flags_tu
8039  16e3 2401          	jrnc	L461
8040  16e5 5c            	incw	x
8041  16e6               L461:
8042  16e6 b71c          	ld	_rotor_int+1,a
8043  16e8 9f            	ld	a,xl
8044  16e9 b71b          	ld	_rotor_int,a
8045                     ; 1627 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8047  16eb 3b006a        	push	_Ui
8048  16ee 3b006b        	push	_Ui+1
8049  16f1 3b006c        	push	_Un
8050  16f4 3b006d        	push	_Un+1
8051  16f7 3b006e        	push	_I
8052  16fa 3b006f        	push	_I+1
8053  16fd 4bda          	push	#218
8054  16ff 3b0005        	push	_adress
8055  1702 ae018e        	ldw	x,#398
8056  1705 cd14b9        	call	_can_transmit
8058  1708 5b08          	addw	sp,#8
8059                     ; 1628 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8061  170a 3b0037        	push	_plazma_int+4
8062  170d 3b0038        	push	_plazma_int+5
8063  1710 3b005f        	push	__x_+1
8064  1713 3b000b        	push	_flags
8065  1716 b601          	ld	a,_vent_resurs_tx_cnt
8066  1718 5f            	clrw	x
8067  1719 97            	ld	xl,a
8068  171a d60000        	ld	a,(_vent_resurs_buff,x)
8069  171d 88            	push	a
8070  171e 3b0067        	push	_T
8071  1721 4bdb          	push	#219
8072  1723 3b0005        	push	_adress
8073  1726 ae018e        	ldw	x,#398
8074  1729 cd14b9        	call	_can_transmit
8076  172c 5b08          	addw	sp,#8
8077                     ; 1629      link_cnt=0;
8079  172e 3f61          	clr	_link_cnt
8080                     ; 1630      link=ON;
8082  1730 35550062      	mov	_link,#85
8083                     ; 1632      if(flags_tu&0b10000000)
8085  1734 b660          	ld	a,_flags_tu
8086  1736 a580          	bcp	a,#128
8087  1738 2716          	jreq	L3253
8088                     ; 1634      	if(!res_fl)
8090  173a 725d000b      	tnz	_res_fl
8091  173e 2625          	jrne	L7253
8092                     ; 1636      		res_fl=1;
8094  1740 a601          	ld	a,#1
8095  1742 ae000b        	ldw	x,#_res_fl
8096  1745 cd0000        	call	c_eewrc
8098                     ; 1637      		bRES=1;
8100  1748 35010010      	mov	_bRES,#1
8101                     ; 1638      		res_fl_cnt=0;
8103  174c 3f41          	clr	_res_fl_cnt
8104  174e 2015          	jra	L7253
8105  1750               L3253:
8106                     ; 1643      	if(main_cnt>20)
8108  1750 9c            	rvf
8109  1751 be51          	ldw	x,_main_cnt
8110  1753 a30015        	cpw	x,#21
8111  1756 2f0d          	jrslt	L7253
8112                     ; 1645     			if(res_fl)
8114  1758 725d000b      	tnz	_res_fl
8115  175c 2707          	jreq	L7253
8116                     ; 1647      			res_fl=0;
8118  175e 4f            	clr	a
8119  175f ae000b        	ldw	x,#_res_fl
8120  1762 cd0000        	call	c_eewrc
8122  1765               L7253:
8123                     ; 1652       if(res_fl_)
8125  1765 725d000a      	tnz	_res_fl_
8126  1769 2603          	jrne	L402
8127  176b cc1cc3        	jp	L1543
8128  176e               L402:
8129                     ; 1654       	res_fl_=0;
8131  176e 4f            	clr	a
8132  176f ae000a        	ldw	x,#_res_fl_
8133  1772 cd0000        	call	c_eewrc
8135  1775 acc31cc3      	jpf	L1543
8136  1779               L5053:
8137                     ; 1657 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8139  1779 b6c9          	ld	a,_mess+6
8140  177b c10005        	cp	a,_adress
8141  177e 2703          	jreq	L602
8142  1780 cc198f        	jp	L1453
8143  1783               L602:
8145  1783 b6ca          	ld	a,_mess+7
8146  1785 c10005        	cp	a,_adress
8147  1788 2703          	jreq	L012
8148  178a cc198f        	jp	L1453
8149  178d               L012:
8151  178d b6cb          	ld	a,_mess+8
8152  178f a1ee          	cp	a,#238
8153  1791 2703          	jreq	L212
8154  1793 cc198f        	jp	L1453
8155  1796               L212:
8157  1796 b6cc          	ld	a,_mess+9
8158  1798 b1cd          	cp	a,_mess+10
8159  179a 2703          	jreq	L412
8160  179c cc198f        	jp	L1453
8161  179f               L412:
8162                     ; 1659 	rotor_int++;
8164  179f be1b          	ldw	x,_rotor_int
8165  17a1 1c0001        	addw	x,#1
8166  17a4 bf1b          	ldw	_rotor_int,x
8167                     ; 1660 	if((mess[9]&0xf0)==0x20)
8169  17a6 b6cc          	ld	a,_mess+9
8170  17a8 a4f0          	and	a,#240
8171  17aa a120          	cp	a,#32
8172  17ac 2673          	jrne	L3453
8173                     ; 1662 		if((mess[9]&0x0f)==0x01)
8175  17ae b6cc          	ld	a,_mess+9
8176  17b0 a40f          	and	a,#15
8177  17b2 a101          	cp	a,#1
8178  17b4 260d          	jrne	L5453
8179                     ; 1664 			ee_K[0][0]=adc_buff_[4];
8181  17b6 ce0011        	ldw	x,_adc_buff_+8
8182  17b9 89            	pushw	x
8183  17ba ae001a        	ldw	x,#_ee_K
8184  17bd cd0000        	call	c_eewrw
8186  17c0 85            	popw	x
8188  17c1 204a          	jra	L7453
8189  17c3               L5453:
8190                     ; 1666 		else if((mess[9]&0x0f)==0x02)
8192  17c3 b6cc          	ld	a,_mess+9
8193  17c5 a40f          	and	a,#15
8194  17c7 a102          	cp	a,#2
8195  17c9 260b          	jrne	L1553
8196                     ; 1668 			ee_K[0][1]++;
8198  17cb ce001c        	ldw	x,_ee_K+2
8199  17ce 1c0001        	addw	x,#1
8200  17d1 cf001c        	ldw	_ee_K+2,x
8202  17d4 2037          	jra	L7453
8203  17d6               L1553:
8204                     ; 1670 		else if((mess[9]&0x0f)==0x03)
8206  17d6 b6cc          	ld	a,_mess+9
8207  17d8 a40f          	and	a,#15
8208  17da a103          	cp	a,#3
8209  17dc 260b          	jrne	L5553
8210                     ; 1672 			ee_K[0][1]+=10;
8212  17de ce001c        	ldw	x,_ee_K+2
8213  17e1 1c000a        	addw	x,#10
8214  17e4 cf001c        	ldw	_ee_K+2,x
8216  17e7 2024          	jra	L7453
8217  17e9               L5553:
8218                     ; 1674 		else if((mess[9]&0x0f)==0x04)
8220  17e9 b6cc          	ld	a,_mess+9
8221  17eb a40f          	and	a,#15
8222  17ed a104          	cp	a,#4
8223  17ef 260b          	jrne	L1653
8224                     ; 1676 			ee_K[0][1]--;
8226  17f1 ce001c        	ldw	x,_ee_K+2
8227  17f4 1d0001        	subw	x,#1
8228  17f7 cf001c        	ldw	_ee_K+2,x
8230  17fa 2011          	jra	L7453
8231  17fc               L1653:
8232                     ; 1678 		else if((mess[9]&0x0f)==0x05)
8234  17fc b6cc          	ld	a,_mess+9
8235  17fe a40f          	and	a,#15
8236  1800 a105          	cp	a,#5
8237  1802 2609          	jrne	L7453
8238                     ; 1680 			ee_K[0][1]-=10;
8240  1804 ce001c        	ldw	x,_ee_K+2
8241  1807 1d000a        	subw	x,#10
8242  180a cf001c        	ldw	_ee_K+2,x
8243  180d               L7453:
8244                     ; 1682 		granee(&ee_K[0][1],50,3000);									
8246  180d ae0bb8        	ldw	x,#3000
8247  1810 89            	pushw	x
8248  1811 ae0032        	ldw	x,#50
8249  1814 89            	pushw	x
8250  1815 ae001c        	ldw	x,#_ee_K+2
8251  1818 cd00f2        	call	_granee
8253  181b 5b04          	addw	sp,#4
8255  181d ac751975      	jpf	L7653
8256  1821               L3453:
8257                     ; 1684 	else if((mess[9]&0xf0)==0x10)
8259  1821 b6cc          	ld	a,_mess+9
8260  1823 a4f0          	and	a,#240
8261  1825 a110          	cp	a,#16
8262  1827 2673          	jrne	L1753
8263                     ; 1686 		if((mess[9]&0x0f)==0x01)
8265  1829 b6cc          	ld	a,_mess+9
8266  182b a40f          	and	a,#15
8267  182d a101          	cp	a,#1
8268  182f 260d          	jrne	L3753
8269                     ; 1688 			ee_K[1][0]=adc_buff_[1];
8271  1831 ce000b        	ldw	x,_adc_buff_+2
8272  1834 89            	pushw	x
8273  1835 ae001e        	ldw	x,#_ee_K+4
8274  1838 cd0000        	call	c_eewrw
8276  183b 85            	popw	x
8278  183c 204a          	jra	L5753
8279  183e               L3753:
8280                     ; 1690 		else if((mess[9]&0x0f)==0x02)
8282  183e b6cc          	ld	a,_mess+9
8283  1840 a40f          	and	a,#15
8284  1842 a102          	cp	a,#2
8285  1844 260b          	jrne	L7753
8286                     ; 1692 			ee_K[1][1]++;
8288  1846 ce0020        	ldw	x,_ee_K+6
8289  1849 1c0001        	addw	x,#1
8290  184c cf0020        	ldw	_ee_K+6,x
8292  184f 2037          	jra	L5753
8293  1851               L7753:
8294                     ; 1694 		else if((mess[9]&0x0f)==0x03)
8296  1851 b6cc          	ld	a,_mess+9
8297  1853 a40f          	and	a,#15
8298  1855 a103          	cp	a,#3
8299  1857 260b          	jrne	L3063
8300                     ; 1696 			ee_K[1][1]+=10;
8302  1859 ce0020        	ldw	x,_ee_K+6
8303  185c 1c000a        	addw	x,#10
8304  185f cf0020        	ldw	_ee_K+6,x
8306  1862 2024          	jra	L5753
8307  1864               L3063:
8308                     ; 1698 		else if((mess[9]&0x0f)==0x04)
8310  1864 b6cc          	ld	a,_mess+9
8311  1866 a40f          	and	a,#15
8312  1868 a104          	cp	a,#4
8313  186a 260b          	jrne	L7063
8314                     ; 1700 			ee_K[1][1]--;
8316  186c ce0020        	ldw	x,_ee_K+6
8317  186f 1d0001        	subw	x,#1
8318  1872 cf0020        	ldw	_ee_K+6,x
8320  1875 2011          	jra	L5753
8321  1877               L7063:
8322                     ; 1702 		else if((mess[9]&0x0f)==0x05)
8324  1877 b6cc          	ld	a,_mess+9
8325  1879 a40f          	and	a,#15
8326  187b a105          	cp	a,#5
8327  187d 2609          	jrne	L5753
8328                     ; 1704 			ee_K[1][1]-=10;
8330  187f ce0020        	ldw	x,_ee_K+6
8331  1882 1d000a        	subw	x,#10
8332  1885 cf0020        	ldw	_ee_K+6,x
8333  1888               L5753:
8334                     ; 1709 		granee(&ee_K[1][1],10,30000);
8336  1888 ae7530        	ldw	x,#30000
8337  188b 89            	pushw	x
8338  188c ae000a        	ldw	x,#10
8339  188f 89            	pushw	x
8340  1890 ae0020        	ldw	x,#_ee_K+6
8341  1893 cd00f2        	call	_granee
8343  1896 5b04          	addw	sp,#4
8345  1898 ac751975      	jpf	L7653
8346  189c               L1753:
8347                     ; 1713 	else if((mess[9]&0xf0)==0x00)
8349  189c b6cc          	ld	a,_mess+9
8350  189e a5f0          	bcp	a,#240
8351  18a0 2671          	jrne	L7163
8352                     ; 1715 		if((mess[9]&0x0f)==0x01)
8354  18a2 b6cc          	ld	a,_mess+9
8355  18a4 a40f          	and	a,#15
8356  18a6 a101          	cp	a,#1
8357  18a8 260d          	jrne	L1263
8358                     ; 1717 			ee_K[2][0]=adc_buff_[2];
8360  18aa ce000d        	ldw	x,_adc_buff_+4
8361  18ad 89            	pushw	x
8362  18ae ae0022        	ldw	x,#_ee_K+8
8363  18b1 cd0000        	call	c_eewrw
8365  18b4 85            	popw	x
8367  18b5 204a          	jra	L3263
8368  18b7               L1263:
8369                     ; 1719 		else if((mess[9]&0x0f)==0x02)
8371  18b7 b6cc          	ld	a,_mess+9
8372  18b9 a40f          	and	a,#15
8373  18bb a102          	cp	a,#2
8374  18bd 260b          	jrne	L5263
8375                     ; 1721 			ee_K[2][1]++;
8377  18bf ce0024        	ldw	x,_ee_K+10
8378  18c2 1c0001        	addw	x,#1
8379  18c5 cf0024        	ldw	_ee_K+10,x
8381  18c8 2037          	jra	L3263
8382  18ca               L5263:
8383                     ; 1723 		else if((mess[9]&0x0f)==0x03)
8385  18ca b6cc          	ld	a,_mess+9
8386  18cc a40f          	and	a,#15
8387  18ce a103          	cp	a,#3
8388  18d0 260b          	jrne	L1363
8389                     ; 1725 			ee_K[2][1]+=10;
8391  18d2 ce0024        	ldw	x,_ee_K+10
8392  18d5 1c000a        	addw	x,#10
8393  18d8 cf0024        	ldw	_ee_K+10,x
8395  18db 2024          	jra	L3263
8396  18dd               L1363:
8397                     ; 1727 		else if((mess[9]&0x0f)==0x04)
8399  18dd b6cc          	ld	a,_mess+9
8400  18df a40f          	and	a,#15
8401  18e1 a104          	cp	a,#4
8402  18e3 260b          	jrne	L5363
8403                     ; 1729 			ee_K[2][1]--;
8405  18e5 ce0024        	ldw	x,_ee_K+10
8406  18e8 1d0001        	subw	x,#1
8407  18eb cf0024        	ldw	_ee_K+10,x
8409  18ee 2011          	jra	L3263
8410  18f0               L5363:
8411                     ; 1731 		else if((mess[9]&0x0f)==0x05)
8413  18f0 b6cc          	ld	a,_mess+9
8414  18f2 a40f          	and	a,#15
8415  18f4 a105          	cp	a,#5
8416  18f6 2609          	jrne	L3263
8417                     ; 1733 			ee_K[2][1]-=10;
8419  18f8 ce0024        	ldw	x,_ee_K+10
8420  18fb 1d000a        	subw	x,#10
8421  18fe cf0024        	ldw	_ee_K+10,x
8422  1901               L3263:
8423                     ; 1738 		granee(&ee_K[2][1],10,30000);
8425  1901 ae7530        	ldw	x,#30000
8426  1904 89            	pushw	x
8427  1905 ae000a        	ldw	x,#10
8428  1908 89            	pushw	x
8429  1909 ae0024        	ldw	x,#_ee_K+10
8430  190c cd00f2        	call	_granee
8432  190f 5b04          	addw	sp,#4
8434  1911 2062          	jra	L7653
8435  1913               L7163:
8436                     ; 1742 	else if((mess[9]&0xf0)==0x30)
8438  1913 b6cc          	ld	a,_mess+9
8439  1915 a4f0          	and	a,#240
8440  1917 a130          	cp	a,#48
8441  1919 265a          	jrne	L7653
8442                     ; 1744 		if((mess[9]&0x0f)==0x02)
8444  191b b6cc          	ld	a,_mess+9
8445  191d a40f          	and	a,#15
8446  191f a102          	cp	a,#2
8447  1921 260b          	jrne	L7463
8448                     ; 1746 			ee_K[3][1]++;
8450  1923 ce0028        	ldw	x,_ee_K+14
8451  1926 1c0001        	addw	x,#1
8452  1929 cf0028        	ldw	_ee_K+14,x
8454  192c 2037          	jra	L1563
8455  192e               L7463:
8456                     ; 1748 		else if((mess[9]&0x0f)==0x03)
8458  192e b6cc          	ld	a,_mess+9
8459  1930 a40f          	and	a,#15
8460  1932 a103          	cp	a,#3
8461  1934 260b          	jrne	L3563
8462                     ; 1750 			ee_K[3][1]+=10;
8464  1936 ce0028        	ldw	x,_ee_K+14
8465  1939 1c000a        	addw	x,#10
8466  193c cf0028        	ldw	_ee_K+14,x
8468  193f 2024          	jra	L1563
8469  1941               L3563:
8470                     ; 1752 		else if((mess[9]&0x0f)==0x04)
8472  1941 b6cc          	ld	a,_mess+9
8473  1943 a40f          	and	a,#15
8474  1945 a104          	cp	a,#4
8475  1947 260b          	jrne	L7563
8476                     ; 1754 			ee_K[3][1]--;
8478  1949 ce0028        	ldw	x,_ee_K+14
8479  194c 1d0001        	subw	x,#1
8480  194f cf0028        	ldw	_ee_K+14,x
8482  1952 2011          	jra	L1563
8483  1954               L7563:
8484                     ; 1756 		else if((mess[9]&0x0f)==0x05)
8486  1954 b6cc          	ld	a,_mess+9
8487  1956 a40f          	and	a,#15
8488  1958 a105          	cp	a,#5
8489  195a 2609          	jrne	L1563
8490                     ; 1758 			ee_K[3][1]-=10;
8492  195c ce0028        	ldw	x,_ee_K+14
8493  195f 1d000a        	subw	x,#10
8494  1962 cf0028        	ldw	_ee_K+14,x
8495  1965               L1563:
8496                     ; 1760 		granee(&ee_K[3][1],300,517);									
8498  1965 ae0205        	ldw	x,#517
8499  1968 89            	pushw	x
8500  1969 ae012c        	ldw	x,#300
8501  196c 89            	pushw	x
8502  196d ae0028        	ldw	x,#_ee_K+14
8503  1970 cd00f2        	call	_granee
8505  1973 5b04          	addw	sp,#4
8506  1975               L7653:
8507                     ; 1763 	link_cnt=0;
8509  1975 3f61          	clr	_link_cnt
8510                     ; 1764      link=ON;
8512  1977 35550062      	mov	_link,#85
8513                     ; 1765      if(res_fl_)
8515  197b 725d000a      	tnz	_res_fl_
8516  197f 2603          	jrne	L612
8517  1981 cc1cc3        	jp	L1543
8518  1984               L612:
8519                     ; 1767       	res_fl_=0;
8521  1984 4f            	clr	a
8522  1985 ae000a        	ldw	x,#_res_fl_
8523  1988 cd0000        	call	c_eewrc
8525  198b acc31cc3      	jpf	L1543
8526  198f               L1453:
8527                     ; 1773 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8529  198f b6c9          	ld	a,_mess+6
8530  1991 a1ff          	cp	a,#255
8531  1993 2703          	jreq	L022
8532  1995 cc1a23        	jp	L1763
8533  1998               L022:
8535  1998 b6ca          	ld	a,_mess+7
8536  199a a1ff          	cp	a,#255
8537  199c 2703          	jreq	L222
8538  199e cc1a23        	jp	L1763
8539  19a1               L222:
8541  19a1 b6cb          	ld	a,_mess+8
8542  19a3 a162          	cp	a,#98
8543  19a5 267c          	jrne	L1763
8544                     ; 1776 	tempSS=mess[9]+(mess[10]*256);
8546  19a7 b6cd          	ld	a,_mess+10
8547  19a9 5f            	clrw	x
8548  19aa 97            	ld	xl,a
8549  19ab 4f            	clr	a
8550  19ac 02            	rlwa	x,a
8551  19ad 01            	rrwa	x,a
8552  19ae bbcc          	add	a,_mess+9
8553  19b0 2401          	jrnc	L661
8554  19b2 5c            	incw	x
8555  19b3               L661:
8556  19b3 02            	rlwa	x,a
8557  19b4 1f04          	ldw	(OFST-1,sp),x
8558  19b6 01            	rrwa	x,a
8559                     ; 1777 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8561  19b7 ce0014        	ldw	x,_ee_Umax
8562  19ba 1304          	cpw	x,(OFST-1,sp)
8563  19bc 270a          	jreq	L3763
8566  19be 1e04          	ldw	x,(OFST-1,sp)
8567  19c0 89            	pushw	x
8568  19c1 ae0014        	ldw	x,#_ee_Umax
8569  19c4 cd0000        	call	c_eewrw
8571  19c7 85            	popw	x
8572  19c8               L3763:
8573                     ; 1778 	tempSS=mess[11]+(mess[12]*256);
8575  19c8 b6cf          	ld	a,_mess+12
8576  19ca 5f            	clrw	x
8577  19cb 97            	ld	xl,a
8578  19cc 4f            	clr	a
8579  19cd 02            	rlwa	x,a
8580  19ce 01            	rrwa	x,a
8581  19cf bbce          	add	a,_mess+11
8582  19d1 2401          	jrnc	L071
8583  19d3 5c            	incw	x
8584  19d4               L071:
8585  19d4 02            	rlwa	x,a
8586  19d5 1f04          	ldw	(OFST-1,sp),x
8587  19d7 01            	rrwa	x,a
8588                     ; 1779 	if(ee_dU!=tempSS) ee_dU=tempSS;
8590  19d8 ce0012        	ldw	x,_ee_dU
8591  19db 1304          	cpw	x,(OFST-1,sp)
8592  19dd 270a          	jreq	L5763
8595  19df 1e04          	ldw	x,(OFST-1,sp)
8596  19e1 89            	pushw	x
8597  19e2 ae0012        	ldw	x,#_ee_dU
8598  19e5 cd0000        	call	c_eewrw
8600  19e8 85            	popw	x
8601  19e9               L5763:
8602                     ; 1780 	if((mess[13]&0x0f)==0x5)
8604  19e9 b6d0          	ld	a,_mess+13
8605  19eb a40f          	and	a,#15
8606  19ed a105          	cp	a,#5
8607  19ef 261a          	jrne	L7763
8608                     ; 1782 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8610  19f1 ce0006        	ldw	x,_ee_AVT_MODE
8611  19f4 a30055        	cpw	x,#85
8612  19f7 2603          	jrne	L422
8613  19f9 cc1cc3        	jp	L1543
8614  19fc               L422:
8617  19fc ae0055        	ldw	x,#85
8618  19ff 89            	pushw	x
8619  1a00 ae0006        	ldw	x,#_ee_AVT_MODE
8620  1a03 cd0000        	call	c_eewrw
8622  1a06 85            	popw	x
8623  1a07 acc31cc3      	jpf	L1543
8624  1a0b               L7763:
8625                     ; 1784 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8627  1a0b ce0006        	ldw	x,_ee_AVT_MODE
8628  1a0e a30055        	cpw	x,#85
8629  1a11 2703          	jreq	L622
8630  1a13 cc1cc3        	jp	L1543
8631  1a16               L622:
8634  1a16 5f            	clrw	x
8635  1a17 89            	pushw	x
8636  1a18 ae0006        	ldw	x,#_ee_AVT_MODE
8637  1a1b cd0000        	call	c_eewrw
8639  1a1e 85            	popw	x
8640  1a1f acc31cc3      	jpf	L1543
8641  1a23               L1763:
8642                     ; 1787 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8644  1a23 b6c9          	ld	a,_mess+6
8645  1a25 a1ff          	cp	a,#255
8646  1a27 2703          	jreq	L032
8647  1a29 cc1afa        	jp	L1173
8648  1a2c               L032:
8650  1a2c b6ca          	ld	a,_mess+7
8651  1a2e a1ff          	cp	a,#255
8652  1a30 2703          	jreq	L232
8653  1a32 cc1afa        	jp	L1173
8654  1a35               L232:
8656  1a35 b6cb          	ld	a,_mess+8
8657  1a37 a126          	cp	a,#38
8658  1a39 2709          	jreq	L3173
8660  1a3b b6cb          	ld	a,_mess+8
8661  1a3d a129          	cp	a,#41
8662  1a3f 2703          	jreq	L432
8663  1a41 cc1afa        	jp	L1173
8664  1a44               L432:
8665  1a44               L3173:
8666                     ; 1790 	tempSS=mess[9]+(mess[10]*256);
8668  1a44 b6cd          	ld	a,_mess+10
8669  1a46 5f            	clrw	x
8670  1a47 97            	ld	xl,a
8671  1a48 4f            	clr	a
8672  1a49 02            	rlwa	x,a
8673  1a4a 01            	rrwa	x,a
8674  1a4b bbcc          	add	a,_mess+9
8675  1a4d 2401          	jrnc	L271
8676  1a4f 5c            	incw	x
8677  1a50               L271:
8678  1a50 02            	rlwa	x,a
8679  1a51 1f04          	ldw	(OFST-1,sp),x
8680  1a53 01            	rrwa	x,a
8681                     ; 1791 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8683  1a54 ce0010        	ldw	x,_ee_tmax
8684  1a57 1304          	cpw	x,(OFST-1,sp)
8685  1a59 270a          	jreq	L5173
8688  1a5b 1e04          	ldw	x,(OFST-1,sp)
8689  1a5d 89            	pushw	x
8690  1a5e ae0010        	ldw	x,#_ee_tmax
8691  1a61 cd0000        	call	c_eewrw
8693  1a64 85            	popw	x
8694  1a65               L5173:
8695                     ; 1792 	tempSS=mess[11]+(mess[12]*256);
8697  1a65 b6cf          	ld	a,_mess+12
8698  1a67 5f            	clrw	x
8699  1a68 97            	ld	xl,a
8700  1a69 4f            	clr	a
8701  1a6a 02            	rlwa	x,a
8702  1a6b 01            	rrwa	x,a
8703  1a6c bbce          	add	a,_mess+11
8704  1a6e 2401          	jrnc	L471
8705  1a70 5c            	incw	x
8706  1a71               L471:
8707  1a71 02            	rlwa	x,a
8708  1a72 1f04          	ldw	(OFST-1,sp),x
8709  1a74 01            	rrwa	x,a
8710                     ; 1793 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8712  1a75 ce000e        	ldw	x,_ee_tsign
8713  1a78 1304          	cpw	x,(OFST-1,sp)
8714  1a7a 270a          	jreq	L7173
8717  1a7c 1e04          	ldw	x,(OFST-1,sp)
8718  1a7e 89            	pushw	x
8719  1a7f ae000e        	ldw	x,#_ee_tsign
8720  1a82 cd0000        	call	c_eewrw
8722  1a85 85            	popw	x
8723  1a86               L7173:
8724                     ; 1796 	if(mess[8]==MEM_KF1)
8726  1a86 b6cb          	ld	a,_mess+8
8727  1a88 a126          	cp	a,#38
8728  1a8a 2623          	jrne	L1273
8729                     ; 1798 		if(ee_DEVICE!=0)ee_DEVICE=0;
8731  1a8c ce0004        	ldw	x,_ee_DEVICE
8732  1a8f 2709          	jreq	L3273
8735  1a91 5f            	clrw	x
8736  1a92 89            	pushw	x
8737  1a93 ae0004        	ldw	x,#_ee_DEVICE
8738  1a96 cd0000        	call	c_eewrw
8740  1a99 85            	popw	x
8741  1a9a               L3273:
8742                     ; 1799 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8744  1a9a b6d0          	ld	a,_mess+13
8745  1a9c 5f            	clrw	x
8746  1a9d 97            	ld	xl,a
8747  1a9e c30016        	cpw	x,_ee_TZAS
8748  1aa1 270c          	jreq	L1273
8751  1aa3 b6d0          	ld	a,_mess+13
8752  1aa5 5f            	clrw	x
8753  1aa6 97            	ld	xl,a
8754  1aa7 89            	pushw	x
8755  1aa8 ae0016        	ldw	x,#_ee_TZAS
8756  1aab cd0000        	call	c_eewrw
8758  1aae 85            	popw	x
8759  1aaf               L1273:
8760                     ; 1801 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8762  1aaf b6cb          	ld	a,_mess+8
8763  1ab1 a129          	cp	a,#41
8764  1ab3 2703          	jreq	L632
8765  1ab5 cc1cc3        	jp	L1543
8766  1ab8               L632:
8767                     ; 1803 		if(ee_DEVICE!=1)ee_DEVICE=1;
8769  1ab8 ce0004        	ldw	x,_ee_DEVICE
8770  1abb a30001        	cpw	x,#1
8771  1abe 270b          	jreq	L1373
8774  1ac0 ae0001        	ldw	x,#1
8775  1ac3 89            	pushw	x
8776  1ac4 ae0004        	ldw	x,#_ee_DEVICE
8777  1ac7 cd0000        	call	c_eewrw
8779  1aca 85            	popw	x
8780  1acb               L1373:
8781                     ; 1804 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8783  1acb b6d0          	ld	a,_mess+13
8784  1acd 5f            	clrw	x
8785  1ace 97            	ld	xl,a
8786  1acf c30002        	cpw	x,_ee_IMAXVENT
8787  1ad2 270c          	jreq	L3373
8790  1ad4 b6d0          	ld	a,_mess+13
8791  1ad6 5f            	clrw	x
8792  1ad7 97            	ld	xl,a
8793  1ad8 89            	pushw	x
8794  1ad9 ae0002        	ldw	x,#_ee_IMAXVENT
8795  1adc cd0000        	call	c_eewrw
8797  1adf 85            	popw	x
8798  1ae0               L3373:
8799                     ; 1805 			if(ee_TZAS!=3) ee_TZAS=3;
8801  1ae0 ce0016        	ldw	x,_ee_TZAS
8802  1ae3 a30003        	cpw	x,#3
8803  1ae6 2603          	jrne	L042
8804  1ae8 cc1cc3        	jp	L1543
8805  1aeb               L042:
8808  1aeb ae0003        	ldw	x,#3
8809  1aee 89            	pushw	x
8810  1aef ae0016        	ldw	x,#_ee_TZAS
8811  1af2 cd0000        	call	c_eewrw
8813  1af5 85            	popw	x
8814  1af6 acc31cc3      	jpf	L1543
8815  1afa               L1173:
8816                     ; 1809 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8818  1afa b6c9          	ld	a,_mess+6
8819  1afc c10005        	cp	a,_adress
8820  1aff 262d          	jrne	L1473
8822  1b01 b6ca          	ld	a,_mess+7
8823  1b03 c10005        	cp	a,_adress
8824  1b06 2626          	jrne	L1473
8826  1b08 b6cb          	ld	a,_mess+8
8827  1b0a a116          	cp	a,#22
8828  1b0c 2620          	jrne	L1473
8830  1b0e b6cc          	ld	a,_mess+9
8831  1b10 a163          	cp	a,#99
8832  1b12 261a          	jrne	L1473
8833                     ; 1811 	flags&=0b11100001;
8835  1b14 b60b          	ld	a,_flags
8836  1b16 a4e1          	and	a,#225
8837  1b18 b70b          	ld	_flags,a
8838                     ; 1812 	tsign_cnt=0;
8840  1b1a 5f            	clrw	x
8841  1b1b bf4d          	ldw	_tsign_cnt,x
8842                     ; 1813 	tmax_cnt=0;
8844  1b1d 5f            	clrw	x
8845  1b1e bf4b          	ldw	_tmax_cnt,x
8846                     ; 1814 	umax_cnt=0;
8848  1b20 5f            	clrw	x
8849  1b21 bf65          	ldw	_umax_cnt,x
8850                     ; 1815 	umin_cnt=0;
8852  1b23 5f            	clrw	x
8853  1b24 bf63          	ldw	_umin_cnt,x
8854                     ; 1816 	led_drv_cnt=30;
8856  1b26 351e001a      	mov	_led_drv_cnt,#30
8858  1b2a acc31cc3      	jpf	L1543
8859  1b2e               L1473:
8860                     ; 1819 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8862  1b2e b6c9          	ld	a,_mess+6
8863  1b30 c10005        	cp	a,_adress
8864  1b33 2620          	jrne	L5473
8866  1b35 b6ca          	ld	a,_mess+7
8867  1b37 c10005        	cp	a,_adress
8868  1b3a 2619          	jrne	L5473
8870  1b3c b6cb          	ld	a,_mess+8
8871  1b3e a116          	cp	a,#22
8872  1b40 2613          	jrne	L5473
8874  1b42 b6cc          	ld	a,_mess+9
8875  1b44 a164          	cp	a,#100
8876  1b46 260d          	jrne	L5473
8877                     ; 1821 	vent_resurs=0;
8879  1b48 5f            	clrw	x
8880  1b49 89            	pushw	x
8881  1b4a ae0000        	ldw	x,#_vent_resurs
8882  1b4d cd0000        	call	c_eewrw
8884  1b50 85            	popw	x
8886  1b51 acc31cc3      	jpf	L1543
8887  1b55               L5473:
8888                     ; 1825 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8890  1b55 b6c9          	ld	a,_mess+6
8891  1b57 a1ff          	cp	a,#255
8892  1b59 265f          	jrne	L1573
8894  1b5b b6ca          	ld	a,_mess+7
8895  1b5d a1ff          	cp	a,#255
8896  1b5f 2659          	jrne	L1573
8898  1b61 b6cb          	ld	a,_mess+8
8899  1b63 a116          	cp	a,#22
8900  1b65 2653          	jrne	L1573
8902  1b67 b6cc          	ld	a,_mess+9
8903  1b69 a116          	cp	a,#22
8904  1b6b 264d          	jrne	L1573
8905                     ; 1827 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8907  1b6d b6cd          	ld	a,_mess+10
8908  1b6f a155          	cp	a,#85
8909  1b71 260f          	jrne	L3573
8911  1b73 b6ce          	ld	a,_mess+11
8912  1b75 a155          	cp	a,#85
8913  1b77 2609          	jrne	L3573
8916  1b79 be5e          	ldw	x,__x_
8917  1b7b 1c0001        	addw	x,#1
8918  1b7e bf5e          	ldw	__x_,x
8920  1b80 2024          	jra	L5573
8921  1b82               L3573:
8922                     ; 1828 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8924  1b82 b6cd          	ld	a,_mess+10
8925  1b84 a166          	cp	a,#102
8926  1b86 260f          	jrne	L7573
8928  1b88 b6ce          	ld	a,_mess+11
8929  1b8a a166          	cp	a,#102
8930  1b8c 2609          	jrne	L7573
8933  1b8e be5e          	ldw	x,__x_
8934  1b90 1d0001        	subw	x,#1
8935  1b93 bf5e          	ldw	__x_,x
8937  1b95 200f          	jra	L5573
8938  1b97               L7573:
8939                     ; 1829 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8941  1b97 b6cd          	ld	a,_mess+10
8942  1b99 a177          	cp	a,#119
8943  1b9b 2609          	jrne	L5573
8945  1b9d b6ce          	ld	a,_mess+11
8946  1b9f a177          	cp	a,#119
8947  1ba1 2603          	jrne	L5573
8950  1ba3 5f            	clrw	x
8951  1ba4 bf5e          	ldw	__x_,x
8952  1ba6               L5573:
8953                     ; 1830      gran(&_x_,-XMAX,XMAX);
8955  1ba6 ae0019        	ldw	x,#25
8956  1ba9 89            	pushw	x
8957  1baa aeffe7        	ldw	x,#65511
8958  1bad 89            	pushw	x
8959  1bae ae005e        	ldw	x,#__x_
8960  1bb1 cd00d1        	call	_gran
8962  1bb4 5b04          	addw	sp,#4
8964  1bb6 acc31cc3      	jpf	L1543
8965  1bba               L1573:
8966                     ; 1832 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8968  1bba b6c9          	ld	a,_mess+6
8969  1bbc c10005        	cp	a,_adress
8970  1bbf 2665          	jrne	L7673
8972  1bc1 b6ca          	ld	a,_mess+7
8973  1bc3 c10005        	cp	a,_adress
8974  1bc6 265e          	jrne	L7673
8976  1bc8 b6cb          	ld	a,_mess+8
8977  1bca a116          	cp	a,#22
8978  1bcc 2658          	jrne	L7673
8980  1bce b6cc          	ld	a,_mess+9
8981  1bd0 b1cd          	cp	a,_mess+10
8982  1bd2 2652          	jrne	L7673
8984  1bd4 b6cc          	ld	a,_mess+9
8985  1bd6 a1ee          	cp	a,#238
8986  1bd8 264c          	jrne	L7673
8987                     ; 1834 	rotor_int++;
8989  1bda be1b          	ldw	x,_rotor_int
8990  1bdc 1c0001        	addw	x,#1
8991  1bdf bf1b          	ldw	_rotor_int,x
8992                     ; 1835      tempI=pwm_u;
8994  1be1 be0c          	ldw	x,_pwm_u
8995  1be3 1f04          	ldw	(OFST-1,sp),x
8996                     ; 1836 	ee_U_AVT=tempI;
8998  1be5 1e04          	ldw	x,(OFST-1,sp)
8999  1be7 89            	pushw	x
9000  1be8 ae000c        	ldw	x,#_ee_U_AVT
9001  1beb cd0000        	call	c_eewrw
9003  1bee 85            	popw	x
9004                     ; 1837 	UU_AVT=Un;
9006  1bef be6c          	ldw	x,_Un
9007  1bf1 89            	pushw	x
9008  1bf2 ae0008        	ldw	x,#_UU_AVT
9009  1bf5 cd0000        	call	c_eewrw
9011  1bf8 85            	popw	x
9012                     ; 1838 	delay_ms(100);
9014  1bf9 ae0064        	ldw	x,#100
9015  1bfc cd011d        	call	_delay_ms
9017                     ; 1839 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9019  1bff ce000c        	ldw	x,_ee_U_AVT
9020  1c02 1304          	cpw	x,(OFST-1,sp)
9021  1c04 2703          	jreq	L242
9022  1c06 cc1cc3        	jp	L1543
9023  1c09               L242:
9026  1c09 4b00          	push	#0
9027  1c0b 4b00          	push	#0
9028  1c0d 4b00          	push	#0
9029  1c0f 4b00          	push	#0
9030  1c11 4bdd          	push	#221
9031  1c13 4bdd          	push	#221
9032  1c15 4b91          	push	#145
9033  1c17 3b0005        	push	_adress
9034  1c1a ae018e        	ldw	x,#398
9035  1c1d cd14b9        	call	_can_transmit
9037  1c20 5b08          	addw	sp,#8
9038  1c22 acc31cc3      	jpf	L1543
9039  1c26               L7673:
9040                     ; 1844 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9042  1c26 b6ca          	ld	a,_mess+7
9043  1c28 a1da          	cp	a,#218
9044  1c2a 2652          	jrne	L5773
9046  1c2c b6c9          	ld	a,_mess+6
9047  1c2e c10005        	cp	a,_adress
9048  1c31 274b          	jreq	L5773
9050  1c33 b6c9          	ld	a,_mess+6
9051  1c35 a106          	cp	a,#6
9052  1c37 2445          	jruge	L5773
9053                     ; 1846 	i_main_bps_cnt[mess[6]]=0;
9055  1c39 b6c9          	ld	a,_mess+6
9056  1c3b 5f            	clrw	x
9057  1c3c 97            	ld	xl,a
9058  1c3d 6f09          	clr	(_i_main_bps_cnt,x)
9059                     ; 1847 	i_main_flag[mess[6]]=1;
9061  1c3f b6c9          	ld	a,_mess+6
9062  1c41 5f            	clrw	x
9063  1c42 97            	ld	xl,a
9064  1c43 a601          	ld	a,#1
9065  1c45 e714          	ld	(_i_main_flag,x),a
9066                     ; 1848 	if(bMAIN)
9068                     	btst	_bMAIN
9069  1c4c 2475          	jruge	L1543
9070                     ; 1850 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9072  1c4e b6cc          	ld	a,_mess+9
9073  1c50 5f            	clrw	x
9074  1c51 97            	ld	xl,a
9075  1c52 4f            	clr	a
9076  1c53 02            	rlwa	x,a
9077  1c54 1f01          	ldw	(OFST-4,sp),x
9078  1c56 b6cb          	ld	a,_mess+8
9079  1c58 5f            	clrw	x
9080  1c59 97            	ld	xl,a
9081  1c5a 72fb01        	addw	x,(OFST-4,sp)
9082  1c5d b6c9          	ld	a,_mess+6
9083  1c5f 905f          	clrw	y
9084  1c61 9097          	ld	yl,a
9085  1c63 9058          	sllw	y
9086  1c65 90ef1a        	ldw	(_i_main,y),x
9087                     ; 1851 		i_main[adress]=I;
9089  1c68 c60005        	ld	a,_adress
9090  1c6b 5f            	clrw	x
9091  1c6c 97            	ld	xl,a
9092  1c6d 58            	sllw	x
9093  1c6e 90be6e        	ldw	y,_I
9094  1c71 ef1a          	ldw	(_i_main,x),y
9095                     ; 1852      	i_main_flag[adress]=1;
9097  1c73 c60005        	ld	a,_adress
9098  1c76 5f            	clrw	x
9099  1c77 97            	ld	xl,a
9100  1c78 a601          	ld	a,#1
9101  1c7a e714          	ld	(_i_main_flag,x),a
9102  1c7c 2045          	jra	L1543
9103  1c7e               L5773:
9104                     ; 1856 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9106  1c7e b6ca          	ld	a,_mess+7
9107  1c80 a1db          	cp	a,#219
9108  1c82 263f          	jrne	L1543
9110  1c84 b6c9          	ld	a,_mess+6
9111  1c86 c10005        	cp	a,_adress
9112  1c89 2738          	jreq	L1543
9114  1c8b b6c9          	ld	a,_mess+6
9115  1c8d a106          	cp	a,#6
9116  1c8f 2432          	jruge	L1543
9117                     ; 1858 	i_main_bps_cnt[mess[6]]=0;
9119  1c91 b6c9          	ld	a,_mess+6
9120  1c93 5f            	clrw	x
9121  1c94 97            	ld	xl,a
9122  1c95 6f09          	clr	(_i_main_bps_cnt,x)
9123                     ; 1859 	i_main_flag[mess[6]]=1;		
9125  1c97 b6c9          	ld	a,_mess+6
9126  1c99 5f            	clrw	x
9127  1c9a 97            	ld	xl,a
9128  1c9b a601          	ld	a,#1
9129  1c9d e714          	ld	(_i_main_flag,x),a
9130                     ; 1860 	if(bMAIN)
9132                     	btst	_bMAIN
9133  1ca4 241d          	jruge	L1543
9134                     ; 1862 		if(mess[9]==0)i_main_flag[i]=1;
9136  1ca6 3dcc          	tnz	_mess+9
9137  1ca8 260a          	jrne	L7004
9140  1caa 7b03          	ld	a,(OFST-2,sp)
9141  1cac 5f            	clrw	x
9142  1cad 97            	ld	xl,a
9143  1cae a601          	ld	a,#1
9144  1cb0 e714          	ld	(_i_main_flag,x),a
9146  1cb2 2006          	jra	L1104
9147  1cb4               L7004:
9148                     ; 1863 		else i_main_flag[i]=0;
9150  1cb4 7b03          	ld	a,(OFST-2,sp)
9151  1cb6 5f            	clrw	x
9152  1cb7 97            	ld	xl,a
9153  1cb8 6f14          	clr	(_i_main_flag,x)
9154  1cba               L1104:
9155                     ; 1864 		i_main_flag[adress]=1;
9157  1cba c60005        	ld	a,_adress
9158  1cbd 5f            	clrw	x
9159  1cbe 97            	ld	xl,a
9160  1cbf a601          	ld	a,#1
9161  1cc1 e714          	ld	(_i_main_flag,x),a
9162  1cc3               L1543:
9163                     ; 1870 can_in_an_end:
9163                     ; 1871 bCAN_RX=0;
9165  1cc3 3f0a          	clr	_bCAN_RX
9166                     ; 1872 }   
9169  1cc5 5b05          	addw	sp,#5
9170  1cc7 81            	ret
9193                     ; 1875 void t4_init(void){
9194                     	switch	.text
9195  1cc8               _t4_init:
9199                     ; 1876 	TIM4->PSCR = 4;
9201  1cc8 35045345      	mov	21317,#4
9202                     ; 1877 	TIM4->ARR= 61;
9204  1ccc 353d5346      	mov	21318,#61
9205                     ; 1878 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9207  1cd0 72105341      	bset	21313,#0
9208                     ; 1880 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9210  1cd4 35855340      	mov	21312,#133
9211                     ; 1882 }
9214  1cd8 81            	ret
9237                     ; 1885 void t1_init(void)
9237                     ; 1886 {
9238                     	switch	.text
9239  1cd9               _t1_init:
9243                     ; 1887 TIM1->ARRH= 0x03;
9245  1cd9 35035262      	mov	21090,#3
9246                     ; 1888 TIM1->ARRL= 0xff;
9248  1cdd 35ff5263      	mov	21091,#255
9249                     ; 1889 TIM1->CCR1H= 0x00;	
9251  1ce1 725f5265      	clr	21093
9252                     ; 1890 TIM1->CCR1L= 0xff;
9254  1ce5 35ff5266      	mov	21094,#255
9255                     ; 1891 TIM1->CCR2H= 0x00;	
9257  1ce9 725f5267      	clr	21095
9258                     ; 1892 TIM1->CCR2L= 0x00;
9260  1ced 725f5268      	clr	21096
9261                     ; 1893 TIM1->CCR3H= 0x00;	
9263  1cf1 725f5269      	clr	21097
9264                     ; 1894 TIM1->CCR3L= 0x64;
9266  1cf5 3564526a      	mov	21098,#100
9267                     ; 1896 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9269  1cf9 35685258      	mov	21080,#104
9270                     ; 1897 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9272  1cfd 35685259      	mov	21081,#104
9273                     ; 1898 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9275  1d01 3568525a      	mov	21082,#104
9276                     ; 1899 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9278  1d05 3511525c      	mov	21084,#17
9279                     ; 1900 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9281  1d09 3501525d      	mov	21085,#1
9282                     ; 1901 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9284  1d0d 35815250      	mov	21072,#129
9285                     ; 1902 TIM1->BKR|= TIM1_BKR_AOE;
9287  1d11 721c526d      	bset	21101,#6
9288                     ; 1903 }
9291  1d15 81            	ret
9316                     ; 1907 void adc2_init(void)
9316                     ; 1908 {
9317                     	switch	.text
9318  1d16               _adc2_init:
9322                     ; 1909 adc_plazma[0]++;
9324  1d16 beb5          	ldw	x,_adc_plazma
9325  1d18 1c0001        	addw	x,#1
9326  1d1b bfb5          	ldw	_adc_plazma,x
9327                     ; 1933 GPIOB->DDR&=~(1<<4);
9329  1d1d 72195007      	bres	20487,#4
9330                     ; 1934 GPIOB->CR1&=~(1<<4);
9332  1d21 72195008      	bres	20488,#4
9333                     ; 1935 GPIOB->CR2&=~(1<<4);
9335  1d25 72195009      	bres	20489,#4
9336                     ; 1937 GPIOB->DDR&=~(1<<5);
9338  1d29 721b5007      	bres	20487,#5
9339                     ; 1938 GPIOB->CR1&=~(1<<5);
9341  1d2d 721b5008      	bres	20488,#5
9342                     ; 1939 GPIOB->CR2&=~(1<<5);
9344  1d31 721b5009      	bres	20489,#5
9345                     ; 1941 GPIOB->DDR&=~(1<<6);
9347  1d35 721d5007      	bres	20487,#6
9348                     ; 1942 GPIOB->CR1&=~(1<<6);
9350  1d39 721d5008      	bres	20488,#6
9351                     ; 1943 GPIOB->CR2&=~(1<<6);
9353  1d3d 721d5009      	bres	20489,#6
9354                     ; 1945 GPIOB->DDR&=~(1<<7);
9356  1d41 721f5007      	bres	20487,#7
9357                     ; 1946 GPIOB->CR1&=~(1<<7);
9359  1d45 721f5008      	bres	20488,#7
9360                     ; 1947 GPIOB->CR2&=~(1<<7);
9362  1d49 721f5009      	bres	20489,#7
9363                     ; 1957 ADC2->TDRL=0xff;
9365  1d4d 35ff5407      	mov	21511,#255
9366                     ; 1959 ADC2->CR2=0x08;
9368  1d51 35085402      	mov	21506,#8
9369                     ; 1960 ADC2->CR1=0x40;
9371  1d55 35405401      	mov	21505,#64
9372                     ; 1963 	ADC2->CSR=0x20+adc_ch+3;
9374  1d59 b6c2          	ld	a,_adc_ch
9375  1d5b ab23          	add	a,#35
9376  1d5d c75400        	ld	21504,a
9377                     ; 1965 	ADC2->CR1|=1;
9379  1d60 72105401      	bset	21505,#0
9380                     ; 1966 	ADC2->CR1|=1;
9382  1d64 72105401      	bset	21505,#0
9383                     ; 1969 adc_plazma[1]=adc_ch;
9385  1d68 b6c2          	ld	a,_adc_ch
9386  1d6a 5f            	clrw	x
9387  1d6b 97            	ld	xl,a
9388  1d6c bfb7          	ldw	_adc_plazma+2,x
9389                     ; 1970 }
9392  1d6e 81            	ret
9426                     ; 1979 @far @interrupt void TIM4_UPD_Interrupt (void) 
9426                     ; 1980 {
9428                     	switch	.text
9429  1d6f               f_TIM4_UPD_Interrupt:
9433                     ; 1981 TIM4->SR1&=~TIM4_SR1_UIF;
9435  1d6f 72115342      	bres	21314,#0
9436                     ; 1983 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9438  1d73 3c08          	inc	_pwm_vent_cnt
9439  1d75 b608          	ld	a,_pwm_vent_cnt
9440  1d77 a10a          	cp	a,#10
9441  1d79 2502          	jrult	L3504
9444  1d7b 3f08          	clr	_pwm_vent_cnt
9445  1d7d               L3504:
9446                     ; 1984 GPIOB->ODR|=(1<<3);
9448  1d7d 72165005      	bset	20485,#3
9449                     ; 1985 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9451  1d81 b608          	ld	a,_pwm_vent_cnt
9452  1d83 a105          	cp	a,#5
9453  1d85 2504          	jrult	L5504
9456  1d87 72175005      	bres	20485,#3
9457  1d8b               L5504:
9458                     ; 1990 if(++t0_cnt0>=100)
9460  1d8b 9c            	rvf
9461  1d8c be01          	ldw	x,_t0_cnt0
9462  1d8e 1c0001        	addw	x,#1
9463  1d91 bf01          	ldw	_t0_cnt0,x
9464  1d93 a30064        	cpw	x,#100
9465  1d96 2f3f          	jrslt	L7504
9466                     ; 1992 	t0_cnt0=0;
9468  1d98 5f            	clrw	x
9469  1d99 bf01          	ldw	_t0_cnt0,x
9470                     ; 1993 	b100Hz=1;
9472  1d9b 72100008      	bset	_b100Hz
9473                     ; 1995 	if(++t0_cnt1>=10)
9475  1d9f 3c03          	inc	_t0_cnt1
9476  1da1 b603          	ld	a,_t0_cnt1
9477  1da3 a10a          	cp	a,#10
9478  1da5 2506          	jrult	L1604
9479                     ; 1997 		t0_cnt1=0;
9481  1da7 3f03          	clr	_t0_cnt1
9482                     ; 1998 		b10Hz=1;
9484  1da9 72100007      	bset	_b10Hz
9485  1dad               L1604:
9486                     ; 2001 	if(++t0_cnt2>=20)
9488  1dad 3c04          	inc	_t0_cnt2
9489  1daf b604          	ld	a,_t0_cnt2
9490  1db1 a114          	cp	a,#20
9491  1db3 2506          	jrult	L3604
9492                     ; 2003 		t0_cnt2=0;
9494  1db5 3f04          	clr	_t0_cnt2
9495                     ; 2004 		b5Hz=1;
9497  1db7 72100006      	bset	_b5Hz
9498  1dbb               L3604:
9499                     ; 2008 	if(++t0_cnt4>=50)
9501  1dbb 3c06          	inc	_t0_cnt4
9502  1dbd b606          	ld	a,_t0_cnt4
9503  1dbf a132          	cp	a,#50
9504  1dc1 2506          	jrult	L5604
9505                     ; 2010 		t0_cnt4=0;
9507  1dc3 3f06          	clr	_t0_cnt4
9508                     ; 2011 		b2Hz=1;
9510  1dc5 72100005      	bset	_b2Hz
9511  1dc9               L5604:
9512                     ; 2014 	if(++t0_cnt3>=100)
9514  1dc9 3c05          	inc	_t0_cnt3
9515  1dcb b605          	ld	a,_t0_cnt3
9516  1dcd a164          	cp	a,#100
9517  1dcf 2506          	jrult	L7504
9518                     ; 2016 		t0_cnt3=0;
9520  1dd1 3f05          	clr	_t0_cnt3
9521                     ; 2017 		b1Hz=1;
9523  1dd3 72100004      	bset	_b1Hz
9524  1dd7               L7504:
9525                     ; 2023 }
9528  1dd7 80            	iret
9553                     ; 2026 @far @interrupt void CAN_RX_Interrupt (void) 
9553                     ; 2027 {
9554                     	switch	.text
9555  1dd8               f_CAN_RX_Interrupt:
9559                     ; 2029 CAN->PSR= 7;									// page 7 - read messsage
9561  1dd8 35075427      	mov	21543,#7
9562                     ; 2031 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9564  1ddc ae000e        	ldw	x,#14
9565  1ddf               L652:
9566  1ddf d65427        	ld	a,(21543,x)
9567  1de2 e7c2          	ld	(_mess-1,x),a
9568  1de4 5a            	decw	x
9569  1de5 26f8          	jrne	L652
9570                     ; 2042 bCAN_RX=1;
9572  1de7 3501000a      	mov	_bCAN_RX,#1
9573                     ; 2043 CAN->RFR|=(1<<5);
9575  1deb 721a5424      	bset	21540,#5
9576                     ; 2045 }
9579  1def 80            	iret
9602                     ; 2048 @far @interrupt void CAN_TX_Interrupt (void) 
9602                     ; 2049 {
9603                     	switch	.text
9604  1df0               f_CAN_TX_Interrupt:
9608                     ; 2050 if((CAN->TSR)&(1<<0))
9610  1df0 c65422        	ld	a,21538
9611  1df3 a501          	bcp	a,#1
9612  1df5 2708          	jreq	L1114
9613                     ; 2052 	bTX_FREE=1;	
9615  1df7 35010009      	mov	_bTX_FREE,#1
9616                     ; 2054 	CAN->TSR|=(1<<0);
9618  1dfb 72105422      	bset	21538,#0
9619  1dff               L1114:
9620                     ; 2056 }
9623  1dff 80            	iret
9681                     ; 2059 @far @interrupt void ADC2_EOC_Interrupt (void) {
9682                     	switch	.text
9683  1e00               f_ADC2_EOC_Interrupt:
9685       00000009      OFST:	set	9
9686  1e00 be00          	ldw	x,c_x
9687  1e02 89            	pushw	x
9688  1e03 be00          	ldw	x,c_y
9689  1e05 89            	pushw	x
9690  1e06 be02          	ldw	x,c_lreg+2
9691  1e08 89            	pushw	x
9692  1e09 be00          	ldw	x,c_lreg
9693  1e0b 89            	pushw	x
9694  1e0c 5209          	subw	sp,#9
9697                     ; 2064 adc_plazma[2]++;
9699  1e0e beb9          	ldw	x,_adc_plazma+4
9700  1e10 1c0001        	addw	x,#1
9701  1e13 bfb9          	ldw	_adc_plazma+4,x
9702                     ; 2071 ADC2->CSR&=~(1<<7);
9704  1e15 721f5400      	bres	21504,#7
9705                     ; 2073 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9707  1e19 c65405        	ld	a,21509
9708  1e1c b703          	ld	c_lreg+3,a
9709  1e1e 3f02          	clr	c_lreg+2
9710  1e20 3f01          	clr	c_lreg+1
9711  1e22 3f00          	clr	c_lreg
9712  1e24 96            	ldw	x,sp
9713  1e25 1c0001        	addw	x,#OFST-8
9714  1e28 cd0000        	call	c_rtol
9716  1e2b c65404        	ld	a,21508
9717  1e2e 5f            	clrw	x
9718  1e2f 97            	ld	xl,a
9719  1e30 90ae0100      	ldw	y,#256
9720  1e34 cd0000        	call	c_umul
9722  1e37 96            	ldw	x,sp
9723  1e38 1c0001        	addw	x,#OFST-8
9724  1e3b cd0000        	call	c_ladd
9726  1e3e 96            	ldw	x,sp
9727  1e3f 1c0006        	addw	x,#OFST-3
9728  1e42 cd0000        	call	c_rtol
9730                     ; 2078 if(adr_drv_stat==1)
9732  1e45 b608          	ld	a,_adr_drv_stat
9733  1e47 a101          	cp	a,#1
9734  1e49 260b          	jrne	L1414
9735                     ; 2080 	adr_drv_stat=2;
9737  1e4b 35020008      	mov	_adr_drv_stat,#2
9738                     ; 2081 	adc_buff_[0]=temp_adc;
9740  1e4f 1e08          	ldw	x,(OFST-1,sp)
9741  1e51 cf0009        	ldw	_adc_buff_,x
9743  1e54 2020          	jra	L3414
9744  1e56               L1414:
9745                     ; 2084 else if(adr_drv_stat==3)
9747  1e56 b608          	ld	a,_adr_drv_stat
9748  1e58 a103          	cp	a,#3
9749  1e5a 260b          	jrne	L5414
9750                     ; 2086 	adr_drv_stat=4;
9752  1e5c 35040008      	mov	_adr_drv_stat,#4
9753                     ; 2087 	adc_buff_[1]=temp_adc;
9755  1e60 1e08          	ldw	x,(OFST-1,sp)
9756  1e62 cf000b        	ldw	_adc_buff_+2,x
9758  1e65 200f          	jra	L3414
9759  1e67               L5414:
9760                     ; 2090 else if(adr_drv_stat==5)
9762  1e67 b608          	ld	a,_adr_drv_stat
9763  1e69 a105          	cp	a,#5
9764  1e6b 2609          	jrne	L3414
9765                     ; 2092 	adr_drv_stat=6;
9767  1e6d 35060008      	mov	_adr_drv_stat,#6
9768                     ; 2093 	adc_buff_[9]=temp_adc;
9770  1e71 1e08          	ldw	x,(OFST-1,sp)
9771  1e73 cf001b        	ldw	_adc_buff_+18,x
9772  1e76               L3414:
9773                     ; 2096 adc_buff[adc_ch][adc_cnt]=temp_adc;
9775  1e76 b6c1          	ld	a,_adc_cnt
9776  1e78 5f            	clrw	x
9777  1e79 97            	ld	xl,a
9778  1e7a 58            	sllw	x
9779  1e7b 1f03          	ldw	(OFST-6,sp),x
9780  1e7d b6c2          	ld	a,_adc_ch
9781  1e7f 97            	ld	xl,a
9782  1e80 a620          	ld	a,#32
9783  1e82 42            	mul	x,a
9784  1e83 72fb03        	addw	x,(OFST-6,sp)
9785  1e86 1608          	ldw	y,(OFST-1,sp)
9786  1e88 df001d        	ldw	(_adc_buff,x),y
9787                     ; 2102 adc_ch++;
9789  1e8b 3cc2          	inc	_adc_ch
9790                     ; 2103 if(adc_ch>=5)
9792  1e8d b6c2          	ld	a,_adc_ch
9793  1e8f a105          	cp	a,#5
9794  1e91 250c          	jrult	L3514
9795                     ; 2106 	adc_ch=0;
9797  1e93 3fc2          	clr	_adc_ch
9798                     ; 2107 	adc_cnt++;
9800  1e95 3cc1          	inc	_adc_cnt
9801                     ; 2108 	if(adc_cnt>=16)
9803  1e97 b6c1          	ld	a,_adc_cnt
9804  1e99 a110          	cp	a,#16
9805  1e9b 2502          	jrult	L3514
9806                     ; 2110 		adc_cnt=0;
9808  1e9d 3fc1          	clr	_adc_cnt
9809  1e9f               L3514:
9810                     ; 2114 if((adc_cnt&0x03)==0)
9812  1e9f b6c1          	ld	a,_adc_cnt
9813  1ea1 a503          	bcp	a,#3
9814  1ea3 264b          	jrne	L7514
9815                     ; 2118 	tempSS=0;
9817  1ea5 ae0000        	ldw	x,#0
9818  1ea8 1f08          	ldw	(OFST-1,sp),x
9819  1eaa ae0000        	ldw	x,#0
9820  1ead 1f06          	ldw	(OFST-3,sp),x
9821                     ; 2119 	for(i=0;i<16;i++)
9823  1eaf 0f05          	clr	(OFST-4,sp)
9824  1eb1               L1614:
9825                     ; 2121 		tempSS+=(signed long)adc_buff[adc_ch][i];
9827  1eb1 7b05          	ld	a,(OFST-4,sp)
9828  1eb3 5f            	clrw	x
9829  1eb4 97            	ld	xl,a
9830  1eb5 58            	sllw	x
9831  1eb6 1f03          	ldw	(OFST-6,sp),x
9832  1eb8 b6c2          	ld	a,_adc_ch
9833  1eba 97            	ld	xl,a
9834  1ebb a620          	ld	a,#32
9835  1ebd 42            	mul	x,a
9836  1ebe 72fb03        	addw	x,(OFST-6,sp)
9837  1ec1 de001d        	ldw	x,(_adc_buff,x)
9838  1ec4 cd0000        	call	c_itolx
9840  1ec7 96            	ldw	x,sp
9841  1ec8 1c0006        	addw	x,#OFST-3
9842  1ecb cd0000        	call	c_lgadd
9844                     ; 2119 	for(i=0;i<16;i++)
9846  1ece 0c05          	inc	(OFST-4,sp)
9849  1ed0 7b05          	ld	a,(OFST-4,sp)
9850  1ed2 a110          	cp	a,#16
9851  1ed4 25db          	jrult	L1614
9852                     ; 2123 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9854  1ed6 96            	ldw	x,sp
9855  1ed7 1c0006        	addw	x,#OFST-3
9856  1eda cd0000        	call	c_ltor
9858  1edd a604          	ld	a,#4
9859  1edf cd0000        	call	c_lrsh
9861  1ee2 be02          	ldw	x,c_lreg+2
9862  1ee4 b6c2          	ld	a,_adc_ch
9863  1ee6 905f          	clrw	y
9864  1ee8 9097          	ld	yl,a
9865  1eea 9058          	sllw	y
9866  1eec 90df0009      	ldw	(_adc_buff_,y),x
9867  1ef0               L7514:
9868                     ; 2134 adc_plazma_short++;
9870  1ef0 bebf          	ldw	x,_adc_plazma_short
9871  1ef2 1c0001        	addw	x,#1
9872  1ef5 bfbf          	ldw	_adc_plazma_short,x
9873                     ; 2149 }
9876  1ef7 5b09          	addw	sp,#9
9877  1ef9 85            	popw	x
9878  1efa bf00          	ldw	c_lreg,x
9879  1efc 85            	popw	x
9880  1efd bf02          	ldw	c_lreg+2,x
9881  1eff 85            	popw	x
9882  1f00 bf00          	ldw	c_y,x
9883  1f02 85            	popw	x
9884  1f03 bf00          	ldw	c_x,x
9885  1f05 80            	iret
9949                     ; 2157 main()
9949                     ; 2158 {
9951                     	switch	.text
9952  1f06               _main:
9956                     ; 2160 CLK->ECKR|=1;
9958  1f06 721050c1      	bset	20673,#0
9960  1f0a               L1024:
9961                     ; 2161 while((CLK->ECKR & 2) == 0);
9963  1f0a c650c1        	ld	a,20673
9964  1f0d a502          	bcp	a,#2
9965  1f0f 27f9          	jreq	L1024
9966                     ; 2162 CLK->SWCR|=2;
9968  1f11 721250c5      	bset	20677,#1
9969                     ; 2163 CLK->SWR=0xB4;
9971  1f15 35b450c4      	mov	20676,#180
9972                     ; 2165 delay_ms(200);
9974  1f19 ae00c8        	ldw	x,#200
9975  1f1c cd011d        	call	_delay_ms
9977                     ; 2166 FLASH_DUKR=0xae;
9979  1f1f 35ae5064      	mov	_FLASH_DUKR,#174
9980                     ; 2167 FLASH_DUKR=0x56;
9982  1f23 35565064      	mov	_FLASH_DUKR,#86
9983                     ; 2168 enableInterrupts();
9986  1f27 9a            rim
9988                     ; 2171 adr_drv_v3();
9991  1f28 cd1107        	call	_adr_drv_v3
9993                     ; 2175 t4_init();
9995  1f2b cd1cc8        	call	_t4_init
9997                     ; 2177 		GPIOG->DDR|=(1<<0);
9999  1f2e 72105020      	bset	20512,#0
10000                     ; 2178 		GPIOG->CR1|=(1<<0);
10002  1f32 72105021      	bset	20513,#0
10003                     ; 2179 		GPIOG->CR2&=~(1<<0);	
10005  1f36 72115022      	bres	20514,#0
10006                     ; 2182 		GPIOG->DDR&=~(1<<1);
10008  1f3a 72135020      	bres	20512,#1
10009                     ; 2183 		GPIOG->CR1|=(1<<1);
10011  1f3e 72125021      	bset	20513,#1
10012                     ; 2184 		GPIOG->CR2&=~(1<<1);
10014  1f42 72135022      	bres	20514,#1
10015                     ; 2186 init_CAN();
10017  1f46 cd144a        	call	_init_CAN
10019                     ; 2191 GPIOC->DDR|=(1<<1);
10021  1f49 7212500c      	bset	20492,#1
10022                     ; 2192 GPIOC->CR1|=(1<<1);
10024  1f4d 7212500d      	bset	20493,#1
10025                     ; 2193 GPIOC->CR2|=(1<<1);
10027  1f51 7212500e      	bset	20494,#1
10028                     ; 2195 GPIOC->DDR|=(1<<2);
10030  1f55 7214500c      	bset	20492,#2
10031                     ; 2196 GPIOC->CR1|=(1<<2);
10033  1f59 7214500d      	bset	20493,#2
10034                     ; 2197 GPIOC->CR2|=(1<<2);
10036  1f5d 7214500e      	bset	20494,#2
10037                     ; 2204 t1_init();
10039  1f61 cd1cd9        	call	_t1_init
10041                     ; 2206 GPIOA->DDR|=(1<<5);
10043  1f64 721a5002      	bset	20482,#5
10044                     ; 2207 GPIOA->CR1|=(1<<5);
10046  1f68 721a5003      	bset	20483,#5
10047                     ; 2208 GPIOA->CR2&=~(1<<5);
10049  1f6c 721b5004      	bres	20484,#5
10050                     ; 2214 GPIOB->DDR&=~(1<<3);
10052  1f70 72175007      	bres	20487,#3
10053                     ; 2215 GPIOB->CR1&=~(1<<3);
10055  1f74 72175008      	bres	20488,#3
10056                     ; 2216 GPIOB->CR2&=~(1<<3);
10058  1f78 72175009      	bres	20489,#3
10059                     ; 2218 GPIOC->DDR|=(1<<3);
10061  1f7c 7216500c      	bset	20492,#3
10062                     ; 2219 GPIOC->CR1|=(1<<3);
10064  1f80 7216500d      	bset	20493,#3
10065                     ; 2220 GPIOC->CR2|=(1<<3);
10067  1f84 7216500e      	bset	20494,#3
10068                     ; 2223 if(bps_class==bpsIPS) 
10070  1f88 b604          	ld	a,_bps_class
10071  1f8a a101          	cp	a,#1
10072  1f8c 260a          	jrne	L7024
10073                     ; 2225 	pwm_u=ee_U_AVT;
10075  1f8e ce000c        	ldw	x,_ee_U_AVT
10076  1f91 bf0c          	ldw	_pwm_u,x
10077                     ; 2226 	volum_u_main_=ee_U_AVT;
10079  1f93 ce000c        	ldw	x,_ee_U_AVT
10080  1f96 bf1d          	ldw	_volum_u_main_,x
10081  1f98               L7024:
10082                     ; 2233 	if(bCAN_RX)
10084  1f98 3d0a          	tnz	_bCAN_RX
10085  1f9a 2705          	jreq	L3124
10086                     ; 2235 		bCAN_RX=0;
10088  1f9c 3f0a          	clr	_bCAN_RX
10089                     ; 2236 		can_in_an();	
10091  1f9e cd1655        	call	_can_in_an
10093  1fa1               L3124:
10094                     ; 2238 	if(b100Hz)
10096                     	btst	_b100Hz
10097  1fa6 240a          	jruge	L5124
10098                     ; 2240 		b100Hz=0;
10100  1fa8 72110008      	bres	_b100Hz
10101                     ; 2249 		adc2_init();
10103  1fac cd1d16        	call	_adc2_init
10105                     ; 2250 		can_tx_hndl();
10107  1faf cd153d        	call	_can_tx_hndl
10109  1fb2               L5124:
10110                     ; 2253 	if(b10Hz)
10112                     	btst	_b10Hz
10113  1fb7 2419          	jruge	L7124
10114                     ; 2255 		b10Hz=0;
10116  1fb9 72110007      	bres	_b10Hz
10117                     ; 2257           matemat();
10119  1fbd cd0cbe        	call	_matemat
10121                     ; 2258 	    	led_drv(); 
10123  1fc0 cd07e2        	call	_led_drv
10125                     ; 2259 	     link_drv();
10127  1fc3 cd08d0        	call	_link_drv
10129                     ; 2260 	     pwr_hndl();		//вычисление воздействий на силу
10131  1fc6 cd0ba2        	call	_pwr_hndl
10133                     ; 2261 	     JP_drv();
10135  1fc9 cd0845        	call	_JP_drv
10137                     ; 2262 	     flags_drv();
10139  1fcc cd10bc        	call	_flags_drv
10141                     ; 2263 		net_drv();
10143  1fcf cd15a7        	call	_net_drv
10145  1fd2               L7124:
10146                     ; 2266 	if(b5Hz)
10148                     	btst	_b5Hz
10149  1fd7 240d          	jruge	L1224
10150                     ; 2268 		b5Hz=0;
10152  1fd9 72110006      	bres	_b5Hz
10153                     ; 2270 		pwr_drv();		//воздействие на силу
10155  1fdd cd0a82        	call	_pwr_drv
10157                     ; 2271 		led_hndl();
10159  1fe0 cd015f        	call	_led_hndl
10161                     ; 2273 		vent_drv();
10163  1fe3 cd091f        	call	_vent_drv
10165  1fe6               L1224:
10166                     ; 2276 	if(b2Hz)
10168                     	btst	_b2Hz
10169  1feb 2404          	jruge	L3224
10170                     ; 2278 		b2Hz=0;
10172  1fed 72110005      	bres	_b2Hz
10173  1ff1               L3224:
10174                     ; 2287 	if(b1Hz)
10176                     	btst	_b1Hz
10177  1ff6 24a0          	jruge	L7024
10178                     ; 2289 		b1Hz=0;
10180  1ff8 72110004      	bres	_b1Hz
10181                     ; 2291 		temper_drv();			//вычисление аварий температуры
10183  1ffc cd0dec        	call	_temper_drv
10185                     ; 2292 		u_drv();
10187  1fff cd0ec3        	call	_u_drv
10189                     ; 2293           x_drv();
10191  2002 cd0fa3        	call	_x_drv
10193                     ; 2294           if(main_cnt<1000)main_cnt++;
10195  2005 9c            	rvf
10196  2006 be51          	ldw	x,_main_cnt
10197  2008 a303e8        	cpw	x,#1000
10198  200b 2e07          	jrsge	L7224
10201  200d be51          	ldw	x,_main_cnt
10202  200f 1c0001        	addw	x,#1
10203  2012 bf51          	ldw	_main_cnt,x
10204  2014               L7224:
10205                     ; 2295   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10207  2014 b662          	ld	a,_link
10208  2016 a1aa          	cp	a,#170
10209  2018 2706          	jreq	L3324
10211  201a b64a          	ld	a,_jp_mode
10212  201c a103          	cp	a,#3
10213  201e 2603          	jrne	L1324
10214  2020               L3324:
10217  2020 cd101d        	call	_apv_hndl
10219  2023               L1324:
10220                     ; 2298   		can_error_cnt++;
10222  2023 3c70          	inc	_can_error_cnt
10223                     ; 2299   		if(can_error_cnt>=10)
10225  2025 b670          	ld	a,_can_error_cnt
10226  2027 a10a          	cp	a,#10
10227  2029 2505          	jrult	L5324
10228                     ; 2301   			can_error_cnt=0;
10230  202b 3f70          	clr	_can_error_cnt
10231                     ; 2302 			init_CAN();
10233  202d cd144a        	call	_init_CAN
10235  2030               L5324:
10236                     ; 2306 		volum_u_main_drv();
10238  2030 cd12f7        	call	_volum_u_main_drv
10240                     ; 2308 		pwm_stat++;
10242  2033 3c07          	inc	_pwm_stat
10243                     ; 2309 		if(pwm_stat>=10)pwm_stat=0;
10245  2035 b607          	ld	a,_pwm_stat
10246  2037 a10a          	cp	a,#10
10247  2039 2502          	jrult	L7324
10250  203b 3f07          	clr	_pwm_stat
10251  203d               L7324:
10252                     ; 2310 adc_plazma_short++;
10254  203d bebf          	ldw	x,_adc_plazma_short
10255  203f 1c0001        	addw	x,#1
10256  2042 bfbf          	ldw	_adc_plazma_short,x
10257                     ; 2312 		vent_resurs_hndl();
10259  2044 cd0000        	call	_vent_resurs_hndl
10261  2047 ac981f98      	jpf	L7024
11322                     	xdef	_main
11323                     	xdef	f_ADC2_EOC_Interrupt
11324                     	xdef	f_CAN_TX_Interrupt
11325                     	xdef	f_CAN_RX_Interrupt
11326                     	xdef	f_TIM4_UPD_Interrupt
11327                     	xdef	_adc2_init
11328                     	xdef	_t1_init
11329                     	xdef	_t4_init
11330                     	xdef	_can_in_an
11331                     	xdef	_net_drv
11332                     	xdef	_can_tx_hndl
11333                     	xdef	_can_transmit
11334                     	xdef	_init_CAN
11335                     	xdef	_volum_u_main_drv
11336                     	xdef	_adr_drv_v3
11337                     	xdef	_adr_drv_v4
11338                     	xdef	_flags_drv
11339                     	xdef	_apv_hndl
11340                     	xdef	_apv_stop
11341                     	xdef	_apv_start
11342                     	xdef	_x_drv
11343                     	xdef	_u_drv
11344                     	xdef	_temper_drv
11345                     	xdef	_matemat
11346                     	xdef	_pwr_hndl
11347                     	xdef	_pwr_drv
11348                     	xdef	_vent_drv
11349                     	xdef	_link_drv
11350                     	xdef	_JP_drv
11351                     	xdef	_led_drv
11352                     	xdef	_led_hndl
11353                     	xdef	_delay_ms
11354                     	xdef	_granee
11355                     	xdef	_gran
11356                     	xdef	_vent_resurs_hndl
11357                     	switch	.ubsct
11358  0001               _vent_resurs_tx_cnt:
11359  0001 00            	ds.b	1
11360                     	xdef	_vent_resurs_tx_cnt
11361                     	switch	.bss
11362  0000               _vent_resurs_buff:
11363  0000 00000000      	ds.b	4
11364                     	xdef	_vent_resurs_buff
11365                     	switch	.ubsct
11366  0002               _vent_resurs_sec_cnt:
11367  0002 0000          	ds.b	2
11368                     	xdef	_vent_resurs_sec_cnt
11369                     .eeprom:	section	.data
11370  0000               _vent_resurs:
11371  0000 0000          	ds.b	2
11372                     	xdef	_vent_resurs
11373  0002               _ee_IMAXVENT:
11374  0002 0000          	ds.b	2
11375                     	xdef	_ee_IMAXVENT
11376                     	switch	.ubsct
11377  0004               _bps_class:
11378  0004 00            	ds.b	1
11379                     	xdef	_bps_class
11380  0005               _vent_pwm:
11381  0005 0000          	ds.b	2
11382                     	xdef	_vent_pwm
11383  0007               _pwm_stat:
11384  0007 00            	ds.b	1
11385                     	xdef	_pwm_stat
11386  0008               _pwm_vent_cnt:
11387  0008 00            	ds.b	1
11388                     	xdef	_pwm_vent_cnt
11389                     	switch	.eeprom
11390  0004               _ee_DEVICE:
11391  0004 0000          	ds.b	2
11392                     	xdef	_ee_DEVICE
11393  0006               _ee_AVT_MODE:
11394  0006 0000          	ds.b	2
11395                     	xdef	_ee_AVT_MODE
11396                     	switch	.ubsct
11397  0009               _i_main_bps_cnt:
11398  0009 000000000000  	ds.b	6
11399                     	xdef	_i_main_bps_cnt
11400  000f               _i_main_sigma:
11401  000f 0000          	ds.b	2
11402                     	xdef	_i_main_sigma
11403  0011               _i_main_num_of_bps:
11404  0011 00            	ds.b	1
11405                     	xdef	_i_main_num_of_bps
11406  0012               _i_main_avg:
11407  0012 0000          	ds.b	2
11408                     	xdef	_i_main_avg
11409  0014               _i_main_flag:
11410  0014 000000000000  	ds.b	6
11411                     	xdef	_i_main_flag
11412  001a               _i_main:
11413  001a 000000000000  	ds.b	12
11414                     	xdef	_i_main
11415  0026               _x:
11416  0026 000000000000  	ds.b	12
11417                     	xdef	_x
11418                     	xdef	_volum_u_main_
11419                     	switch	.eeprom
11420  0008               _UU_AVT:
11421  0008 0000          	ds.b	2
11422                     	xdef	_UU_AVT
11423                     	switch	.ubsct
11424  0032               _cnt_net_drv:
11425  0032 00            	ds.b	1
11426                     	xdef	_cnt_net_drv
11427                     	switch	.bit
11428  0001               _bMAIN:
11429  0001 00            	ds.b	1
11430                     	xdef	_bMAIN
11431                     	switch	.ubsct
11432  0033               _plazma_int:
11433  0033 000000000000  	ds.b	6
11434                     	xdef	_plazma_int
11435                     	xdef	_rotor_int
11436  0039               _led_green_buff:
11437  0039 00000000      	ds.b	4
11438                     	xdef	_led_green_buff
11439  003d               _led_red_buff:
11440  003d 00000000      	ds.b	4
11441                     	xdef	_led_red_buff
11442                     	xdef	_led_drv_cnt
11443                     	xdef	_led_green
11444                     	xdef	_led_red
11445  0041               _res_fl_cnt:
11446  0041 00            	ds.b	1
11447                     	xdef	_res_fl_cnt
11448                     	xdef	_bRES_
11449                     	xdef	_bRES
11450                     	switch	.eeprom
11451  000a               _res_fl_:
11452  000a 00            	ds.b	1
11453                     	xdef	_res_fl_
11454  000b               _res_fl:
11455  000b 00            	ds.b	1
11456                     	xdef	_res_fl
11457                     	switch	.ubsct
11458  0042               _cnt_apv_off:
11459  0042 00            	ds.b	1
11460                     	xdef	_cnt_apv_off
11461                     	switch	.bit
11462  0002               _bAPV:
11463  0002 00            	ds.b	1
11464                     	xdef	_bAPV
11465                     	switch	.ubsct
11466  0043               _apv_cnt_:
11467  0043 0000          	ds.b	2
11468                     	xdef	_apv_cnt_
11469  0045               _apv_cnt:
11470  0045 000000        	ds.b	3
11471                     	xdef	_apv_cnt
11472                     	xdef	_bBL_IPS
11473                     	switch	.bit
11474  0003               _bBL:
11475  0003 00            	ds.b	1
11476                     	xdef	_bBL
11477                     	switch	.ubsct
11478  0048               _cnt_JP1:
11479  0048 00            	ds.b	1
11480                     	xdef	_cnt_JP1
11481  0049               _cnt_JP0:
11482  0049 00            	ds.b	1
11483                     	xdef	_cnt_JP0
11484  004a               _jp_mode:
11485  004a 00            	ds.b	1
11486                     	xdef	_jp_mode
11487                     	xdef	_pwm_i
11488                     	xdef	_pwm_u
11489  004b               _tmax_cnt:
11490  004b 0000          	ds.b	2
11491                     	xdef	_tmax_cnt
11492  004d               _tsign_cnt:
11493  004d 0000          	ds.b	2
11494                     	xdef	_tsign_cnt
11495                     	switch	.eeprom
11496  000c               _ee_U_AVT:
11497  000c 0000          	ds.b	2
11498                     	xdef	_ee_U_AVT
11499  000e               _ee_tsign:
11500  000e 0000          	ds.b	2
11501                     	xdef	_ee_tsign
11502  0010               _ee_tmax:
11503  0010 0000          	ds.b	2
11504                     	xdef	_ee_tmax
11505  0012               _ee_dU:
11506  0012 0000          	ds.b	2
11507                     	xdef	_ee_dU
11508  0014               _ee_Umax:
11509  0014 0000          	ds.b	2
11510                     	xdef	_ee_Umax
11511  0016               _ee_TZAS:
11512  0016 0000          	ds.b	2
11513                     	xdef	_ee_TZAS
11514                     	switch	.ubsct
11515  004f               _main_cnt1:
11516  004f 0000          	ds.b	2
11517                     	xdef	_main_cnt1
11518  0051               _main_cnt:
11519  0051 0000          	ds.b	2
11520                     	xdef	_main_cnt
11521  0053               _off_bp_cnt:
11522  0053 00            	ds.b	1
11523                     	xdef	_off_bp_cnt
11524  0054               _flags_tu_cnt_off:
11525  0054 00            	ds.b	1
11526                     	xdef	_flags_tu_cnt_off
11527  0055               _flags_tu_cnt_on:
11528  0055 00            	ds.b	1
11529                     	xdef	_flags_tu_cnt_on
11530  0056               _vol_i_temp:
11531  0056 0000          	ds.b	2
11532                     	xdef	_vol_i_temp
11533  0058               _vol_u_temp:
11534  0058 0000          	ds.b	2
11535                     	xdef	_vol_u_temp
11536                     	switch	.eeprom
11537  0018               __x_ee_:
11538  0018 0000          	ds.b	2
11539                     	xdef	__x_ee_
11540                     	switch	.ubsct
11541  005a               __x_cnt:
11542  005a 0000          	ds.b	2
11543                     	xdef	__x_cnt
11544  005c               __x__:
11545  005c 0000          	ds.b	2
11546                     	xdef	__x__
11547  005e               __x_:
11548  005e 0000          	ds.b	2
11549                     	xdef	__x_
11550  0060               _flags_tu:
11551  0060 00            	ds.b	1
11552                     	xdef	_flags_tu
11553                     	xdef	_flags
11554  0061               _link_cnt:
11555  0061 00            	ds.b	1
11556                     	xdef	_link_cnt
11557  0062               _link:
11558  0062 00            	ds.b	1
11559                     	xdef	_link
11560  0063               _umin_cnt:
11561  0063 0000          	ds.b	2
11562                     	xdef	_umin_cnt
11563  0065               _umax_cnt:
11564  0065 0000          	ds.b	2
11565                     	xdef	_umax_cnt
11566                     	switch	.eeprom
11567  001a               _ee_K:
11568  001a 000000000000  	ds.b	16
11569                     	xdef	_ee_K
11570                     	switch	.ubsct
11571  0067               _T:
11572  0067 00            	ds.b	1
11573                     	xdef	_T
11574  0068               _Udb:
11575  0068 0000          	ds.b	2
11576                     	xdef	_Udb
11577  006a               _Ui:
11578  006a 0000          	ds.b	2
11579                     	xdef	_Ui
11580  006c               _Un:
11581  006c 0000          	ds.b	2
11582                     	xdef	_Un
11583  006e               _I:
11584  006e 0000          	ds.b	2
11585                     	xdef	_I
11586  0070               _can_error_cnt:
11587  0070 00            	ds.b	1
11588                     	xdef	_can_error_cnt
11589                     	xdef	_bCAN_RX
11590  0071               _tx_busy_cnt:
11591  0071 00            	ds.b	1
11592                     	xdef	_tx_busy_cnt
11593                     	xdef	_bTX_FREE
11594  0072               _can_buff_rd_ptr:
11595  0072 00            	ds.b	1
11596                     	xdef	_can_buff_rd_ptr
11597  0073               _can_buff_wr_ptr:
11598  0073 00            	ds.b	1
11599                     	xdef	_can_buff_wr_ptr
11600  0074               _can_out_buff:
11601  0074 000000000000  	ds.b	64
11602                     	xdef	_can_out_buff
11603                     	switch	.bss
11604  0004               _adress_error:
11605  0004 00            	ds.b	1
11606                     	xdef	_adress_error
11607  0005               _adress:
11608  0005 00            	ds.b	1
11609                     	xdef	_adress
11610  0006               _adr:
11611  0006 000000        	ds.b	3
11612                     	xdef	_adr
11613                     	xdef	_adr_drv_stat
11614                     	xdef	_led_ind
11615                     	switch	.ubsct
11616  00b4               _led_ind_cnt:
11617  00b4 00            	ds.b	1
11618                     	xdef	_led_ind_cnt
11619  00b5               _adc_plazma:
11620  00b5 000000000000  	ds.b	10
11621                     	xdef	_adc_plazma
11622  00bf               _adc_plazma_short:
11623  00bf 0000          	ds.b	2
11624                     	xdef	_adc_plazma_short
11625  00c1               _adc_cnt:
11626  00c1 00            	ds.b	1
11627                     	xdef	_adc_cnt
11628  00c2               _adc_ch:
11629  00c2 00            	ds.b	1
11630                     	xdef	_adc_ch
11631                     	switch	.bss
11632  0009               _adc_buff_:
11633  0009 000000000000  	ds.b	20
11634                     	xdef	_adc_buff_
11635  001d               _adc_buff:
11636  001d 000000000000  	ds.b	320
11637                     	xdef	_adc_buff
11638                     	switch	.ubsct
11639  00c3               _mess:
11640  00c3 000000000000  	ds.b	14
11641                     	xdef	_mess
11642                     	switch	.bit
11643  0004               _b1Hz:
11644  0004 00            	ds.b	1
11645                     	xdef	_b1Hz
11646  0005               _b2Hz:
11647  0005 00            	ds.b	1
11648                     	xdef	_b2Hz
11649  0006               _b5Hz:
11650  0006 00            	ds.b	1
11651                     	xdef	_b5Hz
11652  0007               _b10Hz:
11653  0007 00            	ds.b	1
11654                     	xdef	_b10Hz
11655  0008               _b100Hz:
11656  0008 00            	ds.b	1
11657                     	xdef	_b100Hz
11658                     	xdef	_t0_cnt4
11659                     	xdef	_t0_cnt3
11660                     	xdef	_t0_cnt2
11661                     	xdef	_t0_cnt1
11662                     	xdef	_t0_cnt0
11663                     	xdef	_bVENT_BLOCK
11664                     	xref.b	c_lreg
11665                     	xref.b	c_x
11666                     	xref.b	c_y
11686                     	xref	c_lrsh
11687                     	xref	c_lgadd
11688                     	xref	c_ladd
11689                     	xref	c_umul
11690                     	xref	c_lgmul
11691                     	xref	c_lgsub
11692                     	xref	c_lsbc
11693                     	xref	c_idiv
11694                     	xref	c_ldiv
11695                     	xref	c_itolx
11696                     	xref	c_eewrc
11697                     	xref	c_imul
11698                     	xref	c_ltor
11699                     	xref	c_lgadc
11700                     	xref	c_rtol
11701                     	xref	c_vmul
11702                     	xref	c_eewrw
11703                     	xref	c_lcmp
11704                     	xref	c_uitolx
11705                     	end
