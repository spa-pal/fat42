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
4827                     ; 775 pwm_u=0;
4829  0b74 5f            	clrw	x
4830  0b75 bf0e          	ldw	_pwm_u,x
4831                     ; 776 pwm_i=0;
4833  0b77 5f            	clrw	x
4834  0b78 bf10          	ldw	_pwm_i,x
4835                     ; 777 vent_pwm=0;
4837  0b7a 5f            	clrw	x
4838  0b7b bf05          	ldw	_vent_pwm,x
4839                     ; 779 TIM1->CCR2H= (char)(pwm_u/256);	
4841  0b7d be0e          	ldw	x,_pwm_u
4842  0b7f 90ae0100      	ldw	y,#256
4843  0b83 cd0000        	call	c_idiv
4845  0b86 9f            	ld	a,xl
4846  0b87 c75267        	ld	21095,a
4847                     ; 780 TIM1->CCR2L= (char)pwm_u;
4849  0b8a 55000f5268    	mov	21096,_pwm_u+1
4850                     ; 782 TIM1->CCR1H= (char)(pwm_i/256);	
4852  0b8f 725f5265      	clr	21093
4853                     ; 783 TIM1->CCR1L= (char)pwm_i;
4855  0b93 725f5266      	clr	21094
4856                     ; 785 TIM1->CCR3H= (char)(vent_pwm/256);	
4858  0b97 be05          	ldw	x,_vent_pwm
4859  0b99 90ae0100      	ldw	y,#256
4860  0b9d cd0000        	call	c_idiv
4862  0ba0 9f            	ld	a,xl
4863  0ba1 c75269        	ld	21097,a
4864                     ; 786 TIM1->CCR3L= (char)vent_pwm;
4866  0ba4 550006526a    	mov	21098,_vent_pwm+1
4867                     ; 787 }
4870  0ba9 81            	ret
4909                     ; 792 void pwr_hndl(void)				
4909                     ; 793 {
4910                     	switch	.text
4911  0baa               _pwr_hndl:
4915                     ; 794 if(jp_mode==jp3)
4917  0baa b64a          	ld	a,_jp_mode
4918  0bac a103          	cp	a,#3
4919  0bae 2627          	jrne	L1242
4920                     ; 796 	if((flags&0b00001010)==0)
4922  0bb0 b60b          	ld	a,_flags
4923  0bb2 a50a          	bcp	a,#10
4924  0bb4 260d          	jrne	L3242
4925                     ; 798 		pwm_u=500;
4927  0bb6 ae01f4        	ldw	x,#500
4928  0bb9 bf0e          	ldw	_pwm_u,x
4929                     ; 800 		bBL=0;
4931  0bbb 72110003      	bres	_bBL
4933  0bbf acde0cde      	jpf	L1342
4934  0bc3               L3242:
4935                     ; 802 	else if(flags&0b00001010)
4937  0bc3 b60b          	ld	a,_flags
4938  0bc5 a50a          	bcp	a,#10
4939  0bc7 2603          	jrne	L46
4940  0bc9 cc0cde        	jp	L1342
4941  0bcc               L46:
4942                     ; 804 		pwm_u=0;
4944  0bcc 5f            	clrw	x
4945  0bcd bf0e          	ldw	_pwm_u,x
4946                     ; 806 		bBL=1;
4948  0bcf 72100003      	bset	_bBL
4949  0bd3 acde0cde      	jpf	L1342
4950  0bd7               L1242:
4951                     ; 810 else if(jp_mode==jp2)
4953  0bd7 b64a          	ld	a,_jp_mode
4954  0bd9 a102          	cp	a,#2
4955  0bdb 2610          	jrne	L3342
4956                     ; 812 	pwm_u=0;
4958  0bdd 5f            	clrw	x
4959  0bde bf0e          	ldw	_pwm_u,x
4960                     ; 813 	pwm_i=0x3ff;
4962  0be0 ae03ff        	ldw	x,#1023
4963  0be3 bf10          	ldw	_pwm_i,x
4964                     ; 814 	bBL=0;
4966  0be5 72110003      	bres	_bBL
4968  0be9 acde0cde      	jpf	L1342
4969  0bed               L3342:
4970                     ; 816 else if(jp_mode==jp1)
4972  0bed b64a          	ld	a,_jp_mode
4973  0bef a101          	cp	a,#1
4974  0bf1 2612          	jrne	L7342
4975                     ; 818 	pwm_u=0x3ff;
4977  0bf3 ae03ff        	ldw	x,#1023
4978  0bf6 bf0e          	ldw	_pwm_u,x
4979                     ; 819 	pwm_i=0x3ff;
4981  0bf8 ae03ff        	ldw	x,#1023
4982  0bfb bf10          	ldw	_pwm_i,x
4983                     ; 820 	bBL=0;
4985  0bfd 72110003      	bres	_bBL
4987  0c01 acde0cde      	jpf	L1342
4988  0c05               L7342:
4989                     ; 823 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4991                     	btst	_bMAIN
4992  0c0a 2417          	jruge	L3442
4994  0c0c b663          	ld	a,_link
4995  0c0e a155          	cp	a,#85
4996  0c10 2611          	jrne	L3442
4997                     ; 825 	pwm_u=volum_u_main_;
4999  0c12 be1f          	ldw	x,_volum_u_main_
5000  0c14 bf0e          	ldw	_pwm_u,x
5001                     ; 826 	pwm_i=0x3ff;
5003  0c16 ae03ff        	ldw	x,#1023
5004  0c19 bf10          	ldw	_pwm_i,x
5005                     ; 827 	bBL_IPS=0;
5007  0c1b 72110000      	bres	_bBL_IPS
5009  0c1f acde0cde      	jpf	L1342
5010  0c23               L3442:
5011                     ; 830 else if(link==OFF)
5013  0c23 b663          	ld	a,_link
5014  0c25 a1aa          	cp	a,#170
5015  0c27 2651          	jrne	L7442
5016                     ; 839  	if(ee_DEVICE)
5018  0c29 ce0004        	ldw	x,_ee_DEVICE
5019  0c2c 270e          	jreq	L1542
5020                     ; 841 		pwm_u=0x00;
5022  0c2e 5f            	clrw	x
5023  0c2f bf0e          	ldw	_pwm_u,x
5024                     ; 842 		pwm_i=0x00;
5026  0c31 5f            	clrw	x
5027  0c32 bf10          	ldw	_pwm_i,x
5028                     ; 843 		bBL=1;
5030  0c34 72100003      	bset	_bBL
5032  0c38 acde0cde      	jpf	L1342
5033  0c3c               L1542:
5034                     ; 847 		if((flags&0b00011010)==0)
5036  0c3c b60b          	ld	a,_flags
5037  0c3e a51a          	bcp	a,#26
5038  0c40 2622          	jrne	L5542
5039                     ; 849 			pwm_u=ee_U_AVT;
5041  0c42 ce000c        	ldw	x,_ee_U_AVT
5042  0c45 bf0e          	ldw	_pwm_u,x
5043                     ; 850 			gran(&pwm_u,0,1020);
5045  0c47 ae03fc        	ldw	x,#1020
5046  0c4a 89            	pushw	x
5047  0c4b 5f            	clrw	x
5048  0c4c 89            	pushw	x
5049  0c4d ae000e        	ldw	x,#_pwm_u
5050  0c50 cd00d1        	call	_gran
5052  0c53 5b04          	addw	sp,#4
5053                     ; 851 		    	pwm_i=0x3ff;
5055  0c55 ae03ff        	ldw	x,#1023
5056  0c58 bf10          	ldw	_pwm_i,x
5057                     ; 852 			bBL=0;
5059  0c5a 72110003      	bres	_bBL
5060                     ; 853 			bBL_IPS=0;
5062  0c5e 72110000      	bres	_bBL_IPS
5064  0c62 207a          	jra	L1342
5065  0c64               L5542:
5066                     ; 855 		else if(flags&0b00011010)
5068  0c64 b60b          	ld	a,_flags
5069  0c66 a51a          	bcp	a,#26
5070  0c68 2774          	jreq	L1342
5071                     ; 857 			pwm_u=0;
5073  0c6a 5f            	clrw	x
5074  0c6b bf0e          	ldw	_pwm_u,x
5075                     ; 858 			pwm_i=0;
5077  0c6d 5f            	clrw	x
5078  0c6e bf10          	ldw	_pwm_i,x
5079                     ; 859 			bBL=1;
5081  0c70 72100003      	bset	_bBL
5082                     ; 860 			bBL_IPS=1;
5084  0c74 72100000      	bset	_bBL_IPS
5085  0c78 2064          	jra	L1342
5086  0c7a               L7442:
5087                     ; 869 else	if(link==ON)				//если есть связьvol_i_temp_avar
5089  0c7a b663          	ld	a,_link
5090  0c7c a155          	cp	a,#85
5091  0c7e 265e          	jrne	L1342
5092                     ; 871 	if((flags&0b00100000)==0)	//если нет блокировки извне
5094  0c80 b60b          	ld	a,_flags
5095  0c82 a520          	bcp	a,#32
5096  0c84 2648          	jrne	L7642
5097                     ; 873 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
5099  0c86 b60b          	ld	a,_flags
5100  0c88 a41e          	and	a,#30
5101  0c8a a104          	cp	a,#4
5102  0c8c 2610          	jrne	L1742
5103                     ; 875 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5105  0c8e be5e          	ldw	x,__x_
5106  0c90 72bb0058      	addw	x,_vol_u_temp
5107  0c94 bf0e          	ldw	_pwm_u,x
5108                     ; 876 			pwm_i=vol_i_temp_avar;
5110  0c96 be0c          	ldw	x,_vol_i_temp_avar
5111  0c98 bf10          	ldw	_pwm_i,x
5112                     ; 878 			bBL=0;
5114  0c9a 72110003      	bres	_bBL
5115  0c9e               L1742:
5116                     ; 880 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5118  0c9e b60b          	ld	a,_flags
5119  0ca0 a51a          	bcp	a,#26
5120  0ca2 2706          	jreq	L5742
5122  0ca4 b60b          	ld	a,_flags
5123  0ca6 a540          	bcp	a,#64
5124  0ca8 2712          	jreq	L3742
5125  0caa               L5742:
5126                     ; 882 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5128  0caa be5e          	ldw	x,__x_
5129  0cac 72bb0058      	addw	x,_vol_u_temp
5130  0cb0 bf0e          	ldw	_pwm_u,x
5131                     ; 883 		    	pwm_i=vol_i_temp;
5133  0cb2 be56          	ldw	x,_vol_i_temp
5134  0cb4 bf10          	ldw	_pwm_i,x
5135                     ; 884 			bBL=0;
5137  0cb6 72110003      	bres	_bBL
5139  0cba 2022          	jra	L1342
5140  0cbc               L3742:
5141                     ; 886 		else if(flags&0b00011010)					//если есть аварии
5143  0cbc b60b          	ld	a,_flags
5144  0cbe a51a          	bcp	a,#26
5145  0cc0 271c          	jreq	L1342
5146                     ; 888 			pwm_u=0;								//то полный стоп
5148  0cc2 5f            	clrw	x
5149  0cc3 bf0e          	ldw	_pwm_u,x
5150                     ; 889 			pwm_i=0;
5152  0cc5 5f            	clrw	x
5153  0cc6 bf10          	ldw	_pwm_i,x
5154                     ; 890 			bBL=1;
5156  0cc8 72100003      	bset	_bBL
5157  0ccc 2010          	jra	L1342
5158  0cce               L7642:
5159                     ; 893 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5161  0cce b60b          	ld	a,_flags
5162  0cd0 a520          	bcp	a,#32
5163  0cd2 270a          	jreq	L1342
5164                     ; 895 		pwm_u=0;
5166  0cd4 5f            	clrw	x
5167  0cd5 bf0e          	ldw	_pwm_u,x
5168                     ; 896 	    	pwm_i=0;
5170  0cd7 5f            	clrw	x
5171  0cd8 bf10          	ldw	_pwm_i,x
5172                     ; 897 		bBL=1;
5174  0cda 72100003      	bset	_bBL
5175  0cde               L1342:
5176                     ; 903 }
5179  0cde 81            	ret
5224                     	switch	.const
5225  000c               L07:
5226  000c 00000258      	dc.l	600
5227  0010               L27:
5228  0010 000003e8      	dc.l	1000
5229  0014               L47:
5230  0014 00000708      	dc.l	1800
5231                     ; 906 void matemat(void)
5231                     ; 907 {
5232                     	switch	.text
5233  0cdf               _matemat:
5235  0cdf 5208          	subw	sp,#8
5236       00000008      OFST:	set	8
5239                     ; 928 temp_SL=adc_buff_[4];
5241  0ce1 ce0011        	ldw	x,_adc_buff_+8
5242  0ce4 cd0000        	call	c_itolx
5244  0ce7 96            	ldw	x,sp
5245  0ce8 1c0005        	addw	x,#OFST-3
5246  0ceb cd0000        	call	c_rtol
5248                     ; 929 temp_SL-=ee_K[0][0];
5250  0cee ce001a        	ldw	x,_ee_K
5251  0cf1 cd0000        	call	c_itolx
5253  0cf4 96            	ldw	x,sp
5254  0cf5 1c0005        	addw	x,#OFST-3
5255  0cf8 cd0000        	call	c_lgsub
5257                     ; 930 if(temp_SL<0) temp_SL=0;
5259  0cfb 9c            	rvf
5260  0cfc 0d05          	tnz	(OFST-3,sp)
5261  0cfe 2e0a          	jrsge	L5252
5264  0d00 ae0000        	ldw	x,#0
5265  0d03 1f07          	ldw	(OFST-1,sp),x
5266  0d05 ae0000        	ldw	x,#0
5267  0d08 1f05          	ldw	(OFST-3,sp),x
5268  0d0a               L5252:
5269                     ; 931 temp_SL*=ee_K[0][1];
5271  0d0a ce001c        	ldw	x,_ee_K+2
5272  0d0d cd0000        	call	c_itolx
5274  0d10 96            	ldw	x,sp
5275  0d11 1c0005        	addw	x,#OFST-3
5276  0d14 cd0000        	call	c_lgmul
5278                     ; 932 temp_SL/=600;
5280  0d17 96            	ldw	x,sp
5281  0d18 1c0005        	addw	x,#OFST-3
5282  0d1b cd0000        	call	c_ltor
5284  0d1e ae000c        	ldw	x,#L07
5285  0d21 cd0000        	call	c_ldiv
5287  0d24 96            	ldw	x,sp
5288  0d25 1c0005        	addw	x,#OFST-3
5289  0d28 cd0000        	call	c_rtol
5291                     ; 933 I=(signed short)temp_SL;
5293  0d2b 1e07          	ldw	x,(OFST-1,sp)
5294  0d2d bf6f          	ldw	_I,x
5295                     ; 938 temp_SL=(signed long)adc_buff_[1];
5297  0d2f ce000b        	ldw	x,_adc_buff_+2
5298  0d32 cd0000        	call	c_itolx
5300  0d35 96            	ldw	x,sp
5301  0d36 1c0005        	addw	x,#OFST-3
5302  0d39 cd0000        	call	c_rtol
5304                     ; 940 if(temp_SL<0) temp_SL=0;
5306  0d3c 9c            	rvf
5307  0d3d 0d05          	tnz	(OFST-3,sp)
5308  0d3f 2e0a          	jrsge	L7252
5311  0d41 ae0000        	ldw	x,#0
5312  0d44 1f07          	ldw	(OFST-1,sp),x
5313  0d46 ae0000        	ldw	x,#0
5314  0d49 1f05          	ldw	(OFST-3,sp),x
5315  0d4b               L7252:
5316                     ; 941 temp_SL*=(signed long)ee_K[2][1];
5318  0d4b ce0024        	ldw	x,_ee_K+10
5319  0d4e cd0000        	call	c_itolx
5321  0d51 96            	ldw	x,sp
5322  0d52 1c0005        	addw	x,#OFST-3
5323  0d55 cd0000        	call	c_lgmul
5325                     ; 942 temp_SL/=1000L;
5327  0d58 96            	ldw	x,sp
5328  0d59 1c0005        	addw	x,#OFST-3
5329  0d5c cd0000        	call	c_ltor
5331  0d5f ae0010        	ldw	x,#L27
5332  0d62 cd0000        	call	c_ldiv
5334  0d65 96            	ldw	x,sp
5335  0d66 1c0005        	addw	x,#OFST-3
5336  0d69 cd0000        	call	c_rtol
5338                     ; 943 Ui=(unsigned short)temp_SL;
5340  0d6c 1e07          	ldw	x,(OFST-1,sp)
5341  0d6e bf6b          	ldw	_Ui,x
5342                     ; 950 temp_SL=adc_buff_[3];
5344  0d70 ce000f        	ldw	x,_adc_buff_+6
5345  0d73 cd0000        	call	c_itolx
5347  0d76 96            	ldw	x,sp
5348  0d77 1c0005        	addw	x,#OFST-3
5349  0d7a cd0000        	call	c_rtol
5351                     ; 952 if(temp_SL<0) temp_SL=0;
5353  0d7d 9c            	rvf
5354  0d7e 0d05          	tnz	(OFST-3,sp)
5355  0d80 2e0a          	jrsge	L1352
5358  0d82 ae0000        	ldw	x,#0
5359  0d85 1f07          	ldw	(OFST-1,sp),x
5360  0d87 ae0000        	ldw	x,#0
5361  0d8a 1f05          	ldw	(OFST-3,sp),x
5362  0d8c               L1352:
5363                     ; 953 temp_SL*=ee_K[1][1];
5365  0d8c ce0020        	ldw	x,_ee_K+6
5366  0d8f cd0000        	call	c_itolx
5368  0d92 96            	ldw	x,sp
5369  0d93 1c0005        	addw	x,#OFST-3
5370  0d96 cd0000        	call	c_lgmul
5372                     ; 954 temp_SL/=1800;
5374  0d99 96            	ldw	x,sp
5375  0d9a 1c0005        	addw	x,#OFST-3
5376  0d9d cd0000        	call	c_ltor
5378  0da0 ae0014        	ldw	x,#L47
5379  0da3 cd0000        	call	c_ldiv
5381  0da6 96            	ldw	x,sp
5382  0da7 1c0005        	addw	x,#OFST-3
5383  0daa cd0000        	call	c_rtol
5385                     ; 955 Un=(unsigned short)temp_SL;
5387  0dad 1e07          	ldw	x,(OFST-1,sp)
5388  0daf bf6d          	ldw	_Un,x
5389                     ; 958 temp_SL=adc_buff_[2];
5391  0db1 ce000d        	ldw	x,_adc_buff_+4
5392  0db4 cd0000        	call	c_itolx
5394  0db7 96            	ldw	x,sp
5395  0db8 1c0005        	addw	x,#OFST-3
5396  0dbb cd0000        	call	c_rtol
5398                     ; 959 temp_SL*=ee_K[3][1];
5400  0dbe ce0028        	ldw	x,_ee_K+14
5401  0dc1 cd0000        	call	c_itolx
5403  0dc4 96            	ldw	x,sp
5404  0dc5 1c0005        	addw	x,#OFST-3
5405  0dc8 cd0000        	call	c_lgmul
5407                     ; 960 temp_SL/=1000;
5409  0dcb 96            	ldw	x,sp
5410  0dcc 1c0005        	addw	x,#OFST-3
5411  0dcf cd0000        	call	c_ltor
5413  0dd2 ae0010        	ldw	x,#L27
5414  0dd5 cd0000        	call	c_ldiv
5416  0dd8 96            	ldw	x,sp
5417  0dd9 1c0005        	addw	x,#OFST-3
5418  0ddc cd0000        	call	c_rtol
5420                     ; 961 T=(signed short)(temp_SL-273L);
5422  0ddf 7b08          	ld	a,(OFST+0,sp)
5423  0de1 5f            	clrw	x
5424  0de2 4d            	tnz	a
5425  0de3 2a01          	jrpl	L67
5426  0de5 53            	cplw	x
5427  0de6               L67:
5428  0de6 97            	ld	xl,a
5429  0de7 1d0111        	subw	x,#273
5430  0dea 01            	rrwa	x,a
5431  0deb b768          	ld	_T,a
5432  0ded 02            	rlwa	x,a
5433                     ; 962 if(T<-30)T=-30;
5435  0dee 9c            	rvf
5436  0def b668          	ld	a,_T
5437  0df1 a1e2          	cp	a,#226
5438  0df3 2e04          	jrsge	L3352
5441  0df5 35e20068      	mov	_T,#226
5442  0df9               L3352:
5443                     ; 963 if(T>120)T=120;
5445  0df9 9c            	rvf
5446  0dfa b668          	ld	a,_T
5447  0dfc a179          	cp	a,#121
5448  0dfe 2f04          	jrslt	L5352
5451  0e00 35780068      	mov	_T,#120
5452  0e04               L5352:
5453                     ; 965 Udb=flags;
5455  0e04 b60b          	ld	a,_flags
5456  0e06 5f            	clrw	x
5457  0e07 97            	ld	xl,a
5458  0e08 bf69          	ldw	_Udb,x
5459                     ; 971 temp_SL=(signed long)(T-ee_tsign);
5461  0e0a 5f            	clrw	x
5462  0e0b b668          	ld	a,_T
5463  0e0d 2a01          	jrpl	L001
5464  0e0f 53            	cplw	x
5465  0e10               L001:
5466  0e10 97            	ld	xl,a
5467  0e11 72b0000e      	subw	x,_ee_tsign
5468  0e15 cd0000        	call	c_itolx
5470  0e18 96            	ldw	x,sp
5471  0e19 1c0005        	addw	x,#OFST-3
5472  0e1c cd0000        	call	c_rtol
5474                     ; 972 temp_SL*=1000L;
5476  0e1f ae03e8        	ldw	x,#1000
5477  0e22 bf02          	ldw	c_lreg+2,x
5478  0e24 ae0000        	ldw	x,#0
5479  0e27 bf00          	ldw	c_lreg,x
5480  0e29 96            	ldw	x,sp
5481  0e2a 1c0005        	addw	x,#OFST-3
5482  0e2d cd0000        	call	c_lgmul
5484                     ; 973 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5486  0e30 ce0010        	ldw	x,_ee_tmax
5487  0e33 72b0000e      	subw	x,_ee_tsign
5488  0e37 cd0000        	call	c_itolx
5490  0e3a 96            	ldw	x,sp
5491  0e3b 1c0001        	addw	x,#OFST-7
5492  0e3e cd0000        	call	c_rtol
5494  0e41 96            	ldw	x,sp
5495  0e42 1c0005        	addw	x,#OFST-3
5496  0e45 cd0000        	call	c_ltor
5498  0e48 96            	ldw	x,sp
5499  0e49 1c0001        	addw	x,#OFST-7
5500  0e4c cd0000        	call	c_ldiv
5502  0e4f 96            	ldw	x,sp
5503  0e50 1c0005        	addw	x,#OFST-3
5504  0e53 cd0000        	call	c_rtol
5506                     ; 975 vol_i_temp_avar=(unsigned short)temp_SL; 
5508  0e56 1e07          	ldw	x,(OFST-1,sp)
5509  0e58 bf0c          	ldw	_vol_i_temp_avar,x
5510                     ; 977 }
5513  0e5a 5b08          	addw	sp,#8
5514  0e5c 81            	ret
5545                     ; 980 void temper_drv(void)		//1 Hz
5545                     ; 981 {
5546                     	switch	.text
5547  0e5d               _temper_drv:
5551                     ; 983 if(T>ee_tsign) tsign_cnt++;
5553  0e5d 9c            	rvf
5554  0e5e 5f            	clrw	x
5555  0e5f b668          	ld	a,_T
5556  0e61 2a01          	jrpl	L401
5557  0e63 53            	cplw	x
5558  0e64               L401:
5559  0e64 97            	ld	xl,a
5560  0e65 c3000e        	cpw	x,_ee_tsign
5561  0e68 2d09          	jrsle	L7452
5564  0e6a be4d          	ldw	x,_tsign_cnt
5565  0e6c 1c0001        	addw	x,#1
5566  0e6f bf4d          	ldw	_tsign_cnt,x
5568  0e71 201d          	jra	L1552
5569  0e73               L7452:
5570                     ; 984 else if (T<(ee_tsign-1)) tsign_cnt--;
5572  0e73 9c            	rvf
5573  0e74 ce000e        	ldw	x,_ee_tsign
5574  0e77 5a            	decw	x
5575  0e78 905f          	clrw	y
5576  0e7a b668          	ld	a,_T
5577  0e7c 2a02          	jrpl	L601
5578  0e7e 9053          	cplw	y
5579  0e80               L601:
5580  0e80 9097          	ld	yl,a
5581  0e82 90bf00        	ldw	c_y,y
5582  0e85 b300          	cpw	x,c_y
5583  0e87 2d07          	jrsle	L1552
5586  0e89 be4d          	ldw	x,_tsign_cnt
5587  0e8b 1d0001        	subw	x,#1
5588  0e8e bf4d          	ldw	_tsign_cnt,x
5589  0e90               L1552:
5590                     ; 986 gran(&tsign_cnt,0,60);
5592  0e90 ae003c        	ldw	x,#60
5593  0e93 89            	pushw	x
5594  0e94 5f            	clrw	x
5595  0e95 89            	pushw	x
5596  0e96 ae004d        	ldw	x,#_tsign_cnt
5597  0e99 cd00d1        	call	_gran
5599  0e9c 5b04          	addw	sp,#4
5600                     ; 988 if(tsign_cnt>=55)
5602  0e9e 9c            	rvf
5603  0e9f be4d          	ldw	x,_tsign_cnt
5604  0ea1 a30037        	cpw	x,#55
5605  0ea4 2f16          	jrslt	L5552
5606                     ; 990 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5608  0ea6 3d4a          	tnz	_jp_mode
5609  0ea8 2606          	jrne	L3652
5611  0eaa b60b          	ld	a,_flags
5612  0eac a540          	bcp	a,#64
5613  0eae 2706          	jreq	L1652
5614  0eb0               L3652:
5616  0eb0 b64a          	ld	a,_jp_mode
5617  0eb2 a103          	cp	a,#3
5618  0eb4 2612          	jrne	L5652
5619  0eb6               L1652:
5622  0eb6 7214000b      	bset	_flags,#2
5623  0eba 200c          	jra	L5652
5624  0ebc               L5552:
5625                     ; 992 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5627  0ebc 9c            	rvf
5628  0ebd be4d          	ldw	x,_tsign_cnt
5629  0ebf a30006        	cpw	x,#6
5630  0ec2 2e04          	jrsge	L5652
5633  0ec4 7215000b      	bres	_flags,#2
5634  0ec8               L5652:
5635                     ; 997 if(T>ee_tmax) tmax_cnt++;
5637  0ec8 9c            	rvf
5638  0ec9 5f            	clrw	x
5639  0eca b668          	ld	a,_T
5640  0ecc 2a01          	jrpl	L011
5641  0ece 53            	cplw	x
5642  0ecf               L011:
5643  0ecf 97            	ld	xl,a
5644  0ed0 c30010        	cpw	x,_ee_tmax
5645  0ed3 2d09          	jrsle	L1752
5648  0ed5 be4b          	ldw	x,_tmax_cnt
5649  0ed7 1c0001        	addw	x,#1
5650  0eda bf4b          	ldw	_tmax_cnt,x
5652  0edc 201d          	jra	L3752
5653  0ede               L1752:
5654                     ; 998 else if (T<(ee_tmax-1)) tmax_cnt--;
5656  0ede 9c            	rvf
5657  0edf ce0010        	ldw	x,_ee_tmax
5658  0ee2 5a            	decw	x
5659  0ee3 905f          	clrw	y
5660  0ee5 b668          	ld	a,_T
5661  0ee7 2a02          	jrpl	L211
5662  0ee9 9053          	cplw	y
5663  0eeb               L211:
5664  0eeb 9097          	ld	yl,a
5665  0eed 90bf00        	ldw	c_y,y
5666  0ef0 b300          	cpw	x,c_y
5667  0ef2 2d07          	jrsle	L3752
5670  0ef4 be4b          	ldw	x,_tmax_cnt
5671  0ef6 1d0001        	subw	x,#1
5672  0ef9 bf4b          	ldw	_tmax_cnt,x
5673  0efb               L3752:
5674                     ; 1000 gran(&tmax_cnt,0,60);
5676  0efb ae003c        	ldw	x,#60
5677  0efe 89            	pushw	x
5678  0eff 5f            	clrw	x
5679  0f00 89            	pushw	x
5680  0f01 ae004b        	ldw	x,#_tmax_cnt
5681  0f04 cd00d1        	call	_gran
5683  0f07 5b04          	addw	sp,#4
5684                     ; 1002 if(tmax_cnt>=55)
5686  0f09 9c            	rvf
5687  0f0a be4b          	ldw	x,_tmax_cnt
5688  0f0c a30037        	cpw	x,#55
5689  0f0f 2f16          	jrslt	L7752
5690                     ; 1004 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5692  0f11 3d4a          	tnz	_jp_mode
5693  0f13 2606          	jrne	L5062
5695  0f15 b60b          	ld	a,_flags
5696  0f17 a540          	bcp	a,#64
5697  0f19 2706          	jreq	L3062
5698  0f1b               L5062:
5700  0f1b b64a          	ld	a,_jp_mode
5701  0f1d a103          	cp	a,#3
5702  0f1f 2612          	jrne	L7062
5703  0f21               L3062:
5706  0f21 7212000b      	bset	_flags,#1
5707  0f25 200c          	jra	L7062
5708  0f27               L7752:
5709                     ; 1006 else if (tmax_cnt<=5) flags&=0b11111101;
5711  0f27 9c            	rvf
5712  0f28 be4b          	ldw	x,_tmax_cnt
5713  0f2a a30006        	cpw	x,#6
5714  0f2d 2e04          	jrsge	L7062
5717  0f2f 7213000b      	bres	_flags,#1
5718  0f33               L7062:
5719                     ; 1009 } 
5722  0f33 81            	ret
5754                     ; 1012 void u_drv(void)		//1Hz
5754                     ; 1013 { 
5755                     	switch	.text
5756  0f34               _u_drv:
5760                     ; 1014 if(jp_mode!=jp3)
5762  0f34 b64a          	ld	a,_jp_mode
5763  0f36 a103          	cp	a,#3
5764  0f38 2770          	jreq	L3262
5765                     ; 1016 	if(Ui>ee_Umax)umax_cnt++;
5767  0f3a 9c            	rvf
5768  0f3b be6b          	ldw	x,_Ui
5769  0f3d c30014        	cpw	x,_ee_Umax
5770  0f40 2d09          	jrsle	L5262
5773  0f42 be66          	ldw	x,_umax_cnt
5774  0f44 1c0001        	addw	x,#1
5775  0f47 bf66          	ldw	_umax_cnt,x
5777  0f49 2003          	jra	L7262
5778  0f4b               L5262:
5779                     ; 1017 	else umax_cnt=0;
5781  0f4b 5f            	clrw	x
5782  0f4c bf66          	ldw	_umax_cnt,x
5783  0f4e               L7262:
5784                     ; 1018 	gran(&umax_cnt,0,10);
5786  0f4e ae000a        	ldw	x,#10
5787  0f51 89            	pushw	x
5788  0f52 5f            	clrw	x
5789  0f53 89            	pushw	x
5790  0f54 ae0066        	ldw	x,#_umax_cnt
5791  0f57 cd00d1        	call	_gran
5793  0f5a 5b04          	addw	sp,#4
5794                     ; 1019 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5796  0f5c 9c            	rvf
5797  0f5d be66          	ldw	x,_umax_cnt
5798  0f5f a3000a        	cpw	x,#10
5799  0f62 2f04          	jrslt	L1362
5802  0f64 7216000b      	bset	_flags,#3
5803  0f68               L1362:
5804                     ; 1022 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5806  0f68 9c            	rvf
5807  0f69 be6b          	ldw	x,_Ui
5808  0f6b b36d          	cpw	x,_Un
5809  0f6d 2e1c          	jrsge	L3362
5811  0f6f 9c            	rvf
5812  0f70 be6d          	ldw	x,_Un
5813  0f72 72b0006b      	subw	x,_Ui
5814  0f76 c30012        	cpw	x,_ee_dU
5815  0f79 2d10          	jrsle	L3362
5817  0f7b c65005        	ld	a,20485
5818  0f7e a504          	bcp	a,#4
5819  0f80 2609          	jrne	L3362
5822  0f82 be64          	ldw	x,_umin_cnt
5823  0f84 1c0001        	addw	x,#1
5824  0f87 bf64          	ldw	_umin_cnt,x
5826  0f89 2003          	jra	L5362
5827  0f8b               L3362:
5828                     ; 1023 	else umin_cnt=0;
5830  0f8b 5f            	clrw	x
5831  0f8c bf64          	ldw	_umin_cnt,x
5832  0f8e               L5362:
5833                     ; 1024 	gran(&umin_cnt,0,10);	
5835  0f8e ae000a        	ldw	x,#10
5836  0f91 89            	pushw	x
5837  0f92 5f            	clrw	x
5838  0f93 89            	pushw	x
5839  0f94 ae0064        	ldw	x,#_umin_cnt
5840  0f97 cd00d1        	call	_gran
5842  0f9a 5b04          	addw	sp,#4
5843                     ; 1025 	if(umin_cnt>=10)flags|=0b00010000;	  
5845  0f9c 9c            	rvf
5846  0f9d be64          	ldw	x,_umin_cnt
5847  0f9f a3000a        	cpw	x,#10
5848  0fa2 2f6f          	jrslt	L1462
5851  0fa4 7218000b      	bset	_flags,#4
5852  0fa8 2069          	jra	L1462
5853  0faa               L3262:
5854                     ; 1027 else if(jp_mode==jp3)
5856  0faa b64a          	ld	a,_jp_mode
5857  0fac a103          	cp	a,#3
5858  0fae 2663          	jrne	L1462
5859                     ; 1029 	if(Ui>700)umax_cnt++;
5861  0fb0 9c            	rvf
5862  0fb1 be6b          	ldw	x,_Ui
5863  0fb3 a302bd        	cpw	x,#701
5864  0fb6 2f09          	jrslt	L5462
5867  0fb8 be66          	ldw	x,_umax_cnt
5868  0fba 1c0001        	addw	x,#1
5869  0fbd bf66          	ldw	_umax_cnt,x
5871  0fbf 2003          	jra	L7462
5872  0fc1               L5462:
5873                     ; 1030 	else umax_cnt=0;
5875  0fc1 5f            	clrw	x
5876  0fc2 bf66          	ldw	_umax_cnt,x
5877  0fc4               L7462:
5878                     ; 1031 	gran(&umax_cnt,0,10);
5880  0fc4 ae000a        	ldw	x,#10
5881  0fc7 89            	pushw	x
5882  0fc8 5f            	clrw	x
5883  0fc9 89            	pushw	x
5884  0fca ae0066        	ldw	x,#_umax_cnt
5885  0fcd cd00d1        	call	_gran
5887  0fd0 5b04          	addw	sp,#4
5888                     ; 1032 	if(umax_cnt>=10)flags|=0b00001000;
5890  0fd2 9c            	rvf
5891  0fd3 be66          	ldw	x,_umax_cnt
5892  0fd5 a3000a        	cpw	x,#10
5893  0fd8 2f04          	jrslt	L1562
5896  0fda 7216000b      	bset	_flags,#3
5897  0fde               L1562:
5898                     ; 1035 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5900  0fde 9c            	rvf
5901  0fdf be6b          	ldw	x,_Ui
5902  0fe1 a300c8        	cpw	x,#200
5903  0fe4 2e10          	jrsge	L3562
5905  0fe6 c65005        	ld	a,20485
5906  0fe9 a504          	bcp	a,#4
5907  0feb 2609          	jrne	L3562
5910  0fed be64          	ldw	x,_umin_cnt
5911  0fef 1c0001        	addw	x,#1
5912  0ff2 bf64          	ldw	_umin_cnt,x
5914  0ff4 2003          	jra	L5562
5915  0ff6               L3562:
5916                     ; 1036 	else umin_cnt=0;
5918  0ff6 5f            	clrw	x
5919  0ff7 bf64          	ldw	_umin_cnt,x
5920  0ff9               L5562:
5921                     ; 1037 	gran(&umin_cnt,0,10);	
5923  0ff9 ae000a        	ldw	x,#10
5924  0ffc 89            	pushw	x
5925  0ffd 5f            	clrw	x
5926  0ffe 89            	pushw	x
5927  0fff ae0064        	ldw	x,#_umin_cnt
5928  1002 cd00d1        	call	_gran
5930  1005 5b04          	addw	sp,#4
5931                     ; 1038 	if(umin_cnt>=10)flags|=0b00010000;	  
5933  1007 9c            	rvf
5934  1008 be64          	ldw	x,_umin_cnt
5935  100a a3000a        	cpw	x,#10
5936  100d 2f04          	jrslt	L1462
5939  100f 7218000b      	bset	_flags,#4
5940  1013               L1462:
5941                     ; 1040 }
5944  1013 81            	ret
5971                     ; 1043 void x_drv(void)
5971                     ; 1044 {
5972                     	switch	.text
5973  1014               _x_drv:
5977                     ; 1045 if(_x__==_x_)
5979  1014 be5c          	ldw	x,__x__
5980  1016 b35e          	cpw	x,__x_
5981  1018 262a          	jrne	L1762
5982                     ; 1047 	if(_x_cnt<60)
5984  101a 9c            	rvf
5985  101b be5a          	ldw	x,__x_cnt
5986  101d a3003c        	cpw	x,#60
5987  1020 2e25          	jrsge	L1072
5988                     ; 1049 		_x_cnt++;
5990  1022 be5a          	ldw	x,__x_cnt
5991  1024 1c0001        	addw	x,#1
5992  1027 bf5a          	ldw	__x_cnt,x
5993                     ; 1050 		if(_x_cnt>=60)
5995  1029 9c            	rvf
5996  102a be5a          	ldw	x,__x_cnt
5997  102c a3003c        	cpw	x,#60
5998  102f 2f16          	jrslt	L1072
5999                     ; 1052 			if(_x_ee_!=_x_)_x_ee_=_x_;
6001  1031 ce0018        	ldw	x,__x_ee_
6002  1034 b35e          	cpw	x,__x_
6003  1036 270f          	jreq	L1072
6006  1038 be5e          	ldw	x,__x_
6007  103a 89            	pushw	x
6008  103b ae0018        	ldw	x,#__x_ee_
6009  103e cd0000        	call	c_eewrw
6011  1041 85            	popw	x
6012  1042 2003          	jra	L1072
6013  1044               L1762:
6014                     ; 1057 else _x_cnt=0;
6016  1044 5f            	clrw	x
6017  1045 bf5a          	ldw	__x_cnt,x
6018  1047               L1072:
6019                     ; 1059 if(_x_cnt>60) _x_cnt=0;	
6021  1047 9c            	rvf
6022  1048 be5a          	ldw	x,__x_cnt
6023  104a a3003d        	cpw	x,#61
6024  104d 2f03          	jrslt	L3072
6027  104f 5f            	clrw	x
6028  1050 bf5a          	ldw	__x_cnt,x
6029  1052               L3072:
6030                     ; 1061 _x__=_x_;
6032  1052 be5e          	ldw	x,__x_
6033  1054 bf5c          	ldw	__x__,x
6034                     ; 1062 }
6037  1056 81            	ret
6063                     ; 1065 void apv_start(void)
6063                     ; 1066 {
6064                     	switch	.text
6065  1057               _apv_start:
6069                     ; 1067 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6071  1057 3d45          	tnz	_apv_cnt
6072  1059 2624          	jrne	L5172
6074  105b 3d46          	tnz	_apv_cnt+1
6075  105d 2620          	jrne	L5172
6077  105f 3d47          	tnz	_apv_cnt+2
6078  1061 261c          	jrne	L5172
6080                     	btst	_bAPV
6081  1068 2515          	jrult	L5172
6082                     ; 1069 	apv_cnt[0]=60;
6084  106a 353c0045      	mov	_apv_cnt,#60
6085                     ; 1070 	apv_cnt[1]=60;
6087  106e 353c0046      	mov	_apv_cnt+1,#60
6088                     ; 1071 	apv_cnt[2]=60;
6090  1072 353c0047      	mov	_apv_cnt+2,#60
6091                     ; 1072 	apv_cnt_=3600;
6093  1076 ae0e10        	ldw	x,#3600
6094  1079 bf43          	ldw	_apv_cnt_,x
6095                     ; 1073 	bAPV=1;	
6097  107b 72100002      	bset	_bAPV
6098  107f               L5172:
6099                     ; 1075 }
6102  107f 81            	ret
6128                     ; 1078 void apv_stop(void)
6128                     ; 1079 {
6129                     	switch	.text
6130  1080               _apv_stop:
6134                     ; 1080 apv_cnt[0]=0;
6136  1080 3f45          	clr	_apv_cnt
6137                     ; 1081 apv_cnt[1]=0;
6139  1082 3f46          	clr	_apv_cnt+1
6140                     ; 1082 apv_cnt[2]=0;
6142  1084 3f47          	clr	_apv_cnt+2
6143                     ; 1083 apv_cnt_=0;	
6145  1086 5f            	clrw	x
6146  1087 bf43          	ldw	_apv_cnt_,x
6147                     ; 1084 bAPV=0;
6149  1089 72110002      	bres	_bAPV
6150                     ; 1085 }
6153  108d 81            	ret
6188                     ; 1089 void apv_hndl(void)
6188                     ; 1090 {
6189                     	switch	.text
6190  108e               _apv_hndl:
6194                     ; 1091 if(apv_cnt[0])
6196  108e 3d45          	tnz	_apv_cnt
6197  1090 271e          	jreq	L7372
6198                     ; 1093 	apv_cnt[0]--;
6200  1092 3a45          	dec	_apv_cnt
6201                     ; 1094 	if(apv_cnt[0]==0)
6203  1094 3d45          	tnz	_apv_cnt
6204  1096 265a          	jrne	L3472
6205                     ; 1096 		flags&=0b11100001;
6207  1098 b60b          	ld	a,_flags
6208  109a a4e1          	and	a,#225
6209  109c b70b          	ld	_flags,a
6210                     ; 1097 		tsign_cnt=0;
6212  109e 5f            	clrw	x
6213  109f bf4d          	ldw	_tsign_cnt,x
6214                     ; 1098 		tmax_cnt=0;
6216  10a1 5f            	clrw	x
6217  10a2 bf4b          	ldw	_tmax_cnt,x
6218                     ; 1099 		umax_cnt=0;
6220  10a4 5f            	clrw	x
6221  10a5 bf66          	ldw	_umax_cnt,x
6222                     ; 1100 		umin_cnt=0;
6224  10a7 5f            	clrw	x
6225  10a8 bf64          	ldw	_umin_cnt,x
6226                     ; 1102 		led_drv_cnt=30;
6228  10aa 351e001c      	mov	_led_drv_cnt,#30
6229  10ae 2042          	jra	L3472
6230  10b0               L7372:
6231                     ; 1105 else if(apv_cnt[1])
6233  10b0 3d46          	tnz	_apv_cnt+1
6234  10b2 271e          	jreq	L5472
6235                     ; 1107 	apv_cnt[1]--;
6237  10b4 3a46          	dec	_apv_cnt+1
6238                     ; 1108 	if(apv_cnt[1]==0)
6240  10b6 3d46          	tnz	_apv_cnt+1
6241  10b8 2638          	jrne	L3472
6242                     ; 1110 		flags&=0b11100001;
6244  10ba b60b          	ld	a,_flags
6245  10bc a4e1          	and	a,#225
6246  10be b70b          	ld	_flags,a
6247                     ; 1111 		tsign_cnt=0;
6249  10c0 5f            	clrw	x
6250  10c1 bf4d          	ldw	_tsign_cnt,x
6251                     ; 1112 		tmax_cnt=0;
6253  10c3 5f            	clrw	x
6254  10c4 bf4b          	ldw	_tmax_cnt,x
6255                     ; 1113 		umax_cnt=0;
6257  10c6 5f            	clrw	x
6258  10c7 bf66          	ldw	_umax_cnt,x
6259                     ; 1114 		umin_cnt=0;
6261  10c9 5f            	clrw	x
6262  10ca bf64          	ldw	_umin_cnt,x
6263                     ; 1116 		led_drv_cnt=30;
6265  10cc 351e001c      	mov	_led_drv_cnt,#30
6266  10d0 2020          	jra	L3472
6267  10d2               L5472:
6268                     ; 1119 else if(apv_cnt[2])
6270  10d2 3d47          	tnz	_apv_cnt+2
6271  10d4 271c          	jreq	L3472
6272                     ; 1121 	apv_cnt[2]--;
6274  10d6 3a47          	dec	_apv_cnt+2
6275                     ; 1122 	if(apv_cnt[2]==0)
6277  10d8 3d47          	tnz	_apv_cnt+2
6278  10da 2616          	jrne	L3472
6279                     ; 1124 		flags&=0b11100001;
6281  10dc b60b          	ld	a,_flags
6282  10de a4e1          	and	a,#225
6283  10e0 b70b          	ld	_flags,a
6284                     ; 1125 		tsign_cnt=0;
6286  10e2 5f            	clrw	x
6287  10e3 bf4d          	ldw	_tsign_cnt,x
6288                     ; 1126 		tmax_cnt=0;
6290  10e5 5f            	clrw	x
6291  10e6 bf4b          	ldw	_tmax_cnt,x
6292                     ; 1127 		umax_cnt=0;
6294  10e8 5f            	clrw	x
6295  10e9 bf66          	ldw	_umax_cnt,x
6296                     ; 1128 		umin_cnt=0;          
6298  10eb 5f            	clrw	x
6299  10ec bf64          	ldw	_umin_cnt,x
6300                     ; 1130 		led_drv_cnt=30;
6302  10ee 351e001c      	mov	_led_drv_cnt,#30
6303  10f2               L3472:
6304                     ; 1134 if(apv_cnt_)
6306  10f2 be43          	ldw	x,_apv_cnt_
6307  10f4 2712          	jreq	L7572
6308                     ; 1136 	apv_cnt_--;
6310  10f6 be43          	ldw	x,_apv_cnt_
6311  10f8 1d0001        	subw	x,#1
6312  10fb bf43          	ldw	_apv_cnt_,x
6313                     ; 1137 	if(apv_cnt_==0) 
6315  10fd be43          	ldw	x,_apv_cnt_
6316  10ff 2607          	jrne	L7572
6317                     ; 1139 		bAPV=0;
6319  1101 72110002      	bres	_bAPV
6320                     ; 1140 		apv_start();
6322  1105 cd1057        	call	_apv_start
6324  1108               L7572:
6325                     ; 1144 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6327  1108 be64          	ldw	x,_umin_cnt
6328  110a 261e          	jrne	L3672
6330  110c be66          	ldw	x,_umax_cnt
6331  110e 261a          	jrne	L3672
6333  1110 c65005        	ld	a,20485
6334  1113 a504          	bcp	a,#4
6335  1115 2613          	jrne	L3672
6336                     ; 1146 	if(cnt_apv_off<20)
6338  1117 b642          	ld	a,_cnt_apv_off
6339  1119 a114          	cp	a,#20
6340  111b 240f          	jruge	L1772
6341                     ; 1148 		cnt_apv_off++;
6343  111d 3c42          	inc	_cnt_apv_off
6344                     ; 1149 		if(cnt_apv_off>=20)
6346  111f b642          	ld	a,_cnt_apv_off
6347  1121 a114          	cp	a,#20
6348  1123 2507          	jrult	L1772
6349                     ; 1151 			apv_stop();
6351  1125 cd1080        	call	_apv_stop
6353  1128 2002          	jra	L1772
6354  112a               L3672:
6355                     ; 1155 else cnt_apv_off=0;	
6357  112a 3f42          	clr	_cnt_apv_off
6358  112c               L1772:
6359                     ; 1157 }
6362  112c 81            	ret
6365                     	switch	.ubsct
6366  0000               L3772_flags_old:
6367  0000 00            	ds.b	1
6403                     ; 1160 void flags_drv(void)
6403                     ; 1161 {
6404                     	switch	.text
6405  112d               _flags_drv:
6409                     ; 1163 if(jp_mode!=jp3) 
6411  112d b64a          	ld	a,_jp_mode
6412  112f a103          	cp	a,#3
6413  1131 2723          	jreq	L3103
6414                     ; 1165 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6416  1133 b60b          	ld	a,_flags
6417  1135 a508          	bcp	a,#8
6418  1137 2706          	jreq	L1203
6420  1139 b600          	ld	a,L3772_flags_old
6421  113b a508          	bcp	a,#8
6422  113d 270c          	jreq	L7103
6423  113f               L1203:
6425  113f b60b          	ld	a,_flags
6426  1141 a510          	bcp	a,#16
6427  1143 2726          	jreq	L5203
6429  1145 b600          	ld	a,L3772_flags_old
6430  1147 a510          	bcp	a,#16
6431  1149 2620          	jrne	L5203
6432  114b               L7103:
6433                     ; 1167     		if(link==OFF)apv_start();
6435  114b b663          	ld	a,_link
6436  114d a1aa          	cp	a,#170
6437  114f 261a          	jrne	L5203
6440  1151 cd1057        	call	_apv_start
6442  1154 2015          	jra	L5203
6443  1156               L3103:
6444                     ; 1170 else if(jp_mode==jp3) 
6446  1156 b64a          	ld	a,_jp_mode
6447  1158 a103          	cp	a,#3
6448  115a 260f          	jrne	L5203
6449                     ; 1172 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6451  115c b60b          	ld	a,_flags
6452  115e a508          	bcp	a,#8
6453  1160 2709          	jreq	L5203
6455  1162 b600          	ld	a,L3772_flags_old
6456  1164 a508          	bcp	a,#8
6457  1166 2603          	jrne	L5203
6458                     ; 1174     		apv_start();
6460  1168 cd1057        	call	_apv_start
6462  116b               L5203:
6463                     ; 1177 flags_old=flags;
6465  116b 450b00        	mov	L3772_flags_old,_flags
6466                     ; 1179 } 
6469  116e 81            	ret
6504                     ; 1316 void adr_drv_v4(char in)
6504                     ; 1317 {
6505                     	switch	.text
6506  116f               _adr_drv_v4:
6510                     ; 1318 if(adress!=in)adress=in;
6512  116f c10005        	cp	a,_adress
6513  1172 2703          	jreq	L1503
6516  1174 c70005        	ld	_adress,a
6517  1177               L1503:
6518                     ; 1319 }
6521  1177 81            	ret
6550                     ; 1322 void adr_drv_v3(void)
6550                     ; 1323 {
6551                     	switch	.text
6552  1178               _adr_drv_v3:
6554  1178 88            	push	a
6555       00000001      OFST:	set	1
6558                     ; 1329 GPIOB->DDR&=~(1<<0);
6560  1179 72115007      	bres	20487,#0
6561                     ; 1330 GPIOB->CR1&=~(1<<0);
6563  117d 72115008      	bres	20488,#0
6564                     ; 1331 GPIOB->CR2&=~(1<<0);
6566  1181 72115009      	bres	20489,#0
6567                     ; 1332 ADC2->CR2=0x08;
6569  1185 35085402      	mov	21506,#8
6570                     ; 1333 ADC2->CR1=0x40;
6572  1189 35405401      	mov	21505,#64
6573                     ; 1334 ADC2->CSR=0x20+0;
6575  118d 35205400      	mov	21504,#32
6576                     ; 1335 ADC2->CR1|=1;
6578  1191 72105401      	bset	21505,#0
6579                     ; 1336 ADC2->CR1|=1;
6581  1195 72105401      	bset	21505,#0
6582                     ; 1337 adr_drv_stat=1;
6584  1199 35010008      	mov	_adr_drv_stat,#1
6585  119d               L3603:
6586                     ; 1338 while(adr_drv_stat==1);
6589  119d b608          	ld	a,_adr_drv_stat
6590  119f a101          	cp	a,#1
6591  11a1 27fa          	jreq	L3603
6592                     ; 1340 GPIOB->DDR&=~(1<<1);
6594  11a3 72135007      	bres	20487,#1
6595                     ; 1341 GPIOB->CR1&=~(1<<1);
6597  11a7 72135008      	bres	20488,#1
6598                     ; 1342 GPIOB->CR2&=~(1<<1);
6600  11ab 72135009      	bres	20489,#1
6601                     ; 1343 ADC2->CR2=0x08;
6603  11af 35085402      	mov	21506,#8
6604                     ; 1344 ADC2->CR1=0x40;
6606  11b3 35405401      	mov	21505,#64
6607                     ; 1345 ADC2->CSR=0x20+1;
6609  11b7 35215400      	mov	21504,#33
6610                     ; 1346 ADC2->CR1|=1;
6612  11bb 72105401      	bset	21505,#0
6613                     ; 1347 ADC2->CR1|=1;
6615  11bf 72105401      	bset	21505,#0
6616                     ; 1348 adr_drv_stat=3;
6618  11c3 35030008      	mov	_adr_drv_stat,#3
6619  11c7               L1703:
6620                     ; 1349 while(adr_drv_stat==3);
6623  11c7 b608          	ld	a,_adr_drv_stat
6624  11c9 a103          	cp	a,#3
6625  11cb 27fa          	jreq	L1703
6626                     ; 1351 GPIOE->DDR&=~(1<<6);
6628  11cd 721d5016      	bres	20502,#6
6629                     ; 1352 GPIOE->CR1&=~(1<<6);
6631  11d1 721d5017      	bres	20503,#6
6632                     ; 1353 GPIOE->CR2&=~(1<<6);
6634  11d5 721d5018      	bres	20504,#6
6635                     ; 1354 ADC2->CR2=0x08;
6637  11d9 35085402      	mov	21506,#8
6638                     ; 1355 ADC2->CR1=0x40;
6640  11dd 35405401      	mov	21505,#64
6641                     ; 1356 ADC2->CSR=0x20+9;
6643  11e1 35295400      	mov	21504,#41
6644                     ; 1357 ADC2->CR1|=1;
6646  11e5 72105401      	bset	21505,#0
6647                     ; 1358 ADC2->CR1|=1;
6649  11e9 72105401      	bset	21505,#0
6650                     ; 1359 adr_drv_stat=5;
6652  11ed 35050008      	mov	_adr_drv_stat,#5
6653  11f1               L7703:
6654                     ; 1360 while(adr_drv_stat==5);
6657  11f1 b608          	ld	a,_adr_drv_stat
6658  11f3 a105          	cp	a,#5
6659  11f5 27fa          	jreq	L7703
6660                     ; 1364 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6662  11f7 9c            	rvf
6663  11f8 ce0009        	ldw	x,_adc_buff_
6664  11fb a3022a        	cpw	x,#554
6665  11fe 2f0f          	jrslt	L5013
6667  1200 9c            	rvf
6668  1201 ce0009        	ldw	x,_adc_buff_
6669  1204 a30253        	cpw	x,#595
6670  1207 2e06          	jrsge	L5013
6673  1209 725f0006      	clr	_adr
6675  120d 204c          	jra	L7013
6676  120f               L5013:
6677                     ; 1365 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6679  120f 9c            	rvf
6680  1210 ce0009        	ldw	x,_adc_buff_
6681  1213 a3036d        	cpw	x,#877
6682  1216 2f0f          	jrslt	L1113
6684  1218 9c            	rvf
6685  1219 ce0009        	ldw	x,_adc_buff_
6686  121c a30396        	cpw	x,#918
6687  121f 2e06          	jrsge	L1113
6690  1221 35010006      	mov	_adr,#1
6692  1225 2034          	jra	L7013
6693  1227               L1113:
6694                     ; 1366 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6696  1227 9c            	rvf
6697  1228 ce0009        	ldw	x,_adc_buff_
6698  122b a302a3        	cpw	x,#675
6699  122e 2f0f          	jrslt	L5113
6701  1230 9c            	rvf
6702  1231 ce0009        	ldw	x,_adc_buff_
6703  1234 a302cc        	cpw	x,#716
6704  1237 2e06          	jrsge	L5113
6707  1239 35020006      	mov	_adr,#2
6709  123d 201c          	jra	L7013
6710  123f               L5113:
6711                     ; 1367 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6713  123f 9c            	rvf
6714  1240 ce0009        	ldw	x,_adc_buff_
6715  1243 a303e3        	cpw	x,#995
6716  1246 2f0f          	jrslt	L1213
6718  1248 9c            	rvf
6719  1249 ce0009        	ldw	x,_adc_buff_
6720  124c a3040c        	cpw	x,#1036
6721  124f 2e06          	jrsge	L1213
6724  1251 35030006      	mov	_adr,#3
6726  1255 2004          	jra	L7013
6727  1257               L1213:
6728                     ; 1368 else adr[0]=5;
6730  1257 35050006      	mov	_adr,#5
6731  125b               L7013:
6732                     ; 1370 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6734  125b 9c            	rvf
6735  125c ce000b        	ldw	x,_adc_buff_+2
6736  125f a3022a        	cpw	x,#554
6737  1262 2f0f          	jrslt	L5213
6739  1264 9c            	rvf
6740  1265 ce000b        	ldw	x,_adc_buff_+2
6741  1268 a30253        	cpw	x,#595
6742  126b 2e06          	jrsge	L5213
6745  126d 725f0007      	clr	_adr+1
6747  1271 204c          	jra	L7213
6748  1273               L5213:
6749                     ; 1371 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6751  1273 9c            	rvf
6752  1274 ce000b        	ldw	x,_adc_buff_+2
6753  1277 a3036d        	cpw	x,#877
6754  127a 2f0f          	jrslt	L1313
6756  127c 9c            	rvf
6757  127d ce000b        	ldw	x,_adc_buff_+2
6758  1280 a30396        	cpw	x,#918
6759  1283 2e06          	jrsge	L1313
6762  1285 35010007      	mov	_adr+1,#1
6764  1289 2034          	jra	L7213
6765  128b               L1313:
6766                     ; 1372 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6768  128b 9c            	rvf
6769  128c ce000b        	ldw	x,_adc_buff_+2
6770  128f a302a3        	cpw	x,#675
6771  1292 2f0f          	jrslt	L5313
6773  1294 9c            	rvf
6774  1295 ce000b        	ldw	x,_adc_buff_+2
6775  1298 a302cc        	cpw	x,#716
6776  129b 2e06          	jrsge	L5313
6779  129d 35020007      	mov	_adr+1,#2
6781  12a1 201c          	jra	L7213
6782  12a3               L5313:
6783                     ; 1373 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6785  12a3 9c            	rvf
6786  12a4 ce000b        	ldw	x,_adc_buff_+2
6787  12a7 a303e3        	cpw	x,#995
6788  12aa 2f0f          	jrslt	L1413
6790  12ac 9c            	rvf
6791  12ad ce000b        	ldw	x,_adc_buff_+2
6792  12b0 a3040c        	cpw	x,#1036
6793  12b3 2e06          	jrsge	L1413
6796  12b5 35030007      	mov	_adr+1,#3
6798  12b9 2004          	jra	L7213
6799  12bb               L1413:
6800                     ; 1374 else adr[1]=5;
6802  12bb 35050007      	mov	_adr+1,#5
6803  12bf               L7213:
6804                     ; 1376 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6806  12bf 9c            	rvf
6807  12c0 ce001b        	ldw	x,_adc_buff_+18
6808  12c3 a3022a        	cpw	x,#554
6809  12c6 2f0f          	jrslt	L5413
6811  12c8 9c            	rvf
6812  12c9 ce001b        	ldw	x,_adc_buff_+18
6813  12cc a30253        	cpw	x,#595
6814  12cf 2e06          	jrsge	L5413
6817  12d1 725f0008      	clr	_adr+2
6819  12d5 204c          	jra	L7413
6820  12d7               L5413:
6821                     ; 1377 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6823  12d7 9c            	rvf
6824  12d8 ce001b        	ldw	x,_adc_buff_+18
6825  12db a3036d        	cpw	x,#877
6826  12de 2f0f          	jrslt	L1513
6828  12e0 9c            	rvf
6829  12e1 ce001b        	ldw	x,_adc_buff_+18
6830  12e4 a30396        	cpw	x,#918
6831  12e7 2e06          	jrsge	L1513
6834  12e9 35010008      	mov	_adr+2,#1
6836  12ed 2034          	jra	L7413
6837  12ef               L1513:
6838                     ; 1378 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6840  12ef 9c            	rvf
6841  12f0 ce001b        	ldw	x,_adc_buff_+18
6842  12f3 a302a3        	cpw	x,#675
6843  12f6 2f0f          	jrslt	L5513
6845  12f8 9c            	rvf
6846  12f9 ce001b        	ldw	x,_adc_buff_+18
6847  12fc a302cc        	cpw	x,#716
6848  12ff 2e06          	jrsge	L5513
6851  1301 35020008      	mov	_adr+2,#2
6853  1305 201c          	jra	L7413
6854  1307               L5513:
6855                     ; 1379 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6857  1307 9c            	rvf
6858  1308 ce001b        	ldw	x,_adc_buff_+18
6859  130b a303e3        	cpw	x,#995
6860  130e 2f0f          	jrslt	L1613
6862  1310 9c            	rvf
6863  1311 ce001b        	ldw	x,_adc_buff_+18
6864  1314 a3040c        	cpw	x,#1036
6865  1317 2e06          	jrsge	L1613
6868  1319 35030008      	mov	_adr+2,#3
6870  131d 2004          	jra	L7413
6871  131f               L1613:
6872                     ; 1380 else adr[2]=5;
6874  131f 35050008      	mov	_adr+2,#5
6875  1323               L7413:
6876                     ; 1384 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6878  1323 c60006        	ld	a,_adr
6879  1326 a105          	cp	a,#5
6880  1328 270e          	jreq	L7613
6882  132a c60007        	ld	a,_adr+1
6883  132d a105          	cp	a,#5
6884  132f 2707          	jreq	L7613
6886  1331 c60008        	ld	a,_adr+2
6887  1334 a105          	cp	a,#5
6888  1336 2606          	jrne	L5613
6889  1338               L7613:
6890                     ; 1387 	adress_error=1;
6892  1338 35010004      	mov	_adress_error,#1
6894  133c               L3713:
6895                     ; 1398 }
6898  133c 84            	pop	a
6899  133d 81            	ret
6900  133e               L5613:
6901                     ; 1391 	if(adr[2]&0x02) bps_class=bpsIPS;
6903  133e c60008        	ld	a,_adr+2
6904  1341 a502          	bcp	a,#2
6905  1343 2706          	jreq	L5713
6908  1345 35010004      	mov	_bps_class,#1
6910  1349 2002          	jra	L7713
6911  134b               L5713:
6912                     ; 1392 	else bps_class=bpsIBEP;
6914  134b 3f04          	clr	_bps_class
6915  134d               L7713:
6916                     ; 1394 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6918  134d c60008        	ld	a,_adr+2
6919  1350 a401          	and	a,#1
6920  1352 97            	ld	xl,a
6921  1353 a610          	ld	a,#16
6922  1355 42            	mul	x,a
6923  1356 9f            	ld	a,xl
6924  1357 6b01          	ld	(OFST+0,sp),a
6925  1359 c60007        	ld	a,_adr+1
6926  135c 48            	sll	a
6927  135d 48            	sll	a
6928  135e cb0006        	add	a,_adr
6929  1361 1b01          	add	a,(OFST+0,sp)
6930  1363 c70005        	ld	_adress,a
6931  1366 20d4          	jra	L3713
6975                     ; 1401 void volum_u_main_drv(void)
6975                     ; 1402 {
6976                     	switch	.text
6977  1368               _volum_u_main_drv:
6979  1368 88            	push	a
6980       00000001      OFST:	set	1
6983                     ; 1405 if(bMAIN)
6985                     	btst	_bMAIN
6986  136e 2503          	jrult	L631
6987  1370 cc14b9        	jp	L7123
6988  1373               L631:
6989                     ; 1407 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6991  1373 9c            	rvf
6992  1374 ce0008        	ldw	x,_UU_AVT
6993  1377 1d000a        	subw	x,#10
6994  137a b36d          	cpw	x,_Un
6995  137c 2d09          	jrsle	L1223
6998  137e be1f          	ldw	x,_volum_u_main_
6999  1380 1c0005        	addw	x,#5
7000  1383 bf1f          	ldw	_volum_u_main_,x
7002  1385 2036          	jra	L3223
7003  1387               L1223:
7004                     ; 1408 	else if(Un<(UU_AVT-1))volum_u_main_++;
7006  1387 9c            	rvf
7007  1388 ce0008        	ldw	x,_UU_AVT
7008  138b 5a            	decw	x
7009  138c b36d          	cpw	x,_Un
7010  138e 2d09          	jrsle	L5223
7013  1390 be1f          	ldw	x,_volum_u_main_
7014  1392 1c0001        	addw	x,#1
7015  1395 bf1f          	ldw	_volum_u_main_,x
7017  1397 2024          	jra	L3223
7018  1399               L5223:
7019                     ; 1409 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7021  1399 9c            	rvf
7022  139a ce0008        	ldw	x,_UU_AVT
7023  139d 1c000a        	addw	x,#10
7024  13a0 b36d          	cpw	x,_Un
7025  13a2 2e09          	jrsge	L1323
7028  13a4 be1f          	ldw	x,_volum_u_main_
7029  13a6 1d000a        	subw	x,#10
7030  13a9 bf1f          	ldw	_volum_u_main_,x
7032  13ab 2010          	jra	L3223
7033  13ad               L1323:
7034                     ; 1410 	else if(Un>(UU_AVT+1))volum_u_main_--;
7036  13ad 9c            	rvf
7037  13ae ce0008        	ldw	x,_UU_AVT
7038  13b1 5c            	incw	x
7039  13b2 b36d          	cpw	x,_Un
7040  13b4 2e07          	jrsge	L3223
7043  13b6 be1f          	ldw	x,_volum_u_main_
7044  13b8 1d0001        	subw	x,#1
7045  13bb bf1f          	ldw	_volum_u_main_,x
7046  13bd               L3223:
7047                     ; 1411 	if(volum_u_main_>1020)volum_u_main_=1020;
7049  13bd 9c            	rvf
7050  13be be1f          	ldw	x,_volum_u_main_
7051  13c0 a303fd        	cpw	x,#1021
7052  13c3 2f05          	jrslt	L7323
7055  13c5 ae03fc        	ldw	x,#1020
7056  13c8 bf1f          	ldw	_volum_u_main_,x
7057  13ca               L7323:
7058                     ; 1412 	if(volum_u_main_<0)volum_u_main_=0;
7060  13ca 9c            	rvf
7061  13cb be1f          	ldw	x,_volum_u_main_
7062  13cd 2e03          	jrsge	L1423
7065  13cf 5f            	clrw	x
7066  13d0 bf1f          	ldw	_volum_u_main_,x
7067  13d2               L1423:
7068                     ; 1415 	i_main_sigma=0;
7070  13d2 5f            	clrw	x
7071  13d3 bf0f          	ldw	_i_main_sigma,x
7072                     ; 1416 	i_main_num_of_bps=0;
7074  13d5 3f11          	clr	_i_main_num_of_bps
7075                     ; 1417 	for(i=0;i<6;i++)
7077  13d7 0f01          	clr	(OFST+0,sp)
7078  13d9               L3423:
7079                     ; 1419 		if(i_main_flag[i])
7081  13d9 7b01          	ld	a,(OFST+0,sp)
7082  13db 5f            	clrw	x
7083  13dc 97            	ld	xl,a
7084  13dd 6d14          	tnz	(_i_main_flag,x)
7085  13df 2719          	jreq	L1523
7086                     ; 1421 			i_main_sigma+=i_main[i];
7088  13e1 7b01          	ld	a,(OFST+0,sp)
7089  13e3 5f            	clrw	x
7090  13e4 97            	ld	xl,a
7091  13e5 58            	sllw	x
7092  13e6 ee1a          	ldw	x,(_i_main,x)
7093  13e8 72bb000f      	addw	x,_i_main_sigma
7094  13ec bf0f          	ldw	_i_main_sigma,x
7095                     ; 1422 			i_main_flag[i]=1;
7097  13ee 7b01          	ld	a,(OFST+0,sp)
7098  13f0 5f            	clrw	x
7099  13f1 97            	ld	xl,a
7100  13f2 a601          	ld	a,#1
7101  13f4 e714          	ld	(_i_main_flag,x),a
7102                     ; 1423 			i_main_num_of_bps++;
7104  13f6 3c11          	inc	_i_main_num_of_bps
7106  13f8 2006          	jra	L3523
7107  13fa               L1523:
7108                     ; 1427 			i_main_flag[i]=0;	
7110  13fa 7b01          	ld	a,(OFST+0,sp)
7111  13fc 5f            	clrw	x
7112  13fd 97            	ld	xl,a
7113  13fe 6f14          	clr	(_i_main_flag,x)
7114  1400               L3523:
7115                     ; 1417 	for(i=0;i<6;i++)
7117  1400 0c01          	inc	(OFST+0,sp)
7120  1402 7b01          	ld	a,(OFST+0,sp)
7121  1404 a106          	cp	a,#6
7122  1406 25d1          	jrult	L3423
7123                     ; 1430 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7125  1408 be0f          	ldw	x,_i_main_sigma
7126  140a b611          	ld	a,_i_main_num_of_bps
7127  140c 905f          	clrw	y
7128  140e 9097          	ld	yl,a
7129  1410 cd0000        	call	c_idiv
7131  1413 bf12          	ldw	_i_main_avg,x
7132                     ; 1431 	for(i=0;i<6;i++)
7134  1415 0f01          	clr	(OFST+0,sp)
7135  1417               L5523:
7136                     ; 1433 		if(i_main_flag[i])
7138  1417 7b01          	ld	a,(OFST+0,sp)
7139  1419 5f            	clrw	x
7140  141a 97            	ld	xl,a
7141  141b 6d14          	tnz	(_i_main_flag,x)
7142  141d 2603cc14ae    	jreq	L3623
7143                     ; 1435 			if(i_main[i]<(i_main_avg-10))x[i]++;
7145  1422 9c            	rvf
7146  1423 7b01          	ld	a,(OFST+0,sp)
7147  1425 5f            	clrw	x
7148  1426 97            	ld	xl,a
7149  1427 58            	sllw	x
7150  1428 90be12        	ldw	y,_i_main_avg
7151  142b 72a2000a      	subw	y,#10
7152  142f 90bf00        	ldw	c_y,y
7153  1432 9093          	ldw	y,x
7154  1434 90ee1a        	ldw	y,(_i_main,y)
7155  1437 90b300        	cpw	y,c_y
7156  143a 2e11          	jrsge	L5623
7159  143c 7b01          	ld	a,(OFST+0,sp)
7160  143e 5f            	clrw	x
7161  143f 97            	ld	xl,a
7162  1440 58            	sllw	x
7163  1441 9093          	ldw	y,x
7164  1443 ee26          	ldw	x,(_x,x)
7165  1445 1c0001        	addw	x,#1
7166  1448 90ef26        	ldw	(_x,y),x
7168  144b 2029          	jra	L7623
7169  144d               L5623:
7170                     ; 1436 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7172  144d 9c            	rvf
7173  144e 7b01          	ld	a,(OFST+0,sp)
7174  1450 5f            	clrw	x
7175  1451 97            	ld	xl,a
7176  1452 58            	sllw	x
7177  1453 90be12        	ldw	y,_i_main_avg
7178  1456 72a9000a      	addw	y,#10
7179  145a 90bf00        	ldw	c_y,y
7180  145d 9093          	ldw	y,x
7181  145f 90ee1a        	ldw	y,(_i_main,y)
7182  1462 90b300        	cpw	y,c_y
7183  1465 2d0f          	jrsle	L7623
7186  1467 7b01          	ld	a,(OFST+0,sp)
7187  1469 5f            	clrw	x
7188  146a 97            	ld	xl,a
7189  146b 58            	sllw	x
7190  146c 9093          	ldw	y,x
7191  146e ee26          	ldw	x,(_x,x)
7192  1470 1d0001        	subw	x,#1
7193  1473 90ef26        	ldw	(_x,y),x
7194  1476               L7623:
7195                     ; 1437 			if(x[i]>100)x[i]=100;
7197  1476 9c            	rvf
7198  1477 7b01          	ld	a,(OFST+0,sp)
7199  1479 5f            	clrw	x
7200  147a 97            	ld	xl,a
7201  147b 58            	sllw	x
7202  147c 9093          	ldw	y,x
7203  147e 90ee26        	ldw	y,(_x,y)
7204  1481 90a30065      	cpw	y,#101
7205  1485 2f0b          	jrslt	L3723
7208  1487 7b01          	ld	a,(OFST+0,sp)
7209  1489 5f            	clrw	x
7210  148a 97            	ld	xl,a
7211  148b 58            	sllw	x
7212  148c 90ae0064      	ldw	y,#100
7213  1490 ef26          	ldw	(_x,x),y
7214  1492               L3723:
7215                     ; 1438 			if(x[i]<-100)x[i]=-100;
7217  1492 9c            	rvf
7218  1493 7b01          	ld	a,(OFST+0,sp)
7219  1495 5f            	clrw	x
7220  1496 97            	ld	xl,a
7221  1497 58            	sllw	x
7222  1498 9093          	ldw	y,x
7223  149a 90ee26        	ldw	y,(_x,y)
7224  149d 90a3ff9c      	cpw	y,#65436
7225  14a1 2e0b          	jrsge	L3623
7228  14a3 7b01          	ld	a,(OFST+0,sp)
7229  14a5 5f            	clrw	x
7230  14a6 97            	ld	xl,a
7231  14a7 58            	sllw	x
7232  14a8 90aeff9c      	ldw	y,#65436
7233  14ac ef26          	ldw	(_x,x),y
7234  14ae               L3623:
7235                     ; 1431 	for(i=0;i<6;i++)
7237  14ae 0c01          	inc	(OFST+0,sp)
7240  14b0 7b01          	ld	a,(OFST+0,sp)
7241  14b2 a106          	cp	a,#6
7242  14b4 2403cc1417    	jrult	L5523
7243  14b9               L7123:
7244                     ; 1445 }
7247  14b9 84            	pop	a
7248  14ba 81            	ret
7271                     ; 1448 void init_CAN(void) {
7272                     	switch	.text
7273  14bb               _init_CAN:
7277                     ; 1449 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7279  14bb 72135420      	bres	21536,#1
7280                     ; 1450 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7282  14bf 72105420      	bset	21536,#0
7284  14c3               L1133:
7285                     ; 1451 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7287  14c3 c65421        	ld	a,21537
7288  14c6 a501          	bcp	a,#1
7289  14c8 27f9          	jreq	L1133
7290                     ; 1453 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7292  14ca 72185420      	bset	21536,#4
7293                     ; 1455 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7295  14ce 35025427      	mov	21543,#2
7296                     ; 1464 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7298  14d2 35135428      	mov	21544,#19
7299                     ; 1465 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7301  14d6 35c05429      	mov	21545,#192
7302                     ; 1466 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7304  14da 357f542c      	mov	21548,#127
7305                     ; 1467 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7307  14de 35e0542d      	mov	21549,#224
7308                     ; 1469 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7310  14e2 35315430      	mov	21552,#49
7311                     ; 1470 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7313  14e6 35c05431      	mov	21553,#192
7314                     ; 1471 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7316  14ea 357f5434      	mov	21556,#127
7317                     ; 1472 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7319  14ee 35e05435      	mov	21557,#224
7320                     ; 1476 	CAN->PSR= 6;									// set page 6
7322  14f2 35065427      	mov	21543,#6
7323                     ; 1481 	CAN->Page.Config.FMR1&=~3;								//mask mode
7325  14f6 c65430        	ld	a,21552
7326  14f9 a4fc          	and	a,#252
7327  14fb c75430        	ld	21552,a
7328                     ; 1487 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7330  14fe 35065432      	mov	21554,#6
7331                     ; 1488 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7333  1502 35605432      	mov	21554,#96
7334                     ; 1491 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7336  1506 72105432      	bset	21554,#0
7337                     ; 1492 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7339  150a 72185432      	bset	21554,#4
7340                     ; 1495 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7342  150e 35065427      	mov	21543,#6
7343                     ; 1497 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7345  1512 3509542c      	mov	21548,#9
7346                     ; 1498 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7348  1516 35e7542d      	mov	21549,#231
7349                     ; 1500 	CAN->IER|=(1<<1);
7351  151a 72125425      	bset	21541,#1
7352                     ; 1503 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7354  151e 72115420      	bres	21536,#0
7356  1522               L7133:
7357                     ; 1504 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7359  1522 c65421        	ld	a,21537
7360  1525 a501          	bcp	a,#1
7361  1527 26f9          	jrne	L7133
7362                     ; 1505 }
7365  1529 81            	ret
7473                     ; 1508 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7473                     ; 1509 {
7474                     	switch	.text
7475  152a               _can_transmit:
7477  152a 89            	pushw	x
7478       00000000      OFST:	set	0
7481                     ; 1511 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7483  152b b674          	ld	a,_can_buff_wr_ptr
7484  152d a104          	cp	a,#4
7485  152f 2502          	jrult	L1043
7488  1531 3f74          	clr	_can_buff_wr_ptr
7489  1533               L1043:
7490                     ; 1513 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7492  1533 b674          	ld	a,_can_buff_wr_ptr
7493  1535 97            	ld	xl,a
7494  1536 a610          	ld	a,#16
7495  1538 42            	mul	x,a
7496  1539 1601          	ldw	y,(OFST+1,sp)
7497  153b a606          	ld	a,#6
7498  153d               L441:
7499  153d 9054          	srlw	y
7500  153f 4a            	dec	a
7501  1540 26fb          	jrne	L441
7502  1542 909f          	ld	a,yl
7503  1544 e775          	ld	(_can_out_buff,x),a
7504                     ; 1514 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7506  1546 b674          	ld	a,_can_buff_wr_ptr
7507  1548 97            	ld	xl,a
7508  1549 a610          	ld	a,#16
7509  154b 42            	mul	x,a
7510  154c 7b02          	ld	a,(OFST+2,sp)
7511  154e 48            	sll	a
7512  154f 48            	sll	a
7513  1550 e776          	ld	(_can_out_buff+1,x),a
7514                     ; 1516 can_out_buff[can_buff_wr_ptr][2]=data0;
7516  1552 b674          	ld	a,_can_buff_wr_ptr
7517  1554 97            	ld	xl,a
7518  1555 a610          	ld	a,#16
7519  1557 42            	mul	x,a
7520  1558 7b05          	ld	a,(OFST+5,sp)
7521  155a e777          	ld	(_can_out_buff+2,x),a
7522                     ; 1517 can_out_buff[can_buff_wr_ptr][3]=data1;
7524  155c b674          	ld	a,_can_buff_wr_ptr
7525  155e 97            	ld	xl,a
7526  155f a610          	ld	a,#16
7527  1561 42            	mul	x,a
7528  1562 7b06          	ld	a,(OFST+6,sp)
7529  1564 e778          	ld	(_can_out_buff+3,x),a
7530                     ; 1518 can_out_buff[can_buff_wr_ptr][4]=data2;
7532  1566 b674          	ld	a,_can_buff_wr_ptr
7533  1568 97            	ld	xl,a
7534  1569 a610          	ld	a,#16
7535  156b 42            	mul	x,a
7536  156c 7b07          	ld	a,(OFST+7,sp)
7537  156e e779          	ld	(_can_out_buff+4,x),a
7538                     ; 1519 can_out_buff[can_buff_wr_ptr][5]=data3;
7540  1570 b674          	ld	a,_can_buff_wr_ptr
7541  1572 97            	ld	xl,a
7542  1573 a610          	ld	a,#16
7543  1575 42            	mul	x,a
7544  1576 7b08          	ld	a,(OFST+8,sp)
7545  1578 e77a          	ld	(_can_out_buff+5,x),a
7546                     ; 1520 can_out_buff[can_buff_wr_ptr][6]=data4;
7548  157a b674          	ld	a,_can_buff_wr_ptr
7549  157c 97            	ld	xl,a
7550  157d a610          	ld	a,#16
7551  157f 42            	mul	x,a
7552  1580 7b09          	ld	a,(OFST+9,sp)
7553  1582 e77b          	ld	(_can_out_buff+6,x),a
7554                     ; 1521 can_out_buff[can_buff_wr_ptr][7]=data5;
7556  1584 b674          	ld	a,_can_buff_wr_ptr
7557  1586 97            	ld	xl,a
7558  1587 a610          	ld	a,#16
7559  1589 42            	mul	x,a
7560  158a 7b0a          	ld	a,(OFST+10,sp)
7561  158c e77c          	ld	(_can_out_buff+7,x),a
7562                     ; 1522 can_out_buff[can_buff_wr_ptr][8]=data6;
7564  158e b674          	ld	a,_can_buff_wr_ptr
7565  1590 97            	ld	xl,a
7566  1591 a610          	ld	a,#16
7567  1593 42            	mul	x,a
7568  1594 7b0b          	ld	a,(OFST+11,sp)
7569  1596 e77d          	ld	(_can_out_buff+8,x),a
7570                     ; 1523 can_out_buff[can_buff_wr_ptr][9]=data7;
7572  1598 b674          	ld	a,_can_buff_wr_ptr
7573  159a 97            	ld	xl,a
7574  159b a610          	ld	a,#16
7575  159d 42            	mul	x,a
7576  159e 7b0c          	ld	a,(OFST+12,sp)
7577  15a0 e77e          	ld	(_can_out_buff+9,x),a
7578                     ; 1525 can_buff_wr_ptr++;
7580  15a2 3c74          	inc	_can_buff_wr_ptr
7581                     ; 1526 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7583  15a4 b674          	ld	a,_can_buff_wr_ptr
7584  15a6 a104          	cp	a,#4
7585  15a8 2502          	jrult	L3043
7588  15aa 3f74          	clr	_can_buff_wr_ptr
7589  15ac               L3043:
7590                     ; 1527 } 
7593  15ac 85            	popw	x
7594  15ad 81            	ret
7623                     ; 1530 void can_tx_hndl(void)
7623                     ; 1531 {
7624                     	switch	.text
7625  15ae               _can_tx_hndl:
7629                     ; 1532 if(bTX_FREE)
7631  15ae 3d09          	tnz	_bTX_FREE
7632  15b0 2757          	jreq	L5143
7633                     ; 1534 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7635  15b2 b673          	ld	a,_can_buff_rd_ptr
7636  15b4 b174          	cp	a,_can_buff_wr_ptr
7637  15b6 275f          	jreq	L3243
7638                     ; 1536 		bTX_FREE=0;
7640  15b8 3f09          	clr	_bTX_FREE
7641                     ; 1538 		CAN->PSR= 0;
7643  15ba 725f5427      	clr	21543
7644                     ; 1539 		CAN->Page.TxMailbox.MDLCR=8;
7646  15be 35085429      	mov	21545,#8
7647                     ; 1540 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7649  15c2 b673          	ld	a,_can_buff_rd_ptr
7650  15c4 97            	ld	xl,a
7651  15c5 a610          	ld	a,#16
7652  15c7 42            	mul	x,a
7653  15c8 e675          	ld	a,(_can_out_buff,x)
7654  15ca c7542a        	ld	21546,a
7655                     ; 1541 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7657  15cd b673          	ld	a,_can_buff_rd_ptr
7658  15cf 97            	ld	xl,a
7659  15d0 a610          	ld	a,#16
7660  15d2 42            	mul	x,a
7661  15d3 e676          	ld	a,(_can_out_buff+1,x)
7662  15d5 c7542b        	ld	21547,a
7663                     ; 1543 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7665  15d8 b673          	ld	a,_can_buff_rd_ptr
7666  15da 97            	ld	xl,a
7667  15db a610          	ld	a,#16
7668  15dd 42            	mul	x,a
7669  15de 01            	rrwa	x,a
7670  15df ab77          	add	a,#_can_out_buff+2
7671  15e1 2401          	jrnc	L051
7672  15e3 5c            	incw	x
7673  15e4               L051:
7674  15e4 5f            	clrw	x
7675  15e5 97            	ld	xl,a
7676  15e6 bf00          	ldw	c_x,x
7677  15e8 ae0008        	ldw	x,#8
7678  15eb               L251:
7679  15eb 5a            	decw	x
7680  15ec 92d600        	ld	a,([c_x],x)
7681  15ef d7542e        	ld	(21550,x),a
7682  15f2 5d            	tnzw	x
7683  15f3 26f6          	jrne	L251
7684                     ; 1545 		can_buff_rd_ptr++;
7686  15f5 3c73          	inc	_can_buff_rd_ptr
7687                     ; 1546 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7689  15f7 b673          	ld	a,_can_buff_rd_ptr
7690  15f9 a104          	cp	a,#4
7691  15fb 2502          	jrult	L1243
7694  15fd 3f73          	clr	_can_buff_rd_ptr
7695  15ff               L1243:
7696                     ; 1548 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7698  15ff 72105428      	bset	21544,#0
7699                     ; 1549 		CAN->IER|=(1<<0);
7701  1603 72105425      	bset	21541,#0
7702  1607 200e          	jra	L3243
7703  1609               L5143:
7704                     ; 1554 	tx_busy_cnt++;
7706  1609 3c72          	inc	_tx_busy_cnt
7707                     ; 1555 	if(tx_busy_cnt>=100)
7709  160b b672          	ld	a,_tx_busy_cnt
7710  160d a164          	cp	a,#100
7711  160f 2506          	jrult	L3243
7712                     ; 1557 		tx_busy_cnt=0;
7714  1611 3f72          	clr	_tx_busy_cnt
7715                     ; 1558 		bTX_FREE=1;
7717  1613 35010009      	mov	_bTX_FREE,#1
7718  1617               L3243:
7719                     ; 1561 }
7722  1617 81            	ret
7761                     ; 1564 void net_drv(void)
7761                     ; 1565 { 
7762                     	switch	.text
7763  1618               _net_drv:
7767                     ; 1567 if(bMAIN)
7769                     	btst	_bMAIN
7770  161d 2503          	jrult	L651
7771  161f cc16c5        	jp	L7343
7772  1622               L651:
7773                     ; 1569 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7775  1622 3c32          	inc	_cnt_net_drv
7776  1624 b632          	ld	a,_cnt_net_drv
7777  1626 a107          	cp	a,#7
7778  1628 2502          	jrult	L1443
7781  162a 3f32          	clr	_cnt_net_drv
7782  162c               L1443:
7783                     ; 1571 	if(cnt_net_drv<=5) 
7785  162c b632          	ld	a,_cnt_net_drv
7786  162e a106          	cp	a,#6
7787  1630 244c          	jruge	L3443
7788                     ; 1573 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7790  1632 4be8          	push	#232
7791  1634 4be8          	push	#232
7792  1636 b632          	ld	a,_cnt_net_drv
7793  1638 5f            	clrw	x
7794  1639 97            	ld	xl,a
7795  163a 58            	sllw	x
7796  163b ee26          	ldw	x,(_x,x)
7797  163d 72bb001f      	addw	x,_volum_u_main_
7798  1641 90ae0100      	ldw	y,#256
7799  1645 cd0000        	call	c_idiv
7801  1648 9f            	ld	a,xl
7802  1649 88            	push	a
7803  164a b632          	ld	a,_cnt_net_drv
7804  164c 5f            	clrw	x
7805  164d 97            	ld	xl,a
7806  164e 58            	sllw	x
7807  164f e627          	ld	a,(_x+1,x)
7808  1651 bb20          	add	a,_volum_u_main_+1
7809  1653 88            	push	a
7810  1654 4b00          	push	#0
7811  1656 4bed          	push	#237
7812  1658 3b0032        	push	_cnt_net_drv
7813  165b 3b0032        	push	_cnt_net_drv
7814  165e ae009e        	ldw	x,#158
7815  1661 cd152a        	call	_can_transmit
7817  1664 5b08          	addw	sp,#8
7818                     ; 1574 		i_main_bps_cnt[cnt_net_drv]++;
7820  1666 b632          	ld	a,_cnt_net_drv
7821  1668 5f            	clrw	x
7822  1669 97            	ld	xl,a
7823  166a 6c09          	inc	(_i_main_bps_cnt,x)
7824                     ; 1575 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7826  166c b632          	ld	a,_cnt_net_drv
7827  166e 5f            	clrw	x
7828  166f 97            	ld	xl,a
7829  1670 e609          	ld	a,(_i_main_bps_cnt,x)
7830  1672 a10b          	cp	a,#11
7831  1674 254f          	jrult	L7343
7834  1676 b632          	ld	a,_cnt_net_drv
7835  1678 5f            	clrw	x
7836  1679 97            	ld	xl,a
7837  167a 6f14          	clr	(_i_main_flag,x)
7838  167c 2047          	jra	L7343
7839  167e               L3443:
7840                     ; 1577 	else if(cnt_net_drv==6)
7842  167e b632          	ld	a,_cnt_net_drv
7843  1680 a106          	cp	a,#6
7844  1682 2641          	jrne	L7343
7845                     ; 1579 		plazma_int[2]=pwm_u;
7847  1684 be0e          	ldw	x,_pwm_u
7848  1686 bf37          	ldw	_plazma_int+4,x
7849                     ; 1580 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7851  1688 3b006b        	push	_Ui
7852  168b 3b006c        	push	_Ui+1
7853  168e 3b006d        	push	_Un
7854  1691 3b006e        	push	_Un+1
7855  1694 3b006f        	push	_I
7856  1697 3b0070        	push	_I+1
7857  169a 4bda          	push	#218
7858  169c 3b0005        	push	_adress
7859  169f ae018e        	ldw	x,#398
7860  16a2 cd152a        	call	_can_transmit
7862  16a5 5b08          	addw	sp,#8
7863                     ; 1581 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7865  16a7 3b0037        	push	_plazma_int+4
7866  16aa 3b0038        	push	_plazma_int+5
7867  16ad 3b005f        	push	__x_+1
7868  16b0 3b000b        	push	_flags
7869  16b3 4b00          	push	#0
7870  16b5 3b0068        	push	_T
7871  16b8 4bdb          	push	#219
7872  16ba 3b0005        	push	_adress
7873  16bd ae018e        	ldw	x,#398
7874  16c0 cd152a        	call	_can_transmit
7876  16c3 5b08          	addw	sp,#8
7877  16c5               L7343:
7878                     ; 1584 }
7881  16c5 81            	ret
7995                     ; 1587 void can_in_an(void)
7995                     ; 1588 {
7996                     	switch	.text
7997  16c6               _can_in_an:
7999  16c6 5205          	subw	sp,#5
8000       00000005      OFST:	set	5
8003                     ; 1598 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8005  16c8 b6ca          	ld	a,_mess+6
8006  16ca c10005        	cp	a,_adress
8007  16cd 2703          	jreq	L002
8008  16cf cc17eb        	jp	L7053
8009  16d2               L002:
8011  16d2 b6cb          	ld	a,_mess+7
8012  16d4 c10005        	cp	a,_adress
8013  16d7 2703          	jreq	L202
8014  16d9 cc17eb        	jp	L7053
8015  16dc               L202:
8017  16dc b6cc          	ld	a,_mess+8
8018  16de a1ed          	cp	a,#237
8019  16e0 2703          	jreq	L402
8020  16e2 cc17eb        	jp	L7053
8021  16e5               L402:
8022                     ; 1601 	can_error_cnt=0;
8024  16e5 3f71          	clr	_can_error_cnt
8025                     ; 1603 	bMAIN=0;
8027  16e7 72110001      	bres	_bMAIN
8028                     ; 1604  	flags_tu=mess[9];
8030  16eb 45cd60        	mov	_flags_tu,_mess+9
8031                     ; 1605  	if(flags_tu&0b00000001)
8033  16ee b660          	ld	a,_flags_tu
8034  16f0 a501          	bcp	a,#1
8035  16f2 2706          	jreq	L1153
8036                     ; 1610  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8038  16f4 721a000b      	bset	_flags,#5
8040  16f8 200e          	jra	L3153
8041  16fa               L1153:
8042                     ; 1621  				flags&=0b11011111; 
8044  16fa 721b000b      	bres	_flags,#5
8045                     ; 1622  				off_bp_cnt=5*ee_TZAS;
8047  16fe c60017        	ld	a,_ee_TZAS+1
8048  1701 97            	ld	xl,a
8049  1702 a605          	ld	a,#5
8050  1704 42            	mul	x,a
8051  1705 9f            	ld	a,xl
8052  1706 b753          	ld	_off_bp_cnt,a
8053  1708               L3153:
8054                     ; 1628  	if(flags_tu&0b00000010) flags|=0b01000000;
8056  1708 b660          	ld	a,_flags_tu
8057  170a a502          	bcp	a,#2
8058  170c 2706          	jreq	L5153
8061  170e 721c000b      	bset	_flags,#6
8063  1712 2004          	jra	L7153
8064  1714               L5153:
8065                     ; 1629  	else flags&=0b10111111; 
8067  1714 721d000b      	bres	_flags,#6
8068  1718               L7153:
8069                     ; 1631  	vol_u_temp=mess[10]+mess[11]*256;
8071  1718 b6cf          	ld	a,_mess+11
8072  171a 5f            	clrw	x
8073  171b 97            	ld	xl,a
8074  171c 4f            	clr	a
8075  171d 02            	rlwa	x,a
8076  171e 01            	rrwa	x,a
8077  171f bbce          	add	a,_mess+10
8078  1721 2401          	jrnc	L261
8079  1723 5c            	incw	x
8080  1724               L261:
8081  1724 b759          	ld	_vol_u_temp+1,a
8082  1726 9f            	ld	a,xl
8083  1727 b758          	ld	_vol_u_temp,a
8084                     ; 1632  	vol_i_temp=mess[12]+mess[13]*256;  
8086  1729 b6d1          	ld	a,_mess+13
8087  172b 5f            	clrw	x
8088  172c 97            	ld	xl,a
8089  172d 4f            	clr	a
8090  172e 02            	rlwa	x,a
8091  172f 01            	rrwa	x,a
8092  1730 bbd0          	add	a,_mess+12
8093  1732 2401          	jrnc	L461
8094  1734 5c            	incw	x
8095  1735               L461:
8096  1735 b757          	ld	_vol_i_temp+1,a
8097  1737 9f            	ld	a,xl
8098  1738 b756          	ld	_vol_i_temp,a
8099                     ; 1641 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8101  173a b601          	ld	a,_vent_resurs_tx_cnt
8102  173c a102          	cp	a,#2
8103  173e 2507          	jrult	L1253
8106  1740 ce0000        	ldw	x,_vent_resurs
8107  1743 bf37          	ldw	_plazma_int+4,x
8109  1745 2004          	jra	L3253
8110  1747               L1253:
8111                     ; 1642 	else plazma_int[2]=vent_resurs_sec_cnt;
8113  1747 be02          	ldw	x,_vent_resurs_sec_cnt
8114  1749 bf37          	ldw	_plazma_int+4,x
8115  174b               L3253:
8116                     ; 1643  	rotor_int=flags_tu+(((short)flags)<<8);
8118  174b b60b          	ld	a,_flags
8119  174d 5f            	clrw	x
8120  174e 97            	ld	xl,a
8121  174f 4f            	clr	a
8122  1750 02            	rlwa	x,a
8123  1751 01            	rrwa	x,a
8124  1752 bb60          	add	a,_flags_tu
8125  1754 2401          	jrnc	L661
8126  1756 5c            	incw	x
8127  1757               L661:
8128  1757 b71e          	ld	_rotor_int+1,a
8129  1759 9f            	ld	a,xl
8130  175a b71d          	ld	_rotor_int,a
8131                     ; 1644 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8133  175c 3b006b        	push	_Ui
8134  175f 3b006c        	push	_Ui+1
8135  1762 3b006d        	push	_Un
8136  1765 3b006e        	push	_Un+1
8137  1768 3b006f        	push	_I
8138  176b 3b0070        	push	_I+1
8139  176e 4bda          	push	#218
8140  1770 3b0005        	push	_adress
8141  1773 ae018e        	ldw	x,#398
8142  1776 cd152a        	call	_can_transmit
8144  1779 5b08          	addw	sp,#8
8145                     ; 1645 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8147  177b 3b0037        	push	_plazma_int+4
8148  177e 3b0038        	push	_plazma_int+5
8149  1781 3b005f        	push	__x_+1
8150  1784 3b000b        	push	_flags
8151  1787 b601          	ld	a,_vent_resurs_tx_cnt
8152  1789 5f            	clrw	x
8153  178a 97            	ld	xl,a
8154  178b d60000        	ld	a,(_vent_resurs_buff,x)
8155  178e 88            	push	a
8156  178f 3b0068        	push	_T
8157  1792 4bdb          	push	#219
8158  1794 3b0005        	push	_adress
8159  1797 ae018e        	ldw	x,#398
8160  179a cd152a        	call	_can_transmit
8162  179d 5b08          	addw	sp,#8
8163                     ; 1646      link_cnt=0;
8165  179f 5f            	clrw	x
8166  17a0 bf61          	ldw	_link_cnt,x
8167                     ; 1647      link=ON;
8169  17a2 35550063      	mov	_link,#85
8170                     ; 1649      if(flags_tu&0b10000000)
8172  17a6 b660          	ld	a,_flags_tu
8173  17a8 a580          	bcp	a,#128
8174  17aa 2716          	jreq	L5253
8175                     ; 1651      	if(!res_fl)
8177  17ac 725d000b      	tnz	_res_fl
8178  17b0 2625          	jrne	L1353
8179                     ; 1653      		res_fl=1;
8181  17b2 a601          	ld	a,#1
8182  17b4 ae000b        	ldw	x,#_res_fl
8183  17b7 cd0000        	call	c_eewrc
8185                     ; 1654      		bRES=1;
8187  17ba 35010012      	mov	_bRES,#1
8188                     ; 1655      		res_fl_cnt=0;
8190  17be 3f41          	clr	_res_fl_cnt
8191  17c0 2015          	jra	L1353
8192  17c2               L5253:
8193                     ; 1660      	if(main_cnt>20)
8195  17c2 9c            	rvf
8196  17c3 be51          	ldw	x,_main_cnt
8197  17c5 a30015        	cpw	x,#21
8198  17c8 2f0d          	jrslt	L1353
8199                     ; 1662     			if(res_fl)
8201  17ca 725d000b      	tnz	_res_fl
8202  17ce 2707          	jreq	L1353
8203                     ; 1664      			res_fl=0;
8205  17d0 4f            	clr	a
8206  17d1 ae000b        	ldw	x,#_res_fl
8207  17d4 cd0000        	call	c_eewrc
8209  17d7               L1353:
8210                     ; 1669       if(res_fl_)
8212  17d7 725d000a      	tnz	_res_fl_
8213  17db 2603          	jrne	L602
8214  17dd cc1d36        	jp	L3543
8215  17e0               L602:
8216                     ; 1671       	res_fl_=0;
8218  17e0 4f            	clr	a
8219  17e1 ae000a        	ldw	x,#_res_fl_
8220  17e4 cd0000        	call	c_eewrc
8222  17e7 ac361d36      	jpf	L3543
8223  17eb               L7053:
8224                     ; 1674 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8226  17eb b6ca          	ld	a,_mess+6
8227  17ed c10005        	cp	a,_adress
8228  17f0 2703          	jreq	L012
8229  17f2 cc1a02        	jp	L3453
8230  17f5               L012:
8232  17f5 b6cb          	ld	a,_mess+7
8233  17f7 c10005        	cp	a,_adress
8234  17fa 2703          	jreq	L212
8235  17fc cc1a02        	jp	L3453
8236  17ff               L212:
8238  17ff b6cc          	ld	a,_mess+8
8239  1801 a1ee          	cp	a,#238
8240  1803 2703          	jreq	L412
8241  1805 cc1a02        	jp	L3453
8242  1808               L412:
8244  1808 b6cd          	ld	a,_mess+9
8245  180a b1ce          	cp	a,_mess+10
8246  180c 2703          	jreq	L612
8247  180e cc1a02        	jp	L3453
8248  1811               L612:
8249                     ; 1676 	rotor_int++;
8251  1811 be1d          	ldw	x,_rotor_int
8252  1813 1c0001        	addw	x,#1
8253  1816 bf1d          	ldw	_rotor_int,x
8254                     ; 1677 	if((mess[9]&0xf0)==0x20)
8256  1818 b6cd          	ld	a,_mess+9
8257  181a a4f0          	and	a,#240
8258  181c a120          	cp	a,#32
8259  181e 2673          	jrne	L5453
8260                     ; 1679 		if((mess[9]&0x0f)==0x01)
8262  1820 b6cd          	ld	a,_mess+9
8263  1822 a40f          	and	a,#15
8264  1824 a101          	cp	a,#1
8265  1826 260d          	jrne	L7453
8266                     ; 1681 			ee_K[0][0]=adc_buff_[4];
8268  1828 ce0011        	ldw	x,_adc_buff_+8
8269  182b 89            	pushw	x
8270  182c ae001a        	ldw	x,#_ee_K
8271  182f cd0000        	call	c_eewrw
8273  1832 85            	popw	x
8275  1833 204a          	jra	L1553
8276  1835               L7453:
8277                     ; 1683 		else if((mess[9]&0x0f)==0x02)
8279  1835 b6cd          	ld	a,_mess+9
8280  1837 a40f          	and	a,#15
8281  1839 a102          	cp	a,#2
8282  183b 260b          	jrne	L3553
8283                     ; 1685 			ee_K[0][1]++;
8285  183d ce001c        	ldw	x,_ee_K+2
8286  1840 1c0001        	addw	x,#1
8287  1843 cf001c        	ldw	_ee_K+2,x
8289  1846 2037          	jra	L1553
8290  1848               L3553:
8291                     ; 1687 		else if((mess[9]&0x0f)==0x03)
8293  1848 b6cd          	ld	a,_mess+9
8294  184a a40f          	and	a,#15
8295  184c a103          	cp	a,#3
8296  184e 260b          	jrne	L7553
8297                     ; 1689 			ee_K[0][1]+=10;
8299  1850 ce001c        	ldw	x,_ee_K+2
8300  1853 1c000a        	addw	x,#10
8301  1856 cf001c        	ldw	_ee_K+2,x
8303  1859 2024          	jra	L1553
8304  185b               L7553:
8305                     ; 1691 		else if((mess[9]&0x0f)==0x04)
8307  185b b6cd          	ld	a,_mess+9
8308  185d a40f          	and	a,#15
8309  185f a104          	cp	a,#4
8310  1861 260b          	jrne	L3653
8311                     ; 1693 			ee_K[0][1]--;
8313  1863 ce001c        	ldw	x,_ee_K+2
8314  1866 1d0001        	subw	x,#1
8315  1869 cf001c        	ldw	_ee_K+2,x
8317  186c 2011          	jra	L1553
8318  186e               L3653:
8319                     ; 1695 		else if((mess[9]&0x0f)==0x05)
8321  186e b6cd          	ld	a,_mess+9
8322  1870 a40f          	and	a,#15
8323  1872 a105          	cp	a,#5
8324  1874 2609          	jrne	L1553
8325                     ; 1697 			ee_K[0][1]-=10;
8327  1876 ce001c        	ldw	x,_ee_K+2
8328  1879 1d000a        	subw	x,#10
8329  187c cf001c        	ldw	_ee_K+2,x
8330  187f               L1553:
8331                     ; 1699 		granee(&ee_K[0][1],50,3000);									
8333  187f ae0bb8        	ldw	x,#3000
8334  1882 89            	pushw	x
8335  1883 ae0032        	ldw	x,#50
8336  1886 89            	pushw	x
8337  1887 ae001c        	ldw	x,#_ee_K+2
8338  188a cd00f2        	call	_granee
8340  188d 5b04          	addw	sp,#4
8342  188f ace719e7      	jpf	L1753
8343  1893               L5453:
8344                     ; 1701 	else if((mess[9]&0xf0)==0x10)
8346  1893 b6cd          	ld	a,_mess+9
8347  1895 a4f0          	and	a,#240
8348  1897 a110          	cp	a,#16
8349  1899 2673          	jrne	L3753
8350                     ; 1703 		if((mess[9]&0x0f)==0x01)
8352  189b b6cd          	ld	a,_mess+9
8353  189d a40f          	and	a,#15
8354  189f a101          	cp	a,#1
8355  18a1 260d          	jrne	L5753
8356                     ; 1705 			ee_K[1][0]=adc_buff_[1];
8358  18a3 ce000b        	ldw	x,_adc_buff_+2
8359  18a6 89            	pushw	x
8360  18a7 ae001e        	ldw	x,#_ee_K+4
8361  18aa cd0000        	call	c_eewrw
8363  18ad 85            	popw	x
8365  18ae 204a          	jra	L7753
8366  18b0               L5753:
8367                     ; 1707 		else if((mess[9]&0x0f)==0x02)
8369  18b0 b6cd          	ld	a,_mess+9
8370  18b2 a40f          	and	a,#15
8371  18b4 a102          	cp	a,#2
8372  18b6 260b          	jrne	L1063
8373                     ; 1709 			ee_K[1][1]++;
8375  18b8 ce0020        	ldw	x,_ee_K+6
8376  18bb 1c0001        	addw	x,#1
8377  18be cf0020        	ldw	_ee_K+6,x
8379  18c1 2037          	jra	L7753
8380  18c3               L1063:
8381                     ; 1711 		else if((mess[9]&0x0f)==0x03)
8383  18c3 b6cd          	ld	a,_mess+9
8384  18c5 a40f          	and	a,#15
8385  18c7 a103          	cp	a,#3
8386  18c9 260b          	jrne	L5063
8387                     ; 1713 			ee_K[1][1]+=10;
8389  18cb ce0020        	ldw	x,_ee_K+6
8390  18ce 1c000a        	addw	x,#10
8391  18d1 cf0020        	ldw	_ee_K+6,x
8393  18d4 2024          	jra	L7753
8394  18d6               L5063:
8395                     ; 1715 		else if((mess[9]&0x0f)==0x04)
8397  18d6 b6cd          	ld	a,_mess+9
8398  18d8 a40f          	and	a,#15
8399  18da a104          	cp	a,#4
8400  18dc 260b          	jrne	L1163
8401                     ; 1717 			ee_K[1][1]--;
8403  18de ce0020        	ldw	x,_ee_K+6
8404  18e1 1d0001        	subw	x,#1
8405  18e4 cf0020        	ldw	_ee_K+6,x
8407  18e7 2011          	jra	L7753
8408  18e9               L1163:
8409                     ; 1719 		else if((mess[9]&0x0f)==0x05)
8411  18e9 b6cd          	ld	a,_mess+9
8412  18eb a40f          	and	a,#15
8413  18ed a105          	cp	a,#5
8414  18ef 2609          	jrne	L7753
8415                     ; 1721 			ee_K[1][1]-=10;
8417  18f1 ce0020        	ldw	x,_ee_K+6
8418  18f4 1d000a        	subw	x,#10
8419  18f7 cf0020        	ldw	_ee_K+6,x
8420  18fa               L7753:
8421                     ; 1726 		granee(&ee_K[1][1],10,30000);
8423  18fa ae7530        	ldw	x,#30000
8424  18fd 89            	pushw	x
8425  18fe ae000a        	ldw	x,#10
8426  1901 89            	pushw	x
8427  1902 ae0020        	ldw	x,#_ee_K+6
8428  1905 cd00f2        	call	_granee
8430  1908 5b04          	addw	sp,#4
8432  190a ace719e7      	jpf	L1753
8433  190e               L3753:
8434                     ; 1730 	else if((mess[9]&0xf0)==0x00)
8436  190e b6cd          	ld	a,_mess+9
8437  1910 a5f0          	bcp	a,#240
8438  1912 2671          	jrne	L1263
8439                     ; 1732 		if((mess[9]&0x0f)==0x01)
8441  1914 b6cd          	ld	a,_mess+9
8442  1916 a40f          	and	a,#15
8443  1918 a101          	cp	a,#1
8444  191a 260d          	jrne	L3263
8445                     ; 1734 			ee_K[2][0]=adc_buff_[2];
8447  191c ce000d        	ldw	x,_adc_buff_+4
8448  191f 89            	pushw	x
8449  1920 ae0022        	ldw	x,#_ee_K+8
8450  1923 cd0000        	call	c_eewrw
8452  1926 85            	popw	x
8454  1927 204a          	jra	L5263
8455  1929               L3263:
8456                     ; 1736 		else if((mess[9]&0x0f)==0x02)
8458  1929 b6cd          	ld	a,_mess+9
8459  192b a40f          	and	a,#15
8460  192d a102          	cp	a,#2
8461  192f 260b          	jrne	L7263
8462                     ; 1738 			ee_K[2][1]++;
8464  1931 ce0024        	ldw	x,_ee_K+10
8465  1934 1c0001        	addw	x,#1
8466  1937 cf0024        	ldw	_ee_K+10,x
8468  193a 2037          	jra	L5263
8469  193c               L7263:
8470                     ; 1740 		else if((mess[9]&0x0f)==0x03)
8472  193c b6cd          	ld	a,_mess+9
8473  193e a40f          	and	a,#15
8474  1940 a103          	cp	a,#3
8475  1942 260b          	jrne	L3363
8476                     ; 1742 			ee_K[2][1]+=10;
8478  1944 ce0024        	ldw	x,_ee_K+10
8479  1947 1c000a        	addw	x,#10
8480  194a cf0024        	ldw	_ee_K+10,x
8482  194d 2024          	jra	L5263
8483  194f               L3363:
8484                     ; 1744 		else if((mess[9]&0x0f)==0x04)
8486  194f b6cd          	ld	a,_mess+9
8487  1951 a40f          	and	a,#15
8488  1953 a104          	cp	a,#4
8489  1955 260b          	jrne	L7363
8490                     ; 1746 			ee_K[2][1]--;
8492  1957 ce0024        	ldw	x,_ee_K+10
8493  195a 1d0001        	subw	x,#1
8494  195d cf0024        	ldw	_ee_K+10,x
8496  1960 2011          	jra	L5263
8497  1962               L7363:
8498                     ; 1748 		else if((mess[9]&0x0f)==0x05)
8500  1962 b6cd          	ld	a,_mess+9
8501  1964 a40f          	and	a,#15
8502  1966 a105          	cp	a,#5
8503  1968 2609          	jrne	L5263
8504                     ; 1750 			ee_K[2][1]-=10;
8506  196a ce0024        	ldw	x,_ee_K+10
8507  196d 1d000a        	subw	x,#10
8508  1970 cf0024        	ldw	_ee_K+10,x
8509  1973               L5263:
8510                     ; 1755 		granee(&ee_K[2][1],10,30000);
8512  1973 ae7530        	ldw	x,#30000
8513  1976 89            	pushw	x
8514  1977 ae000a        	ldw	x,#10
8515  197a 89            	pushw	x
8516  197b ae0024        	ldw	x,#_ee_K+10
8517  197e cd00f2        	call	_granee
8519  1981 5b04          	addw	sp,#4
8521  1983 2062          	jra	L1753
8522  1985               L1263:
8523                     ; 1759 	else if((mess[9]&0xf0)==0x30)
8525  1985 b6cd          	ld	a,_mess+9
8526  1987 a4f0          	and	a,#240
8527  1989 a130          	cp	a,#48
8528  198b 265a          	jrne	L1753
8529                     ; 1761 		if((mess[9]&0x0f)==0x02)
8531  198d b6cd          	ld	a,_mess+9
8532  198f a40f          	and	a,#15
8533  1991 a102          	cp	a,#2
8534  1993 260b          	jrne	L1563
8535                     ; 1763 			ee_K[3][1]++;
8537  1995 ce0028        	ldw	x,_ee_K+14
8538  1998 1c0001        	addw	x,#1
8539  199b cf0028        	ldw	_ee_K+14,x
8541  199e 2037          	jra	L3563
8542  19a0               L1563:
8543                     ; 1765 		else if((mess[9]&0x0f)==0x03)
8545  19a0 b6cd          	ld	a,_mess+9
8546  19a2 a40f          	and	a,#15
8547  19a4 a103          	cp	a,#3
8548  19a6 260b          	jrne	L5563
8549                     ; 1767 			ee_K[3][1]+=10;
8551  19a8 ce0028        	ldw	x,_ee_K+14
8552  19ab 1c000a        	addw	x,#10
8553  19ae cf0028        	ldw	_ee_K+14,x
8555  19b1 2024          	jra	L3563
8556  19b3               L5563:
8557                     ; 1769 		else if((mess[9]&0x0f)==0x04)
8559  19b3 b6cd          	ld	a,_mess+9
8560  19b5 a40f          	and	a,#15
8561  19b7 a104          	cp	a,#4
8562  19b9 260b          	jrne	L1663
8563                     ; 1771 			ee_K[3][1]--;
8565  19bb ce0028        	ldw	x,_ee_K+14
8566  19be 1d0001        	subw	x,#1
8567  19c1 cf0028        	ldw	_ee_K+14,x
8569  19c4 2011          	jra	L3563
8570  19c6               L1663:
8571                     ; 1773 		else if((mess[9]&0x0f)==0x05)
8573  19c6 b6cd          	ld	a,_mess+9
8574  19c8 a40f          	and	a,#15
8575  19ca a105          	cp	a,#5
8576  19cc 2609          	jrne	L3563
8577                     ; 1775 			ee_K[3][1]-=10;
8579  19ce ce0028        	ldw	x,_ee_K+14
8580  19d1 1d000a        	subw	x,#10
8581  19d4 cf0028        	ldw	_ee_K+14,x
8582  19d7               L3563:
8583                     ; 1777 		granee(&ee_K[3][1],300,517);									
8585  19d7 ae0205        	ldw	x,#517
8586  19da 89            	pushw	x
8587  19db ae012c        	ldw	x,#300
8588  19de 89            	pushw	x
8589  19df ae0028        	ldw	x,#_ee_K+14
8590  19e2 cd00f2        	call	_granee
8592  19e5 5b04          	addw	sp,#4
8593  19e7               L1753:
8594                     ; 1780 	link_cnt=0;
8596  19e7 5f            	clrw	x
8597  19e8 bf61          	ldw	_link_cnt,x
8598                     ; 1781      link=ON;
8600  19ea 35550063      	mov	_link,#85
8601                     ; 1782      if(res_fl_)
8603  19ee 725d000a      	tnz	_res_fl_
8604  19f2 2603          	jrne	L022
8605  19f4 cc1d36        	jp	L3543
8606  19f7               L022:
8607                     ; 1784       	res_fl_=0;
8609  19f7 4f            	clr	a
8610  19f8 ae000a        	ldw	x,#_res_fl_
8611  19fb cd0000        	call	c_eewrc
8613  19fe ac361d36      	jpf	L3543
8614  1a02               L3453:
8615                     ; 1790 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==0x95))
8617  1a02 b6ca          	ld	a,_mess+6
8618  1a04 a1ff          	cp	a,#255
8619  1a06 2703          	jreq	L222
8620  1a08 cc1a96        	jp	L3763
8621  1a0b               L222:
8623  1a0b b6cb          	ld	a,_mess+7
8624  1a0d a1ff          	cp	a,#255
8625  1a0f 2703          	jreq	L422
8626  1a11 cc1a96        	jp	L3763
8627  1a14               L422:
8629  1a14 b6cc          	ld	a,_mess+8
8630  1a16 a195          	cp	a,#149
8631  1a18 267c          	jrne	L3763
8632                     ; 1793 	tempSS=mess[9]+(mess[10]*256);
8634  1a1a b6ce          	ld	a,_mess+10
8635  1a1c 5f            	clrw	x
8636  1a1d 97            	ld	xl,a
8637  1a1e 4f            	clr	a
8638  1a1f 02            	rlwa	x,a
8639  1a20 01            	rrwa	x,a
8640  1a21 bbcd          	add	a,_mess+9
8641  1a23 2401          	jrnc	L071
8642  1a25 5c            	incw	x
8643  1a26               L071:
8644  1a26 02            	rlwa	x,a
8645  1a27 1f04          	ldw	(OFST-1,sp),x
8646  1a29 01            	rrwa	x,a
8647                     ; 1794 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8649  1a2a ce0014        	ldw	x,_ee_Umax
8650  1a2d 1304          	cpw	x,(OFST-1,sp)
8651  1a2f 270a          	jreq	L5763
8654  1a31 1e04          	ldw	x,(OFST-1,sp)
8655  1a33 89            	pushw	x
8656  1a34 ae0014        	ldw	x,#_ee_Umax
8657  1a37 cd0000        	call	c_eewrw
8659  1a3a 85            	popw	x
8660  1a3b               L5763:
8661                     ; 1795 	tempSS=mess[11]+(mess[12]*256);
8663  1a3b b6d0          	ld	a,_mess+12
8664  1a3d 5f            	clrw	x
8665  1a3e 97            	ld	xl,a
8666  1a3f 4f            	clr	a
8667  1a40 02            	rlwa	x,a
8668  1a41 01            	rrwa	x,a
8669  1a42 bbcf          	add	a,_mess+11
8670  1a44 2401          	jrnc	L271
8671  1a46 5c            	incw	x
8672  1a47               L271:
8673  1a47 02            	rlwa	x,a
8674  1a48 1f04          	ldw	(OFST-1,sp),x
8675  1a4a 01            	rrwa	x,a
8676                     ; 1796 	if(ee_dU!=tempSS) ee_dU=tempSS;
8678  1a4b ce0012        	ldw	x,_ee_dU
8679  1a4e 1304          	cpw	x,(OFST-1,sp)
8680  1a50 270a          	jreq	L7763
8683  1a52 1e04          	ldw	x,(OFST-1,sp)
8684  1a54 89            	pushw	x
8685  1a55 ae0012        	ldw	x,#_ee_dU
8686  1a58 cd0000        	call	c_eewrw
8688  1a5b 85            	popw	x
8689  1a5c               L7763:
8690                     ; 1797 	if((mess[13]&0x0f)==0x5)
8692  1a5c b6d1          	ld	a,_mess+13
8693  1a5e a40f          	and	a,#15
8694  1a60 a105          	cp	a,#5
8695  1a62 261a          	jrne	L1073
8696                     ; 1799 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8698  1a64 ce0006        	ldw	x,_ee_AVT_MODE
8699  1a67 a30055        	cpw	x,#85
8700  1a6a 2603          	jrne	L622
8701  1a6c cc1d36        	jp	L3543
8702  1a6f               L622:
8705  1a6f ae0055        	ldw	x,#85
8706  1a72 89            	pushw	x
8707  1a73 ae0006        	ldw	x,#_ee_AVT_MODE
8708  1a76 cd0000        	call	c_eewrw
8710  1a79 85            	popw	x
8711  1a7a ac361d36      	jpf	L3543
8712  1a7e               L1073:
8713                     ; 1801 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8715  1a7e ce0006        	ldw	x,_ee_AVT_MODE
8716  1a81 a30055        	cpw	x,#85
8717  1a84 2703          	jreq	L032
8718  1a86 cc1d36        	jp	L3543
8719  1a89               L032:
8722  1a89 5f            	clrw	x
8723  1a8a 89            	pushw	x
8724  1a8b ae0006        	ldw	x,#_ee_AVT_MODE
8725  1a8e cd0000        	call	c_eewrw
8727  1a91 85            	popw	x
8728  1a92 ac361d36      	jpf	L3543
8729  1a96               L3763:
8730                     ; 1804 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8732  1a96 b6ca          	ld	a,_mess+6
8733  1a98 a1ff          	cp	a,#255
8734  1a9a 2703          	jreq	L232
8735  1a9c cc1b6d        	jp	L3173
8736  1a9f               L232:
8738  1a9f b6cb          	ld	a,_mess+7
8739  1aa1 a1ff          	cp	a,#255
8740  1aa3 2703          	jreq	L432
8741  1aa5 cc1b6d        	jp	L3173
8742  1aa8               L432:
8744  1aa8 b6cc          	ld	a,_mess+8
8745  1aaa a126          	cp	a,#38
8746  1aac 2709          	jreq	L5173
8748  1aae b6cc          	ld	a,_mess+8
8749  1ab0 a129          	cp	a,#41
8750  1ab2 2703          	jreq	L632
8751  1ab4 cc1b6d        	jp	L3173
8752  1ab7               L632:
8753  1ab7               L5173:
8754                     ; 1807 	tempSS=mess[9]+(mess[10]*256);
8756  1ab7 b6ce          	ld	a,_mess+10
8757  1ab9 5f            	clrw	x
8758  1aba 97            	ld	xl,a
8759  1abb 4f            	clr	a
8760  1abc 02            	rlwa	x,a
8761  1abd 01            	rrwa	x,a
8762  1abe bbcd          	add	a,_mess+9
8763  1ac0 2401          	jrnc	L471
8764  1ac2 5c            	incw	x
8765  1ac3               L471:
8766  1ac3 02            	rlwa	x,a
8767  1ac4 1f04          	ldw	(OFST-1,sp),x
8768  1ac6 01            	rrwa	x,a
8769                     ; 1808 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8771  1ac7 ce0010        	ldw	x,_ee_tmax
8772  1aca 1304          	cpw	x,(OFST-1,sp)
8773  1acc 270a          	jreq	L7173
8776  1ace 1e04          	ldw	x,(OFST-1,sp)
8777  1ad0 89            	pushw	x
8778  1ad1 ae0010        	ldw	x,#_ee_tmax
8779  1ad4 cd0000        	call	c_eewrw
8781  1ad7 85            	popw	x
8782  1ad8               L7173:
8783                     ; 1809 	tempSS=mess[11]+(mess[12]*256);
8785  1ad8 b6d0          	ld	a,_mess+12
8786  1ada 5f            	clrw	x
8787  1adb 97            	ld	xl,a
8788  1adc 4f            	clr	a
8789  1add 02            	rlwa	x,a
8790  1ade 01            	rrwa	x,a
8791  1adf bbcf          	add	a,_mess+11
8792  1ae1 2401          	jrnc	L671
8793  1ae3 5c            	incw	x
8794  1ae4               L671:
8795  1ae4 02            	rlwa	x,a
8796  1ae5 1f04          	ldw	(OFST-1,sp),x
8797  1ae7 01            	rrwa	x,a
8798                     ; 1810 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8800  1ae8 ce000e        	ldw	x,_ee_tsign
8801  1aeb 1304          	cpw	x,(OFST-1,sp)
8802  1aed 270a          	jreq	L1273
8805  1aef 1e04          	ldw	x,(OFST-1,sp)
8806  1af1 89            	pushw	x
8807  1af2 ae000e        	ldw	x,#_ee_tsign
8808  1af5 cd0000        	call	c_eewrw
8810  1af8 85            	popw	x
8811  1af9               L1273:
8812                     ; 1813 	if(mess[8]==MEM_KF1)
8814  1af9 b6cc          	ld	a,_mess+8
8815  1afb a126          	cp	a,#38
8816  1afd 2623          	jrne	L3273
8817                     ; 1815 		if(ee_DEVICE!=0)ee_DEVICE=0;
8819  1aff ce0004        	ldw	x,_ee_DEVICE
8820  1b02 2709          	jreq	L5273
8823  1b04 5f            	clrw	x
8824  1b05 89            	pushw	x
8825  1b06 ae0004        	ldw	x,#_ee_DEVICE
8826  1b09 cd0000        	call	c_eewrw
8828  1b0c 85            	popw	x
8829  1b0d               L5273:
8830                     ; 1816 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8832  1b0d b6d1          	ld	a,_mess+13
8833  1b0f 5f            	clrw	x
8834  1b10 97            	ld	xl,a
8835  1b11 c30016        	cpw	x,_ee_TZAS
8836  1b14 270c          	jreq	L3273
8839  1b16 b6d1          	ld	a,_mess+13
8840  1b18 5f            	clrw	x
8841  1b19 97            	ld	xl,a
8842  1b1a 89            	pushw	x
8843  1b1b ae0016        	ldw	x,#_ee_TZAS
8844  1b1e cd0000        	call	c_eewrw
8846  1b21 85            	popw	x
8847  1b22               L3273:
8848                     ; 1818 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8850  1b22 b6cc          	ld	a,_mess+8
8851  1b24 a129          	cp	a,#41
8852  1b26 2703          	jreq	L042
8853  1b28 cc1d36        	jp	L3543
8854  1b2b               L042:
8855                     ; 1820 		if(ee_DEVICE!=1)ee_DEVICE=1;
8857  1b2b ce0004        	ldw	x,_ee_DEVICE
8858  1b2e a30001        	cpw	x,#1
8859  1b31 270b          	jreq	L3373
8862  1b33 ae0001        	ldw	x,#1
8863  1b36 89            	pushw	x
8864  1b37 ae0004        	ldw	x,#_ee_DEVICE
8865  1b3a cd0000        	call	c_eewrw
8867  1b3d 85            	popw	x
8868  1b3e               L3373:
8869                     ; 1821 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8871  1b3e b6d1          	ld	a,_mess+13
8872  1b40 5f            	clrw	x
8873  1b41 97            	ld	xl,a
8874  1b42 c30002        	cpw	x,_ee_IMAXVENT
8875  1b45 270c          	jreq	L5373
8878  1b47 b6d1          	ld	a,_mess+13
8879  1b49 5f            	clrw	x
8880  1b4a 97            	ld	xl,a
8881  1b4b 89            	pushw	x
8882  1b4c ae0002        	ldw	x,#_ee_IMAXVENT
8883  1b4f cd0000        	call	c_eewrw
8885  1b52 85            	popw	x
8886  1b53               L5373:
8887                     ; 1822 			if(ee_TZAS!=3) ee_TZAS=3;
8889  1b53 ce0016        	ldw	x,_ee_TZAS
8890  1b56 a30003        	cpw	x,#3
8891  1b59 2603          	jrne	L242
8892  1b5b cc1d36        	jp	L3543
8893  1b5e               L242:
8896  1b5e ae0003        	ldw	x,#3
8897  1b61 89            	pushw	x
8898  1b62 ae0016        	ldw	x,#_ee_TZAS
8899  1b65 cd0000        	call	c_eewrw
8901  1b68 85            	popw	x
8902  1b69 ac361d36      	jpf	L3543
8903  1b6d               L3173:
8904                     ; 1826 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8906  1b6d b6ca          	ld	a,_mess+6
8907  1b6f c10005        	cp	a,_adress
8908  1b72 262d          	jrne	L3473
8910  1b74 b6cb          	ld	a,_mess+7
8911  1b76 c10005        	cp	a,_adress
8912  1b79 2626          	jrne	L3473
8914  1b7b b6cc          	ld	a,_mess+8
8915  1b7d a116          	cp	a,#22
8916  1b7f 2620          	jrne	L3473
8918  1b81 b6cd          	ld	a,_mess+9
8919  1b83 a163          	cp	a,#99
8920  1b85 261a          	jrne	L3473
8921                     ; 1828 	flags&=0b11100001;
8923  1b87 b60b          	ld	a,_flags
8924  1b89 a4e1          	and	a,#225
8925  1b8b b70b          	ld	_flags,a
8926                     ; 1829 	tsign_cnt=0;
8928  1b8d 5f            	clrw	x
8929  1b8e bf4d          	ldw	_tsign_cnt,x
8930                     ; 1830 	tmax_cnt=0;
8932  1b90 5f            	clrw	x
8933  1b91 bf4b          	ldw	_tmax_cnt,x
8934                     ; 1831 	umax_cnt=0;
8936  1b93 5f            	clrw	x
8937  1b94 bf66          	ldw	_umax_cnt,x
8938                     ; 1832 	umin_cnt=0;
8940  1b96 5f            	clrw	x
8941  1b97 bf64          	ldw	_umin_cnt,x
8942                     ; 1833 	led_drv_cnt=30;
8944  1b99 351e001c      	mov	_led_drv_cnt,#30
8946  1b9d ac361d36      	jpf	L3543
8947  1ba1               L3473:
8948                     ; 1836 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8950  1ba1 b6ca          	ld	a,_mess+6
8951  1ba3 c10005        	cp	a,_adress
8952  1ba6 2620          	jrne	L7473
8954  1ba8 b6cb          	ld	a,_mess+7
8955  1baa c10005        	cp	a,_adress
8956  1bad 2619          	jrne	L7473
8958  1baf b6cc          	ld	a,_mess+8
8959  1bb1 a116          	cp	a,#22
8960  1bb3 2613          	jrne	L7473
8962  1bb5 b6cd          	ld	a,_mess+9
8963  1bb7 a164          	cp	a,#100
8964  1bb9 260d          	jrne	L7473
8965                     ; 1838 	vent_resurs=0;
8967  1bbb 5f            	clrw	x
8968  1bbc 89            	pushw	x
8969  1bbd ae0000        	ldw	x,#_vent_resurs
8970  1bc0 cd0000        	call	c_eewrw
8972  1bc3 85            	popw	x
8974  1bc4 ac361d36      	jpf	L3543
8975  1bc8               L7473:
8976                     ; 1842 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8978  1bc8 b6ca          	ld	a,_mess+6
8979  1bca a1ff          	cp	a,#255
8980  1bcc 265f          	jrne	L3573
8982  1bce b6cb          	ld	a,_mess+7
8983  1bd0 a1ff          	cp	a,#255
8984  1bd2 2659          	jrne	L3573
8986  1bd4 b6cc          	ld	a,_mess+8
8987  1bd6 a116          	cp	a,#22
8988  1bd8 2653          	jrne	L3573
8990  1bda b6cd          	ld	a,_mess+9
8991  1bdc a116          	cp	a,#22
8992  1bde 264d          	jrne	L3573
8993                     ; 1844 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8995  1be0 b6ce          	ld	a,_mess+10
8996  1be2 a155          	cp	a,#85
8997  1be4 260f          	jrne	L5573
8999  1be6 b6cf          	ld	a,_mess+11
9000  1be8 a155          	cp	a,#85
9001  1bea 2609          	jrne	L5573
9004  1bec be5e          	ldw	x,__x_
9005  1bee 1c0001        	addw	x,#1
9006  1bf1 bf5e          	ldw	__x_,x
9008  1bf3 2024          	jra	L7573
9009  1bf5               L5573:
9010                     ; 1845 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9012  1bf5 b6ce          	ld	a,_mess+10
9013  1bf7 a166          	cp	a,#102
9014  1bf9 260f          	jrne	L1673
9016  1bfb b6cf          	ld	a,_mess+11
9017  1bfd a166          	cp	a,#102
9018  1bff 2609          	jrne	L1673
9021  1c01 be5e          	ldw	x,__x_
9022  1c03 1d0001        	subw	x,#1
9023  1c06 bf5e          	ldw	__x_,x
9025  1c08 200f          	jra	L7573
9026  1c0a               L1673:
9027                     ; 1846 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9029  1c0a b6ce          	ld	a,_mess+10
9030  1c0c a177          	cp	a,#119
9031  1c0e 2609          	jrne	L7573
9033  1c10 b6cf          	ld	a,_mess+11
9034  1c12 a177          	cp	a,#119
9035  1c14 2603          	jrne	L7573
9038  1c16 5f            	clrw	x
9039  1c17 bf5e          	ldw	__x_,x
9040  1c19               L7573:
9041                     ; 1847      gran(&_x_,-XMAX,XMAX);
9043  1c19 ae0019        	ldw	x,#25
9044  1c1c 89            	pushw	x
9045  1c1d aeffe7        	ldw	x,#65511
9046  1c20 89            	pushw	x
9047  1c21 ae005e        	ldw	x,#__x_
9048  1c24 cd00d1        	call	_gran
9050  1c27 5b04          	addw	sp,#4
9052  1c29 ac361d36      	jpf	L3543
9053  1c2d               L3573:
9054                     ; 1849 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9056  1c2d b6ca          	ld	a,_mess+6
9057  1c2f c10005        	cp	a,_adress
9058  1c32 2665          	jrne	L1773
9060  1c34 b6cb          	ld	a,_mess+7
9061  1c36 c10005        	cp	a,_adress
9062  1c39 265e          	jrne	L1773
9064  1c3b b6cc          	ld	a,_mess+8
9065  1c3d a116          	cp	a,#22
9066  1c3f 2658          	jrne	L1773
9068  1c41 b6cd          	ld	a,_mess+9
9069  1c43 b1ce          	cp	a,_mess+10
9070  1c45 2652          	jrne	L1773
9072  1c47 b6cd          	ld	a,_mess+9
9073  1c49 a1ee          	cp	a,#238
9074  1c4b 264c          	jrne	L1773
9075                     ; 1851 	rotor_int++;
9077  1c4d be1d          	ldw	x,_rotor_int
9078  1c4f 1c0001        	addw	x,#1
9079  1c52 bf1d          	ldw	_rotor_int,x
9080                     ; 1852      tempI=pwm_u;
9082  1c54 be0e          	ldw	x,_pwm_u
9083  1c56 1f04          	ldw	(OFST-1,sp),x
9084                     ; 1853 	ee_U_AVT=tempI;
9086  1c58 1e04          	ldw	x,(OFST-1,sp)
9087  1c5a 89            	pushw	x
9088  1c5b ae000c        	ldw	x,#_ee_U_AVT
9089  1c5e cd0000        	call	c_eewrw
9091  1c61 85            	popw	x
9092                     ; 1854 	UU_AVT=Un;
9094  1c62 be6d          	ldw	x,_Un
9095  1c64 89            	pushw	x
9096  1c65 ae0008        	ldw	x,#_UU_AVT
9097  1c68 cd0000        	call	c_eewrw
9099  1c6b 85            	popw	x
9100                     ; 1855 	delay_ms(100);
9102  1c6c ae0064        	ldw	x,#100
9103  1c6f cd011d        	call	_delay_ms
9105                     ; 1856 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9107  1c72 ce000c        	ldw	x,_ee_U_AVT
9108  1c75 1304          	cpw	x,(OFST-1,sp)
9109  1c77 2703          	jreq	L442
9110  1c79 cc1d36        	jp	L3543
9111  1c7c               L442:
9114  1c7c 4b00          	push	#0
9115  1c7e 4b00          	push	#0
9116  1c80 4b00          	push	#0
9117  1c82 4b00          	push	#0
9118  1c84 4bdd          	push	#221
9119  1c86 4bdd          	push	#221
9120  1c88 4b91          	push	#145
9121  1c8a 3b0005        	push	_adress
9122  1c8d ae018e        	ldw	x,#398
9123  1c90 cd152a        	call	_can_transmit
9125  1c93 5b08          	addw	sp,#8
9126  1c95 ac361d36      	jpf	L3543
9127  1c99               L1773:
9128                     ; 1861 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9130  1c99 b6cb          	ld	a,_mess+7
9131  1c9b a1da          	cp	a,#218
9132  1c9d 2652          	jrne	L7773
9134  1c9f b6ca          	ld	a,_mess+6
9135  1ca1 c10005        	cp	a,_adress
9136  1ca4 274b          	jreq	L7773
9138  1ca6 b6ca          	ld	a,_mess+6
9139  1ca8 a106          	cp	a,#6
9140  1caa 2445          	jruge	L7773
9141                     ; 1863 	i_main_bps_cnt[mess[6]]=0;
9143  1cac b6ca          	ld	a,_mess+6
9144  1cae 5f            	clrw	x
9145  1caf 97            	ld	xl,a
9146  1cb0 6f09          	clr	(_i_main_bps_cnt,x)
9147                     ; 1864 	i_main_flag[mess[6]]=1;
9149  1cb2 b6ca          	ld	a,_mess+6
9150  1cb4 5f            	clrw	x
9151  1cb5 97            	ld	xl,a
9152  1cb6 a601          	ld	a,#1
9153  1cb8 e714          	ld	(_i_main_flag,x),a
9154                     ; 1865 	if(bMAIN)
9156                     	btst	_bMAIN
9157  1cbf 2475          	jruge	L3543
9158                     ; 1867 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9160  1cc1 b6cd          	ld	a,_mess+9
9161  1cc3 5f            	clrw	x
9162  1cc4 97            	ld	xl,a
9163  1cc5 4f            	clr	a
9164  1cc6 02            	rlwa	x,a
9165  1cc7 1f01          	ldw	(OFST-4,sp),x
9166  1cc9 b6cc          	ld	a,_mess+8
9167  1ccb 5f            	clrw	x
9168  1ccc 97            	ld	xl,a
9169  1ccd 72fb01        	addw	x,(OFST-4,sp)
9170  1cd0 b6ca          	ld	a,_mess+6
9171  1cd2 905f          	clrw	y
9172  1cd4 9097          	ld	yl,a
9173  1cd6 9058          	sllw	y
9174  1cd8 90ef1a        	ldw	(_i_main,y),x
9175                     ; 1868 		i_main[adress]=I;
9177  1cdb c60005        	ld	a,_adress
9178  1cde 5f            	clrw	x
9179  1cdf 97            	ld	xl,a
9180  1ce0 58            	sllw	x
9181  1ce1 90be6f        	ldw	y,_I
9182  1ce4 ef1a          	ldw	(_i_main,x),y
9183                     ; 1869      	i_main_flag[adress]=1;
9185  1ce6 c60005        	ld	a,_adress
9186  1ce9 5f            	clrw	x
9187  1cea 97            	ld	xl,a
9188  1ceb a601          	ld	a,#1
9189  1ced e714          	ld	(_i_main_flag,x),a
9190  1cef 2045          	jra	L3543
9191  1cf1               L7773:
9192                     ; 1873 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9194  1cf1 b6cb          	ld	a,_mess+7
9195  1cf3 a1db          	cp	a,#219
9196  1cf5 263f          	jrne	L3543
9198  1cf7 b6ca          	ld	a,_mess+6
9199  1cf9 c10005        	cp	a,_adress
9200  1cfc 2738          	jreq	L3543
9202  1cfe b6ca          	ld	a,_mess+6
9203  1d00 a106          	cp	a,#6
9204  1d02 2432          	jruge	L3543
9205                     ; 1875 	i_main_bps_cnt[mess[6]]=0;
9207  1d04 b6ca          	ld	a,_mess+6
9208  1d06 5f            	clrw	x
9209  1d07 97            	ld	xl,a
9210  1d08 6f09          	clr	(_i_main_bps_cnt,x)
9211                     ; 1876 	i_main_flag[mess[6]]=1;		
9213  1d0a b6ca          	ld	a,_mess+6
9214  1d0c 5f            	clrw	x
9215  1d0d 97            	ld	xl,a
9216  1d0e a601          	ld	a,#1
9217  1d10 e714          	ld	(_i_main_flag,x),a
9218                     ; 1877 	if(bMAIN)
9220                     	btst	_bMAIN
9221  1d17 241d          	jruge	L3543
9222                     ; 1879 		if(mess[9]==0)i_main_flag[i]=1;
9224  1d19 3dcd          	tnz	_mess+9
9225  1d1b 260a          	jrne	L1104
9228  1d1d 7b03          	ld	a,(OFST-2,sp)
9229  1d1f 5f            	clrw	x
9230  1d20 97            	ld	xl,a
9231  1d21 a601          	ld	a,#1
9232  1d23 e714          	ld	(_i_main_flag,x),a
9234  1d25 2006          	jra	L3104
9235  1d27               L1104:
9236                     ; 1880 		else i_main_flag[i]=0;
9238  1d27 7b03          	ld	a,(OFST-2,sp)
9239  1d29 5f            	clrw	x
9240  1d2a 97            	ld	xl,a
9241  1d2b 6f14          	clr	(_i_main_flag,x)
9242  1d2d               L3104:
9243                     ; 1881 		i_main_flag[adress]=1;
9245  1d2d c60005        	ld	a,_adress
9246  1d30 5f            	clrw	x
9247  1d31 97            	ld	xl,a
9248  1d32 a601          	ld	a,#1
9249  1d34 e714          	ld	(_i_main_flag,x),a
9250  1d36               L3543:
9251                     ; 1887 can_in_an_end:
9251                     ; 1888 bCAN_RX=0;
9253  1d36 3f0a          	clr	_bCAN_RX
9254                     ; 1889 }   
9257  1d38 5b05          	addw	sp,#5
9258  1d3a 81            	ret
9281                     ; 1892 void t4_init(void){
9282                     	switch	.text
9283  1d3b               _t4_init:
9287                     ; 1893 	TIM4->PSCR = 4;
9289  1d3b 35045345      	mov	21317,#4
9290                     ; 1894 	TIM4->ARR= 61;
9292  1d3f 353d5346      	mov	21318,#61
9293                     ; 1895 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9295  1d43 72105341      	bset	21313,#0
9296                     ; 1897 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9298  1d47 35855340      	mov	21312,#133
9299                     ; 1899 }
9302  1d4b 81            	ret
9325                     ; 1902 void t1_init(void)
9325                     ; 1903 {
9326                     	switch	.text
9327  1d4c               _t1_init:
9331                     ; 1904 TIM1->ARRH= 0x03;
9333  1d4c 35035262      	mov	21090,#3
9334                     ; 1905 TIM1->ARRL= 0xff;
9336  1d50 35ff5263      	mov	21091,#255
9337                     ; 1906 TIM1->CCR1H= 0x00;	
9339  1d54 725f5265      	clr	21093
9340                     ; 1907 TIM1->CCR1L= 0xff;
9342  1d58 35ff5266      	mov	21094,#255
9343                     ; 1908 TIM1->CCR2H= 0x00;	
9345  1d5c 725f5267      	clr	21095
9346                     ; 1909 TIM1->CCR2L= 0x00;
9348  1d60 725f5268      	clr	21096
9349                     ; 1910 TIM1->CCR3H= 0x00;	
9351  1d64 725f5269      	clr	21097
9352                     ; 1911 TIM1->CCR3L= 0x64;
9354  1d68 3564526a      	mov	21098,#100
9355                     ; 1913 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9357  1d6c 35685258      	mov	21080,#104
9358                     ; 1914 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9360  1d70 35685259      	mov	21081,#104
9361                     ; 1915 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9363  1d74 3568525a      	mov	21082,#104
9364                     ; 1916 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9366  1d78 3511525c      	mov	21084,#17
9367                     ; 1917 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9369  1d7c 3501525d      	mov	21085,#1
9370                     ; 1918 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9372  1d80 35815250      	mov	21072,#129
9373                     ; 1919 TIM1->BKR|= TIM1_BKR_AOE;
9375  1d84 721c526d      	bset	21101,#6
9376                     ; 1920 }
9379  1d88 81            	ret
9404                     ; 1924 void adc2_init(void)
9404                     ; 1925 {
9405                     	switch	.text
9406  1d89               _adc2_init:
9410                     ; 1926 adc_plazma[0]++;
9412  1d89 beb6          	ldw	x,_adc_plazma
9413  1d8b 1c0001        	addw	x,#1
9414  1d8e bfb6          	ldw	_adc_plazma,x
9415                     ; 1950 GPIOB->DDR&=~(1<<4);
9417  1d90 72195007      	bres	20487,#4
9418                     ; 1951 GPIOB->CR1&=~(1<<4);
9420  1d94 72195008      	bres	20488,#4
9421                     ; 1952 GPIOB->CR2&=~(1<<4);
9423  1d98 72195009      	bres	20489,#4
9424                     ; 1954 GPIOB->DDR&=~(1<<5);
9426  1d9c 721b5007      	bres	20487,#5
9427                     ; 1955 GPIOB->CR1&=~(1<<5);
9429  1da0 721b5008      	bres	20488,#5
9430                     ; 1956 GPIOB->CR2&=~(1<<5);
9432  1da4 721b5009      	bres	20489,#5
9433                     ; 1958 GPIOB->DDR&=~(1<<6);
9435  1da8 721d5007      	bres	20487,#6
9436                     ; 1959 GPIOB->CR1&=~(1<<6);
9438  1dac 721d5008      	bres	20488,#6
9439                     ; 1960 GPIOB->CR2&=~(1<<6);
9441  1db0 721d5009      	bres	20489,#6
9442                     ; 1962 GPIOB->DDR&=~(1<<7);
9444  1db4 721f5007      	bres	20487,#7
9445                     ; 1963 GPIOB->CR1&=~(1<<7);
9447  1db8 721f5008      	bres	20488,#7
9448                     ; 1964 GPIOB->CR2&=~(1<<7);
9450  1dbc 721f5009      	bres	20489,#7
9451                     ; 1974 ADC2->TDRL=0xff;
9453  1dc0 35ff5407      	mov	21511,#255
9454                     ; 1976 ADC2->CR2=0x08;
9456  1dc4 35085402      	mov	21506,#8
9457                     ; 1977 ADC2->CR1=0x40;
9459  1dc8 35405401      	mov	21505,#64
9460                     ; 1980 	ADC2->CSR=0x20+adc_ch+3;
9462  1dcc b6c3          	ld	a,_adc_ch
9463  1dce ab23          	add	a,#35
9464  1dd0 c75400        	ld	21504,a
9465                     ; 1982 	ADC2->CR1|=1;
9467  1dd3 72105401      	bset	21505,#0
9468                     ; 1983 	ADC2->CR1|=1;
9470  1dd7 72105401      	bset	21505,#0
9471                     ; 1986 adc_plazma[1]=adc_ch;
9473  1ddb b6c3          	ld	a,_adc_ch
9474  1ddd 5f            	clrw	x
9475  1dde 97            	ld	xl,a
9476  1ddf bfb8          	ldw	_adc_plazma+2,x
9477                     ; 1987 }
9480  1de1 81            	ret
9514                     ; 1996 @far @interrupt void TIM4_UPD_Interrupt (void) 
9514                     ; 1997 {
9516                     	switch	.text
9517  1de2               f_TIM4_UPD_Interrupt:
9521                     ; 1998 TIM4->SR1&=~TIM4_SR1_UIF;
9523  1de2 72115342      	bres	21314,#0
9524                     ; 2000 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9526  1de6 3c08          	inc	_pwm_vent_cnt
9527  1de8 b608          	ld	a,_pwm_vent_cnt
9528  1dea a10a          	cp	a,#10
9529  1dec 2502          	jrult	L5504
9532  1dee 3f08          	clr	_pwm_vent_cnt
9533  1df0               L5504:
9534                     ; 2001 GPIOB->ODR|=(1<<3);
9536  1df0 72165005      	bset	20485,#3
9537                     ; 2002 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9539  1df4 b608          	ld	a,_pwm_vent_cnt
9540  1df6 a105          	cp	a,#5
9541  1df8 2504          	jrult	L7504
9544  1dfa 72175005      	bres	20485,#3
9545  1dfe               L7504:
9546                     ; 2007 if(++t0_cnt0>=100)
9548  1dfe 9c            	rvf
9549  1dff be01          	ldw	x,_t0_cnt0
9550  1e01 1c0001        	addw	x,#1
9551  1e04 bf01          	ldw	_t0_cnt0,x
9552  1e06 a30064        	cpw	x,#100
9553  1e09 2f3f          	jrslt	L1604
9554                     ; 2009 	t0_cnt0=0;
9556  1e0b 5f            	clrw	x
9557  1e0c bf01          	ldw	_t0_cnt0,x
9558                     ; 2010 	b100Hz=1;
9560  1e0e 72100008      	bset	_b100Hz
9561                     ; 2012 	if(++t0_cnt1>=10)
9563  1e12 3c03          	inc	_t0_cnt1
9564  1e14 b603          	ld	a,_t0_cnt1
9565  1e16 a10a          	cp	a,#10
9566  1e18 2506          	jrult	L3604
9567                     ; 2014 		t0_cnt1=0;
9569  1e1a 3f03          	clr	_t0_cnt1
9570                     ; 2015 		b10Hz=1;
9572  1e1c 72100007      	bset	_b10Hz
9573  1e20               L3604:
9574                     ; 2018 	if(++t0_cnt2>=20)
9576  1e20 3c04          	inc	_t0_cnt2
9577  1e22 b604          	ld	a,_t0_cnt2
9578  1e24 a114          	cp	a,#20
9579  1e26 2506          	jrult	L5604
9580                     ; 2020 		t0_cnt2=0;
9582  1e28 3f04          	clr	_t0_cnt2
9583                     ; 2021 		b5Hz=1;
9585  1e2a 72100006      	bset	_b5Hz
9586  1e2e               L5604:
9587                     ; 2025 	if(++t0_cnt4>=50)
9589  1e2e 3c06          	inc	_t0_cnt4
9590  1e30 b606          	ld	a,_t0_cnt4
9591  1e32 a132          	cp	a,#50
9592  1e34 2506          	jrult	L7604
9593                     ; 2027 		t0_cnt4=0;
9595  1e36 3f06          	clr	_t0_cnt4
9596                     ; 2028 		b2Hz=1;
9598  1e38 72100005      	bset	_b2Hz
9599  1e3c               L7604:
9600                     ; 2031 	if(++t0_cnt3>=100)
9602  1e3c 3c05          	inc	_t0_cnt3
9603  1e3e b605          	ld	a,_t0_cnt3
9604  1e40 a164          	cp	a,#100
9605  1e42 2506          	jrult	L1604
9606                     ; 2033 		t0_cnt3=0;
9608  1e44 3f05          	clr	_t0_cnt3
9609                     ; 2034 		b1Hz=1;
9611  1e46 72100004      	bset	_b1Hz
9612  1e4a               L1604:
9613                     ; 2040 }
9616  1e4a 80            	iret
9641                     ; 2043 @far @interrupt void CAN_RX_Interrupt (void) 
9641                     ; 2044 {
9642                     	switch	.text
9643  1e4b               f_CAN_RX_Interrupt:
9647                     ; 2046 CAN->PSR= 7;									// page 7 - read messsage
9649  1e4b 35075427      	mov	21543,#7
9650                     ; 2048 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9652  1e4f ae000e        	ldw	x,#14
9653  1e52               L062:
9654  1e52 d65427        	ld	a,(21543,x)
9655  1e55 e7c3          	ld	(_mess-1,x),a
9656  1e57 5a            	decw	x
9657  1e58 26f8          	jrne	L062
9658                     ; 2059 bCAN_RX=1;
9660  1e5a 3501000a      	mov	_bCAN_RX,#1
9661                     ; 2060 CAN->RFR|=(1<<5);
9663  1e5e 721a5424      	bset	21540,#5
9664                     ; 2062 }
9667  1e62 80            	iret
9690                     ; 2065 @far @interrupt void CAN_TX_Interrupt (void) 
9690                     ; 2066 {
9691                     	switch	.text
9692  1e63               f_CAN_TX_Interrupt:
9696                     ; 2067 if((CAN->TSR)&(1<<0))
9698  1e63 c65422        	ld	a,21538
9699  1e66 a501          	bcp	a,#1
9700  1e68 2708          	jreq	L3114
9701                     ; 2069 	bTX_FREE=1;	
9703  1e6a 35010009      	mov	_bTX_FREE,#1
9704                     ; 2071 	CAN->TSR|=(1<<0);
9706  1e6e 72105422      	bset	21538,#0
9707  1e72               L3114:
9708                     ; 2073 }
9711  1e72 80            	iret
9769                     ; 2076 @far @interrupt void ADC2_EOC_Interrupt (void) {
9770                     	switch	.text
9771  1e73               f_ADC2_EOC_Interrupt:
9773       00000009      OFST:	set	9
9774  1e73 be00          	ldw	x,c_x
9775  1e75 89            	pushw	x
9776  1e76 be00          	ldw	x,c_y
9777  1e78 89            	pushw	x
9778  1e79 be02          	ldw	x,c_lreg+2
9779  1e7b 89            	pushw	x
9780  1e7c be00          	ldw	x,c_lreg
9781  1e7e 89            	pushw	x
9782  1e7f 5209          	subw	sp,#9
9785                     ; 2081 adc_plazma[2]++;
9787  1e81 beba          	ldw	x,_adc_plazma+4
9788  1e83 1c0001        	addw	x,#1
9789  1e86 bfba          	ldw	_adc_plazma+4,x
9790                     ; 2088 ADC2->CSR&=~(1<<7);
9792  1e88 721f5400      	bres	21504,#7
9793                     ; 2090 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9795  1e8c c65405        	ld	a,21509
9796  1e8f b703          	ld	c_lreg+3,a
9797  1e91 3f02          	clr	c_lreg+2
9798  1e93 3f01          	clr	c_lreg+1
9799  1e95 3f00          	clr	c_lreg
9800  1e97 96            	ldw	x,sp
9801  1e98 1c0001        	addw	x,#OFST-8
9802  1e9b cd0000        	call	c_rtol
9804  1e9e c65404        	ld	a,21508
9805  1ea1 5f            	clrw	x
9806  1ea2 97            	ld	xl,a
9807  1ea3 90ae0100      	ldw	y,#256
9808  1ea7 cd0000        	call	c_umul
9810  1eaa 96            	ldw	x,sp
9811  1eab 1c0001        	addw	x,#OFST-8
9812  1eae cd0000        	call	c_ladd
9814  1eb1 96            	ldw	x,sp
9815  1eb2 1c0006        	addw	x,#OFST-3
9816  1eb5 cd0000        	call	c_rtol
9818                     ; 2095 if(adr_drv_stat==1)
9820  1eb8 b608          	ld	a,_adr_drv_stat
9821  1eba a101          	cp	a,#1
9822  1ebc 260b          	jrne	L3414
9823                     ; 2097 	adr_drv_stat=2;
9825  1ebe 35020008      	mov	_adr_drv_stat,#2
9826                     ; 2098 	adc_buff_[0]=temp_adc;
9828  1ec2 1e08          	ldw	x,(OFST-1,sp)
9829  1ec4 cf0009        	ldw	_adc_buff_,x
9831  1ec7 2020          	jra	L5414
9832  1ec9               L3414:
9833                     ; 2101 else if(adr_drv_stat==3)
9835  1ec9 b608          	ld	a,_adr_drv_stat
9836  1ecb a103          	cp	a,#3
9837  1ecd 260b          	jrne	L7414
9838                     ; 2103 	adr_drv_stat=4;
9840  1ecf 35040008      	mov	_adr_drv_stat,#4
9841                     ; 2104 	adc_buff_[1]=temp_adc;
9843  1ed3 1e08          	ldw	x,(OFST-1,sp)
9844  1ed5 cf000b        	ldw	_adc_buff_+2,x
9846  1ed8 200f          	jra	L5414
9847  1eda               L7414:
9848                     ; 2107 else if(adr_drv_stat==5)
9850  1eda b608          	ld	a,_adr_drv_stat
9851  1edc a105          	cp	a,#5
9852  1ede 2609          	jrne	L5414
9853                     ; 2109 	adr_drv_stat=6;
9855  1ee0 35060008      	mov	_adr_drv_stat,#6
9856                     ; 2110 	adc_buff_[9]=temp_adc;
9858  1ee4 1e08          	ldw	x,(OFST-1,sp)
9859  1ee6 cf001b        	ldw	_adc_buff_+18,x
9860  1ee9               L5414:
9861                     ; 2113 adc_buff[adc_ch][adc_cnt]=temp_adc;
9863  1ee9 b6c2          	ld	a,_adc_cnt
9864  1eeb 5f            	clrw	x
9865  1eec 97            	ld	xl,a
9866  1eed 58            	sllw	x
9867  1eee 1f03          	ldw	(OFST-6,sp),x
9868  1ef0 b6c3          	ld	a,_adc_ch
9869  1ef2 97            	ld	xl,a
9870  1ef3 a620          	ld	a,#32
9871  1ef5 42            	mul	x,a
9872  1ef6 72fb03        	addw	x,(OFST-6,sp)
9873  1ef9 1608          	ldw	y,(OFST-1,sp)
9874  1efb df001d        	ldw	(_adc_buff,x),y
9875                     ; 2119 adc_ch++;
9877  1efe 3cc3          	inc	_adc_ch
9878                     ; 2120 if(adc_ch>=5)
9880  1f00 b6c3          	ld	a,_adc_ch
9881  1f02 a105          	cp	a,#5
9882  1f04 250c          	jrult	L5514
9883                     ; 2123 	adc_ch=0;
9885  1f06 3fc3          	clr	_adc_ch
9886                     ; 2124 	adc_cnt++;
9888  1f08 3cc2          	inc	_adc_cnt
9889                     ; 2125 	if(adc_cnt>=16)
9891  1f0a b6c2          	ld	a,_adc_cnt
9892  1f0c a110          	cp	a,#16
9893  1f0e 2502          	jrult	L5514
9894                     ; 2127 		adc_cnt=0;
9896  1f10 3fc2          	clr	_adc_cnt
9897  1f12               L5514:
9898                     ; 2131 if((adc_cnt&0x03)==0)
9900  1f12 b6c2          	ld	a,_adc_cnt
9901  1f14 a503          	bcp	a,#3
9902  1f16 264b          	jrne	L1614
9903                     ; 2135 	tempSS=0;
9905  1f18 ae0000        	ldw	x,#0
9906  1f1b 1f08          	ldw	(OFST-1,sp),x
9907  1f1d ae0000        	ldw	x,#0
9908  1f20 1f06          	ldw	(OFST-3,sp),x
9909                     ; 2136 	for(i=0;i<16;i++)
9911  1f22 0f05          	clr	(OFST-4,sp)
9912  1f24               L3614:
9913                     ; 2138 		tempSS+=(signed long)adc_buff[adc_ch][i];
9915  1f24 7b05          	ld	a,(OFST-4,sp)
9916  1f26 5f            	clrw	x
9917  1f27 97            	ld	xl,a
9918  1f28 58            	sllw	x
9919  1f29 1f03          	ldw	(OFST-6,sp),x
9920  1f2b b6c3          	ld	a,_adc_ch
9921  1f2d 97            	ld	xl,a
9922  1f2e a620          	ld	a,#32
9923  1f30 42            	mul	x,a
9924  1f31 72fb03        	addw	x,(OFST-6,sp)
9925  1f34 de001d        	ldw	x,(_adc_buff,x)
9926  1f37 cd0000        	call	c_itolx
9928  1f3a 96            	ldw	x,sp
9929  1f3b 1c0006        	addw	x,#OFST-3
9930  1f3e cd0000        	call	c_lgadd
9932                     ; 2136 	for(i=0;i<16;i++)
9934  1f41 0c05          	inc	(OFST-4,sp)
9937  1f43 7b05          	ld	a,(OFST-4,sp)
9938  1f45 a110          	cp	a,#16
9939  1f47 25db          	jrult	L3614
9940                     ; 2140 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9942  1f49 96            	ldw	x,sp
9943  1f4a 1c0006        	addw	x,#OFST-3
9944  1f4d cd0000        	call	c_ltor
9946  1f50 a604          	ld	a,#4
9947  1f52 cd0000        	call	c_lrsh
9949  1f55 be02          	ldw	x,c_lreg+2
9950  1f57 b6c3          	ld	a,_adc_ch
9951  1f59 905f          	clrw	y
9952  1f5b 9097          	ld	yl,a
9953  1f5d 9058          	sllw	y
9954  1f5f 90df0009      	ldw	(_adc_buff_,y),x
9955  1f63               L1614:
9956                     ; 2151 adc_plazma_short++;
9958  1f63 bec0          	ldw	x,_adc_plazma_short
9959  1f65 1c0001        	addw	x,#1
9960  1f68 bfc0          	ldw	_adc_plazma_short,x
9961                     ; 2166 }
9964  1f6a 5b09          	addw	sp,#9
9965  1f6c 85            	popw	x
9966  1f6d bf00          	ldw	c_lreg,x
9967  1f6f 85            	popw	x
9968  1f70 bf02          	ldw	c_lreg+2,x
9969  1f72 85            	popw	x
9970  1f73 bf00          	ldw	c_y,x
9971  1f75 85            	popw	x
9972  1f76 bf00          	ldw	c_x,x
9973  1f78 80            	iret
10037                     ; 2174 main()
10037                     ; 2175 {
10039                     	switch	.text
10040  1f79               _main:
10044                     ; 2177 CLK->ECKR|=1;
10046  1f79 721050c1      	bset	20673,#0
10048  1f7d               L3024:
10049                     ; 2178 while((CLK->ECKR & 2) == 0);
10051  1f7d c650c1        	ld	a,20673
10052  1f80 a502          	bcp	a,#2
10053  1f82 27f9          	jreq	L3024
10054                     ; 2179 CLK->SWCR|=2;
10056  1f84 721250c5      	bset	20677,#1
10057                     ; 2180 CLK->SWR=0xB4;
10059  1f88 35b450c4      	mov	20676,#180
10060                     ; 2182 delay_ms(200);
10062  1f8c ae00c8        	ldw	x,#200
10063  1f8f cd011d        	call	_delay_ms
10065                     ; 2183 FLASH_DUKR=0xae;
10067  1f92 35ae5064      	mov	_FLASH_DUKR,#174
10068                     ; 2184 FLASH_DUKR=0x56;
10070  1f96 35565064      	mov	_FLASH_DUKR,#86
10071                     ; 2185 enableInterrupts();
10074  1f9a 9a            rim
10076                     ; 2188 adr_drv_v3();
10079  1f9b cd1178        	call	_adr_drv_v3
10081                     ; 2192 t4_init();
10083  1f9e cd1d3b        	call	_t4_init
10085                     ; 2194 		GPIOG->DDR|=(1<<0);
10087  1fa1 72105020      	bset	20512,#0
10088                     ; 2195 		GPIOG->CR1|=(1<<0);
10090  1fa5 72105021      	bset	20513,#0
10091                     ; 2196 		GPIOG->CR2&=~(1<<0);	
10093  1fa9 72115022      	bres	20514,#0
10094                     ; 2199 		GPIOG->DDR&=~(1<<1);
10096  1fad 72135020      	bres	20512,#1
10097                     ; 2200 		GPIOG->CR1|=(1<<1);
10099  1fb1 72125021      	bset	20513,#1
10100                     ; 2201 		GPIOG->CR2&=~(1<<1);
10102  1fb5 72135022      	bres	20514,#1
10103                     ; 2203 init_CAN();
10105  1fb9 cd14bb        	call	_init_CAN
10107                     ; 2208 GPIOC->DDR|=(1<<1);
10109  1fbc 7212500c      	bset	20492,#1
10110                     ; 2209 GPIOC->CR1|=(1<<1);
10112  1fc0 7212500d      	bset	20493,#1
10113                     ; 2210 GPIOC->CR2|=(1<<1);
10115  1fc4 7212500e      	bset	20494,#1
10116                     ; 2212 GPIOC->DDR|=(1<<2);
10118  1fc8 7214500c      	bset	20492,#2
10119                     ; 2213 GPIOC->CR1|=(1<<2);
10121  1fcc 7214500d      	bset	20493,#2
10122                     ; 2214 GPIOC->CR2|=(1<<2);
10124  1fd0 7214500e      	bset	20494,#2
10125                     ; 2221 t1_init();
10127  1fd4 cd1d4c        	call	_t1_init
10129                     ; 2223 GPIOA->DDR|=(1<<5);
10131  1fd7 721a5002      	bset	20482,#5
10132                     ; 2224 GPIOA->CR1|=(1<<5);
10134  1fdb 721a5003      	bset	20483,#5
10135                     ; 2225 GPIOA->CR2&=~(1<<5);
10137  1fdf 721b5004      	bres	20484,#5
10138                     ; 2231 GPIOB->DDR&=~(1<<3);
10140  1fe3 72175007      	bres	20487,#3
10141                     ; 2232 GPIOB->CR1&=~(1<<3);
10143  1fe7 72175008      	bres	20488,#3
10144                     ; 2233 GPIOB->CR2&=~(1<<3);
10146  1feb 72175009      	bres	20489,#3
10147                     ; 2235 GPIOC->DDR|=(1<<3);
10149  1fef 7216500c      	bset	20492,#3
10150                     ; 2236 GPIOC->CR1|=(1<<3);
10152  1ff3 7216500d      	bset	20493,#3
10153                     ; 2237 GPIOC->CR2|=(1<<3);
10155  1ff7 7216500e      	bset	20494,#3
10156                     ; 2240 if(bps_class==bpsIPS) 
10158  1ffb b604          	ld	a,_bps_class
10159  1ffd a101          	cp	a,#1
10160  1fff 260a          	jrne	L1124
10161                     ; 2242 	pwm_u=ee_U_AVT;
10163  2001 ce000c        	ldw	x,_ee_U_AVT
10164  2004 bf0e          	ldw	_pwm_u,x
10165                     ; 2243 	volum_u_main_=ee_U_AVT;
10167  2006 ce000c        	ldw	x,_ee_U_AVT
10168  2009 bf1f          	ldw	_volum_u_main_,x
10169  200b               L1124:
10170                     ; 2250 	if(bCAN_RX)
10172  200b 3d0a          	tnz	_bCAN_RX
10173  200d 2705          	jreq	L5124
10174                     ; 2252 		bCAN_RX=0;
10176  200f 3f0a          	clr	_bCAN_RX
10177                     ; 2253 		can_in_an();	
10179  2011 cd16c6        	call	_can_in_an
10181  2014               L5124:
10182                     ; 2255 	if(b100Hz)
10184                     	btst	_b100Hz
10185  2019 240a          	jruge	L7124
10186                     ; 2257 		b100Hz=0;
10188  201b 72110008      	bres	_b100Hz
10189                     ; 2266 		adc2_init();
10191  201f cd1d89        	call	_adc2_init
10193                     ; 2267 		can_tx_hndl();
10195  2022 cd15ae        	call	_can_tx_hndl
10197  2025               L7124:
10198                     ; 2270 	if(b10Hz)
10200                     	btst	_b10Hz
10201  202a 2419          	jruge	L1224
10202                     ; 2272 		b10Hz=0;
10204  202c 72110007      	bres	_b10Hz
10205                     ; 2274 		matemat();
10207  2030 cd0cdf        	call	_matemat
10209                     ; 2275 		led_drv(); 
10211  2033 cd07e2        	call	_led_drv
10213                     ; 2276 	  link_drv();
10215  2036 cd08d0        	call	_link_drv
10217                     ; 2277 	  pwr_hndl();		//вычисление воздействий на силу
10219  2039 cd0baa        	call	_pwr_hndl
10221                     ; 2278 	  JP_drv();
10223  203c cd0845        	call	_JP_drv
10225                     ; 2279 	  flags_drv();
10227  203f cd112d        	call	_flags_drv
10229                     ; 2280 		net_drv();
10231  2042 cd1618        	call	_net_drv
10233  2045               L1224:
10234                     ; 2283 	if(b5Hz)
10236                     	btst	_b5Hz
10237  204a 240d          	jruge	L3224
10238                     ; 2285 		b5Hz=0;
10240  204c 72110006      	bres	_b5Hz
10241                     ; 2287 		pwr_drv();		//воздействие на силу
10243  2050 cd0a8b        	call	_pwr_drv
10245                     ; 2288 		led_hndl();
10247  2053 cd015f        	call	_led_hndl
10249                     ; 2290 		vent_drv();
10251  2056 cd0928        	call	_vent_drv
10253  2059               L3224:
10254                     ; 2293 	if(b2Hz)
10256                     	btst	_b2Hz
10257  205e 2404          	jruge	L5224
10258                     ; 2295 		b2Hz=0;
10260  2060 72110005      	bres	_b2Hz
10261  2064               L5224:
10262                     ; 2304 	if(b1Hz)
10264                     	btst	_b1Hz
10265  2069 24a0          	jruge	L1124
10266                     ; 2306 		b1Hz=0;
10268  206b 72110004      	bres	_b1Hz
10269                     ; 2308 		temper_drv();			//вычисление аварий температуры
10271  206f cd0e5d        	call	_temper_drv
10273                     ; 2309 		u_drv();
10275  2072 cd0f34        	call	_u_drv
10277                     ; 2310           x_drv();
10279  2075 cd1014        	call	_x_drv
10281                     ; 2311           if(main_cnt<1000)main_cnt++;
10283  2078 9c            	rvf
10284  2079 be51          	ldw	x,_main_cnt
10285  207b a303e8        	cpw	x,#1000
10286  207e 2e07          	jrsge	L1324
10289  2080 be51          	ldw	x,_main_cnt
10290  2082 1c0001        	addw	x,#1
10291  2085 bf51          	ldw	_main_cnt,x
10292  2087               L1324:
10293                     ; 2312   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10295  2087 b663          	ld	a,_link
10296  2089 a1aa          	cp	a,#170
10297  208b 2706          	jreq	L5324
10299  208d b64a          	ld	a,_jp_mode
10300  208f a103          	cp	a,#3
10301  2091 2603          	jrne	L3324
10302  2093               L5324:
10305  2093 cd108e        	call	_apv_hndl
10307  2096               L3324:
10308                     ; 2315   		can_error_cnt++;
10310  2096 3c71          	inc	_can_error_cnt
10311                     ; 2316   		if(can_error_cnt>=10)
10313  2098 b671          	ld	a,_can_error_cnt
10314  209a a10a          	cp	a,#10
10315  209c 2505          	jrult	L7324
10316                     ; 2318   			can_error_cnt=0;
10318  209e 3f71          	clr	_can_error_cnt
10319                     ; 2319 			init_CAN();
10321  20a0 cd14bb        	call	_init_CAN
10323  20a3               L7324:
10324                     ; 2323 		volum_u_main_drv();
10326  20a3 cd1368        	call	_volum_u_main_drv
10328                     ; 2325 		pwm_stat++;
10330  20a6 3c07          	inc	_pwm_stat
10331                     ; 2326 		if(pwm_stat>=10)pwm_stat=0;
10333  20a8 b607          	ld	a,_pwm_stat
10334  20aa a10a          	cp	a,#10
10335  20ac 2502          	jrult	L1424
10338  20ae 3f07          	clr	_pwm_stat
10339  20b0               L1424:
10340                     ; 2327 adc_plazma_short++;
10342  20b0 bec0          	ldw	x,_adc_plazma_short
10343  20b2 1c0001        	addw	x,#1
10344  20b5 bfc0          	ldw	_adc_plazma_short,x
10345                     ; 2329 		vent_resurs_hndl();
10347  20b7 cd0000        	call	_vent_resurs_hndl
10349  20ba ac0b200b      	jpf	L1124
11419                     	xdef	_main
11420                     	xdef	f_ADC2_EOC_Interrupt
11421                     	xdef	f_CAN_TX_Interrupt
11422                     	xdef	f_CAN_RX_Interrupt
11423                     	xdef	f_TIM4_UPD_Interrupt
11424                     	xdef	_adc2_init
11425                     	xdef	_t1_init
11426                     	xdef	_t4_init
11427                     	xdef	_can_in_an
11428                     	xdef	_net_drv
11429                     	xdef	_can_tx_hndl
11430                     	xdef	_can_transmit
11431                     	xdef	_init_CAN
11432                     	xdef	_volum_u_main_drv
11433                     	xdef	_adr_drv_v3
11434                     	xdef	_adr_drv_v4
11435                     	xdef	_flags_drv
11436                     	xdef	_apv_hndl
11437                     	xdef	_apv_stop
11438                     	xdef	_apv_start
11439                     	xdef	_x_drv
11440                     	xdef	_u_drv
11441                     	xdef	_temper_drv
11442                     	xdef	_matemat
11443                     	xdef	_pwr_hndl
11444                     	xdef	_pwr_drv
11445                     	xdef	_vent_drv
11446                     	xdef	_link_drv
11447                     	xdef	_JP_drv
11448                     	xdef	_led_drv
11449                     	xdef	_led_hndl
11450                     	xdef	_delay_ms
11451                     	xdef	_granee
11452                     	xdef	_gran
11453                     	xdef	_vent_resurs_hndl
11454                     	switch	.ubsct
11455  0001               _vent_resurs_tx_cnt:
11456  0001 00            	ds.b	1
11457                     	xdef	_vent_resurs_tx_cnt
11458                     	switch	.bss
11459  0000               _vent_resurs_buff:
11460  0000 00000000      	ds.b	4
11461                     	xdef	_vent_resurs_buff
11462                     	switch	.ubsct
11463  0002               _vent_resurs_sec_cnt:
11464  0002 0000          	ds.b	2
11465                     	xdef	_vent_resurs_sec_cnt
11466                     .eeprom:	section	.data
11467  0000               _vent_resurs:
11468  0000 0000          	ds.b	2
11469                     	xdef	_vent_resurs
11470  0002               _ee_IMAXVENT:
11471  0002 0000          	ds.b	2
11472                     	xdef	_ee_IMAXVENT
11473                     	switch	.ubsct
11474  0004               _bps_class:
11475  0004 00            	ds.b	1
11476                     	xdef	_bps_class
11477  0005               _vent_pwm:
11478  0005 0000          	ds.b	2
11479                     	xdef	_vent_pwm
11480  0007               _pwm_stat:
11481  0007 00            	ds.b	1
11482                     	xdef	_pwm_stat
11483  0008               _pwm_vent_cnt:
11484  0008 00            	ds.b	1
11485                     	xdef	_pwm_vent_cnt
11486                     	switch	.eeprom
11487  0004               _ee_DEVICE:
11488  0004 0000          	ds.b	2
11489                     	xdef	_ee_DEVICE
11490  0006               _ee_AVT_MODE:
11491  0006 0000          	ds.b	2
11492                     	xdef	_ee_AVT_MODE
11493                     	switch	.ubsct
11494  0009               _i_main_bps_cnt:
11495  0009 000000000000  	ds.b	6
11496                     	xdef	_i_main_bps_cnt
11497  000f               _i_main_sigma:
11498  000f 0000          	ds.b	2
11499                     	xdef	_i_main_sigma
11500  0011               _i_main_num_of_bps:
11501  0011 00            	ds.b	1
11502                     	xdef	_i_main_num_of_bps
11503  0012               _i_main_avg:
11504  0012 0000          	ds.b	2
11505                     	xdef	_i_main_avg
11506  0014               _i_main_flag:
11507  0014 000000000000  	ds.b	6
11508                     	xdef	_i_main_flag
11509  001a               _i_main:
11510  001a 000000000000  	ds.b	12
11511                     	xdef	_i_main
11512  0026               _x:
11513  0026 000000000000  	ds.b	12
11514                     	xdef	_x
11515                     	xdef	_volum_u_main_
11516                     	switch	.eeprom
11517  0008               _UU_AVT:
11518  0008 0000          	ds.b	2
11519                     	xdef	_UU_AVT
11520                     	switch	.ubsct
11521  0032               _cnt_net_drv:
11522  0032 00            	ds.b	1
11523                     	xdef	_cnt_net_drv
11524                     	switch	.bit
11525  0001               _bMAIN:
11526  0001 00            	ds.b	1
11527                     	xdef	_bMAIN
11528                     	switch	.ubsct
11529  0033               _plazma_int:
11530  0033 000000000000  	ds.b	6
11531                     	xdef	_plazma_int
11532                     	xdef	_rotor_int
11533  0039               _led_green_buff:
11534  0039 00000000      	ds.b	4
11535                     	xdef	_led_green_buff
11536  003d               _led_red_buff:
11537  003d 00000000      	ds.b	4
11538                     	xdef	_led_red_buff
11539                     	xdef	_led_drv_cnt
11540                     	xdef	_led_green
11541                     	xdef	_led_red
11542  0041               _res_fl_cnt:
11543  0041 00            	ds.b	1
11544                     	xdef	_res_fl_cnt
11545                     	xdef	_bRES_
11546                     	xdef	_bRES
11547                     	switch	.eeprom
11548  000a               _res_fl_:
11549  000a 00            	ds.b	1
11550                     	xdef	_res_fl_
11551  000b               _res_fl:
11552  000b 00            	ds.b	1
11553                     	xdef	_res_fl
11554                     	switch	.ubsct
11555  0042               _cnt_apv_off:
11556  0042 00            	ds.b	1
11557                     	xdef	_cnt_apv_off
11558                     	switch	.bit
11559  0002               _bAPV:
11560  0002 00            	ds.b	1
11561                     	xdef	_bAPV
11562                     	switch	.ubsct
11563  0043               _apv_cnt_:
11564  0043 0000          	ds.b	2
11565                     	xdef	_apv_cnt_
11566  0045               _apv_cnt:
11567  0045 000000        	ds.b	3
11568                     	xdef	_apv_cnt
11569                     	xdef	_bBL_IPS
11570                     	switch	.bit
11571  0003               _bBL:
11572  0003 00            	ds.b	1
11573                     	xdef	_bBL
11574                     	switch	.ubsct
11575  0048               _cnt_JP1:
11576  0048 00            	ds.b	1
11577                     	xdef	_cnt_JP1
11578  0049               _cnt_JP0:
11579  0049 00            	ds.b	1
11580                     	xdef	_cnt_JP0
11581  004a               _jp_mode:
11582  004a 00            	ds.b	1
11583                     	xdef	_jp_mode
11584                     	xdef	_pwm_i
11585                     	xdef	_pwm_u
11586  004b               _tmax_cnt:
11587  004b 0000          	ds.b	2
11588                     	xdef	_tmax_cnt
11589  004d               _tsign_cnt:
11590  004d 0000          	ds.b	2
11591                     	xdef	_tsign_cnt
11592                     	switch	.eeprom
11593  000c               _ee_U_AVT:
11594  000c 0000          	ds.b	2
11595                     	xdef	_ee_U_AVT
11596  000e               _ee_tsign:
11597  000e 0000          	ds.b	2
11598                     	xdef	_ee_tsign
11599  0010               _ee_tmax:
11600  0010 0000          	ds.b	2
11601                     	xdef	_ee_tmax
11602  0012               _ee_dU:
11603  0012 0000          	ds.b	2
11604                     	xdef	_ee_dU
11605  0014               _ee_Umax:
11606  0014 0000          	ds.b	2
11607                     	xdef	_ee_Umax
11608  0016               _ee_TZAS:
11609  0016 0000          	ds.b	2
11610                     	xdef	_ee_TZAS
11611                     	switch	.ubsct
11612  004f               _main_cnt1:
11613  004f 0000          	ds.b	2
11614                     	xdef	_main_cnt1
11615  0051               _main_cnt:
11616  0051 0000          	ds.b	2
11617                     	xdef	_main_cnt
11618  0053               _off_bp_cnt:
11619  0053 00            	ds.b	1
11620                     	xdef	_off_bp_cnt
11621                     	xdef	_vol_i_temp_avar
11622  0054               _flags_tu_cnt_off:
11623  0054 00            	ds.b	1
11624                     	xdef	_flags_tu_cnt_off
11625  0055               _flags_tu_cnt_on:
11626  0055 00            	ds.b	1
11627                     	xdef	_flags_tu_cnt_on
11628  0056               _vol_i_temp:
11629  0056 0000          	ds.b	2
11630                     	xdef	_vol_i_temp
11631  0058               _vol_u_temp:
11632  0058 0000          	ds.b	2
11633                     	xdef	_vol_u_temp
11634                     	switch	.eeprom
11635  0018               __x_ee_:
11636  0018 0000          	ds.b	2
11637                     	xdef	__x_ee_
11638                     	switch	.ubsct
11639  005a               __x_cnt:
11640  005a 0000          	ds.b	2
11641                     	xdef	__x_cnt
11642  005c               __x__:
11643  005c 0000          	ds.b	2
11644                     	xdef	__x__
11645  005e               __x_:
11646  005e 0000          	ds.b	2
11647                     	xdef	__x_
11648  0060               _flags_tu:
11649  0060 00            	ds.b	1
11650                     	xdef	_flags_tu
11651                     	xdef	_flags
11652  0061               _link_cnt:
11653  0061 0000          	ds.b	2
11654                     	xdef	_link_cnt
11655  0063               _link:
11656  0063 00            	ds.b	1
11657                     	xdef	_link
11658  0064               _umin_cnt:
11659  0064 0000          	ds.b	2
11660                     	xdef	_umin_cnt
11661  0066               _umax_cnt:
11662  0066 0000          	ds.b	2
11663                     	xdef	_umax_cnt
11664                     	switch	.eeprom
11665  001a               _ee_K:
11666  001a 000000000000  	ds.b	16
11667                     	xdef	_ee_K
11668                     	switch	.ubsct
11669  0068               _T:
11670  0068 00            	ds.b	1
11671                     	xdef	_T
11672  0069               _Udb:
11673  0069 0000          	ds.b	2
11674                     	xdef	_Udb
11675  006b               _Ui:
11676  006b 0000          	ds.b	2
11677                     	xdef	_Ui
11678  006d               _Un:
11679  006d 0000          	ds.b	2
11680                     	xdef	_Un
11681  006f               _I:
11682  006f 0000          	ds.b	2
11683                     	xdef	_I
11684  0071               _can_error_cnt:
11685  0071 00            	ds.b	1
11686                     	xdef	_can_error_cnt
11687                     	xdef	_bCAN_RX
11688  0072               _tx_busy_cnt:
11689  0072 00            	ds.b	1
11690                     	xdef	_tx_busy_cnt
11691                     	xdef	_bTX_FREE
11692  0073               _can_buff_rd_ptr:
11693  0073 00            	ds.b	1
11694                     	xdef	_can_buff_rd_ptr
11695  0074               _can_buff_wr_ptr:
11696  0074 00            	ds.b	1
11697                     	xdef	_can_buff_wr_ptr
11698  0075               _can_out_buff:
11699  0075 000000000000  	ds.b	64
11700                     	xdef	_can_out_buff
11701                     	switch	.bss
11702  0004               _adress_error:
11703  0004 00            	ds.b	1
11704                     	xdef	_adress_error
11705  0005               _adress:
11706  0005 00            	ds.b	1
11707                     	xdef	_adress
11708  0006               _adr:
11709  0006 000000        	ds.b	3
11710                     	xdef	_adr
11711                     	xdef	_adr_drv_stat
11712                     	xdef	_led_ind
11713                     	switch	.ubsct
11714  00b5               _led_ind_cnt:
11715  00b5 00            	ds.b	1
11716                     	xdef	_led_ind_cnt
11717  00b6               _adc_plazma:
11718  00b6 000000000000  	ds.b	10
11719                     	xdef	_adc_plazma
11720  00c0               _adc_plazma_short:
11721  00c0 0000          	ds.b	2
11722                     	xdef	_adc_plazma_short
11723  00c2               _adc_cnt:
11724  00c2 00            	ds.b	1
11725                     	xdef	_adc_cnt
11726  00c3               _adc_ch:
11727  00c3 00            	ds.b	1
11728                     	xdef	_adc_ch
11729                     	switch	.bss
11730  0009               _adc_buff_:
11731  0009 000000000000  	ds.b	20
11732                     	xdef	_adc_buff_
11733  001d               _adc_buff:
11734  001d 000000000000  	ds.b	320
11735                     	xdef	_adc_buff
11736                     	switch	.ubsct
11737  00c4               _mess:
11738  00c4 000000000000  	ds.b	14
11739                     	xdef	_mess
11740                     	switch	.bit
11741  0004               _b1Hz:
11742  0004 00            	ds.b	1
11743                     	xdef	_b1Hz
11744  0005               _b2Hz:
11745  0005 00            	ds.b	1
11746                     	xdef	_b2Hz
11747  0006               _b5Hz:
11748  0006 00            	ds.b	1
11749                     	xdef	_b5Hz
11750  0007               _b10Hz:
11751  0007 00            	ds.b	1
11752                     	xdef	_b10Hz
11753  0008               _b100Hz:
11754  0008 00            	ds.b	1
11755                     	xdef	_b100Hz
11756                     	xdef	_t0_cnt4
11757                     	xdef	_t0_cnt3
11758                     	xdef	_t0_cnt2
11759                     	xdef	_t0_cnt1
11760                     	xdef	_t0_cnt0
11761                     	xdef	_bVENT_BLOCK
11762                     	xref.b	c_lreg
11763                     	xref.b	c_x
11764                     	xref.b	c_y
11784                     	xref	c_lrsh
11785                     	xref	c_lgadd
11786                     	xref	c_ladd
11787                     	xref	c_umul
11788                     	xref	c_lgmul
11789                     	xref	c_lgsub
11790                     	xref	c_lsbc
11791                     	xref	c_idiv
11792                     	xref	c_ldiv
11793                     	xref	c_itolx
11794                     	xref	c_eewrc
11795                     	xref	c_imul
11796                     	xref	c_ltor
11797                     	xref	c_lgadc
11798                     	xref	c_rtol
11799                     	xref	c_vmul
11800                     	xref	c_eewrw
11801                     	xref	c_lcmp
11802                     	xref	c_uitolx
11803                     	end
