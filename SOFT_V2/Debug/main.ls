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
2203  0000               _bBL_IPS:
2204  0000 00            	dc.b	0
2205                     	bsct
2206  0012               _bRES:
2207  0012 00            	dc.b	0
2208  0013               _bRES_:
2209  0013 00            	dc.b	0
2210  0014               _led_red:
2211  0014 00000000      	dc.l	0
2212  0018               _led_green:
2213  0018 03030303      	dc.l	50529027
2214  001c               _led_drv_cnt:
2215  001c 1e            	dc.b	30
2216  001d               _rotor_int:
2217  001d 007b          	dc.w	123
2218  001f               _volum_u_main_:
2219  001f 02bc          	dc.w	700
2264                     .const:	section	.text
2265  0000               L6:
2266  0000 0000ea60      	dc.l	60000
2267                     ; 178 void vent_resurs_hndl(void)
2267                     ; 179 {
2268                     	scross	off
2269                     	switch	.text
2270  0000               _vent_resurs_hndl:
2272  0000 88            	push	a
2273       00000001      OFST:	set	1
2276                     ; 181 if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
2278  0001 3d00          	tnz	_bVENT_BLOCK
2279  0003 2607          	jrne	L7441
2282  0005 be02          	ldw	x,_vent_resurs_sec_cnt
2283  0007 1c0001        	addw	x,#1
2284  000a bf02          	ldw	_vent_resurs_sec_cnt,x
2285  000c               L7441:
2286                     ; 182 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2288  000c be02          	ldw	x,_vent_resurs_sec_cnt
2289  000e a30e11        	cpw	x,#3601
2290  0011 251b          	jrult	L1541
2291                     ; 184 	if(vent_resurs<60000)vent_resurs++;
2293  0013 9c            	rvf
2294  0014 ce0000        	ldw	x,_vent_resurs
2295  0017 cd0000        	call	c_uitolx
2297  001a ae0000        	ldw	x,#L6
2298  001d cd0000        	call	c_lcmp
2300  0020 2e09          	jrsge	L3541
2303  0022 ce0000        	ldw	x,_vent_resurs
2304  0025 1c0001        	addw	x,#1
2305  0028 cf0000        	ldw	_vent_resurs,x
2306  002b               L3541:
2307                     ; 185 	vent_resurs_sec_cnt=0;
2309  002b 5f            	clrw	x
2310  002c bf02          	ldw	_vent_resurs_sec_cnt,x
2311  002e               L1541:
2312                     ; 190 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2314  002e c60001        	ld	a,_vent_resurs+1
2315  0031 a40f          	and	a,#15
2316  0033 c70000        	ld	_vent_resurs_buff,a
2317                     ; 191 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2319  0036 c60001        	ld	a,_vent_resurs+1
2320  0039 a4f0          	and	a,#240
2321  003b 4e            	swap	a
2322  003c a40f          	and	a,#15
2323  003e aa40          	or	a,#64
2324  0040 c70001        	ld	_vent_resurs_buff+1,a
2325                     ; 192 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2327  0043 c60000        	ld	a,_vent_resurs
2328  0046 97            	ld	xl,a
2329  0047 c60001        	ld	a,_vent_resurs+1
2330  004a 9f            	ld	a,xl
2331  004b a40f          	and	a,#15
2332  004d 97            	ld	xl,a
2333  004e 4f            	clr	a
2334  004f 02            	rlwa	x,a
2335  0050 4f            	clr	a
2336  0051 01            	rrwa	x,a
2337  0052 9f            	ld	a,xl
2338  0053 aa80          	or	a,#128
2339  0055 c70002        	ld	_vent_resurs_buff+2,a
2340                     ; 193 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2342  0058 c60000        	ld	a,_vent_resurs
2343  005b 97            	ld	xl,a
2344  005c c60001        	ld	a,_vent_resurs+1
2345  005f 9f            	ld	a,xl
2346  0060 a4f0          	and	a,#240
2347  0062 97            	ld	xl,a
2348  0063 4f            	clr	a
2349  0064 02            	rlwa	x,a
2350  0065 01            	rrwa	x,a
2351  0066 4f            	clr	a
2352  0067 41            	exg	a,xl
2353  0068 4e            	swap	a
2354  0069 a40f          	and	a,#15
2355  006b 02            	rlwa	x,a
2356  006c 9f            	ld	a,xl
2357  006d aac0          	or	a,#192
2358  006f c70003        	ld	_vent_resurs_buff+3,a
2359                     ; 195 temp=vent_resurs_buff[0]&0x0f;
2361  0072 c60000        	ld	a,_vent_resurs_buff
2362  0075 a40f          	and	a,#15
2363  0077 6b01          	ld	(OFST+0,sp),a
2364                     ; 196 temp^=vent_resurs_buff[1]&0x0f;
2366  0079 c60001        	ld	a,_vent_resurs_buff+1
2367  007c a40f          	and	a,#15
2368  007e 1801          	xor	a,(OFST+0,sp)
2369  0080 6b01          	ld	(OFST+0,sp),a
2370                     ; 197 temp^=vent_resurs_buff[2]&0x0f;
2372  0082 c60002        	ld	a,_vent_resurs_buff+2
2373  0085 a40f          	and	a,#15
2374  0087 1801          	xor	a,(OFST+0,sp)
2375  0089 6b01          	ld	(OFST+0,sp),a
2376                     ; 198 temp^=vent_resurs_buff[3]&0x0f;
2378  008b c60003        	ld	a,_vent_resurs_buff+3
2379  008e a40f          	and	a,#15
2380  0090 1801          	xor	a,(OFST+0,sp)
2381  0092 6b01          	ld	(OFST+0,sp),a
2382                     ; 200 vent_resurs_buff[0]|=(temp&0x03)<<4;
2384  0094 7b01          	ld	a,(OFST+0,sp)
2385  0096 a403          	and	a,#3
2386  0098 97            	ld	xl,a
2387  0099 a610          	ld	a,#16
2388  009b 42            	mul	x,a
2389  009c 9f            	ld	a,xl
2390  009d ca0000        	or	a,_vent_resurs_buff
2391  00a0 c70000        	ld	_vent_resurs_buff,a
2392                     ; 201 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2394  00a3 7b01          	ld	a,(OFST+0,sp)
2395  00a5 a40c          	and	a,#12
2396  00a7 48            	sll	a
2397  00a8 48            	sll	a
2398  00a9 ca0001        	or	a,_vent_resurs_buff+1
2399  00ac c70001        	ld	_vent_resurs_buff+1,a
2400                     ; 202 vent_resurs_buff[2]|=(temp&0x30);
2402  00af 7b01          	ld	a,(OFST+0,sp)
2403  00b1 a430          	and	a,#48
2404  00b3 ca0002        	or	a,_vent_resurs_buff+2
2405  00b6 c70002        	ld	_vent_resurs_buff+2,a
2406                     ; 203 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2408  00b9 7b01          	ld	a,(OFST+0,sp)
2409  00bb a4c0          	and	a,#192
2410  00bd 44            	srl	a
2411  00be 44            	srl	a
2412  00bf ca0003        	or	a,_vent_resurs_buff+3
2413  00c2 c70003        	ld	_vent_resurs_buff+3,a
2414                     ; 206 vent_resurs_tx_cnt++;
2416  00c5 3c01          	inc	_vent_resurs_tx_cnt
2417                     ; 207 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2419  00c7 b601          	ld	a,_vent_resurs_tx_cnt
2420  00c9 a104          	cp	a,#4
2421  00cb 2502          	jrult	L5541
2424  00cd 3f01          	clr	_vent_resurs_tx_cnt
2425  00cf               L5541:
2426                     ; 210 }
2429  00cf 84            	pop	a
2430  00d0 81            	ret
2483                     ; 213 void gran(signed short *adr, signed short min, signed short max)
2483                     ; 214 {
2484                     	switch	.text
2485  00d1               _gran:
2487  00d1 89            	pushw	x
2488       00000000      OFST:	set	0
2491                     ; 215 if (*adr<min) *adr=min;
2493  00d2 9c            	rvf
2494  00d3 9093          	ldw	y,x
2495  00d5 51            	exgw	x,y
2496  00d6 fe            	ldw	x,(x)
2497  00d7 1305          	cpw	x,(OFST+5,sp)
2498  00d9 51            	exgw	x,y
2499  00da 2e03          	jrsge	L5051
2502  00dc 1605          	ldw	y,(OFST+5,sp)
2503  00de ff            	ldw	(x),y
2504  00df               L5051:
2505                     ; 216 if (*adr>max) *adr=max; 
2507  00df 9c            	rvf
2508  00e0 1e01          	ldw	x,(OFST+1,sp)
2509  00e2 9093          	ldw	y,x
2510  00e4 51            	exgw	x,y
2511  00e5 fe            	ldw	x,(x)
2512  00e6 1307          	cpw	x,(OFST+7,sp)
2513  00e8 51            	exgw	x,y
2514  00e9 2d05          	jrsle	L7051
2517  00eb 1e01          	ldw	x,(OFST+1,sp)
2518  00ed 1607          	ldw	y,(OFST+7,sp)
2519  00ef ff            	ldw	(x),y
2520  00f0               L7051:
2521                     ; 217 } 
2524  00f0 85            	popw	x
2525  00f1 81            	ret
2578                     ; 220 void granee(@eeprom signed short *adr, signed short min, signed short max)
2578                     ; 221 {
2579                     	switch	.text
2580  00f2               _granee:
2582  00f2 89            	pushw	x
2583       00000000      OFST:	set	0
2586                     ; 222 if (*adr<min) *adr=min;
2588  00f3 9c            	rvf
2589  00f4 9093          	ldw	y,x
2590  00f6 51            	exgw	x,y
2591  00f7 fe            	ldw	x,(x)
2592  00f8 1305          	cpw	x,(OFST+5,sp)
2593  00fa 51            	exgw	x,y
2594  00fb 2e09          	jrsge	L7351
2597  00fd 1e05          	ldw	x,(OFST+5,sp)
2598  00ff 89            	pushw	x
2599  0100 1e03          	ldw	x,(OFST+3,sp)
2600  0102 cd0000        	call	c_eewrw
2602  0105 85            	popw	x
2603  0106               L7351:
2604                     ; 223 if (*adr>max) *adr=max; 
2606  0106 9c            	rvf
2607  0107 1e01          	ldw	x,(OFST+1,sp)
2608  0109 9093          	ldw	y,x
2609  010b 51            	exgw	x,y
2610  010c fe            	ldw	x,(x)
2611  010d 1307          	cpw	x,(OFST+7,sp)
2612  010f 51            	exgw	x,y
2613  0110 2d09          	jrsle	L1451
2616  0112 1e07          	ldw	x,(OFST+7,sp)
2617  0114 89            	pushw	x
2618  0115 1e03          	ldw	x,(OFST+3,sp)
2619  0117 cd0000        	call	c_eewrw
2621  011a 85            	popw	x
2622  011b               L1451:
2623                     ; 224 }
2626  011b 85            	popw	x
2627  011c 81            	ret
2688                     ; 227 long delay_ms(short in)
2688                     ; 228 {
2689                     	switch	.text
2690  011d               _delay_ms:
2692  011d 520c          	subw	sp,#12
2693       0000000c      OFST:	set	12
2696                     ; 231 i=((long)in)*100UL;
2698  011f 90ae0064      	ldw	y,#100
2699  0123 cd0000        	call	c_vmul
2701  0126 96            	ldw	x,sp
2702  0127 1c0005        	addw	x,#OFST-7
2703  012a cd0000        	call	c_rtol
2705                     ; 233 for(ii=0;ii<i;ii++)
2707  012d ae0000        	ldw	x,#0
2708  0130 1f0b          	ldw	(OFST-1,sp),x
2709  0132 ae0000        	ldw	x,#0
2710  0135 1f09          	ldw	(OFST-3,sp),x
2712  0137 2012          	jra	L1061
2713  0139               L5751:
2714                     ; 235 		iii++;
2716  0139 96            	ldw	x,sp
2717  013a 1c0001        	addw	x,#OFST-11
2718  013d a601          	ld	a,#1
2719  013f cd0000        	call	c_lgadc
2721                     ; 233 for(ii=0;ii<i;ii++)
2723  0142 96            	ldw	x,sp
2724  0143 1c0009        	addw	x,#OFST-3
2725  0146 a601          	ld	a,#1
2726  0148 cd0000        	call	c_lgadc
2728  014b               L1061:
2731  014b 9c            	rvf
2732  014c 96            	ldw	x,sp
2733  014d 1c0009        	addw	x,#OFST-3
2734  0150 cd0000        	call	c_ltor
2736  0153 96            	ldw	x,sp
2737  0154 1c0005        	addw	x,#OFST-7
2738  0157 cd0000        	call	c_lcmp
2740  015a 2fdd          	jrslt	L5751
2741                     ; 238 }
2744  015c 5b0c          	addw	sp,#12
2745  015e 81            	ret
2781                     ; 241 void led_hndl(void)
2781                     ; 242 {
2782                     	switch	.text
2783  015f               _led_hndl:
2787                     ; 243 if(adress_error)
2789  015f 725d0004      	tnz	_adress_error
2790  0163 2718          	jreq	L5161
2791                     ; 245 	led_red=0x55555555L;
2793  0165 ae5555        	ldw	x,#21845
2794  0168 bf16          	ldw	_led_red+2,x
2795  016a ae5555        	ldw	x,#21845
2796  016d bf14          	ldw	_led_red,x
2797                     ; 246 	led_green=0x55555555L;
2799  016f ae5555        	ldw	x,#21845
2800  0172 bf1a          	ldw	_led_green+2,x
2801  0174 ae5555        	ldw	x,#21845
2802  0177 bf18          	ldw	_led_green,x
2804  0179 ace107e1      	jpf	L7161
2805  017d               L5161:
2806                     ; 262 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2808  017d 3d04          	tnz	_bps_class
2809  017f 2703          	jreq	L02
2810  0181 cc0434        	jp	L1261
2811  0184               L02:
2812                     ; 264 	if(jp_mode!=jp3)
2814  0184 b64a          	ld	a,_jp_mode
2815  0186 a103          	cp	a,#3
2816  0188 2603          	jrne	L22
2817  018a cc0330        	jp	L3261
2818  018d               L22:
2819                     ; 266 		if(main_cnt1<(5*ee_TZAS))
2821  018d 9c            	rvf
2822  018e ce0016        	ldw	x,_ee_TZAS
2823  0191 90ae0005      	ldw	y,#5
2824  0195 cd0000        	call	c_imul
2826  0198 b34f          	cpw	x,_main_cnt1
2827  019a 2d18          	jrsle	L5261
2828                     ; 268 			led_red=0x00000000L;
2830  019c ae0000        	ldw	x,#0
2831  019f bf16          	ldw	_led_red+2,x
2832  01a1 ae0000        	ldw	x,#0
2833  01a4 bf14          	ldw	_led_red,x
2834                     ; 269 			led_green=0x03030303L;
2836  01a6 ae0303        	ldw	x,#771
2837  01a9 bf1a          	ldw	_led_green+2,x
2838  01ab ae0303        	ldw	x,#771
2839  01ae bf18          	ldw	_led_green,x
2841  01b0 acf102f1      	jpf	L7261
2842  01b4               L5261:
2843                     ; 272 		else if((link==ON)&&(flags_tu&0b10000000))
2845  01b4 b663          	ld	a,_link
2846  01b6 a155          	cp	a,#85
2847  01b8 261e          	jrne	L1361
2849  01ba b660          	ld	a,_flags_tu
2850  01bc a580          	bcp	a,#128
2851  01be 2718          	jreq	L1361
2852                     ; 274 			led_red=0x00055555L;
2854  01c0 ae5555        	ldw	x,#21845
2855  01c3 bf16          	ldw	_led_red+2,x
2856  01c5 ae0005        	ldw	x,#5
2857  01c8 bf14          	ldw	_led_red,x
2858                     ; 275 			led_green=0xffffffffL;
2860  01ca aeffff        	ldw	x,#65535
2861  01cd bf1a          	ldw	_led_green+2,x
2862  01cf aeffff        	ldw	x,#-1
2863  01d2 bf18          	ldw	_led_green,x
2865  01d4 acf102f1      	jpf	L7261
2866  01d8               L1361:
2867                     ; 278 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2869  01d8 9c            	rvf
2870  01d9 ce0016        	ldw	x,_ee_TZAS
2871  01dc 90ae0005      	ldw	y,#5
2872  01e0 cd0000        	call	c_imul
2874  01e3 b34f          	cpw	x,_main_cnt1
2875  01e5 2e37          	jrsge	L5361
2877  01e7 9c            	rvf
2878  01e8 ce0016        	ldw	x,_ee_TZAS
2879  01eb 90ae0005      	ldw	y,#5
2880  01ef cd0000        	call	c_imul
2882  01f2 1c0064        	addw	x,#100
2883  01f5 b34f          	cpw	x,_main_cnt1
2884  01f7 2d25          	jrsle	L5361
2886  01f9 ce0006        	ldw	x,_ee_AVT_MODE
2887  01fc a30055        	cpw	x,#85
2888  01ff 271d          	jreq	L5361
2890  0201 ce0004        	ldw	x,_ee_DEVICE
2891  0204 2618          	jrne	L5361
2892                     ; 280 			led_red=0x00000000L;
2894  0206 ae0000        	ldw	x,#0
2895  0209 bf16          	ldw	_led_red+2,x
2896  020b ae0000        	ldw	x,#0
2897  020e bf14          	ldw	_led_red,x
2898                     ; 281 			led_green=0xffffffffL;	
2900  0210 aeffff        	ldw	x,#65535
2901  0213 bf1a          	ldw	_led_green+2,x
2902  0215 aeffff        	ldw	x,#-1
2903  0218 bf18          	ldw	_led_green,x
2905  021a acf102f1      	jpf	L7261
2906  021e               L5361:
2907                     ; 284 		else  if(link==OFF)
2909  021e b663          	ld	a,_link
2910  0220 a1aa          	cp	a,#170
2911  0222 2618          	jrne	L1461
2912                     ; 286 			led_red=0x55555555L;
2914  0224 ae5555        	ldw	x,#21845
2915  0227 bf16          	ldw	_led_red+2,x
2916  0229 ae5555        	ldw	x,#21845
2917  022c bf14          	ldw	_led_red,x
2918                     ; 287 			led_green=0xffffffffL;
2920  022e aeffff        	ldw	x,#65535
2921  0231 bf1a          	ldw	_led_green+2,x
2922  0233 aeffff        	ldw	x,#-1
2923  0236 bf18          	ldw	_led_green,x
2925  0238 acf102f1      	jpf	L7261
2926  023c               L1461:
2927                     ; 290 		else if((link==ON)&&((flags&0b00111110)==0))
2929  023c b663          	ld	a,_link
2930  023e a155          	cp	a,#85
2931  0240 261d          	jrne	L5461
2933  0242 b60b          	ld	a,_flags
2934  0244 a53e          	bcp	a,#62
2935  0246 2617          	jrne	L5461
2936                     ; 292 			led_red=0x00000000L;
2938  0248 ae0000        	ldw	x,#0
2939  024b bf16          	ldw	_led_red+2,x
2940  024d ae0000        	ldw	x,#0
2941  0250 bf14          	ldw	_led_red,x
2942                     ; 293 			led_green=0xffffffffL;
2944  0252 aeffff        	ldw	x,#65535
2945  0255 bf1a          	ldw	_led_green+2,x
2946  0257 aeffff        	ldw	x,#-1
2947  025a bf18          	ldw	_led_green,x
2949  025c cc02f1        	jra	L7261
2950  025f               L5461:
2951                     ; 296 		else if((flags&0b00111110)==0b00000100)
2953  025f b60b          	ld	a,_flags
2954  0261 a43e          	and	a,#62
2955  0263 a104          	cp	a,#4
2956  0265 2616          	jrne	L1561
2957                     ; 298 			led_red=0x00010001L;
2959  0267 ae0001        	ldw	x,#1
2960  026a bf16          	ldw	_led_red+2,x
2961  026c ae0001        	ldw	x,#1
2962  026f bf14          	ldw	_led_red,x
2963                     ; 299 			led_green=0xffffffffL;	
2965  0271 aeffff        	ldw	x,#65535
2966  0274 bf1a          	ldw	_led_green+2,x
2967  0276 aeffff        	ldw	x,#-1
2968  0279 bf18          	ldw	_led_green,x
2970  027b 2074          	jra	L7261
2971  027d               L1561:
2972                     ; 301 		else if(flags&0b00000010)
2974  027d b60b          	ld	a,_flags
2975  027f a502          	bcp	a,#2
2976  0281 2716          	jreq	L5561
2977                     ; 303 			led_red=0x00010001L;
2979  0283 ae0001        	ldw	x,#1
2980  0286 bf16          	ldw	_led_red+2,x
2981  0288 ae0001        	ldw	x,#1
2982  028b bf14          	ldw	_led_red,x
2983                     ; 304 			led_green=0x00000000L;	
2985  028d ae0000        	ldw	x,#0
2986  0290 bf1a          	ldw	_led_green+2,x
2987  0292 ae0000        	ldw	x,#0
2988  0295 bf18          	ldw	_led_green,x
2990  0297 2058          	jra	L7261
2991  0299               L5561:
2992                     ; 306 		else if(flags&0b00001000)
2994  0299 b60b          	ld	a,_flags
2995  029b a508          	bcp	a,#8
2996  029d 2716          	jreq	L1661
2997                     ; 308 			led_red=0x00090009L;
2999  029f ae0009        	ldw	x,#9
3000  02a2 bf16          	ldw	_led_red+2,x
3001  02a4 ae0009        	ldw	x,#9
3002  02a7 bf14          	ldw	_led_red,x
3003                     ; 309 			led_green=0x00000000L;	
3005  02a9 ae0000        	ldw	x,#0
3006  02ac bf1a          	ldw	_led_green+2,x
3007  02ae ae0000        	ldw	x,#0
3008  02b1 bf18          	ldw	_led_green,x
3010  02b3 203c          	jra	L7261
3011  02b5               L1661:
3012                     ; 311 		else if(flags&0b00010000)
3014  02b5 b60b          	ld	a,_flags
3015  02b7 a510          	bcp	a,#16
3016  02b9 2716          	jreq	L5661
3017                     ; 313 			led_red=0x00490049L;
3019  02bb ae0049        	ldw	x,#73
3020  02be bf16          	ldw	_led_red+2,x
3021  02c0 ae0049        	ldw	x,#73
3022  02c3 bf14          	ldw	_led_red,x
3023                     ; 314 			led_green=0x00000000L;	
3025  02c5 ae0000        	ldw	x,#0
3026  02c8 bf1a          	ldw	_led_green+2,x
3027  02ca ae0000        	ldw	x,#0
3028  02cd bf18          	ldw	_led_green,x
3030  02cf 2020          	jra	L7261
3031  02d1               L5661:
3032                     ; 317 		else if((link==ON)&&(flags&0b00100000))
3034  02d1 b663          	ld	a,_link
3035  02d3 a155          	cp	a,#85
3036  02d5 261a          	jrne	L7261
3038  02d7 b60b          	ld	a,_flags
3039  02d9 a520          	bcp	a,#32
3040  02db 2714          	jreq	L7261
3041                     ; 319 			led_red=0x00000000L;
3043  02dd ae0000        	ldw	x,#0
3044  02e0 bf16          	ldw	_led_red+2,x
3045  02e2 ae0000        	ldw	x,#0
3046  02e5 bf14          	ldw	_led_red,x
3047                     ; 320 			led_green=0x00030003L;
3049  02e7 ae0003        	ldw	x,#3
3050  02ea bf1a          	ldw	_led_green+2,x
3051  02ec ae0003        	ldw	x,#3
3052  02ef bf18          	ldw	_led_green,x
3053  02f1               L7261:
3054                     ; 323 		if((jp_mode==jp1))
3056  02f1 b64a          	ld	a,_jp_mode
3057  02f3 a101          	cp	a,#1
3058  02f5 2618          	jrne	L3761
3059                     ; 325 			led_red=0x00000000L;
3061  02f7 ae0000        	ldw	x,#0
3062  02fa bf16          	ldw	_led_red+2,x
3063  02fc ae0000        	ldw	x,#0
3064  02ff bf14          	ldw	_led_red,x
3065                     ; 326 			led_green=0x33333333L;
3067  0301 ae3333        	ldw	x,#13107
3068  0304 bf1a          	ldw	_led_green+2,x
3069  0306 ae3333        	ldw	x,#13107
3070  0309 bf18          	ldw	_led_green,x
3072  030b ace107e1      	jpf	L7161
3073  030f               L3761:
3074                     ; 328 		else if((jp_mode==jp2))
3076  030f b64a          	ld	a,_jp_mode
3077  0311 a102          	cp	a,#2
3078  0313 2703          	jreq	L42
3079  0315 cc07e1        	jp	L7161
3080  0318               L42:
3081                     ; 330 			led_red=0xccccccccL;
3083  0318 aecccc        	ldw	x,#52428
3084  031b bf16          	ldw	_led_red+2,x
3085  031d aecccc        	ldw	x,#-13108
3086  0320 bf14          	ldw	_led_red,x
3087                     ; 331 			led_green=0x00000000L;
3089  0322 ae0000        	ldw	x,#0
3090  0325 bf1a          	ldw	_led_green+2,x
3091  0327 ae0000        	ldw	x,#0
3092  032a bf18          	ldw	_led_green,x
3093  032c ace107e1      	jpf	L7161
3094  0330               L3261:
3095                     ; 334 	else if(jp_mode==jp3)
3097  0330 b64a          	ld	a,_jp_mode
3098  0332 a103          	cp	a,#3
3099  0334 2703          	jreq	L62
3100  0336 cc07e1        	jp	L7161
3101  0339               L62:
3102                     ; 336 		if(main_cnt1<(5*ee_TZAS))
3104  0339 9c            	rvf
3105  033a ce0016        	ldw	x,_ee_TZAS
3106  033d 90ae0005      	ldw	y,#5
3107  0341 cd0000        	call	c_imul
3109  0344 b34f          	cpw	x,_main_cnt1
3110  0346 2d18          	jrsle	L5071
3111                     ; 338 			led_red=0x00000000L;
3113  0348 ae0000        	ldw	x,#0
3114  034b bf16          	ldw	_led_red+2,x
3115  034d ae0000        	ldw	x,#0
3116  0350 bf14          	ldw	_led_red,x
3117                     ; 339 			led_green=0x03030303L;
3119  0352 ae0303        	ldw	x,#771
3120  0355 bf1a          	ldw	_led_green+2,x
3121  0357 ae0303        	ldw	x,#771
3122  035a bf18          	ldw	_led_green,x
3124  035c ace107e1      	jpf	L7161
3125  0360               L5071:
3126                     ; 341 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3128  0360 9c            	rvf
3129  0361 ce0016        	ldw	x,_ee_TZAS
3130  0364 90ae0005      	ldw	y,#5
3131  0368 cd0000        	call	c_imul
3133  036b b34f          	cpw	x,_main_cnt1
3134  036d 2e2a          	jrsge	L1171
3136  036f 9c            	rvf
3137  0370 ce0016        	ldw	x,_ee_TZAS
3138  0373 90ae0005      	ldw	y,#5
3139  0377 cd0000        	call	c_imul
3141  037a 1c0046        	addw	x,#70
3142  037d b34f          	cpw	x,_main_cnt1
3143  037f 2d18          	jrsle	L1171
3144                     ; 343 			led_red=0x00000000L;
3146  0381 ae0000        	ldw	x,#0
3147  0384 bf16          	ldw	_led_red+2,x
3148  0386 ae0000        	ldw	x,#0
3149  0389 bf14          	ldw	_led_red,x
3150                     ; 344 			led_green=0xffffffffL;	
3152  038b aeffff        	ldw	x,#65535
3153  038e bf1a          	ldw	_led_green+2,x
3154  0390 aeffff        	ldw	x,#-1
3155  0393 bf18          	ldw	_led_green,x
3157  0395 ace107e1      	jpf	L7161
3158  0399               L1171:
3159                     ; 347 		else if((flags&0b00011110)==0)
3161  0399 b60b          	ld	a,_flags
3162  039b a51e          	bcp	a,#30
3163  039d 2618          	jrne	L5171
3164                     ; 349 			led_red=0x00000000L;
3166  039f ae0000        	ldw	x,#0
3167  03a2 bf16          	ldw	_led_red+2,x
3168  03a4 ae0000        	ldw	x,#0
3169  03a7 bf14          	ldw	_led_red,x
3170                     ; 350 			led_green=0xffffffffL;
3172  03a9 aeffff        	ldw	x,#65535
3173  03ac bf1a          	ldw	_led_green+2,x
3174  03ae aeffff        	ldw	x,#-1
3175  03b1 bf18          	ldw	_led_green,x
3177  03b3 ace107e1      	jpf	L7161
3178  03b7               L5171:
3179                     ; 354 		else if((flags&0b00111110)==0b00000100)
3181  03b7 b60b          	ld	a,_flags
3182  03b9 a43e          	and	a,#62
3183  03bb a104          	cp	a,#4
3184  03bd 2618          	jrne	L1271
3185                     ; 356 			led_red=0x00010001L;
3187  03bf ae0001        	ldw	x,#1
3188  03c2 bf16          	ldw	_led_red+2,x
3189  03c4 ae0001        	ldw	x,#1
3190  03c7 bf14          	ldw	_led_red,x
3191                     ; 357 			led_green=0xffffffffL;	
3193  03c9 aeffff        	ldw	x,#65535
3194  03cc bf1a          	ldw	_led_green+2,x
3195  03ce aeffff        	ldw	x,#-1
3196  03d1 bf18          	ldw	_led_green,x
3198  03d3 ace107e1      	jpf	L7161
3199  03d7               L1271:
3200                     ; 359 		else if(flags&0b00000010)
3202  03d7 b60b          	ld	a,_flags
3203  03d9 a502          	bcp	a,#2
3204  03db 2718          	jreq	L5271
3205                     ; 361 			led_red=0x00010001L;
3207  03dd ae0001        	ldw	x,#1
3208  03e0 bf16          	ldw	_led_red+2,x
3209  03e2 ae0001        	ldw	x,#1
3210  03e5 bf14          	ldw	_led_red,x
3211                     ; 362 			led_green=0x00000000L;	
3213  03e7 ae0000        	ldw	x,#0
3214  03ea bf1a          	ldw	_led_green+2,x
3215  03ec ae0000        	ldw	x,#0
3216  03ef bf18          	ldw	_led_green,x
3218  03f1 ace107e1      	jpf	L7161
3219  03f5               L5271:
3220                     ; 364 		else if(flags&0b00001000)
3222  03f5 b60b          	ld	a,_flags
3223  03f7 a508          	bcp	a,#8
3224  03f9 2718          	jreq	L1371
3225                     ; 366 			led_red=0x00090009L;
3227  03fb ae0009        	ldw	x,#9
3228  03fe bf16          	ldw	_led_red+2,x
3229  0400 ae0009        	ldw	x,#9
3230  0403 bf14          	ldw	_led_red,x
3231                     ; 367 			led_green=0x00000000L;	
3233  0405 ae0000        	ldw	x,#0
3234  0408 bf1a          	ldw	_led_green+2,x
3235  040a ae0000        	ldw	x,#0
3236  040d bf18          	ldw	_led_green,x
3238  040f ace107e1      	jpf	L7161
3239  0413               L1371:
3240                     ; 369 		else if(flags&0b00010000)
3242  0413 b60b          	ld	a,_flags
3243  0415 a510          	bcp	a,#16
3244  0417 2603          	jrne	L03
3245  0419 cc07e1        	jp	L7161
3246  041c               L03:
3247                     ; 371 			led_red=0x00490049L;
3249  041c ae0049        	ldw	x,#73
3250  041f bf16          	ldw	_led_red+2,x
3251  0421 ae0049        	ldw	x,#73
3252  0424 bf14          	ldw	_led_red,x
3253                     ; 372 			led_green=0xffffffffL;	
3255  0426 aeffff        	ldw	x,#65535
3256  0429 bf1a          	ldw	_led_green+2,x
3257  042b aeffff        	ldw	x,#-1
3258  042e bf18          	ldw	_led_green,x
3259  0430 ace107e1      	jpf	L7161
3260  0434               L1261:
3261                     ; 376 else if(bps_class==bpsIPS)	//если блок ИПСный
3263  0434 b604          	ld	a,_bps_class
3264  0436 a101          	cp	a,#1
3265  0438 2703          	jreq	L23
3266  043a cc07e1        	jp	L7161
3267  043d               L23:
3268                     ; 378 	if(jp_mode!=jp3)
3270  043d b64a          	ld	a,_jp_mode
3271  043f a103          	cp	a,#3
3272  0441 2603          	jrne	L43
3273  0443 cc06ed        	jp	L3471
3274  0446               L43:
3275                     ; 380 		if(main_cnt1<(5*ee_TZAS))
3277  0446 9c            	rvf
3278  0447 ce0016        	ldw	x,_ee_TZAS
3279  044a 90ae0005      	ldw	y,#5
3280  044e cd0000        	call	c_imul
3282  0451 b34f          	cpw	x,_main_cnt1
3283  0453 2d18          	jrsle	L5471
3284                     ; 382 			led_red=0x00000000L;
3286  0455 ae0000        	ldw	x,#0
3287  0458 bf16          	ldw	_led_red+2,x
3288  045a ae0000        	ldw	x,#0
3289  045d bf14          	ldw	_led_red,x
3290                     ; 383 			led_green=0x03030303L;
3292  045f ae0303        	ldw	x,#771
3293  0462 bf1a          	ldw	_led_green+2,x
3294  0464 ae0303        	ldw	x,#771
3295  0467 bf18          	ldw	_led_green,x
3297  0469 acae06ae      	jpf	L7471
3298  046d               L5471:
3299                     ; 386 		else if((link==ON)&&(flags_tu&0b10000000))
3301  046d b663          	ld	a,_link
3302  046f a155          	cp	a,#85
3303  0471 261e          	jrne	L1571
3305  0473 b660          	ld	a,_flags_tu
3306  0475 a580          	bcp	a,#128
3307  0477 2718          	jreq	L1571
3308                     ; 388 			led_red=0x00055555L;
3310  0479 ae5555        	ldw	x,#21845
3311  047c bf16          	ldw	_led_red+2,x
3312  047e ae0005        	ldw	x,#5
3313  0481 bf14          	ldw	_led_red,x
3314                     ; 389 			led_green=0xffffffffL;
3316  0483 aeffff        	ldw	x,#65535
3317  0486 bf1a          	ldw	_led_green+2,x
3318  0488 aeffff        	ldw	x,#-1
3319  048b bf18          	ldw	_led_green,x
3321  048d acae06ae      	jpf	L7471
3322  0491               L1571:
3323                     ; 392 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3325  0491 9c            	rvf
3326  0492 ce0016        	ldw	x,_ee_TZAS
3327  0495 90ae0005      	ldw	y,#5
3328  0499 cd0000        	call	c_imul
3330  049c b34f          	cpw	x,_main_cnt1
3331  049e 2e37          	jrsge	L5571
3333  04a0 9c            	rvf
3334  04a1 ce0016        	ldw	x,_ee_TZAS
3335  04a4 90ae0005      	ldw	y,#5
3336  04a8 cd0000        	call	c_imul
3338  04ab 1c0064        	addw	x,#100
3339  04ae b34f          	cpw	x,_main_cnt1
3340  04b0 2d25          	jrsle	L5571
3342  04b2 ce0006        	ldw	x,_ee_AVT_MODE
3343  04b5 a30055        	cpw	x,#85
3344  04b8 271d          	jreq	L5571
3346  04ba ce0004        	ldw	x,_ee_DEVICE
3347  04bd 2618          	jrne	L5571
3348                     ; 394 			led_red=0x00000000L;
3350  04bf ae0000        	ldw	x,#0
3351  04c2 bf16          	ldw	_led_red+2,x
3352  04c4 ae0000        	ldw	x,#0
3353  04c7 bf14          	ldw	_led_red,x
3354                     ; 395 			led_green=0xffffffffL;	
3356  04c9 aeffff        	ldw	x,#65535
3357  04cc bf1a          	ldw	_led_green+2,x
3358  04ce aeffff        	ldw	x,#-1
3359  04d1 bf18          	ldw	_led_green,x
3361  04d3 acae06ae      	jpf	L7471
3362  04d7               L5571:
3363                     ; 398 		else  if(link==OFF)
3365  04d7 b663          	ld	a,_link
3366  04d9 a1aa          	cp	a,#170
3367  04db 2703          	jreq	L63
3368  04dd cc05f9        	jp	L1671
3369  04e0               L63:
3370                     ; 400 			if((flags&0b00011110)==0)
3372  04e0 b60b          	ld	a,_flags
3373  04e2 a51e          	bcp	a,#30
3374  04e4 262d          	jrne	L3671
3375                     ; 402 				led_red=0x00000000L;
3377  04e6 ae0000        	ldw	x,#0
3378  04e9 bf16          	ldw	_led_red+2,x
3379  04eb ae0000        	ldw	x,#0
3380  04ee bf14          	ldw	_led_red,x
3381                     ; 403 				if(bMAIN)led_green=0xfffffff5L;
3383                     	btst	_bMAIN
3384  04f5 240e          	jruge	L5671
3387  04f7 aefff5        	ldw	x,#65525
3388  04fa bf1a          	ldw	_led_green+2,x
3389  04fc aeffff        	ldw	x,#-1
3390  04ff bf18          	ldw	_led_green,x
3392  0501 acae06ae      	jpf	L7471
3393  0505               L5671:
3394                     ; 404 				else led_green=0xffffffffL;
3396  0505 aeffff        	ldw	x,#65535
3397  0508 bf1a          	ldw	_led_green+2,x
3398  050a aeffff        	ldw	x,#-1
3399  050d bf18          	ldw	_led_green,x
3400  050f acae06ae      	jpf	L7471
3401  0513               L3671:
3402                     ; 407 			else if((flags&0b00111110)==0b00000100)
3404  0513 b60b          	ld	a,_flags
3405  0515 a43e          	and	a,#62
3406  0517 a104          	cp	a,#4
3407  0519 262d          	jrne	L3771
3408                     ; 409 				led_red=0x00010001L;
3410  051b ae0001        	ldw	x,#1
3411  051e bf16          	ldw	_led_red+2,x
3412  0520 ae0001        	ldw	x,#1
3413  0523 bf14          	ldw	_led_red,x
3414                     ; 410 				if(bMAIN)led_green=0xfffffff5L;
3416                     	btst	_bMAIN
3417  052a 240e          	jruge	L5771
3420  052c aefff5        	ldw	x,#65525
3421  052f bf1a          	ldw	_led_green+2,x
3422  0531 aeffff        	ldw	x,#-1
3423  0534 bf18          	ldw	_led_green,x
3425  0536 acae06ae      	jpf	L7471
3426  053a               L5771:
3427                     ; 411 				else led_green=0xffffffffL;	
3429  053a aeffff        	ldw	x,#65535
3430  053d bf1a          	ldw	_led_green+2,x
3431  053f aeffff        	ldw	x,#-1
3432  0542 bf18          	ldw	_led_green,x
3433  0544 acae06ae      	jpf	L7471
3434  0548               L3771:
3435                     ; 413 			else if(flags&0b00000010)
3437  0548 b60b          	ld	a,_flags
3438  054a a502          	bcp	a,#2
3439  054c 272d          	jreq	L3002
3440                     ; 415 				led_red=0x00010001L;
3442  054e ae0001        	ldw	x,#1
3443  0551 bf16          	ldw	_led_red+2,x
3444  0553 ae0001        	ldw	x,#1
3445  0556 bf14          	ldw	_led_red,x
3446                     ; 416 				if(bMAIN)led_green=0x00000005L;
3448                     	btst	_bMAIN
3449  055d 240e          	jruge	L5002
3452  055f ae0005        	ldw	x,#5
3453  0562 bf1a          	ldw	_led_green+2,x
3454  0564 ae0000        	ldw	x,#0
3455  0567 bf18          	ldw	_led_green,x
3457  0569 acae06ae      	jpf	L7471
3458  056d               L5002:
3459                     ; 417 				else led_green=0x00000000L;
3461  056d ae0000        	ldw	x,#0
3462  0570 bf1a          	ldw	_led_green+2,x
3463  0572 ae0000        	ldw	x,#0
3464  0575 bf18          	ldw	_led_green,x
3465  0577 acae06ae      	jpf	L7471
3466  057b               L3002:
3467                     ; 419 			else if(flags&0b00001000)
3469  057b b60b          	ld	a,_flags
3470  057d a508          	bcp	a,#8
3471  057f 272d          	jreq	L3102
3472                     ; 421 				led_red=0x00090009L;
3474  0581 ae0009        	ldw	x,#9
3475  0584 bf16          	ldw	_led_red+2,x
3476  0586 ae0009        	ldw	x,#9
3477  0589 bf14          	ldw	_led_red,x
3478                     ; 422 				if(bMAIN)led_green=0x00000005L;
3480                     	btst	_bMAIN
3481  0590 240e          	jruge	L5102
3484  0592 ae0005        	ldw	x,#5
3485  0595 bf1a          	ldw	_led_green+2,x
3486  0597 ae0000        	ldw	x,#0
3487  059a bf18          	ldw	_led_green,x
3489  059c acae06ae      	jpf	L7471
3490  05a0               L5102:
3491                     ; 423 				else led_green=0x00000000L;	
3493  05a0 ae0000        	ldw	x,#0
3494  05a3 bf1a          	ldw	_led_green+2,x
3495  05a5 ae0000        	ldw	x,#0
3496  05a8 bf18          	ldw	_led_green,x
3497  05aa acae06ae      	jpf	L7471
3498  05ae               L3102:
3499                     ; 425 			else if(flags&0b00010000)
3501  05ae b60b          	ld	a,_flags
3502  05b0 a510          	bcp	a,#16
3503  05b2 272d          	jreq	L3202
3504                     ; 427 				led_red=0x00490049L;
3506  05b4 ae0049        	ldw	x,#73
3507  05b7 bf16          	ldw	_led_red+2,x
3508  05b9 ae0049        	ldw	x,#73
3509  05bc bf14          	ldw	_led_red,x
3510                     ; 428 				if(bMAIN)led_green=0x00000005L;
3512                     	btst	_bMAIN
3513  05c3 240e          	jruge	L5202
3516  05c5 ae0005        	ldw	x,#5
3517  05c8 bf1a          	ldw	_led_green+2,x
3518  05ca ae0000        	ldw	x,#0
3519  05cd bf18          	ldw	_led_green,x
3521  05cf acae06ae      	jpf	L7471
3522  05d3               L5202:
3523                     ; 429 				else led_green=0x00000000L;	
3525  05d3 ae0000        	ldw	x,#0
3526  05d6 bf1a          	ldw	_led_green+2,x
3527  05d8 ae0000        	ldw	x,#0
3528  05db bf18          	ldw	_led_green,x
3529  05dd acae06ae      	jpf	L7471
3530  05e1               L3202:
3531                     ; 433 				led_red=0x55555555L;
3533  05e1 ae5555        	ldw	x,#21845
3534  05e4 bf16          	ldw	_led_red+2,x
3535  05e6 ae5555        	ldw	x,#21845
3536  05e9 bf14          	ldw	_led_red,x
3537                     ; 434 				led_green=0xffffffffL;
3539  05eb aeffff        	ldw	x,#65535
3540  05ee bf1a          	ldw	_led_green+2,x
3541  05f0 aeffff        	ldw	x,#-1
3542  05f3 bf18          	ldw	_led_green,x
3543  05f5 acae06ae      	jpf	L7471
3544  05f9               L1671:
3545                     ; 450 		else if((link==ON)&&((flags&0b00111110)==0))
3547  05f9 b663          	ld	a,_link
3548  05fb a155          	cp	a,#85
3549  05fd 261d          	jrne	L5302
3551  05ff b60b          	ld	a,_flags
3552  0601 a53e          	bcp	a,#62
3553  0603 2617          	jrne	L5302
3554                     ; 452 			led_red=0x00000000L;
3556  0605 ae0000        	ldw	x,#0
3557  0608 bf16          	ldw	_led_red+2,x
3558  060a ae0000        	ldw	x,#0
3559  060d bf14          	ldw	_led_red,x
3560                     ; 453 			led_green=0xffffffffL;
3562  060f aeffff        	ldw	x,#65535
3563  0612 bf1a          	ldw	_led_green+2,x
3564  0614 aeffff        	ldw	x,#-1
3565  0617 bf18          	ldw	_led_green,x
3567  0619 cc06ae        	jra	L7471
3568  061c               L5302:
3569                     ; 456 		else if((flags&0b00111110)==0b00000100)
3571  061c b60b          	ld	a,_flags
3572  061e a43e          	and	a,#62
3573  0620 a104          	cp	a,#4
3574  0622 2616          	jrne	L1402
3575                     ; 458 			led_red=0x00010001L;
3577  0624 ae0001        	ldw	x,#1
3578  0627 bf16          	ldw	_led_red+2,x
3579  0629 ae0001        	ldw	x,#1
3580  062c bf14          	ldw	_led_red,x
3581                     ; 459 			led_green=0xffffffffL;	
3583  062e aeffff        	ldw	x,#65535
3584  0631 bf1a          	ldw	_led_green+2,x
3585  0633 aeffff        	ldw	x,#-1
3586  0636 bf18          	ldw	_led_green,x
3588  0638 2074          	jra	L7471
3589  063a               L1402:
3590                     ; 461 		else if(flags&0b00000010)
3592  063a b60b          	ld	a,_flags
3593  063c a502          	bcp	a,#2
3594  063e 2716          	jreq	L5402
3595                     ; 463 			led_red=0x00010001L;
3597  0640 ae0001        	ldw	x,#1
3598  0643 bf16          	ldw	_led_red+2,x
3599  0645 ae0001        	ldw	x,#1
3600  0648 bf14          	ldw	_led_red,x
3601                     ; 464 			led_green=0x00000000L;	
3603  064a ae0000        	ldw	x,#0
3604  064d bf1a          	ldw	_led_green+2,x
3605  064f ae0000        	ldw	x,#0
3606  0652 bf18          	ldw	_led_green,x
3608  0654 2058          	jra	L7471
3609  0656               L5402:
3610                     ; 466 		else if(flags&0b00001000)
3612  0656 b60b          	ld	a,_flags
3613  0658 a508          	bcp	a,#8
3614  065a 2716          	jreq	L1502
3615                     ; 468 			led_red=0x00090009L;
3617  065c ae0009        	ldw	x,#9
3618  065f bf16          	ldw	_led_red+2,x
3619  0661 ae0009        	ldw	x,#9
3620  0664 bf14          	ldw	_led_red,x
3621                     ; 469 			led_green=0x00000000L;	
3623  0666 ae0000        	ldw	x,#0
3624  0669 bf1a          	ldw	_led_green+2,x
3625  066b ae0000        	ldw	x,#0
3626  066e bf18          	ldw	_led_green,x
3628  0670 203c          	jra	L7471
3629  0672               L1502:
3630                     ; 471 		else if(flags&0b00010000)
3632  0672 b60b          	ld	a,_flags
3633  0674 a510          	bcp	a,#16
3634  0676 2716          	jreq	L5502
3635                     ; 473 			led_red=0x00490049L;
3637  0678 ae0049        	ldw	x,#73
3638  067b bf16          	ldw	_led_red+2,x
3639  067d ae0049        	ldw	x,#73
3640  0680 bf14          	ldw	_led_red,x
3641                     ; 474 			led_green=0x00000000L;	
3643  0682 ae0000        	ldw	x,#0
3644  0685 bf1a          	ldw	_led_green+2,x
3645  0687 ae0000        	ldw	x,#0
3646  068a bf18          	ldw	_led_green,x
3648  068c 2020          	jra	L7471
3649  068e               L5502:
3650                     ; 477 		else if((link==ON)&&(flags&0b00100000))
3652  068e b663          	ld	a,_link
3653  0690 a155          	cp	a,#85
3654  0692 261a          	jrne	L7471
3656  0694 b60b          	ld	a,_flags
3657  0696 a520          	bcp	a,#32
3658  0698 2714          	jreq	L7471
3659                     ; 479 			led_red=0x00000000L;
3661  069a ae0000        	ldw	x,#0
3662  069d bf16          	ldw	_led_red+2,x
3663  069f ae0000        	ldw	x,#0
3664  06a2 bf14          	ldw	_led_red,x
3665                     ; 480 			led_green=0x00030003L;
3667  06a4 ae0003        	ldw	x,#3
3668  06a7 bf1a          	ldw	_led_green+2,x
3669  06a9 ae0003        	ldw	x,#3
3670  06ac bf18          	ldw	_led_green,x
3671  06ae               L7471:
3672                     ; 483 		if((jp_mode==jp1))
3674  06ae b64a          	ld	a,_jp_mode
3675  06b0 a101          	cp	a,#1
3676  06b2 2618          	jrne	L3602
3677                     ; 485 			led_red=0x00000000L;
3679  06b4 ae0000        	ldw	x,#0
3680  06b7 bf16          	ldw	_led_red+2,x
3681  06b9 ae0000        	ldw	x,#0
3682  06bc bf14          	ldw	_led_red,x
3683                     ; 486 			led_green=0x33333333L;
3685  06be ae3333        	ldw	x,#13107
3686  06c1 bf1a          	ldw	_led_green+2,x
3687  06c3 ae3333        	ldw	x,#13107
3688  06c6 bf18          	ldw	_led_green,x
3690  06c8 ace107e1      	jpf	L7161
3691  06cc               L3602:
3692                     ; 488 		else if((jp_mode==jp2))
3694  06cc b64a          	ld	a,_jp_mode
3695  06ce a102          	cp	a,#2
3696  06d0 2703          	jreq	L04
3697  06d2 cc07e1        	jp	L7161
3698  06d5               L04:
3699                     ; 492 			led_red=0xccccccccL;
3701  06d5 aecccc        	ldw	x,#52428
3702  06d8 bf16          	ldw	_led_red+2,x
3703  06da aecccc        	ldw	x,#-13108
3704  06dd bf14          	ldw	_led_red,x
3705                     ; 493 			led_green=0x00000000L;
3707  06df ae0000        	ldw	x,#0
3708  06e2 bf1a          	ldw	_led_green+2,x
3709  06e4 ae0000        	ldw	x,#0
3710  06e7 bf18          	ldw	_led_green,x
3711  06e9 ace107e1      	jpf	L7161
3712  06ed               L3471:
3713                     ; 496 	else if(jp_mode==jp3)
3715  06ed b64a          	ld	a,_jp_mode
3716  06ef a103          	cp	a,#3
3717  06f1 2703          	jreq	L24
3718  06f3 cc07e1        	jp	L7161
3719  06f6               L24:
3720                     ; 498 		if(main_cnt1<(5*ee_TZAS))
3722  06f6 9c            	rvf
3723  06f7 ce0016        	ldw	x,_ee_TZAS
3724  06fa 90ae0005      	ldw	y,#5
3725  06fe cd0000        	call	c_imul
3727  0701 b34f          	cpw	x,_main_cnt1
3728  0703 2d18          	jrsle	L5702
3729                     ; 500 			led_red=0x00000000L;
3731  0705 ae0000        	ldw	x,#0
3732  0708 bf16          	ldw	_led_red+2,x
3733  070a ae0000        	ldw	x,#0
3734  070d bf14          	ldw	_led_red,x
3735                     ; 501 			led_green=0x03030303L;
3737  070f ae0303        	ldw	x,#771
3738  0712 bf1a          	ldw	_led_green+2,x
3739  0714 ae0303        	ldw	x,#771
3740  0717 bf18          	ldw	_led_green,x
3742  0719 ace107e1      	jpf	L7161
3743  071d               L5702:
3744                     ; 503 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3746  071d 9c            	rvf
3747  071e ce0016        	ldw	x,_ee_TZAS
3748  0721 90ae0005      	ldw	y,#5
3749  0725 cd0000        	call	c_imul
3751  0728 b34f          	cpw	x,_main_cnt1
3752  072a 2e29          	jrsge	L1012
3754  072c 9c            	rvf
3755  072d ce0016        	ldw	x,_ee_TZAS
3756  0730 90ae0005      	ldw	y,#5
3757  0734 cd0000        	call	c_imul
3759  0737 1c0046        	addw	x,#70
3760  073a b34f          	cpw	x,_main_cnt1
3761  073c 2d17          	jrsle	L1012
3762                     ; 505 			led_red=0x00000000L;
3764  073e ae0000        	ldw	x,#0
3765  0741 bf16          	ldw	_led_red+2,x
3766  0743 ae0000        	ldw	x,#0
3767  0746 bf14          	ldw	_led_red,x
3768                     ; 506 			led_green=0xffffffffL;	
3770  0748 aeffff        	ldw	x,#65535
3771  074b bf1a          	ldw	_led_green+2,x
3772  074d aeffff        	ldw	x,#-1
3773  0750 bf18          	ldw	_led_green,x
3775  0752 cc07e1        	jra	L7161
3776  0755               L1012:
3777                     ; 509 		else if((flags&0b00011110)==0)
3779  0755 b60b          	ld	a,_flags
3780  0757 a51e          	bcp	a,#30
3781  0759 2616          	jrne	L5012
3782                     ; 511 			led_red=0x00000000L;
3784  075b ae0000        	ldw	x,#0
3785  075e bf16          	ldw	_led_red+2,x
3786  0760 ae0000        	ldw	x,#0
3787  0763 bf14          	ldw	_led_red,x
3788                     ; 512 			led_green=0xffffffffL;
3790  0765 aeffff        	ldw	x,#65535
3791  0768 bf1a          	ldw	_led_green+2,x
3792  076a aeffff        	ldw	x,#-1
3793  076d bf18          	ldw	_led_green,x
3795  076f 2070          	jra	L7161
3796  0771               L5012:
3797                     ; 516 		else if((flags&0b00111110)==0b00000100)
3799  0771 b60b          	ld	a,_flags
3800  0773 a43e          	and	a,#62
3801  0775 a104          	cp	a,#4
3802  0777 2616          	jrne	L1112
3803                     ; 518 			led_red=0x00010001L;
3805  0779 ae0001        	ldw	x,#1
3806  077c bf16          	ldw	_led_red+2,x
3807  077e ae0001        	ldw	x,#1
3808  0781 bf14          	ldw	_led_red,x
3809                     ; 519 			led_green=0xffffffffL;	
3811  0783 aeffff        	ldw	x,#65535
3812  0786 bf1a          	ldw	_led_green+2,x
3813  0788 aeffff        	ldw	x,#-1
3814  078b bf18          	ldw	_led_green,x
3816  078d 2052          	jra	L7161
3817  078f               L1112:
3818                     ; 521 		else if(flags&0b00000010)
3820  078f b60b          	ld	a,_flags
3821  0791 a502          	bcp	a,#2
3822  0793 2716          	jreq	L5112
3823                     ; 523 			led_red=0x00010001L;
3825  0795 ae0001        	ldw	x,#1
3826  0798 bf16          	ldw	_led_red+2,x
3827  079a ae0001        	ldw	x,#1
3828  079d bf14          	ldw	_led_red,x
3829                     ; 524 			led_green=0x00000000L;	
3831  079f ae0000        	ldw	x,#0
3832  07a2 bf1a          	ldw	_led_green+2,x
3833  07a4 ae0000        	ldw	x,#0
3834  07a7 bf18          	ldw	_led_green,x
3836  07a9 2036          	jra	L7161
3837  07ab               L5112:
3838                     ; 526 		else if(flags&0b00001000)
3840  07ab b60b          	ld	a,_flags
3841  07ad a508          	bcp	a,#8
3842  07af 2716          	jreq	L1212
3843                     ; 528 			led_red=0x00090009L;
3845  07b1 ae0009        	ldw	x,#9
3846  07b4 bf16          	ldw	_led_red+2,x
3847  07b6 ae0009        	ldw	x,#9
3848  07b9 bf14          	ldw	_led_red,x
3849                     ; 529 			led_green=0x00000000L;	
3851  07bb ae0000        	ldw	x,#0
3852  07be bf1a          	ldw	_led_green+2,x
3853  07c0 ae0000        	ldw	x,#0
3854  07c3 bf18          	ldw	_led_green,x
3856  07c5 201a          	jra	L7161
3857  07c7               L1212:
3858                     ; 531 		else if(flags&0b00010000)
3860  07c7 b60b          	ld	a,_flags
3861  07c9 a510          	bcp	a,#16
3862  07cb 2714          	jreq	L7161
3863                     ; 533 			led_red=0x00490049L;
3865  07cd ae0049        	ldw	x,#73
3866  07d0 bf16          	ldw	_led_red+2,x
3867  07d2 ae0049        	ldw	x,#73
3868  07d5 bf14          	ldw	_led_red,x
3869                     ; 534 			led_green=0xffffffffL;	
3871  07d7 aeffff        	ldw	x,#65535
3872  07da bf1a          	ldw	_led_green+2,x
3873  07dc aeffff        	ldw	x,#-1
3874  07df bf18          	ldw	_led_green,x
3875  07e1               L7161:
3876                     ; 538 }
3879  07e1 81            	ret
3907                     ; 541 void led_drv(void)
3907                     ; 542 {
3908                     	switch	.text
3909  07e2               _led_drv:
3913                     ; 544 GPIOA->DDR|=(1<<4);
3915  07e2 72185002      	bset	20482,#4
3916                     ; 545 GPIOA->CR1|=(1<<4);
3918  07e6 72185003      	bset	20483,#4
3919                     ; 546 GPIOA->CR2&=~(1<<4);
3921  07ea 72195004      	bres	20484,#4
3922                     ; 547 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3924  07ee b640          	ld	a,_led_red_buff+3
3925  07f0 a501          	bcp	a,#1
3926  07f2 2706          	jreq	L7312
3929  07f4 72185000      	bset	20480,#4
3931  07f8 2004          	jra	L1412
3932  07fa               L7312:
3933                     ; 548 else GPIOA->ODR&=~(1<<4); 
3935  07fa 72195000      	bres	20480,#4
3936  07fe               L1412:
3937                     ; 551 GPIOA->DDR|=(1<<5);
3939  07fe 721a5002      	bset	20482,#5
3940                     ; 552 GPIOA->CR1|=(1<<5);
3942  0802 721a5003      	bset	20483,#5
3943                     ; 553 GPIOA->CR2&=~(1<<5);	
3945  0806 721b5004      	bres	20484,#5
3946                     ; 554 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3948  080a b63c          	ld	a,_led_green_buff+3
3949  080c a501          	bcp	a,#1
3950  080e 2706          	jreq	L3412
3953  0810 721a5000      	bset	20480,#5
3955  0814 2004          	jra	L5412
3956  0816               L3412:
3957                     ; 555 else GPIOA->ODR&=~(1<<5);
3959  0816 721b5000      	bres	20480,#5
3960  081a               L5412:
3961                     ; 558 led_red_buff>>=1;
3963  081a 373d          	sra	_led_red_buff
3964  081c 363e          	rrc	_led_red_buff+1
3965  081e 363f          	rrc	_led_red_buff+2
3966  0820 3640          	rrc	_led_red_buff+3
3967                     ; 559 led_green_buff>>=1;
3969  0822 3739          	sra	_led_green_buff
3970  0824 363a          	rrc	_led_green_buff+1
3971  0826 363b          	rrc	_led_green_buff+2
3972  0828 363c          	rrc	_led_green_buff+3
3973                     ; 560 if(++led_drv_cnt>32)
3975  082a 3c1c          	inc	_led_drv_cnt
3976  082c b61c          	ld	a,_led_drv_cnt
3977  082e a121          	cp	a,#33
3978  0830 2512          	jrult	L7412
3979                     ; 562 	led_drv_cnt=0;
3981  0832 3f1c          	clr	_led_drv_cnt
3982                     ; 563 	led_red_buff=led_red;
3984  0834 be16          	ldw	x,_led_red+2
3985  0836 bf3f          	ldw	_led_red_buff+2,x
3986  0838 be14          	ldw	x,_led_red
3987  083a bf3d          	ldw	_led_red_buff,x
3988                     ; 564 	led_green_buff=led_green;
3990  083c be1a          	ldw	x,_led_green+2
3991  083e bf3b          	ldw	_led_green_buff+2,x
3992  0840 be18          	ldw	x,_led_green
3993  0842 bf39          	ldw	_led_green_buff,x
3994  0844               L7412:
3995                     ; 570 } 
3998  0844 81            	ret
4024                     ; 573 void JP_drv(void)
4024                     ; 574 {
4025                     	switch	.text
4026  0845               _JP_drv:
4030                     ; 576 GPIOD->DDR&=~(1<<6);
4032  0845 721d5011      	bres	20497,#6
4033                     ; 577 GPIOD->CR1|=(1<<6);
4035  0849 721c5012      	bset	20498,#6
4036                     ; 578 GPIOD->CR2&=~(1<<6);
4038  084d 721d5013      	bres	20499,#6
4039                     ; 580 GPIOD->DDR&=~(1<<7);
4041  0851 721f5011      	bres	20497,#7
4042                     ; 581 GPIOD->CR1|=(1<<7);
4044  0855 721e5012      	bset	20498,#7
4045                     ; 582 GPIOD->CR2&=~(1<<7);
4047  0859 721f5013      	bres	20499,#7
4048                     ; 584 if(GPIOD->IDR&(1<<6))
4050  085d c65010        	ld	a,20496
4051  0860 a540          	bcp	a,#64
4052  0862 270a          	jreq	L1612
4053                     ; 586 	if(cnt_JP0<10)
4055  0864 b649          	ld	a,_cnt_JP0
4056  0866 a10a          	cp	a,#10
4057  0868 2411          	jruge	L5612
4058                     ; 588 		cnt_JP0++;
4060  086a 3c49          	inc	_cnt_JP0
4061  086c 200d          	jra	L5612
4062  086e               L1612:
4063                     ; 591 else if(!(GPIOD->IDR&(1<<6)))
4065  086e c65010        	ld	a,20496
4066  0871 a540          	bcp	a,#64
4067  0873 2606          	jrne	L5612
4068                     ; 593 	if(cnt_JP0)
4070  0875 3d49          	tnz	_cnt_JP0
4071  0877 2702          	jreq	L5612
4072                     ; 595 		cnt_JP0--;
4074  0879 3a49          	dec	_cnt_JP0
4075  087b               L5612:
4076                     ; 599 if(GPIOD->IDR&(1<<7))
4078  087b c65010        	ld	a,20496
4079  087e a580          	bcp	a,#128
4080  0880 270a          	jreq	L3712
4081                     ; 601 	if(cnt_JP1<10)
4083  0882 b648          	ld	a,_cnt_JP1
4084  0884 a10a          	cp	a,#10
4085  0886 2411          	jruge	L7712
4086                     ; 603 		cnt_JP1++;
4088  0888 3c48          	inc	_cnt_JP1
4089  088a 200d          	jra	L7712
4090  088c               L3712:
4091                     ; 606 else if(!(GPIOD->IDR&(1<<7)))
4093  088c c65010        	ld	a,20496
4094  088f a580          	bcp	a,#128
4095  0891 2606          	jrne	L7712
4096                     ; 608 	if(cnt_JP1)
4098  0893 3d48          	tnz	_cnt_JP1
4099  0895 2702          	jreq	L7712
4100                     ; 610 		cnt_JP1--;
4102  0897 3a48          	dec	_cnt_JP1
4103  0899               L7712:
4104                     ; 615 if((cnt_JP0==10)&&(cnt_JP1==10))
4106  0899 b649          	ld	a,_cnt_JP0
4107  089b a10a          	cp	a,#10
4108  089d 2608          	jrne	L5022
4110  089f b648          	ld	a,_cnt_JP1
4111  08a1 a10a          	cp	a,#10
4112  08a3 2602          	jrne	L5022
4113                     ; 617 	jp_mode=jp0;
4115  08a5 3f4a          	clr	_jp_mode
4116  08a7               L5022:
4117                     ; 619 if((cnt_JP0==0)&&(cnt_JP1==10))
4119  08a7 3d49          	tnz	_cnt_JP0
4120  08a9 260a          	jrne	L7022
4122  08ab b648          	ld	a,_cnt_JP1
4123  08ad a10a          	cp	a,#10
4124  08af 2604          	jrne	L7022
4125                     ; 621 	jp_mode=jp1;
4127  08b1 3501004a      	mov	_jp_mode,#1
4128  08b5               L7022:
4129                     ; 623 if((cnt_JP0==10)&&(cnt_JP1==0))
4131  08b5 b649          	ld	a,_cnt_JP0
4132  08b7 a10a          	cp	a,#10
4133  08b9 2608          	jrne	L1122
4135  08bb 3d48          	tnz	_cnt_JP1
4136  08bd 2604          	jrne	L1122
4137                     ; 625 	jp_mode=jp2;
4139  08bf 3502004a      	mov	_jp_mode,#2
4140  08c3               L1122:
4141                     ; 627 if((cnt_JP0==0)&&(cnt_JP1==0))
4143  08c3 3d49          	tnz	_cnt_JP0
4144  08c5 2608          	jrne	L3122
4146  08c7 3d48          	tnz	_cnt_JP1
4147  08c9 2604          	jrne	L3122
4148                     ; 629 	jp_mode=jp3;
4150  08cb 3503004a      	mov	_jp_mode,#3
4151  08cf               L3122:
4152                     ; 632 }
4155  08cf 81            	ret
4187                     ; 635 void link_drv(void)		//10Hz
4187                     ; 636 {
4188                     	switch	.text
4189  08d0               _link_drv:
4193                     ; 637 if(jp_mode!=jp3)
4195  08d0 b64a          	ld	a,_jp_mode
4196  08d2 a103          	cp	a,#3
4197  08d4 274d          	jreq	L5222
4198                     ; 639 	if(link_cnt<602)link_cnt++;
4200  08d6 9c            	rvf
4201  08d7 be61          	ldw	x,_link_cnt
4202  08d9 a3025a        	cpw	x,#602
4203  08dc 2e07          	jrsge	L7222
4206  08de be61          	ldw	x,_link_cnt
4207  08e0 1c0001        	addw	x,#1
4208  08e3 bf61          	ldw	_link_cnt,x
4209  08e5               L7222:
4210                     ; 640 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4212  08e5 be61          	ldw	x,_link_cnt
4213  08e7 a3024e        	cpw	x,#590
4214  08ea 2606          	jrne	L1322
4217  08ec b60b          	ld	a,_flags
4218  08ee a4c1          	and	a,#193
4219  08f0 b70b          	ld	_flags,a
4220  08f2               L1322:
4221                     ; 641 	if(link_cnt==600)
4223  08f2 be61          	ldw	x,_link_cnt
4224  08f4 a30258        	cpw	x,#600
4225  08f7 262e          	jrne	L3422
4226                     ; 643 		link=OFF;
4228  08f9 35aa0063      	mov	_link,#170
4229                     ; 648 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4231  08fd b604          	ld	a,_bps_class
4232  08ff a101          	cp	a,#1
4233  0901 2606          	jrne	L5322
4236  0903 72100001      	bset	_bMAIN
4238  0907 2004          	jra	L7322
4239  0909               L5322:
4240                     ; 649 		else bMAIN=0;
4242  0909 72110001      	bres	_bMAIN
4243  090d               L7322:
4244                     ; 651 		cnt_net_drv=0;
4246  090d 3f32          	clr	_cnt_net_drv
4247                     ; 652     		if(!res_fl_)
4249  090f 725d000a      	tnz	_res_fl_
4250  0913 2612          	jrne	L3422
4251                     ; 654 	    		bRES_=1;
4253  0915 35010013      	mov	_bRES_,#1
4254                     ; 655 	    		res_fl_=1;
4256  0919 a601          	ld	a,#1
4257  091b ae000a        	ldw	x,#_res_fl_
4258  091e cd0000        	call	c_eewrc
4260  0921 2004          	jra	L3422
4261  0923               L5222:
4262                     ; 659 else link=OFF;	
4264  0923 35aa0063      	mov	_link,#170
4265  0927               L3422:
4266                     ; 660 } 
4269  0927 81            	ret
4339                     	switch	.const
4340  0004               L45:
4341  0004 0000000b      	dc.l	11
4342  0008               L65:
4343  0008 00000001      	dc.l	1
4344                     ; 664 void vent_drv(void)
4344                     ; 665 {
4345                     	switch	.text
4346  0928               _vent_drv:
4348  0928 520e          	subw	sp,#14
4349       0000000e      OFST:	set	14
4352                     ; 668 	short vent_pwm_i_necc=400;
4354  092a ae0190        	ldw	x,#400
4355  092d 1f07          	ldw	(OFST-7,sp),x
4356                     ; 669 	short vent_pwm_t_necc=400;
4358  092f ae0190        	ldw	x,#400
4359  0932 1f09          	ldw	(OFST-5,sp),x
4360                     ; 670 	short vent_pwm_max_necc=400;
4362                     ; 675 	tempSL=36000L/(signed long)ee_Umax;
4364  0934 ce0014        	ldw	x,_ee_Umax
4365  0937 cd0000        	call	c_itolx
4367  093a 96            	ldw	x,sp
4368  093b 1c0001        	addw	x,#OFST-13
4369  093e cd0000        	call	c_rtol
4371  0941 ae8ca0        	ldw	x,#36000
4372  0944 bf02          	ldw	c_lreg+2,x
4373  0946 ae0000        	ldw	x,#0
4374  0949 bf00          	ldw	c_lreg,x
4375  094b 96            	ldw	x,sp
4376  094c 1c0001        	addw	x,#OFST-13
4377  094f cd0000        	call	c_ldiv
4379  0952 96            	ldw	x,sp
4380  0953 1c000b        	addw	x,#OFST-3
4381  0956 cd0000        	call	c_rtol
4383                     ; 676 	tempSL=(signed long)I/tempSL;
4385  0959 be6f          	ldw	x,_I
4386  095b cd0000        	call	c_itolx
4388  095e 96            	ldw	x,sp
4389  095f 1c000b        	addw	x,#OFST-3
4390  0962 cd0000        	call	c_ldiv
4392  0965 96            	ldw	x,sp
4393  0966 1c000b        	addw	x,#OFST-3
4394  0969 cd0000        	call	c_rtol
4396                     ; 678 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4398  096c ce0004        	ldw	x,_ee_DEVICE
4399  096f a30001        	cpw	x,#1
4400  0972 2613          	jrne	L7722
4403  0974 be6f          	ldw	x,_I
4404  0976 90ce0002      	ldw	y,_ee_IMAXVENT
4405  097a cd0000        	call	c_idiv
4407  097d cd0000        	call	c_itolx
4409  0980 96            	ldw	x,sp
4410  0981 1c000b        	addw	x,#OFST-3
4411  0984 cd0000        	call	c_rtol
4413  0987               L7722:
4414                     ; 680 	if(tempSL>10)vent_pwm_i_necc=1000;
4416  0987 9c            	rvf
4417  0988 96            	ldw	x,sp
4418  0989 1c000b        	addw	x,#OFST-3
4419  098c cd0000        	call	c_ltor
4421  098f ae0004        	ldw	x,#L45
4422  0992 cd0000        	call	c_lcmp
4424  0995 2f07          	jrslt	L1032
4427  0997 ae03e8        	ldw	x,#1000
4428  099a 1f07          	ldw	(OFST-7,sp),x
4430  099c 2025          	jra	L3032
4431  099e               L1032:
4432                     ; 681 	else if(tempSL<1)vent_pwm_i_necc=400;
4434  099e 9c            	rvf
4435  099f 96            	ldw	x,sp
4436  09a0 1c000b        	addw	x,#OFST-3
4437  09a3 cd0000        	call	c_ltor
4439  09a6 ae0008        	ldw	x,#L65
4440  09a9 cd0000        	call	c_lcmp
4442  09ac 2e07          	jrsge	L5032
4445  09ae ae0190        	ldw	x,#400
4446  09b1 1f07          	ldw	(OFST-7,sp),x
4448  09b3 200e          	jra	L3032
4449  09b5               L5032:
4450                     ; 682 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4452  09b5 1e0d          	ldw	x,(OFST-1,sp)
4453  09b7 90ae003c      	ldw	y,#60
4454  09bb cd0000        	call	c_imul
4456  09be 1c0190        	addw	x,#400
4457  09c1 1f07          	ldw	(OFST-7,sp),x
4458  09c3               L3032:
4459                     ; 683 	gran(&vent_pwm_i_necc,400,1000);
4461  09c3 ae03e8        	ldw	x,#1000
4462  09c6 89            	pushw	x
4463  09c7 ae0190        	ldw	x,#400
4464  09ca 89            	pushw	x
4465  09cb 96            	ldw	x,sp
4466  09cc 1c000b        	addw	x,#OFST-3
4467  09cf cd00d1        	call	_gran
4469  09d2 5b04          	addw	sp,#4
4470                     ; 685 	tempSL=(signed long)T;
4472  09d4 b668          	ld	a,_T
4473  09d6 b703          	ld	c_lreg+3,a
4474  09d8 48            	sll	a
4475  09d9 4f            	clr	a
4476  09da a200          	sbc	a,#0
4477  09dc b702          	ld	c_lreg+2,a
4478  09de b701          	ld	c_lreg+1,a
4479  09e0 b700          	ld	c_lreg,a
4480  09e2 96            	ldw	x,sp
4481  09e3 1c000b        	addw	x,#OFST-3
4482  09e6 cd0000        	call	c_rtol
4484                     ; 686 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4486  09e9 9c            	rvf
4487  09ea ce000e        	ldw	x,_ee_tsign
4488  09ed cd0000        	call	c_itolx
4490  09f0 a61e          	ld	a,#30
4491  09f2 cd0000        	call	c_lsbc
4493  09f5 96            	ldw	x,sp
4494  09f6 1c000b        	addw	x,#OFST-3
4495  09f9 cd0000        	call	c_lcmp
4497  09fc 2f07          	jrslt	L1132
4500  09fe ae0190        	ldw	x,#400
4501  0a01 1f09          	ldw	(OFST-5,sp),x
4503  0a03 2030          	jra	L3132
4504  0a05               L1132:
4505                     ; 687 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4507  0a05 9c            	rvf
4508  0a06 ce000e        	ldw	x,_ee_tsign
4509  0a09 cd0000        	call	c_itolx
4511  0a0c 96            	ldw	x,sp
4512  0a0d 1c000b        	addw	x,#OFST-3
4513  0a10 cd0000        	call	c_lcmp
4515  0a13 2c07          	jrsgt	L5132
4518  0a15 ae03e8        	ldw	x,#1000
4519  0a18 1f09          	ldw	(OFST-5,sp),x
4521  0a1a 2019          	jra	L3132
4522  0a1c               L5132:
4523                     ; 688 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4525  0a1c ce000e        	ldw	x,_ee_tsign
4526  0a1f 1d001e        	subw	x,#30
4527  0a22 1f03          	ldw	(OFST-11,sp),x
4528  0a24 1e0d          	ldw	x,(OFST-1,sp)
4529  0a26 72f003        	subw	x,(OFST-11,sp)
4530  0a29 90ae0014      	ldw	y,#20
4531  0a2d cd0000        	call	c_imul
4533  0a30 1c0190        	addw	x,#400
4534  0a33 1f09          	ldw	(OFST-5,sp),x
4535  0a35               L3132:
4536                     ; 689 	gran(&vent_pwm_t_necc,400,1000);
4538  0a35 ae03e8        	ldw	x,#1000
4539  0a38 89            	pushw	x
4540  0a39 ae0190        	ldw	x,#400
4541  0a3c 89            	pushw	x
4542  0a3d 96            	ldw	x,sp
4543  0a3e 1c000d        	addw	x,#OFST-1
4544  0a41 cd00d1        	call	_gran
4546  0a44 5b04          	addw	sp,#4
4547                     ; 691 	vent_pwm_max_necc=vent_pwm_i_necc;
4549  0a46 1e07          	ldw	x,(OFST-7,sp)
4550  0a48 1f05          	ldw	(OFST-9,sp),x
4551                     ; 692 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4553  0a4a 9c            	rvf
4554  0a4b 1e09          	ldw	x,(OFST-5,sp)
4555  0a4d 1307          	cpw	x,(OFST-7,sp)
4556  0a4f 2d04          	jrsle	L1232
4559  0a51 1e09          	ldw	x,(OFST-5,sp)
4560  0a53 1f05          	ldw	(OFST-9,sp),x
4561  0a55               L1232:
4562                     ; 694 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4564  0a55 9c            	rvf
4565  0a56 be05          	ldw	x,_vent_pwm
4566  0a58 1305          	cpw	x,(OFST-9,sp)
4567  0a5a 2e07          	jrsge	L3232
4570  0a5c be05          	ldw	x,_vent_pwm
4571  0a5e 1c000a        	addw	x,#10
4572  0a61 bf05          	ldw	_vent_pwm,x
4573  0a63               L3232:
4574                     ; 695 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4576  0a63 9c            	rvf
4577  0a64 be05          	ldw	x,_vent_pwm
4578  0a66 1305          	cpw	x,(OFST-9,sp)
4579  0a68 2d07          	jrsle	L5232
4582  0a6a be05          	ldw	x,_vent_pwm
4583  0a6c 1d000a        	subw	x,#10
4584  0a6f bf05          	ldw	_vent_pwm,x
4585  0a71               L5232:
4586                     ; 696 	gran(&vent_pwm,400,1000);
4588  0a71 ae03e8        	ldw	x,#1000
4589  0a74 89            	pushw	x
4590  0a75 ae0190        	ldw	x,#400
4591  0a78 89            	pushw	x
4592  0a79 ae0005        	ldw	x,#_vent_pwm
4593  0a7c cd00d1        	call	_gran
4595  0a7f 5b04          	addw	sp,#4
4596                     ; 700 	if(bVENT_BLOCK)vent_pwm=0;
4598  0a81 3d00          	tnz	_bVENT_BLOCK
4599  0a83 2703          	jreq	L7232
4602  0a85 5f            	clrw	x
4603  0a86 bf05          	ldw	_vent_pwm,x
4604  0a88               L7232:
4605                     ; 701 }
4608  0a88 5b0e          	addw	sp,#14
4609  0a8a 81            	ret
4644                     ; 706 void pwr_drv(void)
4644                     ; 707 {
4645                     	switch	.text
4646  0a8b               _pwr_drv:
4650                     ; 711 BLOCK_INIT
4652  0a8b 72145007      	bset	20487,#2
4655  0a8f 72145008      	bset	20488,#2
4658  0a93 72155009      	bres	20489,#2
4659                     ; 713 if(main_cnt1<1500)main_cnt1++;
4661  0a97 9c            	rvf
4662  0a98 be4f          	ldw	x,_main_cnt1
4663  0a9a a305dc        	cpw	x,#1500
4664  0a9d 2e07          	jrsge	L1432
4667  0a9f be4f          	ldw	x,_main_cnt1
4668  0aa1 1c0001        	addw	x,#1
4669  0aa4 bf4f          	ldw	_main_cnt1,x
4670  0aa6               L1432:
4671                     ; 715 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4673  0aa6 9c            	rvf
4674  0aa7 ce0016        	ldw	x,_ee_TZAS
4675  0aaa 90ae0005      	ldw	y,#5
4676  0aae cd0000        	call	c_imul
4678  0ab1 b34f          	cpw	x,_main_cnt1
4679  0ab3 2d12          	jrsle	L3432
4681  0ab5 b604          	ld	a,_bps_class
4682  0ab7 a101          	cp	a,#1
4683  0ab9 270c          	jreq	L3432
4684                     ; 717 	BLOCK_ON
4686  0abb 72145005      	bset	20485,#2
4689  0abf 35010000      	mov	_bVENT_BLOCK,#1
4691  0ac3 ac640b64      	jpf	L5432
4692  0ac7               L3432:
4693                     ; 720 else if(bps_class==bpsIPS)
4695  0ac7 b604          	ld	a,_bps_class
4696  0ac9 a101          	cp	a,#1
4697  0acb 2621          	jrne	L7432
4698                     ; 723 		if(bBL_IPS)
4700                     	btst	_bBL_IPS
4701  0ad2 240b          	jruge	L1532
4702                     ; 725 			 BLOCK_ON
4704  0ad4 72145005      	bset	20485,#2
4707  0ad8 35010000      	mov	_bVENT_BLOCK,#1
4709  0adc cc0b64        	jra	L5432
4710  0adf               L1532:
4711                     ; 728 		else if(!bBL_IPS)
4713                     	btst	_bBL_IPS
4714  0ae4 257e          	jrult	L5432
4715                     ; 730 			  BLOCK_OFF
4717  0ae6 72155005      	bres	20485,#2
4720  0aea 3f00          	clr	_bVENT_BLOCK
4721  0aec 2076          	jra	L5432
4722  0aee               L7432:
4723                     ; 734 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4725  0aee 9c            	rvf
4726  0aef ce0016        	ldw	x,_ee_TZAS
4727  0af2 90ae0005      	ldw	y,#5
4728  0af6 cd0000        	call	c_imul
4730  0af9 b34f          	cpw	x,_main_cnt1
4731  0afb 2e49          	jrsge	L1632
4733  0afd 9c            	rvf
4734  0afe ce0016        	ldw	x,_ee_TZAS
4735  0b01 90ae0005      	ldw	y,#5
4736  0b05 cd0000        	call	c_imul
4738  0b08 1c0046        	addw	x,#70
4739  0b0b b34f          	cpw	x,_main_cnt1
4740  0b0d 2d37          	jrsle	L1632
4741                     ; 736 	if(bps_class==bpsIPS)
4743  0b0f b604          	ld	a,_bps_class
4744  0b11 a101          	cp	a,#1
4745  0b13 2608          	jrne	L3632
4746                     ; 738 		  BLOCK_OFF
4748  0b15 72155005      	bres	20485,#2
4751  0b19 3f00          	clr	_bVENT_BLOCK
4753  0b1b 2047          	jra	L5432
4754  0b1d               L3632:
4755                     ; 741 	else if(bps_class==bpsIBEP)
4757  0b1d 3d04          	tnz	_bps_class
4758  0b1f 2643          	jrne	L5432
4759                     ; 743 		if(ee_DEVICE)
4761  0b21 ce0004        	ldw	x,_ee_DEVICE
4762  0b24 2718          	jreq	L1732
4763                     ; 745 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4765  0b26 b60b          	ld	a,_flags
4766  0b28 a520          	bcp	a,#32
4767  0b2a 270a          	jreq	L3732
4770  0b2c 72145005      	bset	20485,#2
4773  0b30 35010000      	mov	_bVENT_BLOCK,#1
4775  0b34 202e          	jra	L5432
4776  0b36               L3732:
4777                     ; 746 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4779  0b36 72155005      	bres	20485,#2
4782  0b3a 3f00          	clr	_bVENT_BLOCK
4783  0b3c 2026          	jra	L5432
4784  0b3e               L1732:
4785                     ; 750 			BLOCK_OFF
4787  0b3e 72155005      	bres	20485,#2
4790  0b42 3f00          	clr	_bVENT_BLOCK
4791  0b44 201e          	jra	L5432
4792  0b46               L1632:
4793                     ; 755 else if(bBL)
4795                     	btst	_bBL
4796  0b4b 240a          	jruge	L3042
4797                     ; 757 	BLOCK_ON
4799  0b4d 72145005      	bset	20485,#2
4802  0b51 35010000      	mov	_bVENT_BLOCK,#1
4804  0b55 200d          	jra	L5432
4805  0b57               L3042:
4806                     ; 760 else if(!bBL)
4808                     	btst	_bBL
4809  0b5c 2506          	jrult	L5432
4810                     ; 762 	BLOCK_OFF
4812  0b5e 72155005      	bres	20485,#2
4815  0b62 3f00          	clr	_bVENT_BLOCK
4816  0b64               L5432:
4817                     ; 766 gran(&pwm_u,2,1020);
4819  0b64 ae03fc        	ldw	x,#1020
4820  0b67 89            	pushw	x
4821  0b68 ae0002        	ldw	x,#2
4822  0b6b 89            	pushw	x
4823  0b6c ae000e        	ldw	x,#_pwm_u
4824  0b6f cd00d1        	call	_gran
4826  0b72 5b04          	addw	sp,#4
4827                     ; 767 gran(&pwm_i,2,1020);
4829  0b74 ae03fc        	ldw	x,#1020
4830  0b77 89            	pushw	x
4831  0b78 ae0002        	ldw	x,#2
4832  0b7b 89            	pushw	x
4833  0b7c ae0010        	ldw	x,#_pwm_i
4834  0b7f cd00d1        	call	_gran
4836  0b82 5b04          	addw	sp,#4
4837                     ; 777 TIM1->CCR2H= (char)(pwm_u/256);	
4839  0b84 be0e          	ldw	x,_pwm_u
4840  0b86 90ae0100      	ldw	y,#256
4841  0b8a cd0000        	call	c_idiv
4843  0b8d 9f            	ld	a,xl
4844  0b8e c75267        	ld	21095,a
4845                     ; 778 TIM1->CCR2L= (char)pwm_u;
4847  0b91 55000f5268    	mov	21096,_pwm_u+1
4848                     ; 780 TIM1->CCR1H= (char)(pwm_i/256);	
4850  0b96 be10          	ldw	x,_pwm_i
4851  0b98 90ae0100      	ldw	y,#256
4852  0b9c cd0000        	call	c_idiv
4854  0b9f 9f            	ld	a,xl
4855  0ba0 c75265        	ld	21093,a
4856                     ; 781 TIM1->CCR1L= (char)pwm_i;
4858  0ba3 5500115266    	mov	21094,_pwm_i+1
4859                     ; 783 TIM1->CCR3H= (char)(vent_pwm/256);	
4861  0ba8 be05          	ldw	x,_vent_pwm
4862  0baa 90ae0100      	ldw	y,#256
4863  0bae cd0000        	call	c_idiv
4865  0bb1 9f            	ld	a,xl
4866  0bb2 c75269        	ld	21097,a
4867                     ; 784 TIM1->CCR3L= (char)vent_pwm;
4869  0bb5 550006526a    	mov	21098,_vent_pwm+1
4870                     ; 785 }
4873  0bba 81            	ret
4912                     ; 790 void pwr_hndl(void)				
4912                     ; 791 {
4913                     	switch	.text
4914  0bbb               _pwr_hndl:
4918                     ; 792 if(jp_mode==jp3)
4920  0bbb b64a          	ld	a,_jp_mode
4921  0bbd a103          	cp	a,#3
4922  0bbf 2646          	jrne	L1242
4923                     ; 794 	if((flags&0b00001010)==0)
4925  0bc1 b60b          	ld	a,_flags
4926  0bc3 a50a          	bcp	a,#10
4927  0bc5 2629          	jrne	L3242
4928                     ; 796 		pwm_u=500;
4930  0bc7 ae01f4        	ldw	x,#500
4931  0bca bf0e          	ldw	_pwm_u,x
4932                     ; 797 		if(pwm_i<1020)
4934  0bcc 9c            	rvf
4935  0bcd be10          	ldw	x,_pwm_i
4936  0bcf a303fc        	cpw	x,#1020
4937  0bd2 2e14          	jrsge	L5242
4938                     ; 799 			pwm_i+=30;
4940  0bd4 be10          	ldw	x,_pwm_i
4941  0bd6 1c001e        	addw	x,#30
4942  0bd9 bf10          	ldw	_pwm_i,x
4943                     ; 800 			if(pwm_i>1020)pwm_i=1020;
4945  0bdb 9c            	rvf
4946  0bdc be10          	ldw	x,_pwm_i
4947  0bde a303fd        	cpw	x,#1021
4948  0be1 2f05          	jrslt	L5242
4951  0be3 ae03fc        	ldw	x,#1020
4952  0be6 bf10          	ldw	_pwm_i,x
4953  0be8               L5242:
4954                     ; 802 		bBL=0;
4956  0be8 72110003      	bres	_bBL
4958  0bec acb70db7      	jpf	L5342
4959  0bf0               L3242:
4960                     ; 804 	else if(flags&0b00001010)
4962  0bf0 b60b          	ld	a,_flags
4963  0bf2 a50a          	bcp	a,#10
4964  0bf4 2603          	jrne	L46
4965  0bf6 cc0db7        	jp	L5342
4966  0bf9               L46:
4967                     ; 806 		pwm_u=0;
4969  0bf9 5f            	clrw	x
4970  0bfa bf0e          	ldw	_pwm_u,x
4971                     ; 807 		pwm_i=0;
4973  0bfc 5f            	clrw	x
4974  0bfd bf10          	ldw	_pwm_i,x
4975                     ; 808 		bBL=1;
4977  0bff 72100003      	bset	_bBL
4978  0c03 acb70db7      	jpf	L5342
4979  0c07               L1242:
4980                     ; 812 else if(jp_mode==jp2)
4982  0c07 b64a          	ld	a,_jp_mode
4983  0c09 a102          	cp	a,#2
4984  0c0b 2627          	jrne	L7342
4985                     ; 814 	pwm_u=0;
4987  0c0d 5f            	clrw	x
4988  0c0e bf0e          	ldw	_pwm_u,x
4989                     ; 816 	if(pwm_i<1020)
4991  0c10 9c            	rvf
4992  0c11 be10          	ldw	x,_pwm_i
4993  0c13 a303fc        	cpw	x,#1020
4994  0c16 2e14          	jrsge	L1442
4995                     ; 818 		pwm_i+=30;
4997  0c18 be10          	ldw	x,_pwm_i
4998  0c1a 1c001e        	addw	x,#30
4999  0c1d bf10          	ldw	_pwm_i,x
5000                     ; 819 		if(pwm_i>1020)pwm_i=1020;
5002  0c1f 9c            	rvf
5003  0c20 be10          	ldw	x,_pwm_i
5004  0c22 a303fd        	cpw	x,#1021
5005  0c25 2f05          	jrslt	L1442
5008  0c27 ae03fc        	ldw	x,#1020
5009  0c2a bf10          	ldw	_pwm_i,x
5010  0c2c               L1442:
5011                     ; 821 	bBL=0;
5013  0c2c 72110003      	bres	_bBL
5015  0c30 acb70db7      	jpf	L5342
5016  0c34               L7342:
5017                     ; 823 else if(jp_mode==jp1)
5019  0c34 b64a          	ld	a,_jp_mode
5020  0c36 a101          	cp	a,#1
5021  0c38 2629          	jrne	L7442
5022                     ; 825 	pwm_u=0x3ff;
5024  0c3a ae03ff        	ldw	x,#1023
5025  0c3d bf0e          	ldw	_pwm_u,x
5026                     ; 827 	if(pwm_i<1020)
5028  0c3f 9c            	rvf
5029  0c40 be10          	ldw	x,_pwm_i
5030  0c42 a303fc        	cpw	x,#1020
5031  0c45 2e14          	jrsge	L1542
5032                     ; 829 		pwm_i+=30;
5034  0c47 be10          	ldw	x,_pwm_i
5035  0c49 1c001e        	addw	x,#30
5036  0c4c bf10          	ldw	_pwm_i,x
5037                     ; 830 		if(pwm_i>1020)pwm_i=1020;
5039  0c4e 9c            	rvf
5040  0c4f be10          	ldw	x,_pwm_i
5041  0c51 a303fd        	cpw	x,#1021
5042  0c54 2f05          	jrslt	L1542
5045  0c56 ae03fc        	ldw	x,#1020
5046  0c59 bf10          	ldw	_pwm_i,x
5047  0c5b               L1542:
5048                     ; 832 	bBL=0;
5050  0c5b 72110003      	bres	_bBL
5052  0c5f acb70db7      	jpf	L5342
5053  0c63               L7442:
5054                     ; 835 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
5056                     	btst	_bMAIN
5057  0c68 242e          	jruge	L7542
5059  0c6a b663          	ld	a,_link
5060  0c6c a155          	cp	a,#85
5061  0c6e 2628          	jrne	L7542
5062                     ; 837 	pwm_u=volum_u_main_;
5064  0c70 be1f          	ldw	x,_volum_u_main_
5065  0c72 bf0e          	ldw	_pwm_u,x
5066                     ; 839 	if(pwm_i<1020)
5068  0c74 9c            	rvf
5069  0c75 be10          	ldw	x,_pwm_i
5070  0c77 a303fc        	cpw	x,#1020
5071  0c7a 2e14          	jrsge	L1642
5072                     ; 841 		pwm_i+=30;
5074  0c7c be10          	ldw	x,_pwm_i
5075  0c7e 1c001e        	addw	x,#30
5076  0c81 bf10          	ldw	_pwm_i,x
5077                     ; 842 		if(pwm_i>1020)pwm_i=1020;
5079  0c83 9c            	rvf
5080  0c84 be10          	ldw	x,_pwm_i
5081  0c86 a303fd        	cpw	x,#1021
5082  0c89 2f05          	jrslt	L1642
5085  0c8b ae03fc        	ldw	x,#1020
5086  0c8e bf10          	ldw	_pwm_i,x
5087  0c90               L1642:
5088                     ; 844 	bBL_IPS=0;
5090  0c90 72110000      	bres	_bBL_IPS
5092  0c94 acb70db7      	jpf	L5342
5093  0c98               L7542:
5094                     ; 847 else if(link==OFF)
5096  0c98 b663          	ld	a,_link
5097  0c9a a1aa          	cp	a,#170
5098  0c9c 266f          	jrne	L7642
5099                     ; 856  	if(ee_DEVICE)
5101  0c9e ce0004        	ldw	x,_ee_DEVICE
5102  0ca1 270e          	jreq	L1742
5103                     ; 858 		pwm_u=0x00;
5105  0ca3 5f            	clrw	x
5106  0ca4 bf0e          	ldw	_pwm_u,x
5107                     ; 859 		pwm_i=0x00;
5109  0ca6 5f            	clrw	x
5110  0ca7 bf10          	ldw	_pwm_i,x
5111                     ; 860 		bBL=1;
5113  0ca9 72100003      	bset	_bBL
5115  0cad acb70db7      	jpf	L5342
5116  0cb1               L1742:
5117                     ; 864 		if((flags&0b00011010)==0)
5119  0cb1 b60b          	ld	a,_flags
5120  0cb3 a51a          	bcp	a,#26
5121  0cb5 263b          	jrne	L5742
5122                     ; 866 			pwm_u=ee_U_AVT;
5124  0cb7 ce000c        	ldw	x,_ee_U_AVT
5125  0cba bf0e          	ldw	_pwm_u,x
5126                     ; 867 			gran(&pwm_u,0,1020);
5128  0cbc ae03fc        	ldw	x,#1020
5129  0cbf 89            	pushw	x
5130  0cc0 5f            	clrw	x
5131  0cc1 89            	pushw	x
5132  0cc2 ae000e        	ldw	x,#_pwm_u
5133  0cc5 cd00d1        	call	_gran
5135  0cc8 5b04          	addw	sp,#4
5136                     ; 869 			if(pwm_i<1020)
5138  0cca 9c            	rvf
5139  0ccb be10          	ldw	x,_pwm_i
5140  0ccd a303fc        	cpw	x,#1020
5141  0cd0 2e14          	jrsge	L7742
5142                     ; 871 				pwm_i+=30;
5144  0cd2 be10          	ldw	x,_pwm_i
5145  0cd4 1c001e        	addw	x,#30
5146  0cd7 bf10          	ldw	_pwm_i,x
5147                     ; 872 				if(pwm_i>1020)pwm_i=1020;
5149  0cd9 9c            	rvf
5150  0cda be10          	ldw	x,_pwm_i
5151  0cdc a303fd        	cpw	x,#1021
5152  0cdf 2f05          	jrslt	L7742
5155  0ce1 ae03fc        	ldw	x,#1020
5156  0ce4 bf10          	ldw	_pwm_i,x
5157  0ce6               L7742:
5158                     ; 874 			bBL=0;
5160  0ce6 72110003      	bres	_bBL
5161                     ; 875 			bBL_IPS=0;
5163  0cea 72110000      	bres	_bBL_IPS
5165  0cee acb70db7      	jpf	L5342
5166  0cf2               L5742:
5167                     ; 877 		else if(flags&0b00011010)
5169  0cf2 b60b          	ld	a,_flags
5170  0cf4 a51a          	bcp	a,#26
5171  0cf6 2603          	jrne	L66
5172  0cf8 cc0db7        	jp	L5342
5173  0cfb               L66:
5174                     ; 879 			pwm_u=0;
5176  0cfb 5f            	clrw	x
5177  0cfc bf0e          	ldw	_pwm_u,x
5178                     ; 880 			pwm_i=0;
5180  0cfe 5f            	clrw	x
5181  0cff bf10          	ldw	_pwm_i,x
5182                     ; 881 			bBL=1;
5184  0d01 72100003      	bset	_bBL
5185                     ; 882 			bBL_IPS=1;
5187  0d05 72100000      	bset	_bBL_IPS
5188  0d09 acb70db7      	jpf	L5342
5189  0d0d               L7642:
5190                     ; 891 else	if(link==ON)				//если есть связьvol_i_temp_avar
5192  0d0d b663          	ld	a,_link
5193  0d0f a155          	cp	a,#85
5194  0d11 2703          	jreq	L07
5195  0d13 cc0db7        	jp	L5342
5196  0d16               L07:
5197                     ; 893 	if((flags&0b00100000)==0)	//если нет блокировки извне
5199  0d16 b60b          	ld	a,_flags
5200  0d18 a520          	bcp	a,#32
5201  0d1a 2703cc0da7    	jrne	L3152
5202                     ; 895 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
5204  0d1f b60b          	ld	a,_flags
5205  0d21 a41e          	and	a,#30
5206  0d23 a104          	cp	a,#4
5207  0d25 2630          	jrne	L5152
5208                     ; 897 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5210  0d27 be5e          	ldw	x,__x_
5211  0d29 72bb0058      	addw	x,_vol_u_temp
5212  0d2d bf0e          	ldw	_pwm_u,x
5213                     ; 898 			if(!ee_DEVICE)
5215  0d2f ce0004        	ldw	x,_ee_DEVICE
5216  0d32 261b          	jrne	L7152
5217                     ; 900 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
5219  0d34 be10          	ldw	x,_pwm_i
5220  0d36 b30c          	cpw	x,_vol_i_temp_avar
5221  0d38 240f          	jruge	L1252
5224  0d3a be0c          	ldw	x,_vol_i_temp_avar
5225  0d3c 90ae001e      	ldw	y,#30
5226  0d40 65            	divw	x,y
5227  0d41 72bb0010      	addw	x,_pwm_i
5228  0d45 bf10          	ldw	_pwm_i,x
5230  0d47 200a          	jra	L5252
5231  0d49               L1252:
5232                     ; 901 				else	pwm_i=vol_i_temp_avar;
5234  0d49 be0c          	ldw	x,_vol_i_temp_avar
5235  0d4b bf10          	ldw	_pwm_i,x
5236  0d4d 2004          	jra	L5252
5237  0d4f               L7152:
5238                     ; 903 			else pwm_i=vol_i_temp_avar;
5240  0d4f be0c          	ldw	x,_vol_i_temp_avar
5241  0d51 bf10          	ldw	_pwm_i,x
5242  0d53               L5252:
5243                     ; 905 			bBL=0;
5245  0d53 72110003      	bres	_bBL
5246  0d57               L5152:
5247                     ; 907 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5249  0d57 b60b          	ld	a,_flags
5250  0d59 a51a          	bcp	a,#26
5251  0d5b 2706          	jreq	L1352
5253  0d5d b60b          	ld	a,_flags
5254  0d5f a540          	bcp	a,#64
5255  0d61 2732          	jreq	L7252
5256  0d63               L1352:
5257                     ; 909 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5259  0d63 be5e          	ldw	x,__x_
5260  0d65 72bb0058      	addw	x,_vol_u_temp
5261  0d69 bf0e          	ldw	_pwm_u,x
5262                     ; 911 			if(!ee_DEVICE)
5264  0d6b ce0004        	ldw	x,_ee_DEVICE
5265  0d6e 261b          	jrne	L3352
5266                     ; 913 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
5268  0d70 be10          	ldw	x,_pwm_i
5269  0d72 b356          	cpw	x,_vol_i_temp
5270  0d74 240f          	jruge	L5352
5273  0d76 be56          	ldw	x,_vol_i_temp
5274  0d78 90ae001e      	ldw	y,#30
5275  0d7c 65            	divw	x,y
5276  0d7d 72bb0010      	addw	x,_pwm_i
5277  0d81 bf10          	ldw	_pwm_i,x
5279  0d83 200a          	jra	L1452
5280  0d85               L5352:
5281                     ; 914 				else	pwm_i=vol_i_temp;
5283  0d85 be56          	ldw	x,_vol_i_temp
5284  0d87 bf10          	ldw	_pwm_i,x
5285  0d89 2004          	jra	L1452
5286  0d8b               L3352:
5287                     ; 916 			else pwm_i=vol_i_temp;			
5289  0d8b be56          	ldw	x,_vol_i_temp
5290  0d8d bf10          	ldw	_pwm_i,x
5291  0d8f               L1452:
5292                     ; 917 			bBL=0;
5294  0d8f 72110003      	bres	_bBL
5296  0d93 2022          	jra	L5342
5297  0d95               L7252:
5298                     ; 919 		else if(flags&0b00011010)					//если есть аварии
5300  0d95 b60b          	ld	a,_flags
5301  0d97 a51a          	bcp	a,#26
5302  0d99 271c          	jreq	L5342
5303                     ; 921 			pwm_u=0;								//то полный стоп
5305  0d9b 5f            	clrw	x
5306  0d9c bf0e          	ldw	_pwm_u,x
5307                     ; 922 			pwm_i=0;
5309  0d9e 5f            	clrw	x
5310  0d9f bf10          	ldw	_pwm_i,x
5311                     ; 923 			bBL=1;
5313  0da1 72100003      	bset	_bBL
5314  0da5 2010          	jra	L5342
5315  0da7               L3152:
5316                     ; 926 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5318  0da7 b60b          	ld	a,_flags
5319  0da9 a520          	bcp	a,#32
5320  0dab 270a          	jreq	L5342
5321                     ; 928 		pwm_u=0;
5323  0dad 5f            	clrw	x
5324  0dae bf0e          	ldw	_pwm_u,x
5325                     ; 929 	    	pwm_i=0;
5327  0db0 5f            	clrw	x
5328  0db1 bf10          	ldw	_pwm_i,x
5329                     ; 930 		bBL=1;
5331  0db3 72100003      	bset	_bBL
5332  0db7               L5342:
5333                     ; 936 }
5336  0db7 81            	ret
5381                     	switch	.const
5382  000c               L47:
5383  000c 00000258      	dc.l	600
5384  0010               L67:
5385  0010 000003e8      	dc.l	1000
5386  0014               L001:
5387  0014 00000708      	dc.l	1800
5388                     ; 939 void matemat(void)
5388                     ; 940 {
5389                     	switch	.text
5390  0db8               _matemat:
5392  0db8 5208          	subw	sp,#8
5393       00000008      OFST:	set	8
5396                     ; 961 temp_SL=adc_buff_[4];
5398  0dba ce0011        	ldw	x,_adc_buff_+8
5399  0dbd cd0000        	call	c_itolx
5401  0dc0 96            	ldw	x,sp
5402  0dc1 1c0005        	addw	x,#OFST-3
5403  0dc4 cd0000        	call	c_rtol
5405                     ; 962 temp_SL-=ee_K[0][0];
5407  0dc7 ce001a        	ldw	x,_ee_K
5408  0dca cd0000        	call	c_itolx
5410  0dcd 96            	ldw	x,sp
5411  0dce 1c0005        	addw	x,#OFST-3
5412  0dd1 cd0000        	call	c_lgsub
5414                     ; 963 if(temp_SL<0) temp_SL=0;
5416  0dd4 9c            	rvf
5417  0dd5 0d05          	tnz	(OFST-3,sp)
5418  0dd7 2e0a          	jrsge	L1752
5421  0dd9 ae0000        	ldw	x,#0
5422  0ddc 1f07          	ldw	(OFST-1,sp),x
5423  0dde ae0000        	ldw	x,#0
5424  0de1 1f05          	ldw	(OFST-3,sp),x
5425  0de3               L1752:
5426                     ; 964 temp_SL*=ee_K[0][1];
5428  0de3 ce001c        	ldw	x,_ee_K+2
5429  0de6 cd0000        	call	c_itolx
5431  0de9 96            	ldw	x,sp
5432  0dea 1c0005        	addw	x,#OFST-3
5433  0ded cd0000        	call	c_lgmul
5435                     ; 965 temp_SL/=600;
5437  0df0 96            	ldw	x,sp
5438  0df1 1c0005        	addw	x,#OFST-3
5439  0df4 cd0000        	call	c_ltor
5441  0df7 ae000c        	ldw	x,#L47
5442  0dfa cd0000        	call	c_ldiv
5444  0dfd 96            	ldw	x,sp
5445  0dfe 1c0005        	addw	x,#OFST-3
5446  0e01 cd0000        	call	c_rtol
5448                     ; 966 I=(signed short)temp_SL;
5450  0e04 1e07          	ldw	x,(OFST-1,sp)
5451  0e06 bf6f          	ldw	_I,x
5452                     ; 971 temp_SL=(signed long)adc_buff_[1];
5454  0e08 ce000b        	ldw	x,_adc_buff_+2
5455  0e0b cd0000        	call	c_itolx
5457  0e0e 96            	ldw	x,sp
5458  0e0f 1c0005        	addw	x,#OFST-3
5459  0e12 cd0000        	call	c_rtol
5461                     ; 973 if(temp_SL<0) temp_SL=0;
5463  0e15 9c            	rvf
5464  0e16 0d05          	tnz	(OFST-3,sp)
5465  0e18 2e0a          	jrsge	L3752
5468  0e1a ae0000        	ldw	x,#0
5469  0e1d 1f07          	ldw	(OFST-1,sp),x
5470  0e1f ae0000        	ldw	x,#0
5471  0e22 1f05          	ldw	(OFST-3,sp),x
5472  0e24               L3752:
5473                     ; 974 temp_SL*=(signed long)ee_K[2][1];
5475  0e24 ce0024        	ldw	x,_ee_K+10
5476  0e27 cd0000        	call	c_itolx
5478  0e2a 96            	ldw	x,sp
5479  0e2b 1c0005        	addw	x,#OFST-3
5480  0e2e cd0000        	call	c_lgmul
5482                     ; 975 temp_SL/=1000L;
5484  0e31 96            	ldw	x,sp
5485  0e32 1c0005        	addw	x,#OFST-3
5486  0e35 cd0000        	call	c_ltor
5488  0e38 ae0010        	ldw	x,#L67
5489  0e3b cd0000        	call	c_ldiv
5491  0e3e 96            	ldw	x,sp
5492  0e3f 1c0005        	addw	x,#OFST-3
5493  0e42 cd0000        	call	c_rtol
5495                     ; 976 Ui=(unsigned short)temp_SL;
5497  0e45 1e07          	ldw	x,(OFST-1,sp)
5498  0e47 bf6b          	ldw	_Ui,x
5499                     ; 983 temp_SL=adc_buff_[3];
5501  0e49 ce000f        	ldw	x,_adc_buff_+6
5502  0e4c cd0000        	call	c_itolx
5504  0e4f 96            	ldw	x,sp
5505  0e50 1c0005        	addw	x,#OFST-3
5506  0e53 cd0000        	call	c_rtol
5508                     ; 985 if(temp_SL<0) temp_SL=0;
5510  0e56 9c            	rvf
5511  0e57 0d05          	tnz	(OFST-3,sp)
5512  0e59 2e0a          	jrsge	L5752
5515  0e5b ae0000        	ldw	x,#0
5516  0e5e 1f07          	ldw	(OFST-1,sp),x
5517  0e60 ae0000        	ldw	x,#0
5518  0e63 1f05          	ldw	(OFST-3,sp),x
5519  0e65               L5752:
5520                     ; 986 temp_SL*=ee_K[1][1];
5522  0e65 ce0020        	ldw	x,_ee_K+6
5523  0e68 cd0000        	call	c_itolx
5525  0e6b 96            	ldw	x,sp
5526  0e6c 1c0005        	addw	x,#OFST-3
5527  0e6f cd0000        	call	c_lgmul
5529                     ; 987 temp_SL/=1800;
5531  0e72 96            	ldw	x,sp
5532  0e73 1c0005        	addw	x,#OFST-3
5533  0e76 cd0000        	call	c_ltor
5535  0e79 ae0014        	ldw	x,#L001
5536  0e7c cd0000        	call	c_ldiv
5538  0e7f 96            	ldw	x,sp
5539  0e80 1c0005        	addw	x,#OFST-3
5540  0e83 cd0000        	call	c_rtol
5542                     ; 988 Un=(unsigned short)temp_SL;
5544  0e86 1e07          	ldw	x,(OFST-1,sp)
5545  0e88 bf6d          	ldw	_Un,x
5546                     ; 991 temp_SL=adc_buff_[2];
5548  0e8a ce000d        	ldw	x,_adc_buff_+4
5549  0e8d cd0000        	call	c_itolx
5551  0e90 96            	ldw	x,sp
5552  0e91 1c0005        	addw	x,#OFST-3
5553  0e94 cd0000        	call	c_rtol
5555                     ; 992 temp_SL*=ee_K[3][1];
5557  0e97 ce0028        	ldw	x,_ee_K+14
5558  0e9a cd0000        	call	c_itolx
5560  0e9d 96            	ldw	x,sp
5561  0e9e 1c0005        	addw	x,#OFST-3
5562  0ea1 cd0000        	call	c_lgmul
5564                     ; 993 temp_SL/=1000;
5566  0ea4 96            	ldw	x,sp
5567  0ea5 1c0005        	addw	x,#OFST-3
5568  0ea8 cd0000        	call	c_ltor
5570  0eab ae0010        	ldw	x,#L67
5571  0eae cd0000        	call	c_ldiv
5573  0eb1 96            	ldw	x,sp
5574  0eb2 1c0005        	addw	x,#OFST-3
5575  0eb5 cd0000        	call	c_rtol
5577                     ; 994 T=(signed short)(temp_SL-273L);
5579  0eb8 7b08          	ld	a,(OFST+0,sp)
5580  0eba 5f            	clrw	x
5581  0ebb 4d            	tnz	a
5582  0ebc 2a01          	jrpl	L201
5583  0ebe 53            	cplw	x
5584  0ebf               L201:
5585  0ebf 97            	ld	xl,a
5586  0ec0 1d0111        	subw	x,#273
5587  0ec3 01            	rrwa	x,a
5588  0ec4 b768          	ld	_T,a
5589  0ec6 02            	rlwa	x,a
5590                     ; 995 if(T<-30)T=-30;
5592  0ec7 9c            	rvf
5593  0ec8 b668          	ld	a,_T
5594  0eca a1e2          	cp	a,#226
5595  0ecc 2e04          	jrsge	L7752
5598  0ece 35e20068      	mov	_T,#226
5599  0ed2               L7752:
5600                     ; 996 if(T>120)T=120;
5602  0ed2 9c            	rvf
5603  0ed3 b668          	ld	a,_T
5604  0ed5 a179          	cp	a,#121
5605  0ed7 2f04          	jrslt	L1062
5608  0ed9 35780068      	mov	_T,#120
5609  0edd               L1062:
5610                     ; 998 Udb=flags;
5612  0edd b60b          	ld	a,_flags
5613  0edf 5f            	clrw	x
5614  0ee0 97            	ld	xl,a
5615  0ee1 bf69          	ldw	_Udb,x
5616                     ; 1004 temp_SL=(signed long)(T-ee_tsign);
5618  0ee3 5f            	clrw	x
5619  0ee4 b668          	ld	a,_T
5620  0ee6 2a01          	jrpl	L401
5621  0ee8 53            	cplw	x
5622  0ee9               L401:
5623  0ee9 97            	ld	xl,a
5624  0eea 72b0000e      	subw	x,_ee_tsign
5625  0eee cd0000        	call	c_itolx
5627  0ef1 96            	ldw	x,sp
5628  0ef2 1c0005        	addw	x,#OFST-3
5629  0ef5 cd0000        	call	c_rtol
5631                     ; 1005 temp_SL*=1000L;
5633  0ef8 ae03e8        	ldw	x,#1000
5634  0efb bf02          	ldw	c_lreg+2,x
5635  0efd ae0000        	ldw	x,#0
5636  0f00 bf00          	ldw	c_lreg,x
5637  0f02 96            	ldw	x,sp
5638  0f03 1c0005        	addw	x,#OFST-3
5639  0f06 cd0000        	call	c_lgmul
5641                     ; 1006 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5643  0f09 ce0010        	ldw	x,_ee_tmax
5644  0f0c 72b0000e      	subw	x,_ee_tsign
5645  0f10 cd0000        	call	c_itolx
5647  0f13 96            	ldw	x,sp
5648  0f14 1c0001        	addw	x,#OFST-7
5649  0f17 cd0000        	call	c_rtol
5651  0f1a 96            	ldw	x,sp
5652  0f1b 1c0005        	addw	x,#OFST-3
5653  0f1e cd0000        	call	c_ltor
5655  0f21 96            	ldw	x,sp
5656  0f22 1c0001        	addw	x,#OFST-7
5657  0f25 cd0000        	call	c_ldiv
5659  0f28 96            	ldw	x,sp
5660  0f29 1c0005        	addw	x,#OFST-3
5661  0f2c cd0000        	call	c_rtol
5663                     ; 1008 vol_i_temp_avar=(unsigned short)temp_SL; 
5665  0f2f 1e07          	ldw	x,(OFST-1,sp)
5666  0f31 bf0c          	ldw	_vol_i_temp_avar,x
5667                     ; 1010 }
5670  0f33 5b08          	addw	sp,#8
5671  0f35 81            	ret
5702                     ; 1013 void temper_drv(void)		//1 Hz
5702                     ; 1014 {
5703                     	switch	.text
5704  0f36               _temper_drv:
5708                     ; 1016 if(T>ee_tsign) tsign_cnt++;
5710  0f36 9c            	rvf
5711  0f37 5f            	clrw	x
5712  0f38 b668          	ld	a,_T
5713  0f3a 2a01          	jrpl	L011
5714  0f3c 53            	cplw	x
5715  0f3d               L011:
5716  0f3d 97            	ld	xl,a
5717  0f3e c3000e        	cpw	x,_ee_tsign
5718  0f41 2d09          	jrsle	L3162
5721  0f43 be4d          	ldw	x,_tsign_cnt
5722  0f45 1c0001        	addw	x,#1
5723  0f48 bf4d          	ldw	_tsign_cnt,x
5725  0f4a 201d          	jra	L5162
5726  0f4c               L3162:
5727                     ; 1017 else if (T<(ee_tsign-1)) tsign_cnt--;
5729  0f4c 9c            	rvf
5730  0f4d ce000e        	ldw	x,_ee_tsign
5731  0f50 5a            	decw	x
5732  0f51 905f          	clrw	y
5733  0f53 b668          	ld	a,_T
5734  0f55 2a02          	jrpl	L211
5735  0f57 9053          	cplw	y
5736  0f59               L211:
5737  0f59 9097          	ld	yl,a
5738  0f5b 90bf00        	ldw	c_y,y
5739  0f5e b300          	cpw	x,c_y
5740  0f60 2d07          	jrsle	L5162
5743  0f62 be4d          	ldw	x,_tsign_cnt
5744  0f64 1d0001        	subw	x,#1
5745  0f67 bf4d          	ldw	_tsign_cnt,x
5746  0f69               L5162:
5747                     ; 1019 gran(&tsign_cnt,0,60);
5749  0f69 ae003c        	ldw	x,#60
5750  0f6c 89            	pushw	x
5751  0f6d 5f            	clrw	x
5752  0f6e 89            	pushw	x
5753  0f6f ae004d        	ldw	x,#_tsign_cnt
5754  0f72 cd00d1        	call	_gran
5756  0f75 5b04          	addw	sp,#4
5757                     ; 1021 if(tsign_cnt>=55)
5759  0f77 9c            	rvf
5760  0f78 be4d          	ldw	x,_tsign_cnt
5761  0f7a a30037        	cpw	x,#55
5762  0f7d 2f16          	jrslt	L1262
5763                     ; 1023 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5765  0f7f 3d4a          	tnz	_jp_mode
5766  0f81 2606          	jrne	L7262
5768  0f83 b60b          	ld	a,_flags
5769  0f85 a540          	bcp	a,#64
5770  0f87 2706          	jreq	L5262
5771  0f89               L7262:
5773  0f89 b64a          	ld	a,_jp_mode
5774  0f8b a103          	cp	a,#3
5775  0f8d 2612          	jrne	L1362
5776  0f8f               L5262:
5779  0f8f 7214000b      	bset	_flags,#2
5780  0f93 200c          	jra	L1362
5781  0f95               L1262:
5782                     ; 1025 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5784  0f95 9c            	rvf
5785  0f96 be4d          	ldw	x,_tsign_cnt
5786  0f98 a30006        	cpw	x,#6
5787  0f9b 2e04          	jrsge	L1362
5790  0f9d 7215000b      	bres	_flags,#2
5791  0fa1               L1362:
5792                     ; 1030 if(T>ee_tmax) tmax_cnt++;
5794  0fa1 9c            	rvf
5795  0fa2 5f            	clrw	x
5796  0fa3 b668          	ld	a,_T
5797  0fa5 2a01          	jrpl	L411
5798  0fa7 53            	cplw	x
5799  0fa8               L411:
5800  0fa8 97            	ld	xl,a
5801  0fa9 c30010        	cpw	x,_ee_tmax
5802  0fac 2d09          	jrsle	L5362
5805  0fae be4b          	ldw	x,_tmax_cnt
5806  0fb0 1c0001        	addw	x,#1
5807  0fb3 bf4b          	ldw	_tmax_cnt,x
5809  0fb5 201d          	jra	L7362
5810  0fb7               L5362:
5811                     ; 1031 else if (T<(ee_tmax-1)) tmax_cnt--;
5813  0fb7 9c            	rvf
5814  0fb8 ce0010        	ldw	x,_ee_tmax
5815  0fbb 5a            	decw	x
5816  0fbc 905f          	clrw	y
5817  0fbe b668          	ld	a,_T
5818  0fc0 2a02          	jrpl	L611
5819  0fc2 9053          	cplw	y
5820  0fc4               L611:
5821  0fc4 9097          	ld	yl,a
5822  0fc6 90bf00        	ldw	c_y,y
5823  0fc9 b300          	cpw	x,c_y
5824  0fcb 2d07          	jrsle	L7362
5827  0fcd be4b          	ldw	x,_tmax_cnt
5828  0fcf 1d0001        	subw	x,#1
5829  0fd2 bf4b          	ldw	_tmax_cnt,x
5830  0fd4               L7362:
5831                     ; 1033 gran(&tmax_cnt,0,60);
5833  0fd4 ae003c        	ldw	x,#60
5834  0fd7 89            	pushw	x
5835  0fd8 5f            	clrw	x
5836  0fd9 89            	pushw	x
5837  0fda ae004b        	ldw	x,#_tmax_cnt
5838  0fdd cd00d1        	call	_gran
5840  0fe0 5b04          	addw	sp,#4
5841                     ; 1035 if(tmax_cnt>=55)
5843  0fe2 9c            	rvf
5844  0fe3 be4b          	ldw	x,_tmax_cnt
5845  0fe5 a30037        	cpw	x,#55
5846  0fe8 2f16          	jrslt	L3462
5847                     ; 1037 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5849  0fea 3d4a          	tnz	_jp_mode
5850  0fec 2606          	jrne	L1562
5852  0fee b60b          	ld	a,_flags
5853  0ff0 a540          	bcp	a,#64
5854  0ff2 2706          	jreq	L7462
5855  0ff4               L1562:
5857  0ff4 b64a          	ld	a,_jp_mode
5858  0ff6 a103          	cp	a,#3
5859  0ff8 2612          	jrne	L3562
5860  0ffa               L7462:
5863  0ffa 7212000b      	bset	_flags,#1
5864  0ffe 200c          	jra	L3562
5865  1000               L3462:
5866                     ; 1039 else if (tmax_cnt<=5) flags&=0b11111101;
5868  1000 9c            	rvf
5869  1001 be4b          	ldw	x,_tmax_cnt
5870  1003 a30006        	cpw	x,#6
5871  1006 2e04          	jrsge	L3562
5874  1008 7213000b      	bres	_flags,#1
5875  100c               L3562:
5876                     ; 1042 } 
5879  100c 81            	ret
5911                     ; 1045 void u_drv(void)		//1Hz
5911                     ; 1046 { 
5912                     	switch	.text
5913  100d               _u_drv:
5917                     ; 1047 if(jp_mode!=jp3)
5919  100d b64a          	ld	a,_jp_mode
5920  100f a103          	cp	a,#3
5921  1011 2770          	jreq	L7662
5922                     ; 1049 	if(Ui>ee_Umax)umax_cnt++;
5924  1013 9c            	rvf
5925  1014 be6b          	ldw	x,_Ui
5926  1016 c30014        	cpw	x,_ee_Umax
5927  1019 2d09          	jrsle	L1762
5930  101b be66          	ldw	x,_umax_cnt
5931  101d 1c0001        	addw	x,#1
5932  1020 bf66          	ldw	_umax_cnt,x
5934  1022 2003          	jra	L3762
5935  1024               L1762:
5936                     ; 1050 	else umax_cnt=0;
5938  1024 5f            	clrw	x
5939  1025 bf66          	ldw	_umax_cnt,x
5940  1027               L3762:
5941                     ; 1051 	gran(&umax_cnt,0,10);
5943  1027 ae000a        	ldw	x,#10
5944  102a 89            	pushw	x
5945  102b 5f            	clrw	x
5946  102c 89            	pushw	x
5947  102d ae0066        	ldw	x,#_umax_cnt
5948  1030 cd00d1        	call	_gran
5950  1033 5b04          	addw	sp,#4
5951                     ; 1052 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5953  1035 9c            	rvf
5954  1036 be66          	ldw	x,_umax_cnt
5955  1038 a3000a        	cpw	x,#10
5956  103b 2f04          	jrslt	L5762
5959  103d 7216000b      	bset	_flags,#3
5960  1041               L5762:
5961                     ; 1055 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5963  1041 9c            	rvf
5964  1042 be6b          	ldw	x,_Ui
5965  1044 b36d          	cpw	x,_Un
5966  1046 2e1c          	jrsge	L7762
5968  1048 9c            	rvf
5969  1049 be6d          	ldw	x,_Un
5970  104b 72b0006b      	subw	x,_Ui
5971  104f c30012        	cpw	x,_ee_dU
5972  1052 2d10          	jrsle	L7762
5974  1054 c65005        	ld	a,20485
5975  1057 a504          	bcp	a,#4
5976  1059 2609          	jrne	L7762
5979  105b be64          	ldw	x,_umin_cnt
5980  105d 1c0001        	addw	x,#1
5981  1060 bf64          	ldw	_umin_cnt,x
5983  1062 2003          	jra	L1072
5984  1064               L7762:
5985                     ; 1056 	else umin_cnt=0;
5987  1064 5f            	clrw	x
5988  1065 bf64          	ldw	_umin_cnt,x
5989  1067               L1072:
5990                     ; 1057 	gran(&umin_cnt,0,10);	
5992  1067 ae000a        	ldw	x,#10
5993  106a 89            	pushw	x
5994  106b 5f            	clrw	x
5995  106c 89            	pushw	x
5996  106d ae0064        	ldw	x,#_umin_cnt
5997  1070 cd00d1        	call	_gran
5999  1073 5b04          	addw	sp,#4
6000                     ; 1058 	if(umin_cnt>=10)flags|=0b00010000;	  
6002  1075 9c            	rvf
6003  1076 be64          	ldw	x,_umin_cnt
6004  1078 a3000a        	cpw	x,#10
6005  107b 2f6f          	jrslt	L5072
6008  107d 7218000b      	bset	_flags,#4
6009  1081 2069          	jra	L5072
6010  1083               L7662:
6011                     ; 1060 else if(jp_mode==jp3)
6013  1083 b64a          	ld	a,_jp_mode
6014  1085 a103          	cp	a,#3
6015  1087 2663          	jrne	L5072
6016                     ; 1062 	if(Ui>700)umax_cnt++;
6018  1089 9c            	rvf
6019  108a be6b          	ldw	x,_Ui
6020  108c a302bd        	cpw	x,#701
6021  108f 2f09          	jrslt	L1172
6024  1091 be66          	ldw	x,_umax_cnt
6025  1093 1c0001        	addw	x,#1
6026  1096 bf66          	ldw	_umax_cnt,x
6028  1098 2003          	jra	L3172
6029  109a               L1172:
6030                     ; 1063 	else umax_cnt=0;
6032  109a 5f            	clrw	x
6033  109b bf66          	ldw	_umax_cnt,x
6034  109d               L3172:
6035                     ; 1064 	gran(&umax_cnt,0,10);
6037  109d ae000a        	ldw	x,#10
6038  10a0 89            	pushw	x
6039  10a1 5f            	clrw	x
6040  10a2 89            	pushw	x
6041  10a3 ae0066        	ldw	x,#_umax_cnt
6042  10a6 cd00d1        	call	_gran
6044  10a9 5b04          	addw	sp,#4
6045                     ; 1065 	if(umax_cnt>=10)flags|=0b00001000;
6047  10ab 9c            	rvf
6048  10ac be66          	ldw	x,_umax_cnt
6049  10ae a3000a        	cpw	x,#10
6050  10b1 2f04          	jrslt	L5172
6053  10b3 7216000b      	bset	_flags,#3
6054  10b7               L5172:
6055                     ; 1068 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6057  10b7 9c            	rvf
6058  10b8 be6b          	ldw	x,_Ui
6059  10ba a300c8        	cpw	x,#200
6060  10bd 2e10          	jrsge	L7172
6062  10bf c65005        	ld	a,20485
6063  10c2 a504          	bcp	a,#4
6064  10c4 2609          	jrne	L7172
6067  10c6 be64          	ldw	x,_umin_cnt
6068  10c8 1c0001        	addw	x,#1
6069  10cb bf64          	ldw	_umin_cnt,x
6071  10cd 2003          	jra	L1272
6072  10cf               L7172:
6073                     ; 1069 	else umin_cnt=0;
6075  10cf 5f            	clrw	x
6076  10d0 bf64          	ldw	_umin_cnt,x
6077  10d2               L1272:
6078                     ; 1070 	gran(&umin_cnt,0,10);	
6080  10d2 ae000a        	ldw	x,#10
6081  10d5 89            	pushw	x
6082  10d6 5f            	clrw	x
6083  10d7 89            	pushw	x
6084  10d8 ae0064        	ldw	x,#_umin_cnt
6085  10db cd00d1        	call	_gran
6087  10de 5b04          	addw	sp,#4
6088                     ; 1071 	if(umin_cnt>=10)flags|=0b00010000;	  
6090  10e0 9c            	rvf
6091  10e1 be64          	ldw	x,_umin_cnt
6092  10e3 a3000a        	cpw	x,#10
6093  10e6 2f04          	jrslt	L5072
6096  10e8 7218000b      	bset	_flags,#4
6097  10ec               L5072:
6098                     ; 1073 }
6101  10ec 81            	ret
6128                     ; 1076 void x_drv(void)
6128                     ; 1077 {
6129                     	switch	.text
6130  10ed               _x_drv:
6134                     ; 1078 if(_x__==_x_)
6136  10ed be5c          	ldw	x,__x__
6137  10ef b35e          	cpw	x,__x_
6138  10f1 262a          	jrne	L5372
6139                     ; 1080 	if(_x_cnt<60)
6141  10f3 9c            	rvf
6142  10f4 be5a          	ldw	x,__x_cnt
6143  10f6 a3003c        	cpw	x,#60
6144  10f9 2e25          	jrsge	L5472
6145                     ; 1082 		_x_cnt++;
6147  10fb be5a          	ldw	x,__x_cnt
6148  10fd 1c0001        	addw	x,#1
6149  1100 bf5a          	ldw	__x_cnt,x
6150                     ; 1083 		if(_x_cnt>=60)
6152  1102 9c            	rvf
6153  1103 be5a          	ldw	x,__x_cnt
6154  1105 a3003c        	cpw	x,#60
6155  1108 2f16          	jrslt	L5472
6156                     ; 1085 			if(_x_ee_!=_x_)_x_ee_=_x_;
6158  110a ce0018        	ldw	x,__x_ee_
6159  110d b35e          	cpw	x,__x_
6160  110f 270f          	jreq	L5472
6163  1111 be5e          	ldw	x,__x_
6164  1113 89            	pushw	x
6165  1114 ae0018        	ldw	x,#__x_ee_
6166  1117 cd0000        	call	c_eewrw
6168  111a 85            	popw	x
6169  111b 2003          	jra	L5472
6170  111d               L5372:
6171                     ; 1090 else _x_cnt=0;
6173  111d 5f            	clrw	x
6174  111e bf5a          	ldw	__x_cnt,x
6175  1120               L5472:
6176                     ; 1092 if(_x_cnt>60) _x_cnt=0;	
6178  1120 9c            	rvf
6179  1121 be5a          	ldw	x,__x_cnt
6180  1123 a3003d        	cpw	x,#61
6181  1126 2f03          	jrslt	L7472
6184  1128 5f            	clrw	x
6185  1129 bf5a          	ldw	__x_cnt,x
6186  112b               L7472:
6187                     ; 1094 _x__=_x_;
6189  112b be5e          	ldw	x,__x_
6190  112d bf5c          	ldw	__x__,x
6191                     ; 1095 }
6194  112f 81            	ret
6220                     ; 1098 void apv_start(void)
6220                     ; 1099 {
6221                     	switch	.text
6222  1130               _apv_start:
6226                     ; 1100 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6228  1130 3d45          	tnz	_apv_cnt
6229  1132 2624          	jrne	L1672
6231  1134 3d46          	tnz	_apv_cnt+1
6232  1136 2620          	jrne	L1672
6234  1138 3d47          	tnz	_apv_cnt+2
6235  113a 261c          	jrne	L1672
6237                     	btst	_bAPV
6238  1141 2515          	jrult	L1672
6239                     ; 1102 	apv_cnt[0]=60;
6241  1143 353c0045      	mov	_apv_cnt,#60
6242                     ; 1103 	apv_cnt[1]=60;
6244  1147 353c0046      	mov	_apv_cnt+1,#60
6245                     ; 1104 	apv_cnt[2]=60;
6247  114b 353c0047      	mov	_apv_cnt+2,#60
6248                     ; 1105 	apv_cnt_=3600;
6250  114f ae0e10        	ldw	x,#3600
6251  1152 bf43          	ldw	_apv_cnt_,x
6252                     ; 1106 	bAPV=1;	
6254  1154 72100002      	bset	_bAPV
6255  1158               L1672:
6256                     ; 1108 }
6259  1158 81            	ret
6285                     ; 1111 void apv_stop(void)
6285                     ; 1112 {
6286                     	switch	.text
6287  1159               _apv_stop:
6291                     ; 1113 apv_cnt[0]=0;
6293  1159 3f45          	clr	_apv_cnt
6294                     ; 1114 apv_cnt[1]=0;
6296  115b 3f46          	clr	_apv_cnt+1
6297                     ; 1115 apv_cnt[2]=0;
6299  115d 3f47          	clr	_apv_cnt+2
6300                     ; 1116 apv_cnt_=0;	
6302  115f 5f            	clrw	x
6303  1160 bf43          	ldw	_apv_cnt_,x
6304                     ; 1117 bAPV=0;
6306  1162 72110002      	bres	_bAPV
6307                     ; 1118 }
6310  1166 81            	ret
6345                     ; 1122 void apv_hndl(void)
6345                     ; 1123 {
6346                     	switch	.text
6347  1167               _apv_hndl:
6351                     ; 1124 if(apv_cnt[0])
6353  1167 3d45          	tnz	_apv_cnt
6354  1169 271e          	jreq	L3003
6355                     ; 1126 	apv_cnt[0]--;
6357  116b 3a45          	dec	_apv_cnt
6358                     ; 1127 	if(apv_cnt[0]==0)
6360  116d 3d45          	tnz	_apv_cnt
6361  116f 265a          	jrne	L7003
6362                     ; 1129 		flags&=0b11100001;
6364  1171 b60b          	ld	a,_flags
6365  1173 a4e1          	and	a,#225
6366  1175 b70b          	ld	_flags,a
6367                     ; 1130 		tsign_cnt=0;
6369  1177 5f            	clrw	x
6370  1178 bf4d          	ldw	_tsign_cnt,x
6371                     ; 1131 		tmax_cnt=0;
6373  117a 5f            	clrw	x
6374  117b bf4b          	ldw	_tmax_cnt,x
6375                     ; 1132 		umax_cnt=0;
6377  117d 5f            	clrw	x
6378  117e bf66          	ldw	_umax_cnt,x
6379                     ; 1133 		umin_cnt=0;
6381  1180 5f            	clrw	x
6382  1181 bf64          	ldw	_umin_cnt,x
6383                     ; 1135 		led_drv_cnt=30;
6385  1183 351e001c      	mov	_led_drv_cnt,#30
6386  1187 2042          	jra	L7003
6387  1189               L3003:
6388                     ; 1138 else if(apv_cnt[1])
6390  1189 3d46          	tnz	_apv_cnt+1
6391  118b 271e          	jreq	L1103
6392                     ; 1140 	apv_cnt[1]--;
6394  118d 3a46          	dec	_apv_cnt+1
6395                     ; 1141 	if(apv_cnt[1]==0)
6397  118f 3d46          	tnz	_apv_cnt+1
6398  1191 2638          	jrne	L7003
6399                     ; 1143 		flags&=0b11100001;
6401  1193 b60b          	ld	a,_flags
6402  1195 a4e1          	and	a,#225
6403  1197 b70b          	ld	_flags,a
6404                     ; 1144 		tsign_cnt=0;
6406  1199 5f            	clrw	x
6407  119a bf4d          	ldw	_tsign_cnt,x
6408                     ; 1145 		tmax_cnt=0;
6410  119c 5f            	clrw	x
6411  119d bf4b          	ldw	_tmax_cnt,x
6412                     ; 1146 		umax_cnt=0;
6414  119f 5f            	clrw	x
6415  11a0 bf66          	ldw	_umax_cnt,x
6416                     ; 1147 		umin_cnt=0;
6418  11a2 5f            	clrw	x
6419  11a3 bf64          	ldw	_umin_cnt,x
6420                     ; 1149 		led_drv_cnt=30;
6422  11a5 351e001c      	mov	_led_drv_cnt,#30
6423  11a9 2020          	jra	L7003
6424  11ab               L1103:
6425                     ; 1152 else if(apv_cnt[2])
6427  11ab 3d47          	tnz	_apv_cnt+2
6428  11ad 271c          	jreq	L7003
6429                     ; 1154 	apv_cnt[2]--;
6431  11af 3a47          	dec	_apv_cnt+2
6432                     ; 1155 	if(apv_cnt[2]==0)
6434  11b1 3d47          	tnz	_apv_cnt+2
6435  11b3 2616          	jrne	L7003
6436                     ; 1157 		flags&=0b11100001;
6438  11b5 b60b          	ld	a,_flags
6439  11b7 a4e1          	and	a,#225
6440  11b9 b70b          	ld	_flags,a
6441                     ; 1158 		tsign_cnt=0;
6443  11bb 5f            	clrw	x
6444  11bc bf4d          	ldw	_tsign_cnt,x
6445                     ; 1159 		tmax_cnt=0;
6447  11be 5f            	clrw	x
6448  11bf bf4b          	ldw	_tmax_cnt,x
6449                     ; 1160 		umax_cnt=0;
6451  11c1 5f            	clrw	x
6452  11c2 bf66          	ldw	_umax_cnt,x
6453                     ; 1161 		umin_cnt=0;          
6455  11c4 5f            	clrw	x
6456  11c5 bf64          	ldw	_umin_cnt,x
6457                     ; 1163 		led_drv_cnt=30;
6459  11c7 351e001c      	mov	_led_drv_cnt,#30
6460  11cb               L7003:
6461                     ; 1167 if(apv_cnt_)
6463  11cb be43          	ldw	x,_apv_cnt_
6464  11cd 2712          	jreq	L3203
6465                     ; 1169 	apv_cnt_--;
6467  11cf be43          	ldw	x,_apv_cnt_
6468  11d1 1d0001        	subw	x,#1
6469  11d4 bf43          	ldw	_apv_cnt_,x
6470                     ; 1170 	if(apv_cnt_==0) 
6472  11d6 be43          	ldw	x,_apv_cnt_
6473  11d8 2607          	jrne	L3203
6474                     ; 1172 		bAPV=0;
6476  11da 72110002      	bres	_bAPV
6477                     ; 1173 		apv_start();
6479  11de cd1130        	call	_apv_start
6481  11e1               L3203:
6482                     ; 1177 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6484  11e1 be64          	ldw	x,_umin_cnt
6485  11e3 261e          	jrne	L7203
6487  11e5 be66          	ldw	x,_umax_cnt
6488  11e7 261a          	jrne	L7203
6490  11e9 c65005        	ld	a,20485
6491  11ec a504          	bcp	a,#4
6492  11ee 2613          	jrne	L7203
6493                     ; 1179 	if(cnt_apv_off<20)
6495  11f0 b642          	ld	a,_cnt_apv_off
6496  11f2 a114          	cp	a,#20
6497  11f4 240f          	jruge	L5303
6498                     ; 1181 		cnt_apv_off++;
6500  11f6 3c42          	inc	_cnt_apv_off
6501                     ; 1182 		if(cnt_apv_off>=20)
6503  11f8 b642          	ld	a,_cnt_apv_off
6504  11fa a114          	cp	a,#20
6505  11fc 2507          	jrult	L5303
6506                     ; 1184 			apv_stop();
6508  11fe cd1159        	call	_apv_stop
6510  1201 2002          	jra	L5303
6511  1203               L7203:
6512                     ; 1188 else cnt_apv_off=0;	
6514  1203 3f42          	clr	_cnt_apv_off
6515  1205               L5303:
6516                     ; 1190 }
6519  1205 81            	ret
6522                     	switch	.ubsct
6523  0000               L7303_flags_old:
6524  0000 00            	ds.b	1
6560                     ; 1193 void flags_drv(void)
6560                     ; 1194 {
6561                     	switch	.text
6562  1206               _flags_drv:
6566                     ; 1196 if(jp_mode!=jp3) 
6568  1206 b64a          	ld	a,_jp_mode
6569  1208 a103          	cp	a,#3
6570  120a 2723          	jreq	L7503
6571                     ; 1198 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6573  120c b60b          	ld	a,_flags
6574  120e a508          	bcp	a,#8
6575  1210 2706          	jreq	L5603
6577  1212 b600          	ld	a,L7303_flags_old
6578  1214 a508          	bcp	a,#8
6579  1216 270c          	jreq	L3603
6580  1218               L5603:
6582  1218 b60b          	ld	a,_flags
6583  121a a510          	bcp	a,#16
6584  121c 2726          	jreq	L1703
6586  121e b600          	ld	a,L7303_flags_old
6587  1220 a510          	bcp	a,#16
6588  1222 2620          	jrne	L1703
6589  1224               L3603:
6590                     ; 1200     		if(link==OFF)apv_start();
6592  1224 b663          	ld	a,_link
6593  1226 a1aa          	cp	a,#170
6594  1228 261a          	jrne	L1703
6597  122a cd1130        	call	_apv_start
6599  122d 2015          	jra	L1703
6600  122f               L7503:
6601                     ; 1203 else if(jp_mode==jp3) 
6603  122f b64a          	ld	a,_jp_mode
6604  1231 a103          	cp	a,#3
6605  1233 260f          	jrne	L1703
6606                     ; 1205 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6608  1235 b60b          	ld	a,_flags
6609  1237 a508          	bcp	a,#8
6610  1239 2709          	jreq	L1703
6612  123b b600          	ld	a,L7303_flags_old
6613  123d a508          	bcp	a,#8
6614  123f 2603          	jrne	L1703
6615                     ; 1207     		apv_start();
6617  1241 cd1130        	call	_apv_start
6619  1244               L1703:
6620                     ; 1210 flags_old=flags;
6622  1244 450b00        	mov	L7303_flags_old,_flags
6623                     ; 1212 } 
6626  1247 81            	ret
6661                     ; 1349 void adr_drv_v4(char in)
6661                     ; 1350 {
6662                     	switch	.text
6663  1248               _adr_drv_v4:
6667                     ; 1351 if(adress!=in)adress=in;
6669  1248 c10005        	cp	a,_adress
6670  124b 2703          	jreq	L5113
6673  124d c70005        	ld	_adress,a
6674  1250               L5113:
6675                     ; 1352 }
6678  1250 81            	ret
6707                     ; 1355 void adr_drv_v3(void)
6707                     ; 1356 {
6708                     	switch	.text
6709  1251               _adr_drv_v3:
6711  1251 88            	push	a
6712       00000001      OFST:	set	1
6715                     ; 1362 GPIOB->DDR&=~(1<<0);
6717  1252 72115007      	bres	20487,#0
6718                     ; 1363 GPIOB->CR1&=~(1<<0);
6720  1256 72115008      	bres	20488,#0
6721                     ; 1364 GPIOB->CR2&=~(1<<0);
6723  125a 72115009      	bres	20489,#0
6724                     ; 1365 ADC2->CR2=0x08;
6726  125e 35085402      	mov	21506,#8
6727                     ; 1366 ADC2->CR1=0x40;
6729  1262 35405401      	mov	21505,#64
6730                     ; 1367 ADC2->CSR=0x20+0;
6732  1266 35205400      	mov	21504,#32
6733                     ; 1368 ADC2->CR1|=1;
6735  126a 72105401      	bset	21505,#0
6736                     ; 1369 ADC2->CR1|=1;
6738  126e 72105401      	bset	21505,#0
6739                     ; 1370 adr_drv_stat=1;
6741  1272 35010008      	mov	_adr_drv_stat,#1
6742  1276               L7213:
6743                     ; 1371 while(adr_drv_stat==1);
6746  1276 b608          	ld	a,_adr_drv_stat
6747  1278 a101          	cp	a,#1
6748  127a 27fa          	jreq	L7213
6749                     ; 1373 GPIOB->DDR&=~(1<<1);
6751  127c 72135007      	bres	20487,#1
6752                     ; 1374 GPIOB->CR1&=~(1<<1);
6754  1280 72135008      	bres	20488,#1
6755                     ; 1375 GPIOB->CR2&=~(1<<1);
6757  1284 72135009      	bres	20489,#1
6758                     ; 1376 ADC2->CR2=0x08;
6760  1288 35085402      	mov	21506,#8
6761                     ; 1377 ADC2->CR1=0x40;
6763  128c 35405401      	mov	21505,#64
6764                     ; 1378 ADC2->CSR=0x20+1;
6766  1290 35215400      	mov	21504,#33
6767                     ; 1379 ADC2->CR1|=1;
6769  1294 72105401      	bset	21505,#0
6770                     ; 1380 ADC2->CR1|=1;
6772  1298 72105401      	bset	21505,#0
6773                     ; 1381 adr_drv_stat=3;
6775  129c 35030008      	mov	_adr_drv_stat,#3
6776  12a0               L5313:
6777                     ; 1382 while(adr_drv_stat==3);
6780  12a0 b608          	ld	a,_adr_drv_stat
6781  12a2 a103          	cp	a,#3
6782  12a4 27fa          	jreq	L5313
6783                     ; 1384 GPIOE->DDR&=~(1<<6);
6785  12a6 721d5016      	bres	20502,#6
6786                     ; 1385 GPIOE->CR1&=~(1<<6);
6788  12aa 721d5017      	bres	20503,#6
6789                     ; 1386 GPIOE->CR2&=~(1<<6);
6791  12ae 721d5018      	bres	20504,#6
6792                     ; 1387 ADC2->CR2=0x08;
6794  12b2 35085402      	mov	21506,#8
6795                     ; 1388 ADC2->CR1=0x40;
6797  12b6 35405401      	mov	21505,#64
6798                     ; 1389 ADC2->CSR=0x20+9;
6800  12ba 35295400      	mov	21504,#41
6801                     ; 1390 ADC2->CR1|=1;
6803  12be 72105401      	bset	21505,#0
6804                     ; 1391 ADC2->CR1|=1;
6806  12c2 72105401      	bset	21505,#0
6807                     ; 1392 adr_drv_stat=5;
6809  12c6 35050008      	mov	_adr_drv_stat,#5
6810  12ca               L3413:
6811                     ; 1393 while(adr_drv_stat==5);
6814  12ca b608          	ld	a,_adr_drv_stat
6815  12cc a105          	cp	a,#5
6816  12ce 27fa          	jreq	L3413
6817                     ; 1397 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6819  12d0 9c            	rvf
6820  12d1 ce0009        	ldw	x,_adc_buff_
6821  12d4 a3022a        	cpw	x,#554
6822  12d7 2f0f          	jrslt	L1513
6824  12d9 9c            	rvf
6825  12da ce0009        	ldw	x,_adc_buff_
6826  12dd a30253        	cpw	x,#595
6827  12e0 2e06          	jrsge	L1513
6830  12e2 725f0006      	clr	_adr
6832  12e6 204c          	jra	L3513
6833  12e8               L1513:
6834                     ; 1398 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6836  12e8 9c            	rvf
6837  12e9 ce0009        	ldw	x,_adc_buff_
6838  12ec a3036d        	cpw	x,#877
6839  12ef 2f0f          	jrslt	L5513
6841  12f1 9c            	rvf
6842  12f2 ce0009        	ldw	x,_adc_buff_
6843  12f5 a30396        	cpw	x,#918
6844  12f8 2e06          	jrsge	L5513
6847  12fa 35010006      	mov	_adr,#1
6849  12fe 2034          	jra	L3513
6850  1300               L5513:
6851                     ; 1399 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6853  1300 9c            	rvf
6854  1301 ce0009        	ldw	x,_adc_buff_
6855  1304 a302a3        	cpw	x,#675
6856  1307 2f0f          	jrslt	L1613
6858  1309 9c            	rvf
6859  130a ce0009        	ldw	x,_adc_buff_
6860  130d a302cc        	cpw	x,#716
6861  1310 2e06          	jrsge	L1613
6864  1312 35020006      	mov	_adr,#2
6866  1316 201c          	jra	L3513
6867  1318               L1613:
6868                     ; 1400 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6870  1318 9c            	rvf
6871  1319 ce0009        	ldw	x,_adc_buff_
6872  131c a303e3        	cpw	x,#995
6873  131f 2f0f          	jrslt	L5613
6875  1321 9c            	rvf
6876  1322 ce0009        	ldw	x,_adc_buff_
6877  1325 a3040c        	cpw	x,#1036
6878  1328 2e06          	jrsge	L5613
6881  132a 35030006      	mov	_adr,#3
6883  132e 2004          	jra	L3513
6884  1330               L5613:
6885                     ; 1401 else adr[0]=5;
6887  1330 35050006      	mov	_adr,#5
6888  1334               L3513:
6889                     ; 1403 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6891  1334 9c            	rvf
6892  1335 ce000b        	ldw	x,_adc_buff_+2
6893  1338 a3022a        	cpw	x,#554
6894  133b 2f0f          	jrslt	L1713
6896  133d 9c            	rvf
6897  133e ce000b        	ldw	x,_adc_buff_+2
6898  1341 a30253        	cpw	x,#595
6899  1344 2e06          	jrsge	L1713
6902  1346 725f0007      	clr	_adr+1
6904  134a 204c          	jra	L3713
6905  134c               L1713:
6906                     ; 1404 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6908  134c 9c            	rvf
6909  134d ce000b        	ldw	x,_adc_buff_+2
6910  1350 a3036d        	cpw	x,#877
6911  1353 2f0f          	jrslt	L5713
6913  1355 9c            	rvf
6914  1356 ce000b        	ldw	x,_adc_buff_+2
6915  1359 a30396        	cpw	x,#918
6916  135c 2e06          	jrsge	L5713
6919  135e 35010007      	mov	_adr+1,#1
6921  1362 2034          	jra	L3713
6922  1364               L5713:
6923                     ; 1405 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6925  1364 9c            	rvf
6926  1365 ce000b        	ldw	x,_adc_buff_+2
6927  1368 a302a3        	cpw	x,#675
6928  136b 2f0f          	jrslt	L1023
6930  136d 9c            	rvf
6931  136e ce000b        	ldw	x,_adc_buff_+2
6932  1371 a302cc        	cpw	x,#716
6933  1374 2e06          	jrsge	L1023
6936  1376 35020007      	mov	_adr+1,#2
6938  137a 201c          	jra	L3713
6939  137c               L1023:
6940                     ; 1406 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6942  137c 9c            	rvf
6943  137d ce000b        	ldw	x,_adc_buff_+2
6944  1380 a303e3        	cpw	x,#995
6945  1383 2f0f          	jrslt	L5023
6947  1385 9c            	rvf
6948  1386 ce000b        	ldw	x,_adc_buff_+2
6949  1389 a3040c        	cpw	x,#1036
6950  138c 2e06          	jrsge	L5023
6953  138e 35030007      	mov	_adr+1,#3
6955  1392 2004          	jra	L3713
6956  1394               L5023:
6957                     ; 1407 else adr[1]=5;
6959  1394 35050007      	mov	_adr+1,#5
6960  1398               L3713:
6961                     ; 1409 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6963  1398 9c            	rvf
6964  1399 ce001b        	ldw	x,_adc_buff_+18
6965  139c a3022a        	cpw	x,#554
6966  139f 2f0f          	jrslt	L1123
6968  13a1 9c            	rvf
6969  13a2 ce001b        	ldw	x,_adc_buff_+18
6970  13a5 a30253        	cpw	x,#595
6971  13a8 2e06          	jrsge	L1123
6974  13aa 725f0008      	clr	_adr+2
6976  13ae 204c          	jra	L3123
6977  13b0               L1123:
6978                     ; 1410 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6980  13b0 9c            	rvf
6981  13b1 ce001b        	ldw	x,_adc_buff_+18
6982  13b4 a3036d        	cpw	x,#877
6983  13b7 2f0f          	jrslt	L5123
6985  13b9 9c            	rvf
6986  13ba ce001b        	ldw	x,_adc_buff_+18
6987  13bd a30396        	cpw	x,#918
6988  13c0 2e06          	jrsge	L5123
6991  13c2 35010008      	mov	_adr+2,#1
6993  13c6 2034          	jra	L3123
6994  13c8               L5123:
6995                     ; 1411 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6997  13c8 9c            	rvf
6998  13c9 ce001b        	ldw	x,_adc_buff_+18
6999  13cc a302a3        	cpw	x,#675
7000  13cf 2f0f          	jrslt	L1223
7002  13d1 9c            	rvf
7003  13d2 ce001b        	ldw	x,_adc_buff_+18
7004  13d5 a302cc        	cpw	x,#716
7005  13d8 2e06          	jrsge	L1223
7008  13da 35020008      	mov	_adr+2,#2
7010  13de 201c          	jra	L3123
7011  13e0               L1223:
7012                     ; 1412 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
7014  13e0 9c            	rvf
7015  13e1 ce001b        	ldw	x,_adc_buff_+18
7016  13e4 a303e3        	cpw	x,#995
7017  13e7 2f0f          	jrslt	L5223
7019  13e9 9c            	rvf
7020  13ea ce001b        	ldw	x,_adc_buff_+18
7021  13ed a3040c        	cpw	x,#1036
7022  13f0 2e06          	jrsge	L5223
7025  13f2 35030008      	mov	_adr+2,#3
7027  13f6 2004          	jra	L3123
7028  13f8               L5223:
7029                     ; 1413 else adr[2]=5;
7031  13f8 35050008      	mov	_adr+2,#5
7032  13fc               L3123:
7033                     ; 1417 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
7035  13fc c60006        	ld	a,_adr
7036  13ff a105          	cp	a,#5
7037  1401 270e          	jreq	L3323
7039  1403 c60007        	ld	a,_adr+1
7040  1406 a105          	cp	a,#5
7041  1408 2707          	jreq	L3323
7043  140a c60008        	ld	a,_adr+2
7044  140d a105          	cp	a,#5
7045  140f 2606          	jrne	L1323
7046  1411               L3323:
7047                     ; 1420 	adress_error=1;
7049  1411 35010004      	mov	_adress_error,#1
7051  1415               L7323:
7052                     ; 1431 }
7055  1415 84            	pop	a
7056  1416 81            	ret
7057  1417               L1323:
7058                     ; 1424 	if(adr[2]&0x02) bps_class=bpsIPS;
7060  1417 c60008        	ld	a,_adr+2
7061  141a a502          	bcp	a,#2
7062  141c 2706          	jreq	L1423
7065  141e 35010004      	mov	_bps_class,#1
7067  1422 2002          	jra	L3423
7068  1424               L1423:
7069                     ; 1425 	else bps_class=bpsIBEP;
7071  1424 3f04          	clr	_bps_class
7072  1426               L3423:
7073                     ; 1427 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
7075  1426 c60008        	ld	a,_adr+2
7076  1429 a401          	and	a,#1
7077  142b 97            	ld	xl,a
7078  142c a610          	ld	a,#16
7079  142e 42            	mul	x,a
7080  142f 9f            	ld	a,xl
7081  1430 6b01          	ld	(OFST+0,sp),a
7082  1432 c60007        	ld	a,_adr+1
7083  1435 48            	sll	a
7084  1436 48            	sll	a
7085  1437 cb0006        	add	a,_adr
7086  143a 1b01          	add	a,(OFST+0,sp)
7087  143c c70005        	ld	_adress,a
7088  143f 20d4          	jra	L7323
7132                     ; 1434 void volum_u_main_drv(void)
7132                     ; 1435 {
7133                     	switch	.text
7134  1441               _volum_u_main_drv:
7136  1441 88            	push	a
7137       00000001      OFST:	set	1
7140                     ; 1438 if(bMAIN)
7142                     	btst	_bMAIN
7143  1447 2503          	jrult	L241
7144  1449 cc1592        	jp	L3623
7145  144c               L241:
7146                     ; 1440 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7148  144c 9c            	rvf
7149  144d ce0008        	ldw	x,_UU_AVT
7150  1450 1d000a        	subw	x,#10
7151  1453 b36d          	cpw	x,_Un
7152  1455 2d09          	jrsle	L5623
7155  1457 be1f          	ldw	x,_volum_u_main_
7156  1459 1c0005        	addw	x,#5
7157  145c bf1f          	ldw	_volum_u_main_,x
7159  145e 2036          	jra	L7623
7160  1460               L5623:
7161                     ; 1441 	else if(Un<(UU_AVT-1))volum_u_main_++;
7163  1460 9c            	rvf
7164  1461 ce0008        	ldw	x,_UU_AVT
7165  1464 5a            	decw	x
7166  1465 b36d          	cpw	x,_Un
7167  1467 2d09          	jrsle	L1723
7170  1469 be1f          	ldw	x,_volum_u_main_
7171  146b 1c0001        	addw	x,#1
7172  146e bf1f          	ldw	_volum_u_main_,x
7174  1470 2024          	jra	L7623
7175  1472               L1723:
7176                     ; 1442 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7178  1472 9c            	rvf
7179  1473 ce0008        	ldw	x,_UU_AVT
7180  1476 1c000a        	addw	x,#10
7181  1479 b36d          	cpw	x,_Un
7182  147b 2e09          	jrsge	L5723
7185  147d be1f          	ldw	x,_volum_u_main_
7186  147f 1d000a        	subw	x,#10
7187  1482 bf1f          	ldw	_volum_u_main_,x
7189  1484 2010          	jra	L7623
7190  1486               L5723:
7191                     ; 1443 	else if(Un>(UU_AVT+1))volum_u_main_--;
7193  1486 9c            	rvf
7194  1487 ce0008        	ldw	x,_UU_AVT
7195  148a 5c            	incw	x
7196  148b b36d          	cpw	x,_Un
7197  148d 2e07          	jrsge	L7623
7200  148f be1f          	ldw	x,_volum_u_main_
7201  1491 1d0001        	subw	x,#1
7202  1494 bf1f          	ldw	_volum_u_main_,x
7203  1496               L7623:
7204                     ; 1444 	if(volum_u_main_>1020)volum_u_main_=1020;
7206  1496 9c            	rvf
7207  1497 be1f          	ldw	x,_volum_u_main_
7208  1499 a303fd        	cpw	x,#1021
7209  149c 2f05          	jrslt	L3033
7212  149e ae03fc        	ldw	x,#1020
7213  14a1 bf1f          	ldw	_volum_u_main_,x
7214  14a3               L3033:
7215                     ; 1445 	if(volum_u_main_<0)volum_u_main_=0;
7217  14a3 9c            	rvf
7218  14a4 be1f          	ldw	x,_volum_u_main_
7219  14a6 2e03          	jrsge	L5033
7222  14a8 5f            	clrw	x
7223  14a9 bf1f          	ldw	_volum_u_main_,x
7224  14ab               L5033:
7225                     ; 1448 	i_main_sigma=0;
7227  14ab 5f            	clrw	x
7228  14ac bf0f          	ldw	_i_main_sigma,x
7229                     ; 1449 	i_main_num_of_bps=0;
7231  14ae 3f11          	clr	_i_main_num_of_bps
7232                     ; 1450 	for(i=0;i<6;i++)
7234  14b0 0f01          	clr	(OFST+0,sp)
7235  14b2               L7033:
7236                     ; 1452 		if(i_main_flag[i])
7238  14b2 7b01          	ld	a,(OFST+0,sp)
7239  14b4 5f            	clrw	x
7240  14b5 97            	ld	xl,a
7241  14b6 6d14          	tnz	(_i_main_flag,x)
7242  14b8 2719          	jreq	L5133
7243                     ; 1454 			i_main_sigma+=i_main[i];
7245  14ba 7b01          	ld	a,(OFST+0,sp)
7246  14bc 5f            	clrw	x
7247  14bd 97            	ld	xl,a
7248  14be 58            	sllw	x
7249  14bf ee1a          	ldw	x,(_i_main,x)
7250  14c1 72bb000f      	addw	x,_i_main_sigma
7251  14c5 bf0f          	ldw	_i_main_sigma,x
7252                     ; 1455 			i_main_flag[i]=1;
7254  14c7 7b01          	ld	a,(OFST+0,sp)
7255  14c9 5f            	clrw	x
7256  14ca 97            	ld	xl,a
7257  14cb a601          	ld	a,#1
7258  14cd e714          	ld	(_i_main_flag,x),a
7259                     ; 1456 			i_main_num_of_bps++;
7261  14cf 3c11          	inc	_i_main_num_of_bps
7263  14d1 2006          	jra	L7133
7264  14d3               L5133:
7265                     ; 1460 			i_main_flag[i]=0;	
7267  14d3 7b01          	ld	a,(OFST+0,sp)
7268  14d5 5f            	clrw	x
7269  14d6 97            	ld	xl,a
7270  14d7 6f14          	clr	(_i_main_flag,x)
7271  14d9               L7133:
7272                     ; 1450 	for(i=0;i<6;i++)
7274  14d9 0c01          	inc	(OFST+0,sp)
7277  14db 7b01          	ld	a,(OFST+0,sp)
7278  14dd a106          	cp	a,#6
7279  14df 25d1          	jrult	L7033
7280                     ; 1463 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7282  14e1 be0f          	ldw	x,_i_main_sigma
7283  14e3 b611          	ld	a,_i_main_num_of_bps
7284  14e5 905f          	clrw	y
7285  14e7 9097          	ld	yl,a
7286  14e9 cd0000        	call	c_idiv
7288  14ec bf12          	ldw	_i_main_avg,x
7289                     ; 1464 	for(i=0;i<6;i++)
7291  14ee 0f01          	clr	(OFST+0,sp)
7292  14f0               L1233:
7293                     ; 1466 		if(i_main_flag[i])
7295  14f0 7b01          	ld	a,(OFST+0,sp)
7296  14f2 5f            	clrw	x
7297  14f3 97            	ld	xl,a
7298  14f4 6d14          	tnz	(_i_main_flag,x)
7299  14f6 2603cc1587    	jreq	L7233
7300                     ; 1468 			if(i_main[i]<(i_main_avg-10))x[i]++;
7302  14fb 9c            	rvf
7303  14fc 7b01          	ld	a,(OFST+0,sp)
7304  14fe 5f            	clrw	x
7305  14ff 97            	ld	xl,a
7306  1500 58            	sllw	x
7307  1501 90be12        	ldw	y,_i_main_avg
7308  1504 72a2000a      	subw	y,#10
7309  1508 90bf00        	ldw	c_y,y
7310  150b 9093          	ldw	y,x
7311  150d 90ee1a        	ldw	y,(_i_main,y)
7312  1510 90b300        	cpw	y,c_y
7313  1513 2e11          	jrsge	L1333
7316  1515 7b01          	ld	a,(OFST+0,sp)
7317  1517 5f            	clrw	x
7318  1518 97            	ld	xl,a
7319  1519 58            	sllw	x
7320  151a 9093          	ldw	y,x
7321  151c ee26          	ldw	x,(_x,x)
7322  151e 1c0001        	addw	x,#1
7323  1521 90ef26        	ldw	(_x,y),x
7325  1524 2029          	jra	L3333
7326  1526               L1333:
7327                     ; 1469 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7329  1526 9c            	rvf
7330  1527 7b01          	ld	a,(OFST+0,sp)
7331  1529 5f            	clrw	x
7332  152a 97            	ld	xl,a
7333  152b 58            	sllw	x
7334  152c 90be12        	ldw	y,_i_main_avg
7335  152f 72a9000a      	addw	y,#10
7336  1533 90bf00        	ldw	c_y,y
7337  1536 9093          	ldw	y,x
7338  1538 90ee1a        	ldw	y,(_i_main,y)
7339  153b 90b300        	cpw	y,c_y
7340  153e 2d0f          	jrsle	L3333
7343  1540 7b01          	ld	a,(OFST+0,sp)
7344  1542 5f            	clrw	x
7345  1543 97            	ld	xl,a
7346  1544 58            	sllw	x
7347  1545 9093          	ldw	y,x
7348  1547 ee26          	ldw	x,(_x,x)
7349  1549 1d0001        	subw	x,#1
7350  154c 90ef26        	ldw	(_x,y),x
7351  154f               L3333:
7352                     ; 1470 			if(x[i]>100)x[i]=100;
7354  154f 9c            	rvf
7355  1550 7b01          	ld	a,(OFST+0,sp)
7356  1552 5f            	clrw	x
7357  1553 97            	ld	xl,a
7358  1554 58            	sllw	x
7359  1555 9093          	ldw	y,x
7360  1557 90ee26        	ldw	y,(_x,y)
7361  155a 90a30065      	cpw	y,#101
7362  155e 2f0b          	jrslt	L7333
7365  1560 7b01          	ld	a,(OFST+0,sp)
7366  1562 5f            	clrw	x
7367  1563 97            	ld	xl,a
7368  1564 58            	sllw	x
7369  1565 90ae0064      	ldw	y,#100
7370  1569 ef26          	ldw	(_x,x),y
7371  156b               L7333:
7372                     ; 1471 			if(x[i]<-100)x[i]=-100;
7374  156b 9c            	rvf
7375  156c 7b01          	ld	a,(OFST+0,sp)
7376  156e 5f            	clrw	x
7377  156f 97            	ld	xl,a
7378  1570 58            	sllw	x
7379  1571 9093          	ldw	y,x
7380  1573 90ee26        	ldw	y,(_x,y)
7381  1576 90a3ff9c      	cpw	y,#65436
7382  157a 2e0b          	jrsge	L7233
7385  157c 7b01          	ld	a,(OFST+0,sp)
7386  157e 5f            	clrw	x
7387  157f 97            	ld	xl,a
7388  1580 58            	sllw	x
7389  1581 90aeff9c      	ldw	y,#65436
7390  1585 ef26          	ldw	(_x,x),y
7391  1587               L7233:
7392                     ; 1464 	for(i=0;i<6;i++)
7394  1587 0c01          	inc	(OFST+0,sp)
7397  1589 7b01          	ld	a,(OFST+0,sp)
7398  158b a106          	cp	a,#6
7399  158d 2403cc14f0    	jrult	L1233
7400  1592               L3623:
7401                     ; 1478 }
7404  1592 84            	pop	a
7405  1593 81            	ret
7428                     ; 1481 void init_CAN(void) {
7429                     	switch	.text
7430  1594               _init_CAN:
7434                     ; 1482 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7436  1594 72135420      	bres	21536,#1
7437                     ; 1483 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7439  1598 72105420      	bset	21536,#0
7441  159c               L5533:
7442                     ; 1484 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7444  159c c65421        	ld	a,21537
7445  159f a501          	bcp	a,#1
7446  15a1 27f9          	jreq	L5533
7447                     ; 1486 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7449  15a3 72185420      	bset	21536,#4
7450                     ; 1488 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7452  15a7 35025427      	mov	21543,#2
7453                     ; 1497 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7455  15ab 35135428      	mov	21544,#19
7456                     ; 1498 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7458  15af 35c05429      	mov	21545,#192
7459                     ; 1499 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7461  15b3 357f542c      	mov	21548,#127
7462                     ; 1500 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7464  15b7 35e0542d      	mov	21549,#224
7465                     ; 1502 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7467  15bb 35315430      	mov	21552,#49
7468                     ; 1503 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7470  15bf 35c05431      	mov	21553,#192
7471                     ; 1504 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7473  15c3 357f5434      	mov	21556,#127
7474                     ; 1505 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7476  15c7 35e05435      	mov	21557,#224
7477                     ; 1509 	CAN->PSR= 6;									// set page 6
7479  15cb 35065427      	mov	21543,#6
7480                     ; 1514 	CAN->Page.Config.FMR1&=~3;								//mask mode
7482  15cf c65430        	ld	a,21552
7483  15d2 a4fc          	and	a,#252
7484  15d4 c75430        	ld	21552,a
7485                     ; 1520 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7487  15d7 35065432      	mov	21554,#6
7488                     ; 1521 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7490  15db 35605432      	mov	21554,#96
7491                     ; 1524 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7493  15df 72105432      	bset	21554,#0
7494                     ; 1525 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7496  15e3 72185432      	bset	21554,#4
7497                     ; 1528 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7499  15e7 35065427      	mov	21543,#6
7500                     ; 1530 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7502  15eb 3509542c      	mov	21548,#9
7503                     ; 1531 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7505  15ef 35e7542d      	mov	21549,#231
7506                     ; 1533 	CAN->IER|=(1<<1);
7508  15f3 72125425      	bset	21541,#1
7509                     ; 1536 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7511  15f7 72115420      	bres	21536,#0
7513  15fb               L3633:
7514                     ; 1537 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7516  15fb c65421        	ld	a,21537
7517  15fe a501          	bcp	a,#1
7518  1600 26f9          	jrne	L3633
7519                     ; 1538 }
7522  1602 81            	ret
7630                     ; 1541 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7630                     ; 1542 {
7631                     	switch	.text
7632  1603               _can_transmit:
7634  1603 89            	pushw	x
7635       00000000      OFST:	set	0
7638                     ; 1544 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7640  1604 b674          	ld	a,_can_buff_wr_ptr
7641  1606 a104          	cp	a,#4
7642  1608 2502          	jrult	L5443
7645  160a 3f74          	clr	_can_buff_wr_ptr
7646  160c               L5443:
7647                     ; 1546 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7649  160c b674          	ld	a,_can_buff_wr_ptr
7650  160e 97            	ld	xl,a
7651  160f a610          	ld	a,#16
7652  1611 42            	mul	x,a
7653  1612 1601          	ldw	y,(OFST+1,sp)
7654  1614 a606          	ld	a,#6
7655  1616               L051:
7656  1616 9054          	srlw	y
7657  1618 4a            	dec	a
7658  1619 26fb          	jrne	L051
7659  161b 909f          	ld	a,yl
7660  161d e775          	ld	(_can_out_buff,x),a
7661                     ; 1547 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7663  161f b674          	ld	a,_can_buff_wr_ptr
7664  1621 97            	ld	xl,a
7665  1622 a610          	ld	a,#16
7666  1624 42            	mul	x,a
7667  1625 7b02          	ld	a,(OFST+2,sp)
7668  1627 48            	sll	a
7669  1628 48            	sll	a
7670  1629 e776          	ld	(_can_out_buff+1,x),a
7671                     ; 1549 can_out_buff[can_buff_wr_ptr][2]=data0;
7673  162b b674          	ld	a,_can_buff_wr_ptr
7674  162d 97            	ld	xl,a
7675  162e a610          	ld	a,#16
7676  1630 42            	mul	x,a
7677  1631 7b05          	ld	a,(OFST+5,sp)
7678  1633 e777          	ld	(_can_out_buff+2,x),a
7679                     ; 1550 can_out_buff[can_buff_wr_ptr][3]=data1;
7681  1635 b674          	ld	a,_can_buff_wr_ptr
7682  1637 97            	ld	xl,a
7683  1638 a610          	ld	a,#16
7684  163a 42            	mul	x,a
7685  163b 7b06          	ld	a,(OFST+6,sp)
7686  163d e778          	ld	(_can_out_buff+3,x),a
7687                     ; 1551 can_out_buff[can_buff_wr_ptr][4]=data2;
7689  163f b674          	ld	a,_can_buff_wr_ptr
7690  1641 97            	ld	xl,a
7691  1642 a610          	ld	a,#16
7692  1644 42            	mul	x,a
7693  1645 7b07          	ld	a,(OFST+7,sp)
7694  1647 e779          	ld	(_can_out_buff+4,x),a
7695                     ; 1552 can_out_buff[can_buff_wr_ptr][5]=data3;
7697  1649 b674          	ld	a,_can_buff_wr_ptr
7698  164b 97            	ld	xl,a
7699  164c a610          	ld	a,#16
7700  164e 42            	mul	x,a
7701  164f 7b08          	ld	a,(OFST+8,sp)
7702  1651 e77a          	ld	(_can_out_buff+5,x),a
7703                     ; 1553 can_out_buff[can_buff_wr_ptr][6]=data4;
7705  1653 b674          	ld	a,_can_buff_wr_ptr
7706  1655 97            	ld	xl,a
7707  1656 a610          	ld	a,#16
7708  1658 42            	mul	x,a
7709  1659 7b09          	ld	a,(OFST+9,sp)
7710  165b e77b          	ld	(_can_out_buff+6,x),a
7711                     ; 1554 can_out_buff[can_buff_wr_ptr][7]=data5;
7713  165d b674          	ld	a,_can_buff_wr_ptr
7714  165f 97            	ld	xl,a
7715  1660 a610          	ld	a,#16
7716  1662 42            	mul	x,a
7717  1663 7b0a          	ld	a,(OFST+10,sp)
7718  1665 e77c          	ld	(_can_out_buff+7,x),a
7719                     ; 1555 can_out_buff[can_buff_wr_ptr][8]=data6;
7721  1667 b674          	ld	a,_can_buff_wr_ptr
7722  1669 97            	ld	xl,a
7723  166a a610          	ld	a,#16
7724  166c 42            	mul	x,a
7725  166d 7b0b          	ld	a,(OFST+11,sp)
7726  166f e77d          	ld	(_can_out_buff+8,x),a
7727                     ; 1556 can_out_buff[can_buff_wr_ptr][9]=data7;
7729  1671 b674          	ld	a,_can_buff_wr_ptr
7730  1673 97            	ld	xl,a
7731  1674 a610          	ld	a,#16
7732  1676 42            	mul	x,a
7733  1677 7b0c          	ld	a,(OFST+12,sp)
7734  1679 e77e          	ld	(_can_out_buff+9,x),a
7735                     ; 1558 can_buff_wr_ptr++;
7737  167b 3c74          	inc	_can_buff_wr_ptr
7738                     ; 1559 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7740  167d b674          	ld	a,_can_buff_wr_ptr
7741  167f a104          	cp	a,#4
7742  1681 2502          	jrult	L7443
7745  1683 3f74          	clr	_can_buff_wr_ptr
7746  1685               L7443:
7747                     ; 1560 } 
7750  1685 85            	popw	x
7751  1686 81            	ret
7780                     ; 1563 void can_tx_hndl(void)
7780                     ; 1564 {
7781                     	switch	.text
7782  1687               _can_tx_hndl:
7786                     ; 1565 if(bTX_FREE)
7788  1687 3d09          	tnz	_bTX_FREE
7789  1689 2757          	jreq	L1643
7790                     ; 1567 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7792  168b b673          	ld	a,_can_buff_rd_ptr
7793  168d b174          	cp	a,_can_buff_wr_ptr
7794  168f 275f          	jreq	L7643
7795                     ; 1569 		bTX_FREE=0;
7797  1691 3f09          	clr	_bTX_FREE
7798                     ; 1571 		CAN->PSR= 0;
7800  1693 725f5427      	clr	21543
7801                     ; 1572 		CAN->Page.TxMailbox.MDLCR=8;
7803  1697 35085429      	mov	21545,#8
7804                     ; 1573 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7806  169b b673          	ld	a,_can_buff_rd_ptr
7807  169d 97            	ld	xl,a
7808  169e a610          	ld	a,#16
7809  16a0 42            	mul	x,a
7810  16a1 e675          	ld	a,(_can_out_buff,x)
7811  16a3 c7542a        	ld	21546,a
7812                     ; 1574 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7814  16a6 b673          	ld	a,_can_buff_rd_ptr
7815  16a8 97            	ld	xl,a
7816  16a9 a610          	ld	a,#16
7817  16ab 42            	mul	x,a
7818  16ac e676          	ld	a,(_can_out_buff+1,x)
7819  16ae c7542b        	ld	21547,a
7820                     ; 1576 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7822  16b1 b673          	ld	a,_can_buff_rd_ptr
7823  16b3 97            	ld	xl,a
7824  16b4 a610          	ld	a,#16
7825  16b6 42            	mul	x,a
7826  16b7 01            	rrwa	x,a
7827  16b8 ab77          	add	a,#_can_out_buff+2
7828  16ba 2401          	jrnc	L451
7829  16bc 5c            	incw	x
7830  16bd               L451:
7831  16bd 5f            	clrw	x
7832  16be 97            	ld	xl,a
7833  16bf bf00          	ldw	c_x,x
7834  16c1 ae0008        	ldw	x,#8
7835  16c4               L651:
7836  16c4 5a            	decw	x
7837  16c5 92d600        	ld	a,([c_x],x)
7838  16c8 d7542e        	ld	(21550,x),a
7839  16cb 5d            	tnzw	x
7840  16cc 26f6          	jrne	L651
7841                     ; 1578 		can_buff_rd_ptr++;
7843  16ce 3c73          	inc	_can_buff_rd_ptr
7844                     ; 1579 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7846  16d0 b673          	ld	a,_can_buff_rd_ptr
7847  16d2 a104          	cp	a,#4
7848  16d4 2502          	jrult	L5643
7851  16d6 3f73          	clr	_can_buff_rd_ptr
7852  16d8               L5643:
7853                     ; 1581 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7855  16d8 72105428      	bset	21544,#0
7856                     ; 1582 		CAN->IER|=(1<<0);
7858  16dc 72105425      	bset	21541,#0
7859  16e0 200e          	jra	L7643
7860  16e2               L1643:
7861                     ; 1587 	tx_busy_cnt++;
7863  16e2 3c72          	inc	_tx_busy_cnt
7864                     ; 1588 	if(tx_busy_cnt>=100)
7866  16e4 b672          	ld	a,_tx_busy_cnt
7867  16e6 a164          	cp	a,#100
7868  16e8 2506          	jrult	L7643
7869                     ; 1590 		tx_busy_cnt=0;
7871  16ea 3f72          	clr	_tx_busy_cnt
7872                     ; 1591 		bTX_FREE=1;
7874  16ec 35010009      	mov	_bTX_FREE,#1
7875  16f0               L7643:
7876                     ; 1594 }
7879  16f0 81            	ret
7918                     ; 1597 void net_drv(void)
7918                     ; 1598 { 
7919                     	switch	.text
7920  16f1               _net_drv:
7924                     ; 1600 if(bMAIN)
7926                     	btst	_bMAIN
7927  16f6 2503          	jrult	L261
7928  16f8 cc179e        	jp	L3053
7929  16fb               L261:
7930                     ; 1602 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7932  16fb 3c32          	inc	_cnt_net_drv
7933  16fd b632          	ld	a,_cnt_net_drv
7934  16ff a107          	cp	a,#7
7935  1701 2502          	jrult	L5053
7938  1703 3f32          	clr	_cnt_net_drv
7939  1705               L5053:
7940                     ; 1604 	if(cnt_net_drv<=5) 
7942  1705 b632          	ld	a,_cnt_net_drv
7943  1707 a106          	cp	a,#6
7944  1709 244c          	jruge	L7053
7945                     ; 1606 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7947  170b 4be8          	push	#232
7948  170d 4be8          	push	#232
7949  170f b632          	ld	a,_cnt_net_drv
7950  1711 5f            	clrw	x
7951  1712 97            	ld	xl,a
7952  1713 58            	sllw	x
7953  1714 ee26          	ldw	x,(_x,x)
7954  1716 72bb001f      	addw	x,_volum_u_main_
7955  171a 90ae0100      	ldw	y,#256
7956  171e cd0000        	call	c_idiv
7958  1721 9f            	ld	a,xl
7959  1722 88            	push	a
7960  1723 b632          	ld	a,_cnt_net_drv
7961  1725 5f            	clrw	x
7962  1726 97            	ld	xl,a
7963  1727 58            	sllw	x
7964  1728 e627          	ld	a,(_x+1,x)
7965  172a bb20          	add	a,_volum_u_main_+1
7966  172c 88            	push	a
7967  172d 4b00          	push	#0
7968  172f 4bed          	push	#237
7969  1731 3b0032        	push	_cnt_net_drv
7970  1734 3b0032        	push	_cnt_net_drv
7971  1737 ae009e        	ldw	x,#158
7972  173a cd1603        	call	_can_transmit
7974  173d 5b08          	addw	sp,#8
7975                     ; 1607 		i_main_bps_cnt[cnt_net_drv]++;
7977  173f b632          	ld	a,_cnt_net_drv
7978  1741 5f            	clrw	x
7979  1742 97            	ld	xl,a
7980  1743 6c09          	inc	(_i_main_bps_cnt,x)
7981                     ; 1608 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7983  1745 b632          	ld	a,_cnt_net_drv
7984  1747 5f            	clrw	x
7985  1748 97            	ld	xl,a
7986  1749 e609          	ld	a,(_i_main_bps_cnt,x)
7987  174b a10b          	cp	a,#11
7988  174d 254f          	jrult	L3053
7991  174f b632          	ld	a,_cnt_net_drv
7992  1751 5f            	clrw	x
7993  1752 97            	ld	xl,a
7994  1753 6f14          	clr	(_i_main_flag,x)
7995  1755 2047          	jra	L3053
7996  1757               L7053:
7997                     ; 1610 	else if(cnt_net_drv==6)
7999  1757 b632          	ld	a,_cnt_net_drv
8000  1759 a106          	cp	a,#6
8001  175b 2641          	jrne	L3053
8002                     ; 1612 		plazma_int[2]=pwm_u;
8004  175d be0e          	ldw	x,_pwm_u
8005  175f bf37          	ldw	_plazma_int+4,x
8006                     ; 1613 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8008  1761 3b006b        	push	_Ui
8009  1764 3b006c        	push	_Ui+1
8010  1767 3b006d        	push	_Un
8011  176a 3b006e        	push	_Un+1
8012  176d 3b006f        	push	_I
8013  1770 3b0070        	push	_I+1
8014  1773 4bda          	push	#218
8015  1775 3b0005        	push	_adress
8016  1778 ae018e        	ldw	x,#398
8017  177b cd1603        	call	_can_transmit
8019  177e 5b08          	addw	sp,#8
8020                     ; 1614 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8022  1780 3b0037        	push	_plazma_int+4
8023  1783 3b0038        	push	_plazma_int+5
8024  1786 3b005f        	push	__x_+1
8025  1789 3b000b        	push	_flags
8026  178c 4b00          	push	#0
8027  178e 3b0068        	push	_T
8028  1791 4bdb          	push	#219
8029  1793 3b0005        	push	_adress
8030  1796 ae018e        	ldw	x,#398
8031  1799 cd1603        	call	_can_transmit
8033  179c 5b08          	addw	sp,#8
8034  179e               L3053:
8035                     ; 1617 }
8038  179e 81            	ret
8152                     ; 1620 void can_in_an(void)
8152                     ; 1621 {
8153                     	switch	.text
8154  179f               _can_in_an:
8156  179f 5205          	subw	sp,#5
8157       00000005      OFST:	set	5
8160                     ; 1631 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8162  17a1 b6ca          	ld	a,_mess+6
8163  17a3 c10005        	cp	a,_adress
8164  17a6 2703          	jreq	L402
8165  17a8 cc18c4        	jp	L3553
8166  17ab               L402:
8168  17ab b6cb          	ld	a,_mess+7
8169  17ad c10005        	cp	a,_adress
8170  17b0 2703          	jreq	L602
8171  17b2 cc18c4        	jp	L3553
8172  17b5               L602:
8174  17b5 b6cc          	ld	a,_mess+8
8175  17b7 a1ed          	cp	a,#237
8176  17b9 2703          	jreq	L012
8177  17bb cc18c4        	jp	L3553
8178  17be               L012:
8179                     ; 1634 	can_error_cnt=0;
8181  17be 3f71          	clr	_can_error_cnt
8182                     ; 1636 	bMAIN=0;
8184  17c0 72110001      	bres	_bMAIN
8185                     ; 1637  	flags_tu=mess[9];
8187  17c4 45cd60        	mov	_flags_tu,_mess+9
8188                     ; 1638  	if(flags_tu&0b00000001)
8190  17c7 b660          	ld	a,_flags_tu
8191  17c9 a501          	bcp	a,#1
8192  17cb 2706          	jreq	L5553
8193                     ; 1643  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8195  17cd 721a000b      	bset	_flags,#5
8197  17d1 200e          	jra	L7553
8198  17d3               L5553:
8199                     ; 1654  				flags&=0b11011111; 
8201  17d3 721b000b      	bres	_flags,#5
8202                     ; 1655  				off_bp_cnt=5*ee_TZAS;
8204  17d7 c60017        	ld	a,_ee_TZAS+1
8205  17da 97            	ld	xl,a
8206  17db a605          	ld	a,#5
8207  17dd 42            	mul	x,a
8208  17de 9f            	ld	a,xl
8209  17df b753          	ld	_off_bp_cnt,a
8210  17e1               L7553:
8211                     ; 1661  	if(flags_tu&0b00000010) flags|=0b01000000;
8213  17e1 b660          	ld	a,_flags_tu
8214  17e3 a502          	bcp	a,#2
8215  17e5 2706          	jreq	L1653
8218  17e7 721c000b      	bset	_flags,#6
8220  17eb 2004          	jra	L3653
8221  17ed               L1653:
8222                     ; 1662  	else flags&=0b10111111; 
8224  17ed 721d000b      	bres	_flags,#6
8225  17f1               L3653:
8226                     ; 1664  	vol_u_temp=mess[10]+mess[11]*256;
8228  17f1 b6cf          	ld	a,_mess+11
8229  17f3 5f            	clrw	x
8230  17f4 97            	ld	xl,a
8231  17f5 4f            	clr	a
8232  17f6 02            	rlwa	x,a
8233  17f7 01            	rrwa	x,a
8234  17f8 bbce          	add	a,_mess+10
8235  17fa 2401          	jrnc	L661
8236  17fc 5c            	incw	x
8237  17fd               L661:
8238  17fd b759          	ld	_vol_u_temp+1,a
8239  17ff 9f            	ld	a,xl
8240  1800 b758          	ld	_vol_u_temp,a
8241                     ; 1665  	vol_i_temp=mess[12]+mess[13]*256;  
8243  1802 b6d1          	ld	a,_mess+13
8244  1804 5f            	clrw	x
8245  1805 97            	ld	xl,a
8246  1806 4f            	clr	a
8247  1807 02            	rlwa	x,a
8248  1808 01            	rrwa	x,a
8249  1809 bbd0          	add	a,_mess+12
8250  180b 2401          	jrnc	L071
8251  180d 5c            	incw	x
8252  180e               L071:
8253  180e b757          	ld	_vol_i_temp+1,a
8254  1810 9f            	ld	a,xl
8255  1811 b756          	ld	_vol_i_temp,a
8256                     ; 1674 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8258  1813 b601          	ld	a,_vent_resurs_tx_cnt
8259  1815 a102          	cp	a,#2
8260  1817 2507          	jrult	L5653
8263  1819 ce0000        	ldw	x,_vent_resurs
8264  181c bf37          	ldw	_plazma_int+4,x
8266  181e 2004          	jra	L7653
8267  1820               L5653:
8268                     ; 1675 	else plazma_int[2]=vent_resurs_sec_cnt;
8270  1820 be02          	ldw	x,_vent_resurs_sec_cnt
8271  1822 bf37          	ldw	_plazma_int+4,x
8272  1824               L7653:
8273                     ; 1676  	rotor_int=flags_tu+(((short)flags)<<8);
8275  1824 b60b          	ld	a,_flags
8276  1826 5f            	clrw	x
8277  1827 97            	ld	xl,a
8278  1828 4f            	clr	a
8279  1829 02            	rlwa	x,a
8280  182a 01            	rrwa	x,a
8281  182b bb60          	add	a,_flags_tu
8282  182d 2401          	jrnc	L271
8283  182f 5c            	incw	x
8284  1830               L271:
8285  1830 b71e          	ld	_rotor_int+1,a
8286  1832 9f            	ld	a,xl
8287  1833 b71d          	ld	_rotor_int,a
8288                     ; 1677 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8290  1835 3b006b        	push	_Ui
8291  1838 3b006c        	push	_Ui+1
8292  183b 3b006d        	push	_Un
8293  183e 3b006e        	push	_Un+1
8294  1841 3b006f        	push	_I
8295  1844 3b0070        	push	_I+1
8296  1847 4bda          	push	#218
8297  1849 3b0005        	push	_adress
8298  184c ae018e        	ldw	x,#398
8299  184f cd1603        	call	_can_transmit
8301  1852 5b08          	addw	sp,#8
8302                     ; 1678 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8304  1854 3b0037        	push	_plazma_int+4
8305  1857 3b0038        	push	_plazma_int+5
8306  185a 3b005f        	push	__x_+1
8307  185d 3b000b        	push	_flags
8308  1860 b601          	ld	a,_vent_resurs_tx_cnt
8309  1862 5f            	clrw	x
8310  1863 97            	ld	xl,a
8311  1864 d60000        	ld	a,(_vent_resurs_buff,x)
8312  1867 88            	push	a
8313  1868 3b0068        	push	_T
8314  186b 4bdb          	push	#219
8315  186d 3b0005        	push	_adress
8316  1870 ae018e        	ldw	x,#398
8317  1873 cd1603        	call	_can_transmit
8319  1876 5b08          	addw	sp,#8
8320                     ; 1679      link_cnt=0;
8322  1878 5f            	clrw	x
8323  1879 bf61          	ldw	_link_cnt,x
8324                     ; 1680      link=ON;
8326  187b 35550063      	mov	_link,#85
8327                     ; 1682      if(flags_tu&0b10000000)
8329  187f b660          	ld	a,_flags_tu
8330  1881 a580          	bcp	a,#128
8331  1883 2716          	jreq	L1753
8332                     ; 1684      	if(!res_fl)
8334  1885 725d000b      	tnz	_res_fl
8335  1889 2625          	jrne	L5753
8336                     ; 1686      		res_fl=1;
8338  188b a601          	ld	a,#1
8339  188d ae000b        	ldw	x,#_res_fl
8340  1890 cd0000        	call	c_eewrc
8342                     ; 1687      		bRES=1;
8344  1893 35010012      	mov	_bRES,#1
8345                     ; 1688      		res_fl_cnt=0;
8347  1897 3f41          	clr	_res_fl_cnt
8348  1899 2015          	jra	L5753
8349  189b               L1753:
8350                     ; 1693      	if(main_cnt>20)
8352  189b 9c            	rvf
8353  189c be51          	ldw	x,_main_cnt
8354  189e a30015        	cpw	x,#21
8355  18a1 2f0d          	jrslt	L5753
8356                     ; 1695     			if(res_fl)
8358  18a3 725d000b      	tnz	_res_fl
8359  18a7 2707          	jreq	L5753
8360                     ; 1697      			res_fl=0;
8362  18a9 4f            	clr	a
8363  18aa ae000b        	ldw	x,#_res_fl
8364  18ad cd0000        	call	c_eewrc
8366  18b0               L5753:
8367                     ; 1702       if(res_fl_)
8369  18b0 725d000a      	tnz	_res_fl_
8370  18b4 2603          	jrne	L212
8371  18b6 cc1e0f        	jp	L7153
8372  18b9               L212:
8373                     ; 1704       	res_fl_=0;
8375  18b9 4f            	clr	a
8376  18ba ae000a        	ldw	x,#_res_fl_
8377  18bd cd0000        	call	c_eewrc
8379  18c0 ac0f1e0f      	jpf	L7153
8380  18c4               L3553:
8381                     ; 1707 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8383  18c4 b6ca          	ld	a,_mess+6
8384  18c6 c10005        	cp	a,_adress
8385  18c9 2703          	jreq	L412
8386  18cb cc1adb        	jp	L7063
8387  18ce               L412:
8389  18ce b6cb          	ld	a,_mess+7
8390  18d0 c10005        	cp	a,_adress
8391  18d3 2703          	jreq	L612
8392  18d5 cc1adb        	jp	L7063
8393  18d8               L612:
8395  18d8 b6cc          	ld	a,_mess+8
8396  18da a1ee          	cp	a,#238
8397  18dc 2703          	jreq	L022
8398  18de cc1adb        	jp	L7063
8399  18e1               L022:
8401  18e1 b6cd          	ld	a,_mess+9
8402  18e3 b1ce          	cp	a,_mess+10
8403  18e5 2703          	jreq	L222
8404  18e7 cc1adb        	jp	L7063
8405  18ea               L222:
8406                     ; 1709 	rotor_int++;
8408  18ea be1d          	ldw	x,_rotor_int
8409  18ec 1c0001        	addw	x,#1
8410  18ef bf1d          	ldw	_rotor_int,x
8411                     ; 1710 	if((mess[9]&0xf0)==0x20)
8413  18f1 b6cd          	ld	a,_mess+9
8414  18f3 a4f0          	and	a,#240
8415  18f5 a120          	cp	a,#32
8416  18f7 2673          	jrne	L1163
8417                     ; 1712 		if((mess[9]&0x0f)==0x01)
8419  18f9 b6cd          	ld	a,_mess+9
8420  18fb a40f          	and	a,#15
8421  18fd a101          	cp	a,#1
8422  18ff 260d          	jrne	L3163
8423                     ; 1714 			ee_K[0][0]=adc_buff_[4];
8425  1901 ce0011        	ldw	x,_adc_buff_+8
8426  1904 89            	pushw	x
8427  1905 ae001a        	ldw	x,#_ee_K
8428  1908 cd0000        	call	c_eewrw
8430  190b 85            	popw	x
8432  190c 204a          	jra	L5163
8433  190e               L3163:
8434                     ; 1716 		else if((mess[9]&0x0f)==0x02)
8436  190e b6cd          	ld	a,_mess+9
8437  1910 a40f          	and	a,#15
8438  1912 a102          	cp	a,#2
8439  1914 260b          	jrne	L7163
8440                     ; 1718 			ee_K[0][1]++;
8442  1916 ce001c        	ldw	x,_ee_K+2
8443  1919 1c0001        	addw	x,#1
8444  191c cf001c        	ldw	_ee_K+2,x
8446  191f 2037          	jra	L5163
8447  1921               L7163:
8448                     ; 1720 		else if((mess[9]&0x0f)==0x03)
8450  1921 b6cd          	ld	a,_mess+9
8451  1923 a40f          	and	a,#15
8452  1925 a103          	cp	a,#3
8453  1927 260b          	jrne	L3263
8454                     ; 1722 			ee_K[0][1]+=10;
8456  1929 ce001c        	ldw	x,_ee_K+2
8457  192c 1c000a        	addw	x,#10
8458  192f cf001c        	ldw	_ee_K+2,x
8460  1932 2024          	jra	L5163
8461  1934               L3263:
8462                     ; 1724 		else if((mess[9]&0x0f)==0x04)
8464  1934 b6cd          	ld	a,_mess+9
8465  1936 a40f          	and	a,#15
8466  1938 a104          	cp	a,#4
8467  193a 260b          	jrne	L7263
8468                     ; 1726 			ee_K[0][1]--;
8470  193c ce001c        	ldw	x,_ee_K+2
8471  193f 1d0001        	subw	x,#1
8472  1942 cf001c        	ldw	_ee_K+2,x
8474  1945 2011          	jra	L5163
8475  1947               L7263:
8476                     ; 1728 		else if((mess[9]&0x0f)==0x05)
8478  1947 b6cd          	ld	a,_mess+9
8479  1949 a40f          	and	a,#15
8480  194b a105          	cp	a,#5
8481  194d 2609          	jrne	L5163
8482                     ; 1730 			ee_K[0][1]-=10;
8484  194f ce001c        	ldw	x,_ee_K+2
8485  1952 1d000a        	subw	x,#10
8486  1955 cf001c        	ldw	_ee_K+2,x
8487  1958               L5163:
8488                     ; 1732 		granee(&ee_K[0][1],50,3000);									
8490  1958 ae0bb8        	ldw	x,#3000
8491  195b 89            	pushw	x
8492  195c ae0032        	ldw	x,#50
8493  195f 89            	pushw	x
8494  1960 ae001c        	ldw	x,#_ee_K+2
8495  1963 cd00f2        	call	_granee
8497  1966 5b04          	addw	sp,#4
8499  1968 acc01ac0      	jpf	L5363
8500  196c               L1163:
8501                     ; 1734 	else if((mess[9]&0xf0)==0x10)
8503  196c b6cd          	ld	a,_mess+9
8504  196e a4f0          	and	a,#240
8505  1970 a110          	cp	a,#16
8506  1972 2673          	jrne	L7363
8507                     ; 1736 		if((mess[9]&0x0f)==0x01)
8509  1974 b6cd          	ld	a,_mess+9
8510  1976 a40f          	and	a,#15
8511  1978 a101          	cp	a,#1
8512  197a 260d          	jrne	L1463
8513                     ; 1738 			ee_K[1][0]=adc_buff_[1];
8515  197c ce000b        	ldw	x,_adc_buff_+2
8516  197f 89            	pushw	x
8517  1980 ae001e        	ldw	x,#_ee_K+4
8518  1983 cd0000        	call	c_eewrw
8520  1986 85            	popw	x
8522  1987 204a          	jra	L3463
8523  1989               L1463:
8524                     ; 1740 		else if((mess[9]&0x0f)==0x02)
8526  1989 b6cd          	ld	a,_mess+9
8527  198b a40f          	and	a,#15
8528  198d a102          	cp	a,#2
8529  198f 260b          	jrne	L5463
8530                     ; 1742 			ee_K[1][1]++;
8532  1991 ce0020        	ldw	x,_ee_K+6
8533  1994 1c0001        	addw	x,#1
8534  1997 cf0020        	ldw	_ee_K+6,x
8536  199a 2037          	jra	L3463
8537  199c               L5463:
8538                     ; 1744 		else if((mess[9]&0x0f)==0x03)
8540  199c b6cd          	ld	a,_mess+9
8541  199e a40f          	and	a,#15
8542  19a0 a103          	cp	a,#3
8543  19a2 260b          	jrne	L1563
8544                     ; 1746 			ee_K[1][1]+=10;
8546  19a4 ce0020        	ldw	x,_ee_K+6
8547  19a7 1c000a        	addw	x,#10
8548  19aa cf0020        	ldw	_ee_K+6,x
8550  19ad 2024          	jra	L3463
8551  19af               L1563:
8552                     ; 1748 		else if((mess[9]&0x0f)==0x04)
8554  19af b6cd          	ld	a,_mess+9
8555  19b1 a40f          	and	a,#15
8556  19b3 a104          	cp	a,#4
8557  19b5 260b          	jrne	L5563
8558                     ; 1750 			ee_K[1][1]--;
8560  19b7 ce0020        	ldw	x,_ee_K+6
8561  19ba 1d0001        	subw	x,#1
8562  19bd cf0020        	ldw	_ee_K+6,x
8564  19c0 2011          	jra	L3463
8565  19c2               L5563:
8566                     ; 1752 		else if((mess[9]&0x0f)==0x05)
8568  19c2 b6cd          	ld	a,_mess+9
8569  19c4 a40f          	and	a,#15
8570  19c6 a105          	cp	a,#5
8571  19c8 2609          	jrne	L3463
8572                     ; 1754 			ee_K[1][1]-=10;
8574  19ca ce0020        	ldw	x,_ee_K+6
8575  19cd 1d000a        	subw	x,#10
8576  19d0 cf0020        	ldw	_ee_K+6,x
8577  19d3               L3463:
8578                     ; 1759 		granee(&ee_K[1][1],10,30000);
8580  19d3 ae7530        	ldw	x,#30000
8581  19d6 89            	pushw	x
8582  19d7 ae000a        	ldw	x,#10
8583  19da 89            	pushw	x
8584  19db ae0020        	ldw	x,#_ee_K+6
8585  19de cd00f2        	call	_granee
8587  19e1 5b04          	addw	sp,#4
8589  19e3 acc01ac0      	jpf	L5363
8590  19e7               L7363:
8591                     ; 1763 	else if((mess[9]&0xf0)==0x00)
8593  19e7 b6cd          	ld	a,_mess+9
8594  19e9 a5f0          	bcp	a,#240
8595  19eb 2671          	jrne	L5663
8596                     ; 1765 		if((mess[9]&0x0f)==0x01)
8598  19ed b6cd          	ld	a,_mess+9
8599  19ef a40f          	and	a,#15
8600  19f1 a101          	cp	a,#1
8601  19f3 260d          	jrne	L7663
8602                     ; 1767 			ee_K[2][0]=adc_buff_[2];
8604  19f5 ce000d        	ldw	x,_adc_buff_+4
8605  19f8 89            	pushw	x
8606  19f9 ae0022        	ldw	x,#_ee_K+8
8607  19fc cd0000        	call	c_eewrw
8609  19ff 85            	popw	x
8611  1a00 204a          	jra	L1763
8612  1a02               L7663:
8613                     ; 1769 		else if((mess[9]&0x0f)==0x02)
8615  1a02 b6cd          	ld	a,_mess+9
8616  1a04 a40f          	and	a,#15
8617  1a06 a102          	cp	a,#2
8618  1a08 260b          	jrne	L3763
8619                     ; 1771 			ee_K[2][1]++;
8621  1a0a ce0024        	ldw	x,_ee_K+10
8622  1a0d 1c0001        	addw	x,#1
8623  1a10 cf0024        	ldw	_ee_K+10,x
8625  1a13 2037          	jra	L1763
8626  1a15               L3763:
8627                     ; 1773 		else if((mess[9]&0x0f)==0x03)
8629  1a15 b6cd          	ld	a,_mess+9
8630  1a17 a40f          	and	a,#15
8631  1a19 a103          	cp	a,#3
8632  1a1b 260b          	jrne	L7763
8633                     ; 1775 			ee_K[2][1]+=10;
8635  1a1d ce0024        	ldw	x,_ee_K+10
8636  1a20 1c000a        	addw	x,#10
8637  1a23 cf0024        	ldw	_ee_K+10,x
8639  1a26 2024          	jra	L1763
8640  1a28               L7763:
8641                     ; 1777 		else if((mess[9]&0x0f)==0x04)
8643  1a28 b6cd          	ld	a,_mess+9
8644  1a2a a40f          	and	a,#15
8645  1a2c a104          	cp	a,#4
8646  1a2e 260b          	jrne	L3073
8647                     ; 1779 			ee_K[2][1]--;
8649  1a30 ce0024        	ldw	x,_ee_K+10
8650  1a33 1d0001        	subw	x,#1
8651  1a36 cf0024        	ldw	_ee_K+10,x
8653  1a39 2011          	jra	L1763
8654  1a3b               L3073:
8655                     ; 1781 		else if((mess[9]&0x0f)==0x05)
8657  1a3b b6cd          	ld	a,_mess+9
8658  1a3d a40f          	and	a,#15
8659  1a3f a105          	cp	a,#5
8660  1a41 2609          	jrne	L1763
8661                     ; 1783 			ee_K[2][1]-=10;
8663  1a43 ce0024        	ldw	x,_ee_K+10
8664  1a46 1d000a        	subw	x,#10
8665  1a49 cf0024        	ldw	_ee_K+10,x
8666  1a4c               L1763:
8667                     ; 1788 		granee(&ee_K[2][1],10,30000);
8669  1a4c ae7530        	ldw	x,#30000
8670  1a4f 89            	pushw	x
8671  1a50 ae000a        	ldw	x,#10
8672  1a53 89            	pushw	x
8673  1a54 ae0024        	ldw	x,#_ee_K+10
8674  1a57 cd00f2        	call	_granee
8676  1a5a 5b04          	addw	sp,#4
8678  1a5c 2062          	jra	L5363
8679  1a5e               L5663:
8680                     ; 1792 	else if((mess[9]&0xf0)==0x30)
8682  1a5e b6cd          	ld	a,_mess+9
8683  1a60 a4f0          	and	a,#240
8684  1a62 a130          	cp	a,#48
8685  1a64 265a          	jrne	L5363
8686                     ; 1794 		if((mess[9]&0x0f)==0x02)
8688  1a66 b6cd          	ld	a,_mess+9
8689  1a68 a40f          	and	a,#15
8690  1a6a a102          	cp	a,#2
8691  1a6c 260b          	jrne	L5173
8692                     ; 1796 			ee_K[3][1]++;
8694  1a6e ce0028        	ldw	x,_ee_K+14
8695  1a71 1c0001        	addw	x,#1
8696  1a74 cf0028        	ldw	_ee_K+14,x
8698  1a77 2037          	jra	L7173
8699  1a79               L5173:
8700                     ; 1798 		else if((mess[9]&0x0f)==0x03)
8702  1a79 b6cd          	ld	a,_mess+9
8703  1a7b a40f          	and	a,#15
8704  1a7d a103          	cp	a,#3
8705  1a7f 260b          	jrne	L1273
8706                     ; 1800 			ee_K[3][1]+=10;
8708  1a81 ce0028        	ldw	x,_ee_K+14
8709  1a84 1c000a        	addw	x,#10
8710  1a87 cf0028        	ldw	_ee_K+14,x
8712  1a8a 2024          	jra	L7173
8713  1a8c               L1273:
8714                     ; 1802 		else if((mess[9]&0x0f)==0x04)
8716  1a8c b6cd          	ld	a,_mess+9
8717  1a8e a40f          	and	a,#15
8718  1a90 a104          	cp	a,#4
8719  1a92 260b          	jrne	L5273
8720                     ; 1804 			ee_K[3][1]--;
8722  1a94 ce0028        	ldw	x,_ee_K+14
8723  1a97 1d0001        	subw	x,#1
8724  1a9a cf0028        	ldw	_ee_K+14,x
8726  1a9d 2011          	jra	L7173
8727  1a9f               L5273:
8728                     ; 1806 		else if((mess[9]&0x0f)==0x05)
8730  1a9f b6cd          	ld	a,_mess+9
8731  1aa1 a40f          	and	a,#15
8732  1aa3 a105          	cp	a,#5
8733  1aa5 2609          	jrne	L7173
8734                     ; 1808 			ee_K[3][1]-=10;
8736  1aa7 ce0028        	ldw	x,_ee_K+14
8737  1aaa 1d000a        	subw	x,#10
8738  1aad cf0028        	ldw	_ee_K+14,x
8739  1ab0               L7173:
8740                     ; 1810 		granee(&ee_K[3][1],300,517);									
8742  1ab0 ae0205        	ldw	x,#517
8743  1ab3 89            	pushw	x
8744  1ab4 ae012c        	ldw	x,#300
8745  1ab7 89            	pushw	x
8746  1ab8 ae0028        	ldw	x,#_ee_K+14
8747  1abb cd00f2        	call	_granee
8749  1abe 5b04          	addw	sp,#4
8750  1ac0               L5363:
8751                     ; 1813 	link_cnt=0;
8753  1ac0 5f            	clrw	x
8754  1ac1 bf61          	ldw	_link_cnt,x
8755                     ; 1814      link=ON;
8757  1ac3 35550063      	mov	_link,#85
8758                     ; 1815      if(res_fl_)
8760  1ac7 725d000a      	tnz	_res_fl_
8761  1acb 2603          	jrne	L422
8762  1acd cc1e0f        	jp	L7153
8763  1ad0               L422:
8764                     ; 1817       	res_fl_=0;
8766  1ad0 4f            	clr	a
8767  1ad1 ae000a        	ldw	x,#_res_fl_
8768  1ad4 cd0000        	call	c_eewrc
8770  1ad7 ac0f1e0f      	jpf	L7153
8771  1adb               L7063:
8772                     ; 1823 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8774  1adb b6ca          	ld	a,_mess+6
8775  1add a1ff          	cp	a,#255
8776  1adf 2703          	jreq	L622
8777  1ae1 cc1b6f        	jp	L7373
8778  1ae4               L622:
8780  1ae4 b6cb          	ld	a,_mess+7
8781  1ae6 a1ff          	cp	a,#255
8782  1ae8 2703          	jreq	L032
8783  1aea cc1b6f        	jp	L7373
8784  1aed               L032:
8786  1aed b6cc          	ld	a,_mess+8
8787  1aef a162          	cp	a,#98
8788  1af1 267c          	jrne	L7373
8789                     ; 1826 	tempSS=mess[9]+(mess[10]*256);
8791  1af3 b6ce          	ld	a,_mess+10
8792  1af5 5f            	clrw	x
8793  1af6 97            	ld	xl,a
8794  1af7 4f            	clr	a
8795  1af8 02            	rlwa	x,a
8796  1af9 01            	rrwa	x,a
8797  1afa bbcd          	add	a,_mess+9
8798  1afc 2401          	jrnc	L471
8799  1afe 5c            	incw	x
8800  1aff               L471:
8801  1aff 02            	rlwa	x,a
8802  1b00 1f04          	ldw	(OFST-1,sp),x
8803  1b02 01            	rrwa	x,a
8804                     ; 1827 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8806  1b03 ce0014        	ldw	x,_ee_Umax
8807  1b06 1304          	cpw	x,(OFST-1,sp)
8808  1b08 270a          	jreq	L1473
8811  1b0a 1e04          	ldw	x,(OFST-1,sp)
8812  1b0c 89            	pushw	x
8813  1b0d ae0014        	ldw	x,#_ee_Umax
8814  1b10 cd0000        	call	c_eewrw
8816  1b13 85            	popw	x
8817  1b14               L1473:
8818                     ; 1828 	tempSS=mess[11]+(mess[12]*256);
8820  1b14 b6d0          	ld	a,_mess+12
8821  1b16 5f            	clrw	x
8822  1b17 97            	ld	xl,a
8823  1b18 4f            	clr	a
8824  1b19 02            	rlwa	x,a
8825  1b1a 01            	rrwa	x,a
8826  1b1b bbcf          	add	a,_mess+11
8827  1b1d 2401          	jrnc	L671
8828  1b1f 5c            	incw	x
8829  1b20               L671:
8830  1b20 02            	rlwa	x,a
8831  1b21 1f04          	ldw	(OFST-1,sp),x
8832  1b23 01            	rrwa	x,a
8833                     ; 1829 	if(ee_dU!=tempSS) ee_dU=tempSS;
8835  1b24 ce0012        	ldw	x,_ee_dU
8836  1b27 1304          	cpw	x,(OFST-1,sp)
8837  1b29 270a          	jreq	L3473
8840  1b2b 1e04          	ldw	x,(OFST-1,sp)
8841  1b2d 89            	pushw	x
8842  1b2e ae0012        	ldw	x,#_ee_dU
8843  1b31 cd0000        	call	c_eewrw
8845  1b34 85            	popw	x
8846  1b35               L3473:
8847                     ; 1830 	if((mess[13]&0x0f)==0x5)
8849  1b35 b6d1          	ld	a,_mess+13
8850  1b37 a40f          	and	a,#15
8851  1b39 a105          	cp	a,#5
8852  1b3b 261a          	jrne	L5473
8853                     ; 1832 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8855  1b3d ce0006        	ldw	x,_ee_AVT_MODE
8856  1b40 a30055        	cpw	x,#85
8857  1b43 2603          	jrne	L232
8858  1b45 cc1e0f        	jp	L7153
8859  1b48               L232:
8862  1b48 ae0055        	ldw	x,#85
8863  1b4b 89            	pushw	x
8864  1b4c ae0006        	ldw	x,#_ee_AVT_MODE
8865  1b4f cd0000        	call	c_eewrw
8867  1b52 85            	popw	x
8868  1b53 ac0f1e0f      	jpf	L7153
8869  1b57               L5473:
8870                     ; 1834 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8872  1b57 ce0006        	ldw	x,_ee_AVT_MODE
8873  1b5a a30055        	cpw	x,#85
8874  1b5d 2703          	jreq	L432
8875  1b5f cc1e0f        	jp	L7153
8876  1b62               L432:
8879  1b62 5f            	clrw	x
8880  1b63 89            	pushw	x
8881  1b64 ae0006        	ldw	x,#_ee_AVT_MODE
8882  1b67 cd0000        	call	c_eewrw
8884  1b6a 85            	popw	x
8885  1b6b ac0f1e0f      	jpf	L7153
8886  1b6f               L7373:
8887                     ; 1837 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8889  1b6f b6ca          	ld	a,_mess+6
8890  1b71 a1ff          	cp	a,#255
8891  1b73 2703          	jreq	L632
8892  1b75 cc1c46        	jp	L7573
8893  1b78               L632:
8895  1b78 b6cb          	ld	a,_mess+7
8896  1b7a a1ff          	cp	a,#255
8897  1b7c 2703          	jreq	L042
8898  1b7e cc1c46        	jp	L7573
8899  1b81               L042:
8901  1b81 b6cc          	ld	a,_mess+8
8902  1b83 a126          	cp	a,#38
8903  1b85 2709          	jreq	L1673
8905  1b87 b6cc          	ld	a,_mess+8
8906  1b89 a129          	cp	a,#41
8907  1b8b 2703          	jreq	L242
8908  1b8d cc1c46        	jp	L7573
8909  1b90               L242:
8910  1b90               L1673:
8911                     ; 1840 	tempSS=mess[9]+(mess[10]*256);
8913  1b90 b6ce          	ld	a,_mess+10
8914  1b92 5f            	clrw	x
8915  1b93 97            	ld	xl,a
8916  1b94 4f            	clr	a
8917  1b95 02            	rlwa	x,a
8918  1b96 01            	rrwa	x,a
8919  1b97 bbcd          	add	a,_mess+9
8920  1b99 2401          	jrnc	L002
8921  1b9b 5c            	incw	x
8922  1b9c               L002:
8923  1b9c 02            	rlwa	x,a
8924  1b9d 1f04          	ldw	(OFST-1,sp),x
8925  1b9f 01            	rrwa	x,a
8926                     ; 1841 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8928  1ba0 ce0010        	ldw	x,_ee_tmax
8929  1ba3 1304          	cpw	x,(OFST-1,sp)
8930  1ba5 270a          	jreq	L3673
8933  1ba7 1e04          	ldw	x,(OFST-1,sp)
8934  1ba9 89            	pushw	x
8935  1baa ae0010        	ldw	x,#_ee_tmax
8936  1bad cd0000        	call	c_eewrw
8938  1bb0 85            	popw	x
8939  1bb1               L3673:
8940                     ; 1842 	tempSS=mess[11]+(mess[12]*256);
8942  1bb1 b6d0          	ld	a,_mess+12
8943  1bb3 5f            	clrw	x
8944  1bb4 97            	ld	xl,a
8945  1bb5 4f            	clr	a
8946  1bb6 02            	rlwa	x,a
8947  1bb7 01            	rrwa	x,a
8948  1bb8 bbcf          	add	a,_mess+11
8949  1bba 2401          	jrnc	L202
8950  1bbc 5c            	incw	x
8951  1bbd               L202:
8952  1bbd 02            	rlwa	x,a
8953  1bbe 1f04          	ldw	(OFST-1,sp),x
8954  1bc0 01            	rrwa	x,a
8955                     ; 1843 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8957  1bc1 ce000e        	ldw	x,_ee_tsign
8958  1bc4 1304          	cpw	x,(OFST-1,sp)
8959  1bc6 270a          	jreq	L5673
8962  1bc8 1e04          	ldw	x,(OFST-1,sp)
8963  1bca 89            	pushw	x
8964  1bcb ae000e        	ldw	x,#_ee_tsign
8965  1bce cd0000        	call	c_eewrw
8967  1bd1 85            	popw	x
8968  1bd2               L5673:
8969                     ; 1846 	if(mess[8]==MEM_KF1)
8971  1bd2 b6cc          	ld	a,_mess+8
8972  1bd4 a126          	cp	a,#38
8973  1bd6 2623          	jrne	L7673
8974                     ; 1848 		if(ee_DEVICE!=0)ee_DEVICE=0;
8976  1bd8 ce0004        	ldw	x,_ee_DEVICE
8977  1bdb 2709          	jreq	L1773
8980  1bdd 5f            	clrw	x
8981  1bde 89            	pushw	x
8982  1bdf ae0004        	ldw	x,#_ee_DEVICE
8983  1be2 cd0000        	call	c_eewrw
8985  1be5 85            	popw	x
8986  1be6               L1773:
8987                     ; 1849 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8989  1be6 b6d1          	ld	a,_mess+13
8990  1be8 5f            	clrw	x
8991  1be9 97            	ld	xl,a
8992  1bea c30016        	cpw	x,_ee_TZAS
8993  1bed 270c          	jreq	L7673
8996  1bef b6d1          	ld	a,_mess+13
8997  1bf1 5f            	clrw	x
8998  1bf2 97            	ld	xl,a
8999  1bf3 89            	pushw	x
9000  1bf4 ae0016        	ldw	x,#_ee_TZAS
9001  1bf7 cd0000        	call	c_eewrw
9003  1bfa 85            	popw	x
9004  1bfb               L7673:
9005                     ; 1851 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
9007  1bfb b6cc          	ld	a,_mess+8
9008  1bfd a129          	cp	a,#41
9009  1bff 2703          	jreq	L442
9010  1c01 cc1e0f        	jp	L7153
9011  1c04               L442:
9012                     ; 1853 		if(ee_DEVICE!=1)ee_DEVICE=1;
9014  1c04 ce0004        	ldw	x,_ee_DEVICE
9015  1c07 a30001        	cpw	x,#1
9016  1c0a 270b          	jreq	L7773
9019  1c0c ae0001        	ldw	x,#1
9020  1c0f 89            	pushw	x
9021  1c10 ae0004        	ldw	x,#_ee_DEVICE
9022  1c13 cd0000        	call	c_eewrw
9024  1c16 85            	popw	x
9025  1c17               L7773:
9026                     ; 1854 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
9028  1c17 b6d1          	ld	a,_mess+13
9029  1c19 5f            	clrw	x
9030  1c1a 97            	ld	xl,a
9031  1c1b c30002        	cpw	x,_ee_IMAXVENT
9032  1c1e 270c          	jreq	L1004
9035  1c20 b6d1          	ld	a,_mess+13
9036  1c22 5f            	clrw	x
9037  1c23 97            	ld	xl,a
9038  1c24 89            	pushw	x
9039  1c25 ae0002        	ldw	x,#_ee_IMAXVENT
9040  1c28 cd0000        	call	c_eewrw
9042  1c2b 85            	popw	x
9043  1c2c               L1004:
9044                     ; 1855 			if(ee_TZAS!=3) ee_TZAS=3;
9046  1c2c ce0016        	ldw	x,_ee_TZAS
9047  1c2f a30003        	cpw	x,#3
9048  1c32 2603          	jrne	L642
9049  1c34 cc1e0f        	jp	L7153
9050  1c37               L642:
9053  1c37 ae0003        	ldw	x,#3
9054  1c3a 89            	pushw	x
9055  1c3b ae0016        	ldw	x,#_ee_TZAS
9056  1c3e cd0000        	call	c_eewrw
9058  1c41 85            	popw	x
9059  1c42 ac0f1e0f      	jpf	L7153
9060  1c46               L7573:
9061                     ; 1859 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
9063  1c46 b6ca          	ld	a,_mess+6
9064  1c48 c10005        	cp	a,_adress
9065  1c4b 262d          	jrne	L7004
9067  1c4d b6cb          	ld	a,_mess+7
9068  1c4f c10005        	cp	a,_adress
9069  1c52 2626          	jrne	L7004
9071  1c54 b6cc          	ld	a,_mess+8
9072  1c56 a116          	cp	a,#22
9073  1c58 2620          	jrne	L7004
9075  1c5a b6cd          	ld	a,_mess+9
9076  1c5c a163          	cp	a,#99
9077  1c5e 261a          	jrne	L7004
9078                     ; 1861 	flags&=0b11100001;
9080  1c60 b60b          	ld	a,_flags
9081  1c62 a4e1          	and	a,#225
9082  1c64 b70b          	ld	_flags,a
9083                     ; 1862 	tsign_cnt=0;
9085  1c66 5f            	clrw	x
9086  1c67 bf4d          	ldw	_tsign_cnt,x
9087                     ; 1863 	tmax_cnt=0;
9089  1c69 5f            	clrw	x
9090  1c6a bf4b          	ldw	_tmax_cnt,x
9091                     ; 1864 	umax_cnt=0;
9093  1c6c 5f            	clrw	x
9094  1c6d bf66          	ldw	_umax_cnt,x
9095                     ; 1865 	umin_cnt=0;
9097  1c6f 5f            	clrw	x
9098  1c70 bf64          	ldw	_umin_cnt,x
9099                     ; 1866 	led_drv_cnt=30;
9101  1c72 351e001c      	mov	_led_drv_cnt,#30
9103  1c76 ac0f1e0f      	jpf	L7153
9104  1c7a               L7004:
9105                     ; 1869 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
9107  1c7a b6ca          	ld	a,_mess+6
9108  1c7c c10005        	cp	a,_adress
9109  1c7f 2620          	jrne	L3104
9111  1c81 b6cb          	ld	a,_mess+7
9112  1c83 c10005        	cp	a,_adress
9113  1c86 2619          	jrne	L3104
9115  1c88 b6cc          	ld	a,_mess+8
9116  1c8a a116          	cp	a,#22
9117  1c8c 2613          	jrne	L3104
9119  1c8e b6cd          	ld	a,_mess+9
9120  1c90 a164          	cp	a,#100
9121  1c92 260d          	jrne	L3104
9122                     ; 1871 	vent_resurs=0;
9124  1c94 5f            	clrw	x
9125  1c95 89            	pushw	x
9126  1c96 ae0000        	ldw	x,#_vent_resurs
9127  1c99 cd0000        	call	c_eewrw
9129  1c9c 85            	popw	x
9131  1c9d ac0f1e0f      	jpf	L7153
9132  1ca1               L3104:
9133                     ; 1875 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
9135  1ca1 b6ca          	ld	a,_mess+6
9136  1ca3 a1ff          	cp	a,#255
9137  1ca5 265f          	jrne	L7104
9139  1ca7 b6cb          	ld	a,_mess+7
9140  1ca9 a1ff          	cp	a,#255
9141  1cab 2659          	jrne	L7104
9143  1cad b6cc          	ld	a,_mess+8
9144  1caf a116          	cp	a,#22
9145  1cb1 2653          	jrne	L7104
9147  1cb3 b6cd          	ld	a,_mess+9
9148  1cb5 a116          	cp	a,#22
9149  1cb7 264d          	jrne	L7104
9150                     ; 1877 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9152  1cb9 b6ce          	ld	a,_mess+10
9153  1cbb a155          	cp	a,#85
9154  1cbd 260f          	jrne	L1204
9156  1cbf b6cf          	ld	a,_mess+11
9157  1cc1 a155          	cp	a,#85
9158  1cc3 2609          	jrne	L1204
9161  1cc5 be5e          	ldw	x,__x_
9162  1cc7 1c0001        	addw	x,#1
9163  1cca bf5e          	ldw	__x_,x
9165  1ccc 2024          	jra	L3204
9166  1cce               L1204:
9167                     ; 1878 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9169  1cce b6ce          	ld	a,_mess+10
9170  1cd0 a166          	cp	a,#102
9171  1cd2 260f          	jrne	L5204
9173  1cd4 b6cf          	ld	a,_mess+11
9174  1cd6 a166          	cp	a,#102
9175  1cd8 2609          	jrne	L5204
9178  1cda be5e          	ldw	x,__x_
9179  1cdc 1d0001        	subw	x,#1
9180  1cdf bf5e          	ldw	__x_,x
9182  1ce1 200f          	jra	L3204
9183  1ce3               L5204:
9184                     ; 1879 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9186  1ce3 b6ce          	ld	a,_mess+10
9187  1ce5 a177          	cp	a,#119
9188  1ce7 2609          	jrne	L3204
9190  1ce9 b6cf          	ld	a,_mess+11
9191  1ceb a177          	cp	a,#119
9192  1ced 2603          	jrne	L3204
9195  1cef 5f            	clrw	x
9196  1cf0 bf5e          	ldw	__x_,x
9197  1cf2               L3204:
9198                     ; 1880      gran(&_x_,-XMAX,XMAX);
9200  1cf2 ae0019        	ldw	x,#25
9201  1cf5 89            	pushw	x
9202  1cf6 aeffe7        	ldw	x,#65511
9203  1cf9 89            	pushw	x
9204  1cfa ae005e        	ldw	x,#__x_
9205  1cfd cd00d1        	call	_gran
9207  1d00 5b04          	addw	sp,#4
9209  1d02 ac0f1e0f      	jpf	L7153
9210  1d06               L7104:
9211                     ; 1882 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9213  1d06 b6ca          	ld	a,_mess+6
9214  1d08 c10005        	cp	a,_adress
9215  1d0b 2665          	jrne	L5304
9217  1d0d b6cb          	ld	a,_mess+7
9218  1d0f c10005        	cp	a,_adress
9219  1d12 265e          	jrne	L5304
9221  1d14 b6cc          	ld	a,_mess+8
9222  1d16 a116          	cp	a,#22
9223  1d18 2658          	jrne	L5304
9225  1d1a b6cd          	ld	a,_mess+9
9226  1d1c b1ce          	cp	a,_mess+10
9227  1d1e 2652          	jrne	L5304
9229  1d20 b6cd          	ld	a,_mess+9
9230  1d22 a1ee          	cp	a,#238
9231  1d24 264c          	jrne	L5304
9232                     ; 1884 	rotor_int++;
9234  1d26 be1d          	ldw	x,_rotor_int
9235  1d28 1c0001        	addw	x,#1
9236  1d2b bf1d          	ldw	_rotor_int,x
9237                     ; 1885      tempI=pwm_u;
9239  1d2d be0e          	ldw	x,_pwm_u
9240  1d2f 1f04          	ldw	(OFST-1,sp),x
9241                     ; 1886 	ee_U_AVT=tempI;
9243  1d31 1e04          	ldw	x,(OFST-1,sp)
9244  1d33 89            	pushw	x
9245  1d34 ae000c        	ldw	x,#_ee_U_AVT
9246  1d37 cd0000        	call	c_eewrw
9248  1d3a 85            	popw	x
9249                     ; 1887 	UU_AVT=Un;
9251  1d3b be6d          	ldw	x,_Un
9252  1d3d 89            	pushw	x
9253  1d3e ae0008        	ldw	x,#_UU_AVT
9254  1d41 cd0000        	call	c_eewrw
9256  1d44 85            	popw	x
9257                     ; 1888 	delay_ms(100);
9259  1d45 ae0064        	ldw	x,#100
9260  1d48 cd011d        	call	_delay_ms
9262                     ; 1889 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9264  1d4b ce000c        	ldw	x,_ee_U_AVT
9265  1d4e 1304          	cpw	x,(OFST-1,sp)
9266  1d50 2703          	jreq	L052
9267  1d52 cc1e0f        	jp	L7153
9268  1d55               L052:
9271  1d55 4b00          	push	#0
9272  1d57 4b00          	push	#0
9273  1d59 4b00          	push	#0
9274  1d5b 4b00          	push	#0
9275  1d5d 4bdd          	push	#221
9276  1d5f 4bdd          	push	#221
9277  1d61 4b91          	push	#145
9278  1d63 3b0005        	push	_adress
9279  1d66 ae018e        	ldw	x,#398
9280  1d69 cd1603        	call	_can_transmit
9282  1d6c 5b08          	addw	sp,#8
9283  1d6e ac0f1e0f      	jpf	L7153
9284  1d72               L5304:
9285                     ; 1894 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9287  1d72 b6cb          	ld	a,_mess+7
9288  1d74 a1da          	cp	a,#218
9289  1d76 2652          	jrne	L3404
9291  1d78 b6ca          	ld	a,_mess+6
9292  1d7a c10005        	cp	a,_adress
9293  1d7d 274b          	jreq	L3404
9295  1d7f b6ca          	ld	a,_mess+6
9296  1d81 a106          	cp	a,#6
9297  1d83 2445          	jruge	L3404
9298                     ; 1896 	i_main_bps_cnt[mess[6]]=0;
9300  1d85 b6ca          	ld	a,_mess+6
9301  1d87 5f            	clrw	x
9302  1d88 97            	ld	xl,a
9303  1d89 6f09          	clr	(_i_main_bps_cnt,x)
9304                     ; 1897 	i_main_flag[mess[6]]=1;
9306  1d8b b6ca          	ld	a,_mess+6
9307  1d8d 5f            	clrw	x
9308  1d8e 97            	ld	xl,a
9309  1d8f a601          	ld	a,#1
9310  1d91 e714          	ld	(_i_main_flag,x),a
9311                     ; 1898 	if(bMAIN)
9313                     	btst	_bMAIN
9314  1d98 2475          	jruge	L7153
9315                     ; 1900 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9317  1d9a b6cd          	ld	a,_mess+9
9318  1d9c 5f            	clrw	x
9319  1d9d 97            	ld	xl,a
9320  1d9e 4f            	clr	a
9321  1d9f 02            	rlwa	x,a
9322  1da0 1f01          	ldw	(OFST-4,sp),x
9323  1da2 b6cc          	ld	a,_mess+8
9324  1da4 5f            	clrw	x
9325  1da5 97            	ld	xl,a
9326  1da6 72fb01        	addw	x,(OFST-4,sp)
9327  1da9 b6ca          	ld	a,_mess+6
9328  1dab 905f          	clrw	y
9329  1dad 9097          	ld	yl,a
9330  1daf 9058          	sllw	y
9331  1db1 90ef1a        	ldw	(_i_main,y),x
9332                     ; 1901 		i_main[adress]=I;
9334  1db4 c60005        	ld	a,_adress
9335  1db7 5f            	clrw	x
9336  1db8 97            	ld	xl,a
9337  1db9 58            	sllw	x
9338  1dba 90be6f        	ldw	y,_I
9339  1dbd ef1a          	ldw	(_i_main,x),y
9340                     ; 1902      	i_main_flag[adress]=1;
9342  1dbf c60005        	ld	a,_adress
9343  1dc2 5f            	clrw	x
9344  1dc3 97            	ld	xl,a
9345  1dc4 a601          	ld	a,#1
9346  1dc6 e714          	ld	(_i_main_flag,x),a
9347  1dc8 2045          	jra	L7153
9348  1dca               L3404:
9349                     ; 1906 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9351  1dca b6cb          	ld	a,_mess+7
9352  1dcc a1db          	cp	a,#219
9353  1dce 263f          	jrne	L7153
9355  1dd0 b6ca          	ld	a,_mess+6
9356  1dd2 c10005        	cp	a,_adress
9357  1dd5 2738          	jreq	L7153
9359  1dd7 b6ca          	ld	a,_mess+6
9360  1dd9 a106          	cp	a,#6
9361  1ddb 2432          	jruge	L7153
9362                     ; 1908 	i_main_bps_cnt[mess[6]]=0;
9364  1ddd b6ca          	ld	a,_mess+6
9365  1ddf 5f            	clrw	x
9366  1de0 97            	ld	xl,a
9367  1de1 6f09          	clr	(_i_main_bps_cnt,x)
9368                     ; 1909 	i_main_flag[mess[6]]=1;		
9370  1de3 b6ca          	ld	a,_mess+6
9371  1de5 5f            	clrw	x
9372  1de6 97            	ld	xl,a
9373  1de7 a601          	ld	a,#1
9374  1de9 e714          	ld	(_i_main_flag,x),a
9375                     ; 1910 	if(bMAIN)
9377                     	btst	_bMAIN
9378  1df0 241d          	jruge	L7153
9379                     ; 1912 		if(mess[9]==0)i_main_flag[i]=1;
9381  1df2 3dcd          	tnz	_mess+9
9382  1df4 260a          	jrne	L5504
9385  1df6 7b03          	ld	a,(OFST-2,sp)
9386  1df8 5f            	clrw	x
9387  1df9 97            	ld	xl,a
9388  1dfa a601          	ld	a,#1
9389  1dfc e714          	ld	(_i_main_flag,x),a
9391  1dfe 2006          	jra	L7504
9392  1e00               L5504:
9393                     ; 1913 		else i_main_flag[i]=0;
9395  1e00 7b03          	ld	a,(OFST-2,sp)
9396  1e02 5f            	clrw	x
9397  1e03 97            	ld	xl,a
9398  1e04 6f14          	clr	(_i_main_flag,x)
9399  1e06               L7504:
9400                     ; 1914 		i_main_flag[adress]=1;
9402  1e06 c60005        	ld	a,_adress
9403  1e09 5f            	clrw	x
9404  1e0a 97            	ld	xl,a
9405  1e0b a601          	ld	a,#1
9406  1e0d e714          	ld	(_i_main_flag,x),a
9407  1e0f               L7153:
9408                     ; 1920 can_in_an_end:
9408                     ; 1921 bCAN_RX=0;
9410  1e0f 3f0a          	clr	_bCAN_RX
9411                     ; 1922 }   
9414  1e11 5b05          	addw	sp,#5
9415  1e13 81            	ret
9438                     ; 1925 void t4_init(void){
9439                     	switch	.text
9440  1e14               _t4_init:
9444                     ; 1926 	TIM4->PSCR = 4;
9446  1e14 35045345      	mov	21317,#4
9447                     ; 1927 	TIM4->ARR= 61;
9449  1e18 353d5346      	mov	21318,#61
9450                     ; 1928 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9452  1e1c 72105341      	bset	21313,#0
9453                     ; 1930 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9455  1e20 35855340      	mov	21312,#133
9456                     ; 1932 }
9459  1e24 81            	ret
9482                     ; 1935 void t1_init(void)
9482                     ; 1936 {
9483                     	switch	.text
9484  1e25               _t1_init:
9488                     ; 1937 TIM1->ARRH= 0x03;
9490  1e25 35035262      	mov	21090,#3
9491                     ; 1938 TIM1->ARRL= 0xff;
9493  1e29 35ff5263      	mov	21091,#255
9494                     ; 1939 TIM1->CCR1H= 0x00;	
9496  1e2d 725f5265      	clr	21093
9497                     ; 1940 TIM1->CCR1L= 0xff;
9499  1e31 35ff5266      	mov	21094,#255
9500                     ; 1941 TIM1->CCR2H= 0x00;	
9502  1e35 725f5267      	clr	21095
9503                     ; 1942 TIM1->CCR2L= 0x00;
9505  1e39 725f5268      	clr	21096
9506                     ; 1943 TIM1->CCR3H= 0x00;	
9508  1e3d 725f5269      	clr	21097
9509                     ; 1944 TIM1->CCR3L= 0x64;
9511  1e41 3564526a      	mov	21098,#100
9512                     ; 1946 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9514  1e45 35685258      	mov	21080,#104
9515                     ; 1947 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9517  1e49 35685259      	mov	21081,#104
9518                     ; 1948 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9520  1e4d 3568525a      	mov	21082,#104
9521                     ; 1949 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9523  1e51 3511525c      	mov	21084,#17
9524                     ; 1950 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9526  1e55 3501525d      	mov	21085,#1
9527                     ; 1951 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9529  1e59 35815250      	mov	21072,#129
9530                     ; 1952 TIM1->BKR|= TIM1_BKR_AOE;
9532  1e5d 721c526d      	bset	21101,#6
9533                     ; 1953 }
9536  1e61 81            	ret
9561                     ; 1957 void adc2_init(void)
9561                     ; 1958 {
9562                     	switch	.text
9563  1e62               _adc2_init:
9567                     ; 1959 adc_plazma[0]++;
9569  1e62 beb6          	ldw	x,_adc_plazma
9570  1e64 1c0001        	addw	x,#1
9571  1e67 bfb6          	ldw	_adc_plazma,x
9572                     ; 1983 GPIOB->DDR&=~(1<<4);
9574  1e69 72195007      	bres	20487,#4
9575                     ; 1984 GPIOB->CR1&=~(1<<4);
9577  1e6d 72195008      	bres	20488,#4
9578                     ; 1985 GPIOB->CR2&=~(1<<4);
9580  1e71 72195009      	bres	20489,#4
9581                     ; 1987 GPIOB->DDR&=~(1<<5);
9583  1e75 721b5007      	bres	20487,#5
9584                     ; 1988 GPIOB->CR1&=~(1<<5);
9586  1e79 721b5008      	bres	20488,#5
9587                     ; 1989 GPIOB->CR2&=~(1<<5);
9589  1e7d 721b5009      	bres	20489,#5
9590                     ; 1991 GPIOB->DDR&=~(1<<6);
9592  1e81 721d5007      	bres	20487,#6
9593                     ; 1992 GPIOB->CR1&=~(1<<6);
9595  1e85 721d5008      	bres	20488,#6
9596                     ; 1993 GPIOB->CR2&=~(1<<6);
9598  1e89 721d5009      	bres	20489,#6
9599                     ; 1995 GPIOB->DDR&=~(1<<7);
9601  1e8d 721f5007      	bres	20487,#7
9602                     ; 1996 GPIOB->CR1&=~(1<<7);
9604  1e91 721f5008      	bres	20488,#7
9605                     ; 1997 GPIOB->CR2&=~(1<<7);
9607  1e95 721f5009      	bres	20489,#7
9608                     ; 2007 ADC2->TDRL=0xff;
9610  1e99 35ff5407      	mov	21511,#255
9611                     ; 2009 ADC2->CR2=0x08;
9613  1e9d 35085402      	mov	21506,#8
9614                     ; 2010 ADC2->CR1=0x40;
9616  1ea1 35405401      	mov	21505,#64
9617                     ; 2013 	ADC2->CSR=0x20+adc_ch+3;
9619  1ea5 b6c3          	ld	a,_adc_ch
9620  1ea7 ab23          	add	a,#35
9621  1ea9 c75400        	ld	21504,a
9622                     ; 2015 	ADC2->CR1|=1;
9624  1eac 72105401      	bset	21505,#0
9625                     ; 2016 	ADC2->CR1|=1;
9627  1eb0 72105401      	bset	21505,#0
9628                     ; 2019 adc_plazma[1]=adc_ch;
9630  1eb4 b6c3          	ld	a,_adc_ch
9631  1eb6 5f            	clrw	x
9632  1eb7 97            	ld	xl,a
9633  1eb8 bfb8          	ldw	_adc_plazma+2,x
9634                     ; 2020 }
9637  1eba 81            	ret
9671                     ; 2029 @far @interrupt void TIM4_UPD_Interrupt (void) 
9671                     ; 2030 {
9673                     	switch	.text
9674  1ebb               f_TIM4_UPD_Interrupt:
9678                     ; 2031 TIM4->SR1&=~TIM4_SR1_UIF;
9680  1ebb 72115342      	bres	21314,#0
9681                     ; 2033 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9683  1ebf 3c08          	inc	_pwm_vent_cnt
9684  1ec1 b608          	ld	a,_pwm_vent_cnt
9685  1ec3 a10a          	cp	a,#10
9686  1ec5 2502          	jrult	L1214
9689  1ec7 3f08          	clr	_pwm_vent_cnt
9690  1ec9               L1214:
9691                     ; 2034 GPIOB->ODR|=(1<<3);
9693  1ec9 72165005      	bset	20485,#3
9694                     ; 2035 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9696  1ecd b608          	ld	a,_pwm_vent_cnt
9697  1ecf a105          	cp	a,#5
9698  1ed1 2504          	jrult	L3214
9701  1ed3 72175005      	bres	20485,#3
9702  1ed7               L3214:
9703                     ; 2040 if(++t0_cnt0>=100)
9705  1ed7 9c            	rvf
9706  1ed8 be01          	ldw	x,_t0_cnt0
9707  1eda 1c0001        	addw	x,#1
9708  1edd bf01          	ldw	_t0_cnt0,x
9709  1edf a30064        	cpw	x,#100
9710  1ee2 2f3f          	jrslt	L5214
9711                     ; 2042 	t0_cnt0=0;
9713  1ee4 5f            	clrw	x
9714  1ee5 bf01          	ldw	_t0_cnt0,x
9715                     ; 2043 	b100Hz=1;
9717  1ee7 72100008      	bset	_b100Hz
9718                     ; 2045 	if(++t0_cnt1>=10)
9720  1eeb 3c03          	inc	_t0_cnt1
9721  1eed b603          	ld	a,_t0_cnt1
9722  1eef a10a          	cp	a,#10
9723  1ef1 2506          	jrult	L7214
9724                     ; 2047 		t0_cnt1=0;
9726  1ef3 3f03          	clr	_t0_cnt1
9727                     ; 2048 		b10Hz=1;
9729  1ef5 72100007      	bset	_b10Hz
9730  1ef9               L7214:
9731                     ; 2051 	if(++t0_cnt2>=20)
9733  1ef9 3c04          	inc	_t0_cnt2
9734  1efb b604          	ld	a,_t0_cnt2
9735  1efd a114          	cp	a,#20
9736  1eff 2506          	jrult	L1314
9737                     ; 2053 		t0_cnt2=0;
9739  1f01 3f04          	clr	_t0_cnt2
9740                     ; 2054 		b5Hz=1;
9742  1f03 72100006      	bset	_b5Hz
9743  1f07               L1314:
9744                     ; 2058 	if(++t0_cnt4>=50)
9746  1f07 3c06          	inc	_t0_cnt4
9747  1f09 b606          	ld	a,_t0_cnt4
9748  1f0b a132          	cp	a,#50
9749  1f0d 2506          	jrult	L3314
9750                     ; 2060 		t0_cnt4=0;
9752  1f0f 3f06          	clr	_t0_cnt4
9753                     ; 2061 		b2Hz=1;
9755  1f11 72100005      	bset	_b2Hz
9756  1f15               L3314:
9757                     ; 2064 	if(++t0_cnt3>=100)
9759  1f15 3c05          	inc	_t0_cnt3
9760  1f17 b605          	ld	a,_t0_cnt3
9761  1f19 a164          	cp	a,#100
9762  1f1b 2506          	jrult	L5214
9763                     ; 2066 		t0_cnt3=0;
9765  1f1d 3f05          	clr	_t0_cnt3
9766                     ; 2067 		b1Hz=1;
9768  1f1f 72100004      	bset	_b1Hz
9769  1f23               L5214:
9770                     ; 2073 }
9773  1f23 80            	iret
9798                     ; 2076 @far @interrupt void CAN_RX_Interrupt (void) 
9798                     ; 2077 {
9799                     	switch	.text
9800  1f24               f_CAN_RX_Interrupt:
9804                     ; 2079 CAN->PSR= 7;									// page 7 - read messsage
9806  1f24 35075427      	mov	21543,#7
9807                     ; 2081 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9809  1f28 ae000e        	ldw	x,#14
9810  1f2b               L462:
9811  1f2b d65427        	ld	a,(21543,x)
9812  1f2e e7c3          	ld	(_mess-1,x),a
9813  1f30 5a            	decw	x
9814  1f31 26f8          	jrne	L462
9815                     ; 2092 bCAN_RX=1;
9817  1f33 3501000a      	mov	_bCAN_RX,#1
9818                     ; 2093 CAN->RFR|=(1<<5);
9820  1f37 721a5424      	bset	21540,#5
9821                     ; 2095 }
9824  1f3b 80            	iret
9847                     ; 2098 @far @interrupt void CAN_TX_Interrupt (void) 
9847                     ; 2099 {
9848                     	switch	.text
9849  1f3c               f_CAN_TX_Interrupt:
9853                     ; 2100 if((CAN->TSR)&(1<<0))
9855  1f3c c65422        	ld	a,21538
9856  1f3f a501          	bcp	a,#1
9857  1f41 2708          	jreq	L7514
9858                     ; 2102 	bTX_FREE=1;	
9860  1f43 35010009      	mov	_bTX_FREE,#1
9861                     ; 2104 	CAN->TSR|=(1<<0);
9863  1f47 72105422      	bset	21538,#0
9864  1f4b               L7514:
9865                     ; 2106 }
9868  1f4b 80            	iret
9926                     ; 2109 @far @interrupt void ADC2_EOC_Interrupt (void) {
9927                     	switch	.text
9928  1f4c               f_ADC2_EOC_Interrupt:
9930       00000009      OFST:	set	9
9931  1f4c be00          	ldw	x,c_x
9932  1f4e 89            	pushw	x
9933  1f4f be00          	ldw	x,c_y
9934  1f51 89            	pushw	x
9935  1f52 be02          	ldw	x,c_lreg+2
9936  1f54 89            	pushw	x
9937  1f55 be00          	ldw	x,c_lreg
9938  1f57 89            	pushw	x
9939  1f58 5209          	subw	sp,#9
9942                     ; 2114 adc_plazma[2]++;
9944  1f5a beba          	ldw	x,_adc_plazma+4
9945  1f5c 1c0001        	addw	x,#1
9946  1f5f bfba          	ldw	_adc_plazma+4,x
9947                     ; 2121 ADC2->CSR&=~(1<<7);
9949  1f61 721f5400      	bres	21504,#7
9950                     ; 2123 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9952  1f65 c65405        	ld	a,21509
9953  1f68 b703          	ld	c_lreg+3,a
9954  1f6a 3f02          	clr	c_lreg+2
9955  1f6c 3f01          	clr	c_lreg+1
9956  1f6e 3f00          	clr	c_lreg
9957  1f70 96            	ldw	x,sp
9958  1f71 1c0001        	addw	x,#OFST-8
9959  1f74 cd0000        	call	c_rtol
9961  1f77 c65404        	ld	a,21508
9962  1f7a 5f            	clrw	x
9963  1f7b 97            	ld	xl,a
9964  1f7c 90ae0100      	ldw	y,#256
9965  1f80 cd0000        	call	c_umul
9967  1f83 96            	ldw	x,sp
9968  1f84 1c0001        	addw	x,#OFST-8
9969  1f87 cd0000        	call	c_ladd
9971  1f8a 96            	ldw	x,sp
9972  1f8b 1c0006        	addw	x,#OFST-3
9973  1f8e cd0000        	call	c_rtol
9975                     ; 2128 if(adr_drv_stat==1)
9977  1f91 b608          	ld	a,_adr_drv_stat
9978  1f93 a101          	cp	a,#1
9979  1f95 260b          	jrne	L7024
9980                     ; 2130 	adr_drv_stat=2;
9982  1f97 35020008      	mov	_adr_drv_stat,#2
9983                     ; 2131 	adc_buff_[0]=temp_adc;
9985  1f9b 1e08          	ldw	x,(OFST-1,sp)
9986  1f9d cf0009        	ldw	_adc_buff_,x
9988  1fa0 2020          	jra	L1124
9989  1fa2               L7024:
9990                     ; 2134 else if(adr_drv_stat==3)
9992  1fa2 b608          	ld	a,_adr_drv_stat
9993  1fa4 a103          	cp	a,#3
9994  1fa6 260b          	jrne	L3124
9995                     ; 2136 	adr_drv_stat=4;
9997  1fa8 35040008      	mov	_adr_drv_stat,#4
9998                     ; 2137 	adc_buff_[1]=temp_adc;
10000  1fac 1e08          	ldw	x,(OFST-1,sp)
10001  1fae cf000b        	ldw	_adc_buff_+2,x
10003  1fb1 200f          	jra	L1124
10004  1fb3               L3124:
10005                     ; 2140 else if(adr_drv_stat==5)
10007  1fb3 b608          	ld	a,_adr_drv_stat
10008  1fb5 a105          	cp	a,#5
10009  1fb7 2609          	jrne	L1124
10010                     ; 2142 	adr_drv_stat=6;
10012  1fb9 35060008      	mov	_adr_drv_stat,#6
10013                     ; 2143 	adc_buff_[9]=temp_adc;
10015  1fbd 1e08          	ldw	x,(OFST-1,sp)
10016  1fbf cf001b        	ldw	_adc_buff_+18,x
10017  1fc2               L1124:
10018                     ; 2146 adc_buff[adc_ch][adc_cnt]=temp_adc;
10020  1fc2 b6c2          	ld	a,_adc_cnt
10021  1fc4 5f            	clrw	x
10022  1fc5 97            	ld	xl,a
10023  1fc6 58            	sllw	x
10024  1fc7 1f03          	ldw	(OFST-6,sp),x
10025  1fc9 b6c3          	ld	a,_adc_ch
10026  1fcb 97            	ld	xl,a
10027  1fcc a620          	ld	a,#32
10028  1fce 42            	mul	x,a
10029  1fcf 72fb03        	addw	x,(OFST-6,sp)
10030  1fd2 1608          	ldw	y,(OFST-1,sp)
10031  1fd4 df001d        	ldw	(_adc_buff,x),y
10032                     ; 2152 adc_ch++;
10034  1fd7 3cc3          	inc	_adc_ch
10035                     ; 2153 if(adc_ch>=5)
10037  1fd9 b6c3          	ld	a,_adc_ch
10038  1fdb a105          	cp	a,#5
10039  1fdd 250c          	jrult	L1224
10040                     ; 2156 	adc_ch=0;
10042  1fdf 3fc3          	clr	_adc_ch
10043                     ; 2157 	adc_cnt++;
10045  1fe1 3cc2          	inc	_adc_cnt
10046                     ; 2158 	if(adc_cnt>=16)
10048  1fe3 b6c2          	ld	a,_adc_cnt
10049  1fe5 a110          	cp	a,#16
10050  1fe7 2502          	jrult	L1224
10051                     ; 2160 		adc_cnt=0;
10053  1fe9 3fc2          	clr	_adc_cnt
10054  1feb               L1224:
10055                     ; 2164 if((adc_cnt&0x03)==0)
10057  1feb b6c2          	ld	a,_adc_cnt
10058  1fed a503          	bcp	a,#3
10059  1fef 264b          	jrne	L5224
10060                     ; 2168 	tempSS=0;
10062  1ff1 ae0000        	ldw	x,#0
10063  1ff4 1f08          	ldw	(OFST-1,sp),x
10064  1ff6 ae0000        	ldw	x,#0
10065  1ff9 1f06          	ldw	(OFST-3,sp),x
10066                     ; 2169 	for(i=0;i<16;i++)
10068  1ffb 0f05          	clr	(OFST-4,sp)
10069  1ffd               L7224:
10070                     ; 2171 		tempSS+=(signed long)adc_buff[adc_ch][i];
10072  1ffd 7b05          	ld	a,(OFST-4,sp)
10073  1fff 5f            	clrw	x
10074  2000 97            	ld	xl,a
10075  2001 58            	sllw	x
10076  2002 1f03          	ldw	(OFST-6,sp),x
10077  2004 b6c3          	ld	a,_adc_ch
10078  2006 97            	ld	xl,a
10079  2007 a620          	ld	a,#32
10080  2009 42            	mul	x,a
10081  200a 72fb03        	addw	x,(OFST-6,sp)
10082  200d de001d        	ldw	x,(_adc_buff,x)
10083  2010 cd0000        	call	c_itolx
10085  2013 96            	ldw	x,sp
10086  2014 1c0006        	addw	x,#OFST-3
10087  2017 cd0000        	call	c_lgadd
10089                     ; 2169 	for(i=0;i<16;i++)
10091  201a 0c05          	inc	(OFST-4,sp)
10094  201c 7b05          	ld	a,(OFST-4,sp)
10095  201e a110          	cp	a,#16
10096  2020 25db          	jrult	L7224
10097                     ; 2173 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
10099  2022 96            	ldw	x,sp
10100  2023 1c0006        	addw	x,#OFST-3
10101  2026 cd0000        	call	c_ltor
10103  2029 a604          	ld	a,#4
10104  202b cd0000        	call	c_lrsh
10106  202e be02          	ldw	x,c_lreg+2
10107  2030 b6c3          	ld	a,_adc_ch
10108  2032 905f          	clrw	y
10109  2034 9097          	ld	yl,a
10110  2036 9058          	sllw	y
10111  2038 90df0009      	ldw	(_adc_buff_,y),x
10112  203c               L5224:
10113                     ; 2184 adc_plazma_short++;
10115  203c bec0          	ldw	x,_adc_plazma_short
10116  203e 1c0001        	addw	x,#1
10117  2041 bfc0          	ldw	_adc_plazma_short,x
10118                     ; 2199 }
10121  2043 5b09          	addw	sp,#9
10122  2045 85            	popw	x
10123  2046 bf00          	ldw	c_lreg,x
10124  2048 85            	popw	x
10125  2049 bf02          	ldw	c_lreg+2,x
10126  204b 85            	popw	x
10127  204c bf00          	ldw	c_y,x
10128  204e 85            	popw	x
10129  204f bf00          	ldw	c_x,x
10130  2051 80            	iret
10194                     ; 2207 main()
10194                     ; 2208 {
10196                     	switch	.text
10197  2052               _main:
10201                     ; 2210 CLK->ECKR|=1;
10203  2052 721050c1      	bset	20673,#0
10205  2056               L7424:
10206                     ; 2211 while((CLK->ECKR & 2) == 0);
10208  2056 c650c1        	ld	a,20673
10209  2059 a502          	bcp	a,#2
10210  205b 27f9          	jreq	L7424
10211                     ; 2212 CLK->SWCR|=2;
10213  205d 721250c5      	bset	20677,#1
10214                     ; 2213 CLK->SWR=0xB4;
10216  2061 35b450c4      	mov	20676,#180
10217                     ; 2215 delay_ms(200);
10219  2065 ae00c8        	ldw	x,#200
10220  2068 cd011d        	call	_delay_ms
10222                     ; 2216 FLASH_DUKR=0xae;
10224  206b 35ae5064      	mov	_FLASH_DUKR,#174
10225                     ; 2217 FLASH_DUKR=0x56;
10227  206f 35565064      	mov	_FLASH_DUKR,#86
10228                     ; 2218 enableInterrupts();
10231  2073 9a            rim
10233                     ; 2221 adr_drv_v3();
10236  2074 cd1251        	call	_adr_drv_v3
10238                     ; 2225 t4_init();
10240  2077 cd1e14        	call	_t4_init
10242                     ; 2227 		GPIOG->DDR|=(1<<0);
10244  207a 72105020      	bset	20512,#0
10245                     ; 2228 		GPIOG->CR1|=(1<<0);
10247  207e 72105021      	bset	20513,#0
10248                     ; 2229 		GPIOG->CR2&=~(1<<0);	
10250  2082 72115022      	bres	20514,#0
10251                     ; 2232 		GPIOG->DDR&=~(1<<1);
10253  2086 72135020      	bres	20512,#1
10254                     ; 2233 		GPIOG->CR1|=(1<<1);
10256  208a 72125021      	bset	20513,#1
10257                     ; 2234 		GPIOG->CR2&=~(1<<1);
10259  208e 72135022      	bres	20514,#1
10260                     ; 2236 init_CAN();
10262  2092 cd1594        	call	_init_CAN
10264                     ; 2241 GPIOC->DDR|=(1<<1);
10266  2095 7212500c      	bset	20492,#1
10267                     ; 2242 GPIOC->CR1|=(1<<1);
10269  2099 7212500d      	bset	20493,#1
10270                     ; 2243 GPIOC->CR2|=(1<<1);
10272  209d 7212500e      	bset	20494,#1
10273                     ; 2245 GPIOC->DDR|=(1<<2);
10275  20a1 7214500c      	bset	20492,#2
10276                     ; 2246 GPIOC->CR1|=(1<<2);
10278  20a5 7214500d      	bset	20493,#2
10279                     ; 2247 GPIOC->CR2|=(1<<2);
10281  20a9 7214500e      	bset	20494,#2
10282                     ; 2254 t1_init();
10284  20ad cd1e25        	call	_t1_init
10286                     ; 2256 GPIOA->DDR|=(1<<5);
10288  20b0 721a5002      	bset	20482,#5
10289                     ; 2257 GPIOA->CR1|=(1<<5);
10291  20b4 721a5003      	bset	20483,#5
10292                     ; 2258 GPIOA->CR2&=~(1<<5);
10294  20b8 721b5004      	bres	20484,#5
10295                     ; 2264 GPIOB->DDR&=~(1<<3);
10297  20bc 72175007      	bres	20487,#3
10298                     ; 2265 GPIOB->CR1&=~(1<<3);
10300  20c0 72175008      	bres	20488,#3
10301                     ; 2266 GPIOB->CR2&=~(1<<3);
10303  20c4 72175009      	bres	20489,#3
10304                     ; 2268 GPIOC->DDR|=(1<<3);
10306  20c8 7216500c      	bset	20492,#3
10307                     ; 2269 GPIOC->CR1|=(1<<3);
10309  20cc 7216500d      	bset	20493,#3
10310                     ; 2270 GPIOC->CR2|=(1<<3);
10312  20d0 7216500e      	bset	20494,#3
10313                     ; 2273 if(bps_class==bpsIPS) 
10315  20d4 b604          	ld	a,_bps_class
10316  20d6 a101          	cp	a,#1
10317  20d8 260a          	jrne	L5524
10318                     ; 2275 	pwm_u=ee_U_AVT;
10320  20da ce000c        	ldw	x,_ee_U_AVT
10321  20dd bf0e          	ldw	_pwm_u,x
10322                     ; 2276 	volum_u_main_=ee_U_AVT;
10324  20df ce000c        	ldw	x,_ee_U_AVT
10325  20e2 bf1f          	ldw	_volum_u_main_,x
10326  20e4               L5524:
10327                     ; 2283 	if(bCAN_RX)
10329  20e4 3d0a          	tnz	_bCAN_RX
10330  20e6 2705          	jreq	L1624
10331                     ; 2285 		bCAN_RX=0;
10333  20e8 3f0a          	clr	_bCAN_RX
10334                     ; 2286 		can_in_an();	
10336  20ea cd179f        	call	_can_in_an
10338  20ed               L1624:
10339                     ; 2288 	if(b100Hz)
10341                     	btst	_b100Hz
10342  20f2 240a          	jruge	L3624
10343                     ; 2290 		b100Hz=0;
10345  20f4 72110008      	bres	_b100Hz
10346                     ; 2299 		adc2_init();
10348  20f8 cd1e62        	call	_adc2_init
10350                     ; 2300 		can_tx_hndl();
10352  20fb cd1687        	call	_can_tx_hndl
10354  20fe               L3624:
10355                     ; 2303 	if(b10Hz)
10357                     	btst	_b10Hz
10358  2103 2419          	jruge	L5624
10359                     ; 2305 		b10Hz=0;
10361  2105 72110007      	bres	_b10Hz
10362                     ; 2307 		matemat();
10364  2109 cd0db8        	call	_matemat
10366                     ; 2308 		led_drv(); 
10368  210c cd07e2        	call	_led_drv
10370                     ; 2309 	  link_drv();
10372  210f cd08d0        	call	_link_drv
10374                     ; 2310 	  pwr_hndl();		//вычисление воздействий на силу
10376  2112 cd0bbb        	call	_pwr_hndl
10378                     ; 2311 	  JP_drv();
10380  2115 cd0845        	call	_JP_drv
10382                     ; 2312 	  flags_drv();
10384  2118 cd1206        	call	_flags_drv
10386                     ; 2313 		net_drv();
10388  211b cd16f1        	call	_net_drv
10390  211e               L5624:
10391                     ; 2316 	if(b5Hz)
10393                     	btst	_b5Hz
10394  2123 240d          	jruge	L7624
10395                     ; 2318 		b5Hz=0;
10397  2125 72110006      	bres	_b5Hz
10398                     ; 2320 		pwr_drv();		//воздействие на силу
10400  2129 cd0a8b        	call	_pwr_drv
10402                     ; 2321 		led_hndl();
10404  212c cd015f        	call	_led_hndl
10406                     ; 2323 		vent_drv();
10408  212f cd0928        	call	_vent_drv
10410  2132               L7624:
10411                     ; 2326 	if(b2Hz)
10413                     	btst	_b2Hz
10414  2137 2404          	jruge	L1724
10415                     ; 2328 		b2Hz=0;
10417  2139 72110005      	bres	_b2Hz
10418  213d               L1724:
10419                     ; 2337 	if(b1Hz)
10421                     	btst	_b1Hz
10422  2142 24a0          	jruge	L5524
10423                     ; 2339 		b1Hz=0;
10425  2144 72110004      	bres	_b1Hz
10426                     ; 2341 		temper_drv();			//вычисление аварий температуры
10428  2148 cd0f36        	call	_temper_drv
10430                     ; 2342 		u_drv();
10432  214b cd100d        	call	_u_drv
10434                     ; 2343           x_drv();
10436  214e cd10ed        	call	_x_drv
10438                     ; 2344           if(main_cnt<1000)main_cnt++;
10440  2151 9c            	rvf
10441  2152 be51          	ldw	x,_main_cnt
10442  2154 a303e8        	cpw	x,#1000
10443  2157 2e07          	jrsge	L5724
10446  2159 be51          	ldw	x,_main_cnt
10447  215b 1c0001        	addw	x,#1
10448  215e bf51          	ldw	_main_cnt,x
10449  2160               L5724:
10450                     ; 2345   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10452  2160 b663          	ld	a,_link
10453  2162 a1aa          	cp	a,#170
10454  2164 2706          	jreq	L1034
10456  2166 b64a          	ld	a,_jp_mode
10457  2168 a103          	cp	a,#3
10458  216a 2603          	jrne	L7724
10459  216c               L1034:
10462  216c cd1167        	call	_apv_hndl
10464  216f               L7724:
10465                     ; 2348   		can_error_cnt++;
10467  216f 3c71          	inc	_can_error_cnt
10468                     ; 2349   		if(can_error_cnt>=10)
10470  2171 b671          	ld	a,_can_error_cnt
10471  2173 a10a          	cp	a,#10
10472  2175 2505          	jrult	L3034
10473                     ; 2351   			can_error_cnt=0;
10475  2177 3f71          	clr	_can_error_cnt
10476                     ; 2352 			init_CAN();
10478  2179 cd1594        	call	_init_CAN
10480  217c               L3034:
10481                     ; 2356 		volum_u_main_drv();
10483  217c cd1441        	call	_volum_u_main_drv
10485                     ; 2358 		pwm_stat++;
10487  217f 3c07          	inc	_pwm_stat
10488                     ; 2359 		if(pwm_stat>=10)pwm_stat=0;
10490  2181 b607          	ld	a,_pwm_stat
10491  2183 a10a          	cp	a,#10
10492  2185 2502          	jrult	L5034
10495  2187 3f07          	clr	_pwm_stat
10496  2189               L5034:
10497                     ; 2360 adc_plazma_short++;
10499  2189 bec0          	ldw	x,_adc_plazma_short
10500  218b 1c0001        	addw	x,#1
10501  218e bfc0          	ldw	_adc_plazma_short,x
10502                     ; 2362 		vent_resurs_hndl();
10504  2190 cd0000        	call	_vent_resurs_hndl
10506  2193 ace420e4      	jpf	L5524
11576                     	xdef	_main
11577                     	xdef	f_ADC2_EOC_Interrupt
11578                     	xdef	f_CAN_TX_Interrupt
11579                     	xdef	f_CAN_RX_Interrupt
11580                     	xdef	f_TIM4_UPD_Interrupt
11581                     	xdef	_adc2_init
11582                     	xdef	_t1_init
11583                     	xdef	_t4_init
11584                     	xdef	_can_in_an
11585                     	xdef	_net_drv
11586                     	xdef	_can_tx_hndl
11587                     	xdef	_can_transmit
11588                     	xdef	_init_CAN
11589                     	xdef	_volum_u_main_drv
11590                     	xdef	_adr_drv_v3
11591                     	xdef	_adr_drv_v4
11592                     	xdef	_flags_drv
11593                     	xdef	_apv_hndl
11594                     	xdef	_apv_stop
11595                     	xdef	_apv_start
11596                     	xdef	_x_drv
11597                     	xdef	_u_drv
11598                     	xdef	_temper_drv
11599                     	xdef	_matemat
11600                     	xdef	_pwr_hndl
11601                     	xdef	_pwr_drv
11602                     	xdef	_vent_drv
11603                     	xdef	_link_drv
11604                     	xdef	_JP_drv
11605                     	xdef	_led_drv
11606                     	xdef	_led_hndl
11607                     	xdef	_delay_ms
11608                     	xdef	_granee
11609                     	xdef	_gran
11610                     	xdef	_vent_resurs_hndl
11611                     	switch	.ubsct
11612  0001               _vent_resurs_tx_cnt:
11613  0001 00            	ds.b	1
11614                     	xdef	_vent_resurs_tx_cnt
11615                     	switch	.bss
11616  0000               _vent_resurs_buff:
11617  0000 00000000      	ds.b	4
11618                     	xdef	_vent_resurs_buff
11619                     	switch	.ubsct
11620  0002               _vent_resurs_sec_cnt:
11621  0002 0000          	ds.b	2
11622                     	xdef	_vent_resurs_sec_cnt
11623                     .eeprom:	section	.data
11624  0000               _vent_resurs:
11625  0000 0000          	ds.b	2
11626                     	xdef	_vent_resurs
11627  0002               _ee_IMAXVENT:
11628  0002 0000          	ds.b	2
11629                     	xdef	_ee_IMAXVENT
11630                     	switch	.ubsct
11631  0004               _bps_class:
11632  0004 00            	ds.b	1
11633                     	xdef	_bps_class
11634  0005               _vent_pwm:
11635  0005 0000          	ds.b	2
11636                     	xdef	_vent_pwm
11637  0007               _pwm_stat:
11638  0007 00            	ds.b	1
11639                     	xdef	_pwm_stat
11640  0008               _pwm_vent_cnt:
11641  0008 00            	ds.b	1
11642                     	xdef	_pwm_vent_cnt
11643                     	switch	.eeprom
11644  0004               _ee_DEVICE:
11645  0004 0000          	ds.b	2
11646                     	xdef	_ee_DEVICE
11647  0006               _ee_AVT_MODE:
11648  0006 0000          	ds.b	2
11649                     	xdef	_ee_AVT_MODE
11650                     	switch	.ubsct
11651  0009               _i_main_bps_cnt:
11652  0009 000000000000  	ds.b	6
11653                     	xdef	_i_main_bps_cnt
11654  000f               _i_main_sigma:
11655  000f 0000          	ds.b	2
11656                     	xdef	_i_main_sigma
11657  0011               _i_main_num_of_bps:
11658  0011 00            	ds.b	1
11659                     	xdef	_i_main_num_of_bps
11660  0012               _i_main_avg:
11661  0012 0000          	ds.b	2
11662                     	xdef	_i_main_avg
11663  0014               _i_main_flag:
11664  0014 000000000000  	ds.b	6
11665                     	xdef	_i_main_flag
11666  001a               _i_main:
11667  001a 000000000000  	ds.b	12
11668                     	xdef	_i_main
11669  0026               _x:
11670  0026 000000000000  	ds.b	12
11671                     	xdef	_x
11672                     	xdef	_volum_u_main_
11673                     	switch	.eeprom
11674  0008               _UU_AVT:
11675  0008 0000          	ds.b	2
11676                     	xdef	_UU_AVT
11677                     	switch	.ubsct
11678  0032               _cnt_net_drv:
11679  0032 00            	ds.b	1
11680                     	xdef	_cnt_net_drv
11681                     	switch	.bit
11682  0001               _bMAIN:
11683  0001 00            	ds.b	1
11684                     	xdef	_bMAIN
11685                     	switch	.ubsct
11686  0033               _plazma_int:
11687  0033 000000000000  	ds.b	6
11688                     	xdef	_plazma_int
11689                     	xdef	_rotor_int
11690  0039               _led_green_buff:
11691  0039 00000000      	ds.b	4
11692                     	xdef	_led_green_buff
11693  003d               _led_red_buff:
11694  003d 00000000      	ds.b	4
11695                     	xdef	_led_red_buff
11696                     	xdef	_led_drv_cnt
11697                     	xdef	_led_green
11698                     	xdef	_led_red
11699  0041               _res_fl_cnt:
11700  0041 00            	ds.b	1
11701                     	xdef	_res_fl_cnt
11702                     	xdef	_bRES_
11703                     	xdef	_bRES
11704                     	switch	.eeprom
11705  000a               _res_fl_:
11706  000a 00            	ds.b	1
11707                     	xdef	_res_fl_
11708  000b               _res_fl:
11709  000b 00            	ds.b	1
11710                     	xdef	_res_fl
11711                     	switch	.ubsct
11712  0042               _cnt_apv_off:
11713  0042 00            	ds.b	1
11714                     	xdef	_cnt_apv_off
11715                     	switch	.bit
11716  0002               _bAPV:
11717  0002 00            	ds.b	1
11718                     	xdef	_bAPV
11719                     	switch	.ubsct
11720  0043               _apv_cnt_:
11721  0043 0000          	ds.b	2
11722                     	xdef	_apv_cnt_
11723  0045               _apv_cnt:
11724  0045 000000        	ds.b	3
11725                     	xdef	_apv_cnt
11726                     	xdef	_bBL_IPS
11727                     	switch	.bit
11728  0003               _bBL:
11729  0003 00            	ds.b	1
11730                     	xdef	_bBL
11731                     	switch	.ubsct
11732  0048               _cnt_JP1:
11733  0048 00            	ds.b	1
11734                     	xdef	_cnt_JP1
11735  0049               _cnt_JP0:
11736  0049 00            	ds.b	1
11737                     	xdef	_cnt_JP0
11738  004a               _jp_mode:
11739  004a 00            	ds.b	1
11740                     	xdef	_jp_mode
11741                     	xdef	_pwm_i
11742                     	xdef	_pwm_u
11743  004b               _tmax_cnt:
11744  004b 0000          	ds.b	2
11745                     	xdef	_tmax_cnt
11746  004d               _tsign_cnt:
11747  004d 0000          	ds.b	2
11748                     	xdef	_tsign_cnt
11749                     	switch	.eeprom
11750  000c               _ee_U_AVT:
11751  000c 0000          	ds.b	2
11752                     	xdef	_ee_U_AVT
11753  000e               _ee_tsign:
11754  000e 0000          	ds.b	2
11755                     	xdef	_ee_tsign
11756  0010               _ee_tmax:
11757  0010 0000          	ds.b	2
11758                     	xdef	_ee_tmax
11759  0012               _ee_dU:
11760  0012 0000          	ds.b	2
11761                     	xdef	_ee_dU
11762  0014               _ee_Umax:
11763  0014 0000          	ds.b	2
11764                     	xdef	_ee_Umax
11765  0016               _ee_TZAS:
11766  0016 0000          	ds.b	2
11767                     	xdef	_ee_TZAS
11768                     	switch	.ubsct
11769  004f               _main_cnt1:
11770  004f 0000          	ds.b	2
11771                     	xdef	_main_cnt1
11772  0051               _main_cnt:
11773  0051 0000          	ds.b	2
11774                     	xdef	_main_cnt
11775  0053               _off_bp_cnt:
11776  0053 00            	ds.b	1
11777                     	xdef	_off_bp_cnt
11778                     	xdef	_vol_i_temp_avar
11779  0054               _flags_tu_cnt_off:
11780  0054 00            	ds.b	1
11781                     	xdef	_flags_tu_cnt_off
11782  0055               _flags_tu_cnt_on:
11783  0055 00            	ds.b	1
11784                     	xdef	_flags_tu_cnt_on
11785  0056               _vol_i_temp:
11786  0056 0000          	ds.b	2
11787                     	xdef	_vol_i_temp
11788  0058               _vol_u_temp:
11789  0058 0000          	ds.b	2
11790                     	xdef	_vol_u_temp
11791                     	switch	.eeprom
11792  0018               __x_ee_:
11793  0018 0000          	ds.b	2
11794                     	xdef	__x_ee_
11795                     	switch	.ubsct
11796  005a               __x_cnt:
11797  005a 0000          	ds.b	2
11798                     	xdef	__x_cnt
11799  005c               __x__:
11800  005c 0000          	ds.b	2
11801                     	xdef	__x__
11802  005e               __x_:
11803  005e 0000          	ds.b	2
11804                     	xdef	__x_
11805  0060               _flags_tu:
11806  0060 00            	ds.b	1
11807                     	xdef	_flags_tu
11808                     	xdef	_flags
11809  0061               _link_cnt:
11810  0061 0000          	ds.b	2
11811                     	xdef	_link_cnt
11812  0063               _link:
11813  0063 00            	ds.b	1
11814                     	xdef	_link
11815  0064               _umin_cnt:
11816  0064 0000          	ds.b	2
11817                     	xdef	_umin_cnt
11818  0066               _umax_cnt:
11819  0066 0000          	ds.b	2
11820                     	xdef	_umax_cnt
11821                     	switch	.eeprom
11822  001a               _ee_K:
11823  001a 000000000000  	ds.b	16
11824                     	xdef	_ee_K
11825                     	switch	.ubsct
11826  0068               _T:
11827  0068 00            	ds.b	1
11828                     	xdef	_T
11829  0069               _Udb:
11830  0069 0000          	ds.b	2
11831                     	xdef	_Udb
11832  006b               _Ui:
11833  006b 0000          	ds.b	2
11834                     	xdef	_Ui
11835  006d               _Un:
11836  006d 0000          	ds.b	2
11837                     	xdef	_Un
11838  006f               _I:
11839  006f 0000          	ds.b	2
11840                     	xdef	_I
11841  0071               _can_error_cnt:
11842  0071 00            	ds.b	1
11843                     	xdef	_can_error_cnt
11844                     	xdef	_bCAN_RX
11845  0072               _tx_busy_cnt:
11846  0072 00            	ds.b	1
11847                     	xdef	_tx_busy_cnt
11848                     	xdef	_bTX_FREE
11849  0073               _can_buff_rd_ptr:
11850  0073 00            	ds.b	1
11851                     	xdef	_can_buff_rd_ptr
11852  0074               _can_buff_wr_ptr:
11853  0074 00            	ds.b	1
11854                     	xdef	_can_buff_wr_ptr
11855  0075               _can_out_buff:
11856  0075 000000000000  	ds.b	64
11857                     	xdef	_can_out_buff
11858                     	switch	.bss
11859  0004               _adress_error:
11860  0004 00            	ds.b	1
11861                     	xdef	_adress_error
11862  0005               _adress:
11863  0005 00            	ds.b	1
11864                     	xdef	_adress
11865  0006               _adr:
11866  0006 000000        	ds.b	3
11867                     	xdef	_adr
11868                     	xdef	_adr_drv_stat
11869                     	xdef	_led_ind
11870                     	switch	.ubsct
11871  00b5               _led_ind_cnt:
11872  00b5 00            	ds.b	1
11873                     	xdef	_led_ind_cnt
11874  00b6               _adc_plazma:
11875  00b6 000000000000  	ds.b	10
11876                     	xdef	_adc_plazma
11877  00c0               _adc_plazma_short:
11878  00c0 0000          	ds.b	2
11879                     	xdef	_adc_plazma_short
11880  00c2               _adc_cnt:
11881  00c2 00            	ds.b	1
11882                     	xdef	_adc_cnt
11883  00c3               _adc_ch:
11884  00c3 00            	ds.b	1
11885                     	xdef	_adc_ch
11886                     	switch	.bss
11887  0009               _adc_buff_:
11888  0009 000000000000  	ds.b	20
11889                     	xdef	_adc_buff_
11890  001d               _adc_buff:
11891  001d 000000000000  	ds.b	320
11892                     	xdef	_adc_buff
11893                     	switch	.ubsct
11894  00c4               _mess:
11895  00c4 000000000000  	ds.b	14
11896                     	xdef	_mess
11897                     	switch	.bit
11898  0004               _b1Hz:
11899  0004 00            	ds.b	1
11900                     	xdef	_b1Hz
11901  0005               _b2Hz:
11902  0005 00            	ds.b	1
11903                     	xdef	_b2Hz
11904  0006               _b5Hz:
11905  0006 00            	ds.b	1
11906                     	xdef	_b5Hz
11907  0007               _b10Hz:
11908  0007 00            	ds.b	1
11909                     	xdef	_b10Hz
11910  0008               _b100Hz:
11911  0008 00            	ds.b	1
11912                     	xdef	_b100Hz
11913                     	xdef	_t0_cnt4
11914                     	xdef	_t0_cnt3
11915                     	xdef	_t0_cnt2
11916                     	xdef	_t0_cnt1
11917                     	xdef	_t0_cnt0
11918                     	xdef	_bVENT_BLOCK
11919                     	xref.b	c_lreg
11920                     	xref.b	c_x
11921                     	xref.b	c_y
11941                     	xref	c_lrsh
11942                     	xref	c_lgadd
11943                     	xref	c_ladd
11944                     	xref	c_umul
11945                     	xref	c_lgmul
11946                     	xref	c_lgsub
11947                     	xref	c_lsbc
11948                     	xref	c_idiv
11949                     	xref	c_ldiv
11950                     	xref	c_itolx
11951                     	xref	c_eewrc
11952                     	xref	c_imul
11953                     	xref	c_ltor
11954                     	xref	c_lgadc
11955                     	xref	c_rtol
11956                     	xref	c_vmul
11957                     	xref	c_eewrw
11958                     	xref	c_lcmp
11959                     	xref	c_uitolx
11960                     	end
