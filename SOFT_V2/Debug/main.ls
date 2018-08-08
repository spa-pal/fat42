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
4837                     ; 769 if((bps_class==bpsIBEP)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
4839  0b84 3d04          	tnz	_bps_class
4840  0b86 2617          	jrne	L1142
4842  0b88 9c            	rvf
4843  0b89 ce0016        	ldw	x,_ee_TZAS
4844  0b8c 90ae0005      	ldw	y,#5
4845  0b90 cd0000        	call	c_imul
4847  0b93 1c0032        	addw	x,#50
4848  0b96 b34f          	cpw	x,_main_cnt1
4849  0b98 2d05          	jrsle	L1142
4852  0b9a ae000a        	ldw	x,#10
4853  0b9d bf0e          	ldw	_pwm_u,x
4854  0b9f               L1142:
4855                     ; 779 TIM1->CCR2H= (char)(pwm_u/256);	
4857  0b9f be0e          	ldw	x,_pwm_u
4858  0ba1 90ae0100      	ldw	y,#256
4859  0ba5 cd0000        	call	c_idiv
4861  0ba8 9f            	ld	a,xl
4862  0ba9 c75267        	ld	21095,a
4863                     ; 780 TIM1->CCR2L= (char)pwm_u;
4865  0bac 55000f5268    	mov	21096,_pwm_u+1
4866                     ; 782 TIM1->CCR1H= (char)(pwm_i/256);	
4868  0bb1 be10          	ldw	x,_pwm_i
4869  0bb3 90ae0100      	ldw	y,#256
4870  0bb7 cd0000        	call	c_idiv
4872  0bba 9f            	ld	a,xl
4873  0bbb c75265        	ld	21093,a
4874                     ; 783 TIM1->CCR1L= (char)pwm_i;
4876  0bbe 5500115266    	mov	21094,_pwm_i+1
4877                     ; 785 TIM1->CCR3H= (char)(vent_pwm/256);	
4879  0bc3 be05          	ldw	x,_vent_pwm
4880  0bc5 90ae0100      	ldw	y,#256
4881  0bc9 cd0000        	call	c_idiv
4883  0bcc 9f            	ld	a,xl
4884  0bcd c75269        	ld	21097,a
4885                     ; 786 TIM1->CCR3L= (char)vent_pwm;
4887  0bd0 550006526a    	mov	21098,_vent_pwm+1
4888                     ; 787 }
4891  0bd5 81            	ret
4930                     ; 792 void pwr_hndl(void)				
4930                     ; 793 {
4931                     	switch	.text
4932  0bd6               _pwr_hndl:
4936                     ; 794 if(jp_mode==jp3)
4938  0bd6 b64a          	ld	a,_jp_mode
4939  0bd8 a103          	cp	a,#3
4940  0bda 2646          	jrne	L3242
4941                     ; 796 	if((flags&0b00001010)==0)
4943  0bdc b60b          	ld	a,_flags
4944  0bde a50a          	bcp	a,#10
4945  0be0 2629          	jrne	L5242
4946                     ; 798 		pwm_u=500;
4948  0be2 ae01f4        	ldw	x,#500
4949  0be5 bf0e          	ldw	_pwm_u,x
4950                     ; 799 		if(pwm_i<1020)
4952  0be7 9c            	rvf
4953  0be8 be10          	ldw	x,_pwm_i
4954  0bea a303fc        	cpw	x,#1020
4955  0bed 2e14          	jrsge	L7242
4956                     ; 801 			pwm_i+=30;
4958  0bef be10          	ldw	x,_pwm_i
4959  0bf1 1c001e        	addw	x,#30
4960  0bf4 bf10          	ldw	_pwm_i,x
4961                     ; 802 			if(pwm_i>1020)pwm_i=1020;
4963  0bf6 9c            	rvf
4964  0bf7 be10          	ldw	x,_pwm_i
4965  0bf9 a303fd        	cpw	x,#1021
4966  0bfc 2f05          	jrslt	L7242
4969  0bfe ae03fc        	ldw	x,#1020
4970  0c01 bf10          	ldw	_pwm_i,x
4971  0c03               L7242:
4972                     ; 804 		bBL=0;
4974  0c03 72110003      	bres	_bBL
4976  0c07 acd20dd2      	jpf	L7342
4977  0c0b               L5242:
4978                     ; 806 	else if(flags&0b00001010)
4980  0c0b b60b          	ld	a,_flags
4981  0c0d a50a          	bcp	a,#10
4982  0c0f 2603          	jrne	L46
4983  0c11 cc0dd2        	jp	L7342
4984  0c14               L46:
4985                     ; 808 		pwm_u=0;
4987  0c14 5f            	clrw	x
4988  0c15 bf0e          	ldw	_pwm_u,x
4989                     ; 809 		pwm_i=0;
4991  0c17 5f            	clrw	x
4992  0c18 bf10          	ldw	_pwm_i,x
4993                     ; 810 		bBL=1;
4995  0c1a 72100003      	bset	_bBL
4996  0c1e acd20dd2      	jpf	L7342
4997  0c22               L3242:
4998                     ; 814 else if(jp_mode==jp2)
5000  0c22 b64a          	ld	a,_jp_mode
5001  0c24 a102          	cp	a,#2
5002  0c26 2627          	jrne	L1442
5003                     ; 816 	pwm_u=0;
5005  0c28 5f            	clrw	x
5006  0c29 bf0e          	ldw	_pwm_u,x
5007                     ; 818 	if(pwm_i<1020)
5009  0c2b 9c            	rvf
5010  0c2c be10          	ldw	x,_pwm_i
5011  0c2e a303fc        	cpw	x,#1020
5012  0c31 2e14          	jrsge	L3442
5013                     ; 820 		pwm_i+=30;
5015  0c33 be10          	ldw	x,_pwm_i
5016  0c35 1c001e        	addw	x,#30
5017  0c38 bf10          	ldw	_pwm_i,x
5018                     ; 821 		if(pwm_i>1020)pwm_i=1020;
5020  0c3a 9c            	rvf
5021  0c3b be10          	ldw	x,_pwm_i
5022  0c3d a303fd        	cpw	x,#1021
5023  0c40 2f05          	jrslt	L3442
5026  0c42 ae03fc        	ldw	x,#1020
5027  0c45 bf10          	ldw	_pwm_i,x
5028  0c47               L3442:
5029                     ; 823 	bBL=0;
5031  0c47 72110003      	bres	_bBL
5033  0c4b acd20dd2      	jpf	L7342
5034  0c4f               L1442:
5035                     ; 825 else if(jp_mode==jp1)
5037  0c4f b64a          	ld	a,_jp_mode
5038  0c51 a101          	cp	a,#1
5039  0c53 2629          	jrne	L1542
5040                     ; 827 	pwm_u=0x3ff;
5042  0c55 ae03ff        	ldw	x,#1023
5043  0c58 bf0e          	ldw	_pwm_u,x
5044                     ; 829 	if(pwm_i<1020)
5046  0c5a 9c            	rvf
5047  0c5b be10          	ldw	x,_pwm_i
5048  0c5d a303fc        	cpw	x,#1020
5049  0c60 2e14          	jrsge	L3542
5050                     ; 831 		pwm_i+=30;
5052  0c62 be10          	ldw	x,_pwm_i
5053  0c64 1c001e        	addw	x,#30
5054  0c67 bf10          	ldw	_pwm_i,x
5055                     ; 832 		if(pwm_i>1020)pwm_i=1020;
5057  0c69 9c            	rvf
5058  0c6a be10          	ldw	x,_pwm_i
5059  0c6c a303fd        	cpw	x,#1021
5060  0c6f 2f05          	jrslt	L3542
5063  0c71 ae03fc        	ldw	x,#1020
5064  0c74 bf10          	ldw	_pwm_i,x
5065  0c76               L3542:
5066                     ; 834 	bBL=0;
5068  0c76 72110003      	bres	_bBL
5070  0c7a acd20dd2      	jpf	L7342
5071  0c7e               L1542:
5072                     ; 837 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
5074                     	btst	_bMAIN
5075  0c83 242e          	jruge	L1642
5077  0c85 b663          	ld	a,_link
5078  0c87 a155          	cp	a,#85
5079  0c89 2628          	jrne	L1642
5080                     ; 839 	pwm_u=volum_u_main_;
5082  0c8b be1f          	ldw	x,_volum_u_main_
5083  0c8d bf0e          	ldw	_pwm_u,x
5084                     ; 841 	if(pwm_i<1020)
5086  0c8f 9c            	rvf
5087  0c90 be10          	ldw	x,_pwm_i
5088  0c92 a303fc        	cpw	x,#1020
5089  0c95 2e14          	jrsge	L3642
5090                     ; 843 		pwm_i+=30;
5092  0c97 be10          	ldw	x,_pwm_i
5093  0c99 1c001e        	addw	x,#30
5094  0c9c bf10          	ldw	_pwm_i,x
5095                     ; 844 		if(pwm_i>1020)pwm_i=1020;
5097  0c9e 9c            	rvf
5098  0c9f be10          	ldw	x,_pwm_i
5099  0ca1 a303fd        	cpw	x,#1021
5100  0ca4 2f05          	jrslt	L3642
5103  0ca6 ae03fc        	ldw	x,#1020
5104  0ca9 bf10          	ldw	_pwm_i,x
5105  0cab               L3642:
5106                     ; 846 	bBL_IPS=0;
5108  0cab 72110000      	bres	_bBL_IPS
5110  0caf acd20dd2      	jpf	L7342
5111  0cb3               L1642:
5112                     ; 849 else if(link==OFF)
5114  0cb3 b663          	ld	a,_link
5115  0cb5 a1aa          	cp	a,#170
5116  0cb7 266f          	jrne	L1742
5117                     ; 858  	if(ee_DEVICE)
5119  0cb9 ce0004        	ldw	x,_ee_DEVICE
5120  0cbc 270e          	jreq	L3742
5121                     ; 860 		pwm_u=0x00;
5123  0cbe 5f            	clrw	x
5124  0cbf bf0e          	ldw	_pwm_u,x
5125                     ; 861 		pwm_i=0x00;
5127  0cc1 5f            	clrw	x
5128  0cc2 bf10          	ldw	_pwm_i,x
5129                     ; 862 		bBL=1;
5131  0cc4 72100003      	bset	_bBL
5133  0cc8 acd20dd2      	jpf	L7342
5134  0ccc               L3742:
5135                     ; 866 		if((flags&0b00011010)==0)
5137  0ccc b60b          	ld	a,_flags
5138  0cce a51a          	bcp	a,#26
5139  0cd0 263b          	jrne	L7742
5140                     ; 868 			pwm_u=ee_U_AVT;
5142  0cd2 ce000c        	ldw	x,_ee_U_AVT
5143  0cd5 bf0e          	ldw	_pwm_u,x
5144                     ; 869 			gran(&pwm_u,0,1020);
5146  0cd7 ae03fc        	ldw	x,#1020
5147  0cda 89            	pushw	x
5148  0cdb 5f            	clrw	x
5149  0cdc 89            	pushw	x
5150  0cdd ae000e        	ldw	x,#_pwm_u
5151  0ce0 cd00d1        	call	_gran
5153  0ce3 5b04          	addw	sp,#4
5154                     ; 871 			if(pwm_i<1020)
5156  0ce5 9c            	rvf
5157  0ce6 be10          	ldw	x,_pwm_i
5158  0ce8 a303fc        	cpw	x,#1020
5159  0ceb 2e14          	jrsge	L1052
5160                     ; 873 				pwm_i+=30;
5162  0ced be10          	ldw	x,_pwm_i
5163  0cef 1c001e        	addw	x,#30
5164  0cf2 bf10          	ldw	_pwm_i,x
5165                     ; 874 				if(pwm_i>1020)pwm_i=1020;
5167  0cf4 9c            	rvf
5168  0cf5 be10          	ldw	x,_pwm_i
5169  0cf7 a303fd        	cpw	x,#1021
5170  0cfa 2f05          	jrslt	L1052
5173  0cfc ae03fc        	ldw	x,#1020
5174  0cff bf10          	ldw	_pwm_i,x
5175  0d01               L1052:
5176                     ; 876 			bBL=0;
5178  0d01 72110003      	bres	_bBL
5179                     ; 877 			bBL_IPS=0;
5181  0d05 72110000      	bres	_bBL_IPS
5183  0d09 acd20dd2      	jpf	L7342
5184  0d0d               L7742:
5185                     ; 879 		else if(flags&0b00011010)
5187  0d0d b60b          	ld	a,_flags
5188  0d0f a51a          	bcp	a,#26
5189  0d11 2603          	jrne	L66
5190  0d13 cc0dd2        	jp	L7342
5191  0d16               L66:
5192                     ; 881 			pwm_u=0;
5194  0d16 5f            	clrw	x
5195  0d17 bf0e          	ldw	_pwm_u,x
5196                     ; 882 			pwm_i=0;
5198  0d19 5f            	clrw	x
5199  0d1a bf10          	ldw	_pwm_i,x
5200                     ; 883 			bBL=1;
5202  0d1c 72100003      	bset	_bBL
5203                     ; 884 			bBL_IPS=1;
5205  0d20 72100000      	bset	_bBL_IPS
5206  0d24 acd20dd2      	jpf	L7342
5207  0d28               L1742:
5208                     ; 893 else	if(link==ON)				//если есть связьvol_i_temp_avar
5210  0d28 b663          	ld	a,_link
5211  0d2a a155          	cp	a,#85
5212  0d2c 2703          	jreq	L07
5213  0d2e cc0dd2        	jp	L7342
5214  0d31               L07:
5215                     ; 895 	if((flags&0b00100000)==0)	//если нет блокировки извне
5217  0d31 b60b          	ld	a,_flags
5218  0d33 a520          	bcp	a,#32
5219  0d35 2703cc0dc2    	jrne	L5152
5220                     ; 897 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
5222  0d3a b60b          	ld	a,_flags
5223  0d3c a41e          	and	a,#30
5224  0d3e a104          	cp	a,#4
5225  0d40 2630          	jrne	L7152
5226                     ; 899 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5228  0d42 be5e          	ldw	x,__x_
5229  0d44 72bb0058      	addw	x,_vol_u_temp
5230  0d48 bf0e          	ldw	_pwm_u,x
5231                     ; 900 			if(!ee_DEVICE)
5233  0d4a ce0004        	ldw	x,_ee_DEVICE
5234  0d4d 261b          	jrne	L1252
5235                     ; 902 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
5237  0d4f be10          	ldw	x,_pwm_i
5238  0d51 b30c          	cpw	x,_vol_i_temp_avar
5239  0d53 240f          	jruge	L3252
5242  0d55 be0c          	ldw	x,_vol_i_temp_avar
5243  0d57 90ae001e      	ldw	y,#30
5244  0d5b 65            	divw	x,y
5245  0d5c 72bb0010      	addw	x,_pwm_i
5246  0d60 bf10          	ldw	_pwm_i,x
5248  0d62 200a          	jra	L7252
5249  0d64               L3252:
5250                     ; 903 				else	pwm_i=vol_i_temp_avar;
5252  0d64 be0c          	ldw	x,_vol_i_temp_avar
5253  0d66 bf10          	ldw	_pwm_i,x
5254  0d68 2004          	jra	L7252
5255  0d6a               L1252:
5256                     ; 905 			else pwm_i=vol_i_temp_avar;
5258  0d6a be0c          	ldw	x,_vol_i_temp_avar
5259  0d6c bf10          	ldw	_pwm_i,x
5260  0d6e               L7252:
5261                     ; 907 			bBL=0;
5263  0d6e 72110003      	bres	_bBL
5264  0d72               L7152:
5265                     ; 909 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5267  0d72 b60b          	ld	a,_flags
5268  0d74 a51a          	bcp	a,#26
5269  0d76 2706          	jreq	L3352
5271  0d78 b60b          	ld	a,_flags
5272  0d7a a540          	bcp	a,#64
5273  0d7c 2732          	jreq	L1352
5274  0d7e               L3352:
5275                     ; 911 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5277  0d7e be5e          	ldw	x,__x_
5278  0d80 72bb0058      	addw	x,_vol_u_temp
5279  0d84 bf0e          	ldw	_pwm_u,x
5280                     ; 913 			if(!ee_DEVICE)
5282  0d86 ce0004        	ldw	x,_ee_DEVICE
5283  0d89 261b          	jrne	L5352
5284                     ; 915 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
5286  0d8b be10          	ldw	x,_pwm_i
5287  0d8d b356          	cpw	x,_vol_i_temp
5288  0d8f 240f          	jruge	L7352
5291  0d91 be56          	ldw	x,_vol_i_temp
5292  0d93 90ae001e      	ldw	y,#30
5293  0d97 65            	divw	x,y
5294  0d98 72bb0010      	addw	x,_pwm_i
5295  0d9c bf10          	ldw	_pwm_i,x
5297  0d9e 200a          	jra	L3452
5298  0da0               L7352:
5299                     ; 916 				else	pwm_i=vol_i_temp;
5301  0da0 be56          	ldw	x,_vol_i_temp
5302  0da2 bf10          	ldw	_pwm_i,x
5303  0da4 2004          	jra	L3452
5304  0da6               L5352:
5305                     ; 918 			else pwm_i=vol_i_temp;			
5307  0da6 be56          	ldw	x,_vol_i_temp
5308  0da8 bf10          	ldw	_pwm_i,x
5309  0daa               L3452:
5310                     ; 919 			bBL=0;
5312  0daa 72110003      	bres	_bBL
5314  0dae 2022          	jra	L7342
5315  0db0               L1352:
5316                     ; 921 		else if(flags&0b00011010)					//если есть аварии
5318  0db0 b60b          	ld	a,_flags
5319  0db2 a51a          	bcp	a,#26
5320  0db4 271c          	jreq	L7342
5321                     ; 923 			pwm_u=0;								//то полный стоп
5323  0db6 5f            	clrw	x
5324  0db7 bf0e          	ldw	_pwm_u,x
5325                     ; 924 			pwm_i=0;
5327  0db9 5f            	clrw	x
5328  0dba bf10          	ldw	_pwm_i,x
5329                     ; 925 			bBL=1;
5331  0dbc 72100003      	bset	_bBL
5332  0dc0 2010          	jra	L7342
5333  0dc2               L5152:
5334                     ; 928 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5336  0dc2 b60b          	ld	a,_flags
5337  0dc4 a520          	bcp	a,#32
5338  0dc6 270a          	jreq	L7342
5339                     ; 930 		pwm_u=0;
5341  0dc8 5f            	clrw	x
5342  0dc9 bf0e          	ldw	_pwm_u,x
5343                     ; 931 	    	pwm_i=0;
5345  0dcb 5f            	clrw	x
5346  0dcc bf10          	ldw	_pwm_i,x
5347                     ; 932 		bBL=1;
5349  0dce 72100003      	bset	_bBL
5350  0dd2               L7342:
5351                     ; 938 }
5354  0dd2 81            	ret
5399                     	switch	.const
5400  000c               L47:
5401  000c 00000258      	dc.l	600
5402  0010               L67:
5403  0010 000003e8      	dc.l	1000
5404  0014               L001:
5405  0014 00000708      	dc.l	1800
5406                     ; 941 void matemat(void)
5406                     ; 942 {
5407                     	switch	.text
5408  0dd3               _matemat:
5410  0dd3 5208          	subw	sp,#8
5411       00000008      OFST:	set	8
5414                     ; 963 temp_SL=adc_buff_[4];
5416  0dd5 ce0011        	ldw	x,_adc_buff_+8
5417  0dd8 cd0000        	call	c_itolx
5419  0ddb 96            	ldw	x,sp
5420  0ddc 1c0005        	addw	x,#OFST-3
5421  0ddf cd0000        	call	c_rtol
5423                     ; 964 temp_SL-=ee_K[0][0];
5425  0de2 ce001a        	ldw	x,_ee_K
5426  0de5 cd0000        	call	c_itolx
5428  0de8 96            	ldw	x,sp
5429  0de9 1c0005        	addw	x,#OFST-3
5430  0dec cd0000        	call	c_lgsub
5432                     ; 965 if(temp_SL<0) temp_SL=0;
5434  0def 9c            	rvf
5435  0df0 0d05          	tnz	(OFST-3,sp)
5436  0df2 2e0a          	jrsge	L3752
5439  0df4 ae0000        	ldw	x,#0
5440  0df7 1f07          	ldw	(OFST-1,sp),x
5441  0df9 ae0000        	ldw	x,#0
5442  0dfc 1f05          	ldw	(OFST-3,sp),x
5443  0dfe               L3752:
5444                     ; 966 temp_SL*=ee_K[0][1];
5446  0dfe ce001c        	ldw	x,_ee_K+2
5447  0e01 cd0000        	call	c_itolx
5449  0e04 96            	ldw	x,sp
5450  0e05 1c0005        	addw	x,#OFST-3
5451  0e08 cd0000        	call	c_lgmul
5453                     ; 967 temp_SL/=600;
5455  0e0b 96            	ldw	x,sp
5456  0e0c 1c0005        	addw	x,#OFST-3
5457  0e0f cd0000        	call	c_ltor
5459  0e12 ae000c        	ldw	x,#L47
5460  0e15 cd0000        	call	c_ldiv
5462  0e18 96            	ldw	x,sp
5463  0e19 1c0005        	addw	x,#OFST-3
5464  0e1c cd0000        	call	c_rtol
5466                     ; 968 I=(signed short)temp_SL;
5468  0e1f 1e07          	ldw	x,(OFST-1,sp)
5469  0e21 bf6f          	ldw	_I,x
5470                     ; 973 temp_SL=(signed long)adc_buff_[1];
5472  0e23 ce000b        	ldw	x,_adc_buff_+2
5473  0e26 cd0000        	call	c_itolx
5475  0e29 96            	ldw	x,sp
5476  0e2a 1c0005        	addw	x,#OFST-3
5477  0e2d cd0000        	call	c_rtol
5479                     ; 975 if(temp_SL<0) temp_SL=0;
5481  0e30 9c            	rvf
5482  0e31 0d05          	tnz	(OFST-3,sp)
5483  0e33 2e0a          	jrsge	L5752
5486  0e35 ae0000        	ldw	x,#0
5487  0e38 1f07          	ldw	(OFST-1,sp),x
5488  0e3a ae0000        	ldw	x,#0
5489  0e3d 1f05          	ldw	(OFST-3,sp),x
5490  0e3f               L5752:
5491                     ; 976 temp_SL*=(signed long)ee_K[2][1];
5493  0e3f ce0024        	ldw	x,_ee_K+10
5494  0e42 cd0000        	call	c_itolx
5496  0e45 96            	ldw	x,sp
5497  0e46 1c0005        	addw	x,#OFST-3
5498  0e49 cd0000        	call	c_lgmul
5500                     ; 977 temp_SL/=1000L;
5502  0e4c 96            	ldw	x,sp
5503  0e4d 1c0005        	addw	x,#OFST-3
5504  0e50 cd0000        	call	c_ltor
5506  0e53 ae0010        	ldw	x,#L67
5507  0e56 cd0000        	call	c_ldiv
5509  0e59 96            	ldw	x,sp
5510  0e5a 1c0005        	addw	x,#OFST-3
5511  0e5d cd0000        	call	c_rtol
5513                     ; 978 Ui=(unsigned short)temp_SL;
5515  0e60 1e07          	ldw	x,(OFST-1,sp)
5516  0e62 bf6b          	ldw	_Ui,x
5517                     ; 985 temp_SL=adc_buff_[3];
5519  0e64 ce000f        	ldw	x,_adc_buff_+6
5520  0e67 cd0000        	call	c_itolx
5522  0e6a 96            	ldw	x,sp
5523  0e6b 1c0005        	addw	x,#OFST-3
5524  0e6e cd0000        	call	c_rtol
5526                     ; 987 if(temp_SL<0) temp_SL=0;
5528  0e71 9c            	rvf
5529  0e72 0d05          	tnz	(OFST-3,sp)
5530  0e74 2e0a          	jrsge	L7752
5533  0e76 ae0000        	ldw	x,#0
5534  0e79 1f07          	ldw	(OFST-1,sp),x
5535  0e7b ae0000        	ldw	x,#0
5536  0e7e 1f05          	ldw	(OFST-3,sp),x
5537  0e80               L7752:
5538                     ; 988 temp_SL*=ee_K[1][1];
5540  0e80 ce0020        	ldw	x,_ee_K+6
5541  0e83 cd0000        	call	c_itolx
5543  0e86 96            	ldw	x,sp
5544  0e87 1c0005        	addw	x,#OFST-3
5545  0e8a cd0000        	call	c_lgmul
5547                     ; 989 temp_SL/=1800;
5549  0e8d 96            	ldw	x,sp
5550  0e8e 1c0005        	addw	x,#OFST-3
5551  0e91 cd0000        	call	c_ltor
5553  0e94 ae0014        	ldw	x,#L001
5554  0e97 cd0000        	call	c_ldiv
5556  0e9a 96            	ldw	x,sp
5557  0e9b 1c0005        	addw	x,#OFST-3
5558  0e9e cd0000        	call	c_rtol
5560                     ; 990 Un=(unsigned short)temp_SL;
5562  0ea1 1e07          	ldw	x,(OFST-1,sp)
5563  0ea3 bf6d          	ldw	_Un,x
5564                     ; 993 temp_SL=adc_buff_[2];
5566  0ea5 ce000d        	ldw	x,_adc_buff_+4
5567  0ea8 cd0000        	call	c_itolx
5569  0eab 96            	ldw	x,sp
5570  0eac 1c0005        	addw	x,#OFST-3
5571  0eaf cd0000        	call	c_rtol
5573                     ; 994 temp_SL*=ee_K[3][1];
5575  0eb2 ce0028        	ldw	x,_ee_K+14
5576  0eb5 cd0000        	call	c_itolx
5578  0eb8 96            	ldw	x,sp
5579  0eb9 1c0005        	addw	x,#OFST-3
5580  0ebc cd0000        	call	c_lgmul
5582                     ; 995 temp_SL/=1000;
5584  0ebf 96            	ldw	x,sp
5585  0ec0 1c0005        	addw	x,#OFST-3
5586  0ec3 cd0000        	call	c_ltor
5588  0ec6 ae0010        	ldw	x,#L67
5589  0ec9 cd0000        	call	c_ldiv
5591  0ecc 96            	ldw	x,sp
5592  0ecd 1c0005        	addw	x,#OFST-3
5593  0ed0 cd0000        	call	c_rtol
5595                     ; 996 T=(signed short)(temp_SL-273L);
5597  0ed3 7b08          	ld	a,(OFST+0,sp)
5598  0ed5 5f            	clrw	x
5599  0ed6 4d            	tnz	a
5600  0ed7 2a01          	jrpl	L201
5601  0ed9 53            	cplw	x
5602  0eda               L201:
5603  0eda 97            	ld	xl,a
5604  0edb 1d0111        	subw	x,#273
5605  0ede 01            	rrwa	x,a
5606  0edf b768          	ld	_T,a
5607  0ee1 02            	rlwa	x,a
5608                     ; 997 if(T<-30)T=-30;
5610  0ee2 9c            	rvf
5611  0ee3 b668          	ld	a,_T
5612  0ee5 a1e2          	cp	a,#226
5613  0ee7 2e04          	jrsge	L1062
5616  0ee9 35e20068      	mov	_T,#226
5617  0eed               L1062:
5618                     ; 998 if(T>120)T=120;
5620  0eed 9c            	rvf
5621  0eee b668          	ld	a,_T
5622  0ef0 a179          	cp	a,#121
5623  0ef2 2f04          	jrslt	L3062
5626  0ef4 35780068      	mov	_T,#120
5627  0ef8               L3062:
5628                     ; 1000 Udb=flags;
5630  0ef8 b60b          	ld	a,_flags
5631  0efa 5f            	clrw	x
5632  0efb 97            	ld	xl,a
5633  0efc bf69          	ldw	_Udb,x
5634                     ; 1006 temp_SL=(signed long)(T-ee_tsign);
5636  0efe 5f            	clrw	x
5637  0eff b668          	ld	a,_T
5638  0f01 2a01          	jrpl	L401
5639  0f03 53            	cplw	x
5640  0f04               L401:
5641  0f04 97            	ld	xl,a
5642  0f05 72b0000e      	subw	x,_ee_tsign
5643  0f09 cd0000        	call	c_itolx
5645  0f0c 96            	ldw	x,sp
5646  0f0d 1c0005        	addw	x,#OFST-3
5647  0f10 cd0000        	call	c_rtol
5649                     ; 1007 temp_SL*=1000L;
5651  0f13 ae03e8        	ldw	x,#1000
5652  0f16 bf02          	ldw	c_lreg+2,x
5653  0f18 ae0000        	ldw	x,#0
5654  0f1b bf00          	ldw	c_lreg,x
5655  0f1d 96            	ldw	x,sp
5656  0f1e 1c0005        	addw	x,#OFST-3
5657  0f21 cd0000        	call	c_lgmul
5659                     ; 1008 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5661  0f24 ce0010        	ldw	x,_ee_tmax
5662  0f27 72b0000e      	subw	x,_ee_tsign
5663  0f2b cd0000        	call	c_itolx
5665  0f2e 96            	ldw	x,sp
5666  0f2f 1c0001        	addw	x,#OFST-7
5667  0f32 cd0000        	call	c_rtol
5669  0f35 96            	ldw	x,sp
5670  0f36 1c0005        	addw	x,#OFST-3
5671  0f39 cd0000        	call	c_ltor
5673  0f3c 96            	ldw	x,sp
5674  0f3d 1c0001        	addw	x,#OFST-7
5675  0f40 cd0000        	call	c_ldiv
5677  0f43 96            	ldw	x,sp
5678  0f44 1c0005        	addw	x,#OFST-3
5679  0f47 cd0000        	call	c_rtol
5681                     ; 1010 vol_i_temp_avar=(unsigned short)temp_SL; 
5683  0f4a 1e07          	ldw	x,(OFST-1,sp)
5684  0f4c bf0c          	ldw	_vol_i_temp_avar,x
5685                     ; 1012 }
5688  0f4e 5b08          	addw	sp,#8
5689  0f50 81            	ret
5720                     ; 1015 void temper_drv(void)		//1 Hz
5720                     ; 1016 {
5721                     	switch	.text
5722  0f51               _temper_drv:
5726                     ; 1018 if(T>ee_tsign) tsign_cnt++;
5728  0f51 9c            	rvf
5729  0f52 5f            	clrw	x
5730  0f53 b668          	ld	a,_T
5731  0f55 2a01          	jrpl	L011
5732  0f57 53            	cplw	x
5733  0f58               L011:
5734  0f58 97            	ld	xl,a
5735  0f59 c3000e        	cpw	x,_ee_tsign
5736  0f5c 2d09          	jrsle	L5162
5739  0f5e be4d          	ldw	x,_tsign_cnt
5740  0f60 1c0001        	addw	x,#1
5741  0f63 bf4d          	ldw	_tsign_cnt,x
5743  0f65 201d          	jra	L7162
5744  0f67               L5162:
5745                     ; 1019 else if (T<(ee_tsign-1)) tsign_cnt--;
5747  0f67 9c            	rvf
5748  0f68 ce000e        	ldw	x,_ee_tsign
5749  0f6b 5a            	decw	x
5750  0f6c 905f          	clrw	y
5751  0f6e b668          	ld	a,_T
5752  0f70 2a02          	jrpl	L211
5753  0f72 9053          	cplw	y
5754  0f74               L211:
5755  0f74 9097          	ld	yl,a
5756  0f76 90bf00        	ldw	c_y,y
5757  0f79 b300          	cpw	x,c_y
5758  0f7b 2d07          	jrsle	L7162
5761  0f7d be4d          	ldw	x,_tsign_cnt
5762  0f7f 1d0001        	subw	x,#1
5763  0f82 bf4d          	ldw	_tsign_cnt,x
5764  0f84               L7162:
5765                     ; 1021 gran(&tsign_cnt,0,60);
5767  0f84 ae003c        	ldw	x,#60
5768  0f87 89            	pushw	x
5769  0f88 5f            	clrw	x
5770  0f89 89            	pushw	x
5771  0f8a ae004d        	ldw	x,#_tsign_cnt
5772  0f8d cd00d1        	call	_gran
5774  0f90 5b04          	addw	sp,#4
5775                     ; 1023 if(tsign_cnt>=55)
5777  0f92 9c            	rvf
5778  0f93 be4d          	ldw	x,_tsign_cnt
5779  0f95 a30037        	cpw	x,#55
5780  0f98 2f16          	jrslt	L3262
5781                     ; 1025 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5783  0f9a 3d4a          	tnz	_jp_mode
5784  0f9c 2606          	jrne	L1362
5786  0f9e b60b          	ld	a,_flags
5787  0fa0 a540          	bcp	a,#64
5788  0fa2 2706          	jreq	L7262
5789  0fa4               L1362:
5791  0fa4 b64a          	ld	a,_jp_mode
5792  0fa6 a103          	cp	a,#3
5793  0fa8 2612          	jrne	L3362
5794  0faa               L7262:
5797  0faa 7214000b      	bset	_flags,#2
5798  0fae 200c          	jra	L3362
5799  0fb0               L3262:
5800                     ; 1027 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5802  0fb0 9c            	rvf
5803  0fb1 be4d          	ldw	x,_tsign_cnt
5804  0fb3 a30006        	cpw	x,#6
5805  0fb6 2e04          	jrsge	L3362
5808  0fb8 7215000b      	bres	_flags,#2
5809  0fbc               L3362:
5810                     ; 1032 if(T>ee_tmax) tmax_cnt++;
5812  0fbc 9c            	rvf
5813  0fbd 5f            	clrw	x
5814  0fbe b668          	ld	a,_T
5815  0fc0 2a01          	jrpl	L411
5816  0fc2 53            	cplw	x
5817  0fc3               L411:
5818  0fc3 97            	ld	xl,a
5819  0fc4 c30010        	cpw	x,_ee_tmax
5820  0fc7 2d09          	jrsle	L7362
5823  0fc9 be4b          	ldw	x,_tmax_cnt
5824  0fcb 1c0001        	addw	x,#1
5825  0fce bf4b          	ldw	_tmax_cnt,x
5827  0fd0 201d          	jra	L1462
5828  0fd2               L7362:
5829                     ; 1033 else if (T<(ee_tmax-1)) tmax_cnt--;
5831  0fd2 9c            	rvf
5832  0fd3 ce0010        	ldw	x,_ee_tmax
5833  0fd6 5a            	decw	x
5834  0fd7 905f          	clrw	y
5835  0fd9 b668          	ld	a,_T
5836  0fdb 2a02          	jrpl	L611
5837  0fdd 9053          	cplw	y
5838  0fdf               L611:
5839  0fdf 9097          	ld	yl,a
5840  0fe1 90bf00        	ldw	c_y,y
5841  0fe4 b300          	cpw	x,c_y
5842  0fe6 2d07          	jrsle	L1462
5845  0fe8 be4b          	ldw	x,_tmax_cnt
5846  0fea 1d0001        	subw	x,#1
5847  0fed bf4b          	ldw	_tmax_cnt,x
5848  0fef               L1462:
5849                     ; 1035 gran(&tmax_cnt,0,60);
5851  0fef ae003c        	ldw	x,#60
5852  0ff2 89            	pushw	x
5853  0ff3 5f            	clrw	x
5854  0ff4 89            	pushw	x
5855  0ff5 ae004b        	ldw	x,#_tmax_cnt
5856  0ff8 cd00d1        	call	_gran
5858  0ffb 5b04          	addw	sp,#4
5859                     ; 1037 if(tmax_cnt>=55)
5861  0ffd 9c            	rvf
5862  0ffe be4b          	ldw	x,_tmax_cnt
5863  1000 a30037        	cpw	x,#55
5864  1003 2f16          	jrslt	L5462
5865                     ; 1039 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5867  1005 3d4a          	tnz	_jp_mode
5868  1007 2606          	jrne	L3562
5870  1009 b60b          	ld	a,_flags
5871  100b a540          	bcp	a,#64
5872  100d 2706          	jreq	L1562
5873  100f               L3562:
5875  100f b64a          	ld	a,_jp_mode
5876  1011 a103          	cp	a,#3
5877  1013 2612          	jrne	L5562
5878  1015               L1562:
5881  1015 7212000b      	bset	_flags,#1
5882  1019 200c          	jra	L5562
5883  101b               L5462:
5884                     ; 1041 else if (tmax_cnt<=5) flags&=0b11111101;
5886  101b 9c            	rvf
5887  101c be4b          	ldw	x,_tmax_cnt
5888  101e a30006        	cpw	x,#6
5889  1021 2e04          	jrsge	L5562
5892  1023 7213000b      	bres	_flags,#1
5893  1027               L5562:
5894                     ; 1044 } 
5897  1027 81            	ret
5929                     ; 1047 void u_drv(void)		//1Hz
5929                     ; 1048 { 
5930                     	switch	.text
5931  1028               _u_drv:
5935                     ; 1049 if(jp_mode!=jp3)
5937  1028 b64a          	ld	a,_jp_mode
5938  102a a103          	cp	a,#3
5939  102c 2770          	jreq	L1762
5940                     ; 1051 	if(Ui>ee_Umax)umax_cnt++;
5942  102e 9c            	rvf
5943  102f be6b          	ldw	x,_Ui
5944  1031 c30014        	cpw	x,_ee_Umax
5945  1034 2d09          	jrsle	L3762
5948  1036 be66          	ldw	x,_umax_cnt
5949  1038 1c0001        	addw	x,#1
5950  103b bf66          	ldw	_umax_cnt,x
5952  103d 2003          	jra	L5762
5953  103f               L3762:
5954                     ; 1052 	else umax_cnt=0;
5956  103f 5f            	clrw	x
5957  1040 bf66          	ldw	_umax_cnt,x
5958  1042               L5762:
5959                     ; 1053 	gran(&umax_cnt,0,10);
5961  1042 ae000a        	ldw	x,#10
5962  1045 89            	pushw	x
5963  1046 5f            	clrw	x
5964  1047 89            	pushw	x
5965  1048 ae0066        	ldw	x,#_umax_cnt
5966  104b cd00d1        	call	_gran
5968  104e 5b04          	addw	sp,#4
5969                     ; 1054 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5971  1050 9c            	rvf
5972  1051 be66          	ldw	x,_umax_cnt
5973  1053 a3000a        	cpw	x,#10
5974  1056 2f04          	jrslt	L7762
5977  1058 7216000b      	bset	_flags,#3
5978  105c               L7762:
5979                     ; 1057 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5981  105c 9c            	rvf
5982  105d be6b          	ldw	x,_Ui
5983  105f b36d          	cpw	x,_Un
5984  1061 2e1c          	jrsge	L1072
5986  1063 9c            	rvf
5987  1064 be6d          	ldw	x,_Un
5988  1066 72b0006b      	subw	x,_Ui
5989  106a c30012        	cpw	x,_ee_dU
5990  106d 2d10          	jrsle	L1072
5992  106f c65005        	ld	a,20485
5993  1072 a504          	bcp	a,#4
5994  1074 2609          	jrne	L1072
5997  1076 be64          	ldw	x,_umin_cnt
5998  1078 1c0001        	addw	x,#1
5999  107b bf64          	ldw	_umin_cnt,x
6001  107d 2003          	jra	L3072
6002  107f               L1072:
6003                     ; 1058 	else umin_cnt=0;
6005  107f 5f            	clrw	x
6006  1080 bf64          	ldw	_umin_cnt,x
6007  1082               L3072:
6008                     ; 1059 	gran(&umin_cnt,0,10);	
6010  1082 ae000a        	ldw	x,#10
6011  1085 89            	pushw	x
6012  1086 5f            	clrw	x
6013  1087 89            	pushw	x
6014  1088 ae0064        	ldw	x,#_umin_cnt
6015  108b cd00d1        	call	_gran
6017  108e 5b04          	addw	sp,#4
6018                     ; 1060 	if(umin_cnt>=10)flags|=0b00010000;	  
6020  1090 9c            	rvf
6021  1091 be64          	ldw	x,_umin_cnt
6022  1093 a3000a        	cpw	x,#10
6023  1096 2f6f          	jrslt	L7072
6026  1098 7218000b      	bset	_flags,#4
6027  109c 2069          	jra	L7072
6028  109e               L1762:
6029                     ; 1062 else if(jp_mode==jp3)
6031  109e b64a          	ld	a,_jp_mode
6032  10a0 a103          	cp	a,#3
6033  10a2 2663          	jrne	L7072
6034                     ; 1064 	if(Ui>700)umax_cnt++;
6036  10a4 9c            	rvf
6037  10a5 be6b          	ldw	x,_Ui
6038  10a7 a302bd        	cpw	x,#701
6039  10aa 2f09          	jrslt	L3172
6042  10ac be66          	ldw	x,_umax_cnt
6043  10ae 1c0001        	addw	x,#1
6044  10b1 bf66          	ldw	_umax_cnt,x
6046  10b3 2003          	jra	L5172
6047  10b5               L3172:
6048                     ; 1065 	else umax_cnt=0;
6050  10b5 5f            	clrw	x
6051  10b6 bf66          	ldw	_umax_cnt,x
6052  10b8               L5172:
6053                     ; 1066 	gran(&umax_cnt,0,10);
6055  10b8 ae000a        	ldw	x,#10
6056  10bb 89            	pushw	x
6057  10bc 5f            	clrw	x
6058  10bd 89            	pushw	x
6059  10be ae0066        	ldw	x,#_umax_cnt
6060  10c1 cd00d1        	call	_gran
6062  10c4 5b04          	addw	sp,#4
6063                     ; 1067 	if(umax_cnt>=10)flags|=0b00001000;
6065  10c6 9c            	rvf
6066  10c7 be66          	ldw	x,_umax_cnt
6067  10c9 a3000a        	cpw	x,#10
6068  10cc 2f04          	jrslt	L7172
6071  10ce 7216000b      	bset	_flags,#3
6072  10d2               L7172:
6073                     ; 1070 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6075  10d2 9c            	rvf
6076  10d3 be6b          	ldw	x,_Ui
6077  10d5 a300c8        	cpw	x,#200
6078  10d8 2e10          	jrsge	L1272
6080  10da c65005        	ld	a,20485
6081  10dd a504          	bcp	a,#4
6082  10df 2609          	jrne	L1272
6085  10e1 be64          	ldw	x,_umin_cnt
6086  10e3 1c0001        	addw	x,#1
6087  10e6 bf64          	ldw	_umin_cnt,x
6089  10e8 2003          	jra	L3272
6090  10ea               L1272:
6091                     ; 1071 	else umin_cnt=0;
6093  10ea 5f            	clrw	x
6094  10eb bf64          	ldw	_umin_cnt,x
6095  10ed               L3272:
6096                     ; 1072 	gran(&umin_cnt,0,10);	
6098  10ed ae000a        	ldw	x,#10
6099  10f0 89            	pushw	x
6100  10f1 5f            	clrw	x
6101  10f2 89            	pushw	x
6102  10f3 ae0064        	ldw	x,#_umin_cnt
6103  10f6 cd00d1        	call	_gran
6105  10f9 5b04          	addw	sp,#4
6106                     ; 1073 	if(umin_cnt>=10)flags|=0b00010000;	  
6108  10fb 9c            	rvf
6109  10fc be64          	ldw	x,_umin_cnt
6110  10fe a3000a        	cpw	x,#10
6111  1101 2f04          	jrslt	L7072
6114  1103 7218000b      	bset	_flags,#4
6115  1107               L7072:
6116                     ; 1075 }
6119  1107 81            	ret
6146                     ; 1078 void x_drv(void)
6146                     ; 1079 {
6147                     	switch	.text
6148  1108               _x_drv:
6152                     ; 1080 if(_x__==_x_)
6154  1108 be5c          	ldw	x,__x__
6155  110a b35e          	cpw	x,__x_
6156  110c 262a          	jrne	L7372
6157                     ; 1082 	if(_x_cnt<60)
6159  110e 9c            	rvf
6160  110f be5a          	ldw	x,__x_cnt
6161  1111 a3003c        	cpw	x,#60
6162  1114 2e25          	jrsge	L7472
6163                     ; 1084 		_x_cnt++;
6165  1116 be5a          	ldw	x,__x_cnt
6166  1118 1c0001        	addw	x,#1
6167  111b bf5a          	ldw	__x_cnt,x
6168                     ; 1085 		if(_x_cnt>=60)
6170  111d 9c            	rvf
6171  111e be5a          	ldw	x,__x_cnt
6172  1120 a3003c        	cpw	x,#60
6173  1123 2f16          	jrslt	L7472
6174                     ; 1087 			if(_x_ee_!=_x_)_x_ee_=_x_;
6176  1125 ce0018        	ldw	x,__x_ee_
6177  1128 b35e          	cpw	x,__x_
6178  112a 270f          	jreq	L7472
6181  112c be5e          	ldw	x,__x_
6182  112e 89            	pushw	x
6183  112f ae0018        	ldw	x,#__x_ee_
6184  1132 cd0000        	call	c_eewrw
6186  1135 85            	popw	x
6187  1136 2003          	jra	L7472
6188  1138               L7372:
6189                     ; 1092 else _x_cnt=0;
6191  1138 5f            	clrw	x
6192  1139 bf5a          	ldw	__x_cnt,x
6193  113b               L7472:
6194                     ; 1094 if(_x_cnt>60) _x_cnt=0;	
6196  113b 9c            	rvf
6197  113c be5a          	ldw	x,__x_cnt
6198  113e a3003d        	cpw	x,#61
6199  1141 2f03          	jrslt	L1572
6202  1143 5f            	clrw	x
6203  1144 bf5a          	ldw	__x_cnt,x
6204  1146               L1572:
6205                     ; 1096 _x__=_x_;
6207  1146 be5e          	ldw	x,__x_
6208  1148 bf5c          	ldw	__x__,x
6209                     ; 1097 }
6212  114a 81            	ret
6238                     ; 1100 void apv_start(void)
6238                     ; 1101 {
6239                     	switch	.text
6240  114b               _apv_start:
6244                     ; 1102 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6246  114b 3d45          	tnz	_apv_cnt
6247  114d 2624          	jrne	L3672
6249  114f 3d46          	tnz	_apv_cnt+1
6250  1151 2620          	jrne	L3672
6252  1153 3d47          	tnz	_apv_cnt+2
6253  1155 261c          	jrne	L3672
6255                     	btst	_bAPV
6256  115c 2515          	jrult	L3672
6257                     ; 1104 	apv_cnt[0]=60;
6259  115e 353c0045      	mov	_apv_cnt,#60
6260                     ; 1105 	apv_cnt[1]=60;
6262  1162 353c0046      	mov	_apv_cnt+1,#60
6263                     ; 1106 	apv_cnt[2]=60;
6265  1166 353c0047      	mov	_apv_cnt+2,#60
6266                     ; 1107 	apv_cnt_=3600;
6268  116a ae0e10        	ldw	x,#3600
6269  116d bf43          	ldw	_apv_cnt_,x
6270                     ; 1108 	bAPV=1;	
6272  116f 72100002      	bset	_bAPV
6273  1173               L3672:
6274                     ; 1110 }
6277  1173 81            	ret
6303                     ; 1113 void apv_stop(void)
6303                     ; 1114 {
6304                     	switch	.text
6305  1174               _apv_stop:
6309                     ; 1115 apv_cnt[0]=0;
6311  1174 3f45          	clr	_apv_cnt
6312                     ; 1116 apv_cnt[1]=0;
6314  1176 3f46          	clr	_apv_cnt+1
6315                     ; 1117 apv_cnt[2]=0;
6317  1178 3f47          	clr	_apv_cnt+2
6318                     ; 1118 apv_cnt_=0;	
6320  117a 5f            	clrw	x
6321  117b bf43          	ldw	_apv_cnt_,x
6322                     ; 1119 bAPV=0;
6324  117d 72110002      	bres	_bAPV
6325                     ; 1120 }
6328  1181 81            	ret
6363                     ; 1124 void apv_hndl(void)
6363                     ; 1125 {
6364                     	switch	.text
6365  1182               _apv_hndl:
6369                     ; 1126 if(apv_cnt[0])
6371  1182 3d45          	tnz	_apv_cnt
6372  1184 271e          	jreq	L5003
6373                     ; 1128 	apv_cnt[0]--;
6375  1186 3a45          	dec	_apv_cnt
6376                     ; 1129 	if(apv_cnt[0]==0)
6378  1188 3d45          	tnz	_apv_cnt
6379  118a 265a          	jrne	L1103
6380                     ; 1131 		flags&=0b11100001;
6382  118c b60b          	ld	a,_flags
6383  118e a4e1          	and	a,#225
6384  1190 b70b          	ld	_flags,a
6385                     ; 1132 		tsign_cnt=0;
6387  1192 5f            	clrw	x
6388  1193 bf4d          	ldw	_tsign_cnt,x
6389                     ; 1133 		tmax_cnt=0;
6391  1195 5f            	clrw	x
6392  1196 bf4b          	ldw	_tmax_cnt,x
6393                     ; 1134 		umax_cnt=0;
6395  1198 5f            	clrw	x
6396  1199 bf66          	ldw	_umax_cnt,x
6397                     ; 1135 		umin_cnt=0;
6399  119b 5f            	clrw	x
6400  119c bf64          	ldw	_umin_cnt,x
6401                     ; 1137 		led_drv_cnt=30;
6403  119e 351e001c      	mov	_led_drv_cnt,#30
6404  11a2 2042          	jra	L1103
6405  11a4               L5003:
6406                     ; 1140 else if(apv_cnt[1])
6408  11a4 3d46          	tnz	_apv_cnt+1
6409  11a6 271e          	jreq	L3103
6410                     ; 1142 	apv_cnt[1]--;
6412  11a8 3a46          	dec	_apv_cnt+1
6413                     ; 1143 	if(apv_cnt[1]==0)
6415  11aa 3d46          	tnz	_apv_cnt+1
6416  11ac 2638          	jrne	L1103
6417                     ; 1145 		flags&=0b11100001;
6419  11ae b60b          	ld	a,_flags
6420  11b0 a4e1          	and	a,#225
6421  11b2 b70b          	ld	_flags,a
6422                     ; 1146 		tsign_cnt=0;
6424  11b4 5f            	clrw	x
6425  11b5 bf4d          	ldw	_tsign_cnt,x
6426                     ; 1147 		tmax_cnt=0;
6428  11b7 5f            	clrw	x
6429  11b8 bf4b          	ldw	_tmax_cnt,x
6430                     ; 1148 		umax_cnt=0;
6432  11ba 5f            	clrw	x
6433  11bb bf66          	ldw	_umax_cnt,x
6434                     ; 1149 		umin_cnt=0;
6436  11bd 5f            	clrw	x
6437  11be bf64          	ldw	_umin_cnt,x
6438                     ; 1151 		led_drv_cnt=30;
6440  11c0 351e001c      	mov	_led_drv_cnt,#30
6441  11c4 2020          	jra	L1103
6442  11c6               L3103:
6443                     ; 1154 else if(apv_cnt[2])
6445  11c6 3d47          	tnz	_apv_cnt+2
6446  11c8 271c          	jreq	L1103
6447                     ; 1156 	apv_cnt[2]--;
6449  11ca 3a47          	dec	_apv_cnt+2
6450                     ; 1157 	if(apv_cnt[2]==0)
6452  11cc 3d47          	tnz	_apv_cnt+2
6453  11ce 2616          	jrne	L1103
6454                     ; 1159 		flags&=0b11100001;
6456  11d0 b60b          	ld	a,_flags
6457  11d2 a4e1          	and	a,#225
6458  11d4 b70b          	ld	_flags,a
6459                     ; 1160 		tsign_cnt=0;
6461  11d6 5f            	clrw	x
6462  11d7 bf4d          	ldw	_tsign_cnt,x
6463                     ; 1161 		tmax_cnt=0;
6465  11d9 5f            	clrw	x
6466  11da bf4b          	ldw	_tmax_cnt,x
6467                     ; 1162 		umax_cnt=0;
6469  11dc 5f            	clrw	x
6470  11dd bf66          	ldw	_umax_cnt,x
6471                     ; 1163 		umin_cnt=0;          
6473  11df 5f            	clrw	x
6474  11e0 bf64          	ldw	_umin_cnt,x
6475                     ; 1165 		led_drv_cnt=30;
6477  11e2 351e001c      	mov	_led_drv_cnt,#30
6478  11e6               L1103:
6479                     ; 1169 if(apv_cnt_)
6481  11e6 be43          	ldw	x,_apv_cnt_
6482  11e8 2712          	jreq	L5203
6483                     ; 1171 	apv_cnt_--;
6485  11ea be43          	ldw	x,_apv_cnt_
6486  11ec 1d0001        	subw	x,#1
6487  11ef bf43          	ldw	_apv_cnt_,x
6488                     ; 1172 	if(apv_cnt_==0) 
6490  11f1 be43          	ldw	x,_apv_cnt_
6491  11f3 2607          	jrne	L5203
6492                     ; 1174 		bAPV=0;
6494  11f5 72110002      	bres	_bAPV
6495                     ; 1175 		apv_start();
6497  11f9 cd114b        	call	_apv_start
6499  11fc               L5203:
6500                     ; 1179 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6502  11fc be64          	ldw	x,_umin_cnt
6503  11fe 261e          	jrne	L1303
6505  1200 be66          	ldw	x,_umax_cnt
6506  1202 261a          	jrne	L1303
6508  1204 c65005        	ld	a,20485
6509  1207 a504          	bcp	a,#4
6510  1209 2613          	jrne	L1303
6511                     ; 1181 	if(cnt_apv_off<20)
6513  120b b642          	ld	a,_cnt_apv_off
6514  120d a114          	cp	a,#20
6515  120f 240f          	jruge	L7303
6516                     ; 1183 		cnt_apv_off++;
6518  1211 3c42          	inc	_cnt_apv_off
6519                     ; 1184 		if(cnt_apv_off>=20)
6521  1213 b642          	ld	a,_cnt_apv_off
6522  1215 a114          	cp	a,#20
6523  1217 2507          	jrult	L7303
6524                     ; 1186 			apv_stop();
6526  1219 cd1174        	call	_apv_stop
6528  121c 2002          	jra	L7303
6529  121e               L1303:
6530                     ; 1190 else cnt_apv_off=0;	
6532  121e 3f42          	clr	_cnt_apv_off
6533  1220               L7303:
6534                     ; 1192 }
6537  1220 81            	ret
6540                     	switch	.ubsct
6541  0000               L1403_flags_old:
6542  0000 00            	ds.b	1
6578                     ; 1195 void flags_drv(void)
6578                     ; 1196 {
6579                     	switch	.text
6580  1221               _flags_drv:
6584                     ; 1198 if(jp_mode!=jp3) 
6586  1221 b64a          	ld	a,_jp_mode
6587  1223 a103          	cp	a,#3
6588  1225 2723          	jreq	L1603
6589                     ; 1200 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6591  1227 b60b          	ld	a,_flags
6592  1229 a508          	bcp	a,#8
6593  122b 2706          	jreq	L7603
6595  122d b600          	ld	a,L1403_flags_old
6596  122f a508          	bcp	a,#8
6597  1231 270c          	jreq	L5603
6598  1233               L7603:
6600  1233 b60b          	ld	a,_flags
6601  1235 a510          	bcp	a,#16
6602  1237 2726          	jreq	L3703
6604  1239 b600          	ld	a,L1403_flags_old
6605  123b a510          	bcp	a,#16
6606  123d 2620          	jrne	L3703
6607  123f               L5603:
6608                     ; 1202     		if(link==OFF)apv_start();
6610  123f b663          	ld	a,_link
6611  1241 a1aa          	cp	a,#170
6612  1243 261a          	jrne	L3703
6615  1245 cd114b        	call	_apv_start
6617  1248 2015          	jra	L3703
6618  124a               L1603:
6619                     ; 1205 else if(jp_mode==jp3) 
6621  124a b64a          	ld	a,_jp_mode
6622  124c a103          	cp	a,#3
6623  124e 260f          	jrne	L3703
6624                     ; 1207 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6626  1250 b60b          	ld	a,_flags
6627  1252 a508          	bcp	a,#8
6628  1254 2709          	jreq	L3703
6630  1256 b600          	ld	a,L1403_flags_old
6631  1258 a508          	bcp	a,#8
6632  125a 2603          	jrne	L3703
6633                     ; 1209     		apv_start();
6635  125c cd114b        	call	_apv_start
6637  125f               L3703:
6638                     ; 1212 flags_old=flags;
6640  125f 450b00        	mov	L1403_flags_old,_flags
6641                     ; 1214 } 
6644  1262 81            	ret
6679                     ; 1351 void adr_drv_v4(char in)
6679                     ; 1352 {
6680                     	switch	.text
6681  1263               _adr_drv_v4:
6685                     ; 1353 if(adress!=in)adress=in;
6687  1263 c10005        	cp	a,_adress
6688  1266 2703          	jreq	L7113
6691  1268 c70005        	ld	_adress,a
6692  126b               L7113:
6693                     ; 1354 }
6696  126b 81            	ret
6725                     ; 1357 void adr_drv_v3(void)
6725                     ; 1358 {
6726                     	switch	.text
6727  126c               _adr_drv_v3:
6729  126c 88            	push	a
6730       00000001      OFST:	set	1
6733                     ; 1364 GPIOB->DDR&=~(1<<0);
6735  126d 72115007      	bres	20487,#0
6736                     ; 1365 GPIOB->CR1&=~(1<<0);
6738  1271 72115008      	bres	20488,#0
6739                     ; 1366 GPIOB->CR2&=~(1<<0);
6741  1275 72115009      	bres	20489,#0
6742                     ; 1367 ADC2->CR2=0x08;
6744  1279 35085402      	mov	21506,#8
6745                     ; 1368 ADC2->CR1=0x40;
6747  127d 35405401      	mov	21505,#64
6748                     ; 1369 ADC2->CSR=0x20+0;
6750  1281 35205400      	mov	21504,#32
6751                     ; 1370 ADC2->CR1|=1;
6753  1285 72105401      	bset	21505,#0
6754                     ; 1371 ADC2->CR1|=1;
6756  1289 72105401      	bset	21505,#0
6757                     ; 1372 adr_drv_stat=1;
6759  128d 35010008      	mov	_adr_drv_stat,#1
6760  1291               L1313:
6761                     ; 1373 while(adr_drv_stat==1);
6764  1291 b608          	ld	a,_adr_drv_stat
6765  1293 a101          	cp	a,#1
6766  1295 27fa          	jreq	L1313
6767                     ; 1375 GPIOB->DDR&=~(1<<1);
6769  1297 72135007      	bres	20487,#1
6770                     ; 1376 GPIOB->CR1&=~(1<<1);
6772  129b 72135008      	bres	20488,#1
6773                     ; 1377 GPIOB->CR2&=~(1<<1);
6775  129f 72135009      	bres	20489,#1
6776                     ; 1378 ADC2->CR2=0x08;
6778  12a3 35085402      	mov	21506,#8
6779                     ; 1379 ADC2->CR1=0x40;
6781  12a7 35405401      	mov	21505,#64
6782                     ; 1380 ADC2->CSR=0x20+1;
6784  12ab 35215400      	mov	21504,#33
6785                     ; 1381 ADC2->CR1|=1;
6787  12af 72105401      	bset	21505,#0
6788                     ; 1382 ADC2->CR1|=1;
6790  12b3 72105401      	bset	21505,#0
6791                     ; 1383 adr_drv_stat=3;
6793  12b7 35030008      	mov	_adr_drv_stat,#3
6794  12bb               L7313:
6795                     ; 1384 while(adr_drv_stat==3);
6798  12bb b608          	ld	a,_adr_drv_stat
6799  12bd a103          	cp	a,#3
6800  12bf 27fa          	jreq	L7313
6801                     ; 1386 GPIOE->DDR&=~(1<<6);
6803  12c1 721d5016      	bres	20502,#6
6804                     ; 1387 GPIOE->CR1&=~(1<<6);
6806  12c5 721d5017      	bres	20503,#6
6807                     ; 1388 GPIOE->CR2&=~(1<<6);
6809  12c9 721d5018      	bres	20504,#6
6810                     ; 1389 ADC2->CR2=0x08;
6812  12cd 35085402      	mov	21506,#8
6813                     ; 1390 ADC2->CR1=0x40;
6815  12d1 35405401      	mov	21505,#64
6816                     ; 1391 ADC2->CSR=0x20+9;
6818  12d5 35295400      	mov	21504,#41
6819                     ; 1392 ADC2->CR1|=1;
6821  12d9 72105401      	bset	21505,#0
6822                     ; 1393 ADC2->CR1|=1;
6824  12dd 72105401      	bset	21505,#0
6825                     ; 1394 adr_drv_stat=5;
6827  12e1 35050008      	mov	_adr_drv_stat,#5
6828  12e5               L5413:
6829                     ; 1395 while(adr_drv_stat==5);
6832  12e5 b608          	ld	a,_adr_drv_stat
6833  12e7 a105          	cp	a,#5
6834  12e9 27fa          	jreq	L5413
6835                     ; 1399 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6837  12eb 9c            	rvf
6838  12ec ce0009        	ldw	x,_adc_buff_
6839  12ef a3022a        	cpw	x,#554
6840  12f2 2f0f          	jrslt	L3513
6842  12f4 9c            	rvf
6843  12f5 ce0009        	ldw	x,_adc_buff_
6844  12f8 a30253        	cpw	x,#595
6845  12fb 2e06          	jrsge	L3513
6848  12fd 725f0006      	clr	_adr
6850  1301 204c          	jra	L5513
6851  1303               L3513:
6852                     ; 1400 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6854  1303 9c            	rvf
6855  1304 ce0009        	ldw	x,_adc_buff_
6856  1307 a3036d        	cpw	x,#877
6857  130a 2f0f          	jrslt	L7513
6859  130c 9c            	rvf
6860  130d ce0009        	ldw	x,_adc_buff_
6861  1310 a30396        	cpw	x,#918
6862  1313 2e06          	jrsge	L7513
6865  1315 35010006      	mov	_adr,#1
6867  1319 2034          	jra	L5513
6868  131b               L7513:
6869                     ; 1401 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6871  131b 9c            	rvf
6872  131c ce0009        	ldw	x,_adc_buff_
6873  131f a302a3        	cpw	x,#675
6874  1322 2f0f          	jrslt	L3613
6876  1324 9c            	rvf
6877  1325 ce0009        	ldw	x,_adc_buff_
6878  1328 a302cc        	cpw	x,#716
6879  132b 2e06          	jrsge	L3613
6882  132d 35020006      	mov	_adr,#2
6884  1331 201c          	jra	L5513
6885  1333               L3613:
6886                     ; 1402 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6888  1333 9c            	rvf
6889  1334 ce0009        	ldw	x,_adc_buff_
6890  1337 a303e3        	cpw	x,#995
6891  133a 2f0f          	jrslt	L7613
6893  133c 9c            	rvf
6894  133d ce0009        	ldw	x,_adc_buff_
6895  1340 a3040c        	cpw	x,#1036
6896  1343 2e06          	jrsge	L7613
6899  1345 35030006      	mov	_adr,#3
6901  1349 2004          	jra	L5513
6902  134b               L7613:
6903                     ; 1403 else adr[0]=5;
6905  134b 35050006      	mov	_adr,#5
6906  134f               L5513:
6907                     ; 1405 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6909  134f 9c            	rvf
6910  1350 ce000b        	ldw	x,_adc_buff_+2
6911  1353 a3022a        	cpw	x,#554
6912  1356 2f0f          	jrslt	L3713
6914  1358 9c            	rvf
6915  1359 ce000b        	ldw	x,_adc_buff_+2
6916  135c a30253        	cpw	x,#595
6917  135f 2e06          	jrsge	L3713
6920  1361 725f0007      	clr	_adr+1
6922  1365 204c          	jra	L5713
6923  1367               L3713:
6924                     ; 1406 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6926  1367 9c            	rvf
6927  1368 ce000b        	ldw	x,_adc_buff_+2
6928  136b a3036d        	cpw	x,#877
6929  136e 2f0f          	jrslt	L7713
6931  1370 9c            	rvf
6932  1371 ce000b        	ldw	x,_adc_buff_+2
6933  1374 a30396        	cpw	x,#918
6934  1377 2e06          	jrsge	L7713
6937  1379 35010007      	mov	_adr+1,#1
6939  137d 2034          	jra	L5713
6940  137f               L7713:
6941                     ; 1407 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6943  137f 9c            	rvf
6944  1380 ce000b        	ldw	x,_adc_buff_+2
6945  1383 a302a3        	cpw	x,#675
6946  1386 2f0f          	jrslt	L3023
6948  1388 9c            	rvf
6949  1389 ce000b        	ldw	x,_adc_buff_+2
6950  138c a302cc        	cpw	x,#716
6951  138f 2e06          	jrsge	L3023
6954  1391 35020007      	mov	_adr+1,#2
6956  1395 201c          	jra	L5713
6957  1397               L3023:
6958                     ; 1408 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6960  1397 9c            	rvf
6961  1398 ce000b        	ldw	x,_adc_buff_+2
6962  139b a303e3        	cpw	x,#995
6963  139e 2f0f          	jrslt	L7023
6965  13a0 9c            	rvf
6966  13a1 ce000b        	ldw	x,_adc_buff_+2
6967  13a4 a3040c        	cpw	x,#1036
6968  13a7 2e06          	jrsge	L7023
6971  13a9 35030007      	mov	_adr+1,#3
6973  13ad 2004          	jra	L5713
6974  13af               L7023:
6975                     ; 1409 else adr[1]=5;
6977  13af 35050007      	mov	_adr+1,#5
6978  13b3               L5713:
6979                     ; 1411 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6981  13b3 9c            	rvf
6982  13b4 ce001b        	ldw	x,_adc_buff_+18
6983  13b7 a3022a        	cpw	x,#554
6984  13ba 2f0f          	jrslt	L3123
6986  13bc 9c            	rvf
6987  13bd ce001b        	ldw	x,_adc_buff_+18
6988  13c0 a30253        	cpw	x,#595
6989  13c3 2e06          	jrsge	L3123
6992  13c5 725f0008      	clr	_adr+2
6994  13c9 204c          	jra	L5123
6995  13cb               L3123:
6996                     ; 1412 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6998  13cb 9c            	rvf
6999  13cc ce001b        	ldw	x,_adc_buff_+18
7000  13cf a3036d        	cpw	x,#877
7001  13d2 2f0f          	jrslt	L7123
7003  13d4 9c            	rvf
7004  13d5 ce001b        	ldw	x,_adc_buff_+18
7005  13d8 a30396        	cpw	x,#918
7006  13db 2e06          	jrsge	L7123
7009  13dd 35010008      	mov	_adr+2,#1
7011  13e1 2034          	jra	L5123
7012  13e3               L7123:
7013                     ; 1413 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
7015  13e3 9c            	rvf
7016  13e4 ce001b        	ldw	x,_adc_buff_+18
7017  13e7 a302a3        	cpw	x,#675
7018  13ea 2f0f          	jrslt	L3223
7020  13ec 9c            	rvf
7021  13ed ce001b        	ldw	x,_adc_buff_+18
7022  13f0 a302cc        	cpw	x,#716
7023  13f3 2e06          	jrsge	L3223
7026  13f5 35020008      	mov	_adr+2,#2
7028  13f9 201c          	jra	L5123
7029  13fb               L3223:
7030                     ; 1414 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
7032  13fb 9c            	rvf
7033  13fc ce001b        	ldw	x,_adc_buff_+18
7034  13ff a303e3        	cpw	x,#995
7035  1402 2f0f          	jrslt	L7223
7037  1404 9c            	rvf
7038  1405 ce001b        	ldw	x,_adc_buff_+18
7039  1408 a3040c        	cpw	x,#1036
7040  140b 2e06          	jrsge	L7223
7043  140d 35030008      	mov	_adr+2,#3
7045  1411 2004          	jra	L5123
7046  1413               L7223:
7047                     ; 1415 else adr[2]=5;
7049  1413 35050008      	mov	_adr+2,#5
7050  1417               L5123:
7051                     ; 1419 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
7053  1417 c60006        	ld	a,_adr
7054  141a a105          	cp	a,#5
7055  141c 270e          	jreq	L5323
7057  141e c60007        	ld	a,_adr+1
7058  1421 a105          	cp	a,#5
7059  1423 2707          	jreq	L5323
7061  1425 c60008        	ld	a,_adr+2
7062  1428 a105          	cp	a,#5
7063  142a 2606          	jrne	L3323
7064  142c               L5323:
7065                     ; 1422 	adress_error=1;
7067  142c 35010004      	mov	_adress_error,#1
7069  1430               L1423:
7070                     ; 1433 }
7073  1430 84            	pop	a
7074  1431 81            	ret
7075  1432               L3323:
7076                     ; 1426 	if(adr[2]&0x02) bps_class=bpsIPS;
7078  1432 c60008        	ld	a,_adr+2
7079  1435 a502          	bcp	a,#2
7080  1437 2706          	jreq	L3423
7083  1439 35010004      	mov	_bps_class,#1
7085  143d 2002          	jra	L5423
7086  143f               L3423:
7087                     ; 1427 	else bps_class=bpsIBEP;
7089  143f 3f04          	clr	_bps_class
7090  1441               L5423:
7091                     ; 1429 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
7093  1441 c60008        	ld	a,_adr+2
7094  1444 a401          	and	a,#1
7095  1446 97            	ld	xl,a
7096  1447 a610          	ld	a,#16
7097  1449 42            	mul	x,a
7098  144a 9f            	ld	a,xl
7099  144b 6b01          	ld	(OFST+0,sp),a
7100  144d c60007        	ld	a,_adr+1
7101  1450 48            	sll	a
7102  1451 48            	sll	a
7103  1452 cb0006        	add	a,_adr
7104  1455 1b01          	add	a,(OFST+0,sp)
7105  1457 c70005        	ld	_adress,a
7106  145a 20d4          	jra	L1423
7150                     ; 1436 void volum_u_main_drv(void)
7150                     ; 1437 {
7151                     	switch	.text
7152  145c               _volum_u_main_drv:
7154  145c 88            	push	a
7155       00000001      OFST:	set	1
7158                     ; 1440 if(bMAIN)
7160                     	btst	_bMAIN
7161  1462 2503          	jrult	L241
7162  1464 cc15ad        	jp	L5623
7163  1467               L241:
7164                     ; 1442 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7166  1467 9c            	rvf
7167  1468 ce0008        	ldw	x,_UU_AVT
7168  146b 1d000a        	subw	x,#10
7169  146e b36d          	cpw	x,_Un
7170  1470 2d09          	jrsle	L7623
7173  1472 be1f          	ldw	x,_volum_u_main_
7174  1474 1c0005        	addw	x,#5
7175  1477 bf1f          	ldw	_volum_u_main_,x
7177  1479 2036          	jra	L1723
7178  147b               L7623:
7179                     ; 1443 	else if(Un<(UU_AVT-1))volum_u_main_++;
7181  147b 9c            	rvf
7182  147c ce0008        	ldw	x,_UU_AVT
7183  147f 5a            	decw	x
7184  1480 b36d          	cpw	x,_Un
7185  1482 2d09          	jrsle	L3723
7188  1484 be1f          	ldw	x,_volum_u_main_
7189  1486 1c0001        	addw	x,#1
7190  1489 bf1f          	ldw	_volum_u_main_,x
7192  148b 2024          	jra	L1723
7193  148d               L3723:
7194                     ; 1444 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7196  148d 9c            	rvf
7197  148e ce0008        	ldw	x,_UU_AVT
7198  1491 1c000a        	addw	x,#10
7199  1494 b36d          	cpw	x,_Un
7200  1496 2e09          	jrsge	L7723
7203  1498 be1f          	ldw	x,_volum_u_main_
7204  149a 1d000a        	subw	x,#10
7205  149d bf1f          	ldw	_volum_u_main_,x
7207  149f 2010          	jra	L1723
7208  14a1               L7723:
7209                     ; 1445 	else if(Un>(UU_AVT+1))volum_u_main_--;
7211  14a1 9c            	rvf
7212  14a2 ce0008        	ldw	x,_UU_AVT
7213  14a5 5c            	incw	x
7214  14a6 b36d          	cpw	x,_Un
7215  14a8 2e07          	jrsge	L1723
7218  14aa be1f          	ldw	x,_volum_u_main_
7219  14ac 1d0001        	subw	x,#1
7220  14af bf1f          	ldw	_volum_u_main_,x
7221  14b1               L1723:
7222                     ; 1446 	if(volum_u_main_>1020)volum_u_main_=1020;
7224  14b1 9c            	rvf
7225  14b2 be1f          	ldw	x,_volum_u_main_
7226  14b4 a303fd        	cpw	x,#1021
7227  14b7 2f05          	jrslt	L5033
7230  14b9 ae03fc        	ldw	x,#1020
7231  14bc bf1f          	ldw	_volum_u_main_,x
7232  14be               L5033:
7233                     ; 1447 	if(volum_u_main_<0)volum_u_main_=0;
7235  14be 9c            	rvf
7236  14bf be1f          	ldw	x,_volum_u_main_
7237  14c1 2e03          	jrsge	L7033
7240  14c3 5f            	clrw	x
7241  14c4 bf1f          	ldw	_volum_u_main_,x
7242  14c6               L7033:
7243                     ; 1450 	i_main_sigma=0;
7245  14c6 5f            	clrw	x
7246  14c7 bf0f          	ldw	_i_main_sigma,x
7247                     ; 1451 	i_main_num_of_bps=0;
7249  14c9 3f11          	clr	_i_main_num_of_bps
7250                     ; 1452 	for(i=0;i<6;i++)
7252  14cb 0f01          	clr	(OFST+0,sp)
7253  14cd               L1133:
7254                     ; 1454 		if(i_main_flag[i])
7256  14cd 7b01          	ld	a,(OFST+0,sp)
7257  14cf 5f            	clrw	x
7258  14d0 97            	ld	xl,a
7259  14d1 6d14          	tnz	(_i_main_flag,x)
7260  14d3 2719          	jreq	L7133
7261                     ; 1456 			i_main_sigma+=i_main[i];
7263  14d5 7b01          	ld	a,(OFST+0,sp)
7264  14d7 5f            	clrw	x
7265  14d8 97            	ld	xl,a
7266  14d9 58            	sllw	x
7267  14da ee1a          	ldw	x,(_i_main,x)
7268  14dc 72bb000f      	addw	x,_i_main_sigma
7269  14e0 bf0f          	ldw	_i_main_sigma,x
7270                     ; 1457 			i_main_flag[i]=1;
7272  14e2 7b01          	ld	a,(OFST+0,sp)
7273  14e4 5f            	clrw	x
7274  14e5 97            	ld	xl,a
7275  14e6 a601          	ld	a,#1
7276  14e8 e714          	ld	(_i_main_flag,x),a
7277                     ; 1458 			i_main_num_of_bps++;
7279  14ea 3c11          	inc	_i_main_num_of_bps
7281  14ec 2006          	jra	L1233
7282  14ee               L7133:
7283                     ; 1462 			i_main_flag[i]=0;	
7285  14ee 7b01          	ld	a,(OFST+0,sp)
7286  14f0 5f            	clrw	x
7287  14f1 97            	ld	xl,a
7288  14f2 6f14          	clr	(_i_main_flag,x)
7289  14f4               L1233:
7290                     ; 1452 	for(i=0;i<6;i++)
7292  14f4 0c01          	inc	(OFST+0,sp)
7295  14f6 7b01          	ld	a,(OFST+0,sp)
7296  14f8 a106          	cp	a,#6
7297  14fa 25d1          	jrult	L1133
7298                     ; 1465 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7300  14fc be0f          	ldw	x,_i_main_sigma
7301  14fe b611          	ld	a,_i_main_num_of_bps
7302  1500 905f          	clrw	y
7303  1502 9097          	ld	yl,a
7304  1504 cd0000        	call	c_idiv
7306  1507 bf12          	ldw	_i_main_avg,x
7307                     ; 1466 	for(i=0;i<6;i++)
7309  1509 0f01          	clr	(OFST+0,sp)
7310  150b               L3233:
7311                     ; 1468 		if(i_main_flag[i])
7313  150b 7b01          	ld	a,(OFST+0,sp)
7314  150d 5f            	clrw	x
7315  150e 97            	ld	xl,a
7316  150f 6d14          	tnz	(_i_main_flag,x)
7317  1511 2603cc15a2    	jreq	L1333
7318                     ; 1470 			if(i_main[i]<(i_main_avg-10))x[i]++;
7320  1516 9c            	rvf
7321  1517 7b01          	ld	a,(OFST+0,sp)
7322  1519 5f            	clrw	x
7323  151a 97            	ld	xl,a
7324  151b 58            	sllw	x
7325  151c 90be12        	ldw	y,_i_main_avg
7326  151f 72a2000a      	subw	y,#10
7327  1523 90bf00        	ldw	c_y,y
7328  1526 9093          	ldw	y,x
7329  1528 90ee1a        	ldw	y,(_i_main,y)
7330  152b 90b300        	cpw	y,c_y
7331  152e 2e11          	jrsge	L3333
7334  1530 7b01          	ld	a,(OFST+0,sp)
7335  1532 5f            	clrw	x
7336  1533 97            	ld	xl,a
7337  1534 58            	sllw	x
7338  1535 9093          	ldw	y,x
7339  1537 ee26          	ldw	x,(_x,x)
7340  1539 1c0001        	addw	x,#1
7341  153c 90ef26        	ldw	(_x,y),x
7343  153f 2029          	jra	L5333
7344  1541               L3333:
7345                     ; 1471 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7347  1541 9c            	rvf
7348  1542 7b01          	ld	a,(OFST+0,sp)
7349  1544 5f            	clrw	x
7350  1545 97            	ld	xl,a
7351  1546 58            	sllw	x
7352  1547 90be12        	ldw	y,_i_main_avg
7353  154a 72a9000a      	addw	y,#10
7354  154e 90bf00        	ldw	c_y,y
7355  1551 9093          	ldw	y,x
7356  1553 90ee1a        	ldw	y,(_i_main,y)
7357  1556 90b300        	cpw	y,c_y
7358  1559 2d0f          	jrsle	L5333
7361  155b 7b01          	ld	a,(OFST+0,sp)
7362  155d 5f            	clrw	x
7363  155e 97            	ld	xl,a
7364  155f 58            	sllw	x
7365  1560 9093          	ldw	y,x
7366  1562 ee26          	ldw	x,(_x,x)
7367  1564 1d0001        	subw	x,#1
7368  1567 90ef26        	ldw	(_x,y),x
7369  156a               L5333:
7370                     ; 1472 			if(x[i]>100)x[i]=100;
7372  156a 9c            	rvf
7373  156b 7b01          	ld	a,(OFST+0,sp)
7374  156d 5f            	clrw	x
7375  156e 97            	ld	xl,a
7376  156f 58            	sllw	x
7377  1570 9093          	ldw	y,x
7378  1572 90ee26        	ldw	y,(_x,y)
7379  1575 90a30065      	cpw	y,#101
7380  1579 2f0b          	jrslt	L1433
7383  157b 7b01          	ld	a,(OFST+0,sp)
7384  157d 5f            	clrw	x
7385  157e 97            	ld	xl,a
7386  157f 58            	sllw	x
7387  1580 90ae0064      	ldw	y,#100
7388  1584 ef26          	ldw	(_x,x),y
7389  1586               L1433:
7390                     ; 1473 			if(x[i]<-100)x[i]=-100;
7392  1586 9c            	rvf
7393  1587 7b01          	ld	a,(OFST+0,sp)
7394  1589 5f            	clrw	x
7395  158a 97            	ld	xl,a
7396  158b 58            	sllw	x
7397  158c 9093          	ldw	y,x
7398  158e 90ee26        	ldw	y,(_x,y)
7399  1591 90a3ff9c      	cpw	y,#65436
7400  1595 2e0b          	jrsge	L1333
7403  1597 7b01          	ld	a,(OFST+0,sp)
7404  1599 5f            	clrw	x
7405  159a 97            	ld	xl,a
7406  159b 58            	sllw	x
7407  159c 90aeff9c      	ldw	y,#65436
7408  15a0 ef26          	ldw	(_x,x),y
7409  15a2               L1333:
7410                     ; 1466 	for(i=0;i<6;i++)
7412  15a2 0c01          	inc	(OFST+0,sp)
7415  15a4 7b01          	ld	a,(OFST+0,sp)
7416  15a6 a106          	cp	a,#6
7417  15a8 2403cc150b    	jrult	L3233
7418  15ad               L5623:
7419                     ; 1480 }
7422  15ad 84            	pop	a
7423  15ae 81            	ret
7446                     ; 1483 void init_CAN(void) {
7447                     	switch	.text
7448  15af               _init_CAN:
7452                     ; 1484 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7454  15af 72135420      	bres	21536,#1
7455                     ; 1485 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7457  15b3 72105420      	bset	21536,#0
7459  15b7               L7533:
7460                     ; 1486 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7462  15b7 c65421        	ld	a,21537
7463  15ba a501          	bcp	a,#1
7464  15bc 27f9          	jreq	L7533
7465                     ; 1488 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7467  15be 72185420      	bset	21536,#4
7468                     ; 1490 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7470  15c2 35025427      	mov	21543,#2
7471                     ; 1499 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7473  15c6 35135428      	mov	21544,#19
7474                     ; 1500 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7476  15ca 35c05429      	mov	21545,#192
7477                     ; 1501 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7479  15ce 357f542c      	mov	21548,#127
7480                     ; 1502 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7482  15d2 35e0542d      	mov	21549,#224
7483                     ; 1504 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7485  15d6 35315430      	mov	21552,#49
7486                     ; 1505 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7488  15da 35c05431      	mov	21553,#192
7489                     ; 1506 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7491  15de 357f5434      	mov	21556,#127
7492                     ; 1507 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7494  15e2 35e05435      	mov	21557,#224
7495                     ; 1511 	CAN->PSR= 6;									// set page 6
7497  15e6 35065427      	mov	21543,#6
7498                     ; 1516 	CAN->Page.Config.FMR1&=~3;								//mask mode
7500  15ea c65430        	ld	a,21552
7501  15ed a4fc          	and	a,#252
7502  15ef c75430        	ld	21552,a
7503                     ; 1522 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7505  15f2 35065432      	mov	21554,#6
7506                     ; 1523 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7508  15f6 35605432      	mov	21554,#96
7509                     ; 1526 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7511  15fa 72105432      	bset	21554,#0
7512                     ; 1527 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7514  15fe 72185432      	bset	21554,#4
7515                     ; 1530 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7517  1602 35065427      	mov	21543,#6
7518                     ; 1532 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7520  1606 3509542c      	mov	21548,#9
7521                     ; 1533 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7523  160a 35e7542d      	mov	21549,#231
7524                     ; 1535 	CAN->IER|=(1<<1);
7526  160e 72125425      	bset	21541,#1
7527                     ; 1538 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7529  1612 72115420      	bres	21536,#0
7531  1616               L5633:
7532                     ; 1539 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7534  1616 c65421        	ld	a,21537
7535  1619 a501          	bcp	a,#1
7536  161b 26f9          	jrne	L5633
7537                     ; 1540 }
7540  161d 81            	ret
7648                     ; 1543 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7648                     ; 1544 {
7649                     	switch	.text
7650  161e               _can_transmit:
7652  161e 89            	pushw	x
7653       00000000      OFST:	set	0
7656                     ; 1546 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7658  161f b674          	ld	a,_can_buff_wr_ptr
7659  1621 a104          	cp	a,#4
7660  1623 2502          	jrult	L7443
7663  1625 3f74          	clr	_can_buff_wr_ptr
7664  1627               L7443:
7665                     ; 1548 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7667  1627 b674          	ld	a,_can_buff_wr_ptr
7668  1629 97            	ld	xl,a
7669  162a a610          	ld	a,#16
7670  162c 42            	mul	x,a
7671  162d 1601          	ldw	y,(OFST+1,sp)
7672  162f a606          	ld	a,#6
7673  1631               L051:
7674  1631 9054          	srlw	y
7675  1633 4a            	dec	a
7676  1634 26fb          	jrne	L051
7677  1636 909f          	ld	a,yl
7678  1638 e775          	ld	(_can_out_buff,x),a
7679                     ; 1549 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7681  163a b674          	ld	a,_can_buff_wr_ptr
7682  163c 97            	ld	xl,a
7683  163d a610          	ld	a,#16
7684  163f 42            	mul	x,a
7685  1640 7b02          	ld	a,(OFST+2,sp)
7686  1642 48            	sll	a
7687  1643 48            	sll	a
7688  1644 e776          	ld	(_can_out_buff+1,x),a
7689                     ; 1551 can_out_buff[can_buff_wr_ptr][2]=data0;
7691  1646 b674          	ld	a,_can_buff_wr_ptr
7692  1648 97            	ld	xl,a
7693  1649 a610          	ld	a,#16
7694  164b 42            	mul	x,a
7695  164c 7b05          	ld	a,(OFST+5,sp)
7696  164e e777          	ld	(_can_out_buff+2,x),a
7697                     ; 1552 can_out_buff[can_buff_wr_ptr][3]=data1;
7699  1650 b674          	ld	a,_can_buff_wr_ptr
7700  1652 97            	ld	xl,a
7701  1653 a610          	ld	a,#16
7702  1655 42            	mul	x,a
7703  1656 7b06          	ld	a,(OFST+6,sp)
7704  1658 e778          	ld	(_can_out_buff+3,x),a
7705                     ; 1553 can_out_buff[can_buff_wr_ptr][4]=data2;
7707  165a b674          	ld	a,_can_buff_wr_ptr
7708  165c 97            	ld	xl,a
7709  165d a610          	ld	a,#16
7710  165f 42            	mul	x,a
7711  1660 7b07          	ld	a,(OFST+7,sp)
7712  1662 e779          	ld	(_can_out_buff+4,x),a
7713                     ; 1554 can_out_buff[can_buff_wr_ptr][5]=data3;
7715  1664 b674          	ld	a,_can_buff_wr_ptr
7716  1666 97            	ld	xl,a
7717  1667 a610          	ld	a,#16
7718  1669 42            	mul	x,a
7719  166a 7b08          	ld	a,(OFST+8,sp)
7720  166c e77a          	ld	(_can_out_buff+5,x),a
7721                     ; 1555 can_out_buff[can_buff_wr_ptr][6]=data4;
7723  166e b674          	ld	a,_can_buff_wr_ptr
7724  1670 97            	ld	xl,a
7725  1671 a610          	ld	a,#16
7726  1673 42            	mul	x,a
7727  1674 7b09          	ld	a,(OFST+9,sp)
7728  1676 e77b          	ld	(_can_out_buff+6,x),a
7729                     ; 1556 can_out_buff[can_buff_wr_ptr][7]=data5;
7731  1678 b674          	ld	a,_can_buff_wr_ptr
7732  167a 97            	ld	xl,a
7733  167b a610          	ld	a,#16
7734  167d 42            	mul	x,a
7735  167e 7b0a          	ld	a,(OFST+10,sp)
7736  1680 e77c          	ld	(_can_out_buff+7,x),a
7737                     ; 1557 can_out_buff[can_buff_wr_ptr][8]=data6;
7739  1682 b674          	ld	a,_can_buff_wr_ptr
7740  1684 97            	ld	xl,a
7741  1685 a610          	ld	a,#16
7742  1687 42            	mul	x,a
7743  1688 7b0b          	ld	a,(OFST+11,sp)
7744  168a e77d          	ld	(_can_out_buff+8,x),a
7745                     ; 1558 can_out_buff[can_buff_wr_ptr][9]=data7;
7747  168c b674          	ld	a,_can_buff_wr_ptr
7748  168e 97            	ld	xl,a
7749  168f a610          	ld	a,#16
7750  1691 42            	mul	x,a
7751  1692 7b0c          	ld	a,(OFST+12,sp)
7752  1694 e77e          	ld	(_can_out_buff+9,x),a
7753                     ; 1560 can_buff_wr_ptr++;
7755  1696 3c74          	inc	_can_buff_wr_ptr
7756                     ; 1561 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7758  1698 b674          	ld	a,_can_buff_wr_ptr
7759  169a a104          	cp	a,#4
7760  169c 2502          	jrult	L1543
7763  169e 3f74          	clr	_can_buff_wr_ptr
7764  16a0               L1543:
7765                     ; 1562 } 
7768  16a0 85            	popw	x
7769  16a1 81            	ret
7798                     ; 1565 void can_tx_hndl(void)
7798                     ; 1566 {
7799                     	switch	.text
7800  16a2               _can_tx_hndl:
7804                     ; 1567 if(bTX_FREE)
7806  16a2 3d09          	tnz	_bTX_FREE
7807  16a4 2757          	jreq	L3643
7808                     ; 1569 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7810  16a6 b673          	ld	a,_can_buff_rd_ptr
7811  16a8 b174          	cp	a,_can_buff_wr_ptr
7812  16aa 275f          	jreq	L1743
7813                     ; 1571 		bTX_FREE=0;
7815  16ac 3f09          	clr	_bTX_FREE
7816                     ; 1573 		CAN->PSR= 0;
7818  16ae 725f5427      	clr	21543
7819                     ; 1574 		CAN->Page.TxMailbox.MDLCR=8;
7821  16b2 35085429      	mov	21545,#8
7822                     ; 1575 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7824  16b6 b673          	ld	a,_can_buff_rd_ptr
7825  16b8 97            	ld	xl,a
7826  16b9 a610          	ld	a,#16
7827  16bb 42            	mul	x,a
7828  16bc e675          	ld	a,(_can_out_buff,x)
7829  16be c7542a        	ld	21546,a
7830                     ; 1576 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7832  16c1 b673          	ld	a,_can_buff_rd_ptr
7833  16c3 97            	ld	xl,a
7834  16c4 a610          	ld	a,#16
7835  16c6 42            	mul	x,a
7836  16c7 e676          	ld	a,(_can_out_buff+1,x)
7837  16c9 c7542b        	ld	21547,a
7838                     ; 1578 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7840  16cc b673          	ld	a,_can_buff_rd_ptr
7841  16ce 97            	ld	xl,a
7842  16cf a610          	ld	a,#16
7843  16d1 42            	mul	x,a
7844  16d2 01            	rrwa	x,a
7845  16d3 ab77          	add	a,#_can_out_buff+2
7846  16d5 2401          	jrnc	L451
7847  16d7 5c            	incw	x
7848  16d8               L451:
7849  16d8 5f            	clrw	x
7850  16d9 97            	ld	xl,a
7851  16da bf00          	ldw	c_x,x
7852  16dc ae0008        	ldw	x,#8
7853  16df               L651:
7854  16df 5a            	decw	x
7855  16e0 92d600        	ld	a,([c_x],x)
7856  16e3 d7542e        	ld	(21550,x),a
7857  16e6 5d            	tnzw	x
7858  16e7 26f6          	jrne	L651
7859                     ; 1580 		can_buff_rd_ptr++;
7861  16e9 3c73          	inc	_can_buff_rd_ptr
7862                     ; 1581 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7864  16eb b673          	ld	a,_can_buff_rd_ptr
7865  16ed a104          	cp	a,#4
7866  16ef 2502          	jrult	L7643
7869  16f1 3f73          	clr	_can_buff_rd_ptr
7870  16f3               L7643:
7871                     ; 1583 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7873  16f3 72105428      	bset	21544,#0
7874                     ; 1584 		CAN->IER|=(1<<0);
7876  16f7 72105425      	bset	21541,#0
7877  16fb 200e          	jra	L1743
7878  16fd               L3643:
7879                     ; 1589 	tx_busy_cnt++;
7881  16fd 3c72          	inc	_tx_busy_cnt
7882                     ; 1590 	if(tx_busy_cnt>=100)
7884  16ff b672          	ld	a,_tx_busy_cnt
7885  1701 a164          	cp	a,#100
7886  1703 2506          	jrult	L1743
7887                     ; 1592 		tx_busy_cnt=0;
7889  1705 3f72          	clr	_tx_busy_cnt
7890                     ; 1593 		bTX_FREE=1;
7892  1707 35010009      	mov	_bTX_FREE,#1
7893  170b               L1743:
7894                     ; 1596 }
7897  170b 81            	ret
7936                     ; 1599 void net_drv(void)
7936                     ; 1600 { 
7937                     	switch	.text
7938  170c               _net_drv:
7942                     ; 1602 if(bMAIN)
7944                     	btst	_bMAIN
7945  1711 2503          	jrult	L261
7946  1713 cc17b9        	jp	L5053
7947  1716               L261:
7948                     ; 1604 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7950  1716 3c32          	inc	_cnt_net_drv
7951  1718 b632          	ld	a,_cnt_net_drv
7952  171a a107          	cp	a,#7
7953  171c 2502          	jrult	L7053
7956  171e 3f32          	clr	_cnt_net_drv
7957  1720               L7053:
7958                     ; 1606 	if(cnt_net_drv<=5) 
7960  1720 b632          	ld	a,_cnt_net_drv
7961  1722 a106          	cp	a,#6
7962  1724 244c          	jruge	L1153
7963                     ; 1608 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7965  1726 4be8          	push	#232
7966  1728 4be8          	push	#232
7967  172a b632          	ld	a,_cnt_net_drv
7968  172c 5f            	clrw	x
7969  172d 97            	ld	xl,a
7970  172e 58            	sllw	x
7971  172f ee26          	ldw	x,(_x,x)
7972  1731 72bb001f      	addw	x,_volum_u_main_
7973  1735 90ae0100      	ldw	y,#256
7974  1739 cd0000        	call	c_idiv
7976  173c 9f            	ld	a,xl
7977  173d 88            	push	a
7978  173e b632          	ld	a,_cnt_net_drv
7979  1740 5f            	clrw	x
7980  1741 97            	ld	xl,a
7981  1742 58            	sllw	x
7982  1743 e627          	ld	a,(_x+1,x)
7983  1745 bb20          	add	a,_volum_u_main_+1
7984  1747 88            	push	a
7985  1748 4b00          	push	#0
7986  174a 4bed          	push	#237
7987  174c 3b0032        	push	_cnt_net_drv
7988  174f 3b0032        	push	_cnt_net_drv
7989  1752 ae009e        	ldw	x,#158
7990  1755 cd161e        	call	_can_transmit
7992  1758 5b08          	addw	sp,#8
7993                     ; 1609 		i_main_bps_cnt[cnt_net_drv]++;
7995  175a b632          	ld	a,_cnt_net_drv
7996  175c 5f            	clrw	x
7997  175d 97            	ld	xl,a
7998  175e 6c09          	inc	(_i_main_bps_cnt,x)
7999                     ; 1610 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
8001  1760 b632          	ld	a,_cnt_net_drv
8002  1762 5f            	clrw	x
8003  1763 97            	ld	xl,a
8004  1764 e609          	ld	a,(_i_main_bps_cnt,x)
8005  1766 a10b          	cp	a,#11
8006  1768 254f          	jrult	L5053
8009  176a b632          	ld	a,_cnt_net_drv
8010  176c 5f            	clrw	x
8011  176d 97            	ld	xl,a
8012  176e 6f14          	clr	(_i_main_flag,x)
8013  1770 2047          	jra	L5053
8014  1772               L1153:
8015                     ; 1612 	else if(cnt_net_drv==6)
8017  1772 b632          	ld	a,_cnt_net_drv
8018  1774 a106          	cp	a,#6
8019  1776 2641          	jrne	L5053
8020                     ; 1614 		plazma_int[2]=pwm_u;
8022  1778 be0e          	ldw	x,_pwm_u
8023  177a bf37          	ldw	_plazma_int+4,x
8024                     ; 1615 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8026  177c 3b006b        	push	_Ui
8027  177f 3b006c        	push	_Ui+1
8028  1782 3b006d        	push	_Un
8029  1785 3b006e        	push	_Un+1
8030  1788 3b006f        	push	_I
8031  178b 3b0070        	push	_I+1
8032  178e 4bda          	push	#218
8033  1790 3b0005        	push	_adress
8034  1793 ae018e        	ldw	x,#398
8035  1796 cd161e        	call	_can_transmit
8037  1799 5b08          	addw	sp,#8
8038                     ; 1616 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8040  179b 3b0037        	push	_plazma_int+4
8041  179e 3b0038        	push	_plazma_int+5
8042  17a1 3b005f        	push	__x_+1
8043  17a4 3b000b        	push	_flags
8044  17a7 4b00          	push	#0
8045  17a9 3b0068        	push	_T
8046  17ac 4bdb          	push	#219
8047  17ae 3b0005        	push	_adress
8048  17b1 ae018e        	ldw	x,#398
8049  17b4 cd161e        	call	_can_transmit
8051  17b7 5b08          	addw	sp,#8
8052  17b9               L5053:
8053                     ; 1619 }
8056  17b9 81            	ret
8170                     ; 1622 void can_in_an(void)
8170                     ; 1623 {
8171                     	switch	.text
8172  17ba               _can_in_an:
8174  17ba 5205          	subw	sp,#5
8175       00000005      OFST:	set	5
8178                     ; 1633 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8180  17bc b6ca          	ld	a,_mess+6
8181  17be c10005        	cp	a,_adress
8182  17c1 2703          	jreq	L402
8183  17c3 cc18df        	jp	L5553
8184  17c6               L402:
8186  17c6 b6cb          	ld	a,_mess+7
8187  17c8 c10005        	cp	a,_adress
8188  17cb 2703          	jreq	L602
8189  17cd cc18df        	jp	L5553
8190  17d0               L602:
8192  17d0 b6cc          	ld	a,_mess+8
8193  17d2 a1ed          	cp	a,#237
8194  17d4 2703          	jreq	L012
8195  17d6 cc18df        	jp	L5553
8196  17d9               L012:
8197                     ; 1636 	can_error_cnt=0;
8199  17d9 3f71          	clr	_can_error_cnt
8200                     ; 1638 	bMAIN=0;
8202  17db 72110001      	bres	_bMAIN
8203                     ; 1639  	flags_tu=mess[9];
8205  17df 45cd60        	mov	_flags_tu,_mess+9
8206                     ; 1640  	if(flags_tu&0b00000001)
8208  17e2 b660          	ld	a,_flags_tu
8209  17e4 a501          	bcp	a,#1
8210  17e6 2706          	jreq	L7553
8211                     ; 1645  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8213  17e8 721a000b      	bset	_flags,#5
8215  17ec 200e          	jra	L1653
8216  17ee               L7553:
8217                     ; 1656  				flags&=0b11011111; 
8219  17ee 721b000b      	bres	_flags,#5
8220                     ; 1657  				off_bp_cnt=5*ee_TZAS;
8222  17f2 c60017        	ld	a,_ee_TZAS+1
8223  17f5 97            	ld	xl,a
8224  17f6 a605          	ld	a,#5
8225  17f8 42            	mul	x,a
8226  17f9 9f            	ld	a,xl
8227  17fa b753          	ld	_off_bp_cnt,a
8228  17fc               L1653:
8229                     ; 1663  	if(flags_tu&0b00000010) flags|=0b01000000;
8231  17fc b660          	ld	a,_flags_tu
8232  17fe a502          	bcp	a,#2
8233  1800 2706          	jreq	L3653
8236  1802 721c000b      	bset	_flags,#6
8238  1806 2004          	jra	L5653
8239  1808               L3653:
8240                     ; 1664  	else flags&=0b10111111; 
8242  1808 721d000b      	bres	_flags,#6
8243  180c               L5653:
8244                     ; 1666  	vol_u_temp=mess[10]+mess[11]*256;
8246  180c b6cf          	ld	a,_mess+11
8247  180e 5f            	clrw	x
8248  180f 97            	ld	xl,a
8249  1810 4f            	clr	a
8250  1811 02            	rlwa	x,a
8251  1812 01            	rrwa	x,a
8252  1813 bbce          	add	a,_mess+10
8253  1815 2401          	jrnc	L661
8254  1817 5c            	incw	x
8255  1818               L661:
8256  1818 b759          	ld	_vol_u_temp+1,a
8257  181a 9f            	ld	a,xl
8258  181b b758          	ld	_vol_u_temp,a
8259                     ; 1667  	vol_i_temp=mess[12]+mess[13]*256;  
8261  181d b6d1          	ld	a,_mess+13
8262  181f 5f            	clrw	x
8263  1820 97            	ld	xl,a
8264  1821 4f            	clr	a
8265  1822 02            	rlwa	x,a
8266  1823 01            	rrwa	x,a
8267  1824 bbd0          	add	a,_mess+12
8268  1826 2401          	jrnc	L071
8269  1828 5c            	incw	x
8270  1829               L071:
8271  1829 b757          	ld	_vol_i_temp+1,a
8272  182b 9f            	ld	a,xl
8273  182c b756          	ld	_vol_i_temp,a
8274                     ; 1676 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8276  182e b601          	ld	a,_vent_resurs_tx_cnt
8277  1830 a102          	cp	a,#2
8278  1832 2507          	jrult	L7653
8281  1834 ce0000        	ldw	x,_vent_resurs
8282  1837 bf37          	ldw	_plazma_int+4,x
8284  1839 2004          	jra	L1753
8285  183b               L7653:
8286                     ; 1677 	else plazma_int[2]=vent_resurs_sec_cnt;
8288  183b be02          	ldw	x,_vent_resurs_sec_cnt
8289  183d bf37          	ldw	_plazma_int+4,x
8290  183f               L1753:
8291                     ; 1678  	rotor_int=flags_tu+(((short)flags)<<8);
8293  183f b60b          	ld	a,_flags
8294  1841 5f            	clrw	x
8295  1842 97            	ld	xl,a
8296  1843 4f            	clr	a
8297  1844 02            	rlwa	x,a
8298  1845 01            	rrwa	x,a
8299  1846 bb60          	add	a,_flags_tu
8300  1848 2401          	jrnc	L271
8301  184a 5c            	incw	x
8302  184b               L271:
8303  184b b71e          	ld	_rotor_int+1,a
8304  184d 9f            	ld	a,xl
8305  184e b71d          	ld	_rotor_int,a
8306                     ; 1679 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8308  1850 3b006b        	push	_Ui
8309  1853 3b006c        	push	_Ui+1
8310  1856 3b006d        	push	_Un
8311  1859 3b006e        	push	_Un+1
8312  185c 3b006f        	push	_I
8313  185f 3b0070        	push	_I+1
8314  1862 4bda          	push	#218
8315  1864 3b0005        	push	_adress
8316  1867 ae018e        	ldw	x,#398
8317  186a cd161e        	call	_can_transmit
8319  186d 5b08          	addw	sp,#8
8320                     ; 1680 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8322  186f 3b0037        	push	_plazma_int+4
8323  1872 3b0038        	push	_plazma_int+5
8324  1875 3b005f        	push	__x_+1
8325  1878 3b000b        	push	_flags
8326  187b b601          	ld	a,_vent_resurs_tx_cnt
8327  187d 5f            	clrw	x
8328  187e 97            	ld	xl,a
8329  187f d60000        	ld	a,(_vent_resurs_buff,x)
8330  1882 88            	push	a
8331  1883 3b0068        	push	_T
8332  1886 4bdb          	push	#219
8333  1888 3b0005        	push	_adress
8334  188b ae018e        	ldw	x,#398
8335  188e cd161e        	call	_can_transmit
8337  1891 5b08          	addw	sp,#8
8338                     ; 1681      link_cnt=0;
8340  1893 5f            	clrw	x
8341  1894 bf61          	ldw	_link_cnt,x
8342                     ; 1682      link=ON;
8344  1896 35550063      	mov	_link,#85
8345                     ; 1684      if(flags_tu&0b10000000)
8347  189a b660          	ld	a,_flags_tu
8348  189c a580          	bcp	a,#128
8349  189e 2716          	jreq	L3753
8350                     ; 1686      	if(!res_fl)
8352  18a0 725d000b      	tnz	_res_fl
8353  18a4 2625          	jrne	L7753
8354                     ; 1688      		res_fl=1;
8356  18a6 a601          	ld	a,#1
8357  18a8 ae000b        	ldw	x,#_res_fl
8358  18ab cd0000        	call	c_eewrc
8360                     ; 1689      		bRES=1;
8362  18ae 35010012      	mov	_bRES,#1
8363                     ; 1690      		res_fl_cnt=0;
8365  18b2 3f41          	clr	_res_fl_cnt
8366  18b4 2015          	jra	L7753
8367  18b6               L3753:
8368                     ; 1695      	if(main_cnt>20)
8370  18b6 9c            	rvf
8371  18b7 be51          	ldw	x,_main_cnt
8372  18b9 a30015        	cpw	x,#21
8373  18bc 2f0d          	jrslt	L7753
8374                     ; 1697     			if(res_fl)
8376  18be 725d000b      	tnz	_res_fl
8377  18c2 2707          	jreq	L7753
8378                     ; 1699      			res_fl=0;
8380  18c4 4f            	clr	a
8381  18c5 ae000b        	ldw	x,#_res_fl
8382  18c8 cd0000        	call	c_eewrc
8384  18cb               L7753:
8385                     ; 1704       if(res_fl_)
8387  18cb 725d000a      	tnz	_res_fl_
8388  18cf 2603          	jrne	L212
8389  18d1 cc1e2a        	jp	L1253
8390  18d4               L212:
8391                     ; 1706       	res_fl_=0;
8393  18d4 4f            	clr	a
8394  18d5 ae000a        	ldw	x,#_res_fl_
8395  18d8 cd0000        	call	c_eewrc
8397  18db ac2a1e2a      	jpf	L1253
8398  18df               L5553:
8399                     ; 1709 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8401  18df b6ca          	ld	a,_mess+6
8402  18e1 c10005        	cp	a,_adress
8403  18e4 2703          	jreq	L412
8404  18e6 cc1af6        	jp	L1163
8405  18e9               L412:
8407  18e9 b6cb          	ld	a,_mess+7
8408  18eb c10005        	cp	a,_adress
8409  18ee 2703          	jreq	L612
8410  18f0 cc1af6        	jp	L1163
8411  18f3               L612:
8413  18f3 b6cc          	ld	a,_mess+8
8414  18f5 a1ee          	cp	a,#238
8415  18f7 2703          	jreq	L022
8416  18f9 cc1af6        	jp	L1163
8417  18fc               L022:
8419  18fc b6cd          	ld	a,_mess+9
8420  18fe b1ce          	cp	a,_mess+10
8421  1900 2703          	jreq	L222
8422  1902 cc1af6        	jp	L1163
8423  1905               L222:
8424                     ; 1711 	rotor_int++;
8426  1905 be1d          	ldw	x,_rotor_int
8427  1907 1c0001        	addw	x,#1
8428  190a bf1d          	ldw	_rotor_int,x
8429                     ; 1712 	if((mess[9]&0xf0)==0x20)
8431  190c b6cd          	ld	a,_mess+9
8432  190e a4f0          	and	a,#240
8433  1910 a120          	cp	a,#32
8434  1912 2673          	jrne	L3163
8435                     ; 1714 		if((mess[9]&0x0f)==0x01)
8437  1914 b6cd          	ld	a,_mess+9
8438  1916 a40f          	and	a,#15
8439  1918 a101          	cp	a,#1
8440  191a 260d          	jrne	L5163
8441                     ; 1716 			ee_K[0][0]=adc_buff_[4];
8443  191c ce0011        	ldw	x,_adc_buff_+8
8444  191f 89            	pushw	x
8445  1920 ae001a        	ldw	x,#_ee_K
8446  1923 cd0000        	call	c_eewrw
8448  1926 85            	popw	x
8450  1927 204a          	jra	L7163
8451  1929               L5163:
8452                     ; 1718 		else if((mess[9]&0x0f)==0x02)
8454  1929 b6cd          	ld	a,_mess+9
8455  192b a40f          	and	a,#15
8456  192d a102          	cp	a,#2
8457  192f 260b          	jrne	L1263
8458                     ; 1720 			ee_K[0][1]++;
8460  1931 ce001c        	ldw	x,_ee_K+2
8461  1934 1c0001        	addw	x,#1
8462  1937 cf001c        	ldw	_ee_K+2,x
8464  193a 2037          	jra	L7163
8465  193c               L1263:
8466                     ; 1722 		else if((mess[9]&0x0f)==0x03)
8468  193c b6cd          	ld	a,_mess+9
8469  193e a40f          	and	a,#15
8470  1940 a103          	cp	a,#3
8471  1942 260b          	jrne	L5263
8472                     ; 1724 			ee_K[0][1]+=10;
8474  1944 ce001c        	ldw	x,_ee_K+2
8475  1947 1c000a        	addw	x,#10
8476  194a cf001c        	ldw	_ee_K+2,x
8478  194d 2024          	jra	L7163
8479  194f               L5263:
8480                     ; 1726 		else if((mess[9]&0x0f)==0x04)
8482  194f b6cd          	ld	a,_mess+9
8483  1951 a40f          	and	a,#15
8484  1953 a104          	cp	a,#4
8485  1955 260b          	jrne	L1363
8486                     ; 1728 			ee_K[0][1]--;
8488  1957 ce001c        	ldw	x,_ee_K+2
8489  195a 1d0001        	subw	x,#1
8490  195d cf001c        	ldw	_ee_K+2,x
8492  1960 2011          	jra	L7163
8493  1962               L1363:
8494                     ; 1730 		else if((mess[9]&0x0f)==0x05)
8496  1962 b6cd          	ld	a,_mess+9
8497  1964 a40f          	and	a,#15
8498  1966 a105          	cp	a,#5
8499  1968 2609          	jrne	L7163
8500                     ; 1732 			ee_K[0][1]-=10;
8502  196a ce001c        	ldw	x,_ee_K+2
8503  196d 1d000a        	subw	x,#10
8504  1970 cf001c        	ldw	_ee_K+2,x
8505  1973               L7163:
8506                     ; 1734 		granee(&ee_K[0][1],50,3000);									
8508  1973 ae0bb8        	ldw	x,#3000
8509  1976 89            	pushw	x
8510  1977 ae0032        	ldw	x,#50
8511  197a 89            	pushw	x
8512  197b ae001c        	ldw	x,#_ee_K+2
8513  197e cd00f2        	call	_granee
8515  1981 5b04          	addw	sp,#4
8517  1983 acdb1adb      	jpf	L7363
8518  1987               L3163:
8519                     ; 1736 	else if((mess[9]&0xf0)==0x10)
8521  1987 b6cd          	ld	a,_mess+9
8522  1989 a4f0          	and	a,#240
8523  198b a110          	cp	a,#16
8524  198d 2673          	jrne	L1463
8525                     ; 1738 		if((mess[9]&0x0f)==0x01)
8527  198f b6cd          	ld	a,_mess+9
8528  1991 a40f          	and	a,#15
8529  1993 a101          	cp	a,#1
8530  1995 260d          	jrne	L3463
8531                     ; 1740 			ee_K[1][0]=adc_buff_[1];
8533  1997 ce000b        	ldw	x,_adc_buff_+2
8534  199a 89            	pushw	x
8535  199b ae001e        	ldw	x,#_ee_K+4
8536  199e cd0000        	call	c_eewrw
8538  19a1 85            	popw	x
8540  19a2 204a          	jra	L5463
8541  19a4               L3463:
8542                     ; 1742 		else if((mess[9]&0x0f)==0x02)
8544  19a4 b6cd          	ld	a,_mess+9
8545  19a6 a40f          	and	a,#15
8546  19a8 a102          	cp	a,#2
8547  19aa 260b          	jrne	L7463
8548                     ; 1744 			ee_K[1][1]++;
8550  19ac ce0020        	ldw	x,_ee_K+6
8551  19af 1c0001        	addw	x,#1
8552  19b2 cf0020        	ldw	_ee_K+6,x
8554  19b5 2037          	jra	L5463
8555  19b7               L7463:
8556                     ; 1746 		else if((mess[9]&0x0f)==0x03)
8558  19b7 b6cd          	ld	a,_mess+9
8559  19b9 a40f          	and	a,#15
8560  19bb a103          	cp	a,#3
8561  19bd 260b          	jrne	L3563
8562                     ; 1748 			ee_K[1][1]+=10;
8564  19bf ce0020        	ldw	x,_ee_K+6
8565  19c2 1c000a        	addw	x,#10
8566  19c5 cf0020        	ldw	_ee_K+6,x
8568  19c8 2024          	jra	L5463
8569  19ca               L3563:
8570                     ; 1750 		else if((mess[9]&0x0f)==0x04)
8572  19ca b6cd          	ld	a,_mess+9
8573  19cc a40f          	and	a,#15
8574  19ce a104          	cp	a,#4
8575  19d0 260b          	jrne	L7563
8576                     ; 1752 			ee_K[1][1]--;
8578  19d2 ce0020        	ldw	x,_ee_K+6
8579  19d5 1d0001        	subw	x,#1
8580  19d8 cf0020        	ldw	_ee_K+6,x
8582  19db 2011          	jra	L5463
8583  19dd               L7563:
8584                     ; 1754 		else if((mess[9]&0x0f)==0x05)
8586  19dd b6cd          	ld	a,_mess+9
8587  19df a40f          	and	a,#15
8588  19e1 a105          	cp	a,#5
8589  19e3 2609          	jrne	L5463
8590                     ; 1756 			ee_K[1][1]-=10;
8592  19e5 ce0020        	ldw	x,_ee_K+6
8593  19e8 1d000a        	subw	x,#10
8594  19eb cf0020        	ldw	_ee_K+6,x
8595  19ee               L5463:
8596                     ; 1761 		granee(&ee_K[1][1],10,30000);
8598  19ee ae7530        	ldw	x,#30000
8599  19f1 89            	pushw	x
8600  19f2 ae000a        	ldw	x,#10
8601  19f5 89            	pushw	x
8602  19f6 ae0020        	ldw	x,#_ee_K+6
8603  19f9 cd00f2        	call	_granee
8605  19fc 5b04          	addw	sp,#4
8607  19fe acdb1adb      	jpf	L7363
8608  1a02               L1463:
8609                     ; 1765 	else if((mess[9]&0xf0)==0x00)
8611  1a02 b6cd          	ld	a,_mess+9
8612  1a04 a5f0          	bcp	a,#240
8613  1a06 2671          	jrne	L7663
8614                     ; 1767 		if((mess[9]&0x0f)==0x01)
8616  1a08 b6cd          	ld	a,_mess+9
8617  1a0a a40f          	and	a,#15
8618  1a0c a101          	cp	a,#1
8619  1a0e 260d          	jrne	L1763
8620                     ; 1769 			ee_K[2][0]=adc_buff_[2];
8622  1a10 ce000d        	ldw	x,_adc_buff_+4
8623  1a13 89            	pushw	x
8624  1a14 ae0022        	ldw	x,#_ee_K+8
8625  1a17 cd0000        	call	c_eewrw
8627  1a1a 85            	popw	x
8629  1a1b 204a          	jra	L3763
8630  1a1d               L1763:
8631                     ; 1771 		else if((mess[9]&0x0f)==0x02)
8633  1a1d b6cd          	ld	a,_mess+9
8634  1a1f a40f          	and	a,#15
8635  1a21 a102          	cp	a,#2
8636  1a23 260b          	jrne	L5763
8637                     ; 1773 			ee_K[2][1]++;
8639  1a25 ce0024        	ldw	x,_ee_K+10
8640  1a28 1c0001        	addw	x,#1
8641  1a2b cf0024        	ldw	_ee_K+10,x
8643  1a2e 2037          	jra	L3763
8644  1a30               L5763:
8645                     ; 1775 		else if((mess[9]&0x0f)==0x03)
8647  1a30 b6cd          	ld	a,_mess+9
8648  1a32 a40f          	and	a,#15
8649  1a34 a103          	cp	a,#3
8650  1a36 260b          	jrne	L1073
8651                     ; 1777 			ee_K[2][1]+=10;
8653  1a38 ce0024        	ldw	x,_ee_K+10
8654  1a3b 1c000a        	addw	x,#10
8655  1a3e cf0024        	ldw	_ee_K+10,x
8657  1a41 2024          	jra	L3763
8658  1a43               L1073:
8659                     ; 1779 		else if((mess[9]&0x0f)==0x04)
8661  1a43 b6cd          	ld	a,_mess+9
8662  1a45 a40f          	and	a,#15
8663  1a47 a104          	cp	a,#4
8664  1a49 260b          	jrne	L5073
8665                     ; 1781 			ee_K[2][1]--;
8667  1a4b ce0024        	ldw	x,_ee_K+10
8668  1a4e 1d0001        	subw	x,#1
8669  1a51 cf0024        	ldw	_ee_K+10,x
8671  1a54 2011          	jra	L3763
8672  1a56               L5073:
8673                     ; 1783 		else if((mess[9]&0x0f)==0x05)
8675  1a56 b6cd          	ld	a,_mess+9
8676  1a58 a40f          	and	a,#15
8677  1a5a a105          	cp	a,#5
8678  1a5c 2609          	jrne	L3763
8679                     ; 1785 			ee_K[2][1]-=10;
8681  1a5e ce0024        	ldw	x,_ee_K+10
8682  1a61 1d000a        	subw	x,#10
8683  1a64 cf0024        	ldw	_ee_K+10,x
8684  1a67               L3763:
8685                     ; 1790 		granee(&ee_K[2][1],10,30000);
8687  1a67 ae7530        	ldw	x,#30000
8688  1a6a 89            	pushw	x
8689  1a6b ae000a        	ldw	x,#10
8690  1a6e 89            	pushw	x
8691  1a6f ae0024        	ldw	x,#_ee_K+10
8692  1a72 cd00f2        	call	_granee
8694  1a75 5b04          	addw	sp,#4
8696  1a77 2062          	jra	L7363
8697  1a79               L7663:
8698                     ; 1794 	else if((mess[9]&0xf0)==0x30)
8700  1a79 b6cd          	ld	a,_mess+9
8701  1a7b a4f0          	and	a,#240
8702  1a7d a130          	cp	a,#48
8703  1a7f 265a          	jrne	L7363
8704                     ; 1796 		if((mess[9]&0x0f)==0x02)
8706  1a81 b6cd          	ld	a,_mess+9
8707  1a83 a40f          	and	a,#15
8708  1a85 a102          	cp	a,#2
8709  1a87 260b          	jrne	L7173
8710                     ; 1798 			ee_K[3][1]++;
8712  1a89 ce0028        	ldw	x,_ee_K+14
8713  1a8c 1c0001        	addw	x,#1
8714  1a8f cf0028        	ldw	_ee_K+14,x
8716  1a92 2037          	jra	L1273
8717  1a94               L7173:
8718                     ; 1800 		else if((mess[9]&0x0f)==0x03)
8720  1a94 b6cd          	ld	a,_mess+9
8721  1a96 a40f          	and	a,#15
8722  1a98 a103          	cp	a,#3
8723  1a9a 260b          	jrne	L3273
8724                     ; 1802 			ee_K[3][1]+=10;
8726  1a9c ce0028        	ldw	x,_ee_K+14
8727  1a9f 1c000a        	addw	x,#10
8728  1aa2 cf0028        	ldw	_ee_K+14,x
8730  1aa5 2024          	jra	L1273
8731  1aa7               L3273:
8732                     ; 1804 		else if((mess[9]&0x0f)==0x04)
8734  1aa7 b6cd          	ld	a,_mess+9
8735  1aa9 a40f          	and	a,#15
8736  1aab a104          	cp	a,#4
8737  1aad 260b          	jrne	L7273
8738                     ; 1806 			ee_K[3][1]--;
8740  1aaf ce0028        	ldw	x,_ee_K+14
8741  1ab2 1d0001        	subw	x,#1
8742  1ab5 cf0028        	ldw	_ee_K+14,x
8744  1ab8 2011          	jra	L1273
8745  1aba               L7273:
8746                     ; 1808 		else if((mess[9]&0x0f)==0x05)
8748  1aba b6cd          	ld	a,_mess+9
8749  1abc a40f          	and	a,#15
8750  1abe a105          	cp	a,#5
8751  1ac0 2609          	jrne	L1273
8752                     ; 1810 			ee_K[3][1]-=10;
8754  1ac2 ce0028        	ldw	x,_ee_K+14
8755  1ac5 1d000a        	subw	x,#10
8756  1ac8 cf0028        	ldw	_ee_K+14,x
8757  1acb               L1273:
8758                     ; 1812 		granee(&ee_K[3][1],300,517);									
8760  1acb ae0205        	ldw	x,#517
8761  1ace 89            	pushw	x
8762  1acf ae012c        	ldw	x,#300
8763  1ad2 89            	pushw	x
8764  1ad3 ae0028        	ldw	x,#_ee_K+14
8765  1ad6 cd00f2        	call	_granee
8767  1ad9 5b04          	addw	sp,#4
8768  1adb               L7363:
8769                     ; 1815 	link_cnt=0;
8771  1adb 5f            	clrw	x
8772  1adc bf61          	ldw	_link_cnt,x
8773                     ; 1816      link=ON;
8775  1ade 35550063      	mov	_link,#85
8776                     ; 1817      if(res_fl_)
8778  1ae2 725d000a      	tnz	_res_fl_
8779  1ae6 2603          	jrne	L422
8780  1ae8 cc1e2a        	jp	L1253
8781  1aeb               L422:
8782                     ; 1819       	res_fl_=0;
8784  1aeb 4f            	clr	a
8785  1aec ae000a        	ldw	x,#_res_fl_
8786  1aef cd0000        	call	c_eewrc
8788  1af2 ac2a1e2a      	jpf	L1253
8789  1af6               L1163:
8790                     ; 1825 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8792  1af6 b6ca          	ld	a,_mess+6
8793  1af8 a1ff          	cp	a,#255
8794  1afa 2703          	jreq	L622
8795  1afc cc1b8a        	jp	L1473
8796  1aff               L622:
8798  1aff b6cb          	ld	a,_mess+7
8799  1b01 a1ff          	cp	a,#255
8800  1b03 2703          	jreq	L032
8801  1b05 cc1b8a        	jp	L1473
8802  1b08               L032:
8804  1b08 b6cc          	ld	a,_mess+8
8805  1b0a a162          	cp	a,#98
8806  1b0c 267c          	jrne	L1473
8807                     ; 1828 	tempSS=mess[9]+(mess[10]*256);
8809  1b0e b6ce          	ld	a,_mess+10
8810  1b10 5f            	clrw	x
8811  1b11 97            	ld	xl,a
8812  1b12 4f            	clr	a
8813  1b13 02            	rlwa	x,a
8814  1b14 01            	rrwa	x,a
8815  1b15 bbcd          	add	a,_mess+9
8816  1b17 2401          	jrnc	L471
8817  1b19 5c            	incw	x
8818  1b1a               L471:
8819  1b1a 02            	rlwa	x,a
8820  1b1b 1f04          	ldw	(OFST-1,sp),x
8821  1b1d 01            	rrwa	x,a
8822                     ; 1829 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8824  1b1e ce0014        	ldw	x,_ee_Umax
8825  1b21 1304          	cpw	x,(OFST-1,sp)
8826  1b23 270a          	jreq	L3473
8829  1b25 1e04          	ldw	x,(OFST-1,sp)
8830  1b27 89            	pushw	x
8831  1b28 ae0014        	ldw	x,#_ee_Umax
8832  1b2b cd0000        	call	c_eewrw
8834  1b2e 85            	popw	x
8835  1b2f               L3473:
8836                     ; 1830 	tempSS=mess[11]+(mess[12]*256);
8838  1b2f b6d0          	ld	a,_mess+12
8839  1b31 5f            	clrw	x
8840  1b32 97            	ld	xl,a
8841  1b33 4f            	clr	a
8842  1b34 02            	rlwa	x,a
8843  1b35 01            	rrwa	x,a
8844  1b36 bbcf          	add	a,_mess+11
8845  1b38 2401          	jrnc	L671
8846  1b3a 5c            	incw	x
8847  1b3b               L671:
8848  1b3b 02            	rlwa	x,a
8849  1b3c 1f04          	ldw	(OFST-1,sp),x
8850  1b3e 01            	rrwa	x,a
8851                     ; 1831 	if(ee_dU!=tempSS) ee_dU=tempSS;
8853  1b3f ce0012        	ldw	x,_ee_dU
8854  1b42 1304          	cpw	x,(OFST-1,sp)
8855  1b44 270a          	jreq	L5473
8858  1b46 1e04          	ldw	x,(OFST-1,sp)
8859  1b48 89            	pushw	x
8860  1b49 ae0012        	ldw	x,#_ee_dU
8861  1b4c cd0000        	call	c_eewrw
8863  1b4f 85            	popw	x
8864  1b50               L5473:
8865                     ; 1832 	if((mess[13]&0x0f)==0x5)
8867  1b50 b6d1          	ld	a,_mess+13
8868  1b52 a40f          	and	a,#15
8869  1b54 a105          	cp	a,#5
8870  1b56 261a          	jrne	L7473
8871                     ; 1834 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8873  1b58 ce0006        	ldw	x,_ee_AVT_MODE
8874  1b5b a30055        	cpw	x,#85
8875  1b5e 2603          	jrne	L232
8876  1b60 cc1e2a        	jp	L1253
8877  1b63               L232:
8880  1b63 ae0055        	ldw	x,#85
8881  1b66 89            	pushw	x
8882  1b67 ae0006        	ldw	x,#_ee_AVT_MODE
8883  1b6a cd0000        	call	c_eewrw
8885  1b6d 85            	popw	x
8886  1b6e ac2a1e2a      	jpf	L1253
8887  1b72               L7473:
8888                     ; 1836 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8890  1b72 ce0006        	ldw	x,_ee_AVT_MODE
8891  1b75 a30055        	cpw	x,#85
8892  1b78 2703          	jreq	L432
8893  1b7a cc1e2a        	jp	L1253
8894  1b7d               L432:
8897  1b7d 5f            	clrw	x
8898  1b7e 89            	pushw	x
8899  1b7f ae0006        	ldw	x,#_ee_AVT_MODE
8900  1b82 cd0000        	call	c_eewrw
8902  1b85 85            	popw	x
8903  1b86 ac2a1e2a      	jpf	L1253
8904  1b8a               L1473:
8905                     ; 1839 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8907  1b8a b6ca          	ld	a,_mess+6
8908  1b8c a1ff          	cp	a,#255
8909  1b8e 2703          	jreq	L632
8910  1b90 cc1c61        	jp	L1673
8911  1b93               L632:
8913  1b93 b6cb          	ld	a,_mess+7
8914  1b95 a1ff          	cp	a,#255
8915  1b97 2703          	jreq	L042
8916  1b99 cc1c61        	jp	L1673
8917  1b9c               L042:
8919  1b9c b6cc          	ld	a,_mess+8
8920  1b9e a126          	cp	a,#38
8921  1ba0 2709          	jreq	L3673
8923  1ba2 b6cc          	ld	a,_mess+8
8924  1ba4 a129          	cp	a,#41
8925  1ba6 2703          	jreq	L242
8926  1ba8 cc1c61        	jp	L1673
8927  1bab               L242:
8928  1bab               L3673:
8929                     ; 1842 	tempSS=mess[9]+(mess[10]*256);
8931  1bab b6ce          	ld	a,_mess+10
8932  1bad 5f            	clrw	x
8933  1bae 97            	ld	xl,a
8934  1baf 4f            	clr	a
8935  1bb0 02            	rlwa	x,a
8936  1bb1 01            	rrwa	x,a
8937  1bb2 bbcd          	add	a,_mess+9
8938  1bb4 2401          	jrnc	L002
8939  1bb6 5c            	incw	x
8940  1bb7               L002:
8941  1bb7 02            	rlwa	x,a
8942  1bb8 1f04          	ldw	(OFST-1,sp),x
8943  1bba 01            	rrwa	x,a
8944                     ; 1843 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8946  1bbb ce0010        	ldw	x,_ee_tmax
8947  1bbe 1304          	cpw	x,(OFST-1,sp)
8948  1bc0 270a          	jreq	L5673
8951  1bc2 1e04          	ldw	x,(OFST-1,sp)
8952  1bc4 89            	pushw	x
8953  1bc5 ae0010        	ldw	x,#_ee_tmax
8954  1bc8 cd0000        	call	c_eewrw
8956  1bcb 85            	popw	x
8957  1bcc               L5673:
8958                     ; 1844 	tempSS=mess[11]+(mess[12]*256);
8960  1bcc b6d0          	ld	a,_mess+12
8961  1bce 5f            	clrw	x
8962  1bcf 97            	ld	xl,a
8963  1bd0 4f            	clr	a
8964  1bd1 02            	rlwa	x,a
8965  1bd2 01            	rrwa	x,a
8966  1bd3 bbcf          	add	a,_mess+11
8967  1bd5 2401          	jrnc	L202
8968  1bd7 5c            	incw	x
8969  1bd8               L202:
8970  1bd8 02            	rlwa	x,a
8971  1bd9 1f04          	ldw	(OFST-1,sp),x
8972  1bdb 01            	rrwa	x,a
8973                     ; 1845 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8975  1bdc ce000e        	ldw	x,_ee_tsign
8976  1bdf 1304          	cpw	x,(OFST-1,sp)
8977  1be1 270a          	jreq	L7673
8980  1be3 1e04          	ldw	x,(OFST-1,sp)
8981  1be5 89            	pushw	x
8982  1be6 ae000e        	ldw	x,#_ee_tsign
8983  1be9 cd0000        	call	c_eewrw
8985  1bec 85            	popw	x
8986  1bed               L7673:
8987                     ; 1848 	if(mess[8]==MEM_KF1)
8989  1bed b6cc          	ld	a,_mess+8
8990  1bef a126          	cp	a,#38
8991  1bf1 2623          	jrne	L1773
8992                     ; 1850 		if(ee_DEVICE!=0)ee_DEVICE=0;
8994  1bf3 ce0004        	ldw	x,_ee_DEVICE
8995  1bf6 2709          	jreq	L3773
8998  1bf8 5f            	clrw	x
8999  1bf9 89            	pushw	x
9000  1bfa ae0004        	ldw	x,#_ee_DEVICE
9001  1bfd cd0000        	call	c_eewrw
9003  1c00 85            	popw	x
9004  1c01               L3773:
9005                     ; 1851 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
9007  1c01 b6d1          	ld	a,_mess+13
9008  1c03 5f            	clrw	x
9009  1c04 97            	ld	xl,a
9010  1c05 c30016        	cpw	x,_ee_TZAS
9011  1c08 270c          	jreq	L1773
9014  1c0a b6d1          	ld	a,_mess+13
9015  1c0c 5f            	clrw	x
9016  1c0d 97            	ld	xl,a
9017  1c0e 89            	pushw	x
9018  1c0f ae0016        	ldw	x,#_ee_TZAS
9019  1c12 cd0000        	call	c_eewrw
9021  1c15 85            	popw	x
9022  1c16               L1773:
9023                     ; 1853 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
9025  1c16 b6cc          	ld	a,_mess+8
9026  1c18 a129          	cp	a,#41
9027  1c1a 2703          	jreq	L442
9028  1c1c cc1e2a        	jp	L1253
9029  1c1f               L442:
9030                     ; 1855 		if(ee_DEVICE!=1)ee_DEVICE=1;
9032  1c1f ce0004        	ldw	x,_ee_DEVICE
9033  1c22 a30001        	cpw	x,#1
9034  1c25 270b          	jreq	L1004
9037  1c27 ae0001        	ldw	x,#1
9038  1c2a 89            	pushw	x
9039  1c2b ae0004        	ldw	x,#_ee_DEVICE
9040  1c2e cd0000        	call	c_eewrw
9042  1c31 85            	popw	x
9043  1c32               L1004:
9044                     ; 1856 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
9046  1c32 b6d1          	ld	a,_mess+13
9047  1c34 5f            	clrw	x
9048  1c35 97            	ld	xl,a
9049  1c36 c30002        	cpw	x,_ee_IMAXVENT
9050  1c39 270c          	jreq	L3004
9053  1c3b b6d1          	ld	a,_mess+13
9054  1c3d 5f            	clrw	x
9055  1c3e 97            	ld	xl,a
9056  1c3f 89            	pushw	x
9057  1c40 ae0002        	ldw	x,#_ee_IMAXVENT
9058  1c43 cd0000        	call	c_eewrw
9060  1c46 85            	popw	x
9061  1c47               L3004:
9062                     ; 1857 			if(ee_TZAS!=3) ee_TZAS=3;
9064  1c47 ce0016        	ldw	x,_ee_TZAS
9065  1c4a a30003        	cpw	x,#3
9066  1c4d 2603          	jrne	L642
9067  1c4f cc1e2a        	jp	L1253
9068  1c52               L642:
9071  1c52 ae0003        	ldw	x,#3
9072  1c55 89            	pushw	x
9073  1c56 ae0016        	ldw	x,#_ee_TZAS
9074  1c59 cd0000        	call	c_eewrw
9076  1c5c 85            	popw	x
9077  1c5d ac2a1e2a      	jpf	L1253
9078  1c61               L1673:
9079                     ; 1861 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
9081  1c61 b6ca          	ld	a,_mess+6
9082  1c63 c10005        	cp	a,_adress
9083  1c66 262d          	jrne	L1104
9085  1c68 b6cb          	ld	a,_mess+7
9086  1c6a c10005        	cp	a,_adress
9087  1c6d 2626          	jrne	L1104
9089  1c6f b6cc          	ld	a,_mess+8
9090  1c71 a116          	cp	a,#22
9091  1c73 2620          	jrne	L1104
9093  1c75 b6cd          	ld	a,_mess+9
9094  1c77 a163          	cp	a,#99
9095  1c79 261a          	jrne	L1104
9096                     ; 1863 	flags&=0b11100001;
9098  1c7b b60b          	ld	a,_flags
9099  1c7d a4e1          	and	a,#225
9100  1c7f b70b          	ld	_flags,a
9101                     ; 1864 	tsign_cnt=0;
9103  1c81 5f            	clrw	x
9104  1c82 bf4d          	ldw	_tsign_cnt,x
9105                     ; 1865 	tmax_cnt=0;
9107  1c84 5f            	clrw	x
9108  1c85 bf4b          	ldw	_tmax_cnt,x
9109                     ; 1866 	umax_cnt=0;
9111  1c87 5f            	clrw	x
9112  1c88 bf66          	ldw	_umax_cnt,x
9113                     ; 1867 	umin_cnt=0;
9115  1c8a 5f            	clrw	x
9116  1c8b bf64          	ldw	_umin_cnt,x
9117                     ; 1868 	led_drv_cnt=30;
9119  1c8d 351e001c      	mov	_led_drv_cnt,#30
9121  1c91 ac2a1e2a      	jpf	L1253
9122  1c95               L1104:
9123                     ; 1871 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
9125  1c95 b6ca          	ld	a,_mess+6
9126  1c97 c10005        	cp	a,_adress
9127  1c9a 2620          	jrne	L5104
9129  1c9c b6cb          	ld	a,_mess+7
9130  1c9e c10005        	cp	a,_adress
9131  1ca1 2619          	jrne	L5104
9133  1ca3 b6cc          	ld	a,_mess+8
9134  1ca5 a116          	cp	a,#22
9135  1ca7 2613          	jrne	L5104
9137  1ca9 b6cd          	ld	a,_mess+9
9138  1cab a164          	cp	a,#100
9139  1cad 260d          	jrne	L5104
9140                     ; 1873 	vent_resurs=0;
9142  1caf 5f            	clrw	x
9143  1cb0 89            	pushw	x
9144  1cb1 ae0000        	ldw	x,#_vent_resurs
9145  1cb4 cd0000        	call	c_eewrw
9147  1cb7 85            	popw	x
9149  1cb8 ac2a1e2a      	jpf	L1253
9150  1cbc               L5104:
9151                     ; 1877 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
9153  1cbc b6ca          	ld	a,_mess+6
9154  1cbe a1ff          	cp	a,#255
9155  1cc0 265f          	jrne	L1204
9157  1cc2 b6cb          	ld	a,_mess+7
9158  1cc4 a1ff          	cp	a,#255
9159  1cc6 2659          	jrne	L1204
9161  1cc8 b6cc          	ld	a,_mess+8
9162  1cca a116          	cp	a,#22
9163  1ccc 2653          	jrne	L1204
9165  1cce b6cd          	ld	a,_mess+9
9166  1cd0 a116          	cp	a,#22
9167  1cd2 264d          	jrne	L1204
9168                     ; 1879 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9170  1cd4 b6ce          	ld	a,_mess+10
9171  1cd6 a155          	cp	a,#85
9172  1cd8 260f          	jrne	L3204
9174  1cda b6cf          	ld	a,_mess+11
9175  1cdc a155          	cp	a,#85
9176  1cde 2609          	jrne	L3204
9179  1ce0 be5e          	ldw	x,__x_
9180  1ce2 1c0001        	addw	x,#1
9181  1ce5 bf5e          	ldw	__x_,x
9183  1ce7 2024          	jra	L5204
9184  1ce9               L3204:
9185                     ; 1880 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9187  1ce9 b6ce          	ld	a,_mess+10
9188  1ceb a166          	cp	a,#102
9189  1ced 260f          	jrne	L7204
9191  1cef b6cf          	ld	a,_mess+11
9192  1cf1 a166          	cp	a,#102
9193  1cf3 2609          	jrne	L7204
9196  1cf5 be5e          	ldw	x,__x_
9197  1cf7 1d0001        	subw	x,#1
9198  1cfa bf5e          	ldw	__x_,x
9200  1cfc 200f          	jra	L5204
9201  1cfe               L7204:
9202                     ; 1881 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9204  1cfe b6ce          	ld	a,_mess+10
9205  1d00 a177          	cp	a,#119
9206  1d02 2609          	jrne	L5204
9208  1d04 b6cf          	ld	a,_mess+11
9209  1d06 a177          	cp	a,#119
9210  1d08 2603          	jrne	L5204
9213  1d0a 5f            	clrw	x
9214  1d0b bf5e          	ldw	__x_,x
9215  1d0d               L5204:
9216                     ; 1882      gran(&_x_,-XMAX,XMAX);
9218  1d0d ae0019        	ldw	x,#25
9219  1d10 89            	pushw	x
9220  1d11 aeffe7        	ldw	x,#65511
9221  1d14 89            	pushw	x
9222  1d15 ae005e        	ldw	x,#__x_
9223  1d18 cd00d1        	call	_gran
9225  1d1b 5b04          	addw	sp,#4
9227  1d1d ac2a1e2a      	jpf	L1253
9228  1d21               L1204:
9229                     ; 1884 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9231  1d21 b6ca          	ld	a,_mess+6
9232  1d23 c10005        	cp	a,_adress
9233  1d26 2665          	jrne	L7304
9235  1d28 b6cb          	ld	a,_mess+7
9236  1d2a c10005        	cp	a,_adress
9237  1d2d 265e          	jrne	L7304
9239  1d2f b6cc          	ld	a,_mess+8
9240  1d31 a116          	cp	a,#22
9241  1d33 2658          	jrne	L7304
9243  1d35 b6cd          	ld	a,_mess+9
9244  1d37 b1ce          	cp	a,_mess+10
9245  1d39 2652          	jrne	L7304
9247  1d3b b6cd          	ld	a,_mess+9
9248  1d3d a1ee          	cp	a,#238
9249  1d3f 264c          	jrne	L7304
9250                     ; 1886 	rotor_int++;
9252  1d41 be1d          	ldw	x,_rotor_int
9253  1d43 1c0001        	addw	x,#1
9254  1d46 bf1d          	ldw	_rotor_int,x
9255                     ; 1887      tempI=pwm_u;
9257  1d48 be0e          	ldw	x,_pwm_u
9258  1d4a 1f04          	ldw	(OFST-1,sp),x
9259                     ; 1888 	ee_U_AVT=tempI;
9261  1d4c 1e04          	ldw	x,(OFST-1,sp)
9262  1d4e 89            	pushw	x
9263  1d4f ae000c        	ldw	x,#_ee_U_AVT
9264  1d52 cd0000        	call	c_eewrw
9266  1d55 85            	popw	x
9267                     ; 1889 	UU_AVT=Un;
9269  1d56 be6d          	ldw	x,_Un
9270  1d58 89            	pushw	x
9271  1d59 ae0008        	ldw	x,#_UU_AVT
9272  1d5c cd0000        	call	c_eewrw
9274  1d5f 85            	popw	x
9275                     ; 1890 	delay_ms(100);
9277  1d60 ae0064        	ldw	x,#100
9278  1d63 cd011d        	call	_delay_ms
9280                     ; 1891 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9282  1d66 ce000c        	ldw	x,_ee_U_AVT
9283  1d69 1304          	cpw	x,(OFST-1,sp)
9284  1d6b 2703          	jreq	L052
9285  1d6d cc1e2a        	jp	L1253
9286  1d70               L052:
9289  1d70 4b00          	push	#0
9290  1d72 4b00          	push	#0
9291  1d74 4b00          	push	#0
9292  1d76 4b00          	push	#0
9293  1d78 4bdd          	push	#221
9294  1d7a 4bdd          	push	#221
9295  1d7c 4b91          	push	#145
9296  1d7e 3b0005        	push	_adress
9297  1d81 ae018e        	ldw	x,#398
9298  1d84 cd161e        	call	_can_transmit
9300  1d87 5b08          	addw	sp,#8
9301  1d89 ac2a1e2a      	jpf	L1253
9302  1d8d               L7304:
9303                     ; 1896 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9305  1d8d b6cb          	ld	a,_mess+7
9306  1d8f a1da          	cp	a,#218
9307  1d91 2652          	jrne	L5404
9309  1d93 b6ca          	ld	a,_mess+6
9310  1d95 c10005        	cp	a,_adress
9311  1d98 274b          	jreq	L5404
9313  1d9a b6ca          	ld	a,_mess+6
9314  1d9c a106          	cp	a,#6
9315  1d9e 2445          	jruge	L5404
9316                     ; 1898 	i_main_bps_cnt[mess[6]]=0;
9318  1da0 b6ca          	ld	a,_mess+6
9319  1da2 5f            	clrw	x
9320  1da3 97            	ld	xl,a
9321  1da4 6f09          	clr	(_i_main_bps_cnt,x)
9322                     ; 1899 	i_main_flag[mess[6]]=1;
9324  1da6 b6ca          	ld	a,_mess+6
9325  1da8 5f            	clrw	x
9326  1da9 97            	ld	xl,a
9327  1daa a601          	ld	a,#1
9328  1dac e714          	ld	(_i_main_flag,x),a
9329                     ; 1900 	if(bMAIN)
9331                     	btst	_bMAIN
9332  1db3 2475          	jruge	L1253
9333                     ; 1902 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9335  1db5 b6cd          	ld	a,_mess+9
9336  1db7 5f            	clrw	x
9337  1db8 97            	ld	xl,a
9338  1db9 4f            	clr	a
9339  1dba 02            	rlwa	x,a
9340  1dbb 1f01          	ldw	(OFST-4,sp),x
9341  1dbd b6cc          	ld	a,_mess+8
9342  1dbf 5f            	clrw	x
9343  1dc0 97            	ld	xl,a
9344  1dc1 72fb01        	addw	x,(OFST-4,sp)
9345  1dc4 b6ca          	ld	a,_mess+6
9346  1dc6 905f          	clrw	y
9347  1dc8 9097          	ld	yl,a
9348  1dca 9058          	sllw	y
9349  1dcc 90ef1a        	ldw	(_i_main,y),x
9350                     ; 1903 		i_main[adress]=I;
9352  1dcf c60005        	ld	a,_adress
9353  1dd2 5f            	clrw	x
9354  1dd3 97            	ld	xl,a
9355  1dd4 58            	sllw	x
9356  1dd5 90be6f        	ldw	y,_I
9357  1dd8 ef1a          	ldw	(_i_main,x),y
9358                     ; 1904      	i_main_flag[adress]=1;
9360  1dda c60005        	ld	a,_adress
9361  1ddd 5f            	clrw	x
9362  1dde 97            	ld	xl,a
9363  1ddf a601          	ld	a,#1
9364  1de1 e714          	ld	(_i_main_flag,x),a
9365  1de3 2045          	jra	L1253
9366  1de5               L5404:
9367                     ; 1908 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9369  1de5 b6cb          	ld	a,_mess+7
9370  1de7 a1db          	cp	a,#219
9371  1de9 263f          	jrne	L1253
9373  1deb b6ca          	ld	a,_mess+6
9374  1ded c10005        	cp	a,_adress
9375  1df0 2738          	jreq	L1253
9377  1df2 b6ca          	ld	a,_mess+6
9378  1df4 a106          	cp	a,#6
9379  1df6 2432          	jruge	L1253
9380                     ; 1910 	i_main_bps_cnt[mess[6]]=0;
9382  1df8 b6ca          	ld	a,_mess+6
9383  1dfa 5f            	clrw	x
9384  1dfb 97            	ld	xl,a
9385  1dfc 6f09          	clr	(_i_main_bps_cnt,x)
9386                     ; 1911 	i_main_flag[mess[6]]=1;		
9388  1dfe b6ca          	ld	a,_mess+6
9389  1e00 5f            	clrw	x
9390  1e01 97            	ld	xl,a
9391  1e02 a601          	ld	a,#1
9392  1e04 e714          	ld	(_i_main_flag,x),a
9393                     ; 1912 	if(bMAIN)
9395                     	btst	_bMAIN
9396  1e0b 241d          	jruge	L1253
9397                     ; 1914 		if(mess[9]==0)i_main_flag[i]=1;
9399  1e0d 3dcd          	tnz	_mess+9
9400  1e0f 260a          	jrne	L7504
9403  1e11 7b03          	ld	a,(OFST-2,sp)
9404  1e13 5f            	clrw	x
9405  1e14 97            	ld	xl,a
9406  1e15 a601          	ld	a,#1
9407  1e17 e714          	ld	(_i_main_flag,x),a
9409  1e19 2006          	jra	L1604
9410  1e1b               L7504:
9411                     ; 1915 		else i_main_flag[i]=0;
9413  1e1b 7b03          	ld	a,(OFST-2,sp)
9414  1e1d 5f            	clrw	x
9415  1e1e 97            	ld	xl,a
9416  1e1f 6f14          	clr	(_i_main_flag,x)
9417  1e21               L1604:
9418                     ; 1916 		i_main_flag[adress]=1;
9420  1e21 c60005        	ld	a,_adress
9421  1e24 5f            	clrw	x
9422  1e25 97            	ld	xl,a
9423  1e26 a601          	ld	a,#1
9424  1e28 e714          	ld	(_i_main_flag,x),a
9425  1e2a               L1253:
9426                     ; 1922 can_in_an_end:
9426                     ; 1923 bCAN_RX=0;
9428  1e2a 3f0a          	clr	_bCAN_RX
9429                     ; 1924 }   
9432  1e2c 5b05          	addw	sp,#5
9433  1e2e 81            	ret
9456                     ; 1927 void t4_init(void){
9457                     	switch	.text
9458  1e2f               _t4_init:
9462                     ; 1928 	TIM4->PSCR = 4;
9464  1e2f 35045345      	mov	21317,#4
9465                     ; 1929 	TIM4->ARR= 61;
9467  1e33 353d5346      	mov	21318,#61
9468                     ; 1930 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9470  1e37 72105341      	bset	21313,#0
9471                     ; 1932 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9473  1e3b 35855340      	mov	21312,#133
9474                     ; 1934 }
9477  1e3f 81            	ret
9500                     ; 1937 void t1_init(void)
9500                     ; 1938 {
9501                     	switch	.text
9502  1e40               _t1_init:
9506                     ; 1939 TIM1->ARRH= 0x03;
9508  1e40 35035262      	mov	21090,#3
9509                     ; 1940 TIM1->ARRL= 0xff;
9511  1e44 35ff5263      	mov	21091,#255
9512                     ; 1941 TIM1->CCR1H= 0x00;	
9514  1e48 725f5265      	clr	21093
9515                     ; 1942 TIM1->CCR1L= 0xff;
9517  1e4c 35ff5266      	mov	21094,#255
9518                     ; 1943 TIM1->CCR2H= 0x00;	
9520  1e50 725f5267      	clr	21095
9521                     ; 1944 TIM1->CCR2L= 0x00;
9523  1e54 725f5268      	clr	21096
9524                     ; 1945 TIM1->CCR3H= 0x00;	
9526  1e58 725f5269      	clr	21097
9527                     ; 1946 TIM1->CCR3L= 0x64;
9529  1e5c 3564526a      	mov	21098,#100
9530                     ; 1948 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9532  1e60 35685258      	mov	21080,#104
9533                     ; 1949 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9535  1e64 35685259      	mov	21081,#104
9536                     ; 1950 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9538  1e68 3568525a      	mov	21082,#104
9539                     ; 1951 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9541  1e6c 3511525c      	mov	21084,#17
9542                     ; 1952 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9544  1e70 3501525d      	mov	21085,#1
9545                     ; 1953 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9547  1e74 35815250      	mov	21072,#129
9548                     ; 1954 TIM1->BKR|= TIM1_BKR_AOE;
9550  1e78 721c526d      	bset	21101,#6
9551                     ; 1955 }
9554  1e7c 81            	ret
9579                     ; 1959 void adc2_init(void)
9579                     ; 1960 {
9580                     	switch	.text
9581  1e7d               _adc2_init:
9585                     ; 1961 adc_plazma[0]++;
9587  1e7d beb6          	ldw	x,_adc_plazma
9588  1e7f 1c0001        	addw	x,#1
9589  1e82 bfb6          	ldw	_adc_plazma,x
9590                     ; 1985 GPIOB->DDR&=~(1<<4);
9592  1e84 72195007      	bres	20487,#4
9593                     ; 1986 GPIOB->CR1&=~(1<<4);
9595  1e88 72195008      	bres	20488,#4
9596                     ; 1987 GPIOB->CR2&=~(1<<4);
9598  1e8c 72195009      	bres	20489,#4
9599                     ; 1989 GPIOB->DDR&=~(1<<5);
9601  1e90 721b5007      	bres	20487,#5
9602                     ; 1990 GPIOB->CR1&=~(1<<5);
9604  1e94 721b5008      	bres	20488,#5
9605                     ; 1991 GPIOB->CR2&=~(1<<5);
9607  1e98 721b5009      	bres	20489,#5
9608                     ; 1993 GPIOB->DDR&=~(1<<6);
9610  1e9c 721d5007      	bres	20487,#6
9611                     ; 1994 GPIOB->CR1&=~(1<<6);
9613  1ea0 721d5008      	bres	20488,#6
9614                     ; 1995 GPIOB->CR2&=~(1<<6);
9616  1ea4 721d5009      	bres	20489,#6
9617                     ; 1997 GPIOB->DDR&=~(1<<7);
9619  1ea8 721f5007      	bres	20487,#7
9620                     ; 1998 GPIOB->CR1&=~(1<<7);
9622  1eac 721f5008      	bres	20488,#7
9623                     ; 1999 GPIOB->CR2&=~(1<<7);
9625  1eb0 721f5009      	bres	20489,#7
9626                     ; 2009 ADC2->TDRL=0xff;
9628  1eb4 35ff5407      	mov	21511,#255
9629                     ; 2011 ADC2->CR2=0x08;
9631  1eb8 35085402      	mov	21506,#8
9632                     ; 2012 ADC2->CR1=0x40;
9634  1ebc 35405401      	mov	21505,#64
9635                     ; 2015 	ADC2->CSR=0x20+adc_ch+3;
9637  1ec0 b6c3          	ld	a,_adc_ch
9638  1ec2 ab23          	add	a,#35
9639  1ec4 c75400        	ld	21504,a
9640                     ; 2017 	ADC2->CR1|=1;
9642  1ec7 72105401      	bset	21505,#0
9643                     ; 2018 	ADC2->CR1|=1;
9645  1ecb 72105401      	bset	21505,#0
9646                     ; 2021 adc_plazma[1]=adc_ch;
9648  1ecf b6c3          	ld	a,_adc_ch
9649  1ed1 5f            	clrw	x
9650  1ed2 97            	ld	xl,a
9651  1ed3 bfb8          	ldw	_adc_plazma+2,x
9652                     ; 2022 }
9655  1ed5 81            	ret
9689                     ; 2031 @far @interrupt void TIM4_UPD_Interrupt (void) 
9689                     ; 2032 {
9691                     	switch	.text
9692  1ed6               f_TIM4_UPD_Interrupt:
9696                     ; 2033 TIM4->SR1&=~TIM4_SR1_UIF;
9698  1ed6 72115342      	bres	21314,#0
9699                     ; 2035 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9701  1eda 3c08          	inc	_pwm_vent_cnt
9702  1edc b608          	ld	a,_pwm_vent_cnt
9703  1ede a10a          	cp	a,#10
9704  1ee0 2502          	jrult	L3214
9707  1ee2 3f08          	clr	_pwm_vent_cnt
9708  1ee4               L3214:
9709                     ; 2036 GPIOB->ODR|=(1<<3);
9711  1ee4 72165005      	bset	20485,#3
9712                     ; 2037 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9714  1ee8 b608          	ld	a,_pwm_vent_cnt
9715  1eea a105          	cp	a,#5
9716  1eec 2504          	jrult	L5214
9719  1eee 72175005      	bres	20485,#3
9720  1ef2               L5214:
9721                     ; 2042 if(++t0_cnt0>=100)
9723  1ef2 9c            	rvf
9724  1ef3 be01          	ldw	x,_t0_cnt0
9725  1ef5 1c0001        	addw	x,#1
9726  1ef8 bf01          	ldw	_t0_cnt0,x
9727  1efa a30064        	cpw	x,#100
9728  1efd 2f3f          	jrslt	L7214
9729                     ; 2044 	t0_cnt0=0;
9731  1eff 5f            	clrw	x
9732  1f00 bf01          	ldw	_t0_cnt0,x
9733                     ; 2045 	b100Hz=1;
9735  1f02 72100008      	bset	_b100Hz
9736                     ; 2047 	if(++t0_cnt1>=10)
9738  1f06 3c03          	inc	_t0_cnt1
9739  1f08 b603          	ld	a,_t0_cnt1
9740  1f0a a10a          	cp	a,#10
9741  1f0c 2506          	jrult	L1314
9742                     ; 2049 		t0_cnt1=0;
9744  1f0e 3f03          	clr	_t0_cnt1
9745                     ; 2050 		b10Hz=1;
9747  1f10 72100007      	bset	_b10Hz
9748  1f14               L1314:
9749                     ; 2053 	if(++t0_cnt2>=20)
9751  1f14 3c04          	inc	_t0_cnt2
9752  1f16 b604          	ld	a,_t0_cnt2
9753  1f18 a114          	cp	a,#20
9754  1f1a 2506          	jrult	L3314
9755                     ; 2055 		t0_cnt2=0;
9757  1f1c 3f04          	clr	_t0_cnt2
9758                     ; 2056 		b5Hz=1;
9760  1f1e 72100006      	bset	_b5Hz
9761  1f22               L3314:
9762                     ; 2060 	if(++t0_cnt4>=50)
9764  1f22 3c06          	inc	_t0_cnt4
9765  1f24 b606          	ld	a,_t0_cnt4
9766  1f26 a132          	cp	a,#50
9767  1f28 2506          	jrult	L5314
9768                     ; 2062 		t0_cnt4=0;
9770  1f2a 3f06          	clr	_t0_cnt4
9771                     ; 2063 		b2Hz=1;
9773  1f2c 72100005      	bset	_b2Hz
9774  1f30               L5314:
9775                     ; 2066 	if(++t0_cnt3>=100)
9777  1f30 3c05          	inc	_t0_cnt3
9778  1f32 b605          	ld	a,_t0_cnt3
9779  1f34 a164          	cp	a,#100
9780  1f36 2506          	jrult	L7214
9781                     ; 2068 		t0_cnt3=0;
9783  1f38 3f05          	clr	_t0_cnt3
9784                     ; 2069 		b1Hz=1;
9786  1f3a 72100004      	bset	_b1Hz
9787  1f3e               L7214:
9788                     ; 2075 }
9791  1f3e 80            	iret
9816                     ; 2078 @far @interrupt void CAN_RX_Interrupt (void) 
9816                     ; 2079 {
9817                     	switch	.text
9818  1f3f               f_CAN_RX_Interrupt:
9822                     ; 2081 CAN->PSR= 7;									// page 7 - read messsage
9824  1f3f 35075427      	mov	21543,#7
9825                     ; 2083 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9827  1f43 ae000e        	ldw	x,#14
9828  1f46               L462:
9829  1f46 d65427        	ld	a,(21543,x)
9830  1f49 e7c3          	ld	(_mess-1,x),a
9831  1f4b 5a            	decw	x
9832  1f4c 26f8          	jrne	L462
9833                     ; 2094 bCAN_RX=1;
9835  1f4e 3501000a      	mov	_bCAN_RX,#1
9836                     ; 2095 CAN->RFR|=(1<<5);
9838  1f52 721a5424      	bset	21540,#5
9839                     ; 2097 }
9842  1f56 80            	iret
9865                     ; 2100 @far @interrupt void CAN_TX_Interrupt (void) 
9865                     ; 2101 {
9866                     	switch	.text
9867  1f57               f_CAN_TX_Interrupt:
9871                     ; 2102 if((CAN->TSR)&(1<<0))
9873  1f57 c65422        	ld	a,21538
9874  1f5a a501          	bcp	a,#1
9875  1f5c 2708          	jreq	L1614
9876                     ; 2104 	bTX_FREE=1;	
9878  1f5e 35010009      	mov	_bTX_FREE,#1
9879                     ; 2106 	CAN->TSR|=(1<<0);
9881  1f62 72105422      	bset	21538,#0
9882  1f66               L1614:
9883                     ; 2108 }
9886  1f66 80            	iret
9944                     ; 2111 @far @interrupt void ADC2_EOC_Interrupt (void) {
9945                     	switch	.text
9946  1f67               f_ADC2_EOC_Interrupt:
9948       00000009      OFST:	set	9
9949  1f67 be00          	ldw	x,c_x
9950  1f69 89            	pushw	x
9951  1f6a be00          	ldw	x,c_y
9952  1f6c 89            	pushw	x
9953  1f6d be02          	ldw	x,c_lreg+2
9954  1f6f 89            	pushw	x
9955  1f70 be00          	ldw	x,c_lreg
9956  1f72 89            	pushw	x
9957  1f73 5209          	subw	sp,#9
9960                     ; 2116 adc_plazma[2]++;
9962  1f75 beba          	ldw	x,_adc_plazma+4
9963  1f77 1c0001        	addw	x,#1
9964  1f7a bfba          	ldw	_adc_plazma+4,x
9965                     ; 2123 ADC2->CSR&=~(1<<7);
9967  1f7c 721f5400      	bres	21504,#7
9968                     ; 2125 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9970  1f80 c65405        	ld	a,21509
9971  1f83 b703          	ld	c_lreg+3,a
9972  1f85 3f02          	clr	c_lreg+2
9973  1f87 3f01          	clr	c_lreg+1
9974  1f89 3f00          	clr	c_lreg
9975  1f8b 96            	ldw	x,sp
9976  1f8c 1c0001        	addw	x,#OFST-8
9977  1f8f cd0000        	call	c_rtol
9979  1f92 c65404        	ld	a,21508
9980  1f95 5f            	clrw	x
9981  1f96 97            	ld	xl,a
9982  1f97 90ae0100      	ldw	y,#256
9983  1f9b cd0000        	call	c_umul
9985  1f9e 96            	ldw	x,sp
9986  1f9f 1c0001        	addw	x,#OFST-8
9987  1fa2 cd0000        	call	c_ladd
9989  1fa5 96            	ldw	x,sp
9990  1fa6 1c0006        	addw	x,#OFST-3
9991  1fa9 cd0000        	call	c_rtol
9993                     ; 2130 if(adr_drv_stat==1)
9995  1fac b608          	ld	a,_adr_drv_stat
9996  1fae a101          	cp	a,#1
9997  1fb0 260b          	jrne	L1124
9998                     ; 2132 	adr_drv_stat=2;
10000  1fb2 35020008      	mov	_adr_drv_stat,#2
10001                     ; 2133 	adc_buff_[0]=temp_adc;
10003  1fb6 1e08          	ldw	x,(OFST-1,sp)
10004  1fb8 cf0009        	ldw	_adc_buff_,x
10006  1fbb 2020          	jra	L3124
10007  1fbd               L1124:
10008                     ; 2136 else if(adr_drv_stat==3)
10010  1fbd b608          	ld	a,_adr_drv_stat
10011  1fbf a103          	cp	a,#3
10012  1fc1 260b          	jrne	L5124
10013                     ; 2138 	adr_drv_stat=4;
10015  1fc3 35040008      	mov	_adr_drv_stat,#4
10016                     ; 2139 	adc_buff_[1]=temp_adc;
10018  1fc7 1e08          	ldw	x,(OFST-1,sp)
10019  1fc9 cf000b        	ldw	_adc_buff_+2,x
10021  1fcc 200f          	jra	L3124
10022  1fce               L5124:
10023                     ; 2142 else if(adr_drv_stat==5)
10025  1fce b608          	ld	a,_adr_drv_stat
10026  1fd0 a105          	cp	a,#5
10027  1fd2 2609          	jrne	L3124
10028                     ; 2144 	adr_drv_stat=6;
10030  1fd4 35060008      	mov	_adr_drv_stat,#6
10031                     ; 2145 	adc_buff_[9]=temp_adc;
10033  1fd8 1e08          	ldw	x,(OFST-1,sp)
10034  1fda cf001b        	ldw	_adc_buff_+18,x
10035  1fdd               L3124:
10036                     ; 2148 adc_buff[adc_ch][adc_cnt]=temp_adc;
10038  1fdd b6c2          	ld	a,_adc_cnt
10039  1fdf 5f            	clrw	x
10040  1fe0 97            	ld	xl,a
10041  1fe1 58            	sllw	x
10042  1fe2 1f03          	ldw	(OFST-6,sp),x
10043  1fe4 b6c3          	ld	a,_adc_ch
10044  1fe6 97            	ld	xl,a
10045  1fe7 a620          	ld	a,#32
10046  1fe9 42            	mul	x,a
10047  1fea 72fb03        	addw	x,(OFST-6,sp)
10048  1fed 1608          	ldw	y,(OFST-1,sp)
10049  1fef df001d        	ldw	(_adc_buff,x),y
10050                     ; 2154 adc_ch++;
10052  1ff2 3cc3          	inc	_adc_ch
10053                     ; 2155 if(adc_ch>=5)
10055  1ff4 b6c3          	ld	a,_adc_ch
10056  1ff6 a105          	cp	a,#5
10057  1ff8 250c          	jrult	L3224
10058                     ; 2158 	adc_ch=0;
10060  1ffa 3fc3          	clr	_adc_ch
10061                     ; 2159 	adc_cnt++;
10063  1ffc 3cc2          	inc	_adc_cnt
10064                     ; 2160 	if(adc_cnt>=16)
10066  1ffe b6c2          	ld	a,_adc_cnt
10067  2000 a110          	cp	a,#16
10068  2002 2502          	jrult	L3224
10069                     ; 2162 		adc_cnt=0;
10071  2004 3fc2          	clr	_adc_cnt
10072  2006               L3224:
10073                     ; 2166 if((adc_cnt&0x03)==0)
10075  2006 b6c2          	ld	a,_adc_cnt
10076  2008 a503          	bcp	a,#3
10077  200a 264b          	jrne	L7224
10078                     ; 2170 	tempSS=0;
10080  200c ae0000        	ldw	x,#0
10081  200f 1f08          	ldw	(OFST-1,sp),x
10082  2011 ae0000        	ldw	x,#0
10083  2014 1f06          	ldw	(OFST-3,sp),x
10084                     ; 2171 	for(i=0;i<16;i++)
10086  2016 0f05          	clr	(OFST-4,sp)
10087  2018               L1324:
10088                     ; 2173 		tempSS+=(signed long)adc_buff[adc_ch][i];
10090  2018 7b05          	ld	a,(OFST-4,sp)
10091  201a 5f            	clrw	x
10092  201b 97            	ld	xl,a
10093  201c 58            	sllw	x
10094  201d 1f03          	ldw	(OFST-6,sp),x
10095  201f b6c3          	ld	a,_adc_ch
10096  2021 97            	ld	xl,a
10097  2022 a620          	ld	a,#32
10098  2024 42            	mul	x,a
10099  2025 72fb03        	addw	x,(OFST-6,sp)
10100  2028 de001d        	ldw	x,(_adc_buff,x)
10101  202b cd0000        	call	c_itolx
10103  202e 96            	ldw	x,sp
10104  202f 1c0006        	addw	x,#OFST-3
10105  2032 cd0000        	call	c_lgadd
10107                     ; 2171 	for(i=0;i<16;i++)
10109  2035 0c05          	inc	(OFST-4,sp)
10112  2037 7b05          	ld	a,(OFST-4,sp)
10113  2039 a110          	cp	a,#16
10114  203b 25db          	jrult	L1324
10115                     ; 2175 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
10117  203d 96            	ldw	x,sp
10118  203e 1c0006        	addw	x,#OFST-3
10119  2041 cd0000        	call	c_ltor
10121  2044 a604          	ld	a,#4
10122  2046 cd0000        	call	c_lrsh
10124  2049 be02          	ldw	x,c_lreg+2
10125  204b b6c3          	ld	a,_adc_ch
10126  204d 905f          	clrw	y
10127  204f 9097          	ld	yl,a
10128  2051 9058          	sllw	y
10129  2053 90df0009      	ldw	(_adc_buff_,y),x
10130  2057               L7224:
10131                     ; 2186 adc_plazma_short++;
10133  2057 bec0          	ldw	x,_adc_plazma_short
10134  2059 1c0001        	addw	x,#1
10135  205c bfc0          	ldw	_adc_plazma_short,x
10136                     ; 2201 }
10139  205e 5b09          	addw	sp,#9
10140  2060 85            	popw	x
10141  2061 bf00          	ldw	c_lreg,x
10142  2063 85            	popw	x
10143  2064 bf02          	ldw	c_lreg+2,x
10144  2066 85            	popw	x
10145  2067 bf00          	ldw	c_y,x
10146  2069 85            	popw	x
10147  206a bf00          	ldw	c_x,x
10148  206c 80            	iret
10212                     ; 2209 main()
10212                     ; 2210 {
10214                     	switch	.text
10215  206d               _main:
10219                     ; 2212 CLK->ECKR|=1;
10221  206d 721050c1      	bset	20673,#0
10223  2071               L1524:
10224                     ; 2213 while((CLK->ECKR & 2) == 0);
10226  2071 c650c1        	ld	a,20673
10227  2074 a502          	bcp	a,#2
10228  2076 27f9          	jreq	L1524
10229                     ; 2214 CLK->SWCR|=2;
10231  2078 721250c5      	bset	20677,#1
10232                     ; 2215 CLK->SWR=0xB4;
10234  207c 35b450c4      	mov	20676,#180
10235                     ; 2217 delay_ms(200);
10237  2080 ae00c8        	ldw	x,#200
10238  2083 cd011d        	call	_delay_ms
10240                     ; 2218 FLASH_DUKR=0xae;
10242  2086 35ae5064      	mov	_FLASH_DUKR,#174
10243                     ; 2219 FLASH_DUKR=0x56;
10245  208a 35565064      	mov	_FLASH_DUKR,#86
10246                     ; 2220 enableInterrupts();
10249  208e 9a            rim
10251                     ; 2223 adr_drv_v3();
10254  208f cd126c        	call	_adr_drv_v3
10256                     ; 2227 t4_init();
10258  2092 cd1e2f        	call	_t4_init
10260                     ; 2229 		GPIOG->DDR|=(1<<0);
10262  2095 72105020      	bset	20512,#0
10263                     ; 2230 		GPIOG->CR1|=(1<<0);
10265  2099 72105021      	bset	20513,#0
10266                     ; 2231 		GPIOG->CR2&=~(1<<0);	
10268  209d 72115022      	bres	20514,#0
10269                     ; 2234 		GPIOG->DDR&=~(1<<1);
10271  20a1 72135020      	bres	20512,#1
10272                     ; 2235 		GPIOG->CR1|=(1<<1);
10274  20a5 72125021      	bset	20513,#1
10275                     ; 2236 		GPIOG->CR2&=~(1<<1);
10277  20a9 72135022      	bres	20514,#1
10278                     ; 2238 init_CAN();
10280  20ad cd15af        	call	_init_CAN
10282                     ; 2243 GPIOC->DDR|=(1<<1);
10284  20b0 7212500c      	bset	20492,#1
10285                     ; 2244 GPIOC->CR1|=(1<<1);
10287  20b4 7212500d      	bset	20493,#1
10288                     ; 2245 GPIOC->CR2|=(1<<1);
10290  20b8 7212500e      	bset	20494,#1
10291                     ; 2247 GPIOC->DDR|=(1<<2);
10293  20bc 7214500c      	bset	20492,#2
10294                     ; 2248 GPIOC->CR1|=(1<<2);
10296  20c0 7214500d      	bset	20493,#2
10297                     ; 2249 GPIOC->CR2|=(1<<2);
10299  20c4 7214500e      	bset	20494,#2
10300                     ; 2256 t1_init();
10302  20c8 cd1e40        	call	_t1_init
10304                     ; 2258 GPIOA->DDR|=(1<<5);
10306  20cb 721a5002      	bset	20482,#5
10307                     ; 2259 GPIOA->CR1|=(1<<5);
10309  20cf 721a5003      	bset	20483,#5
10310                     ; 2260 GPIOA->CR2&=~(1<<5);
10312  20d3 721b5004      	bres	20484,#5
10313                     ; 2266 GPIOB->DDR&=~(1<<3);
10315  20d7 72175007      	bres	20487,#3
10316                     ; 2267 GPIOB->CR1&=~(1<<3);
10318  20db 72175008      	bres	20488,#3
10319                     ; 2268 GPIOB->CR2&=~(1<<3);
10321  20df 72175009      	bres	20489,#3
10322                     ; 2270 GPIOC->DDR|=(1<<3);
10324  20e3 7216500c      	bset	20492,#3
10325                     ; 2271 GPIOC->CR1|=(1<<3);
10327  20e7 7216500d      	bset	20493,#3
10328                     ; 2272 GPIOC->CR2|=(1<<3);
10330  20eb 7216500e      	bset	20494,#3
10331                     ; 2275 if(bps_class==bpsIPS) 
10333  20ef b604          	ld	a,_bps_class
10334  20f1 a101          	cp	a,#1
10335  20f3 260a          	jrne	L7524
10336                     ; 2277 	pwm_u=ee_U_AVT;
10338  20f5 ce000c        	ldw	x,_ee_U_AVT
10339  20f8 bf0e          	ldw	_pwm_u,x
10340                     ; 2278 	volum_u_main_=ee_U_AVT;
10342  20fa ce000c        	ldw	x,_ee_U_AVT
10343  20fd bf1f          	ldw	_volum_u_main_,x
10344  20ff               L7524:
10345                     ; 2285 	if(bCAN_RX)
10347  20ff 3d0a          	tnz	_bCAN_RX
10348  2101 2705          	jreq	L3624
10349                     ; 2287 		bCAN_RX=0;
10351  2103 3f0a          	clr	_bCAN_RX
10352                     ; 2288 		can_in_an();	
10354  2105 cd17ba        	call	_can_in_an
10356  2108               L3624:
10357                     ; 2290 	if(b100Hz)
10359                     	btst	_b100Hz
10360  210d 240a          	jruge	L5624
10361                     ; 2292 		b100Hz=0;
10363  210f 72110008      	bres	_b100Hz
10364                     ; 2301 		adc2_init();
10366  2113 cd1e7d        	call	_adc2_init
10368                     ; 2302 		can_tx_hndl();
10370  2116 cd16a2        	call	_can_tx_hndl
10372  2119               L5624:
10373                     ; 2305 	if(b10Hz)
10375                     	btst	_b10Hz
10376  211e 2419          	jruge	L7624
10377                     ; 2307 		b10Hz=0;
10379  2120 72110007      	bres	_b10Hz
10380                     ; 2309 		matemat();
10382  2124 cd0dd3        	call	_matemat
10384                     ; 2310 		led_drv(); 
10386  2127 cd07e2        	call	_led_drv
10388                     ; 2311 	  link_drv();
10390  212a cd08d0        	call	_link_drv
10392                     ; 2312 	  pwr_hndl();		//вычисление воздействий на силу
10394  212d cd0bd6        	call	_pwr_hndl
10396                     ; 2313 	  JP_drv();
10398  2130 cd0845        	call	_JP_drv
10400                     ; 2314 	  flags_drv();
10402  2133 cd1221        	call	_flags_drv
10404                     ; 2315 		net_drv();
10406  2136 cd170c        	call	_net_drv
10408  2139               L7624:
10409                     ; 2318 	if(b5Hz)
10411                     	btst	_b5Hz
10412  213e 240d          	jruge	L1724
10413                     ; 2320 		b5Hz=0;
10415  2140 72110006      	bres	_b5Hz
10416                     ; 2322 		pwr_drv();		//воздействие на силу
10418  2144 cd0a8b        	call	_pwr_drv
10420                     ; 2323 		led_hndl();
10422  2147 cd015f        	call	_led_hndl
10424                     ; 2325 		vent_drv();
10426  214a cd0928        	call	_vent_drv
10428  214d               L1724:
10429                     ; 2328 	if(b2Hz)
10431                     	btst	_b2Hz
10432  2152 2404          	jruge	L3724
10433                     ; 2330 		b2Hz=0;
10435  2154 72110005      	bres	_b2Hz
10436  2158               L3724:
10437                     ; 2339 	if(b1Hz)
10439                     	btst	_b1Hz
10440  215d 24a0          	jruge	L7524
10441                     ; 2341 		b1Hz=0;
10443  215f 72110004      	bres	_b1Hz
10444                     ; 2343 		temper_drv();			//вычисление аварий температуры
10446  2163 cd0f51        	call	_temper_drv
10448                     ; 2344 		u_drv();
10450  2166 cd1028        	call	_u_drv
10452                     ; 2345           x_drv();
10454  2169 cd1108        	call	_x_drv
10456                     ; 2346           if(main_cnt<1000)main_cnt++;
10458  216c 9c            	rvf
10459  216d be51          	ldw	x,_main_cnt
10460  216f a303e8        	cpw	x,#1000
10461  2172 2e07          	jrsge	L7724
10464  2174 be51          	ldw	x,_main_cnt
10465  2176 1c0001        	addw	x,#1
10466  2179 bf51          	ldw	_main_cnt,x
10467  217b               L7724:
10468                     ; 2347   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10470  217b b663          	ld	a,_link
10471  217d a1aa          	cp	a,#170
10472  217f 2706          	jreq	L3034
10474  2181 b64a          	ld	a,_jp_mode
10475  2183 a103          	cp	a,#3
10476  2185 2603          	jrne	L1034
10477  2187               L3034:
10480  2187 cd1182        	call	_apv_hndl
10482  218a               L1034:
10483                     ; 2350   		can_error_cnt++;
10485  218a 3c71          	inc	_can_error_cnt
10486                     ; 2351   		if(can_error_cnt>=10)
10488  218c b671          	ld	a,_can_error_cnt
10489  218e a10a          	cp	a,#10
10490  2190 2505          	jrult	L5034
10491                     ; 2353   			can_error_cnt=0;
10493  2192 3f71          	clr	_can_error_cnt
10494                     ; 2354 			init_CAN();
10496  2194 cd15af        	call	_init_CAN
10498  2197               L5034:
10499                     ; 2358 		volum_u_main_drv();
10501  2197 cd145c        	call	_volum_u_main_drv
10503                     ; 2360 		pwm_stat++;
10505  219a 3c07          	inc	_pwm_stat
10506                     ; 2361 		if(pwm_stat>=10)pwm_stat=0;
10508  219c b607          	ld	a,_pwm_stat
10509  219e a10a          	cp	a,#10
10510  21a0 2502          	jrult	L7034
10513  21a2 3f07          	clr	_pwm_stat
10514  21a4               L7034:
10515                     ; 2362 adc_plazma_short++;
10517  21a4 bec0          	ldw	x,_adc_plazma_short
10518  21a6 1c0001        	addw	x,#1
10519  21a9 bfc0          	ldw	_adc_plazma_short,x
10520                     ; 2364 		vent_resurs_hndl();
10522  21ab cd0000        	call	_vent_resurs_hndl
10524  21ae acff20ff      	jpf	L7524
11594                     	xdef	_main
11595                     	xdef	f_ADC2_EOC_Interrupt
11596                     	xdef	f_CAN_TX_Interrupt
11597                     	xdef	f_CAN_RX_Interrupt
11598                     	xdef	f_TIM4_UPD_Interrupt
11599                     	xdef	_adc2_init
11600                     	xdef	_t1_init
11601                     	xdef	_t4_init
11602                     	xdef	_can_in_an
11603                     	xdef	_net_drv
11604                     	xdef	_can_tx_hndl
11605                     	xdef	_can_transmit
11606                     	xdef	_init_CAN
11607                     	xdef	_volum_u_main_drv
11608                     	xdef	_adr_drv_v3
11609                     	xdef	_adr_drv_v4
11610                     	xdef	_flags_drv
11611                     	xdef	_apv_hndl
11612                     	xdef	_apv_stop
11613                     	xdef	_apv_start
11614                     	xdef	_x_drv
11615                     	xdef	_u_drv
11616                     	xdef	_temper_drv
11617                     	xdef	_matemat
11618                     	xdef	_pwr_hndl
11619                     	xdef	_pwr_drv
11620                     	xdef	_vent_drv
11621                     	xdef	_link_drv
11622                     	xdef	_JP_drv
11623                     	xdef	_led_drv
11624                     	xdef	_led_hndl
11625                     	xdef	_delay_ms
11626                     	xdef	_granee
11627                     	xdef	_gran
11628                     	xdef	_vent_resurs_hndl
11629                     	switch	.ubsct
11630  0001               _vent_resurs_tx_cnt:
11631  0001 00            	ds.b	1
11632                     	xdef	_vent_resurs_tx_cnt
11633                     	switch	.bss
11634  0000               _vent_resurs_buff:
11635  0000 00000000      	ds.b	4
11636                     	xdef	_vent_resurs_buff
11637                     	switch	.ubsct
11638  0002               _vent_resurs_sec_cnt:
11639  0002 0000          	ds.b	2
11640                     	xdef	_vent_resurs_sec_cnt
11641                     .eeprom:	section	.data
11642  0000               _vent_resurs:
11643  0000 0000          	ds.b	2
11644                     	xdef	_vent_resurs
11645  0002               _ee_IMAXVENT:
11646  0002 0000          	ds.b	2
11647                     	xdef	_ee_IMAXVENT
11648                     	switch	.ubsct
11649  0004               _bps_class:
11650  0004 00            	ds.b	1
11651                     	xdef	_bps_class
11652  0005               _vent_pwm:
11653  0005 0000          	ds.b	2
11654                     	xdef	_vent_pwm
11655  0007               _pwm_stat:
11656  0007 00            	ds.b	1
11657                     	xdef	_pwm_stat
11658  0008               _pwm_vent_cnt:
11659  0008 00            	ds.b	1
11660                     	xdef	_pwm_vent_cnt
11661                     	switch	.eeprom
11662  0004               _ee_DEVICE:
11663  0004 0000          	ds.b	2
11664                     	xdef	_ee_DEVICE
11665  0006               _ee_AVT_MODE:
11666  0006 0000          	ds.b	2
11667                     	xdef	_ee_AVT_MODE
11668                     	switch	.ubsct
11669  0009               _i_main_bps_cnt:
11670  0009 000000000000  	ds.b	6
11671                     	xdef	_i_main_bps_cnt
11672  000f               _i_main_sigma:
11673  000f 0000          	ds.b	2
11674                     	xdef	_i_main_sigma
11675  0011               _i_main_num_of_bps:
11676  0011 00            	ds.b	1
11677                     	xdef	_i_main_num_of_bps
11678  0012               _i_main_avg:
11679  0012 0000          	ds.b	2
11680                     	xdef	_i_main_avg
11681  0014               _i_main_flag:
11682  0014 000000000000  	ds.b	6
11683                     	xdef	_i_main_flag
11684  001a               _i_main:
11685  001a 000000000000  	ds.b	12
11686                     	xdef	_i_main
11687  0026               _x:
11688  0026 000000000000  	ds.b	12
11689                     	xdef	_x
11690                     	xdef	_volum_u_main_
11691                     	switch	.eeprom
11692  0008               _UU_AVT:
11693  0008 0000          	ds.b	2
11694                     	xdef	_UU_AVT
11695                     	switch	.ubsct
11696  0032               _cnt_net_drv:
11697  0032 00            	ds.b	1
11698                     	xdef	_cnt_net_drv
11699                     	switch	.bit
11700  0001               _bMAIN:
11701  0001 00            	ds.b	1
11702                     	xdef	_bMAIN
11703                     	switch	.ubsct
11704  0033               _plazma_int:
11705  0033 000000000000  	ds.b	6
11706                     	xdef	_plazma_int
11707                     	xdef	_rotor_int
11708  0039               _led_green_buff:
11709  0039 00000000      	ds.b	4
11710                     	xdef	_led_green_buff
11711  003d               _led_red_buff:
11712  003d 00000000      	ds.b	4
11713                     	xdef	_led_red_buff
11714                     	xdef	_led_drv_cnt
11715                     	xdef	_led_green
11716                     	xdef	_led_red
11717  0041               _res_fl_cnt:
11718  0041 00            	ds.b	1
11719                     	xdef	_res_fl_cnt
11720                     	xdef	_bRES_
11721                     	xdef	_bRES
11722                     	switch	.eeprom
11723  000a               _res_fl_:
11724  000a 00            	ds.b	1
11725                     	xdef	_res_fl_
11726  000b               _res_fl:
11727  000b 00            	ds.b	1
11728                     	xdef	_res_fl
11729                     	switch	.ubsct
11730  0042               _cnt_apv_off:
11731  0042 00            	ds.b	1
11732                     	xdef	_cnt_apv_off
11733                     	switch	.bit
11734  0002               _bAPV:
11735  0002 00            	ds.b	1
11736                     	xdef	_bAPV
11737                     	switch	.ubsct
11738  0043               _apv_cnt_:
11739  0043 0000          	ds.b	2
11740                     	xdef	_apv_cnt_
11741  0045               _apv_cnt:
11742  0045 000000        	ds.b	3
11743                     	xdef	_apv_cnt
11744                     	xdef	_bBL_IPS
11745                     	switch	.bit
11746  0003               _bBL:
11747  0003 00            	ds.b	1
11748                     	xdef	_bBL
11749                     	switch	.ubsct
11750  0048               _cnt_JP1:
11751  0048 00            	ds.b	1
11752                     	xdef	_cnt_JP1
11753  0049               _cnt_JP0:
11754  0049 00            	ds.b	1
11755                     	xdef	_cnt_JP0
11756  004a               _jp_mode:
11757  004a 00            	ds.b	1
11758                     	xdef	_jp_mode
11759                     	xdef	_pwm_i
11760                     	xdef	_pwm_u
11761  004b               _tmax_cnt:
11762  004b 0000          	ds.b	2
11763                     	xdef	_tmax_cnt
11764  004d               _tsign_cnt:
11765  004d 0000          	ds.b	2
11766                     	xdef	_tsign_cnt
11767                     	switch	.eeprom
11768  000c               _ee_U_AVT:
11769  000c 0000          	ds.b	2
11770                     	xdef	_ee_U_AVT
11771  000e               _ee_tsign:
11772  000e 0000          	ds.b	2
11773                     	xdef	_ee_tsign
11774  0010               _ee_tmax:
11775  0010 0000          	ds.b	2
11776                     	xdef	_ee_tmax
11777  0012               _ee_dU:
11778  0012 0000          	ds.b	2
11779                     	xdef	_ee_dU
11780  0014               _ee_Umax:
11781  0014 0000          	ds.b	2
11782                     	xdef	_ee_Umax
11783  0016               _ee_TZAS:
11784  0016 0000          	ds.b	2
11785                     	xdef	_ee_TZAS
11786                     	switch	.ubsct
11787  004f               _main_cnt1:
11788  004f 0000          	ds.b	2
11789                     	xdef	_main_cnt1
11790  0051               _main_cnt:
11791  0051 0000          	ds.b	2
11792                     	xdef	_main_cnt
11793  0053               _off_bp_cnt:
11794  0053 00            	ds.b	1
11795                     	xdef	_off_bp_cnt
11796                     	xdef	_vol_i_temp_avar
11797  0054               _flags_tu_cnt_off:
11798  0054 00            	ds.b	1
11799                     	xdef	_flags_tu_cnt_off
11800  0055               _flags_tu_cnt_on:
11801  0055 00            	ds.b	1
11802                     	xdef	_flags_tu_cnt_on
11803  0056               _vol_i_temp:
11804  0056 0000          	ds.b	2
11805                     	xdef	_vol_i_temp
11806  0058               _vol_u_temp:
11807  0058 0000          	ds.b	2
11808                     	xdef	_vol_u_temp
11809                     	switch	.eeprom
11810  0018               __x_ee_:
11811  0018 0000          	ds.b	2
11812                     	xdef	__x_ee_
11813                     	switch	.ubsct
11814  005a               __x_cnt:
11815  005a 0000          	ds.b	2
11816                     	xdef	__x_cnt
11817  005c               __x__:
11818  005c 0000          	ds.b	2
11819                     	xdef	__x__
11820  005e               __x_:
11821  005e 0000          	ds.b	2
11822                     	xdef	__x_
11823  0060               _flags_tu:
11824  0060 00            	ds.b	1
11825                     	xdef	_flags_tu
11826                     	xdef	_flags
11827  0061               _link_cnt:
11828  0061 0000          	ds.b	2
11829                     	xdef	_link_cnt
11830  0063               _link:
11831  0063 00            	ds.b	1
11832                     	xdef	_link
11833  0064               _umin_cnt:
11834  0064 0000          	ds.b	2
11835                     	xdef	_umin_cnt
11836  0066               _umax_cnt:
11837  0066 0000          	ds.b	2
11838                     	xdef	_umax_cnt
11839                     	switch	.eeprom
11840  001a               _ee_K:
11841  001a 000000000000  	ds.b	16
11842                     	xdef	_ee_K
11843                     	switch	.ubsct
11844  0068               _T:
11845  0068 00            	ds.b	1
11846                     	xdef	_T
11847  0069               _Udb:
11848  0069 0000          	ds.b	2
11849                     	xdef	_Udb
11850  006b               _Ui:
11851  006b 0000          	ds.b	2
11852                     	xdef	_Ui
11853  006d               _Un:
11854  006d 0000          	ds.b	2
11855                     	xdef	_Un
11856  006f               _I:
11857  006f 0000          	ds.b	2
11858                     	xdef	_I
11859  0071               _can_error_cnt:
11860  0071 00            	ds.b	1
11861                     	xdef	_can_error_cnt
11862                     	xdef	_bCAN_RX
11863  0072               _tx_busy_cnt:
11864  0072 00            	ds.b	1
11865                     	xdef	_tx_busy_cnt
11866                     	xdef	_bTX_FREE
11867  0073               _can_buff_rd_ptr:
11868  0073 00            	ds.b	1
11869                     	xdef	_can_buff_rd_ptr
11870  0074               _can_buff_wr_ptr:
11871  0074 00            	ds.b	1
11872                     	xdef	_can_buff_wr_ptr
11873  0075               _can_out_buff:
11874  0075 000000000000  	ds.b	64
11875                     	xdef	_can_out_buff
11876                     	switch	.bss
11877  0004               _adress_error:
11878  0004 00            	ds.b	1
11879                     	xdef	_adress_error
11880  0005               _adress:
11881  0005 00            	ds.b	1
11882                     	xdef	_adress
11883  0006               _adr:
11884  0006 000000        	ds.b	3
11885                     	xdef	_adr
11886                     	xdef	_adr_drv_stat
11887                     	xdef	_led_ind
11888                     	switch	.ubsct
11889  00b5               _led_ind_cnt:
11890  00b5 00            	ds.b	1
11891                     	xdef	_led_ind_cnt
11892  00b6               _adc_plazma:
11893  00b6 000000000000  	ds.b	10
11894                     	xdef	_adc_plazma
11895  00c0               _adc_plazma_short:
11896  00c0 0000          	ds.b	2
11897                     	xdef	_adc_plazma_short
11898  00c2               _adc_cnt:
11899  00c2 00            	ds.b	1
11900                     	xdef	_adc_cnt
11901  00c3               _adc_ch:
11902  00c3 00            	ds.b	1
11903                     	xdef	_adc_ch
11904                     	switch	.bss
11905  0009               _adc_buff_:
11906  0009 000000000000  	ds.b	20
11907                     	xdef	_adc_buff_
11908  001d               _adc_buff:
11909  001d 000000000000  	ds.b	320
11910                     	xdef	_adc_buff
11911                     	switch	.ubsct
11912  00c4               _mess:
11913  00c4 000000000000  	ds.b	14
11914                     	xdef	_mess
11915                     	switch	.bit
11916  0004               _b1Hz:
11917  0004 00            	ds.b	1
11918                     	xdef	_b1Hz
11919  0005               _b2Hz:
11920  0005 00            	ds.b	1
11921                     	xdef	_b2Hz
11922  0006               _b5Hz:
11923  0006 00            	ds.b	1
11924                     	xdef	_b5Hz
11925  0007               _b10Hz:
11926  0007 00            	ds.b	1
11927                     	xdef	_b10Hz
11928  0008               _b100Hz:
11929  0008 00            	ds.b	1
11930                     	xdef	_b100Hz
11931                     	xdef	_t0_cnt4
11932                     	xdef	_t0_cnt3
11933                     	xdef	_t0_cnt2
11934                     	xdef	_t0_cnt1
11935                     	xdef	_t0_cnt0
11936                     	xdef	_bVENT_BLOCK
11937                     	xref.b	c_lreg
11938                     	xref.b	c_x
11939                     	xref.b	c_y
11959                     	xref	c_lrsh
11960                     	xref	c_lgadd
11961                     	xref	c_ladd
11962                     	xref	c_umul
11963                     	xref	c_lgmul
11964                     	xref	c_lgsub
11965                     	xref	c_lsbc
11966                     	xref	c_idiv
11967                     	xref	c_ldiv
11968                     	xref	c_itolx
11969                     	xref	c_eewrc
11970                     	xref	c_imul
11971                     	xref	c_ltor
11972                     	xref	c_lgadc
11973                     	xref	c_rtol
11974                     	xref	c_vmul
11975                     	xref	c_eewrw
11976                     	xref	c_lcmp
11977                     	xref	c_uitolx
11978                     	end
