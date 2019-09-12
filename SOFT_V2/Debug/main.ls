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
4837                     ; 769 if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
4839  0b84 ce0004        	ldw	x,_ee_DEVICE
4840  0b87 2617          	jrne	L1142
4842  0b89 9c            	rvf
4843  0b8a ce0016        	ldw	x,_ee_TZAS
4844  0b8d 90ae0005      	ldw	y,#5
4845  0b91 cd0000        	call	c_imul
4847  0b94 1c0032        	addw	x,#50
4848  0b97 b34f          	cpw	x,_main_cnt1
4849  0b99 2d05          	jrsle	L1142
4852  0b9b ae000a        	ldw	x,#10
4853  0b9e bf0e          	ldw	_pwm_u,x
4854  0ba0               L1142:
4855                     ; 779 TIM1->CCR2H= (char)(pwm_u/256);	
4857  0ba0 be0e          	ldw	x,_pwm_u
4858  0ba2 90ae0100      	ldw	y,#256
4859  0ba6 cd0000        	call	c_idiv
4861  0ba9 9f            	ld	a,xl
4862  0baa c75267        	ld	21095,a
4863                     ; 780 TIM1->CCR2L= (char)pwm_u;
4865  0bad 55000f5268    	mov	21096,_pwm_u+1
4866                     ; 782 TIM1->CCR1H= (char)(pwm_i/256);	
4868  0bb2 be10          	ldw	x,_pwm_i
4869  0bb4 90ae0100      	ldw	y,#256
4870  0bb8 cd0000        	call	c_idiv
4872  0bbb 9f            	ld	a,xl
4873  0bbc c75265        	ld	21093,a
4874                     ; 783 TIM1->CCR1L= (char)pwm_i;
4876  0bbf 5500115266    	mov	21094,_pwm_i+1
4877                     ; 785 TIM1->CCR3H= (char)(vent_pwm/256);	
4879  0bc4 be05          	ldw	x,_vent_pwm
4880  0bc6 90ae0100      	ldw	y,#256
4881  0bca cd0000        	call	c_idiv
4883  0bcd 9f            	ld	a,xl
4884  0bce c75269        	ld	21097,a
4885                     ; 786 TIM1->CCR3L= (char)vent_pwm;
4887  0bd1 550006526a    	mov	21098,_vent_pwm+1
4888                     ; 787 }
4891  0bd6 81            	ret
4930                     ; 792 void pwr_hndl(void)				
4930                     ; 793 {
4931                     	switch	.text
4932  0bd7               _pwr_hndl:
4936                     ; 794 if(jp_mode==jp3)
4938  0bd7 b64a          	ld	a,_jp_mode
4939  0bd9 a103          	cp	a,#3
4940  0bdb 2646          	jrne	L3242
4941                     ; 796 	if((flags&0b00001010)==0)
4943  0bdd b60b          	ld	a,_flags
4944  0bdf a50a          	bcp	a,#10
4945  0be1 2629          	jrne	L5242
4946                     ; 798 		pwm_u=500;
4948  0be3 ae01f4        	ldw	x,#500
4949  0be6 bf0e          	ldw	_pwm_u,x
4950                     ; 799 		if(pwm_i<1020)
4952  0be8 9c            	rvf
4953  0be9 be10          	ldw	x,_pwm_i
4954  0beb a303fc        	cpw	x,#1020
4955  0bee 2e14          	jrsge	L7242
4956                     ; 801 			pwm_i+=30;
4958  0bf0 be10          	ldw	x,_pwm_i
4959  0bf2 1c001e        	addw	x,#30
4960  0bf5 bf10          	ldw	_pwm_i,x
4961                     ; 802 			if(pwm_i>1020)pwm_i=1020;
4963  0bf7 9c            	rvf
4964  0bf8 be10          	ldw	x,_pwm_i
4965  0bfa a303fd        	cpw	x,#1021
4966  0bfd 2f05          	jrslt	L7242
4969  0bff ae03fc        	ldw	x,#1020
4970  0c02 bf10          	ldw	_pwm_i,x
4971  0c04               L7242:
4972                     ; 804 		bBL=0;
4974  0c04 72110003      	bres	_bBL
4976  0c08 acd30dd3      	jpf	L7342
4977  0c0c               L5242:
4978                     ; 806 	else if(flags&0b00001010)
4980  0c0c b60b          	ld	a,_flags
4981  0c0e a50a          	bcp	a,#10
4982  0c10 2603          	jrne	L46
4983  0c12 cc0dd3        	jp	L7342
4984  0c15               L46:
4985                     ; 808 		pwm_u=0;
4987  0c15 5f            	clrw	x
4988  0c16 bf0e          	ldw	_pwm_u,x
4989                     ; 809 		pwm_i=0;
4991  0c18 5f            	clrw	x
4992  0c19 bf10          	ldw	_pwm_i,x
4993                     ; 810 		bBL=1;
4995  0c1b 72100003      	bset	_bBL
4996  0c1f acd30dd3      	jpf	L7342
4997  0c23               L3242:
4998                     ; 814 else if(jp_mode==jp2)
5000  0c23 b64a          	ld	a,_jp_mode
5001  0c25 a102          	cp	a,#2
5002  0c27 2627          	jrne	L1442
5003                     ; 816 	pwm_u=0;
5005  0c29 5f            	clrw	x
5006  0c2a bf0e          	ldw	_pwm_u,x
5007                     ; 818 	if(pwm_i<1020)
5009  0c2c 9c            	rvf
5010  0c2d be10          	ldw	x,_pwm_i
5011  0c2f a303fc        	cpw	x,#1020
5012  0c32 2e14          	jrsge	L3442
5013                     ; 820 		pwm_i+=30;
5015  0c34 be10          	ldw	x,_pwm_i
5016  0c36 1c001e        	addw	x,#30
5017  0c39 bf10          	ldw	_pwm_i,x
5018                     ; 821 		if(pwm_i>1020)pwm_i=1020;
5020  0c3b 9c            	rvf
5021  0c3c be10          	ldw	x,_pwm_i
5022  0c3e a303fd        	cpw	x,#1021
5023  0c41 2f05          	jrslt	L3442
5026  0c43 ae03fc        	ldw	x,#1020
5027  0c46 bf10          	ldw	_pwm_i,x
5028  0c48               L3442:
5029                     ; 823 	bBL=0;
5031  0c48 72110003      	bres	_bBL
5033  0c4c acd30dd3      	jpf	L7342
5034  0c50               L1442:
5035                     ; 825 else if(jp_mode==jp1)
5037  0c50 b64a          	ld	a,_jp_mode
5038  0c52 a101          	cp	a,#1
5039  0c54 2629          	jrne	L1542
5040                     ; 827 	pwm_u=0x3ff;
5042  0c56 ae03ff        	ldw	x,#1023
5043  0c59 bf0e          	ldw	_pwm_u,x
5044                     ; 829 	if(pwm_i<1020)
5046  0c5b 9c            	rvf
5047  0c5c be10          	ldw	x,_pwm_i
5048  0c5e a303fc        	cpw	x,#1020
5049  0c61 2e14          	jrsge	L3542
5050                     ; 831 		pwm_i+=30;
5052  0c63 be10          	ldw	x,_pwm_i
5053  0c65 1c001e        	addw	x,#30
5054  0c68 bf10          	ldw	_pwm_i,x
5055                     ; 832 		if(pwm_i>1020)pwm_i=1020;
5057  0c6a 9c            	rvf
5058  0c6b be10          	ldw	x,_pwm_i
5059  0c6d a303fd        	cpw	x,#1021
5060  0c70 2f05          	jrslt	L3542
5063  0c72 ae03fc        	ldw	x,#1020
5064  0c75 bf10          	ldw	_pwm_i,x
5065  0c77               L3542:
5066                     ; 834 	bBL=0;
5068  0c77 72110003      	bres	_bBL
5070  0c7b acd30dd3      	jpf	L7342
5071  0c7f               L1542:
5072                     ; 837 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
5074                     	btst	_bMAIN
5075  0c84 242e          	jruge	L1642
5077  0c86 b663          	ld	a,_link
5078  0c88 a155          	cp	a,#85
5079  0c8a 2628          	jrne	L1642
5080                     ; 839 	pwm_u=volum_u_main_;
5082  0c8c be1f          	ldw	x,_volum_u_main_
5083  0c8e bf0e          	ldw	_pwm_u,x
5084                     ; 841 	if(pwm_i<1020)
5086  0c90 9c            	rvf
5087  0c91 be10          	ldw	x,_pwm_i
5088  0c93 a303fc        	cpw	x,#1020
5089  0c96 2e14          	jrsge	L3642
5090                     ; 843 		pwm_i+=30;
5092  0c98 be10          	ldw	x,_pwm_i
5093  0c9a 1c001e        	addw	x,#30
5094  0c9d bf10          	ldw	_pwm_i,x
5095                     ; 844 		if(pwm_i>1020)pwm_i=1020;
5097  0c9f 9c            	rvf
5098  0ca0 be10          	ldw	x,_pwm_i
5099  0ca2 a303fd        	cpw	x,#1021
5100  0ca5 2f05          	jrslt	L3642
5103  0ca7 ae03fc        	ldw	x,#1020
5104  0caa bf10          	ldw	_pwm_i,x
5105  0cac               L3642:
5106                     ; 846 	bBL_IPS=0;
5108  0cac 72110000      	bres	_bBL_IPS
5110  0cb0 acd30dd3      	jpf	L7342
5111  0cb4               L1642:
5112                     ; 849 else if(link==OFF)
5114  0cb4 b663          	ld	a,_link
5115  0cb6 a1aa          	cp	a,#170
5116  0cb8 266f          	jrne	L1742
5117                     ; 858  	if(ee_DEVICE)
5119  0cba ce0004        	ldw	x,_ee_DEVICE
5120  0cbd 270e          	jreq	L3742
5121                     ; 860 		pwm_u=0x00;
5123  0cbf 5f            	clrw	x
5124  0cc0 bf0e          	ldw	_pwm_u,x
5125                     ; 861 		pwm_i=0x00;
5127  0cc2 5f            	clrw	x
5128  0cc3 bf10          	ldw	_pwm_i,x
5129                     ; 862 		bBL=1;
5131  0cc5 72100003      	bset	_bBL
5133  0cc9 acd30dd3      	jpf	L7342
5134  0ccd               L3742:
5135                     ; 866 		if((flags&0b00011010)==0)
5137  0ccd b60b          	ld	a,_flags
5138  0ccf a51a          	bcp	a,#26
5139  0cd1 263b          	jrne	L7742
5140                     ; 868 			pwm_u=ee_U_AVT;
5142  0cd3 ce000c        	ldw	x,_ee_U_AVT
5143  0cd6 bf0e          	ldw	_pwm_u,x
5144                     ; 869 			gran(&pwm_u,0,1020);
5146  0cd8 ae03fc        	ldw	x,#1020
5147  0cdb 89            	pushw	x
5148  0cdc 5f            	clrw	x
5149  0cdd 89            	pushw	x
5150  0cde ae000e        	ldw	x,#_pwm_u
5151  0ce1 cd00d1        	call	_gran
5153  0ce4 5b04          	addw	sp,#4
5154                     ; 871 			if(pwm_i<1020)
5156  0ce6 9c            	rvf
5157  0ce7 be10          	ldw	x,_pwm_i
5158  0ce9 a303fc        	cpw	x,#1020
5159  0cec 2e14          	jrsge	L1052
5160                     ; 873 				pwm_i+=30;
5162  0cee be10          	ldw	x,_pwm_i
5163  0cf0 1c001e        	addw	x,#30
5164  0cf3 bf10          	ldw	_pwm_i,x
5165                     ; 874 				if(pwm_i>1020)pwm_i=1020;
5167  0cf5 9c            	rvf
5168  0cf6 be10          	ldw	x,_pwm_i
5169  0cf8 a303fd        	cpw	x,#1021
5170  0cfb 2f05          	jrslt	L1052
5173  0cfd ae03fc        	ldw	x,#1020
5174  0d00 bf10          	ldw	_pwm_i,x
5175  0d02               L1052:
5176                     ; 876 			bBL=0;
5178  0d02 72110003      	bres	_bBL
5179                     ; 877 			bBL_IPS=0;
5181  0d06 72110000      	bres	_bBL_IPS
5183  0d0a acd30dd3      	jpf	L7342
5184  0d0e               L7742:
5185                     ; 879 		else if(flags&0b00011010)
5187  0d0e b60b          	ld	a,_flags
5188  0d10 a51a          	bcp	a,#26
5189  0d12 2603          	jrne	L66
5190  0d14 cc0dd3        	jp	L7342
5191  0d17               L66:
5192                     ; 881 			pwm_u=0;
5194  0d17 5f            	clrw	x
5195  0d18 bf0e          	ldw	_pwm_u,x
5196                     ; 882 			pwm_i=0;
5198  0d1a 5f            	clrw	x
5199  0d1b bf10          	ldw	_pwm_i,x
5200                     ; 883 			bBL=1;
5202  0d1d 72100003      	bset	_bBL
5203                     ; 884 			bBL_IPS=1;
5205  0d21 72100000      	bset	_bBL_IPS
5206  0d25 acd30dd3      	jpf	L7342
5207  0d29               L1742:
5208                     ; 893 else	if(link==ON)				//если есть связьvol_i_temp_avar
5210  0d29 b663          	ld	a,_link
5211  0d2b a155          	cp	a,#85
5212  0d2d 2703          	jreq	L07
5213  0d2f cc0dd3        	jp	L7342
5214  0d32               L07:
5215                     ; 895 	if((flags&0b00100000)==0)	//если нет блокировки извне
5217  0d32 b60b          	ld	a,_flags
5218  0d34 a520          	bcp	a,#32
5219  0d36 2703cc0dc3    	jrne	L5152
5220                     ; 897 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
5222  0d3b b60b          	ld	a,_flags
5223  0d3d a41e          	and	a,#30
5224  0d3f a104          	cp	a,#4
5225  0d41 2630          	jrne	L7152
5226                     ; 899 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5228  0d43 be5e          	ldw	x,__x_
5229  0d45 72bb0058      	addw	x,_vol_u_temp
5230  0d49 bf0e          	ldw	_pwm_u,x
5231                     ; 900 			if(!ee_DEVICE)
5233  0d4b ce0004        	ldw	x,_ee_DEVICE
5234  0d4e 261b          	jrne	L1252
5235                     ; 902 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
5237  0d50 be10          	ldw	x,_pwm_i
5238  0d52 b30c          	cpw	x,_vol_i_temp_avar
5239  0d54 240f          	jruge	L3252
5242  0d56 be0c          	ldw	x,_vol_i_temp_avar
5243  0d58 90ae001e      	ldw	y,#30
5244  0d5c 65            	divw	x,y
5245  0d5d 72bb0010      	addw	x,_pwm_i
5246  0d61 bf10          	ldw	_pwm_i,x
5248  0d63 200a          	jra	L7252
5249  0d65               L3252:
5250                     ; 903 				else	pwm_i=vol_i_temp_avar;
5252  0d65 be0c          	ldw	x,_vol_i_temp_avar
5253  0d67 bf10          	ldw	_pwm_i,x
5254  0d69 2004          	jra	L7252
5255  0d6b               L1252:
5256                     ; 905 			else pwm_i=vol_i_temp_avar;
5258  0d6b be0c          	ldw	x,_vol_i_temp_avar
5259  0d6d bf10          	ldw	_pwm_i,x
5260  0d6f               L7252:
5261                     ; 907 			bBL=0;
5263  0d6f 72110003      	bres	_bBL
5264  0d73               L7152:
5265                     ; 909 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5267  0d73 b60b          	ld	a,_flags
5268  0d75 a51a          	bcp	a,#26
5269  0d77 2706          	jreq	L3352
5271  0d79 b60b          	ld	a,_flags
5272  0d7b a540          	bcp	a,#64
5273  0d7d 2732          	jreq	L1352
5274  0d7f               L3352:
5275                     ; 911 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5277  0d7f be5e          	ldw	x,__x_
5278  0d81 72bb0058      	addw	x,_vol_u_temp
5279  0d85 bf0e          	ldw	_pwm_u,x
5280                     ; 913 			if(!ee_DEVICE)
5282  0d87 ce0004        	ldw	x,_ee_DEVICE
5283  0d8a 261b          	jrne	L5352
5284                     ; 915 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
5286  0d8c be10          	ldw	x,_pwm_i
5287  0d8e b356          	cpw	x,_vol_i_temp
5288  0d90 240f          	jruge	L7352
5291  0d92 be56          	ldw	x,_vol_i_temp
5292  0d94 90ae001e      	ldw	y,#30
5293  0d98 65            	divw	x,y
5294  0d99 72bb0010      	addw	x,_pwm_i
5295  0d9d bf10          	ldw	_pwm_i,x
5297  0d9f 200a          	jra	L3452
5298  0da1               L7352:
5299                     ; 916 				else	pwm_i=vol_i_temp;
5301  0da1 be56          	ldw	x,_vol_i_temp
5302  0da3 bf10          	ldw	_pwm_i,x
5303  0da5 2004          	jra	L3452
5304  0da7               L5352:
5305                     ; 918 			else pwm_i=vol_i_temp;			
5307  0da7 be56          	ldw	x,_vol_i_temp
5308  0da9 bf10          	ldw	_pwm_i,x
5309  0dab               L3452:
5310                     ; 919 			bBL=0;
5312  0dab 72110003      	bres	_bBL
5314  0daf 2022          	jra	L7342
5315  0db1               L1352:
5316                     ; 921 		else if(flags&0b00011010)					//если есть аварии
5318  0db1 b60b          	ld	a,_flags
5319  0db3 a51a          	bcp	a,#26
5320  0db5 271c          	jreq	L7342
5321                     ; 923 			pwm_u=0;								//то полный стоп
5323  0db7 5f            	clrw	x
5324  0db8 bf0e          	ldw	_pwm_u,x
5325                     ; 924 			pwm_i=0;
5327  0dba 5f            	clrw	x
5328  0dbb bf10          	ldw	_pwm_i,x
5329                     ; 925 			bBL=1;
5331  0dbd 72100003      	bset	_bBL
5332  0dc1 2010          	jra	L7342
5333  0dc3               L5152:
5334                     ; 928 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5336  0dc3 b60b          	ld	a,_flags
5337  0dc5 a520          	bcp	a,#32
5338  0dc7 270a          	jreq	L7342
5339                     ; 930 		pwm_u=0;
5341  0dc9 5f            	clrw	x
5342  0dca bf0e          	ldw	_pwm_u,x
5343                     ; 931 	    	pwm_i=0;
5345  0dcc 5f            	clrw	x
5346  0dcd bf10          	ldw	_pwm_i,x
5347                     ; 932 		bBL=1;
5349  0dcf 72100003      	bset	_bBL
5350  0dd3               L7342:
5351                     ; 938 }
5354  0dd3 81            	ret
5399                     	switch	.const
5400  000c               L47:
5401  000c 00000258      	dc.l	600
5402  0010               L67:
5403  0010 000003e8      	dc.l	1000
5404                     ; 941 void matemat(void)
5404                     ; 942 {
5405                     	switch	.text
5406  0dd4               _matemat:
5408  0dd4 5208          	subw	sp,#8
5409       00000008      OFST:	set	8
5412                     ; 963 temp_SL=adc_buff_[4];
5414  0dd6 ce0011        	ldw	x,_adc_buff_+8
5415  0dd9 cd0000        	call	c_itolx
5417  0ddc 96            	ldw	x,sp
5418  0ddd 1c0005        	addw	x,#OFST-3
5419  0de0 cd0000        	call	c_rtol
5421                     ; 964 temp_SL-=ee_K[0][0];
5423  0de3 ce001a        	ldw	x,_ee_K
5424  0de6 cd0000        	call	c_itolx
5426  0de9 96            	ldw	x,sp
5427  0dea 1c0005        	addw	x,#OFST-3
5428  0ded cd0000        	call	c_lgsub
5430                     ; 965 if(temp_SL<0) temp_SL=0;
5432  0df0 9c            	rvf
5433  0df1 0d05          	tnz	(OFST-3,sp)
5434  0df3 2e0a          	jrsge	L3752
5437  0df5 ae0000        	ldw	x,#0
5438  0df8 1f07          	ldw	(OFST-1,sp),x
5439  0dfa ae0000        	ldw	x,#0
5440  0dfd 1f05          	ldw	(OFST-3,sp),x
5441  0dff               L3752:
5442                     ; 966 temp_SL*=ee_K[0][1];
5444  0dff ce001c        	ldw	x,_ee_K+2
5445  0e02 cd0000        	call	c_itolx
5447  0e05 96            	ldw	x,sp
5448  0e06 1c0005        	addw	x,#OFST-3
5449  0e09 cd0000        	call	c_lgmul
5451                     ; 967 temp_SL/=600;
5453  0e0c 96            	ldw	x,sp
5454  0e0d 1c0005        	addw	x,#OFST-3
5455  0e10 cd0000        	call	c_ltor
5457  0e13 ae000c        	ldw	x,#L47
5458  0e16 cd0000        	call	c_ldiv
5460  0e19 96            	ldw	x,sp
5461  0e1a 1c0005        	addw	x,#OFST-3
5462  0e1d cd0000        	call	c_rtol
5464                     ; 968 I=(signed short)temp_SL;
5466  0e20 1e07          	ldw	x,(OFST-1,sp)
5467  0e22 bf6f          	ldw	_I,x
5468                     ; 973 temp_SL=(signed long)adc_buff_[1];
5470  0e24 ce000b        	ldw	x,_adc_buff_+2
5471  0e27 cd0000        	call	c_itolx
5473  0e2a 96            	ldw	x,sp
5474  0e2b 1c0005        	addw	x,#OFST-3
5475  0e2e cd0000        	call	c_rtol
5477                     ; 975 if(temp_SL<0) temp_SL=0;
5479  0e31 9c            	rvf
5480  0e32 0d05          	tnz	(OFST-3,sp)
5481  0e34 2e0a          	jrsge	L5752
5484  0e36 ae0000        	ldw	x,#0
5485  0e39 1f07          	ldw	(OFST-1,sp),x
5486  0e3b ae0000        	ldw	x,#0
5487  0e3e 1f05          	ldw	(OFST-3,sp),x
5488  0e40               L5752:
5489                     ; 976 temp_SL*=(signed long)ee_K[2][1];
5491  0e40 ce0024        	ldw	x,_ee_K+10
5492  0e43 cd0000        	call	c_itolx
5494  0e46 96            	ldw	x,sp
5495  0e47 1c0005        	addw	x,#OFST-3
5496  0e4a cd0000        	call	c_lgmul
5498                     ; 977 temp_SL/=1000L;
5500  0e4d 96            	ldw	x,sp
5501  0e4e 1c0005        	addw	x,#OFST-3
5502  0e51 cd0000        	call	c_ltor
5504  0e54 ae0010        	ldw	x,#L67
5505  0e57 cd0000        	call	c_ldiv
5507  0e5a 96            	ldw	x,sp
5508  0e5b 1c0005        	addw	x,#OFST-3
5509  0e5e cd0000        	call	c_rtol
5511                     ; 978 Ui=(unsigned short)temp_SL;
5513  0e61 1e07          	ldw	x,(OFST-1,sp)
5514  0e63 bf6b          	ldw	_Ui,x
5515                     ; 985 temp_SL=adc_buff_[3];
5517  0e65 ce000f        	ldw	x,_adc_buff_+6
5518  0e68 cd0000        	call	c_itolx
5520  0e6b 96            	ldw	x,sp
5521  0e6c 1c0005        	addw	x,#OFST-3
5522  0e6f cd0000        	call	c_rtol
5524                     ; 987 if(temp_SL<0) temp_SL=0;
5526  0e72 9c            	rvf
5527  0e73 0d05          	tnz	(OFST-3,sp)
5528  0e75 2e0a          	jrsge	L7752
5531  0e77 ae0000        	ldw	x,#0
5532  0e7a 1f07          	ldw	(OFST-1,sp),x
5533  0e7c ae0000        	ldw	x,#0
5534  0e7f 1f05          	ldw	(OFST-3,sp),x
5535  0e81               L7752:
5536                     ; 988 temp_SL*=ee_K[1][1];
5538  0e81 ce0020        	ldw	x,_ee_K+6
5539  0e84 cd0000        	call	c_itolx
5541  0e87 96            	ldw	x,sp
5542  0e88 1c0005        	addw	x,#OFST-3
5543  0e8b cd0000        	call	c_lgmul
5545                     ; 989 temp_SL/=1000;
5547  0e8e 96            	ldw	x,sp
5548  0e8f 1c0005        	addw	x,#OFST-3
5549  0e92 cd0000        	call	c_ltor
5551  0e95 ae0010        	ldw	x,#L67
5552  0e98 cd0000        	call	c_ldiv
5554  0e9b 96            	ldw	x,sp
5555  0e9c 1c0005        	addw	x,#OFST-3
5556  0e9f cd0000        	call	c_rtol
5558                     ; 990 Un=(unsigned short)temp_SL;
5560  0ea2 1e07          	ldw	x,(OFST-1,sp)
5561  0ea4 bf6d          	ldw	_Un,x
5562                     ; 993 temp_SL=adc_buff_[2];
5564  0ea6 ce000d        	ldw	x,_adc_buff_+4
5565  0ea9 cd0000        	call	c_itolx
5567  0eac 96            	ldw	x,sp
5568  0ead 1c0005        	addw	x,#OFST-3
5569  0eb0 cd0000        	call	c_rtol
5571                     ; 994 temp_SL*=ee_K[3][1];
5573  0eb3 ce0028        	ldw	x,_ee_K+14
5574  0eb6 cd0000        	call	c_itolx
5576  0eb9 96            	ldw	x,sp
5577  0eba 1c0005        	addw	x,#OFST-3
5578  0ebd cd0000        	call	c_lgmul
5580                     ; 995 temp_SL/=1000;
5582  0ec0 96            	ldw	x,sp
5583  0ec1 1c0005        	addw	x,#OFST-3
5584  0ec4 cd0000        	call	c_ltor
5586  0ec7 ae0010        	ldw	x,#L67
5587  0eca cd0000        	call	c_ldiv
5589  0ecd 96            	ldw	x,sp
5590  0ece 1c0005        	addw	x,#OFST-3
5591  0ed1 cd0000        	call	c_rtol
5593                     ; 996 T=(signed short)(temp_SL-273L);
5595  0ed4 7b08          	ld	a,(OFST+0,sp)
5596  0ed6 5f            	clrw	x
5597  0ed7 4d            	tnz	a
5598  0ed8 2a01          	jrpl	L001
5599  0eda 53            	cplw	x
5600  0edb               L001:
5601  0edb 97            	ld	xl,a
5602  0edc 1d0111        	subw	x,#273
5603  0edf 01            	rrwa	x,a
5604  0ee0 b768          	ld	_T,a
5605  0ee2 02            	rlwa	x,a
5606                     ; 997 if(T<-30)T=-30;
5608  0ee3 9c            	rvf
5609  0ee4 b668          	ld	a,_T
5610  0ee6 a1e2          	cp	a,#226
5611  0ee8 2e04          	jrsge	L1062
5614  0eea 35e20068      	mov	_T,#226
5615  0eee               L1062:
5616                     ; 998 if(T>120)T=120;
5618  0eee 9c            	rvf
5619  0eef b668          	ld	a,_T
5620  0ef1 a179          	cp	a,#121
5621  0ef3 2f04          	jrslt	L3062
5624  0ef5 35780068      	mov	_T,#120
5625  0ef9               L3062:
5626                     ; 1000 Udb=flags;
5628  0ef9 b60b          	ld	a,_flags
5629  0efb 5f            	clrw	x
5630  0efc 97            	ld	xl,a
5631  0efd bf69          	ldw	_Udb,x
5632                     ; 1006 temp_SL=(signed long)(T-ee_tsign);
5634  0eff 5f            	clrw	x
5635  0f00 b668          	ld	a,_T
5636  0f02 2a01          	jrpl	L201
5637  0f04 53            	cplw	x
5638  0f05               L201:
5639  0f05 97            	ld	xl,a
5640  0f06 72b0000e      	subw	x,_ee_tsign
5641  0f0a cd0000        	call	c_itolx
5643  0f0d 96            	ldw	x,sp
5644  0f0e 1c0005        	addw	x,#OFST-3
5645  0f11 cd0000        	call	c_rtol
5647                     ; 1007 temp_SL*=1000L;
5649  0f14 ae03e8        	ldw	x,#1000
5650  0f17 bf02          	ldw	c_lreg+2,x
5651  0f19 ae0000        	ldw	x,#0
5652  0f1c bf00          	ldw	c_lreg,x
5653  0f1e 96            	ldw	x,sp
5654  0f1f 1c0005        	addw	x,#OFST-3
5655  0f22 cd0000        	call	c_lgmul
5657                     ; 1008 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5659  0f25 ce0010        	ldw	x,_ee_tmax
5660  0f28 72b0000e      	subw	x,_ee_tsign
5661  0f2c cd0000        	call	c_itolx
5663  0f2f 96            	ldw	x,sp
5664  0f30 1c0001        	addw	x,#OFST-7
5665  0f33 cd0000        	call	c_rtol
5667  0f36 96            	ldw	x,sp
5668  0f37 1c0005        	addw	x,#OFST-3
5669  0f3a cd0000        	call	c_ltor
5671  0f3d 96            	ldw	x,sp
5672  0f3e 1c0001        	addw	x,#OFST-7
5673  0f41 cd0000        	call	c_ldiv
5675  0f44 96            	ldw	x,sp
5676  0f45 1c0005        	addw	x,#OFST-3
5677  0f48 cd0000        	call	c_rtol
5679                     ; 1010 vol_i_temp_avar=(unsigned short)temp_SL; 
5681  0f4b 1e07          	ldw	x,(OFST-1,sp)
5682  0f4d bf0c          	ldw	_vol_i_temp_avar,x
5683                     ; 1012 }
5686  0f4f 5b08          	addw	sp,#8
5687  0f51 81            	ret
5718                     ; 1015 void temper_drv(void)		//1 Hz
5718                     ; 1016 {
5719                     	switch	.text
5720  0f52               _temper_drv:
5724                     ; 1018 if(T>ee_tsign) tsign_cnt++;
5726  0f52 9c            	rvf
5727  0f53 5f            	clrw	x
5728  0f54 b668          	ld	a,_T
5729  0f56 2a01          	jrpl	L601
5730  0f58 53            	cplw	x
5731  0f59               L601:
5732  0f59 97            	ld	xl,a
5733  0f5a c3000e        	cpw	x,_ee_tsign
5734  0f5d 2d09          	jrsle	L5162
5737  0f5f be4d          	ldw	x,_tsign_cnt
5738  0f61 1c0001        	addw	x,#1
5739  0f64 bf4d          	ldw	_tsign_cnt,x
5741  0f66 201d          	jra	L7162
5742  0f68               L5162:
5743                     ; 1019 else if (T<(ee_tsign-1)) tsign_cnt--;
5745  0f68 9c            	rvf
5746  0f69 ce000e        	ldw	x,_ee_tsign
5747  0f6c 5a            	decw	x
5748  0f6d 905f          	clrw	y
5749  0f6f b668          	ld	a,_T
5750  0f71 2a02          	jrpl	L011
5751  0f73 9053          	cplw	y
5752  0f75               L011:
5753  0f75 9097          	ld	yl,a
5754  0f77 90bf00        	ldw	c_y,y
5755  0f7a b300          	cpw	x,c_y
5756  0f7c 2d07          	jrsle	L7162
5759  0f7e be4d          	ldw	x,_tsign_cnt
5760  0f80 1d0001        	subw	x,#1
5761  0f83 bf4d          	ldw	_tsign_cnt,x
5762  0f85               L7162:
5763                     ; 1021 gran(&tsign_cnt,0,60);
5765  0f85 ae003c        	ldw	x,#60
5766  0f88 89            	pushw	x
5767  0f89 5f            	clrw	x
5768  0f8a 89            	pushw	x
5769  0f8b ae004d        	ldw	x,#_tsign_cnt
5770  0f8e cd00d1        	call	_gran
5772  0f91 5b04          	addw	sp,#4
5773                     ; 1023 if(tsign_cnt>=55)
5775  0f93 9c            	rvf
5776  0f94 be4d          	ldw	x,_tsign_cnt
5777  0f96 a30037        	cpw	x,#55
5778  0f99 2f16          	jrslt	L3262
5779                     ; 1025 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5781  0f9b 3d4a          	tnz	_jp_mode
5782  0f9d 2606          	jrne	L1362
5784  0f9f b60b          	ld	a,_flags
5785  0fa1 a540          	bcp	a,#64
5786  0fa3 2706          	jreq	L7262
5787  0fa5               L1362:
5789  0fa5 b64a          	ld	a,_jp_mode
5790  0fa7 a103          	cp	a,#3
5791  0fa9 2612          	jrne	L3362
5792  0fab               L7262:
5795  0fab 7214000b      	bset	_flags,#2
5796  0faf 200c          	jra	L3362
5797  0fb1               L3262:
5798                     ; 1027 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5800  0fb1 9c            	rvf
5801  0fb2 be4d          	ldw	x,_tsign_cnt
5802  0fb4 a30006        	cpw	x,#6
5803  0fb7 2e04          	jrsge	L3362
5806  0fb9 7215000b      	bres	_flags,#2
5807  0fbd               L3362:
5808                     ; 1032 if(T>ee_tmax) tmax_cnt++;
5810  0fbd 9c            	rvf
5811  0fbe 5f            	clrw	x
5812  0fbf b668          	ld	a,_T
5813  0fc1 2a01          	jrpl	L211
5814  0fc3 53            	cplw	x
5815  0fc4               L211:
5816  0fc4 97            	ld	xl,a
5817  0fc5 c30010        	cpw	x,_ee_tmax
5818  0fc8 2d09          	jrsle	L7362
5821  0fca be4b          	ldw	x,_tmax_cnt
5822  0fcc 1c0001        	addw	x,#1
5823  0fcf bf4b          	ldw	_tmax_cnt,x
5825  0fd1 201d          	jra	L1462
5826  0fd3               L7362:
5827                     ; 1033 else if (T<(ee_tmax-1)) tmax_cnt--;
5829  0fd3 9c            	rvf
5830  0fd4 ce0010        	ldw	x,_ee_tmax
5831  0fd7 5a            	decw	x
5832  0fd8 905f          	clrw	y
5833  0fda b668          	ld	a,_T
5834  0fdc 2a02          	jrpl	L411
5835  0fde 9053          	cplw	y
5836  0fe0               L411:
5837  0fe0 9097          	ld	yl,a
5838  0fe2 90bf00        	ldw	c_y,y
5839  0fe5 b300          	cpw	x,c_y
5840  0fe7 2d07          	jrsle	L1462
5843  0fe9 be4b          	ldw	x,_tmax_cnt
5844  0feb 1d0001        	subw	x,#1
5845  0fee bf4b          	ldw	_tmax_cnt,x
5846  0ff0               L1462:
5847                     ; 1035 gran(&tmax_cnt,0,60);
5849  0ff0 ae003c        	ldw	x,#60
5850  0ff3 89            	pushw	x
5851  0ff4 5f            	clrw	x
5852  0ff5 89            	pushw	x
5853  0ff6 ae004b        	ldw	x,#_tmax_cnt
5854  0ff9 cd00d1        	call	_gran
5856  0ffc 5b04          	addw	sp,#4
5857                     ; 1037 if(tmax_cnt>=55)
5859  0ffe 9c            	rvf
5860  0fff be4b          	ldw	x,_tmax_cnt
5861  1001 a30037        	cpw	x,#55
5862  1004 2f16          	jrslt	L5462
5863                     ; 1039 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5865  1006 3d4a          	tnz	_jp_mode
5866  1008 2606          	jrne	L3562
5868  100a b60b          	ld	a,_flags
5869  100c a540          	bcp	a,#64
5870  100e 2706          	jreq	L1562
5871  1010               L3562:
5873  1010 b64a          	ld	a,_jp_mode
5874  1012 a103          	cp	a,#3
5875  1014 2612          	jrne	L5562
5876  1016               L1562:
5879  1016 7212000b      	bset	_flags,#1
5880  101a 200c          	jra	L5562
5881  101c               L5462:
5882                     ; 1041 else if (tmax_cnt<=5) flags&=0b11111101;
5884  101c 9c            	rvf
5885  101d be4b          	ldw	x,_tmax_cnt
5886  101f a30006        	cpw	x,#6
5887  1022 2e04          	jrsge	L5562
5890  1024 7213000b      	bres	_flags,#1
5891  1028               L5562:
5892                     ; 1044 } 
5895  1028 81            	ret
5927                     ; 1047 void u_drv(void)		//1Hz
5927                     ; 1048 { 
5928                     	switch	.text
5929  1029               _u_drv:
5933                     ; 1049 if(jp_mode!=jp3)
5935  1029 b64a          	ld	a,_jp_mode
5936  102b a103          	cp	a,#3
5937  102d 2770          	jreq	L1762
5938                     ; 1051 	if(Ui>ee_Umax)umax_cnt++;
5940  102f 9c            	rvf
5941  1030 be6b          	ldw	x,_Ui
5942  1032 c30014        	cpw	x,_ee_Umax
5943  1035 2d09          	jrsle	L3762
5946  1037 be66          	ldw	x,_umax_cnt
5947  1039 1c0001        	addw	x,#1
5948  103c bf66          	ldw	_umax_cnt,x
5950  103e 2003          	jra	L5762
5951  1040               L3762:
5952                     ; 1052 	else umax_cnt=0;
5954  1040 5f            	clrw	x
5955  1041 bf66          	ldw	_umax_cnt,x
5956  1043               L5762:
5957                     ; 1053 	gran(&umax_cnt,0,10);
5959  1043 ae000a        	ldw	x,#10
5960  1046 89            	pushw	x
5961  1047 5f            	clrw	x
5962  1048 89            	pushw	x
5963  1049 ae0066        	ldw	x,#_umax_cnt
5964  104c cd00d1        	call	_gran
5966  104f 5b04          	addw	sp,#4
5967                     ; 1054 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5969  1051 9c            	rvf
5970  1052 be66          	ldw	x,_umax_cnt
5971  1054 a3000a        	cpw	x,#10
5972  1057 2f04          	jrslt	L7762
5975  1059 7216000b      	bset	_flags,#3
5976  105d               L7762:
5977                     ; 1057 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5979  105d 9c            	rvf
5980  105e be6b          	ldw	x,_Ui
5981  1060 b36d          	cpw	x,_Un
5982  1062 2e1c          	jrsge	L1072
5984  1064 9c            	rvf
5985  1065 be6d          	ldw	x,_Un
5986  1067 72b0006b      	subw	x,_Ui
5987  106b c30012        	cpw	x,_ee_dU
5988  106e 2d10          	jrsle	L1072
5990  1070 c65005        	ld	a,20485
5991  1073 a504          	bcp	a,#4
5992  1075 2609          	jrne	L1072
5995  1077 be64          	ldw	x,_umin_cnt
5996  1079 1c0001        	addw	x,#1
5997  107c bf64          	ldw	_umin_cnt,x
5999  107e 2003          	jra	L3072
6000  1080               L1072:
6001                     ; 1058 	else umin_cnt=0;
6003  1080 5f            	clrw	x
6004  1081 bf64          	ldw	_umin_cnt,x
6005  1083               L3072:
6006                     ; 1059 	gran(&umin_cnt,0,10);	
6008  1083 ae000a        	ldw	x,#10
6009  1086 89            	pushw	x
6010  1087 5f            	clrw	x
6011  1088 89            	pushw	x
6012  1089 ae0064        	ldw	x,#_umin_cnt
6013  108c cd00d1        	call	_gran
6015  108f 5b04          	addw	sp,#4
6016                     ; 1060 	if(umin_cnt>=10)flags|=0b00010000;	  
6018  1091 9c            	rvf
6019  1092 be64          	ldw	x,_umin_cnt
6020  1094 a3000a        	cpw	x,#10
6021  1097 2f6f          	jrslt	L7072
6024  1099 7218000b      	bset	_flags,#4
6025  109d 2069          	jra	L7072
6026  109f               L1762:
6027                     ; 1062 else if(jp_mode==jp3)
6029  109f b64a          	ld	a,_jp_mode
6030  10a1 a103          	cp	a,#3
6031  10a3 2663          	jrne	L7072
6032                     ; 1064 	if(Ui>700)umax_cnt++;
6034  10a5 9c            	rvf
6035  10a6 be6b          	ldw	x,_Ui
6036  10a8 a302bd        	cpw	x,#701
6037  10ab 2f09          	jrslt	L3172
6040  10ad be66          	ldw	x,_umax_cnt
6041  10af 1c0001        	addw	x,#1
6042  10b2 bf66          	ldw	_umax_cnt,x
6044  10b4 2003          	jra	L5172
6045  10b6               L3172:
6046                     ; 1065 	else umax_cnt=0;
6048  10b6 5f            	clrw	x
6049  10b7 bf66          	ldw	_umax_cnt,x
6050  10b9               L5172:
6051                     ; 1066 	gran(&umax_cnt,0,10);
6053  10b9 ae000a        	ldw	x,#10
6054  10bc 89            	pushw	x
6055  10bd 5f            	clrw	x
6056  10be 89            	pushw	x
6057  10bf ae0066        	ldw	x,#_umax_cnt
6058  10c2 cd00d1        	call	_gran
6060  10c5 5b04          	addw	sp,#4
6061                     ; 1067 	if(umax_cnt>=10)flags|=0b00001000;
6063  10c7 9c            	rvf
6064  10c8 be66          	ldw	x,_umax_cnt
6065  10ca a3000a        	cpw	x,#10
6066  10cd 2f04          	jrslt	L7172
6069  10cf 7216000b      	bset	_flags,#3
6070  10d3               L7172:
6071                     ; 1070 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6073  10d3 9c            	rvf
6074  10d4 be6b          	ldw	x,_Ui
6075  10d6 a300c8        	cpw	x,#200
6076  10d9 2e10          	jrsge	L1272
6078  10db c65005        	ld	a,20485
6079  10de a504          	bcp	a,#4
6080  10e0 2609          	jrne	L1272
6083  10e2 be64          	ldw	x,_umin_cnt
6084  10e4 1c0001        	addw	x,#1
6085  10e7 bf64          	ldw	_umin_cnt,x
6087  10e9 2003          	jra	L3272
6088  10eb               L1272:
6089                     ; 1071 	else umin_cnt=0;
6091  10eb 5f            	clrw	x
6092  10ec bf64          	ldw	_umin_cnt,x
6093  10ee               L3272:
6094                     ; 1072 	gran(&umin_cnt,0,10);	
6096  10ee ae000a        	ldw	x,#10
6097  10f1 89            	pushw	x
6098  10f2 5f            	clrw	x
6099  10f3 89            	pushw	x
6100  10f4 ae0064        	ldw	x,#_umin_cnt
6101  10f7 cd00d1        	call	_gran
6103  10fa 5b04          	addw	sp,#4
6104                     ; 1073 	if(umin_cnt>=10)flags|=0b00010000;	  
6106  10fc 9c            	rvf
6107  10fd be64          	ldw	x,_umin_cnt
6108  10ff a3000a        	cpw	x,#10
6109  1102 2f04          	jrslt	L7072
6112  1104 7218000b      	bset	_flags,#4
6113  1108               L7072:
6114                     ; 1075 }
6117  1108 81            	ret
6144                     ; 1078 void x_drv(void)
6144                     ; 1079 {
6145                     	switch	.text
6146  1109               _x_drv:
6150                     ; 1080 if(_x__==_x_)
6152  1109 be5c          	ldw	x,__x__
6153  110b b35e          	cpw	x,__x_
6154  110d 262a          	jrne	L7372
6155                     ; 1082 	if(_x_cnt<60)
6157  110f 9c            	rvf
6158  1110 be5a          	ldw	x,__x_cnt
6159  1112 a3003c        	cpw	x,#60
6160  1115 2e25          	jrsge	L7472
6161                     ; 1084 		_x_cnt++;
6163  1117 be5a          	ldw	x,__x_cnt
6164  1119 1c0001        	addw	x,#1
6165  111c bf5a          	ldw	__x_cnt,x
6166                     ; 1085 		if(_x_cnt>=60)
6168  111e 9c            	rvf
6169  111f be5a          	ldw	x,__x_cnt
6170  1121 a3003c        	cpw	x,#60
6171  1124 2f16          	jrslt	L7472
6172                     ; 1087 			if(_x_ee_!=_x_)_x_ee_=_x_;
6174  1126 ce0018        	ldw	x,__x_ee_
6175  1129 b35e          	cpw	x,__x_
6176  112b 270f          	jreq	L7472
6179  112d be5e          	ldw	x,__x_
6180  112f 89            	pushw	x
6181  1130 ae0018        	ldw	x,#__x_ee_
6182  1133 cd0000        	call	c_eewrw
6184  1136 85            	popw	x
6185  1137 2003          	jra	L7472
6186  1139               L7372:
6187                     ; 1092 else _x_cnt=0;
6189  1139 5f            	clrw	x
6190  113a bf5a          	ldw	__x_cnt,x
6191  113c               L7472:
6192                     ; 1094 if(_x_cnt>60) _x_cnt=0;	
6194  113c 9c            	rvf
6195  113d be5a          	ldw	x,__x_cnt
6196  113f a3003d        	cpw	x,#61
6197  1142 2f03          	jrslt	L1572
6200  1144 5f            	clrw	x
6201  1145 bf5a          	ldw	__x_cnt,x
6202  1147               L1572:
6203                     ; 1096 _x__=_x_;
6205  1147 be5e          	ldw	x,__x_
6206  1149 bf5c          	ldw	__x__,x
6207                     ; 1097 }
6210  114b 81            	ret
6236                     ; 1100 void apv_start(void)
6236                     ; 1101 {
6237                     	switch	.text
6238  114c               _apv_start:
6242                     ; 1102 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6244  114c 3d45          	tnz	_apv_cnt
6245  114e 2624          	jrne	L3672
6247  1150 3d46          	tnz	_apv_cnt+1
6248  1152 2620          	jrne	L3672
6250  1154 3d47          	tnz	_apv_cnt+2
6251  1156 261c          	jrne	L3672
6253                     	btst	_bAPV
6254  115d 2515          	jrult	L3672
6255                     ; 1104 	apv_cnt[0]=60;
6257  115f 353c0045      	mov	_apv_cnt,#60
6258                     ; 1105 	apv_cnt[1]=60;
6260  1163 353c0046      	mov	_apv_cnt+1,#60
6261                     ; 1106 	apv_cnt[2]=60;
6263  1167 353c0047      	mov	_apv_cnt+2,#60
6264                     ; 1107 	apv_cnt_=3600;
6266  116b ae0e10        	ldw	x,#3600
6267  116e bf43          	ldw	_apv_cnt_,x
6268                     ; 1108 	bAPV=1;	
6270  1170 72100002      	bset	_bAPV
6271  1174               L3672:
6272                     ; 1110 }
6275  1174 81            	ret
6301                     ; 1113 void apv_stop(void)
6301                     ; 1114 {
6302                     	switch	.text
6303  1175               _apv_stop:
6307                     ; 1115 apv_cnt[0]=0;
6309  1175 3f45          	clr	_apv_cnt
6310                     ; 1116 apv_cnt[1]=0;
6312  1177 3f46          	clr	_apv_cnt+1
6313                     ; 1117 apv_cnt[2]=0;
6315  1179 3f47          	clr	_apv_cnt+2
6316                     ; 1118 apv_cnt_=0;	
6318  117b 5f            	clrw	x
6319  117c bf43          	ldw	_apv_cnt_,x
6320                     ; 1119 bAPV=0;
6322  117e 72110002      	bres	_bAPV
6323                     ; 1120 }
6326  1182 81            	ret
6361                     ; 1124 void apv_hndl(void)
6361                     ; 1125 {
6362                     	switch	.text
6363  1183               _apv_hndl:
6367                     ; 1126 if(apv_cnt[0])
6369  1183 3d45          	tnz	_apv_cnt
6370  1185 271e          	jreq	L5003
6371                     ; 1128 	apv_cnt[0]--;
6373  1187 3a45          	dec	_apv_cnt
6374                     ; 1129 	if(apv_cnt[0]==0)
6376  1189 3d45          	tnz	_apv_cnt
6377  118b 265a          	jrne	L1103
6378                     ; 1131 		flags&=0b11100001;
6380  118d b60b          	ld	a,_flags
6381  118f a4e1          	and	a,#225
6382  1191 b70b          	ld	_flags,a
6383                     ; 1132 		tsign_cnt=0;
6385  1193 5f            	clrw	x
6386  1194 bf4d          	ldw	_tsign_cnt,x
6387                     ; 1133 		tmax_cnt=0;
6389  1196 5f            	clrw	x
6390  1197 bf4b          	ldw	_tmax_cnt,x
6391                     ; 1134 		umax_cnt=0;
6393  1199 5f            	clrw	x
6394  119a bf66          	ldw	_umax_cnt,x
6395                     ; 1135 		umin_cnt=0;
6397  119c 5f            	clrw	x
6398  119d bf64          	ldw	_umin_cnt,x
6399                     ; 1137 		led_drv_cnt=30;
6401  119f 351e001c      	mov	_led_drv_cnt,#30
6402  11a3 2042          	jra	L1103
6403  11a5               L5003:
6404                     ; 1140 else if(apv_cnt[1])
6406  11a5 3d46          	tnz	_apv_cnt+1
6407  11a7 271e          	jreq	L3103
6408                     ; 1142 	apv_cnt[1]--;
6410  11a9 3a46          	dec	_apv_cnt+1
6411                     ; 1143 	if(apv_cnt[1]==0)
6413  11ab 3d46          	tnz	_apv_cnt+1
6414  11ad 2638          	jrne	L1103
6415                     ; 1145 		flags&=0b11100001;
6417  11af b60b          	ld	a,_flags
6418  11b1 a4e1          	and	a,#225
6419  11b3 b70b          	ld	_flags,a
6420                     ; 1146 		tsign_cnt=0;
6422  11b5 5f            	clrw	x
6423  11b6 bf4d          	ldw	_tsign_cnt,x
6424                     ; 1147 		tmax_cnt=0;
6426  11b8 5f            	clrw	x
6427  11b9 bf4b          	ldw	_tmax_cnt,x
6428                     ; 1148 		umax_cnt=0;
6430  11bb 5f            	clrw	x
6431  11bc bf66          	ldw	_umax_cnt,x
6432                     ; 1149 		umin_cnt=0;
6434  11be 5f            	clrw	x
6435  11bf bf64          	ldw	_umin_cnt,x
6436                     ; 1151 		led_drv_cnt=30;
6438  11c1 351e001c      	mov	_led_drv_cnt,#30
6439  11c5 2020          	jra	L1103
6440  11c7               L3103:
6441                     ; 1154 else if(apv_cnt[2])
6443  11c7 3d47          	tnz	_apv_cnt+2
6444  11c9 271c          	jreq	L1103
6445                     ; 1156 	apv_cnt[2]--;
6447  11cb 3a47          	dec	_apv_cnt+2
6448                     ; 1157 	if(apv_cnt[2]==0)
6450  11cd 3d47          	tnz	_apv_cnt+2
6451  11cf 2616          	jrne	L1103
6452                     ; 1159 		flags&=0b11100001;
6454  11d1 b60b          	ld	a,_flags
6455  11d3 a4e1          	and	a,#225
6456  11d5 b70b          	ld	_flags,a
6457                     ; 1160 		tsign_cnt=0;
6459  11d7 5f            	clrw	x
6460  11d8 bf4d          	ldw	_tsign_cnt,x
6461                     ; 1161 		tmax_cnt=0;
6463  11da 5f            	clrw	x
6464  11db bf4b          	ldw	_tmax_cnt,x
6465                     ; 1162 		umax_cnt=0;
6467  11dd 5f            	clrw	x
6468  11de bf66          	ldw	_umax_cnt,x
6469                     ; 1163 		umin_cnt=0;          
6471  11e0 5f            	clrw	x
6472  11e1 bf64          	ldw	_umin_cnt,x
6473                     ; 1165 		led_drv_cnt=30;
6475  11e3 351e001c      	mov	_led_drv_cnt,#30
6476  11e7               L1103:
6477                     ; 1169 if(apv_cnt_)
6479  11e7 be43          	ldw	x,_apv_cnt_
6480  11e9 2712          	jreq	L5203
6481                     ; 1171 	apv_cnt_--;
6483  11eb be43          	ldw	x,_apv_cnt_
6484  11ed 1d0001        	subw	x,#1
6485  11f0 bf43          	ldw	_apv_cnt_,x
6486                     ; 1172 	if(apv_cnt_==0) 
6488  11f2 be43          	ldw	x,_apv_cnt_
6489  11f4 2607          	jrne	L5203
6490                     ; 1174 		bAPV=0;
6492  11f6 72110002      	bres	_bAPV
6493                     ; 1175 		apv_start();
6495  11fa cd114c        	call	_apv_start
6497  11fd               L5203:
6498                     ; 1179 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6500  11fd be64          	ldw	x,_umin_cnt
6501  11ff 261e          	jrne	L1303
6503  1201 be66          	ldw	x,_umax_cnt
6504  1203 261a          	jrne	L1303
6506  1205 c65005        	ld	a,20485
6507  1208 a504          	bcp	a,#4
6508  120a 2613          	jrne	L1303
6509                     ; 1181 	if(cnt_apv_off<20)
6511  120c b642          	ld	a,_cnt_apv_off
6512  120e a114          	cp	a,#20
6513  1210 240f          	jruge	L7303
6514                     ; 1183 		cnt_apv_off++;
6516  1212 3c42          	inc	_cnt_apv_off
6517                     ; 1184 		if(cnt_apv_off>=20)
6519  1214 b642          	ld	a,_cnt_apv_off
6520  1216 a114          	cp	a,#20
6521  1218 2507          	jrult	L7303
6522                     ; 1186 			apv_stop();
6524  121a cd1175        	call	_apv_stop
6526  121d 2002          	jra	L7303
6527  121f               L1303:
6528                     ; 1190 else cnt_apv_off=0;	
6530  121f 3f42          	clr	_cnt_apv_off
6531  1221               L7303:
6532                     ; 1192 }
6535  1221 81            	ret
6538                     	switch	.ubsct
6539  0000               L1403_flags_old:
6540  0000 00            	ds.b	1
6576                     ; 1195 void flags_drv(void)
6576                     ; 1196 {
6577                     	switch	.text
6578  1222               _flags_drv:
6582                     ; 1198 if(jp_mode!=jp3) 
6584  1222 b64a          	ld	a,_jp_mode
6585  1224 a103          	cp	a,#3
6586  1226 2723          	jreq	L1603
6587                     ; 1200 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6589  1228 b60b          	ld	a,_flags
6590  122a a508          	bcp	a,#8
6591  122c 2706          	jreq	L7603
6593  122e b600          	ld	a,L1403_flags_old
6594  1230 a508          	bcp	a,#8
6595  1232 270c          	jreq	L5603
6596  1234               L7603:
6598  1234 b60b          	ld	a,_flags
6599  1236 a510          	bcp	a,#16
6600  1238 2726          	jreq	L3703
6602  123a b600          	ld	a,L1403_flags_old
6603  123c a510          	bcp	a,#16
6604  123e 2620          	jrne	L3703
6605  1240               L5603:
6606                     ; 1202     		if(link==OFF)apv_start();
6608  1240 b663          	ld	a,_link
6609  1242 a1aa          	cp	a,#170
6610  1244 261a          	jrne	L3703
6613  1246 cd114c        	call	_apv_start
6615  1249 2015          	jra	L3703
6616  124b               L1603:
6617                     ; 1205 else if(jp_mode==jp3) 
6619  124b b64a          	ld	a,_jp_mode
6620  124d a103          	cp	a,#3
6621  124f 260f          	jrne	L3703
6622                     ; 1207 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6624  1251 b60b          	ld	a,_flags
6625  1253 a508          	bcp	a,#8
6626  1255 2709          	jreq	L3703
6628  1257 b600          	ld	a,L1403_flags_old
6629  1259 a508          	bcp	a,#8
6630  125b 2603          	jrne	L3703
6631                     ; 1209     		apv_start();
6633  125d cd114c        	call	_apv_start
6635  1260               L3703:
6636                     ; 1212 flags_old=flags;
6638  1260 450b00        	mov	L1403_flags_old,_flags
6639                     ; 1214 } 
6642  1263 81            	ret
6677                     ; 1351 void adr_drv_v4(char in)
6677                     ; 1352 {
6678                     	switch	.text
6679  1264               _adr_drv_v4:
6683                     ; 1353 if(adress!=in)adress=in;
6685  1264 c10005        	cp	a,_adress
6686  1267 2703          	jreq	L7113
6689  1269 c70005        	ld	_adress,a
6690  126c               L7113:
6691                     ; 1354 }
6694  126c 81            	ret
6723                     ; 1357 void adr_drv_v3(void)
6723                     ; 1358 {
6724                     	switch	.text
6725  126d               _adr_drv_v3:
6727  126d 88            	push	a
6728       00000001      OFST:	set	1
6731                     ; 1364 GPIOB->DDR&=~(1<<0);
6733  126e 72115007      	bres	20487,#0
6734                     ; 1365 GPIOB->CR1&=~(1<<0);
6736  1272 72115008      	bres	20488,#0
6737                     ; 1366 GPIOB->CR2&=~(1<<0);
6739  1276 72115009      	bres	20489,#0
6740                     ; 1367 ADC2->CR2=0x08;
6742  127a 35085402      	mov	21506,#8
6743                     ; 1368 ADC2->CR1=0x40;
6745  127e 35405401      	mov	21505,#64
6746                     ; 1369 ADC2->CSR=0x20+0;
6748  1282 35205400      	mov	21504,#32
6749                     ; 1370 ADC2->CR1|=1;
6751  1286 72105401      	bset	21505,#0
6752                     ; 1371 ADC2->CR1|=1;
6754  128a 72105401      	bset	21505,#0
6755                     ; 1372 adr_drv_stat=1;
6757  128e 35010008      	mov	_adr_drv_stat,#1
6758  1292               L1313:
6759                     ; 1373 while(adr_drv_stat==1);
6762  1292 b608          	ld	a,_adr_drv_stat
6763  1294 a101          	cp	a,#1
6764  1296 27fa          	jreq	L1313
6765                     ; 1375 GPIOB->DDR&=~(1<<1);
6767  1298 72135007      	bres	20487,#1
6768                     ; 1376 GPIOB->CR1&=~(1<<1);
6770  129c 72135008      	bres	20488,#1
6771                     ; 1377 GPIOB->CR2&=~(1<<1);
6773  12a0 72135009      	bres	20489,#1
6774                     ; 1378 ADC2->CR2=0x08;
6776  12a4 35085402      	mov	21506,#8
6777                     ; 1379 ADC2->CR1=0x40;
6779  12a8 35405401      	mov	21505,#64
6780                     ; 1380 ADC2->CSR=0x20+1;
6782  12ac 35215400      	mov	21504,#33
6783                     ; 1381 ADC2->CR1|=1;
6785  12b0 72105401      	bset	21505,#0
6786                     ; 1382 ADC2->CR1|=1;
6788  12b4 72105401      	bset	21505,#0
6789                     ; 1383 adr_drv_stat=3;
6791  12b8 35030008      	mov	_adr_drv_stat,#3
6792  12bc               L7313:
6793                     ; 1384 while(adr_drv_stat==3);
6796  12bc b608          	ld	a,_adr_drv_stat
6797  12be a103          	cp	a,#3
6798  12c0 27fa          	jreq	L7313
6799                     ; 1386 GPIOE->DDR&=~(1<<6);
6801  12c2 721d5016      	bres	20502,#6
6802                     ; 1387 GPIOE->CR1&=~(1<<6);
6804  12c6 721d5017      	bres	20503,#6
6805                     ; 1388 GPIOE->CR2&=~(1<<6);
6807  12ca 721d5018      	bres	20504,#6
6808                     ; 1389 ADC2->CR2=0x08;
6810  12ce 35085402      	mov	21506,#8
6811                     ; 1390 ADC2->CR1=0x40;
6813  12d2 35405401      	mov	21505,#64
6814                     ; 1391 ADC2->CSR=0x20+9;
6816  12d6 35295400      	mov	21504,#41
6817                     ; 1392 ADC2->CR1|=1;
6819  12da 72105401      	bset	21505,#0
6820                     ; 1393 ADC2->CR1|=1;
6822  12de 72105401      	bset	21505,#0
6823                     ; 1394 adr_drv_stat=5;
6825  12e2 35050008      	mov	_adr_drv_stat,#5
6826  12e6               L5413:
6827                     ; 1395 while(adr_drv_stat==5);
6830  12e6 b608          	ld	a,_adr_drv_stat
6831  12e8 a105          	cp	a,#5
6832  12ea 27fa          	jreq	L5413
6833                     ; 1399 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6835  12ec 9c            	rvf
6836  12ed ce0009        	ldw	x,_adc_buff_
6837  12f0 a3022a        	cpw	x,#554
6838  12f3 2f0f          	jrslt	L3513
6840  12f5 9c            	rvf
6841  12f6 ce0009        	ldw	x,_adc_buff_
6842  12f9 a30253        	cpw	x,#595
6843  12fc 2e06          	jrsge	L3513
6846  12fe 725f0006      	clr	_adr
6848  1302 204c          	jra	L5513
6849  1304               L3513:
6850                     ; 1400 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6852  1304 9c            	rvf
6853  1305 ce0009        	ldw	x,_adc_buff_
6854  1308 a3036d        	cpw	x,#877
6855  130b 2f0f          	jrslt	L7513
6857  130d 9c            	rvf
6858  130e ce0009        	ldw	x,_adc_buff_
6859  1311 a30396        	cpw	x,#918
6860  1314 2e06          	jrsge	L7513
6863  1316 35010006      	mov	_adr,#1
6865  131a 2034          	jra	L5513
6866  131c               L7513:
6867                     ; 1401 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6869  131c 9c            	rvf
6870  131d ce0009        	ldw	x,_adc_buff_
6871  1320 a302a3        	cpw	x,#675
6872  1323 2f0f          	jrslt	L3613
6874  1325 9c            	rvf
6875  1326 ce0009        	ldw	x,_adc_buff_
6876  1329 a302cc        	cpw	x,#716
6877  132c 2e06          	jrsge	L3613
6880  132e 35020006      	mov	_adr,#2
6882  1332 201c          	jra	L5513
6883  1334               L3613:
6884                     ; 1402 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6886  1334 9c            	rvf
6887  1335 ce0009        	ldw	x,_adc_buff_
6888  1338 a303e3        	cpw	x,#995
6889  133b 2f0f          	jrslt	L7613
6891  133d 9c            	rvf
6892  133e ce0009        	ldw	x,_adc_buff_
6893  1341 a3040c        	cpw	x,#1036
6894  1344 2e06          	jrsge	L7613
6897  1346 35030006      	mov	_adr,#3
6899  134a 2004          	jra	L5513
6900  134c               L7613:
6901                     ; 1403 else adr[0]=5;
6903  134c 35050006      	mov	_adr,#5
6904  1350               L5513:
6905                     ; 1405 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6907  1350 9c            	rvf
6908  1351 ce000b        	ldw	x,_adc_buff_+2
6909  1354 a3022a        	cpw	x,#554
6910  1357 2f0f          	jrslt	L3713
6912  1359 9c            	rvf
6913  135a ce000b        	ldw	x,_adc_buff_+2
6914  135d a30253        	cpw	x,#595
6915  1360 2e06          	jrsge	L3713
6918  1362 725f0007      	clr	_adr+1
6920  1366 204c          	jra	L5713
6921  1368               L3713:
6922                     ; 1406 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6924  1368 9c            	rvf
6925  1369 ce000b        	ldw	x,_adc_buff_+2
6926  136c a3036d        	cpw	x,#877
6927  136f 2f0f          	jrslt	L7713
6929  1371 9c            	rvf
6930  1372 ce000b        	ldw	x,_adc_buff_+2
6931  1375 a30396        	cpw	x,#918
6932  1378 2e06          	jrsge	L7713
6935  137a 35010007      	mov	_adr+1,#1
6937  137e 2034          	jra	L5713
6938  1380               L7713:
6939                     ; 1407 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6941  1380 9c            	rvf
6942  1381 ce000b        	ldw	x,_adc_buff_+2
6943  1384 a302a3        	cpw	x,#675
6944  1387 2f0f          	jrslt	L3023
6946  1389 9c            	rvf
6947  138a ce000b        	ldw	x,_adc_buff_+2
6948  138d a302cc        	cpw	x,#716
6949  1390 2e06          	jrsge	L3023
6952  1392 35020007      	mov	_adr+1,#2
6954  1396 201c          	jra	L5713
6955  1398               L3023:
6956                     ; 1408 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6958  1398 9c            	rvf
6959  1399 ce000b        	ldw	x,_adc_buff_+2
6960  139c a303e3        	cpw	x,#995
6961  139f 2f0f          	jrslt	L7023
6963  13a1 9c            	rvf
6964  13a2 ce000b        	ldw	x,_adc_buff_+2
6965  13a5 a3040c        	cpw	x,#1036
6966  13a8 2e06          	jrsge	L7023
6969  13aa 35030007      	mov	_adr+1,#3
6971  13ae 2004          	jra	L5713
6972  13b0               L7023:
6973                     ; 1409 else adr[1]=5;
6975  13b0 35050007      	mov	_adr+1,#5
6976  13b4               L5713:
6977                     ; 1411 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6979  13b4 9c            	rvf
6980  13b5 ce001b        	ldw	x,_adc_buff_+18
6981  13b8 a3022a        	cpw	x,#554
6982  13bb 2f0f          	jrslt	L3123
6984  13bd 9c            	rvf
6985  13be ce001b        	ldw	x,_adc_buff_+18
6986  13c1 a30253        	cpw	x,#595
6987  13c4 2e06          	jrsge	L3123
6990  13c6 725f0008      	clr	_adr+2
6992  13ca 204c          	jra	L5123
6993  13cc               L3123:
6994                     ; 1412 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6996  13cc 9c            	rvf
6997  13cd ce001b        	ldw	x,_adc_buff_+18
6998  13d0 a3036d        	cpw	x,#877
6999  13d3 2f0f          	jrslt	L7123
7001  13d5 9c            	rvf
7002  13d6 ce001b        	ldw	x,_adc_buff_+18
7003  13d9 a30396        	cpw	x,#918
7004  13dc 2e06          	jrsge	L7123
7007  13de 35010008      	mov	_adr+2,#1
7009  13e2 2034          	jra	L5123
7010  13e4               L7123:
7011                     ; 1413 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
7013  13e4 9c            	rvf
7014  13e5 ce001b        	ldw	x,_adc_buff_+18
7015  13e8 a302a3        	cpw	x,#675
7016  13eb 2f0f          	jrslt	L3223
7018  13ed 9c            	rvf
7019  13ee ce001b        	ldw	x,_adc_buff_+18
7020  13f1 a302cc        	cpw	x,#716
7021  13f4 2e06          	jrsge	L3223
7024  13f6 35020008      	mov	_adr+2,#2
7026  13fa 201c          	jra	L5123
7027  13fc               L3223:
7028                     ; 1414 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
7030  13fc 9c            	rvf
7031  13fd ce001b        	ldw	x,_adc_buff_+18
7032  1400 a303e3        	cpw	x,#995
7033  1403 2f0f          	jrslt	L7223
7035  1405 9c            	rvf
7036  1406 ce001b        	ldw	x,_adc_buff_+18
7037  1409 a3040c        	cpw	x,#1036
7038  140c 2e06          	jrsge	L7223
7041  140e 35030008      	mov	_adr+2,#3
7043  1412 2004          	jra	L5123
7044  1414               L7223:
7045                     ; 1415 else adr[2]=5;
7047  1414 35050008      	mov	_adr+2,#5
7048  1418               L5123:
7049                     ; 1419 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
7051  1418 c60006        	ld	a,_adr
7052  141b a105          	cp	a,#5
7053  141d 270e          	jreq	L5323
7055  141f c60007        	ld	a,_adr+1
7056  1422 a105          	cp	a,#5
7057  1424 2707          	jreq	L5323
7059  1426 c60008        	ld	a,_adr+2
7060  1429 a105          	cp	a,#5
7061  142b 2606          	jrne	L3323
7062  142d               L5323:
7063                     ; 1422 	adress_error=1;
7065  142d 35010004      	mov	_adress_error,#1
7067  1431               L1423:
7068                     ; 1433 }
7071  1431 84            	pop	a
7072  1432 81            	ret
7073  1433               L3323:
7074                     ; 1426 	if(adr[2]&0x02) bps_class=bpsIPS;
7076  1433 c60008        	ld	a,_adr+2
7077  1436 a502          	bcp	a,#2
7078  1438 2706          	jreq	L3423
7081  143a 35010004      	mov	_bps_class,#1
7083  143e 2002          	jra	L5423
7084  1440               L3423:
7085                     ; 1427 	else bps_class=bpsIBEP;
7087  1440 3f04          	clr	_bps_class
7088  1442               L5423:
7089                     ; 1429 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
7091  1442 c60008        	ld	a,_adr+2
7092  1445 a401          	and	a,#1
7093  1447 97            	ld	xl,a
7094  1448 a610          	ld	a,#16
7095  144a 42            	mul	x,a
7096  144b 9f            	ld	a,xl
7097  144c 6b01          	ld	(OFST+0,sp),a
7098  144e c60007        	ld	a,_adr+1
7099  1451 48            	sll	a
7100  1452 48            	sll	a
7101  1453 cb0006        	add	a,_adr
7102  1456 1b01          	add	a,(OFST+0,sp)
7103  1458 c70005        	ld	_adress,a
7104  145b 20d4          	jra	L1423
7148                     ; 1436 void volum_u_main_drv(void)
7148                     ; 1437 {
7149                     	switch	.text
7150  145d               _volum_u_main_drv:
7152  145d 88            	push	a
7153       00000001      OFST:	set	1
7156                     ; 1440 if(bMAIN)
7158                     	btst	_bMAIN
7159  1463 2503          	jrult	L041
7160  1465 cc15ae        	jp	L5623
7161  1468               L041:
7162                     ; 1442 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7164  1468 9c            	rvf
7165  1469 ce0008        	ldw	x,_UU_AVT
7166  146c 1d000a        	subw	x,#10
7167  146f b36d          	cpw	x,_Un
7168  1471 2d09          	jrsle	L7623
7171  1473 be1f          	ldw	x,_volum_u_main_
7172  1475 1c0005        	addw	x,#5
7173  1478 bf1f          	ldw	_volum_u_main_,x
7175  147a 2036          	jra	L1723
7176  147c               L7623:
7177                     ; 1443 	else if(Un<(UU_AVT-1))volum_u_main_++;
7179  147c 9c            	rvf
7180  147d ce0008        	ldw	x,_UU_AVT
7181  1480 5a            	decw	x
7182  1481 b36d          	cpw	x,_Un
7183  1483 2d09          	jrsle	L3723
7186  1485 be1f          	ldw	x,_volum_u_main_
7187  1487 1c0001        	addw	x,#1
7188  148a bf1f          	ldw	_volum_u_main_,x
7190  148c 2024          	jra	L1723
7191  148e               L3723:
7192                     ; 1444 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7194  148e 9c            	rvf
7195  148f ce0008        	ldw	x,_UU_AVT
7196  1492 1c000a        	addw	x,#10
7197  1495 b36d          	cpw	x,_Un
7198  1497 2e09          	jrsge	L7723
7201  1499 be1f          	ldw	x,_volum_u_main_
7202  149b 1d000a        	subw	x,#10
7203  149e bf1f          	ldw	_volum_u_main_,x
7205  14a0 2010          	jra	L1723
7206  14a2               L7723:
7207                     ; 1445 	else if(Un>(UU_AVT+1))volum_u_main_--;
7209  14a2 9c            	rvf
7210  14a3 ce0008        	ldw	x,_UU_AVT
7211  14a6 5c            	incw	x
7212  14a7 b36d          	cpw	x,_Un
7213  14a9 2e07          	jrsge	L1723
7216  14ab be1f          	ldw	x,_volum_u_main_
7217  14ad 1d0001        	subw	x,#1
7218  14b0 bf1f          	ldw	_volum_u_main_,x
7219  14b2               L1723:
7220                     ; 1446 	if(volum_u_main_>1020)volum_u_main_=1020;
7222  14b2 9c            	rvf
7223  14b3 be1f          	ldw	x,_volum_u_main_
7224  14b5 a303fd        	cpw	x,#1021
7225  14b8 2f05          	jrslt	L5033
7228  14ba ae03fc        	ldw	x,#1020
7229  14bd bf1f          	ldw	_volum_u_main_,x
7230  14bf               L5033:
7231                     ; 1447 	if(volum_u_main_<0)volum_u_main_=0;
7233  14bf 9c            	rvf
7234  14c0 be1f          	ldw	x,_volum_u_main_
7235  14c2 2e03          	jrsge	L7033
7238  14c4 5f            	clrw	x
7239  14c5 bf1f          	ldw	_volum_u_main_,x
7240  14c7               L7033:
7241                     ; 1450 	i_main_sigma=0;
7243  14c7 5f            	clrw	x
7244  14c8 bf0f          	ldw	_i_main_sigma,x
7245                     ; 1451 	i_main_num_of_bps=0;
7247  14ca 3f11          	clr	_i_main_num_of_bps
7248                     ; 1452 	for(i=0;i<6;i++)
7250  14cc 0f01          	clr	(OFST+0,sp)
7251  14ce               L1133:
7252                     ; 1454 		if(i_main_flag[i])
7254  14ce 7b01          	ld	a,(OFST+0,sp)
7255  14d0 5f            	clrw	x
7256  14d1 97            	ld	xl,a
7257  14d2 6d14          	tnz	(_i_main_flag,x)
7258  14d4 2719          	jreq	L7133
7259                     ; 1456 			i_main_sigma+=i_main[i];
7261  14d6 7b01          	ld	a,(OFST+0,sp)
7262  14d8 5f            	clrw	x
7263  14d9 97            	ld	xl,a
7264  14da 58            	sllw	x
7265  14db ee1a          	ldw	x,(_i_main,x)
7266  14dd 72bb000f      	addw	x,_i_main_sigma
7267  14e1 bf0f          	ldw	_i_main_sigma,x
7268                     ; 1457 			i_main_flag[i]=1;
7270  14e3 7b01          	ld	a,(OFST+0,sp)
7271  14e5 5f            	clrw	x
7272  14e6 97            	ld	xl,a
7273  14e7 a601          	ld	a,#1
7274  14e9 e714          	ld	(_i_main_flag,x),a
7275                     ; 1458 			i_main_num_of_bps++;
7277  14eb 3c11          	inc	_i_main_num_of_bps
7279  14ed 2006          	jra	L1233
7280  14ef               L7133:
7281                     ; 1462 			i_main_flag[i]=0;	
7283  14ef 7b01          	ld	a,(OFST+0,sp)
7284  14f1 5f            	clrw	x
7285  14f2 97            	ld	xl,a
7286  14f3 6f14          	clr	(_i_main_flag,x)
7287  14f5               L1233:
7288                     ; 1452 	for(i=0;i<6;i++)
7290  14f5 0c01          	inc	(OFST+0,sp)
7293  14f7 7b01          	ld	a,(OFST+0,sp)
7294  14f9 a106          	cp	a,#6
7295  14fb 25d1          	jrult	L1133
7296                     ; 1465 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7298  14fd be0f          	ldw	x,_i_main_sigma
7299  14ff b611          	ld	a,_i_main_num_of_bps
7300  1501 905f          	clrw	y
7301  1503 9097          	ld	yl,a
7302  1505 cd0000        	call	c_idiv
7304  1508 bf12          	ldw	_i_main_avg,x
7305                     ; 1466 	for(i=0;i<6;i++)
7307  150a 0f01          	clr	(OFST+0,sp)
7308  150c               L3233:
7309                     ; 1468 		if(i_main_flag[i])
7311  150c 7b01          	ld	a,(OFST+0,sp)
7312  150e 5f            	clrw	x
7313  150f 97            	ld	xl,a
7314  1510 6d14          	tnz	(_i_main_flag,x)
7315  1512 2603cc15a3    	jreq	L1333
7316                     ; 1470 			if(i_main[i]<(i_main_avg-10))x[i]++;
7318  1517 9c            	rvf
7319  1518 7b01          	ld	a,(OFST+0,sp)
7320  151a 5f            	clrw	x
7321  151b 97            	ld	xl,a
7322  151c 58            	sllw	x
7323  151d 90be12        	ldw	y,_i_main_avg
7324  1520 72a2000a      	subw	y,#10
7325  1524 90bf00        	ldw	c_y,y
7326  1527 9093          	ldw	y,x
7327  1529 90ee1a        	ldw	y,(_i_main,y)
7328  152c 90b300        	cpw	y,c_y
7329  152f 2e11          	jrsge	L3333
7332  1531 7b01          	ld	a,(OFST+0,sp)
7333  1533 5f            	clrw	x
7334  1534 97            	ld	xl,a
7335  1535 58            	sllw	x
7336  1536 9093          	ldw	y,x
7337  1538 ee26          	ldw	x,(_x,x)
7338  153a 1c0001        	addw	x,#1
7339  153d 90ef26        	ldw	(_x,y),x
7341  1540 2029          	jra	L5333
7342  1542               L3333:
7343                     ; 1471 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7345  1542 9c            	rvf
7346  1543 7b01          	ld	a,(OFST+0,sp)
7347  1545 5f            	clrw	x
7348  1546 97            	ld	xl,a
7349  1547 58            	sllw	x
7350  1548 90be12        	ldw	y,_i_main_avg
7351  154b 72a9000a      	addw	y,#10
7352  154f 90bf00        	ldw	c_y,y
7353  1552 9093          	ldw	y,x
7354  1554 90ee1a        	ldw	y,(_i_main,y)
7355  1557 90b300        	cpw	y,c_y
7356  155a 2d0f          	jrsle	L5333
7359  155c 7b01          	ld	a,(OFST+0,sp)
7360  155e 5f            	clrw	x
7361  155f 97            	ld	xl,a
7362  1560 58            	sllw	x
7363  1561 9093          	ldw	y,x
7364  1563 ee26          	ldw	x,(_x,x)
7365  1565 1d0001        	subw	x,#1
7366  1568 90ef26        	ldw	(_x,y),x
7367  156b               L5333:
7368                     ; 1472 			if(x[i]>100)x[i]=100;
7370  156b 9c            	rvf
7371  156c 7b01          	ld	a,(OFST+0,sp)
7372  156e 5f            	clrw	x
7373  156f 97            	ld	xl,a
7374  1570 58            	sllw	x
7375  1571 9093          	ldw	y,x
7376  1573 90ee26        	ldw	y,(_x,y)
7377  1576 90a30065      	cpw	y,#101
7378  157a 2f0b          	jrslt	L1433
7381  157c 7b01          	ld	a,(OFST+0,sp)
7382  157e 5f            	clrw	x
7383  157f 97            	ld	xl,a
7384  1580 58            	sllw	x
7385  1581 90ae0064      	ldw	y,#100
7386  1585 ef26          	ldw	(_x,x),y
7387  1587               L1433:
7388                     ; 1473 			if(x[i]<-100)x[i]=-100;
7390  1587 9c            	rvf
7391  1588 7b01          	ld	a,(OFST+0,sp)
7392  158a 5f            	clrw	x
7393  158b 97            	ld	xl,a
7394  158c 58            	sllw	x
7395  158d 9093          	ldw	y,x
7396  158f 90ee26        	ldw	y,(_x,y)
7397  1592 90a3ff9c      	cpw	y,#65436
7398  1596 2e0b          	jrsge	L1333
7401  1598 7b01          	ld	a,(OFST+0,sp)
7402  159a 5f            	clrw	x
7403  159b 97            	ld	xl,a
7404  159c 58            	sllw	x
7405  159d 90aeff9c      	ldw	y,#65436
7406  15a1 ef26          	ldw	(_x,x),y
7407  15a3               L1333:
7408                     ; 1466 	for(i=0;i<6;i++)
7410  15a3 0c01          	inc	(OFST+0,sp)
7413  15a5 7b01          	ld	a,(OFST+0,sp)
7414  15a7 a106          	cp	a,#6
7415  15a9 2403cc150c    	jrult	L3233
7416  15ae               L5623:
7417                     ; 1480 }
7420  15ae 84            	pop	a
7421  15af 81            	ret
7444                     ; 1483 void init_CAN(void) {
7445                     	switch	.text
7446  15b0               _init_CAN:
7450                     ; 1484 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7452  15b0 72135420      	bres	21536,#1
7453                     ; 1485 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7455  15b4 72105420      	bset	21536,#0
7457  15b8               L7533:
7458                     ; 1486 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7460  15b8 c65421        	ld	a,21537
7461  15bb a501          	bcp	a,#1
7462  15bd 27f9          	jreq	L7533
7463                     ; 1488 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7465  15bf 72185420      	bset	21536,#4
7466                     ; 1490 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7468  15c3 35025427      	mov	21543,#2
7469                     ; 1499 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7471  15c7 35135428      	mov	21544,#19
7472                     ; 1500 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7474  15cb 35c05429      	mov	21545,#192
7475                     ; 1501 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7477  15cf 357f542c      	mov	21548,#127
7478                     ; 1502 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7480  15d3 35e0542d      	mov	21549,#224
7481                     ; 1504 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7483  15d7 35315430      	mov	21552,#49
7484                     ; 1505 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7486  15db 35c05431      	mov	21553,#192
7487                     ; 1506 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7489  15df 357f5434      	mov	21556,#127
7490                     ; 1507 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7492  15e3 35e05435      	mov	21557,#224
7493                     ; 1511 	CAN->PSR= 6;									// set page 6
7495  15e7 35065427      	mov	21543,#6
7496                     ; 1516 	CAN->Page.Config.FMR1&=~3;								//mask mode
7498  15eb c65430        	ld	a,21552
7499  15ee a4fc          	and	a,#252
7500  15f0 c75430        	ld	21552,a
7501                     ; 1522 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7503  15f3 35065432      	mov	21554,#6
7504                     ; 1523 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7506  15f7 35605432      	mov	21554,#96
7507                     ; 1526 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7509  15fb 72105432      	bset	21554,#0
7510                     ; 1527 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7512  15ff 72185432      	bset	21554,#4
7513                     ; 1530 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7515  1603 35065427      	mov	21543,#6
7516                     ; 1532 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7518  1607 3509542c      	mov	21548,#9
7519                     ; 1533 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7521  160b 35e7542d      	mov	21549,#231
7522                     ; 1535 	CAN->IER|=(1<<1);
7524  160f 72125425      	bset	21541,#1
7525                     ; 1538 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7527  1613 72115420      	bres	21536,#0
7529  1617               L5633:
7530                     ; 1539 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7532  1617 c65421        	ld	a,21537
7533  161a a501          	bcp	a,#1
7534  161c 26f9          	jrne	L5633
7535                     ; 1540 }
7538  161e 81            	ret
7646                     ; 1543 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7646                     ; 1544 {
7647                     	switch	.text
7648  161f               _can_transmit:
7650  161f 89            	pushw	x
7651       00000000      OFST:	set	0
7654                     ; 1546 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7656  1620 b674          	ld	a,_can_buff_wr_ptr
7657  1622 a104          	cp	a,#4
7658  1624 2502          	jrult	L7443
7661  1626 3f74          	clr	_can_buff_wr_ptr
7662  1628               L7443:
7663                     ; 1548 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7665  1628 b674          	ld	a,_can_buff_wr_ptr
7666  162a 97            	ld	xl,a
7667  162b a610          	ld	a,#16
7668  162d 42            	mul	x,a
7669  162e 1601          	ldw	y,(OFST+1,sp)
7670  1630 a606          	ld	a,#6
7671  1632               L641:
7672  1632 9054          	srlw	y
7673  1634 4a            	dec	a
7674  1635 26fb          	jrne	L641
7675  1637 909f          	ld	a,yl
7676  1639 e775          	ld	(_can_out_buff,x),a
7677                     ; 1549 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7679  163b b674          	ld	a,_can_buff_wr_ptr
7680  163d 97            	ld	xl,a
7681  163e a610          	ld	a,#16
7682  1640 42            	mul	x,a
7683  1641 7b02          	ld	a,(OFST+2,sp)
7684  1643 48            	sll	a
7685  1644 48            	sll	a
7686  1645 e776          	ld	(_can_out_buff+1,x),a
7687                     ; 1551 can_out_buff[can_buff_wr_ptr][2]=data0;
7689  1647 b674          	ld	a,_can_buff_wr_ptr
7690  1649 97            	ld	xl,a
7691  164a a610          	ld	a,#16
7692  164c 42            	mul	x,a
7693  164d 7b05          	ld	a,(OFST+5,sp)
7694  164f e777          	ld	(_can_out_buff+2,x),a
7695                     ; 1552 can_out_buff[can_buff_wr_ptr][3]=data1;
7697  1651 b674          	ld	a,_can_buff_wr_ptr
7698  1653 97            	ld	xl,a
7699  1654 a610          	ld	a,#16
7700  1656 42            	mul	x,a
7701  1657 7b06          	ld	a,(OFST+6,sp)
7702  1659 e778          	ld	(_can_out_buff+3,x),a
7703                     ; 1553 can_out_buff[can_buff_wr_ptr][4]=data2;
7705  165b b674          	ld	a,_can_buff_wr_ptr
7706  165d 97            	ld	xl,a
7707  165e a610          	ld	a,#16
7708  1660 42            	mul	x,a
7709  1661 7b07          	ld	a,(OFST+7,sp)
7710  1663 e779          	ld	(_can_out_buff+4,x),a
7711                     ; 1554 can_out_buff[can_buff_wr_ptr][5]=data3;
7713  1665 b674          	ld	a,_can_buff_wr_ptr
7714  1667 97            	ld	xl,a
7715  1668 a610          	ld	a,#16
7716  166a 42            	mul	x,a
7717  166b 7b08          	ld	a,(OFST+8,sp)
7718  166d e77a          	ld	(_can_out_buff+5,x),a
7719                     ; 1555 can_out_buff[can_buff_wr_ptr][6]=data4;
7721  166f b674          	ld	a,_can_buff_wr_ptr
7722  1671 97            	ld	xl,a
7723  1672 a610          	ld	a,#16
7724  1674 42            	mul	x,a
7725  1675 7b09          	ld	a,(OFST+9,sp)
7726  1677 e77b          	ld	(_can_out_buff+6,x),a
7727                     ; 1556 can_out_buff[can_buff_wr_ptr][7]=data5;
7729  1679 b674          	ld	a,_can_buff_wr_ptr
7730  167b 97            	ld	xl,a
7731  167c a610          	ld	a,#16
7732  167e 42            	mul	x,a
7733  167f 7b0a          	ld	a,(OFST+10,sp)
7734  1681 e77c          	ld	(_can_out_buff+7,x),a
7735                     ; 1557 can_out_buff[can_buff_wr_ptr][8]=data6;
7737  1683 b674          	ld	a,_can_buff_wr_ptr
7738  1685 97            	ld	xl,a
7739  1686 a610          	ld	a,#16
7740  1688 42            	mul	x,a
7741  1689 7b0b          	ld	a,(OFST+11,sp)
7742  168b e77d          	ld	(_can_out_buff+8,x),a
7743                     ; 1558 can_out_buff[can_buff_wr_ptr][9]=data7;
7745  168d b674          	ld	a,_can_buff_wr_ptr
7746  168f 97            	ld	xl,a
7747  1690 a610          	ld	a,#16
7748  1692 42            	mul	x,a
7749  1693 7b0c          	ld	a,(OFST+12,sp)
7750  1695 e77e          	ld	(_can_out_buff+9,x),a
7751                     ; 1560 can_buff_wr_ptr++;
7753  1697 3c74          	inc	_can_buff_wr_ptr
7754                     ; 1561 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7756  1699 b674          	ld	a,_can_buff_wr_ptr
7757  169b a104          	cp	a,#4
7758  169d 2502          	jrult	L1543
7761  169f 3f74          	clr	_can_buff_wr_ptr
7762  16a1               L1543:
7763                     ; 1562 } 
7766  16a1 85            	popw	x
7767  16a2 81            	ret
7796                     ; 1565 void can_tx_hndl(void)
7796                     ; 1566 {
7797                     	switch	.text
7798  16a3               _can_tx_hndl:
7802                     ; 1567 if(bTX_FREE)
7804  16a3 3d09          	tnz	_bTX_FREE
7805  16a5 2757          	jreq	L3643
7806                     ; 1569 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7808  16a7 b673          	ld	a,_can_buff_rd_ptr
7809  16a9 b174          	cp	a,_can_buff_wr_ptr
7810  16ab 275f          	jreq	L1743
7811                     ; 1571 		bTX_FREE=0;
7813  16ad 3f09          	clr	_bTX_FREE
7814                     ; 1573 		CAN->PSR= 0;
7816  16af 725f5427      	clr	21543
7817                     ; 1574 		CAN->Page.TxMailbox.MDLCR=8;
7819  16b3 35085429      	mov	21545,#8
7820                     ; 1575 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7822  16b7 b673          	ld	a,_can_buff_rd_ptr
7823  16b9 97            	ld	xl,a
7824  16ba a610          	ld	a,#16
7825  16bc 42            	mul	x,a
7826  16bd e675          	ld	a,(_can_out_buff,x)
7827  16bf c7542a        	ld	21546,a
7828                     ; 1576 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7830  16c2 b673          	ld	a,_can_buff_rd_ptr
7831  16c4 97            	ld	xl,a
7832  16c5 a610          	ld	a,#16
7833  16c7 42            	mul	x,a
7834  16c8 e676          	ld	a,(_can_out_buff+1,x)
7835  16ca c7542b        	ld	21547,a
7836                     ; 1578 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7838  16cd b673          	ld	a,_can_buff_rd_ptr
7839  16cf 97            	ld	xl,a
7840  16d0 a610          	ld	a,#16
7841  16d2 42            	mul	x,a
7842  16d3 01            	rrwa	x,a
7843  16d4 ab77          	add	a,#_can_out_buff+2
7844  16d6 2401          	jrnc	L251
7845  16d8 5c            	incw	x
7846  16d9               L251:
7847  16d9 5f            	clrw	x
7848  16da 97            	ld	xl,a
7849  16db bf00          	ldw	c_x,x
7850  16dd ae0008        	ldw	x,#8
7851  16e0               L451:
7852  16e0 5a            	decw	x
7853  16e1 92d600        	ld	a,([c_x],x)
7854  16e4 d7542e        	ld	(21550,x),a
7855  16e7 5d            	tnzw	x
7856  16e8 26f6          	jrne	L451
7857                     ; 1580 		can_buff_rd_ptr++;
7859  16ea 3c73          	inc	_can_buff_rd_ptr
7860                     ; 1581 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7862  16ec b673          	ld	a,_can_buff_rd_ptr
7863  16ee a104          	cp	a,#4
7864  16f0 2502          	jrult	L7643
7867  16f2 3f73          	clr	_can_buff_rd_ptr
7868  16f4               L7643:
7869                     ; 1583 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7871  16f4 72105428      	bset	21544,#0
7872                     ; 1584 		CAN->IER|=(1<<0);
7874  16f8 72105425      	bset	21541,#0
7875  16fc 200e          	jra	L1743
7876  16fe               L3643:
7877                     ; 1589 	tx_busy_cnt++;
7879  16fe 3c72          	inc	_tx_busy_cnt
7880                     ; 1590 	if(tx_busy_cnt>=100)
7882  1700 b672          	ld	a,_tx_busy_cnt
7883  1702 a164          	cp	a,#100
7884  1704 2506          	jrult	L1743
7885                     ; 1592 		tx_busy_cnt=0;
7887  1706 3f72          	clr	_tx_busy_cnt
7888                     ; 1593 		bTX_FREE=1;
7890  1708 35010009      	mov	_bTX_FREE,#1
7891  170c               L1743:
7892                     ; 1596 }
7895  170c 81            	ret
7934                     ; 1599 void net_drv(void)
7934                     ; 1600 { 
7935                     	switch	.text
7936  170d               _net_drv:
7940                     ; 1602 if(bMAIN)
7942                     	btst	_bMAIN
7943  1712 2503          	jrult	L061
7944  1714 cc17ba        	jp	L5053
7945  1717               L061:
7946                     ; 1604 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7948  1717 3c32          	inc	_cnt_net_drv
7949  1719 b632          	ld	a,_cnt_net_drv
7950  171b a107          	cp	a,#7
7951  171d 2502          	jrult	L7053
7954  171f 3f32          	clr	_cnt_net_drv
7955  1721               L7053:
7956                     ; 1606 	if(cnt_net_drv<=5) 
7958  1721 b632          	ld	a,_cnt_net_drv
7959  1723 a106          	cp	a,#6
7960  1725 244c          	jruge	L1153
7961                     ; 1608 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7963  1727 4be8          	push	#232
7964  1729 4be8          	push	#232
7965  172b b632          	ld	a,_cnt_net_drv
7966  172d 5f            	clrw	x
7967  172e 97            	ld	xl,a
7968  172f 58            	sllw	x
7969  1730 ee26          	ldw	x,(_x,x)
7970  1732 72bb001f      	addw	x,_volum_u_main_
7971  1736 90ae0100      	ldw	y,#256
7972  173a cd0000        	call	c_idiv
7974  173d 9f            	ld	a,xl
7975  173e 88            	push	a
7976  173f b632          	ld	a,_cnt_net_drv
7977  1741 5f            	clrw	x
7978  1742 97            	ld	xl,a
7979  1743 58            	sllw	x
7980  1744 e627          	ld	a,(_x+1,x)
7981  1746 bb20          	add	a,_volum_u_main_+1
7982  1748 88            	push	a
7983  1749 4b00          	push	#0
7984  174b 4bed          	push	#237
7985  174d 3b0032        	push	_cnt_net_drv
7986  1750 3b0032        	push	_cnt_net_drv
7987  1753 ae009e        	ldw	x,#158
7988  1756 cd161f        	call	_can_transmit
7990  1759 5b08          	addw	sp,#8
7991                     ; 1609 		i_main_bps_cnt[cnt_net_drv]++;
7993  175b b632          	ld	a,_cnt_net_drv
7994  175d 5f            	clrw	x
7995  175e 97            	ld	xl,a
7996  175f 6c09          	inc	(_i_main_bps_cnt,x)
7997                     ; 1610 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7999  1761 b632          	ld	a,_cnt_net_drv
8000  1763 5f            	clrw	x
8001  1764 97            	ld	xl,a
8002  1765 e609          	ld	a,(_i_main_bps_cnt,x)
8003  1767 a10b          	cp	a,#11
8004  1769 254f          	jrult	L5053
8007  176b b632          	ld	a,_cnt_net_drv
8008  176d 5f            	clrw	x
8009  176e 97            	ld	xl,a
8010  176f 6f14          	clr	(_i_main_flag,x)
8011  1771 2047          	jra	L5053
8012  1773               L1153:
8013                     ; 1612 	else if(cnt_net_drv==6)
8015  1773 b632          	ld	a,_cnt_net_drv
8016  1775 a106          	cp	a,#6
8017  1777 2641          	jrne	L5053
8018                     ; 1614 		plazma_int[2]=pwm_u;
8020  1779 be0e          	ldw	x,_pwm_u
8021  177b bf37          	ldw	_plazma_int+4,x
8022                     ; 1615 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8024  177d 3b006b        	push	_Ui
8025  1780 3b006c        	push	_Ui+1
8026  1783 3b006d        	push	_Un
8027  1786 3b006e        	push	_Un+1
8028  1789 3b006f        	push	_I
8029  178c 3b0070        	push	_I+1
8030  178f 4bda          	push	#218
8031  1791 3b0005        	push	_adress
8032  1794 ae018e        	ldw	x,#398
8033  1797 cd161f        	call	_can_transmit
8035  179a 5b08          	addw	sp,#8
8036                     ; 1616 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8038  179c 3b0037        	push	_plazma_int+4
8039  179f 3b0038        	push	_plazma_int+5
8040  17a2 3b005f        	push	__x_+1
8041  17a5 3b000b        	push	_flags
8042  17a8 4b00          	push	#0
8043  17aa 3b0068        	push	_T
8044  17ad 4bdb          	push	#219
8045  17af 3b0005        	push	_adress
8046  17b2 ae018e        	ldw	x,#398
8047  17b5 cd161f        	call	_can_transmit
8049  17b8 5b08          	addw	sp,#8
8050  17ba               L5053:
8051                     ; 1619 }
8054  17ba 81            	ret
8168                     ; 1622 void can_in_an(void)
8168                     ; 1623 {
8169                     	switch	.text
8170  17bb               _can_in_an:
8172  17bb 5205          	subw	sp,#5
8173       00000005      OFST:	set	5
8176                     ; 1633 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8178  17bd b6ca          	ld	a,_mess+6
8179  17bf c10005        	cp	a,_adress
8180  17c2 2703          	jreq	L202
8181  17c4 cc18e0        	jp	L5553
8182  17c7               L202:
8184  17c7 b6cb          	ld	a,_mess+7
8185  17c9 c10005        	cp	a,_adress
8186  17cc 2703          	jreq	L402
8187  17ce cc18e0        	jp	L5553
8188  17d1               L402:
8190  17d1 b6cc          	ld	a,_mess+8
8191  17d3 a1ed          	cp	a,#237
8192  17d5 2703          	jreq	L602
8193  17d7 cc18e0        	jp	L5553
8194  17da               L602:
8195                     ; 1636 	can_error_cnt=0;
8197  17da 3f71          	clr	_can_error_cnt
8198                     ; 1638 	bMAIN=0;
8200  17dc 72110001      	bres	_bMAIN
8201                     ; 1639  	flags_tu=mess[9];
8203  17e0 45cd60        	mov	_flags_tu,_mess+9
8204                     ; 1640  	if(flags_tu&0b00000001)
8206  17e3 b660          	ld	a,_flags_tu
8207  17e5 a501          	bcp	a,#1
8208  17e7 2706          	jreq	L7553
8209                     ; 1645  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8211  17e9 721a000b      	bset	_flags,#5
8213  17ed 200e          	jra	L1653
8214  17ef               L7553:
8215                     ; 1656  				flags&=0b11011111; 
8217  17ef 721b000b      	bres	_flags,#5
8218                     ; 1657  				off_bp_cnt=5*ee_TZAS;
8220  17f3 c60017        	ld	a,_ee_TZAS+1
8221  17f6 97            	ld	xl,a
8222  17f7 a605          	ld	a,#5
8223  17f9 42            	mul	x,a
8224  17fa 9f            	ld	a,xl
8225  17fb b753          	ld	_off_bp_cnt,a
8226  17fd               L1653:
8227                     ; 1663  	if(flags_tu&0b00000010) flags|=0b01000000;
8229  17fd b660          	ld	a,_flags_tu
8230  17ff a502          	bcp	a,#2
8231  1801 2706          	jreq	L3653
8234  1803 721c000b      	bset	_flags,#6
8236  1807 2004          	jra	L5653
8237  1809               L3653:
8238                     ; 1664  	else flags&=0b10111111; 
8240  1809 721d000b      	bres	_flags,#6
8241  180d               L5653:
8242                     ; 1666  	vol_u_temp=mess[10]+mess[11]*256;
8244  180d b6cf          	ld	a,_mess+11
8245  180f 5f            	clrw	x
8246  1810 97            	ld	xl,a
8247  1811 4f            	clr	a
8248  1812 02            	rlwa	x,a
8249  1813 01            	rrwa	x,a
8250  1814 bbce          	add	a,_mess+10
8251  1816 2401          	jrnc	L461
8252  1818 5c            	incw	x
8253  1819               L461:
8254  1819 b759          	ld	_vol_u_temp+1,a
8255  181b 9f            	ld	a,xl
8256  181c b758          	ld	_vol_u_temp,a
8257                     ; 1667  	vol_i_temp=mess[12]+mess[13]*256;  
8259  181e b6d1          	ld	a,_mess+13
8260  1820 5f            	clrw	x
8261  1821 97            	ld	xl,a
8262  1822 4f            	clr	a
8263  1823 02            	rlwa	x,a
8264  1824 01            	rrwa	x,a
8265  1825 bbd0          	add	a,_mess+12
8266  1827 2401          	jrnc	L661
8267  1829 5c            	incw	x
8268  182a               L661:
8269  182a b757          	ld	_vol_i_temp+1,a
8270  182c 9f            	ld	a,xl
8271  182d b756          	ld	_vol_i_temp,a
8272                     ; 1676 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8274  182f b601          	ld	a,_vent_resurs_tx_cnt
8275  1831 a102          	cp	a,#2
8276  1833 2507          	jrult	L7653
8279  1835 ce0000        	ldw	x,_vent_resurs
8280  1838 bf37          	ldw	_plazma_int+4,x
8282  183a 2004          	jra	L1753
8283  183c               L7653:
8284                     ; 1677 	else plazma_int[2]=vent_resurs_sec_cnt;
8286  183c be02          	ldw	x,_vent_resurs_sec_cnt
8287  183e bf37          	ldw	_plazma_int+4,x
8288  1840               L1753:
8289                     ; 1678  	rotor_int=flags_tu+(((short)flags)<<8);
8291  1840 b60b          	ld	a,_flags
8292  1842 5f            	clrw	x
8293  1843 97            	ld	xl,a
8294  1844 4f            	clr	a
8295  1845 02            	rlwa	x,a
8296  1846 01            	rrwa	x,a
8297  1847 bb60          	add	a,_flags_tu
8298  1849 2401          	jrnc	L071
8299  184b 5c            	incw	x
8300  184c               L071:
8301  184c b71e          	ld	_rotor_int+1,a
8302  184e 9f            	ld	a,xl
8303  184f b71d          	ld	_rotor_int,a
8304                     ; 1679 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8306  1851 3b006b        	push	_Ui
8307  1854 3b006c        	push	_Ui+1
8308  1857 3b006d        	push	_Un
8309  185a 3b006e        	push	_Un+1
8310  185d 3b006f        	push	_I
8311  1860 3b0070        	push	_I+1
8312  1863 4bda          	push	#218
8313  1865 3b0005        	push	_adress
8314  1868 ae018e        	ldw	x,#398
8315  186b cd161f        	call	_can_transmit
8317  186e 5b08          	addw	sp,#8
8318                     ; 1680 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8320  1870 3b0037        	push	_plazma_int+4
8321  1873 3b0038        	push	_plazma_int+5
8322  1876 3b005f        	push	__x_+1
8323  1879 3b000b        	push	_flags
8324  187c b601          	ld	a,_vent_resurs_tx_cnt
8325  187e 5f            	clrw	x
8326  187f 97            	ld	xl,a
8327  1880 d60000        	ld	a,(_vent_resurs_buff,x)
8328  1883 88            	push	a
8329  1884 3b0068        	push	_T
8330  1887 4bdb          	push	#219
8331  1889 3b0005        	push	_adress
8332  188c ae018e        	ldw	x,#398
8333  188f cd161f        	call	_can_transmit
8335  1892 5b08          	addw	sp,#8
8336                     ; 1681      link_cnt=0;
8338  1894 5f            	clrw	x
8339  1895 bf61          	ldw	_link_cnt,x
8340                     ; 1682      link=ON;
8342  1897 35550063      	mov	_link,#85
8343                     ; 1684      if(flags_tu&0b10000000)
8345  189b b660          	ld	a,_flags_tu
8346  189d a580          	bcp	a,#128
8347  189f 2716          	jreq	L3753
8348                     ; 1686      	if(!res_fl)
8350  18a1 725d000b      	tnz	_res_fl
8351  18a5 2625          	jrne	L7753
8352                     ; 1688      		res_fl=1;
8354  18a7 a601          	ld	a,#1
8355  18a9 ae000b        	ldw	x,#_res_fl
8356  18ac cd0000        	call	c_eewrc
8358                     ; 1689      		bRES=1;
8360  18af 35010012      	mov	_bRES,#1
8361                     ; 1690      		res_fl_cnt=0;
8363  18b3 3f41          	clr	_res_fl_cnt
8364  18b5 2015          	jra	L7753
8365  18b7               L3753:
8366                     ; 1695      	if(main_cnt>20)
8368  18b7 9c            	rvf
8369  18b8 be51          	ldw	x,_main_cnt
8370  18ba a30015        	cpw	x,#21
8371  18bd 2f0d          	jrslt	L7753
8372                     ; 1697     			if(res_fl)
8374  18bf 725d000b      	tnz	_res_fl
8375  18c3 2707          	jreq	L7753
8376                     ; 1699      			res_fl=0;
8378  18c5 4f            	clr	a
8379  18c6 ae000b        	ldw	x,#_res_fl
8380  18c9 cd0000        	call	c_eewrc
8382  18cc               L7753:
8383                     ; 1704       if(res_fl_)
8385  18cc 725d000a      	tnz	_res_fl_
8386  18d0 2603          	jrne	L012
8387  18d2 cc1e2b        	jp	L1253
8388  18d5               L012:
8389                     ; 1706       	res_fl_=0;
8391  18d5 4f            	clr	a
8392  18d6 ae000a        	ldw	x,#_res_fl_
8393  18d9 cd0000        	call	c_eewrc
8395  18dc ac2b1e2b      	jpf	L1253
8396  18e0               L5553:
8397                     ; 1709 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8399  18e0 b6ca          	ld	a,_mess+6
8400  18e2 c10005        	cp	a,_adress
8401  18e5 2703          	jreq	L212
8402  18e7 cc1af7        	jp	L1163
8403  18ea               L212:
8405  18ea b6cb          	ld	a,_mess+7
8406  18ec c10005        	cp	a,_adress
8407  18ef 2703          	jreq	L412
8408  18f1 cc1af7        	jp	L1163
8409  18f4               L412:
8411  18f4 b6cc          	ld	a,_mess+8
8412  18f6 a1ee          	cp	a,#238
8413  18f8 2703          	jreq	L612
8414  18fa cc1af7        	jp	L1163
8415  18fd               L612:
8417  18fd b6cd          	ld	a,_mess+9
8418  18ff b1ce          	cp	a,_mess+10
8419  1901 2703          	jreq	L022
8420  1903 cc1af7        	jp	L1163
8421  1906               L022:
8422                     ; 1711 	rotor_int++;
8424  1906 be1d          	ldw	x,_rotor_int
8425  1908 1c0001        	addw	x,#1
8426  190b bf1d          	ldw	_rotor_int,x
8427                     ; 1712 	if((mess[9]&0xf0)==0x20)
8429  190d b6cd          	ld	a,_mess+9
8430  190f a4f0          	and	a,#240
8431  1911 a120          	cp	a,#32
8432  1913 2673          	jrne	L3163
8433                     ; 1714 		if((mess[9]&0x0f)==0x01)
8435  1915 b6cd          	ld	a,_mess+9
8436  1917 a40f          	and	a,#15
8437  1919 a101          	cp	a,#1
8438  191b 260d          	jrne	L5163
8439                     ; 1716 			ee_K[0][0]=adc_buff_[4];
8441  191d ce0011        	ldw	x,_adc_buff_+8
8442  1920 89            	pushw	x
8443  1921 ae001a        	ldw	x,#_ee_K
8444  1924 cd0000        	call	c_eewrw
8446  1927 85            	popw	x
8448  1928 204a          	jra	L7163
8449  192a               L5163:
8450                     ; 1718 		else if((mess[9]&0x0f)==0x02)
8452  192a b6cd          	ld	a,_mess+9
8453  192c a40f          	and	a,#15
8454  192e a102          	cp	a,#2
8455  1930 260b          	jrne	L1263
8456                     ; 1720 			ee_K[0][1]++;
8458  1932 ce001c        	ldw	x,_ee_K+2
8459  1935 1c0001        	addw	x,#1
8460  1938 cf001c        	ldw	_ee_K+2,x
8462  193b 2037          	jra	L7163
8463  193d               L1263:
8464                     ; 1722 		else if((mess[9]&0x0f)==0x03)
8466  193d b6cd          	ld	a,_mess+9
8467  193f a40f          	and	a,#15
8468  1941 a103          	cp	a,#3
8469  1943 260b          	jrne	L5263
8470                     ; 1724 			ee_K[0][1]+=10;
8472  1945 ce001c        	ldw	x,_ee_K+2
8473  1948 1c000a        	addw	x,#10
8474  194b cf001c        	ldw	_ee_K+2,x
8476  194e 2024          	jra	L7163
8477  1950               L5263:
8478                     ; 1726 		else if((mess[9]&0x0f)==0x04)
8480  1950 b6cd          	ld	a,_mess+9
8481  1952 a40f          	and	a,#15
8482  1954 a104          	cp	a,#4
8483  1956 260b          	jrne	L1363
8484                     ; 1728 			ee_K[0][1]--;
8486  1958 ce001c        	ldw	x,_ee_K+2
8487  195b 1d0001        	subw	x,#1
8488  195e cf001c        	ldw	_ee_K+2,x
8490  1961 2011          	jra	L7163
8491  1963               L1363:
8492                     ; 1730 		else if((mess[9]&0x0f)==0x05)
8494  1963 b6cd          	ld	a,_mess+9
8495  1965 a40f          	and	a,#15
8496  1967 a105          	cp	a,#5
8497  1969 2609          	jrne	L7163
8498                     ; 1732 			ee_K[0][1]-=10;
8500  196b ce001c        	ldw	x,_ee_K+2
8501  196e 1d000a        	subw	x,#10
8502  1971 cf001c        	ldw	_ee_K+2,x
8503  1974               L7163:
8504                     ; 1734 		granee(&ee_K[0][1],10,3000);									
8506  1974 ae0bb8        	ldw	x,#3000
8507  1977 89            	pushw	x
8508  1978 ae000a        	ldw	x,#10
8509  197b 89            	pushw	x
8510  197c ae001c        	ldw	x,#_ee_K+2
8511  197f cd00f2        	call	_granee
8513  1982 5b04          	addw	sp,#4
8515  1984 acdc1adc      	jpf	L7363
8516  1988               L3163:
8517                     ; 1736 	else if((mess[9]&0xf0)==0x10)
8519  1988 b6cd          	ld	a,_mess+9
8520  198a a4f0          	and	a,#240
8521  198c a110          	cp	a,#16
8522  198e 2673          	jrne	L1463
8523                     ; 1738 		if((mess[9]&0x0f)==0x01)
8525  1990 b6cd          	ld	a,_mess+9
8526  1992 a40f          	and	a,#15
8527  1994 a101          	cp	a,#1
8528  1996 260d          	jrne	L3463
8529                     ; 1740 			ee_K[1][0]=adc_buff_[1];
8531  1998 ce000b        	ldw	x,_adc_buff_+2
8532  199b 89            	pushw	x
8533  199c ae001e        	ldw	x,#_ee_K+4
8534  199f cd0000        	call	c_eewrw
8536  19a2 85            	popw	x
8538  19a3 204a          	jra	L5463
8539  19a5               L3463:
8540                     ; 1742 		else if((mess[9]&0x0f)==0x02)
8542  19a5 b6cd          	ld	a,_mess+9
8543  19a7 a40f          	and	a,#15
8544  19a9 a102          	cp	a,#2
8545  19ab 260b          	jrne	L7463
8546                     ; 1744 			ee_K[1][1]++;
8548  19ad ce0020        	ldw	x,_ee_K+6
8549  19b0 1c0001        	addw	x,#1
8550  19b3 cf0020        	ldw	_ee_K+6,x
8552  19b6 2037          	jra	L5463
8553  19b8               L7463:
8554                     ; 1746 		else if((mess[9]&0x0f)==0x03)
8556  19b8 b6cd          	ld	a,_mess+9
8557  19ba a40f          	and	a,#15
8558  19bc a103          	cp	a,#3
8559  19be 260b          	jrne	L3563
8560                     ; 1748 			ee_K[1][1]+=10;
8562  19c0 ce0020        	ldw	x,_ee_K+6
8563  19c3 1c000a        	addw	x,#10
8564  19c6 cf0020        	ldw	_ee_K+6,x
8566  19c9 2024          	jra	L5463
8567  19cb               L3563:
8568                     ; 1750 		else if((mess[9]&0x0f)==0x04)
8570  19cb b6cd          	ld	a,_mess+9
8571  19cd a40f          	and	a,#15
8572  19cf a104          	cp	a,#4
8573  19d1 260b          	jrne	L7563
8574                     ; 1752 			ee_K[1][1]--;
8576  19d3 ce0020        	ldw	x,_ee_K+6
8577  19d6 1d0001        	subw	x,#1
8578  19d9 cf0020        	ldw	_ee_K+6,x
8580  19dc 2011          	jra	L5463
8581  19de               L7563:
8582                     ; 1754 		else if((mess[9]&0x0f)==0x05)
8584  19de b6cd          	ld	a,_mess+9
8585  19e0 a40f          	and	a,#15
8586  19e2 a105          	cp	a,#5
8587  19e4 2609          	jrne	L5463
8588                     ; 1756 			ee_K[1][1]-=10;
8590  19e6 ce0020        	ldw	x,_ee_K+6
8591  19e9 1d000a        	subw	x,#10
8592  19ec cf0020        	ldw	_ee_K+6,x
8593  19ef               L5463:
8594                     ; 1761 		granee(&ee_K[1][1],10,30000);
8596  19ef ae7530        	ldw	x,#30000
8597  19f2 89            	pushw	x
8598  19f3 ae000a        	ldw	x,#10
8599  19f6 89            	pushw	x
8600  19f7 ae0020        	ldw	x,#_ee_K+6
8601  19fa cd00f2        	call	_granee
8603  19fd 5b04          	addw	sp,#4
8605  19ff acdc1adc      	jpf	L7363
8606  1a03               L1463:
8607                     ; 1765 	else if((mess[9]&0xf0)==0x00)
8609  1a03 b6cd          	ld	a,_mess+9
8610  1a05 a5f0          	bcp	a,#240
8611  1a07 2671          	jrne	L7663
8612                     ; 1767 		if((mess[9]&0x0f)==0x01)
8614  1a09 b6cd          	ld	a,_mess+9
8615  1a0b a40f          	and	a,#15
8616  1a0d a101          	cp	a,#1
8617  1a0f 260d          	jrne	L1763
8618                     ; 1769 			ee_K[2][0]=adc_buff_[2];
8620  1a11 ce000d        	ldw	x,_adc_buff_+4
8621  1a14 89            	pushw	x
8622  1a15 ae0022        	ldw	x,#_ee_K+8
8623  1a18 cd0000        	call	c_eewrw
8625  1a1b 85            	popw	x
8627  1a1c 204a          	jra	L3763
8628  1a1e               L1763:
8629                     ; 1771 		else if((mess[9]&0x0f)==0x02)
8631  1a1e b6cd          	ld	a,_mess+9
8632  1a20 a40f          	and	a,#15
8633  1a22 a102          	cp	a,#2
8634  1a24 260b          	jrne	L5763
8635                     ; 1773 			ee_K[2][1]++;
8637  1a26 ce0024        	ldw	x,_ee_K+10
8638  1a29 1c0001        	addw	x,#1
8639  1a2c cf0024        	ldw	_ee_K+10,x
8641  1a2f 2037          	jra	L3763
8642  1a31               L5763:
8643                     ; 1775 		else if((mess[9]&0x0f)==0x03)
8645  1a31 b6cd          	ld	a,_mess+9
8646  1a33 a40f          	and	a,#15
8647  1a35 a103          	cp	a,#3
8648  1a37 260b          	jrne	L1073
8649                     ; 1777 			ee_K[2][1]+=10;
8651  1a39 ce0024        	ldw	x,_ee_K+10
8652  1a3c 1c000a        	addw	x,#10
8653  1a3f cf0024        	ldw	_ee_K+10,x
8655  1a42 2024          	jra	L3763
8656  1a44               L1073:
8657                     ; 1779 		else if((mess[9]&0x0f)==0x04)
8659  1a44 b6cd          	ld	a,_mess+9
8660  1a46 a40f          	and	a,#15
8661  1a48 a104          	cp	a,#4
8662  1a4a 260b          	jrne	L5073
8663                     ; 1781 			ee_K[2][1]--;
8665  1a4c ce0024        	ldw	x,_ee_K+10
8666  1a4f 1d0001        	subw	x,#1
8667  1a52 cf0024        	ldw	_ee_K+10,x
8669  1a55 2011          	jra	L3763
8670  1a57               L5073:
8671                     ; 1783 		else if((mess[9]&0x0f)==0x05)
8673  1a57 b6cd          	ld	a,_mess+9
8674  1a59 a40f          	and	a,#15
8675  1a5b a105          	cp	a,#5
8676  1a5d 2609          	jrne	L3763
8677                     ; 1785 			ee_K[2][1]-=10;
8679  1a5f ce0024        	ldw	x,_ee_K+10
8680  1a62 1d000a        	subw	x,#10
8681  1a65 cf0024        	ldw	_ee_K+10,x
8682  1a68               L3763:
8683                     ; 1790 		granee(&ee_K[2][1],10,30000);
8685  1a68 ae7530        	ldw	x,#30000
8686  1a6b 89            	pushw	x
8687  1a6c ae000a        	ldw	x,#10
8688  1a6f 89            	pushw	x
8689  1a70 ae0024        	ldw	x,#_ee_K+10
8690  1a73 cd00f2        	call	_granee
8692  1a76 5b04          	addw	sp,#4
8694  1a78 2062          	jra	L7363
8695  1a7a               L7663:
8696                     ; 1794 	else if((mess[9]&0xf0)==0x30)
8698  1a7a b6cd          	ld	a,_mess+9
8699  1a7c a4f0          	and	a,#240
8700  1a7e a130          	cp	a,#48
8701  1a80 265a          	jrne	L7363
8702                     ; 1796 		if((mess[9]&0x0f)==0x02)
8704  1a82 b6cd          	ld	a,_mess+9
8705  1a84 a40f          	and	a,#15
8706  1a86 a102          	cp	a,#2
8707  1a88 260b          	jrne	L7173
8708                     ; 1798 			ee_K[3][1]++;
8710  1a8a ce0028        	ldw	x,_ee_K+14
8711  1a8d 1c0001        	addw	x,#1
8712  1a90 cf0028        	ldw	_ee_K+14,x
8714  1a93 2037          	jra	L1273
8715  1a95               L7173:
8716                     ; 1800 		else if((mess[9]&0x0f)==0x03)
8718  1a95 b6cd          	ld	a,_mess+9
8719  1a97 a40f          	and	a,#15
8720  1a99 a103          	cp	a,#3
8721  1a9b 260b          	jrne	L3273
8722                     ; 1802 			ee_K[3][1]+=10;
8724  1a9d ce0028        	ldw	x,_ee_K+14
8725  1aa0 1c000a        	addw	x,#10
8726  1aa3 cf0028        	ldw	_ee_K+14,x
8728  1aa6 2024          	jra	L1273
8729  1aa8               L3273:
8730                     ; 1804 		else if((mess[9]&0x0f)==0x04)
8732  1aa8 b6cd          	ld	a,_mess+9
8733  1aaa a40f          	and	a,#15
8734  1aac a104          	cp	a,#4
8735  1aae 260b          	jrne	L7273
8736                     ; 1806 			ee_K[3][1]--;
8738  1ab0 ce0028        	ldw	x,_ee_K+14
8739  1ab3 1d0001        	subw	x,#1
8740  1ab6 cf0028        	ldw	_ee_K+14,x
8742  1ab9 2011          	jra	L1273
8743  1abb               L7273:
8744                     ; 1808 		else if((mess[9]&0x0f)==0x05)
8746  1abb b6cd          	ld	a,_mess+9
8747  1abd a40f          	and	a,#15
8748  1abf a105          	cp	a,#5
8749  1ac1 2609          	jrne	L1273
8750                     ; 1810 			ee_K[3][1]-=10;
8752  1ac3 ce0028        	ldw	x,_ee_K+14
8753  1ac6 1d000a        	subw	x,#10
8754  1ac9 cf0028        	ldw	_ee_K+14,x
8755  1acc               L1273:
8756                     ; 1812 		granee(&ee_K[3][1],300,517);									
8758  1acc ae0205        	ldw	x,#517
8759  1acf 89            	pushw	x
8760  1ad0 ae012c        	ldw	x,#300
8761  1ad3 89            	pushw	x
8762  1ad4 ae0028        	ldw	x,#_ee_K+14
8763  1ad7 cd00f2        	call	_granee
8765  1ada 5b04          	addw	sp,#4
8766  1adc               L7363:
8767                     ; 1815 	link_cnt=0;
8769  1adc 5f            	clrw	x
8770  1add bf61          	ldw	_link_cnt,x
8771                     ; 1816      link=ON;
8773  1adf 35550063      	mov	_link,#85
8774                     ; 1817      if(res_fl_)
8776  1ae3 725d000a      	tnz	_res_fl_
8777  1ae7 2603          	jrne	L222
8778  1ae9 cc1e2b        	jp	L1253
8779  1aec               L222:
8780                     ; 1819       	res_fl_=0;
8782  1aec 4f            	clr	a
8783  1aed ae000a        	ldw	x,#_res_fl_
8784  1af0 cd0000        	call	c_eewrc
8786  1af3 ac2b1e2b      	jpf	L1253
8787  1af7               L1163:
8788                     ; 1825 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8790  1af7 b6ca          	ld	a,_mess+6
8791  1af9 a1ff          	cp	a,#255
8792  1afb 2703          	jreq	L422
8793  1afd cc1b8b        	jp	L1473
8794  1b00               L422:
8796  1b00 b6cb          	ld	a,_mess+7
8797  1b02 a1ff          	cp	a,#255
8798  1b04 2703          	jreq	L622
8799  1b06 cc1b8b        	jp	L1473
8800  1b09               L622:
8802  1b09 b6cc          	ld	a,_mess+8
8803  1b0b a162          	cp	a,#98
8804  1b0d 267c          	jrne	L1473
8805                     ; 1828 	tempSS=mess[9]+(mess[10]*256);
8807  1b0f b6ce          	ld	a,_mess+10
8808  1b11 5f            	clrw	x
8809  1b12 97            	ld	xl,a
8810  1b13 4f            	clr	a
8811  1b14 02            	rlwa	x,a
8812  1b15 01            	rrwa	x,a
8813  1b16 bbcd          	add	a,_mess+9
8814  1b18 2401          	jrnc	L271
8815  1b1a 5c            	incw	x
8816  1b1b               L271:
8817  1b1b 02            	rlwa	x,a
8818  1b1c 1f04          	ldw	(OFST-1,sp),x
8819  1b1e 01            	rrwa	x,a
8820                     ; 1829 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8822  1b1f ce0014        	ldw	x,_ee_Umax
8823  1b22 1304          	cpw	x,(OFST-1,sp)
8824  1b24 270a          	jreq	L3473
8827  1b26 1e04          	ldw	x,(OFST-1,sp)
8828  1b28 89            	pushw	x
8829  1b29 ae0014        	ldw	x,#_ee_Umax
8830  1b2c cd0000        	call	c_eewrw
8832  1b2f 85            	popw	x
8833  1b30               L3473:
8834                     ; 1830 	tempSS=mess[11]+(mess[12]*256);
8836  1b30 b6d0          	ld	a,_mess+12
8837  1b32 5f            	clrw	x
8838  1b33 97            	ld	xl,a
8839  1b34 4f            	clr	a
8840  1b35 02            	rlwa	x,a
8841  1b36 01            	rrwa	x,a
8842  1b37 bbcf          	add	a,_mess+11
8843  1b39 2401          	jrnc	L471
8844  1b3b 5c            	incw	x
8845  1b3c               L471:
8846  1b3c 02            	rlwa	x,a
8847  1b3d 1f04          	ldw	(OFST-1,sp),x
8848  1b3f 01            	rrwa	x,a
8849                     ; 1831 	if(ee_dU!=tempSS) ee_dU=tempSS;
8851  1b40 ce0012        	ldw	x,_ee_dU
8852  1b43 1304          	cpw	x,(OFST-1,sp)
8853  1b45 270a          	jreq	L5473
8856  1b47 1e04          	ldw	x,(OFST-1,sp)
8857  1b49 89            	pushw	x
8858  1b4a ae0012        	ldw	x,#_ee_dU
8859  1b4d cd0000        	call	c_eewrw
8861  1b50 85            	popw	x
8862  1b51               L5473:
8863                     ; 1832 	if((mess[13]&0x0f)==0x5)
8865  1b51 b6d1          	ld	a,_mess+13
8866  1b53 a40f          	and	a,#15
8867  1b55 a105          	cp	a,#5
8868  1b57 261a          	jrne	L7473
8869                     ; 1834 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8871  1b59 ce0006        	ldw	x,_ee_AVT_MODE
8872  1b5c a30055        	cpw	x,#85
8873  1b5f 2603          	jrne	L032
8874  1b61 cc1e2b        	jp	L1253
8875  1b64               L032:
8878  1b64 ae0055        	ldw	x,#85
8879  1b67 89            	pushw	x
8880  1b68 ae0006        	ldw	x,#_ee_AVT_MODE
8881  1b6b cd0000        	call	c_eewrw
8883  1b6e 85            	popw	x
8884  1b6f ac2b1e2b      	jpf	L1253
8885  1b73               L7473:
8886                     ; 1836 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8888  1b73 ce0006        	ldw	x,_ee_AVT_MODE
8889  1b76 a30055        	cpw	x,#85
8890  1b79 2703          	jreq	L232
8891  1b7b cc1e2b        	jp	L1253
8892  1b7e               L232:
8895  1b7e 5f            	clrw	x
8896  1b7f 89            	pushw	x
8897  1b80 ae0006        	ldw	x,#_ee_AVT_MODE
8898  1b83 cd0000        	call	c_eewrw
8900  1b86 85            	popw	x
8901  1b87 ac2b1e2b      	jpf	L1253
8902  1b8b               L1473:
8903                     ; 1839 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8905  1b8b b6ca          	ld	a,_mess+6
8906  1b8d a1ff          	cp	a,#255
8907  1b8f 2703          	jreq	L432
8908  1b91 cc1c62        	jp	L1673
8909  1b94               L432:
8911  1b94 b6cb          	ld	a,_mess+7
8912  1b96 a1ff          	cp	a,#255
8913  1b98 2703          	jreq	L632
8914  1b9a cc1c62        	jp	L1673
8915  1b9d               L632:
8917  1b9d b6cc          	ld	a,_mess+8
8918  1b9f a126          	cp	a,#38
8919  1ba1 2709          	jreq	L3673
8921  1ba3 b6cc          	ld	a,_mess+8
8922  1ba5 a129          	cp	a,#41
8923  1ba7 2703          	jreq	L042
8924  1ba9 cc1c62        	jp	L1673
8925  1bac               L042:
8926  1bac               L3673:
8927                     ; 1842 	tempSS=mess[9]+(mess[10]*256);
8929  1bac b6ce          	ld	a,_mess+10
8930  1bae 5f            	clrw	x
8931  1baf 97            	ld	xl,a
8932  1bb0 4f            	clr	a
8933  1bb1 02            	rlwa	x,a
8934  1bb2 01            	rrwa	x,a
8935  1bb3 bbcd          	add	a,_mess+9
8936  1bb5 2401          	jrnc	L671
8937  1bb7 5c            	incw	x
8938  1bb8               L671:
8939  1bb8 02            	rlwa	x,a
8940  1bb9 1f04          	ldw	(OFST-1,sp),x
8941  1bbb 01            	rrwa	x,a
8942                     ; 1843 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8944  1bbc ce0010        	ldw	x,_ee_tmax
8945  1bbf 1304          	cpw	x,(OFST-1,sp)
8946  1bc1 270a          	jreq	L5673
8949  1bc3 1e04          	ldw	x,(OFST-1,sp)
8950  1bc5 89            	pushw	x
8951  1bc6 ae0010        	ldw	x,#_ee_tmax
8952  1bc9 cd0000        	call	c_eewrw
8954  1bcc 85            	popw	x
8955  1bcd               L5673:
8956                     ; 1844 	tempSS=mess[11]+(mess[12]*256);
8958  1bcd b6d0          	ld	a,_mess+12
8959  1bcf 5f            	clrw	x
8960  1bd0 97            	ld	xl,a
8961  1bd1 4f            	clr	a
8962  1bd2 02            	rlwa	x,a
8963  1bd3 01            	rrwa	x,a
8964  1bd4 bbcf          	add	a,_mess+11
8965  1bd6 2401          	jrnc	L002
8966  1bd8 5c            	incw	x
8967  1bd9               L002:
8968  1bd9 02            	rlwa	x,a
8969  1bda 1f04          	ldw	(OFST-1,sp),x
8970  1bdc 01            	rrwa	x,a
8971                     ; 1845 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8973  1bdd ce000e        	ldw	x,_ee_tsign
8974  1be0 1304          	cpw	x,(OFST-1,sp)
8975  1be2 270a          	jreq	L7673
8978  1be4 1e04          	ldw	x,(OFST-1,sp)
8979  1be6 89            	pushw	x
8980  1be7 ae000e        	ldw	x,#_ee_tsign
8981  1bea cd0000        	call	c_eewrw
8983  1bed 85            	popw	x
8984  1bee               L7673:
8985                     ; 1848 	if(mess[8]==MEM_KF1)
8987  1bee b6cc          	ld	a,_mess+8
8988  1bf0 a126          	cp	a,#38
8989  1bf2 2623          	jrne	L1773
8990                     ; 1850 		if(ee_DEVICE!=0)ee_DEVICE=0;
8992  1bf4 ce0004        	ldw	x,_ee_DEVICE
8993  1bf7 2709          	jreq	L3773
8996  1bf9 5f            	clrw	x
8997  1bfa 89            	pushw	x
8998  1bfb ae0004        	ldw	x,#_ee_DEVICE
8999  1bfe cd0000        	call	c_eewrw
9001  1c01 85            	popw	x
9002  1c02               L3773:
9003                     ; 1851 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
9005  1c02 b6d1          	ld	a,_mess+13
9006  1c04 5f            	clrw	x
9007  1c05 97            	ld	xl,a
9008  1c06 c30016        	cpw	x,_ee_TZAS
9009  1c09 270c          	jreq	L1773
9012  1c0b b6d1          	ld	a,_mess+13
9013  1c0d 5f            	clrw	x
9014  1c0e 97            	ld	xl,a
9015  1c0f 89            	pushw	x
9016  1c10 ae0016        	ldw	x,#_ee_TZAS
9017  1c13 cd0000        	call	c_eewrw
9019  1c16 85            	popw	x
9020  1c17               L1773:
9021                     ; 1853 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
9023  1c17 b6cc          	ld	a,_mess+8
9024  1c19 a129          	cp	a,#41
9025  1c1b 2703          	jreq	L242
9026  1c1d cc1e2b        	jp	L1253
9027  1c20               L242:
9028                     ; 1855 		if(ee_DEVICE!=1)ee_DEVICE=1;
9030  1c20 ce0004        	ldw	x,_ee_DEVICE
9031  1c23 a30001        	cpw	x,#1
9032  1c26 270b          	jreq	L1004
9035  1c28 ae0001        	ldw	x,#1
9036  1c2b 89            	pushw	x
9037  1c2c ae0004        	ldw	x,#_ee_DEVICE
9038  1c2f cd0000        	call	c_eewrw
9040  1c32 85            	popw	x
9041  1c33               L1004:
9042                     ; 1856 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
9044  1c33 b6d1          	ld	a,_mess+13
9045  1c35 5f            	clrw	x
9046  1c36 97            	ld	xl,a
9047  1c37 c30002        	cpw	x,_ee_IMAXVENT
9048  1c3a 270c          	jreq	L3004
9051  1c3c b6d1          	ld	a,_mess+13
9052  1c3e 5f            	clrw	x
9053  1c3f 97            	ld	xl,a
9054  1c40 89            	pushw	x
9055  1c41 ae0002        	ldw	x,#_ee_IMAXVENT
9056  1c44 cd0000        	call	c_eewrw
9058  1c47 85            	popw	x
9059  1c48               L3004:
9060                     ; 1857 			if(ee_TZAS!=3) ee_TZAS=3;
9062  1c48 ce0016        	ldw	x,_ee_TZAS
9063  1c4b a30003        	cpw	x,#3
9064  1c4e 2603          	jrne	L442
9065  1c50 cc1e2b        	jp	L1253
9066  1c53               L442:
9069  1c53 ae0003        	ldw	x,#3
9070  1c56 89            	pushw	x
9071  1c57 ae0016        	ldw	x,#_ee_TZAS
9072  1c5a cd0000        	call	c_eewrw
9074  1c5d 85            	popw	x
9075  1c5e ac2b1e2b      	jpf	L1253
9076  1c62               L1673:
9077                     ; 1861 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
9079  1c62 b6ca          	ld	a,_mess+6
9080  1c64 c10005        	cp	a,_adress
9081  1c67 262d          	jrne	L1104
9083  1c69 b6cb          	ld	a,_mess+7
9084  1c6b c10005        	cp	a,_adress
9085  1c6e 2626          	jrne	L1104
9087  1c70 b6cc          	ld	a,_mess+8
9088  1c72 a116          	cp	a,#22
9089  1c74 2620          	jrne	L1104
9091  1c76 b6cd          	ld	a,_mess+9
9092  1c78 a163          	cp	a,#99
9093  1c7a 261a          	jrne	L1104
9094                     ; 1863 	flags&=0b11100001;
9096  1c7c b60b          	ld	a,_flags
9097  1c7e a4e1          	and	a,#225
9098  1c80 b70b          	ld	_flags,a
9099                     ; 1864 	tsign_cnt=0;
9101  1c82 5f            	clrw	x
9102  1c83 bf4d          	ldw	_tsign_cnt,x
9103                     ; 1865 	tmax_cnt=0;
9105  1c85 5f            	clrw	x
9106  1c86 bf4b          	ldw	_tmax_cnt,x
9107                     ; 1866 	umax_cnt=0;
9109  1c88 5f            	clrw	x
9110  1c89 bf66          	ldw	_umax_cnt,x
9111                     ; 1867 	umin_cnt=0;
9113  1c8b 5f            	clrw	x
9114  1c8c bf64          	ldw	_umin_cnt,x
9115                     ; 1868 	led_drv_cnt=30;
9117  1c8e 351e001c      	mov	_led_drv_cnt,#30
9119  1c92 ac2b1e2b      	jpf	L1253
9120  1c96               L1104:
9121                     ; 1871 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
9123  1c96 b6ca          	ld	a,_mess+6
9124  1c98 c10005        	cp	a,_adress
9125  1c9b 2620          	jrne	L5104
9127  1c9d b6cb          	ld	a,_mess+7
9128  1c9f c10005        	cp	a,_adress
9129  1ca2 2619          	jrne	L5104
9131  1ca4 b6cc          	ld	a,_mess+8
9132  1ca6 a116          	cp	a,#22
9133  1ca8 2613          	jrne	L5104
9135  1caa b6cd          	ld	a,_mess+9
9136  1cac a164          	cp	a,#100
9137  1cae 260d          	jrne	L5104
9138                     ; 1873 	vent_resurs=0;
9140  1cb0 5f            	clrw	x
9141  1cb1 89            	pushw	x
9142  1cb2 ae0000        	ldw	x,#_vent_resurs
9143  1cb5 cd0000        	call	c_eewrw
9145  1cb8 85            	popw	x
9147  1cb9 ac2b1e2b      	jpf	L1253
9148  1cbd               L5104:
9149                     ; 1877 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
9151  1cbd b6ca          	ld	a,_mess+6
9152  1cbf a1ff          	cp	a,#255
9153  1cc1 265f          	jrne	L1204
9155  1cc3 b6cb          	ld	a,_mess+7
9156  1cc5 a1ff          	cp	a,#255
9157  1cc7 2659          	jrne	L1204
9159  1cc9 b6cc          	ld	a,_mess+8
9160  1ccb a116          	cp	a,#22
9161  1ccd 2653          	jrne	L1204
9163  1ccf b6cd          	ld	a,_mess+9
9164  1cd1 a116          	cp	a,#22
9165  1cd3 264d          	jrne	L1204
9166                     ; 1879 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9168  1cd5 b6ce          	ld	a,_mess+10
9169  1cd7 a155          	cp	a,#85
9170  1cd9 260f          	jrne	L3204
9172  1cdb b6cf          	ld	a,_mess+11
9173  1cdd a155          	cp	a,#85
9174  1cdf 2609          	jrne	L3204
9177  1ce1 be5e          	ldw	x,__x_
9178  1ce3 1c0001        	addw	x,#1
9179  1ce6 bf5e          	ldw	__x_,x
9181  1ce8 2024          	jra	L5204
9182  1cea               L3204:
9183                     ; 1880 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9185  1cea b6ce          	ld	a,_mess+10
9186  1cec a166          	cp	a,#102
9187  1cee 260f          	jrne	L7204
9189  1cf0 b6cf          	ld	a,_mess+11
9190  1cf2 a166          	cp	a,#102
9191  1cf4 2609          	jrne	L7204
9194  1cf6 be5e          	ldw	x,__x_
9195  1cf8 1d0001        	subw	x,#1
9196  1cfb bf5e          	ldw	__x_,x
9198  1cfd 200f          	jra	L5204
9199  1cff               L7204:
9200                     ; 1881 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9202  1cff b6ce          	ld	a,_mess+10
9203  1d01 a177          	cp	a,#119
9204  1d03 2609          	jrne	L5204
9206  1d05 b6cf          	ld	a,_mess+11
9207  1d07 a177          	cp	a,#119
9208  1d09 2603          	jrne	L5204
9211  1d0b 5f            	clrw	x
9212  1d0c bf5e          	ldw	__x_,x
9213  1d0e               L5204:
9214                     ; 1882      gran(&_x_,-XMAX,XMAX);
9216  1d0e ae0019        	ldw	x,#25
9217  1d11 89            	pushw	x
9218  1d12 aeffe7        	ldw	x,#65511
9219  1d15 89            	pushw	x
9220  1d16 ae005e        	ldw	x,#__x_
9221  1d19 cd00d1        	call	_gran
9223  1d1c 5b04          	addw	sp,#4
9225  1d1e ac2b1e2b      	jpf	L1253
9226  1d22               L1204:
9227                     ; 1884 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9229  1d22 b6ca          	ld	a,_mess+6
9230  1d24 c10005        	cp	a,_adress
9231  1d27 2665          	jrne	L7304
9233  1d29 b6cb          	ld	a,_mess+7
9234  1d2b c10005        	cp	a,_adress
9235  1d2e 265e          	jrne	L7304
9237  1d30 b6cc          	ld	a,_mess+8
9238  1d32 a116          	cp	a,#22
9239  1d34 2658          	jrne	L7304
9241  1d36 b6cd          	ld	a,_mess+9
9242  1d38 b1ce          	cp	a,_mess+10
9243  1d3a 2652          	jrne	L7304
9245  1d3c b6cd          	ld	a,_mess+9
9246  1d3e a1ee          	cp	a,#238
9247  1d40 264c          	jrne	L7304
9248                     ; 1886 	rotor_int++;
9250  1d42 be1d          	ldw	x,_rotor_int
9251  1d44 1c0001        	addw	x,#1
9252  1d47 bf1d          	ldw	_rotor_int,x
9253                     ; 1887      tempI=pwm_u;
9255  1d49 be0e          	ldw	x,_pwm_u
9256  1d4b 1f04          	ldw	(OFST-1,sp),x
9257                     ; 1888 	ee_U_AVT=tempI;
9259  1d4d 1e04          	ldw	x,(OFST-1,sp)
9260  1d4f 89            	pushw	x
9261  1d50 ae000c        	ldw	x,#_ee_U_AVT
9262  1d53 cd0000        	call	c_eewrw
9264  1d56 85            	popw	x
9265                     ; 1889 	UU_AVT=Un;
9267  1d57 be6d          	ldw	x,_Un
9268  1d59 89            	pushw	x
9269  1d5a ae0008        	ldw	x,#_UU_AVT
9270  1d5d cd0000        	call	c_eewrw
9272  1d60 85            	popw	x
9273                     ; 1890 	delay_ms(100);
9275  1d61 ae0064        	ldw	x,#100
9276  1d64 cd011d        	call	_delay_ms
9278                     ; 1891 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9280  1d67 ce000c        	ldw	x,_ee_U_AVT
9281  1d6a 1304          	cpw	x,(OFST-1,sp)
9282  1d6c 2703          	jreq	L642
9283  1d6e cc1e2b        	jp	L1253
9284  1d71               L642:
9287  1d71 4b00          	push	#0
9288  1d73 4b00          	push	#0
9289  1d75 4b00          	push	#0
9290  1d77 4b00          	push	#0
9291  1d79 4bdd          	push	#221
9292  1d7b 4bdd          	push	#221
9293  1d7d 4b91          	push	#145
9294  1d7f 3b0005        	push	_adress
9295  1d82 ae018e        	ldw	x,#398
9296  1d85 cd161f        	call	_can_transmit
9298  1d88 5b08          	addw	sp,#8
9299  1d8a ac2b1e2b      	jpf	L1253
9300  1d8e               L7304:
9301                     ; 1896 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9303  1d8e b6cb          	ld	a,_mess+7
9304  1d90 a1da          	cp	a,#218
9305  1d92 2652          	jrne	L5404
9307  1d94 b6ca          	ld	a,_mess+6
9308  1d96 c10005        	cp	a,_adress
9309  1d99 274b          	jreq	L5404
9311  1d9b b6ca          	ld	a,_mess+6
9312  1d9d a106          	cp	a,#6
9313  1d9f 2445          	jruge	L5404
9314                     ; 1898 	i_main_bps_cnt[mess[6]]=0;
9316  1da1 b6ca          	ld	a,_mess+6
9317  1da3 5f            	clrw	x
9318  1da4 97            	ld	xl,a
9319  1da5 6f09          	clr	(_i_main_bps_cnt,x)
9320                     ; 1899 	i_main_flag[mess[6]]=1;
9322  1da7 b6ca          	ld	a,_mess+6
9323  1da9 5f            	clrw	x
9324  1daa 97            	ld	xl,a
9325  1dab a601          	ld	a,#1
9326  1dad e714          	ld	(_i_main_flag,x),a
9327                     ; 1900 	if(bMAIN)
9329                     	btst	_bMAIN
9330  1db4 2475          	jruge	L1253
9331                     ; 1902 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9333  1db6 b6cd          	ld	a,_mess+9
9334  1db8 5f            	clrw	x
9335  1db9 97            	ld	xl,a
9336  1dba 4f            	clr	a
9337  1dbb 02            	rlwa	x,a
9338  1dbc 1f01          	ldw	(OFST-4,sp),x
9339  1dbe b6cc          	ld	a,_mess+8
9340  1dc0 5f            	clrw	x
9341  1dc1 97            	ld	xl,a
9342  1dc2 72fb01        	addw	x,(OFST-4,sp)
9343  1dc5 b6ca          	ld	a,_mess+6
9344  1dc7 905f          	clrw	y
9345  1dc9 9097          	ld	yl,a
9346  1dcb 9058          	sllw	y
9347  1dcd 90ef1a        	ldw	(_i_main,y),x
9348                     ; 1903 		i_main[adress]=I;
9350  1dd0 c60005        	ld	a,_adress
9351  1dd3 5f            	clrw	x
9352  1dd4 97            	ld	xl,a
9353  1dd5 58            	sllw	x
9354  1dd6 90be6f        	ldw	y,_I
9355  1dd9 ef1a          	ldw	(_i_main,x),y
9356                     ; 1904      	i_main_flag[adress]=1;
9358  1ddb c60005        	ld	a,_adress
9359  1dde 5f            	clrw	x
9360  1ddf 97            	ld	xl,a
9361  1de0 a601          	ld	a,#1
9362  1de2 e714          	ld	(_i_main_flag,x),a
9363  1de4 2045          	jra	L1253
9364  1de6               L5404:
9365                     ; 1908 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9367  1de6 b6cb          	ld	a,_mess+7
9368  1de8 a1db          	cp	a,#219
9369  1dea 263f          	jrne	L1253
9371  1dec b6ca          	ld	a,_mess+6
9372  1dee c10005        	cp	a,_adress
9373  1df1 2738          	jreq	L1253
9375  1df3 b6ca          	ld	a,_mess+6
9376  1df5 a106          	cp	a,#6
9377  1df7 2432          	jruge	L1253
9378                     ; 1910 	i_main_bps_cnt[mess[6]]=0;
9380  1df9 b6ca          	ld	a,_mess+6
9381  1dfb 5f            	clrw	x
9382  1dfc 97            	ld	xl,a
9383  1dfd 6f09          	clr	(_i_main_bps_cnt,x)
9384                     ; 1911 	i_main_flag[mess[6]]=1;		
9386  1dff b6ca          	ld	a,_mess+6
9387  1e01 5f            	clrw	x
9388  1e02 97            	ld	xl,a
9389  1e03 a601          	ld	a,#1
9390  1e05 e714          	ld	(_i_main_flag,x),a
9391                     ; 1912 	if(bMAIN)
9393                     	btst	_bMAIN
9394  1e0c 241d          	jruge	L1253
9395                     ; 1914 		if(mess[9]==0)i_main_flag[i]=1;
9397  1e0e 3dcd          	tnz	_mess+9
9398  1e10 260a          	jrne	L7504
9401  1e12 7b03          	ld	a,(OFST-2,sp)
9402  1e14 5f            	clrw	x
9403  1e15 97            	ld	xl,a
9404  1e16 a601          	ld	a,#1
9405  1e18 e714          	ld	(_i_main_flag,x),a
9407  1e1a 2006          	jra	L1604
9408  1e1c               L7504:
9409                     ; 1915 		else i_main_flag[i]=0;
9411  1e1c 7b03          	ld	a,(OFST-2,sp)
9412  1e1e 5f            	clrw	x
9413  1e1f 97            	ld	xl,a
9414  1e20 6f14          	clr	(_i_main_flag,x)
9415  1e22               L1604:
9416                     ; 1916 		i_main_flag[adress]=1;
9418  1e22 c60005        	ld	a,_adress
9419  1e25 5f            	clrw	x
9420  1e26 97            	ld	xl,a
9421  1e27 a601          	ld	a,#1
9422  1e29 e714          	ld	(_i_main_flag,x),a
9423  1e2b               L1253:
9424                     ; 1922 can_in_an_end:
9424                     ; 1923 bCAN_RX=0;
9426  1e2b 3f0a          	clr	_bCAN_RX
9427                     ; 1924 }   
9430  1e2d 5b05          	addw	sp,#5
9431  1e2f 81            	ret
9454                     ; 1927 void t4_init(void){
9455                     	switch	.text
9456  1e30               _t4_init:
9460                     ; 1928 	TIM4->PSCR = 4;
9462  1e30 35045345      	mov	21317,#4
9463                     ; 1929 	TIM4->ARR= 61;
9465  1e34 353d5346      	mov	21318,#61
9466                     ; 1930 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9468  1e38 72105341      	bset	21313,#0
9469                     ; 1932 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9471  1e3c 35855340      	mov	21312,#133
9472                     ; 1934 }
9475  1e40 81            	ret
9498                     ; 1937 void t1_init(void)
9498                     ; 1938 {
9499                     	switch	.text
9500  1e41               _t1_init:
9504                     ; 1939 TIM1->ARRH= 0x03;
9506  1e41 35035262      	mov	21090,#3
9507                     ; 1940 TIM1->ARRL= 0xff;
9509  1e45 35ff5263      	mov	21091,#255
9510                     ; 1941 TIM1->CCR1H= 0x00;	
9512  1e49 725f5265      	clr	21093
9513                     ; 1942 TIM1->CCR1L= 0xff;
9515  1e4d 35ff5266      	mov	21094,#255
9516                     ; 1943 TIM1->CCR2H= 0x00;	
9518  1e51 725f5267      	clr	21095
9519                     ; 1944 TIM1->CCR2L= 0x00;
9521  1e55 725f5268      	clr	21096
9522                     ; 1945 TIM1->CCR3H= 0x00;	
9524  1e59 725f5269      	clr	21097
9525                     ; 1946 TIM1->CCR3L= 0x64;
9527  1e5d 3564526a      	mov	21098,#100
9528                     ; 1948 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9530  1e61 35685258      	mov	21080,#104
9531                     ; 1949 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9533  1e65 35685259      	mov	21081,#104
9534                     ; 1950 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9536  1e69 3568525a      	mov	21082,#104
9537                     ; 1951 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9539  1e6d 3511525c      	mov	21084,#17
9540                     ; 1952 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9542  1e71 3501525d      	mov	21085,#1
9543                     ; 1953 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9545  1e75 35815250      	mov	21072,#129
9546                     ; 1954 TIM1->BKR|= TIM1_BKR_AOE;
9548  1e79 721c526d      	bset	21101,#6
9549                     ; 1955 }
9552  1e7d 81            	ret
9577                     ; 1959 void adc2_init(void)
9577                     ; 1960 {
9578                     	switch	.text
9579  1e7e               _adc2_init:
9583                     ; 1961 adc_plazma[0]++;
9585  1e7e beb6          	ldw	x,_adc_plazma
9586  1e80 1c0001        	addw	x,#1
9587  1e83 bfb6          	ldw	_adc_plazma,x
9588                     ; 1985 GPIOB->DDR&=~(1<<4);
9590  1e85 72195007      	bres	20487,#4
9591                     ; 1986 GPIOB->CR1&=~(1<<4);
9593  1e89 72195008      	bres	20488,#4
9594                     ; 1987 GPIOB->CR2&=~(1<<4);
9596  1e8d 72195009      	bres	20489,#4
9597                     ; 1989 GPIOB->DDR&=~(1<<5);
9599  1e91 721b5007      	bres	20487,#5
9600                     ; 1990 GPIOB->CR1&=~(1<<5);
9602  1e95 721b5008      	bres	20488,#5
9603                     ; 1991 GPIOB->CR2&=~(1<<5);
9605  1e99 721b5009      	bres	20489,#5
9606                     ; 1993 GPIOB->DDR&=~(1<<6);
9608  1e9d 721d5007      	bres	20487,#6
9609                     ; 1994 GPIOB->CR1&=~(1<<6);
9611  1ea1 721d5008      	bres	20488,#6
9612                     ; 1995 GPIOB->CR2&=~(1<<6);
9614  1ea5 721d5009      	bres	20489,#6
9615                     ; 1997 GPIOB->DDR&=~(1<<7);
9617  1ea9 721f5007      	bres	20487,#7
9618                     ; 1998 GPIOB->CR1&=~(1<<7);
9620  1ead 721f5008      	bres	20488,#7
9621                     ; 1999 GPIOB->CR2&=~(1<<7);
9623  1eb1 721f5009      	bres	20489,#7
9624                     ; 2009 ADC2->TDRL=0xff;
9626  1eb5 35ff5407      	mov	21511,#255
9627                     ; 2011 ADC2->CR2=0x08;
9629  1eb9 35085402      	mov	21506,#8
9630                     ; 2012 ADC2->CR1=0x40;
9632  1ebd 35405401      	mov	21505,#64
9633                     ; 2015 	ADC2->CSR=0x20+adc_ch+3;
9635  1ec1 b6c3          	ld	a,_adc_ch
9636  1ec3 ab23          	add	a,#35
9637  1ec5 c75400        	ld	21504,a
9638                     ; 2017 	ADC2->CR1|=1;
9640  1ec8 72105401      	bset	21505,#0
9641                     ; 2018 	ADC2->CR1|=1;
9643  1ecc 72105401      	bset	21505,#0
9644                     ; 2021 adc_plazma[1]=adc_ch;
9646  1ed0 b6c3          	ld	a,_adc_ch
9647  1ed2 5f            	clrw	x
9648  1ed3 97            	ld	xl,a
9649  1ed4 bfb8          	ldw	_adc_plazma+2,x
9650                     ; 2022 }
9653  1ed6 81            	ret
9687                     ; 2031 @far @interrupt void TIM4_UPD_Interrupt (void) 
9687                     ; 2032 {
9689                     	switch	.text
9690  1ed7               f_TIM4_UPD_Interrupt:
9694                     ; 2033 TIM4->SR1&=~TIM4_SR1_UIF;
9696  1ed7 72115342      	bres	21314,#0
9697                     ; 2035 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9699  1edb 3c08          	inc	_pwm_vent_cnt
9700  1edd b608          	ld	a,_pwm_vent_cnt
9701  1edf a10a          	cp	a,#10
9702  1ee1 2502          	jrult	L3214
9705  1ee3 3f08          	clr	_pwm_vent_cnt
9706  1ee5               L3214:
9707                     ; 2036 GPIOB->ODR|=(1<<3);
9709  1ee5 72165005      	bset	20485,#3
9710                     ; 2037 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9712  1ee9 b608          	ld	a,_pwm_vent_cnt
9713  1eeb a105          	cp	a,#5
9714  1eed 2504          	jrult	L5214
9717  1eef 72175005      	bres	20485,#3
9718  1ef3               L5214:
9719                     ; 2042 if(++t0_cnt0>=100)
9721  1ef3 9c            	rvf
9722  1ef4 be01          	ldw	x,_t0_cnt0
9723  1ef6 1c0001        	addw	x,#1
9724  1ef9 bf01          	ldw	_t0_cnt0,x
9725  1efb a30064        	cpw	x,#100
9726  1efe 2f3f          	jrslt	L7214
9727                     ; 2044 	t0_cnt0=0;
9729  1f00 5f            	clrw	x
9730  1f01 bf01          	ldw	_t0_cnt0,x
9731                     ; 2045 	b100Hz=1;
9733  1f03 72100008      	bset	_b100Hz
9734                     ; 2047 	if(++t0_cnt1>=10)
9736  1f07 3c03          	inc	_t0_cnt1
9737  1f09 b603          	ld	a,_t0_cnt1
9738  1f0b a10a          	cp	a,#10
9739  1f0d 2506          	jrult	L1314
9740                     ; 2049 		t0_cnt1=0;
9742  1f0f 3f03          	clr	_t0_cnt1
9743                     ; 2050 		b10Hz=1;
9745  1f11 72100007      	bset	_b10Hz
9746  1f15               L1314:
9747                     ; 2053 	if(++t0_cnt2>=20)
9749  1f15 3c04          	inc	_t0_cnt2
9750  1f17 b604          	ld	a,_t0_cnt2
9751  1f19 a114          	cp	a,#20
9752  1f1b 2506          	jrult	L3314
9753                     ; 2055 		t0_cnt2=0;
9755  1f1d 3f04          	clr	_t0_cnt2
9756                     ; 2056 		b5Hz=1;
9758  1f1f 72100006      	bset	_b5Hz
9759  1f23               L3314:
9760                     ; 2060 	if(++t0_cnt4>=50)
9762  1f23 3c06          	inc	_t0_cnt4
9763  1f25 b606          	ld	a,_t0_cnt4
9764  1f27 a132          	cp	a,#50
9765  1f29 2506          	jrult	L5314
9766                     ; 2062 		t0_cnt4=0;
9768  1f2b 3f06          	clr	_t0_cnt4
9769                     ; 2063 		b2Hz=1;
9771  1f2d 72100005      	bset	_b2Hz
9772  1f31               L5314:
9773                     ; 2066 	if(++t0_cnt3>=100)
9775  1f31 3c05          	inc	_t0_cnt3
9776  1f33 b605          	ld	a,_t0_cnt3
9777  1f35 a164          	cp	a,#100
9778  1f37 2506          	jrult	L7214
9779                     ; 2068 		t0_cnt3=0;
9781  1f39 3f05          	clr	_t0_cnt3
9782                     ; 2069 		b1Hz=1;
9784  1f3b 72100004      	bset	_b1Hz
9785  1f3f               L7214:
9786                     ; 2075 }
9789  1f3f 80            	iret
9814                     ; 2078 @far @interrupt void CAN_RX_Interrupt (void) 
9814                     ; 2079 {
9815                     	switch	.text
9816  1f40               f_CAN_RX_Interrupt:
9820                     ; 2081 CAN->PSR= 7;									// page 7 - read messsage
9822  1f40 35075427      	mov	21543,#7
9823                     ; 2083 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9825  1f44 ae000e        	ldw	x,#14
9826  1f47               L262:
9827  1f47 d65427        	ld	a,(21543,x)
9828  1f4a e7c3          	ld	(_mess-1,x),a
9829  1f4c 5a            	decw	x
9830  1f4d 26f8          	jrne	L262
9831                     ; 2094 bCAN_RX=1;
9833  1f4f 3501000a      	mov	_bCAN_RX,#1
9834                     ; 2095 CAN->RFR|=(1<<5);
9836  1f53 721a5424      	bset	21540,#5
9837                     ; 2097 }
9840  1f57 80            	iret
9863                     ; 2100 @far @interrupt void CAN_TX_Interrupt (void) 
9863                     ; 2101 {
9864                     	switch	.text
9865  1f58               f_CAN_TX_Interrupt:
9869                     ; 2102 if((CAN->TSR)&(1<<0))
9871  1f58 c65422        	ld	a,21538
9872  1f5b a501          	bcp	a,#1
9873  1f5d 2708          	jreq	L1614
9874                     ; 2104 	bTX_FREE=1;	
9876  1f5f 35010009      	mov	_bTX_FREE,#1
9877                     ; 2106 	CAN->TSR|=(1<<0);
9879  1f63 72105422      	bset	21538,#0
9880  1f67               L1614:
9881                     ; 2108 }
9884  1f67 80            	iret
9942                     ; 2111 @far @interrupt void ADC2_EOC_Interrupt (void) {
9943                     	switch	.text
9944  1f68               f_ADC2_EOC_Interrupt:
9946       00000009      OFST:	set	9
9947  1f68 be00          	ldw	x,c_x
9948  1f6a 89            	pushw	x
9949  1f6b be00          	ldw	x,c_y
9950  1f6d 89            	pushw	x
9951  1f6e be02          	ldw	x,c_lreg+2
9952  1f70 89            	pushw	x
9953  1f71 be00          	ldw	x,c_lreg
9954  1f73 89            	pushw	x
9955  1f74 5209          	subw	sp,#9
9958                     ; 2116 adc_plazma[2]++;
9960  1f76 beba          	ldw	x,_adc_plazma+4
9961  1f78 1c0001        	addw	x,#1
9962  1f7b bfba          	ldw	_adc_plazma+4,x
9963                     ; 2123 ADC2->CSR&=~(1<<7);
9965  1f7d 721f5400      	bres	21504,#7
9966                     ; 2125 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9968  1f81 c65405        	ld	a,21509
9969  1f84 b703          	ld	c_lreg+3,a
9970  1f86 3f02          	clr	c_lreg+2
9971  1f88 3f01          	clr	c_lreg+1
9972  1f8a 3f00          	clr	c_lreg
9973  1f8c 96            	ldw	x,sp
9974  1f8d 1c0001        	addw	x,#OFST-8
9975  1f90 cd0000        	call	c_rtol
9977  1f93 c65404        	ld	a,21508
9978  1f96 5f            	clrw	x
9979  1f97 97            	ld	xl,a
9980  1f98 90ae0100      	ldw	y,#256
9981  1f9c cd0000        	call	c_umul
9983  1f9f 96            	ldw	x,sp
9984  1fa0 1c0001        	addw	x,#OFST-8
9985  1fa3 cd0000        	call	c_ladd
9987  1fa6 96            	ldw	x,sp
9988  1fa7 1c0006        	addw	x,#OFST-3
9989  1faa cd0000        	call	c_rtol
9991                     ; 2130 if(adr_drv_stat==1)
9993  1fad b608          	ld	a,_adr_drv_stat
9994  1faf a101          	cp	a,#1
9995  1fb1 260b          	jrne	L1124
9996                     ; 2132 	adr_drv_stat=2;
9998  1fb3 35020008      	mov	_adr_drv_stat,#2
9999                     ; 2133 	adc_buff_[0]=temp_adc;
10001  1fb7 1e08          	ldw	x,(OFST-1,sp)
10002  1fb9 cf0009        	ldw	_adc_buff_,x
10004  1fbc 2020          	jra	L3124
10005  1fbe               L1124:
10006                     ; 2136 else if(adr_drv_stat==3)
10008  1fbe b608          	ld	a,_adr_drv_stat
10009  1fc0 a103          	cp	a,#3
10010  1fc2 260b          	jrne	L5124
10011                     ; 2138 	adr_drv_stat=4;
10013  1fc4 35040008      	mov	_adr_drv_stat,#4
10014                     ; 2139 	adc_buff_[1]=temp_adc;
10016  1fc8 1e08          	ldw	x,(OFST-1,sp)
10017  1fca cf000b        	ldw	_adc_buff_+2,x
10019  1fcd 200f          	jra	L3124
10020  1fcf               L5124:
10021                     ; 2142 else if(adr_drv_stat==5)
10023  1fcf b608          	ld	a,_adr_drv_stat
10024  1fd1 a105          	cp	a,#5
10025  1fd3 2609          	jrne	L3124
10026                     ; 2144 	adr_drv_stat=6;
10028  1fd5 35060008      	mov	_adr_drv_stat,#6
10029                     ; 2145 	adc_buff_[9]=temp_adc;
10031  1fd9 1e08          	ldw	x,(OFST-1,sp)
10032  1fdb cf001b        	ldw	_adc_buff_+18,x
10033  1fde               L3124:
10034                     ; 2148 adc_buff[adc_ch][adc_cnt]=temp_adc;
10036  1fde b6c2          	ld	a,_adc_cnt
10037  1fe0 5f            	clrw	x
10038  1fe1 97            	ld	xl,a
10039  1fe2 58            	sllw	x
10040  1fe3 1f03          	ldw	(OFST-6,sp),x
10041  1fe5 b6c3          	ld	a,_adc_ch
10042  1fe7 97            	ld	xl,a
10043  1fe8 a620          	ld	a,#32
10044  1fea 42            	mul	x,a
10045  1feb 72fb03        	addw	x,(OFST-6,sp)
10046  1fee 1608          	ldw	y,(OFST-1,sp)
10047  1ff0 df001d        	ldw	(_adc_buff,x),y
10048                     ; 2154 adc_ch++;
10050  1ff3 3cc3          	inc	_adc_ch
10051                     ; 2155 if(adc_ch>=5)
10053  1ff5 b6c3          	ld	a,_adc_ch
10054  1ff7 a105          	cp	a,#5
10055  1ff9 250c          	jrult	L3224
10056                     ; 2158 	adc_ch=0;
10058  1ffb 3fc3          	clr	_adc_ch
10059                     ; 2159 	adc_cnt++;
10061  1ffd 3cc2          	inc	_adc_cnt
10062                     ; 2160 	if(adc_cnt>=16)
10064  1fff b6c2          	ld	a,_adc_cnt
10065  2001 a110          	cp	a,#16
10066  2003 2502          	jrult	L3224
10067                     ; 2162 		adc_cnt=0;
10069  2005 3fc2          	clr	_adc_cnt
10070  2007               L3224:
10071                     ; 2166 if((adc_cnt&0x03)==0)
10073  2007 b6c2          	ld	a,_adc_cnt
10074  2009 a503          	bcp	a,#3
10075  200b 264b          	jrne	L7224
10076                     ; 2170 	tempSS=0;
10078  200d ae0000        	ldw	x,#0
10079  2010 1f08          	ldw	(OFST-1,sp),x
10080  2012 ae0000        	ldw	x,#0
10081  2015 1f06          	ldw	(OFST-3,sp),x
10082                     ; 2171 	for(i=0;i<16;i++)
10084  2017 0f05          	clr	(OFST-4,sp)
10085  2019               L1324:
10086                     ; 2173 		tempSS+=(signed long)adc_buff[adc_ch][i];
10088  2019 7b05          	ld	a,(OFST-4,sp)
10089  201b 5f            	clrw	x
10090  201c 97            	ld	xl,a
10091  201d 58            	sllw	x
10092  201e 1f03          	ldw	(OFST-6,sp),x
10093  2020 b6c3          	ld	a,_adc_ch
10094  2022 97            	ld	xl,a
10095  2023 a620          	ld	a,#32
10096  2025 42            	mul	x,a
10097  2026 72fb03        	addw	x,(OFST-6,sp)
10098  2029 de001d        	ldw	x,(_adc_buff,x)
10099  202c cd0000        	call	c_itolx
10101  202f 96            	ldw	x,sp
10102  2030 1c0006        	addw	x,#OFST-3
10103  2033 cd0000        	call	c_lgadd
10105                     ; 2171 	for(i=0;i<16;i++)
10107  2036 0c05          	inc	(OFST-4,sp)
10110  2038 7b05          	ld	a,(OFST-4,sp)
10111  203a a110          	cp	a,#16
10112  203c 25db          	jrult	L1324
10113                     ; 2175 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
10115  203e 96            	ldw	x,sp
10116  203f 1c0006        	addw	x,#OFST-3
10117  2042 cd0000        	call	c_ltor
10119  2045 a604          	ld	a,#4
10120  2047 cd0000        	call	c_lrsh
10122  204a be02          	ldw	x,c_lreg+2
10123  204c b6c3          	ld	a,_adc_ch
10124  204e 905f          	clrw	y
10125  2050 9097          	ld	yl,a
10126  2052 9058          	sllw	y
10127  2054 90df0009      	ldw	(_adc_buff_,y),x
10128  2058               L7224:
10129                     ; 2186 adc_plazma_short++;
10131  2058 bec0          	ldw	x,_adc_plazma_short
10132  205a 1c0001        	addw	x,#1
10133  205d bfc0          	ldw	_adc_plazma_short,x
10134                     ; 2201 }
10137  205f 5b09          	addw	sp,#9
10138  2061 85            	popw	x
10139  2062 bf00          	ldw	c_lreg,x
10140  2064 85            	popw	x
10141  2065 bf02          	ldw	c_lreg+2,x
10142  2067 85            	popw	x
10143  2068 bf00          	ldw	c_y,x
10144  206a 85            	popw	x
10145  206b bf00          	ldw	c_x,x
10146  206d 80            	iret
10210                     ; 2209 main()
10210                     ; 2210 {
10212                     	switch	.text
10213  206e               _main:
10217                     ; 2212 CLK->ECKR|=1;
10219  206e 721050c1      	bset	20673,#0
10221  2072               L1524:
10222                     ; 2213 while((CLK->ECKR & 2) == 0);
10224  2072 c650c1        	ld	a,20673
10225  2075 a502          	bcp	a,#2
10226  2077 27f9          	jreq	L1524
10227                     ; 2214 CLK->SWCR|=2;
10229  2079 721250c5      	bset	20677,#1
10230                     ; 2215 CLK->SWR=0xB4;
10232  207d 35b450c4      	mov	20676,#180
10233                     ; 2217 delay_ms(200);
10235  2081 ae00c8        	ldw	x,#200
10236  2084 cd011d        	call	_delay_ms
10238                     ; 2218 FLASH_DUKR=0xae;
10240  2087 35ae5064      	mov	_FLASH_DUKR,#174
10241                     ; 2219 FLASH_DUKR=0x56;
10243  208b 35565064      	mov	_FLASH_DUKR,#86
10244                     ; 2220 enableInterrupts();
10247  208f 9a            rim
10249                     ; 2223 adr_drv_v3();
10252  2090 cd126d        	call	_adr_drv_v3
10254                     ; 2226 BLOCK_INIT
10256  2093 72145007      	bset	20487,#2
10259  2097 72145008      	bset	20488,#2
10262  209b 72155009      	bres	20489,#2
10263                     ; 2228 t4_init();
10265  209f cd1e30        	call	_t4_init
10267                     ; 2230 		GPIOG->DDR|=(1<<0);
10269  20a2 72105020      	bset	20512,#0
10270                     ; 2231 		GPIOG->CR1|=(1<<0);
10272  20a6 72105021      	bset	20513,#0
10273                     ; 2232 		GPIOG->CR2&=~(1<<0);	
10275  20aa 72115022      	bres	20514,#0
10276                     ; 2235 		GPIOG->DDR&=~(1<<1);
10278  20ae 72135020      	bres	20512,#1
10279                     ; 2236 		GPIOG->CR1|=(1<<1);
10281  20b2 72125021      	bset	20513,#1
10282                     ; 2237 		GPIOG->CR2&=~(1<<1);
10284  20b6 72135022      	bres	20514,#1
10285                     ; 2239 init_CAN();
10287  20ba cd15b0        	call	_init_CAN
10289                     ; 2244 GPIOC->DDR|=(1<<1);
10291  20bd 7212500c      	bset	20492,#1
10292                     ; 2245 GPIOC->CR1|=(1<<1);
10294  20c1 7212500d      	bset	20493,#1
10295                     ; 2246 GPIOC->CR2|=(1<<1);
10297  20c5 7212500e      	bset	20494,#1
10298                     ; 2248 GPIOC->DDR|=(1<<2);
10300  20c9 7214500c      	bset	20492,#2
10301                     ; 2249 GPIOC->CR1|=(1<<2);
10303  20cd 7214500d      	bset	20493,#2
10304                     ; 2250 GPIOC->CR2|=(1<<2);
10306  20d1 7214500e      	bset	20494,#2
10307                     ; 2257 t1_init();
10309  20d5 cd1e41        	call	_t1_init
10311                     ; 2259 GPIOA->DDR|=(1<<5);
10313  20d8 721a5002      	bset	20482,#5
10314                     ; 2260 GPIOA->CR1|=(1<<5);
10316  20dc 721a5003      	bset	20483,#5
10317                     ; 2261 GPIOA->CR2&=~(1<<5);
10319  20e0 721b5004      	bres	20484,#5
10320                     ; 2267 GPIOB->DDR&=~(1<<3);
10322  20e4 72175007      	bres	20487,#3
10323                     ; 2268 GPIOB->CR1&=~(1<<3);
10325  20e8 72175008      	bres	20488,#3
10326                     ; 2269 GPIOB->CR2&=~(1<<3);
10328  20ec 72175009      	bres	20489,#3
10329                     ; 2271 GPIOC->DDR|=(1<<3);
10331  20f0 7216500c      	bset	20492,#3
10332                     ; 2272 GPIOC->CR1|=(1<<3);
10334  20f4 7216500d      	bset	20493,#3
10335                     ; 2273 GPIOC->CR2|=(1<<3);
10337  20f8 7216500e      	bset	20494,#3
10338                     ; 2276 if(bps_class==bpsIPS) 
10340  20fc b604          	ld	a,_bps_class
10341  20fe a101          	cp	a,#1
10342  2100 260a          	jrne	L7524
10343                     ; 2278 	pwm_u=ee_U_AVT;
10345  2102 ce000c        	ldw	x,_ee_U_AVT
10346  2105 bf0e          	ldw	_pwm_u,x
10347                     ; 2279 	volum_u_main_=ee_U_AVT;
10349  2107 ce000c        	ldw	x,_ee_U_AVT
10350  210a bf1f          	ldw	_volum_u_main_,x
10351  210c               L7524:
10352                     ; 2286 	if(bCAN_RX)
10354  210c 3d0a          	tnz	_bCAN_RX
10355  210e 2705          	jreq	L3624
10356                     ; 2288 		bCAN_RX=0;
10358  2110 3f0a          	clr	_bCAN_RX
10359                     ; 2289 		can_in_an();	
10361  2112 cd17bb        	call	_can_in_an
10363  2115               L3624:
10364                     ; 2291 	if(b100Hz)
10366                     	btst	_b100Hz
10367  211a 240a          	jruge	L5624
10368                     ; 2293 		b100Hz=0;
10370  211c 72110008      	bres	_b100Hz
10371                     ; 2302 		adc2_init();
10373  2120 cd1e7e        	call	_adc2_init
10375                     ; 2303 		can_tx_hndl();
10377  2123 cd16a3        	call	_can_tx_hndl
10379  2126               L5624:
10380                     ; 2306 	if(b10Hz)
10382                     	btst	_b10Hz
10383  212b 2419          	jruge	L7624
10384                     ; 2308 		b10Hz=0;
10386  212d 72110007      	bres	_b10Hz
10387                     ; 2310 		matemat();
10389  2131 cd0dd4        	call	_matemat
10391                     ; 2311 		led_drv(); 
10393  2134 cd07e2        	call	_led_drv
10395                     ; 2312 	  link_drv();
10397  2137 cd08d0        	call	_link_drv
10399                     ; 2313 	  pwr_hndl();		//вычисление воздействий на силу
10401  213a cd0bd7        	call	_pwr_hndl
10403                     ; 2314 	  JP_drv();
10405  213d cd0845        	call	_JP_drv
10407                     ; 2315 	  flags_drv();
10409  2140 cd1222        	call	_flags_drv
10411                     ; 2316 		net_drv();
10413  2143 cd170d        	call	_net_drv
10415  2146               L7624:
10416                     ; 2319 	if(b5Hz)
10418                     	btst	_b5Hz
10419  214b 240d          	jruge	L1724
10420                     ; 2321 		b5Hz=0;
10422  214d 72110006      	bres	_b5Hz
10423                     ; 2323 		pwr_drv();		//воздействие на силу
10425  2151 cd0a8b        	call	_pwr_drv
10427                     ; 2324 		led_hndl();
10429  2154 cd015f        	call	_led_hndl
10431                     ; 2326 		vent_drv();
10433  2157 cd0928        	call	_vent_drv
10435  215a               L1724:
10436                     ; 2329 	if(b2Hz)
10438                     	btst	_b2Hz
10439  215f 2404          	jruge	L3724
10440                     ; 2331 		b2Hz=0;
10442  2161 72110005      	bres	_b2Hz
10443  2165               L3724:
10444                     ; 2340 	if(b1Hz)
10446                     	btst	_b1Hz
10447  216a 24a0          	jruge	L7524
10448                     ; 2342 		b1Hz=0;
10450  216c 72110004      	bres	_b1Hz
10451                     ; 2344 		temper_drv();			//вычисление аварий температуры
10453  2170 cd0f52        	call	_temper_drv
10455                     ; 2345 		u_drv();
10457  2173 cd1029        	call	_u_drv
10459                     ; 2346           x_drv();
10461  2176 cd1109        	call	_x_drv
10463                     ; 2347           if(main_cnt<1000)main_cnt++;
10465  2179 9c            	rvf
10466  217a be51          	ldw	x,_main_cnt
10467  217c a303e8        	cpw	x,#1000
10468  217f 2e07          	jrsge	L7724
10471  2181 be51          	ldw	x,_main_cnt
10472  2183 1c0001        	addw	x,#1
10473  2186 bf51          	ldw	_main_cnt,x
10474  2188               L7724:
10475                     ; 2348   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10477  2188 b663          	ld	a,_link
10478  218a a1aa          	cp	a,#170
10479  218c 2706          	jreq	L3034
10481  218e b64a          	ld	a,_jp_mode
10482  2190 a103          	cp	a,#3
10483  2192 2603          	jrne	L1034
10484  2194               L3034:
10487  2194 cd1183        	call	_apv_hndl
10489  2197               L1034:
10490                     ; 2351   		can_error_cnt++;
10492  2197 3c71          	inc	_can_error_cnt
10493                     ; 2352   		if(can_error_cnt>=10)
10495  2199 b671          	ld	a,_can_error_cnt
10496  219b a10a          	cp	a,#10
10497  219d 2505          	jrult	L5034
10498                     ; 2354   			can_error_cnt=0;
10500  219f 3f71          	clr	_can_error_cnt
10501                     ; 2355 			init_CAN();
10503  21a1 cd15b0        	call	_init_CAN
10505  21a4               L5034:
10506                     ; 2359 		volum_u_main_drv();
10508  21a4 cd145d        	call	_volum_u_main_drv
10510                     ; 2361 		pwm_stat++;
10512  21a7 3c07          	inc	_pwm_stat
10513                     ; 2362 		if(pwm_stat>=10)pwm_stat=0;
10515  21a9 b607          	ld	a,_pwm_stat
10516  21ab a10a          	cp	a,#10
10517  21ad 2502          	jrult	L7034
10520  21af 3f07          	clr	_pwm_stat
10521  21b1               L7034:
10522                     ; 2363 adc_plazma_short++;
10524  21b1 bec0          	ldw	x,_adc_plazma_short
10525  21b3 1c0001        	addw	x,#1
10526  21b6 bfc0          	ldw	_adc_plazma_short,x
10527                     ; 2365 		vent_resurs_hndl();
10529  21b8 cd0000        	call	_vent_resurs_hndl
10531  21bb ac0c210c      	jpf	L7524
11601                     	xdef	_main
11602                     	xdef	f_ADC2_EOC_Interrupt
11603                     	xdef	f_CAN_TX_Interrupt
11604                     	xdef	f_CAN_RX_Interrupt
11605                     	xdef	f_TIM4_UPD_Interrupt
11606                     	xdef	_adc2_init
11607                     	xdef	_t1_init
11608                     	xdef	_t4_init
11609                     	xdef	_can_in_an
11610                     	xdef	_net_drv
11611                     	xdef	_can_tx_hndl
11612                     	xdef	_can_transmit
11613                     	xdef	_init_CAN
11614                     	xdef	_volum_u_main_drv
11615                     	xdef	_adr_drv_v3
11616                     	xdef	_adr_drv_v4
11617                     	xdef	_flags_drv
11618                     	xdef	_apv_hndl
11619                     	xdef	_apv_stop
11620                     	xdef	_apv_start
11621                     	xdef	_x_drv
11622                     	xdef	_u_drv
11623                     	xdef	_temper_drv
11624                     	xdef	_matemat
11625                     	xdef	_pwr_hndl
11626                     	xdef	_pwr_drv
11627                     	xdef	_vent_drv
11628                     	xdef	_link_drv
11629                     	xdef	_JP_drv
11630                     	xdef	_led_drv
11631                     	xdef	_led_hndl
11632                     	xdef	_delay_ms
11633                     	xdef	_granee
11634                     	xdef	_gran
11635                     	xdef	_vent_resurs_hndl
11636                     	switch	.ubsct
11637  0001               _vent_resurs_tx_cnt:
11638  0001 00            	ds.b	1
11639                     	xdef	_vent_resurs_tx_cnt
11640                     	switch	.bss
11641  0000               _vent_resurs_buff:
11642  0000 00000000      	ds.b	4
11643                     	xdef	_vent_resurs_buff
11644                     	switch	.ubsct
11645  0002               _vent_resurs_sec_cnt:
11646  0002 0000          	ds.b	2
11647                     	xdef	_vent_resurs_sec_cnt
11648                     .eeprom:	section	.data
11649  0000               _vent_resurs:
11650  0000 0000          	ds.b	2
11651                     	xdef	_vent_resurs
11652  0002               _ee_IMAXVENT:
11653  0002 0000          	ds.b	2
11654                     	xdef	_ee_IMAXVENT
11655                     	switch	.ubsct
11656  0004               _bps_class:
11657  0004 00            	ds.b	1
11658                     	xdef	_bps_class
11659  0005               _vent_pwm:
11660  0005 0000          	ds.b	2
11661                     	xdef	_vent_pwm
11662  0007               _pwm_stat:
11663  0007 00            	ds.b	1
11664                     	xdef	_pwm_stat
11665  0008               _pwm_vent_cnt:
11666  0008 00            	ds.b	1
11667                     	xdef	_pwm_vent_cnt
11668                     	switch	.eeprom
11669  0004               _ee_DEVICE:
11670  0004 0000          	ds.b	2
11671                     	xdef	_ee_DEVICE
11672  0006               _ee_AVT_MODE:
11673  0006 0000          	ds.b	2
11674                     	xdef	_ee_AVT_MODE
11675                     	switch	.ubsct
11676  0009               _i_main_bps_cnt:
11677  0009 000000000000  	ds.b	6
11678                     	xdef	_i_main_bps_cnt
11679  000f               _i_main_sigma:
11680  000f 0000          	ds.b	2
11681                     	xdef	_i_main_sigma
11682  0011               _i_main_num_of_bps:
11683  0011 00            	ds.b	1
11684                     	xdef	_i_main_num_of_bps
11685  0012               _i_main_avg:
11686  0012 0000          	ds.b	2
11687                     	xdef	_i_main_avg
11688  0014               _i_main_flag:
11689  0014 000000000000  	ds.b	6
11690                     	xdef	_i_main_flag
11691  001a               _i_main:
11692  001a 000000000000  	ds.b	12
11693                     	xdef	_i_main
11694  0026               _x:
11695  0026 000000000000  	ds.b	12
11696                     	xdef	_x
11697                     	xdef	_volum_u_main_
11698                     	switch	.eeprom
11699  0008               _UU_AVT:
11700  0008 0000          	ds.b	2
11701                     	xdef	_UU_AVT
11702                     	switch	.ubsct
11703  0032               _cnt_net_drv:
11704  0032 00            	ds.b	1
11705                     	xdef	_cnt_net_drv
11706                     	switch	.bit
11707  0001               _bMAIN:
11708  0001 00            	ds.b	1
11709                     	xdef	_bMAIN
11710                     	switch	.ubsct
11711  0033               _plazma_int:
11712  0033 000000000000  	ds.b	6
11713                     	xdef	_plazma_int
11714                     	xdef	_rotor_int
11715  0039               _led_green_buff:
11716  0039 00000000      	ds.b	4
11717                     	xdef	_led_green_buff
11718  003d               _led_red_buff:
11719  003d 00000000      	ds.b	4
11720                     	xdef	_led_red_buff
11721                     	xdef	_led_drv_cnt
11722                     	xdef	_led_green
11723                     	xdef	_led_red
11724  0041               _res_fl_cnt:
11725  0041 00            	ds.b	1
11726                     	xdef	_res_fl_cnt
11727                     	xdef	_bRES_
11728                     	xdef	_bRES
11729                     	switch	.eeprom
11730  000a               _res_fl_:
11731  000a 00            	ds.b	1
11732                     	xdef	_res_fl_
11733  000b               _res_fl:
11734  000b 00            	ds.b	1
11735                     	xdef	_res_fl
11736                     	switch	.ubsct
11737  0042               _cnt_apv_off:
11738  0042 00            	ds.b	1
11739                     	xdef	_cnt_apv_off
11740                     	switch	.bit
11741  0002               _bAPV:
11742  0002 00            	ds.b	1
11743                     	xdef	_bAPV
11744                     	switch	.ubsct
11745  0043               _apv_cnt_:
11746  0043 0000          	ds.b	2
11747                     	xdef	_apv_cnt_
11748  0045               _apv_cnt:
11749  0045 000000        	ds.b	3
11750                     	xdef	_apv_cnt
11751                     	xdef	_bBL_IPS
11752                     	switch	.bit
11753  0003               _bBL:
11754  0003 00            	ds.b	1
11755                     	xdef	_bBL
11756                     	switch	.ubsct
11757  0048               _cnt_JP1:
11758  0048 00            	ds.b	1
11759                     	xdef	_cnt_JP1
11760  0049               _cnt_JP0:
11761  0049 00            	ds.b	1
11762                     	xdef	_cnt_JP0
11763  004a               _jp_mode:
11764  004a 00            	ds.b	1
11765                     	xdef	_jp_mode
11766                     	xdef	_pwm_i
11767                     	xdef	_pwm_u
11768  004b               _tmax_cnt:
11769  004b 0000          	ds.b	2
11770                     	xdef	_tmax_cnt
11771  004d               _tsign_cnt:
11772  004d 0000          	ds.b	2
11773                     	xdef	_tsign_cnt
11774                     	switch	.eeprom
11775  000c               _ee_U_AVT:
11776  000c 0000          	ds.b	2
11777                     	xdef	_ee_U_AVT
11778  000e               _ee_tsign:
11779  000e 0000          	ds.b	2
11780                     	xdef	_ee_tsign
11781  0010               _ee_tmax:
11782  0010 0000          	ds.b	2
11783                     	xdef	_ee_tmax
11784  0012               _ee_dU:
11785  0012 0000          	ds.b	2
11786                     	xdef	_ee_dU
11787  0014               _ee_Umax:
11788  0014 0000          	ds.b	2
11789                     	xdef	_ee_Umax
11790  0016               _ee_TZAS:
11791  0016 0000          	ds.b	2
11792                     	xdef	_ee_TZAS
11793                     	switch	.ubsct
11794  004f               _main_cnt1:
11795  004f 0000          	ds.b	2
11796                     	xdef	_main_cnt1
11797  0051               _main_cnt:
11798  0051 0000          	ds.b	2
11799                     	xdef	_main_cnt
11800  0053               _off_bp_cnt:
11801  0053 00            	ds.b	1
11802                     	xdef	_off_bp_cnt
11803                     	xdef	_vol_i_temp_avar
11804  0054               _flags_tu_cnt_off:
11805  0054 00            	ds.b	1
11806                     	xdef	_flags_tu_cnt_off
11807  0055               _flags_tu_cnt_on:
11808  0055 00            	ds.b	1
11809                     	xdef	_flags_tu_cnt_on
11810  0056               _vol_i_temp:
11811  0056 0000          	ds.b	2
11812                     	xdef	_vol_i_temp
11813  0058               _vol_u_temp:
11814  0058 0000          	ds.b	2
11815                     	xdef	_vol_u_temp
11816                     	switch	.eeprom
11817  0018               __x_ee_:
11818  0018 0000          	ds.b	2
11819                     	xdef	__x_ee_
11820                     	switch	.ubsct
11821  005a               __x_cnt:
11822  005a 0000          	ds.b	2
11823                     	xdef	__x_cnt
11824  005c               __x__:
11825  005c 0000          	ds.b	2
11826                     	xdef	__x__
11827  005e               __x_:
11828  005e 0000          	ds.b	2
11829                     	xdef	__x_
11830  0060               _flags_tu:
11831  0060 00            	ds.b	1
11832                     	xdef	_flags_tu
11833                     	xdef	_flags
11834  0061               _link_cnt:
11835  0061 0000          	ds.b	2
11836                     	xdef	_link_cnt
11837  0063               _link:
11838  0063 00            	ds.b	1
11839                     	xdef	_link
11840  0064               _umin_cnt:
11841  0064 0000          	ds.b	2
11842                     	xdef	_umin_cnt
11843  0066               _umax_cnt:
11844  0066 0000          	ds.b	2
11845                     	xdef	_umax_cnt
11846                     	switch	.eeprom
11847  001a               _ee_K:
11848  001a 000000000000  	ds.b	16
11849                     	xdef	_ee_K
11850                     	switch	.ubsct
11851  0068               _T:
11852  0068 00            	ds.b	1
11853                     	xdef	_T
11854  0069               _Udb:
11855  0069 0000          	ds.b	2
11856                     	xdef	_Udb
11857  006b               _Ui:
11858  006b 0000          	ds.b	2
11859                     	xdef	_Ui
11860  006d               _Un:
11861  006d 0000          	ds.b	2
11862                     	xdef	_Un
11863  006f               _I:
11864  006f 0000          	ds.b	2
11865                     	xdef	_I
11866  0071               _can_error_cnt:
11867  0071 00            	ds.b	1
11868                     	xdef	_can_error_cnt
11869                     	xdef	_bCAN_RX
11870  0072               _tx_busy_cnt:
11871  0072 00            	ds.b	1
11872                     	xdef	_tx_busy_cnt
11873                     	xdef	_bTX_FREE
11874  0073               _can_buff_rd_ptr:
11875  0073 00            	ds.b	1
11876                     	xdef	_can_buff_rd_ptr
11877  0074               _can_buff_wr_ptr:
11878  0074 00            	ds.b	1
11879                     	xdef	_can_buff_wr_ptr
11880  0075               _can_out_buff:
11881  0075 000000000000  	ds.b	64
11882                     	xdef	_can_out_buff
11883                     	switch	.bss
11884  0004               _adress_error:
11885  0004 00            	ds.b	1
11886                     	xdef	_adress_error
11887  0005               _adress:
11888  0005 00            	ds.b	1
11889                     	xdef	_adress
11890  0006               _adr:
11891  0006 000000        	ds.b	3
11892                     	xdef	_adr
11893                     	xdef	_adr_drv_stat
11894                     	xdef	_led_ind
11895                     	switch	.ubsct
11896  00b5               _led_ind_cnt:
11897  00b5 00            	ds.b	1
11898                     	xdef	_led_ind_cnt
11899  00b6               _adc_plazma:
11900  00b6 000000000000  	ds.b	10
11901                     	xdef	_adc_plazma
11902  00c0               _adc_plazma_short:
11903  00c0 0000          	ds.b	2
11904                     	xdef	_adc_plazma_short
11905  00c2               _adc_cnt:
11906  00c2 00            	ds.b	1
11907                     	xdef	_adc_cnt
11908  00c3               _adc_ch:
11909  00c3 00            	ds.b	1
11910                     	xdef	_adc_ch
11911                     	switch	.bss
11912  0009               _adc_buff_:
11913  0009 000000000000  	ds.b	20
11914                     	xdef	_adc_buff_
11915  001d               _adc_buff:
11916  001d 000000000000  	ds.b	320
11917                     	xdef	_adc_buff
11918                     	switch	.ubsct
11919  00c4               _mess:
11920  00c4 000000000000  	ds.b	14
11921                     	xdef	_mess
11922                     	switch	.bit
11923  0004               _b1Hz:
11924  0004 00            	ds.b	1
11925                     	xdef	_b1Hz
11926  0005               _b2Hz:
11927  0005 00            	ds.b	1
11928                     	xdef	_b2Hz
11929  0006               _b5Hz:
11930  0006 00            	ds.b	1
11931                     	xdef	_b5Hz
11932  0007               _b10Hz:
11933  0007 00            	ds.b	1
11934                     	xdef	_b10Hz
11935  0008               _b100Hz:
11936  0008 00            	ds.b	1
11937                     	xdef	_b100Hz
11938                     	xdef	_t0_cnt4
11939                     	xdef	_t0_cnt3
11940                     	xdef	_t0_cnt2
11941                     	xdef	_t0_cnt1
11942                     	xdef	_t0_cnt0
11943                     	xdef	_bVENT_BLOCK
11944                     	xref.b	c_lreg
11945                     	xref.b	c_x
11946                     	xref.b	c_y
11966                     	xref	c_lrsh
11967                     	xref	c_lgadd
11968                     	xref	c_ladd
11969                     	xref	c_umul
11970                     	xref	c_lgmul
11971                     	xref	c_lgsub
11972                     	xref	c_lsbc
11973                     	xref	c_idiv
11974                     	xref	c_ldiv
11975                     	xref	c_itolx
11976                     	xref	c_eewrc
11977                     	xref	c_imul
11978                     	xref	c_ltor
11979                     	xref	c_lgadc
11980                     	xref	c_rtol
11981                     	xref	c_vmul
11982                     	xref	c_eewrw
11983                     	xref	c_lcmp
11984                     	xref	c_uitolx
11985                     	end
