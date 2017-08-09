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
2806                     ; 262 else if(bps_class==bpsIBEP)	//���� ���� �������
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
3261                     ; 376 else if(bps_class==bpsIPS)	//���� ���� ������
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
3922                     ; 547 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//����� ���� � led_red_buff 1 � �� ����� 1
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
3946                     ; 554 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//����� ���� � led_green_buff 1 � �� ����� 1
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
4210                     ; 640 	if(link_cnt==590)flags&=0xc1;		//���� ���������� ����� ������ ����� ���������� ��� ������ � ������� ����������
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
4229                     ; 648 		if(bps_class==bpsIPS)bMAIN=1;	//���� ��� ��������� ��� ������ - �������� ����� �������;
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
4827                     ; 776 TIM1->CCR2H= (char)(pwm_u/256);	
4829  0b74 be0e          	ldw	x,_pwm_u
4830  0b76 90ae0100      	ldw	y,#256
4831  0b7a cd0000        	call	c_idiv
4833  0b7d 9f            	ld	a,xl
4834  0b7e c75267        	ld	21095,a
4835                     ; 777 TIM1->CCR2L= (char)pwm_u;
4837  0b81 55000f5268    	mov	21096,_pwm_u+1
4838                     ; 779 TIM1->CCR1H= (char)(pwm_i/256);	
4840  0b86 be10          	ldw	x,_pwm_i
4841  0b88 90ae0100      	ldw	y,#256
4842  0b8c cd0000        	call	c_idiv
4844  0b8f 9f            	ld	a,xl
4845  0b90 c75265        	ld	21093,a
4846                     ; 780 TIM1->CCR1L= (char)pwm_i;
4848  0b93 5500115266    	mov	21094,_pwm_i+1
4849                     ; 782 TIM1->CCR3H= (char)(vent_pwm/256);	
4851  0b98 be05          	ldw	x,_vent_pwm
4852  0b9a 90ae0100      	ldw	y,#256
4853  0b9e cd0000        	call	c_idiv
4855  0ba1 9f            	ld	a,xl
4856  0ba2 c75269        	ld	21097,a
4857                     ; 783 TIM1->CCR3L= (char)vent_pwm;
4859  0ba5 550006526a    	mov	21098,_vent_pwm+1
4860                     ; 784 }
4863  0baa 81            	ret
4902                     ; 789 void pwr_hndl(void)				
4902                     ; 790 {
4903                     	switch	.text
4904  0bab               _pwr_hndl:
4908                     ; 791 if(jp_mode==jp3)
4910  0bab b64a          	ld	a,_jp_mode
4911  0bad a103          	cp	a,#3
4912  0baf 2627          	jrne	L1242
4913                     ; 793 	if((flags&0b00001010)==0)
4915  0bb1 b60b          	ld	a,_flags
4916  0bb3 a50a          	bcp	a,#10
4917  0bb5 260d          	jrne	L3242
4918                     ; 795 		pwm_u=500;
4920  0bb7 ae01f4        	ldw	x,#500
4921  0bba bf0e          	ldw	_pwm_u,x
4922                     ; 797 		bBL=0;
4924  0bbc 72110003      	bres	_bBL
4926  0bc0 acdf0cdf      	jpf	L1342
4927  0bc4               L3242:
4928                     ; 799 	else if(flags&0b00001010)
4930  0bc4 b60b          	ld	a,_flags
4931  0bc6 a50a          	bcp	a,#10
4932  0bc8 2603          	jrne	L46
4933  0bca cc0cdf        	jp	L1342
4934  0bcd               L46:
4935                     ; 801 		pwm_u=0;
4937  0bcd 5f            	clrw	x
4938  0bce bf0e          	ldw	_pwm_u,x
4939                     ; 803 		bBL=1;
4941  0bd0 72100003      	bset	_bBL
4942  0bd4 acdf0cdf      	jpf	L1342
4943  0bd8               L1242:
4944                     ; 807 else if(jp_mode==jp2)
4946  0bd8 b64a          	ld	a,_jp_mode
4947  0bda a102          	cp	a,#2
4948  0bdc 2610          	jrne	L3342
4949                     ; 809 	pwm_u=0;
4951  0bde 5f            	clrw	x
4952  0bdf bf0e          	ldw	_pwm_u,x
4953                     ; 810 	pwm_i=0x3ff;
4955  0be1 ae03ff        	ldw	x,#1023
4956  0be4 bf10          	ldw	_pwm_i,x
4957                     ; 811 	bBL=0;
4959  0be6 72110003      	bres	_bBL
4961  0bea acdf0cdf      	jpf	L1342
4962  0bee               L3342:
4963                     ; 813 else if(jp_mode==jp1)
4965  0bee b64a          	ld	a,_jp_mode
4966  0bf0 a101          	cp	a,#1
4967  0bf2 2612          	jrne	L7342
4968                     ; 815 	pwm_u=0x3ff;
4970  0bf4 ae03ff        	ldw	x,#1023
4971  0bf7 bf0e          	ldw	_pwm_u,x
4972                     ; 816 	pwm_i=0x3ff;
4974  0bf9 ae03ff        	ldw	x,#1023
4975  0bfc bf10          	ldw	_pwm_i,x
4976                     ; 817 	bBL=0;
4978  0bfe 72110003      	bres	_bBL
4980  0c02 acdf0cdf      	jpf	L1342
4981  0c06               L7342:
4982                     ; 820 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4984                     	btst	_bMAIN
4985  0c0b 2417          	jruge	L3442
4987  0c0d b663          	ld	a,_link
4988  0c0f a155          	cp	a,#85
4989  0c11 2611          	jrne	L3442
4990                     ; 822 	pwm_u=volum_u_main_;
4992  0c13 be1f          	ldw	x,_volum_u_main_
4993  0c15 bf0e          	ldw	_pwm_u,x
4994                     ; 823 	pwm_i=0x3ff;
4996  0c17 ae03ff        	ldw	x,#1023
4997  0c1a bf10          	ldw	_pwm_i,x
4998                     ; 824 	bBL_IPS=0;
5000  0c1c 72110000      	bres	_bBL_IPS
5002  0c20 acdf0cdf      	jpf	L1342
5003  0c24               L3442:
5004                     ; 827 else if(link==OFF)
5006  0c24 b663          	ld	a,_link
5007  0c26 a1aa          	cp	a,#170
5008  0c28 2651          	jrne	L7442
5009                     ; 836  	if(ee_DEVICE)
5011  0c2a ce0004        	ldw	x,_ee_DEVICE
5012  0c2d 270e          	jreq	L1542
5013                     ; 838 		pwm_u=0x00;
5015  0c2f 5f            	clrw	x
5016  0c30 bf0e          	ldw	_pwm_u,x
5017                     ; 839 		pwm_i=0x00;
5019  0c32 5f            	clrw	x
5020  0c33 bf10          	ldw	_pwm_i,x
5021                     ; 840 		bBL=1;
5023  0c35 72100003      	bset	_bBL
5025  0c39 acdf0cdf      	jpf	L1342
5026  0c3d               L1542:
5027                     ; 844 		if((flags&0b00011010)==0)
5029  0c3d b60b          	ld	a,_flags
5030  0c3f a51a          	bcp	a,#26
5031  0c41 2622          	jrne	L5542
5032                     ; 846 			pwm_u=ee_U_AVT;
5034  0c43 ce000c        	ldw	x,_ee_U_AVT
5035  0c46 bf0e          	ldw	_pwm_u,x
5036                     ; 847 			gran(&pwm_u,0,1020);
5038  0c48 ae03fc        	ldw	x,#1020
5039  0c4b 89            	pushw	x
5040  0c4c 5f            	clrw	x
5041  0c4d 89            	pushw	x
5042  0c4e ae000e        	ldw	x,#_pwm_u
5043  0c51 cd00d1        	call	_gran
5045  0c54 5b04          	addw	sp,#4
5046                     ; 848 		    	pwm_i=0x3ff;
5048  0c56 ae03ff        	ldw	x,#1023
5049  0c59 bf10          	ldw	_pwm_i,x
5050                     ; 849 			bBL=0;
5052  0c5b 72110003      	bres	_bBL
5053                     ; 850 			bBL_IPS=0;
5055  0c5f 72110000      	bres	_bBL_IPS
5057  0c63 207a          	jra	L1342
5058  0c65               L5542:
5059                     ; 852 		else if(flags&0b00011010)
5061  0c65 b60b          	ld	a,_flags
5062  0c67 a51a          	bcp	a,#26
5063  0c69 2774          	jreq	L1342
5064                     ; 854 			pwm_u=0;
5066  0c6b 5f            	clrw	x
5067  0c6c bf0e          	ldw	_pwm_u,x
5068                     ; 855 			pwm_i=0;
5070  0c6e 5f            	clrw	x
5071  0c6f bf10          	ldw	_pwm_i,x
5072                     ; 856 			bBL=1;
5074  0c71 72100003      	bset	_bBL
5075                     ; 857 			bBL_IPS=1;
5077  0c75 72100000      	bset	_bBL_IPS
5078  0c79 2064          	jra	L1342
5079  0c7b               L7442:
5080                     ; 866 else	if(link==ON)				//���� ���� �����vol_i_temp_avar
5082  0c7b b663          	ld	a,_link
5083  0c7d a155          	cp	a,#85
5084  0c7f 265e          	jrne	L1342
5085                     ; 868 	if((flags&0b00100000)==0)	//���� ��� ���������� �����
5087  0c81 b60b          	ld	a,_flags
5088  0c83 a520          	bcp	a,#32
5089  0c85 2648          	jrne	L7642
5090                     ; 870 		if(((flags&0b00011110)==0b00000100)) 	//���� ��� ������ ��� ���� ��� �������������
5092  0c87 b60b          	ld	a,_flags
5093  0c89 a41e          	and	a,#30
5094  0c8b a104          	cp	a,#4
5095  0c8d 2610          	jrne	L1742
5096                     ; 872 			pwm_u=vol_u_temp+_x_;					//���������� �� ������ + ������������ �����
5098  0c8f be5e          	ldw	x,__x_
5099  0c91 72bb0058      	addw	x,_vol_u_temp
5100  0c95 bf0e          	ldw	_pwm_u,x
5101                     ; 873 			pwm_i=vol_i_temp_avar;
5103  0c97 be0c          	ldw	x,_vol_i_temp_avar
5104  0c99 bf10          	ldw	_pwm_i,x
5105                     ; 875 			bBL=0;
5107  0c9b 72110003      	bres	_bBL
5108  0c9f               L1742:
5109                     ; 877 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//���� ��� ������ ��� ���� ��� �������������
5111  0c9f b60b          	ld	a,_flags
5112  0ca1 a51a          	bcp	a,#26
5113  0ca3 2706          	jreq	L5742
5115  0ca5 b60b          	ld	a,_flags
5116  0ca7 a540          	bcp	a,#64
5117  0ca9 2712          	jreq	L3742
5118  0cab               L5742:
5119                     ; 879 			pwm_u=vol_u_temp+_x_;					//���������� �� ������ + ������������ �����
5121  0cab be5e          	ldw	x,__x_
5122  0cad 72bb0058      	addw	x,_vol_u_temp
5123  0cb1 bf0e          	ldw	_pwm_u,x
5124                     ; 880 		    	pwm_i=vol_i_temp;
5126  0cb3 be56          	ldw	x,_vol_i_temp
5127  0cb5 bf10          	ldw	_pwm_i,x
5128                     ; 881 			bBL=0;
5130  0cb7 72110003      	bres	_bBL
5132  0cbb 2022          	jra	L1342
5133  0cbd               L3742:
5134                     ; 883 		else if(flags&0b00011010)					//���� ���� ������
5136  0cbd b60b          	ld	a,_flags
5137  0cbf a51a          	bcp	a,#26
5138  0cc1 271c          	jreq	L1342
5139                     ; 885 			pwm_u=0;								//�� ������ ����
5141  0cc3 5f            	clrw	x
5142  0cc4 bf0e          	ldw	_pwm_u,x
5143                     ; 886 			pwm_i=0;
5145  0cc6 5f            	clrw	x
5146  0cc7 bf10          	ldw	_pwm_i,x
5147                     ; 887 			bBL=1;
5149  0cc9 72100003      	bset	_bBL
5150  0ccd 2010          	jra	L1342
5151  0ccf               L7642:
5152                     ; 890 	else if(flags&0b00100000)	//���� ������������ ����� �� ������ ����������
5154  0ccf b60b          	ld	a,_flags
5155  0cd1 a520          	bcp	a,#32
5156  0cd3 270a          	jreq	L1342
5157                     ; 892 		pwm_u=0;
5159  0cd5 5f            	clrw	x
5160  0cd6 bf0e          	ldw	_pwm_u,x
5161                     ; 893 	    	pwm_i=0;
5163  0cd8 5f            	clrw	x
5164  0cd9 bf10          	ldw	_pwm_i,x
5165                     ; 894 		bBL=1;
5167  0cdb 72100003      	bset	_bBL
5168  0cdf               L1342:
5169                     ; 900 }
5172  0cdf 81            	ret
5217                     	switch	.const
5218  000c               L07:
5219  000c 00000258      	dc.l	600
5220  0010               L27:
5221  0010 000003e8      	dc.l	1000
5222  0014               L47:
5223  0014 00000708      	dc.l	1800
5224                     ; 903 void matemat(void)
5224                     ; 904 {
5225                     	switch	.text
5226  0ce0               _matemat:
5228  0ce0 5208          	subw	sp,#8
5229       00000008      OFST:	set	8
5232                     ; 925 temp_SL=adc_buff_[4];
5234  0ce2 ce0011        	ldw	x,_adc_buff_+8
5235  0ce5 cd0000        	call	c_itolx
5237  0ce8 96            	ldw	x,sp
5238  0ce9 1c0005        	addw	x,#OFST-3
5239  0cec cd0000        	call	c_rtol
5241                     ; 926 temp_SL-=ee_K[0][0];
5243  0cef ce001a        	ldw	x,_ee_K
5244  0cf2 cd0000        	call	c_itolx
5246  0cf5 96            	ldw	x,sp
5247  0cf6 1c0005        	addw	x,#OFST-3
5248  0cf9 cd0000        	call	c_lgsub
5250                     ; 927 if(temp_SL<0) temp_SL=0;
5252  0cfc 9c            	rvf
5253  0cfd 0d05          	tnz	(OFST-3,sp)
5254  0cff 2e0a          	jrsge	L5252
5257  0d01 ae0000        	ldw	x,#0
5258  0d04 1f07          	ldw	(OFST-1,sp),x
5259  0d06 ae0000        	ldw	x,#0
5260  0d09 1f05          	ldw	(OFST-3,sp),x
5261  0d0b               L5252:
5262                     ; 928 temp_SL*=ee_K[0][1];
5264  0d0b ce001c        	ldw	x,_ee_K+2
5265  0d0e cd0000        	call	c_itolx
5267  0d11 96            	ldw	x,sp
5268  0d12 1c0005        	addw	x,#OFST-3
5269  0d15 cd0000        	call	c_lgmul
5271                     ; 929 temp_SL/=600;
5273  0d18 96            	ldw	x,sp
5274  0d19 1c0005        	addw	x,#OFST-3
5275  0d1c cd0000        	call	c_ltor
5277  0d1f ae000c        	ldw	x,#L07
5278  0d22 cd0000        	call	c_ldiv
5280  0d25 96            	ldw	x,sp
5281  0d26 1c0005        	addw	x,#OFST-3
5282  0d29 cd0000        	call	c_rtol
5284                     ; 930 I=(signed short)temp_SL;
5286  0d2c 1e07          	ldw	x,(OFST-1,sp)
5287  0d2e bf6f          	ldw	_I,x
5288                     ; 935 temp_SL=(signed long)adc_buff_[1];
5290  0d30 ce000b        	ldw	x,_adc_buff_+2
5291  0d33 cd0000        	call	c_itolx
5293  0d36 96            	ldw	x,sp
5294  0d37 1c0005        	addw	x,#OFST-3
5295  0d3a cd0000        	call	c_rtol
5297                     ; 937 if(temp_SL<0) temp_SL=0;
5299  0d3d 9c            	rvf
5300  0d3e 0d05          	tnz	(OFST-3,sp)
5301  0d40 2e0a          	jrsge	L7252
5304  0d42 ae0000        	ldw	x,#0
5305  0d45 1f07          	ldw	(OFST-1,sp),x
5306  0d47 ae0000        	ldw	x,#0
5307  0d4a 1f05          	ldw	(OFST-3,sp),x
5308  0d4c               L7252:
5309                     ; 938 temp_SL*=(signed long)ee_K[2][1];
5311  0d4c ce0024        	ldw	x,_ee_K+10
5312  0d4f cd0000        	call	c_itolx
5314  0d52 96            	ldw	x,sp
5315  0d53 1c0005        	addw	x,#OFST-3
5316  0d56 cd0000        	call	c_lgmul
5318                     ; 939 temp_SL/=1000L;
5320  0d59 96            	ldw	x,sp
5321  0d5a 1c0005        	addw	x,#OFST-3
5322  0d5d cd0000        	call	c_ltor
5324  0d60 ae0010        	ldw	x,#L27
5325  0d63 cd0000        	call	c_ldiv
5327  0d66 96            	ldw	x,sp
5328  0d67 1c0005        	addw	x,#OFST-3
5329  0d6a cd0000        	call	c_rtol
5331                     ; 940 Ui=(unsigned short)temp_SL;
5333  0d6d 1e07          	ldw	x,(OFST-1,sp)
5334  0d6f bf6b          	ldw	_Ui,x
5335                     ; 947 temp_SL=adc_buff_[3];
5337  0d71 ce000f        	ldw	x,_adc_buff_+6
5338  0d74 cd0000        	call	c_itolx
5340  0d77 96            	ldw	x,sp
5341  0d78 1c0005        	addw	x,#OFST-3
5342  0d7b cd0000        	call	c_rtol
5344                     ; 949 if(temp_SL<0) temp_SL=0;
5346  0d7e 9c            	rvf
5347  0d7f 0d05          	tnz	(OFST-3,sp)
5348  0d81 2e0a          	jrsge	L1352
5351  0d83 ae0000        	ldw	x,#0
5352  0d86 1f07          	ldw	(OFST-1,sp),x
5353  0d88 ae0000        	ldw	x,#0
5354  0d8b 1f05          	ldw	(OFST-3,sp),x
5355  0d8d               L1352:
5356                     ; 950 temp_SL*=ee_K[1][1];
5358  0d8d ce0020        	ldw	x,_ee_K+6
5359  0d90 cd0000        	call	c_itolx
5361  0d93 96            	ldw	x,sp
5362  0d94 1c0005        	addw	x,#OFST-3
5363  0d97 cd0000        	call	c_lgmul
5365                     ; 951 temp_SL/=1800;
5367  0d9a 96            	ldw	x,sp
5368  0d9b 1c0005        	addw	x,#OFST-3
5369  0d9e cd0000        	call	c_ltor
5371  0da1 ae0014        	ldw	x,#L47
5372  0da4 cd0000        	call	c_ldiv
5374  0da7 96            	ldw	x,sp
5375  0da8 1c0005        	addw	x,#OFST-3
5376  0dab cd0000        	call	c_rtol
5378                     ; 952 Un=(unsigned short)temp_SL;
5380  0dae 1e07          	ldw	x,(OFST-1,sp)
5381  0db0 bf6d          	ldw	_Un,x
5382                     ; 955 temp_SL=adc_buff_[2];
5384  0db2 ce000d        	ldw	x,_adc_buff_+4
5385  0db5 cd0000        	call	c_itolx
5387  0db8 96            	ldw	x,sp
5388  0db9 1c0005        	addw	x,#OFST-3
5389  0dbc cd0000        	call	c_rtol
5391                     ; 956 temp_SL*=ee_K[3][1];
5393  0dbf ce0028        	ldw	x,_ee_K+14
5394  0dc2 cd0000        	call	c_itolx
5396  0dc5 96            	ldw	x,sp
5397  0dc6 1c0005        	addw	x,#OFST-3
5398  0dc9 cd0000        	call	c_lgmul
5400                     ; 957 temp_SL/=1000;
5402  0dcc 96            	ldw	x,sp
5403  0dcd 1c0005        	addw	x,#OFST-3
5404  0dd0 cd0000        	call	c_ltor
5406  0dd3 ae0010        	ldw	x,#L27
5407  0dd6 cd0000        	call	c_ldiv
5409  0dd9 96            	ldw	x,sp
5410  0dda 1c0005        	addw	x,#OFST-3
5411  0ddd cd0000        	call	c_rtol
5413                     ; 958 T=(signed short)(temp_SL-273L);
5415  0de0 7b08          	ld	a,(OFST+0,sp)
5416  0de2 5f            	clrw	x
5417  0de3 4d            	tnz	a
5418  0de4 2a01          	jrpl	L67
5419  0de6 53            	cplw	x
5420  0de7               L67:
5421  0de7 97            	ld	xl,a
5422  0de8 1d0111        	subw	x,#273
5423  0deb 01            	rrwa	x,a
5424  0dec b768          	ld	_T,a
5425  0dee 02            	rlwa	x,a
5426                     ; 959 if(T<-30)T=-30;
5428  0def 9c            	rvf
5429  0df0 b668          	ld	a,_T
5430  0df2 a1e2          	cp	a,#226
5431  0df4 2e04          	jrsge	L3352
5434  0df6 35e20068      	mov	_T,#226
5435  0dfa               L3352:
5436                     ; 960 if(T>120)T=120;
5438  0dfa 9c            	rvf
5439  0dfb b668          	ld	a,_T
5440  0dfd a179          	cp	a,#121
5441  0dff 2f04          	jrslt	L5352
5444  0e01 35780068      	mov	_T,#120
5445  0e05               L5352:
5446                     ; 962 Udb=flags;
5448  0e05 b60b          	ld	a,_flags
5449  0e07 5f            	clrw	x
5450  0e08 97            	ld	xl,a
5451  0e09 bf69          	ldw	_Udb,x
5452                     ; 968 temp_SL=(signed long)(T-ee_tsign);
5454  0e0b 5f            	clrw	x
5455  0e0c b668          	ld	a,_T
5456  0e0e 2a01          	jrpl	L001
5457  0e10 53            	cplw	x
5458  0e11               L001:
5459  0e11 97            	ld	xl,a
5460  0e12 72b0000e      	subw	x,_ee_tsign
5461  0e16 cd0000        	call	c_itolx
5463  0e19 96            	ldw	x,sp
5464  0e1a 1c0005        	addw	x,#OFST-3
5465  0e1d cd0000        	call	c_rtol
5467                     ; 969 temp_SL*=1000L;
5469  0e20 ae03e8        	ldw	x,#1000
5470  0e23 bf02          	ldw	c_lreg+2,x
5471  0e25 ae0000        	ldw	x,#0
5472  0e28 bf00          	ldw	c_lreg,x
5473  0e2a 96            	ldw	x,sp
5474  0e2b 1c0005        	addw	x,#OFST-3
5475  0e2e cd0000        	call	c_lgmul
5477                     ; 970 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5479  0e31 ce0010        	ldw	x,_ee_tmax
5480  0e34 72b0000e      	subw	x,_ee_tsign
5481  0e38 cd0000        	call	c_itolx
5483  0e3b 96            	ldw	x,sp
5484  0e3c 1c0001        	addw	x,#OFST-7
5485  0e3f cd0000        	call	c_rtol
5487  0e42 96            	ldw	x,sp
5488  0e43 1c0005        	addw	x,#OFST-3
5489  0e46 cd0000        	call	c_ltor
5491  0e49 96            	ldw	x,sp
5492  0e4a 1c0001        	addw	x,#OFST-7
5493  0e4d cd0000        	call	c_ldiv
5495  0e50 96            	ldw	x,sp
5496  0e51 1c0005        	addw	x,#OFST-3
5497  0e54 cd0000        	call	c_rtol
5499                     ; 972 vol_i_temp_avar=(unsigned short)temp_SL; 
5501  0e57 1e07          	ldw	x,(OFST-1,sp)
5502  0e59 bf0c          	ldw	_vol_i_temp_avar,x
5503                     ; 974 }
5506  0e5b 5b08          	addw	sp,#8
5507  0e5d 81            	ret
5538                     ; 977 void temper_drv(void)		//1 Hz
5538                     ; 978 {
5539                     	switch	.text
5540  0e5e               _temper_drv:
5544                     ; 980 if(T>ee_tsign) tsign_cnt++;
5546  0e5e 9c            	rvf
5547  0e5f 5f            	clrw	x
5548  0e60 b668          	ld	a,_T
5549  0e62 2a01          	jrpl	L401
5550  0e64 53            	cplw	x
5551  0e65               L401:
5552  0e65 97            	ld	xl,a
5553  0e66 c3000e        	cpw	x,_ee_tsign
5554  0e69 2d09          	jrsle	L7452
5557  0e6b be4d          	ldw	x,_tsign_cnt
5558  0e6d 1c0001        	addw	x,#1
5559  0e70 bf4d          	ldw	_tsign_cnt,x
5561  0e72 201d          	jra	L1552
5562  0e74               L7452:
5563                     ; 981 else if (T<(ee_tsign-1)) tsign_cnt--;
5565  0e74 9c            	rvf
5566  0e75 ce000e        	ldw	x,_ee_tsign
5567  0e78 5a            	decw	x
5568  0e79 905f          	clrw	y
5569  0e7b b668          	ld	a,_T
5570  0e7d 2a02          	jrpl	L601
5571  0e7f 9053          	cplw	y
5572  0e81               L601:
5573  0e81 9097          	ld	yl,a
5574  0e83 90bf00        	ldw	c_y,y
5575  0e86 b300          	cpw	x,c_y
5576  0e88 2d07          	jrsle	L1552
5579  0e8a be4d          	ldw	x,_tsign_cnt
5580  0e8c 1d0001        	subw	x,#1
5581  0e8f bf4d          	ldw	_tsign_cnt,x
5582  0e91               L1552:
5583                     ; 983 gran(&tsign_cnt,0,60);
5585  0e91 ae003c        	ldw	x,#60
5586  0e94 89            	pushw	x
5587  0e95 5f            	clrw	x
5588  0e96 89            	pushw	x
5589  0e97 ae004d        	ldw	x,#_tsign_cnt
5590  0e9a cd00d1        	call	_gran
5592  0e9d 5b04          	addw	sp,#4
5593                     ; 985 if(tsign_cnt>=55)
5595  0e9f 9c            	rvf
5596  0ea0 be4d          	ldw	x,_tsign_cnt
5597  0ea2 a30037        	cpw	x,#55
5598  0ea5 2f16          	jrslt	L5552
5599                     ; 987 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //������� ��� ��������� 
5601  0ea7 3d4a          	tnz	_jp_mode
5602  0ea9 2606          	jrne	L3652
5604  0eab b60b          	ld	a,_flags
5605  0ead a540          	bcp	a,#64
5606  0eaf 2706          	jreq	L1652
5607  0eb1               L3652:
5609  0eb1 b64a          	ld	a,_jp_mode
5610  0eb3 a103          	cp	a,#3
5611  0eb5 2612          	jrne	L5652
5612  0eb7               L1652:
5615  0eb7 7214000b      	bset	_flags,#2
5616  0ebb 200c          	jra	L5652
5617  0ebd               L5552:
5618                     ; 989 else if (tsign_cnt<=5) flags&=0b11111011;	//�������� ��� ���������
5620  0ebd 9c            	rvf
5621  0ebe be4d          	ldw	x,_tsign_cnt
5622  0ec0 a30006        	cpw	x,#6
5623  0ec3 2e04          	jrsge	L5652
5626  0ec5 7215000b      	bres	_flags,#2
5627  0ec9               L5652:
5628                     ; 994 if(T>ee_tmax) tmax_cnt++;
5630  0ec9 9c            	rvf
5631  0eca 5f            	clrw	x
5632  0ecb b668          	ld	a,_T
5633  0ecd 2a01          	jrpl	L011
5634  0ecf 53            	cplw	x
5635  0ed0               L011:
5636  0ed0 97            	ld	xl,a
5637  0ed1 c30010        	cpw	x,_ee_tmax
5638  0ed4 2d09          	jrsle	L1752
5641  0ed6 be4b          	ldw	x,_tmax_cnt
5642  0ed8 1c0001        	addw	x,#1
5643  0edb bf4b          	ldw	_tmax_cnt,x
5645  0edd 201d          	jra	L3752
5646  0edf               L1752:
5647                     ; 995 else if (T<(ee_tmax-1)) tmax_cnt--;
5649  0edf 9c            	rvf
5650  0ee0 ce0010        	ldw	x,_ee_tmax
5651  0ee3 5a            	decw	x
5652  0ee4 905f          	clrw	y
5653  0ee6 b668          	ld	a,_T
5654  0ee8 2a02          	jrpl	L211
5655  0eea 9053          	cplw	y
5656  0eec               L211:
5657  0eec 9097          	ld	yl,a
5658  0eee 90bf00        	ldw	c_y,y
5659  0ef1 b300          	cpw	x,c_y
5660  0ef3 2d07          	jrsle	L3752
5663  0ef5 be4b          	ldw	x,_tmax_cnt
5664  0ef7 1d0001        	subw	x,#1
5665  0efa bf4b          	ldw	_tmax_cnt,x
5666  0efc               L3752:
5667                     ; 997 gran(&tmax_cnt,0,60);
5669  0efc ae003c        	ldw	x,#60
5670  0eff 89            	pushw	x
5671  0f00 5f            	clrw	x
5672  0f01 89            	pushw	x
5673  0f02 ae004b        	ldw	x,#_tmax_cnt
5674  0f05 cd00d1        	call	_gran
5676  0f08 5b04          	addw	sp,#4
5677                     ; 999 if(tmax_cnt>=55)
5679  0f0a 9c            	rvf
5680  0f0b be4b          	ldw	x,_tmax_cnt
5681  0f0d a30037        	cpw	x,#55
5682  0f10 2f16          	jrslt	L7752
5683                     ; 1001 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5685  0f12 3d4a          	tnz	_jp_mode
5686  0f14 2606          	jrne	L5062
5688  0f16 b60b          	ld	a,_flags
5689  0f18 a540          	bcp	a,#64
5690  0f1a 2706          	jreq	L3062
5691  0f1c               L5062:
5693  0f1c b64a          	ld	a,_jp_mode
5694  0f1e a103          	cp	a,#3
5695  0f20 2612          	jrne	L7062
5696  0f22               L3062:
5699  0f22 7212000b      	bset	_flags,#1
5700  0f26 200c          	jra	L7062
5701  0f28               L7752:
5702                     ; 1003 else if (tmax_cnt<=5) flags&=0b11111101;
5704  0f28 9c            	rvf
5705  0f29 be4b          	ldw	x,_tmax_cnt
5706  0f2b a30006        	cpw	x,#6
5707  0f2e 2e04          	jrsge	L7062
5710  0f30 7213000b      	bres	_flags,#1
5711  0f34               L7062:
5712                     ; 1006 } 
5715  0f34 81            	ret
5747                     ; 1009 void u_drv(void)		//1Hz
5747                     ; 1010 { 
5748                     	switch	.text
5749  0f35               _u_drv:
5753                     ; 1011 if(jp_mode!=jp3)
5755  0f35 b64a          	ld	a,_jp_mode
5756  0f37 a103          	cp	a,#3
5757  0f39 2770          	jreq	L3262
5758                     ; 1013 	if(Ui>ee_Umax)umax_cnt++;
5760  0f3b 9c            	rvf
5761  0f3c be6b          	ldw	x,_Ui
5762  0f3e c30014        	cpw	x,_ee_Umax
5763  0f41 2d09          	jrsle	L5262
5766  0f43 be66          	ldw	x,_umax_cnt
5767  0f45 1c0001        	addw	x,#1
5768  0f48 bf66          	ldw	_umax_cnt,x
5770  0f4a 2003          	jra	L7262
5771  0f4c               L5262:
5772                     ; 1014 	else umax_cnt=0;
5774  0f4c 5f            	clrw	x
5775  0f4d bf66          	ldw	_umax_cnt,x
5776  0f4f               L7262:
5777                     ; 1015 	gran(&umax_cnt,0,10);
5779  0f4f ae000a        	ldw	x,#10
5780  0f52 89            	pushw	x
5781  0f53 5f            	clrw	x
5782  0f54 89            	pushw	x
5783  0f55 ae0066        	ldw	x,#_umax_cnt
5784  0f58 cd00d1        	call	_gran
5786  0f5b 5b04          	addw	sp,#4
5787                     ; 1016 	if(umax_cnt>=10)flags|=0b00001000; 	//������� ������ �� ���������� ����������
5789  0f5d 9c            	rvf
5790  0f5e be66          	ldw	x,_umax_cnt
5791  0f60 a3000a        	cpw	x,#10
5792  0f63 2f04          	jrslt	L1362
5795  0f65 7216000b      	bset	_flags,#3
5796  0f69               L1362:
5797                     ; 1019 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5799  0f69 9c            	rvf
5800  0f6a be6b          	ldw	x,_Ui
5801  0f6c b36d          	cpw	x,_Un
5802  0f6e 2e1c          	jrsge	L3362
5804  0f70 9c            	rvf
5805  0f71 be6d          	ldw	x,_Un
5806  0f73 72b0006b      	subw	x,_Ui
5807  0f77 c30012        	cpw	x,_ee_dU
5808  0f7a 2d10          	jrsle	L3362
5810  0f7c c65005        	ld	a,20485
5811  0f7f a504          	bcp	a,#4
5812  0f81 2609          	jrne	L3362
5815  0f83 be64          	ldw	x,_umin_cnt
5816  0f85 1c0001        	addw	x,#1
5817  0f88 bf64          	ldw	_umin_cnt,x
5819  0f8a 2003          	jra	L5362
5820  0f8c               L3362:
5821                     ; 1020 	else umin_cnt=0;
5823  0f8c 5f            	clrw	x
5824  0f8d bf64          	ldw	_umin_cnt,x
5825  0f8f               L5362:
5826                     ; 1021 	gran(&umin_cnt,0,10);	
5828  0f8f ae000a        	ldw	x,#10
5829  0f92 89            	pushw	x
5830  0f93 5f            	clrw	x
5831  0f94 89            	pushw	x
5832  0f95 ae0064        	ldw	x,#_umin_cnt
5833  0f98 cd00d1        	call	_gran
5835  0f9b 5b04          	addw	sp,#4
5836                     ; 1022 	if(umin_cnt>=10)flags|=0b00010000;	  
5838  0f9d 9c            	rvf
5839  0f9e be64          	ldw	x,_umin_cnt
5840  0fa0 a3000a        	cpw	x,#10
5841  0fa3 2f6f          	jrslt	L1462
5844  0fa5 7218000b      	bset	_flags,#4
5845  0fa9 2069          	jra	L1462
5846  0fab               L3262:
5847                     ; 1024 else if(jp_mode==jp3)
5849  0fab b64a          	ld	a,_jp_mode
5850  0fad a103          	cp	a,#3
5851  0faf 2663          	jrne	L1462
5852                     ; 1026 	if(Ui>700)umax_cnt++;
5854  0fb1 9c            	rvf
5855  0fb2 be6b          	ldw	x,_Ui
5856  0fb4 a302bd        	cpw	x,#701
5857  0fb7 2f09          	jrslt	L5462
5860  0fb9 be66          	ldw	x,_umax_cnt
5861  0fbb 1c0001        	addw	x,#1
5862  0fbe bf66          	ldw	_umax_cnt,x
5864  0fc0 2003          	jra	L7462
5865  0fc2               L5462:
5866                     ; 1027 	else umax_cnt=0;
5868  0fc2 5f            	clrw	x
5869  0fc3 bf66          	ldw	_umax_cnt,x
5870  0fc5               L7462:
5871                     ; 1028 	gran(&umax_cnt,0,10);
5873  0fc5 ae000a        	ldw	x,#10
5874  0fc8 89            	pushw	x
5875  0fc9 5f            	clrw	x
5876  0fca 89            	pushw	x
5877  0fcb ae0066        	ldw	x,#_umax_cnt
5878  0fce cd00d1        	call	_gran
5880  0fd1 5b04          	addw	sp,#4
5881                     ; 1029 	if(umax_cnt>=10)flags|=0b00001000;
5883  0fd3 9c            	rvf
5884  0fd4 be66          	ldw	x,_umax_cnt
5885  0fd6 a3000a        	cpw	x,#10
5886  0fd9 2f04          	jrslt	L1562
5889  0fdb 7216000b      	bset	_flags,#3
5890  0fdf               L1562:
5891                     ; 1032 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5893  0fdf 9c            	rvf
5894  0fe0 be6b          	ldw	x,_Ui
5895  0fe2 a300c8        	cpw	x,#200
5896  0fe5 2e10          	jrsge	L3562
5898  0fe7 c65005        	ld	a,20485
5899  0fea a504          	bcp	a,#4
5900  0fec 2609          	jrne	L3562
5903  0fee be64          	ldw	x,_umin_cnt
5904  0ff0 1c0001        	addw	x,#1
5905  0ff3 bf64          	ldw	_umin_cnt,x
5907  0ff5 2003          	jra	L5562
5908  0ff7               L3562:
5909                     ; 1033 	else umin_cnt=0;
5911  0ff7 5f            	clrw	x
5912  0ff8 bf64          	ldw	_umin_cnt,x
5913  0ffa               L5562:
5914                     ; 1034 	gran(&umin_cnt,0,10);	
5916  0ffa ae000a        	ldw	x,#10
5917  0ffd 89            	pushw	x
5918  0ffe 5f            	clrw	x
5919  0fff 89            	pushw	x
5920  1000 ae0064        	ldw	x,#_umin_cnt
5921  1003 cd00d1        	call	_gran
5923  1006 5b04          	addw	sp,#4
5924                     ; 1035 	if(umin_cnt>=10)flags|=0b00010000;	  
5926  1008 9c            	rvf
5927  1009 be64          	ldw	x,_umin_cnt
5928  100b a3000a        	cpw	x,#10
5929  100e 2f04          	jrslt	L1462
5932  1010 7218000b      	bset	_flags,#4
5933  1014               L1462:
5934                     ; 1037 }
5937  1014 81            	ret
5964                     ; 1040 void x_drv(void)
5964                     ; 1041 {
5965                     	switch	.text
5966  1015               _x_drv:
5970                     ; 1042 if(_x__==_x_)
5972  1015 be5c          	ldw	x,__x__
5973  1017 b35e          	cpw	x,__x_
5974  1019 262a          	jrne	L1762
5975                     ; 1044 	if(_x_cnt<60)
5977  101b 9c            	rvf
5978  101c be5a          	ldw	x,__x_cnt
5979  101e a3003c        	cpw	x,#60
5980  1021 2e25          	jrsge	L1072
5981                     ; 1046 		_x_cnt++;
5983  1023 be5a          	ldw	x,__x_cnt
5984  1025 1c0001        	addw	x,#1
5985  1028 bf5a          	ldw	__x_cnt,x
5986                     ; 1047 		if(_x_cnt>=60)
5988  102a 9c            	rvf
5989  102b be5a          	ldw	x,__x_cnt
5990  102d a3003c        	cpw	x,#60
5991  1030 2f16          	jrslt	L1072
5992                     ; 1049 			if(_x_ee_!=_x_)_x_ee_=_x_;
5994  1032 ce0018        	ldw	x,__x_ee_
5995  1035 b35e          	cpw	x,__x_
5996  1037 270f          	jreq	L1072
5999  1039 be5e          	ldw	x,__x_
6000  103b 89            	pushw	x
6001  103c ae0018        	ldw	x,#__x_ee_
6002  103f cd0000        	call	c_eewrw
6004  1042 85            	popw	x
6005  1043 2003          	jra	L1072
6006  1045               L1762:
6007                     ; 1054 else _x_cnt=0;
6009  1045 5f            	clrw	x
6010  1046 bf5a          	ldw	__x_cnt,x
6011  1048               L1072:
6012                     ; 1056 if(_x_cnt>60) _x_cnt=0;	
6014  1048 9c            	rvf
6015  1049 be5a          	ldw	x,__x_cnt
6016  104b a3003d        	cpw	x,#61
6017  104e 2f03          	jrslt	L3072
6020  1050 5f            	clrw	x
6021  1051 bf5a          	ldw	__x_cnt,x
6022  1053               L3072:
6023                     ; 1058 _x__=_x_;
6025  1053 be5e          	ldw	x,__x_
6026  1055 bf5c          	ldw	__x__,x
6027                     ; 1059 }
6030  1057 81            	ret
6056                     ; 1062 void apv_start(void)
6056                     ; 1063 {
6057                     	switch	.text
6058  1058               _apv_start:
6062                     ; 1064 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6064  1058 3d45          	tnz	_apv_cnt
6065  105a 2624          	jrne	L5172
6067  105c 3d46          	tnz	_apv_cnt+1
6068  105e 2620          	jrne	L5172
6070  1060 3d47          	tnz	_apv_cnt+2
6071  1062 261c          	jrne	L5172
6073                     	btst	_bAPV
6074  1069 2515          	jrult	L5172
6075                     ; 1066 	apv_cnt[0]=60;
6077  106b 353c0045      	mov	_apv_cnt,#60
6078                     ; 1067 	apv_cnt[1]=60;
6080  106f 353c0046      	mov	_apv_cnt+1,#60
6081                     ; 1068 	apv_cnt[2]=60;
6083  1073 353c0047      	mov	_apv_cnt+2,#60
6084                     ; 1069 	apv_cnt_=3600;
6086  1077 ae0e10        	ldw	x,#3600
6087  107a bf43          	ldw	_apv_cnt_,x
6088                     ; 1070 	bAPV=1;	
6090  107c 72100002      	bset	_bAPV
6091  1080               L5172:
6092                     ; 1072 }
6095  1080 81            	ret
6121                     ; 1075 void apv_stop(void)
6121                     ; 1076 {
6122                     	switch	.text
6123  1081               _apv_stop:
6127                     ; 1077 apv_cnt[0]=0;
6129  1081 3f45          	clr	_apv_cnt
6130                     ; 1078 apv_cnt[1]=0;
6132  1083 3f46          	clr	_apv_cnt+1
6133                     ; 1079 apv_cnt[2]=0;
6135  1085 3f47          	clr	_apv_cnt+2
6136                     ; 1080 apv_cnt_=0;	
6138  1087 5f            	clrw	x
6139  1088 bf43          	ldw	_apv_cnt_,x
6140                     ; 1081 bAPV=0;
6142  108a 72110002      	bres	_bAPV
6143                     ; 1082 }
6146  108e 81            	ret
6181                     ; 1086 void apv_hndl(void)
6181                     ; 1087 {
6182                     	switch	.text
6183  108f               _apv_hndl:
6187                     ; 1088 if(apv_cnt[0])
6189  108f 3d45          	tnz	_apv_cnt
6190  1091 271e          	jreq	L7372
6191                     ; 1090 	apv_cnt[0]--;
6193  1093 3a45          	dec	_apv_cnt
6194                     ; 1091 	if(apv_cnt[0]==0)
6196  1095 3d45          	tnz	_apv_cnt
6197  1097 265a          	jrne	L3472
6198                     ; 1093 		flags&=0b11100001;
6200  1099 b60b          	ld	a,_flags
6201  109b a4e1          	and	a,#225
6202  109d b70b          	ld	_flags,a
6203                     ; 1094 		tsign_cnt=0;
6205  109f 5f            	clrw	x
6206  10a0 bf4d          	ldw	_tsign_cnt,x
6207                     ; 1095 		tmax_cnt=0;
6209  10a2 5f            	clrw	x
6210  10a3 bf4b          	ldw	_tmax_cnt,x
6211                     ; 1096 		umax_cnt=0;
6213  10a5 5f            	clrw	x
6214  10a6 bf66          	ldw	_umax_cnt,x
6215                     ; 1097 		umin_cnt=0;
6217  10a8 5f            	clrw	x
6218  10a9 bf64          	ldw	_umin_cnt,x
6219                     ; 1099 		led_drv_cnt=30;
6221  10ab 351e001c      	mov	_led_drv_cnt,#30
6222  10af 2042          	jra	L3472
6223  10b1               L7372:
6224                     ; 1102 else if(apv_cnt[1])
6226  10b1 3d46          	tnz	_apv_cnt+1
6227  10b3 271e          	jreq	L5472
6228                     ; 1104 	apv_cnt[1]--;
6230  10b5 3a46          	dec	_apv_cnt+1
6231                     ; 1105 	if(apv_cnt[1]==0)
6233  10b7 3d46          	tnz	_apv_cnt+1
6234  10b9 2638          	jrne	L3472
6235                     ; 1107 		flags&=0b11100001;
6237  10bb b60b          	ld	a,_flags
6238  10bd a4e1          	and	a,#225
6239  10bf b70b          	ld	_flags,a
6240                     ; 1108 		tsign_cnt=0;
6242  10c1 5f            	clrw	x
6243  10c2 bf4d          	ldw	_tsign_cnt,x
6244                     ; 1109 		tmax_cnt=0;
6246  10c4 5f            	clrw	x
6247  10c5 bf4b          	ldw	_tmax_cnt,x
6248                     ; 1110 		umax_cnt=0;
6250  10c7 5f            	clrw	x
6251  10c8 bf66          	ldw	_umax_cnt,x
6252                     ; 1111 		umin_cnt=0;
6254  10ca 5f            	clrw	x
6255  10cb bf64          	ldw	_umin_cnt,x
6256                     ; 1113 		led_drv_cnt=30;
6258  10cd 351e001c      	mov	_led_drv_cnt,#30
6259  10d1 2020          	jra	L3472
6260  10d3               L5472:
6261                     ; 1116 else if(apv_cnt[2])
6263  10d3 3d47          	tnz	_apv_cnt+2
6264  10d5 271c          	jreq	L3472
6265                     ; 1118 	apv_cnt[2]--;
6267  10d7 3a47          	dec	_apv_cnt+2
6268                     ; 1119 	if(apv_cnt[2]==0)
6270  10d9 3d47          	tnz	_apv_cnt+2
6271  10db 2616          	jrne	L3472
6272                     ; 1121 		flags&=0b11100001;
6274  10dd b60b          	ld	a,_flags
6275  10df a4e1          	and	a,#225
6276  10e1 b70b          	ld	_flags,a
6277                     ; 1122 		tsign_cnt=0;
6279  10e3 5f            	clrw	x
6280  10e4 bf4d          	ldw	_tsign_cnt,x
6281                     ; 1123 		tmax_cnt=0;
6283  10e6 5f            	clrw	x
6284  10e7 bf4b          	ldw	_tmax_cnt,x
6285                     ; 1124 		umax_cnt=0;
6287  10e9 5f            	clrw	x
6288  10ea bf66          	ldw	_umax_cnt,x
6289                     ; 1125 		umin_cnt=0;          
6291  10ec 5f            	clrw	x
6292  10ed bf64          	ldw	_umin_cnt,x
6293                     ; 1127 		led_drv_cnt=30;
6295  10ef 351e001c      	mov	_led_drv_cnt,#30
6296  10f3               L3472:
6297                     ; 1131 if(apv_cnt_)
6299  10f3 be43          	ldw	x,_apv_cnt_
6300  10f5 2712          	jreq	L7572
6301                     ; 1133 	apv_cnt_--;
6303  10f7 be43          	ldw	x,_apv_cnt_
6304  10f9 1d0001        	subw	x,#1
6305  10fc bf43          	ldw	_apv_cnt_,x
6306                     ; 1134 	if(apv_cnt_==0) 
6308  10fe be43          	ldw	x,_apv_cnt_
6309  1100 2607          	jrne	L7572
6310                     ; 1136 		bAPV=0;
6312  1102 72110002      	bres	_bAPV
6313                     ; 1137 		apv_start();
6315  1106 cd1058        	call	_apv_start
6317  1109               L7572:
6318                     ; 1141 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6320  1109 be64          	ldw	x,_umin_cnt
6321  110b 261e          	jrne	L3672
6323  110d be66          	ldw	x,_umax_cnt
6324  110f 261a          	jrne	L3672
6326  1111 c65005        	ld	a,20485
6327  1114 a504          	bcp	a,#4
6328  1116 2613          	jrne	L3672
6329                     ; 1143 	if(cnt_apv_off<20)
6331  1118 b642          	ld	a,_cnt_apv_off
6332  111a a114          	cp	a,#20
6333  111c 240f          	jruge	L1772
6334                     ; 1145 		cnt_apv_off++;
6336  111e 3c42          	inc	_cnt_apv_off
6337                     ; 1146 		if(cnt_apv_off>=20)
6339  1120 b642          	ld	a,_cnt_apv_off
6340  1122 a114          	cp	a,#20
6341  1124 2507          	jrult	L1772
6342                     ; 1148 			apv_stop();
6344  1126 cd1081        	call	_apv_stop
6346  1129 2002          	jra	L1772
6347  112b               L3672:
6348                     ; 1152 else cnt_apv_off=0;	
6350  112b 3f42          	clr	_cnt_apv_off
6351  112d               L1772:
6352                     ; 1154 }
6355  112d 81            	ret
6358                     	switch	.ubsct
6359  0000               L3772_flags_old:
6360  0000 00            	ds.b	1
6396                     ; 1157 void flags_drv(void)
6396                     ; 1158 {
6397                     	switch	.text
6398  112e               _flags_drv:
6402                     ; 1160 if(jp_mode!=jp3) 
6404  112e b64a          	ld	a,_jp_mode
6405  1130 a103          	cp	a,#3
6406  1132 2723          	jreq	L3103
6407                     ; 1162 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6409  1134 b60b          	ld	a,_flags
6410  1136 a508          	bcp	a,#8
6411  1138 2706          	jreq	L1203
6413  113a b600          	ld	a,L3772_flags_old
6414  113c a508          	bcp	a,#8
6415  113e 270c          	jreq	L7103
6416  1140               L1203:
6418  1140 b60b          	ld	a,_flags
6419  1142 a510          	bcp	a,#16
6420  1144 2726          	jreq	L5203
6422  1146 b600          	ld	a,L3772_flags_old
6423  1148 a510          	bcp	a,#16
6424  114a 2620          	jrne	L5203
6425  114c               L7103:
6426                     ; 1164     		if(link==OFF)apv_start();
6428  114c b663          	ld	a,_link
6429  114e a1aa          	cp	a,#170
6430  1150 261a          	jrne	L5203
6433  1152 cd1058        	call	_apv_start
6435  1155 2015          	jra	L5203
6436  1157               L3103:
6437                     ; 1167 else if(jp_mode==jp3) 
6439  1157 b64a          	ld	a,_jp_mode
6440  1159 a103          	cp	a,#3
6441  115b 260f          	jrne	L5203
6442                     ; 1169 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6444  115d b60b          	ld	a,_flags
6445  115f a508          	bcp	a,#8
6446  1161 2709          	jreq	L5203
6448  1163 b600          	ld	a,L3772_flags_old
6449  1165 a508          	bcp	a,#8
6450  1167 2603          	jrne	L5203
6451                     ; 1171     		apv_start();
6453  1169 cd1058        	call	_apv_start
6455  116c               L5203:
6456                     ; 1174 flags_old=flags;
6458  116c 450b00        	mov	L3772_flags_old,_flags
6459                     ; 1176 } 
6462  116f 81            	ret
6497                     ; 1313 void adr_drv_v4(char in)
6497                     ; 1314 {
6498                     	switch	.text
6499  1170               _adr_drv_v4:
6503                     ; 1315 if(adress!=in)adress=in;
6505  1170 c10005        	cp	a,_adress
6506  1173 2703          	jreq	L1503
6509  1175 c70005        	ld	_adress,a
6510  1178               L1503:
6511                     ; 1316 }
6514  1178 81            	ret
6543                     ; 1319 void adr_drv_v3(void)
6543                     ; 1320 {
6544                     	switch	.text
6545  1179               _adr_drv_v3:
6547  1179 88            	push	a
6548       00000001      OFST:	set	1
6551                     ; 1326 GPIOB->DDR&=~(1<<0);
6553  117a 72115007      	bres	20487,#0
6554                     ; 1327 GPIOB->CR1&=~(1<<0);
6556  117e 72115008      	bres	20488,#0
6557                     ; 1328 GPIOB->CR2&=~(1<<0);
6559  1182 72115009      	bres	20489,#0
6560                     ; 1329 ADC2->CR2=0x08;
6562  1186 35085402      	mov	21506,#8
6563                     ; 1330 ADC2->CR1=0x40;
6565  118a 35405401      	mov	21505,#64
6566                     ; 1331 ADC2->CSR=0x20+0;
6568  118e 35205400      	mov	21504,#32
6569                     ; 1332 ADC2->CR1|=1;
6571  1192 72105401      	bset	21505,#0
6572                     ; 1333 ADC2->CR1|=1;
6574  1196 72105401      	bset	21505,#0
6575                     ; 1334 adr_drv_stat=1;
6577  119a 35010008      	mov	_adr_drv_stat,#1
6578  119e               L3603:
6579                     ; 1335 while(adr_drv_stat==1);
6582  119e b608          	ld	a,_adr_drv_stat
6583  11a0 a101          	cp	a,#1
6584  11a2 27fa          	jreq	L3603
6585                     ; 1337 GPIOB->DDR&=~(1<<1);
6587  11a4 72135007      	bres	20487,#1
6588                     ; 1338 GPIOB->CR1&=~(1<<1);
6590  11a8 72135008      	bres	20488,#1
6591                     ; 1339 GPIOB->CR2&=~(1<<1);
6593  11ac 72135009      	bres	20489,#1
6594                     ; 1340 ADC2->CR2=0x08;
6596  11b0 35085402      	mov	21506,#8
6597                     ; 1341 ADC2->CR1=0x40;
6599  11b4 35405401      	mov	21505,#64
6600                     ; 1342 ADC2->CSR=0x20+1;
6602  11b8 35215400      	mov	21504,#33
6603                     ; 1343 ADC2->CR1|=1;
6605  11bc 72105401      	bset	21505,#0
6606                     ; 1344 ADC2->CR1|=1;
6608  11c0 72105401      	bset	21505,#0
6609                     ; 1345 adr_drv_stat=3;
6611  11c4 35030008      	mov	_adr_drv_stat,#3
6612  11c8               L1703:
6613                     ; 1346 while(adr_drv_stat==3);
6616  11c8 b608          	ld	a,_adr_drv_stat
6617  11ca a103          	cp	a,#3
6618  11cc 27fa          	jreq	L1703
6619                     ; 1348 GPIOE->DDR&=~(1<<6);
6621  11ce 721d5016      	bres	20502,#6
6622                     ; 1349 GPIOE->CR1&=~(1<<6);
6624  11d2 721d5017      	bres	20503,#6
6625                     ; 1350 GPIOE->CR2&=~(1<<6);
6627  11d6 721d5018      	bres	20504,#6
6628                     ; 1351 ADC2->CR2=0x08;
6630  11da 35085402      	mov	21506,#8
6631                     ; 1352 ADC2->CR1=0x40;
6633  11de 35405401      	mov	21505,#64
6634                     ; 1353 ADC2->CSR=0x20+9;
6636  11e2 35295400      	mov	21504,#41
6637                     ; 1354 ADC2->CR1|=1;
6639  11e6 72105401      	bset	21505,#0
6640                     ; 1355 ADC2->CR1|=1;
6642  11ea 72105401      	bset	21505,#0
6643                     ; 1356 adr_drv_stat=5;
6645  11ee 35050008      	mov	_adr_drv_stat,#5
6646  11f2               L7703:
6647                     ; 1357 while(adr_drv_stat==5);
6650  11f2 b608          	ld	a,_adr_drv_stat
6651  11f4 a105          	cp	a,#5
6652  11f6 27fa          	jreq	L7703
6653                     ; 1361 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6655  11f8 9c            	rvf
6656  11f9 ce0009        	ldw	x,_adc_buff_
6657  11fc a3022a        	cpw	x,#554
6658  11ff 2f0f          	jrslt	L5013
6660  1201 9c            	rvf
6661  1202 ce0009        	ldw	x,_adc_buff_
6662  1205 a30253        	cpw	x,#595
6663  1208 2e06          	jrsge	L5013
6666  120a 725f0006      	clr	_adr
6668  120e 204c          	jra	L7013
6669  1210               L5013:
6670                     ; 1362 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6672  1210 9c            	rvf
6673  1211 ce0009        	ldw	x,_adc_buff_
6674  1214 a3036d        	cpw	x,#877
6675  1217 2f0f          	jrslt	L1113
6677  1219 9c            	rvf
6678  121a ce0009        	ldw	x,_adc_buff_
6679  121d a30396        	cpw	x,#918
6680  1220 2e06          	jrsge	L1113
6683  1222 35010006      	mov	_adr,#1
6685  1226 2034          	jra	L7013
6686  1228               L1113:
6687                     ; 1363 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6689  1228 9c            	rvf
6690  1229 ce0009        	ldw	x,_adc_buff_
6691  122c a302a3        	cpw	x,#675
6692  122f 2f0f          	jrslt	L5113
6694  1231 9c            	rvf
6695  1232 ce0009        	ldw	x,_adc_buff_
6696  1235 a302cc        	cpw	x,#716
6697  1238 2e06          	jrsge	L5113
6700  123a 35020006      	mov	_adr,#2
6702  123e 201c          	jra	L7013
6703  1240               L5113:
6704                     ; 1364 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6706  1240 9c            	rvf
6707  1241 ce0009        	ldw	x,_adc_buff_
6708  1244 a303e3        	cpw	x,#995
6709  1247 2f0f          	jrslt	L1213
6711  1249 9c            	rvf
6712  124a ce0009        	ldw	x,_adc_buff_
6713  124d a3040c        	cpw	x,#1036
6714  1250 2e06          	jrsge	L1213
6717  1252 35030006      	mov	_adr,#3
6719  1256 2004          	jra	L7013
6720  1258               L1213:
6721                     ; 1365 else adr[0]=5;
6723  1258 35050006      	mov	_adr,#5
6724  125c               L7013:
6725                     ; 1367 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6727  125c 9c            	rvf
6728  125d ce000b        	ldw	x,_adc_buff_+2
6729  1260 a3022a        	cpw	x,#554
6730  1263 2f0f          	jrslt	L5213
6732  1265 9c            	rvf
6733  1266 ce000b        	ldw	x,_adc_buff_+2
6734  1269 a30253        	cpw	x,#595
6735  126c 2e06          	jrsge	L5213
6738  126e 725f0007      	clr	_adr+1
6740  1272 204c          	jra	L7213
6741  1274               L5213:
6742                     ; 1368 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6744  1274 9c            	rvf
6745  1275 ce000b        	ldw	x,_adc_buff_+2
6746  1278 a3036d        	cpw	x,#877
6747  127b 2f0f          	jrslt	L1313
6749  127d 9c            	rvf
6750  127e ce000b        	ldw	x,_adc_buff_+2
6751  1281 a30396        	cpw	x,#918
6752  1284 2e06          	jrsge	L1313
6755  1286 35010007      	mov	_adr+1,#1
6757  128a 2034          	jra	L7213
6758  128c               L1313:
6759                     ; 1369 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6761  128c 9c            	rvf
6762  128d ce000b        	ldw	x,_adc_buff_+2
6763  1290 a302a3        	cpw	x,#675
6764  1293 2f0f          	jrslt	L5313
6766  1295 9c            	rvf
6767  1296 ce000b        	ldw	x,_adc_buff_+2
6768  1299 a302cc        	cpw	x,#716
6769  129c 2e06          	jrsge	L5313
6772  129e 35020007      	mov	_adr+1,#2
6774  12a2 201c          	jra	L7213
6775  12a4               L5313:
6776                     ; 1370 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6778  12a4 9c            	rvf
6779  12a5 ce000b        	ldw	x,_adc_buff_+2
6780  12a8 a303e3        	cpw	x,#995
6781  12ab 2f0f          	jrslt	L1413
6783  12ad 9c            	rvf
6784  12ae ce000b        	ldw	x,_adc_buff_+2
6785  12b1 a3040c        	cpw	x,#1036
6786  12b4 2e06          	jrsge	L1413
6789  12b6 35030007      	mov	_adr+1,#3
6791  12ba 2004          	jra	L7213
6792  12bc               L1413:
6793                     ; 1371 else adr[1]=5;
6795  12bc 35050007      	mov	_adr+1,#5
6796  12c0               L7213:
6797                     ; 1373 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6799  12c0 9c            	rvf
6800  12c1 ce001b        	ldw	x,_adc_buff_+18
6801  12c4 a3022a        	cpw	x,#554
6802  12c7 2f0f          	jrslt	L5413
6804  12c9 9c            	rvf
6805  12ca ce001b        	ldw	x,_adc_buff_+18
6806  12cd a30253        	cpw	x,#595
6807  12d0 2e06          	jrsge	L5413
6810  12d2 725f0008      	clr	_adr+2
6812  12d6 204c          	jra	L7413
6813  12d8               L5413:
6814                     ; 1374 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6816  12d8 9c            	rvf
6817  12d9 ce001b        	ldw	x,_adc_buff_+18
6818  12dc a3036d        	cpw	x,#877
6819  12df 2f0f          	jrslt	L1513
6821  12e1 9c            	rvf
6822  12e2 ce001b        	ldw	x,_adc_buff_+18
6823  12e5 a30396        	cpw	x,#918
6824  12e8 2e06          	jrsge	L1513
6827  12ea 35010008      	mov	_adr+2,#1
6829  12ee 2034          	jra	L7413
6830  12f0               L1513:
6831                     ; 1375 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6833  12f0 9c            	rvf
6834  12f1 ce001b        	ldw	x,_adc_buff_+18
6835  12f4 a302a3        	cpw	x,#675
6836  12f7 2f0f          	jrslt	L5513
6838  12f9 9c            	rvf
6839  12fa ce001b        	ldw	x,_adc_buff_+18
6840  12fd a302cc        	cpw	x,#716
6841  1300 2e06          	jrsge	L5513
6844  1302 35020008      	mov	_adr+2,#2
6846  1306 201c          	jra	L7413
6847  1308               L5513:
6848                     ; 1376 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6850  1308 9c            	rvf
6851  1309 ce001b        	ldw	x,_adc_buff_+18
6852  130c a303e3        	cpw	x,#995
6853  130f 2f0f          	jrslt	L1613
6855  1311 9c            	rvf
6856  1312 ce001b        	ldw	x,_adc_buff_+18
6857  1315 a3040c        	cpw	x,#1036
6858  1318 2e06          	jrsge	L1613
6861  131a 35030008      	mov	_adr+2,#3
6863  131e 2004          	jra	L7413
6864  1320               L1613:
6865                     ; 1377 else adr[2]=5;
6867  1320 35050008      	mov	_adr+2,#5
6868  1324               L7413:
6869                     ; 1381 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6871  1324 c60006        	ld	a,_adr
6872  1327 a105          	cp	a,#5
6873  1329 270e          	jreq	L7613
6875  132b c60007        	ld	a,_adr+1
6876  132e a105          	cp	a,#5
6877  1330 2707          	jreq	L7613
6879  1332 c60008        	ld	a,_adr+2
6880  1335 a105          	cp	a,#5
6881  1337 2606          	jrne	L5613
6882  1339               L7613:
6883                     ; 1384 	adress_error=1;
6885  1339 35010004      	mov	_adress_error,#1
6887  133d               L3713:
6888                     ; 1395 }
6891  133d 84            	pop	a
6892  133e 81            	ret
6893  133f               L5613:
6894                     ; 1388 	if(adr[2]&0x02) bps_class=bpsIPS;
6896  133f c60008        	ld	a,_adr+2
6897  1342 a502          	bcp	a,#2
6898  1344 2706          	jreq	L5713
6901  1346 35010004      	mov	_bps_class,#1
6903  134a 2002          	jra	L7713
6904  134c               L5713:
6905                     ; 1389 	else bps_class=bpsIBEP;
6907  134c 3f04          	clr	_bps_class
6908  134e               L7713:
6909                     ; 1391 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6911  134e c60008        	ld	a,_adr+2
6912  1351 a401          	and	a,#1
6913  1353 97            	ld	xl,a
6914  1354 a610          	ld	a,#16
6915  1356 42            	mul	x,a
6916  1357 9f            	ld	a,xl
6917  1358 6b01          	ld	(OFST+0,sp),a
6918  135a c60007        	ld	a,_adr+1
6919  135d 48            	sll	a
6920  135e 48            	sll	a
6921  135f cb0006        	add	a,_adr
6922  1362 1b01          	add	a,(OFST+0,sp)
6923  1364 c70005        	ld	_adress,a
6924  1367 20d4          	jra	L3713
6968                     ; 1398 void volum_u_main_drv(void)
6968                     ; 1399 {
6969                     	switch	.text
6970  1369               _volum_u_main_drv:
6972  1369 88            	push	a
6973       00000001      OFST:	set	1
6976                     ; 1402 if(bMAIN)
6978                     	btst	_bMAIN
6979  136f 2503          	jrult	L631
6980  1371 cc14ba        	jp	L7123
6981  1374               L631:
6982                     ; 1404 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6984  1374 9c            	rvf
6985  1375 ce0008        	ldw	x,_UU_AVT
6986  1378 1d000a        	subw	x,#10
6987  137b b36d          	cpw	x,_Un
6988  137d 2d09          	jrsle	L1223
6991  137f be1f          	ldw	x,_volum_u_main_
6992  1381 1c0005        	addw	x,#5
6993  1384 bf1f          	ldw	_volum_u_main_,x
6995  1386 2036          	jra	L3223
6996  1388               L1223:
6997                     ; 1405 	else if(Un<(UU_AVT-1))volum_u_main_++;
6999  1388 9c            	rvf
7000  1389 ce0008        	ldw	x,_UU_AVT
7001  138c 5a            	decw	x
7002  138d b36d          	cpw	x,_Un
7003  138f 2d09          	jrsle	L5223
7006  1391 be1f          	ldw	x,_volum_u_main_
7007  1393 1c0001        	addw	x,#1
7008  1396 bf1f          	ldw	_volum_u_main_,x
7010  1398 2024          	jra	L3223
7011  139a               L5223:
7012                     ; 1406 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7014  139a 9c            	rvf
7015  139b ce0008        	ldw	x,_UU_AVT
7016  139e 1c000a        	addw	x,#10
7017  13a1 b36d          	cpw	x,_Un
7018  13a3 2e09          	jrsge	L1323
7021  13a5 be1f          	ldw	x,_volum_u_main_
7022  13a7 1d000a        	subw	x,#10
7023  13aa bf1f          	ldw	_volum_u_main_,x
7025  13ac 2010          	jra	L3223
7026  13ae               L1323:
7027                     ; 1407 	else if(Un>(UU_AVT+1))volum_u_main_--;
7029  13ae 9c            	rvf
7030  13af ce0008        	ldw	x,_UU_AVT
7031  13b2 5c            	incw	x
7032  13b3 b36d          	cpw	x,_Un
7033  13b5 2e07          	jrsge	L3223
7036  13b7 be1f          	ldw	x,_volum_u_main_
7037  13b9 1d0001        	subw	x,#1
7038  13bc bf1f          	ldw	_volum_u_main_,x
7039  13be               L3223:
7040                     ; 1408 	if(volum_u_main_>1020)volum_u_main_=1020;
7042  13be 9c            	rvf
7043  13bf be1f          	ldw	x,_volum_u_main_
7044  13c1 a303fd        	cpw	x,#1021
7045  13c4 2f05          	jrslt	L7323
7048  13c6 ae03fc        	ldw	x,#1020
7049  13c9 bf1f          	ldw	_volum_u_main_,x
7050  13cb               L7323:
7051                     ; 1409 	if(volum_u_main_<0)volum_u_main_=0;
7053  13cb 9c            	rvf
7054  13cc be1f          	ldw	x,_volum_u_main_
7055  13ce 2e03          	jrsge	L1423
7058  13d0 5f            	clrw	x
7059  13d1 bf1f          	ldw	_volum_u_main_,x
7060  13d3               L1423:
7061                     ; 1412 	i_main_sigma=0;
7063  13d3 5f            	clrw	x
7064  13d4 bf0f          	ldw	_i_main_sigma,x
7065                     ; 1413 	i_main_num_of_bps=0;
7067  13d6 3f11          	clr	_i_main_num_of_bps
7068                     ; 1414 	for(i=0;i<6;i++)
7070  13d8 0f01          	clr	(OFST+0,sp)
7071  13da               L3423:
7072                     ; 1416 		if(i_main_flag[i])
7074  13da 7b01          	ld	a,(OFST+0,sp)
7075  13dc 5f            	clrw	x
7076  13dd 97            	ld	xl,a
7077  13de 6d14          	tnz	(_i_main_flag,x)
7078  13e0 2719          	jreq	L1523
7079                     ; 1418 			i_main_sigma+=i_main[i];
7081  13e2 7b01          	ld	a,(OFST+0,sp)
7082  13e4 5f            	clrw	x
7083  13e5 97            	ld	xl,a
7084  13e6 58            	sllw	x
7085  13e7 ee1a          	ldw	x,(_i_main,x)
7086  13e9 72bb000f      	addw	x,_i_main_sigma
7087  13ed bf0f          	ldw	_i_main_sigma,x
7088                     ; 1419 			i_main_flag[i]=1;
7090  13ef 7b01          	ld	a,(OFST+0,sp)
7091  13f1 5f            	clrw	x
7092  13f2 97            	ld	xl,a
7093  13f3 a601          	ld	a,#1
7094  13f5 e714          	ld	(_i_main_flag,x),a
7095                     ; 1420 			i_main_num_of_bps++;
7097  13f7 3c11          	inc	_i_main_num_of_bps
7099  13f9 2006          	jra	L3523
7100  13fb               L1523:
7101                     ; 1424 			i_main_flag[i]=0;	
7103  13fb 7b01          	ld	a,(OFST+0,sp)
7104  13fd 5f            	clrw	x
7105  13fe 97            	ld	xl,a
7106  13ff 6f14          	clr	(_i_main_flag,x)
7107  1401               L3523:
7108                     ; 1414 	for(i=0;i<6;i++)
7110  1401 0c01          	inc	(OFST+0,sp)
7113  1403 7b01          	ld	a,(OFST+0,sp)
7114  1405 a106          	cp	a,#6
7115  1407 25d1          	jrult	L3423
7116                     ; 1427 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7118  1409 be0f          	ldw	x,_i_main_sigma
7119  140b b611          	ld	a,_i_main_num_of_bps
7120  140d 905f          	clrw	y
7121  140f 9097          	ld	yl,a
7122  1411 cd0000        	call	c_idiv
7124  1414 bf12          	ldw	_i_main_avg,x
7125                     ; 1428 	for(i=0;i<6;i++)
7127  1416 0f01          	clr	(OFST+0,sp)
7128  1418               L5523:
7129                     ; 1430 		if(i_main_flag[i])
7131  1418 7b01          	ld	a,(OFST+0,sp)
7132  141a 5f            	clrw	x
7133  141b 97            	ld	xl,a
7134  141c 6d14          	tnz	(_i_main_flag,x)
7135  141e 2603cc14af    	jreq	L3623
7136                     ; 1432 			if(i_main[i]<(i_main_avg-10))x[i]++;
7138  1423 9c            	rvf
7139  1424 7b01          	ld	a,(OFST+0,sp)
7140  1426 5f            	clrw	x
7141  1427 97            	ld	xl,a
7142  1428 58            	sllw	x
7143  1429 90be12        	ldw	y,_i_main_avg
7144  142c 72a2000a      	subw	y,#10
7145  1430 90bf00        	ldw	c_y,y
7146  1433 9093          	ldw	y,x
7147  1435 90ee1a        	ldw	y,(_i_main,y)
7148  1438 90b300        	cpw	y,c_y
7149  143b 2e11          	jrsge	L5623
7152  143d 7b01          	ld	a,(OFST+0,sp)
7153  143f 5f            	clrw	x
7154  1440 97            	ld	xl,a
7155  1441 58            	sllw	x
7156  1442 9093          	ldw	y,x
7157  1444 ee26          	ldw	x,(_x,x)
7158  1446 1c0001        	addw	x,#1
7159  1449 90ef26        	ldw	(_x,y),x
7161  144c 2029          	jra	L7623
7162  144e               L5623:
7163                     ; 1433 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7165  144e 9c            	rvf
7166  144f 7b01          	ld	a,(OFST+0,sp)
7167  1451 5f            	clrw	x
7168  1452 97            	ld	xl,a
7169  1453 58            	sllw	x
7170  1454 90be12        	ldw	y,_i_main_avg
7171  1457 72a9000a      	addw	y,#10
7172  145b 90bf00        	ldw	c_y,y
7173  145e 9093          	ldw	y,x
7174  1460 90ee1a        	ldw	y,(_i_main,y)
7175  1463 90b300        	cpw	y,c_y
7176  1466 2d0f          	jrsle	L7623
7179  1468 7b01          	ld	a,(OFST+0,sp)
7180  146a 5f            	clrw	x
7181  146b 97            	ld	xl,a
7182  146c 58            	sllw	x
7183  146d 9093          	ldw	y,x
7184  146f ee26          	ldw	x,(_x,x)
7185  1471 1d0001        	subw	x,#1
7186  1474 90ef26        	ldw	(_x,y),x
7187  1477               L7623:
7188                     ; 1434 			if(x[i]>100)x[i]=100;
7190  1477 9c            	rvf
7191  1478 7b01          	ld	a,(OFST+0,sp)
7192  147a 5f            	clrw	x
7193  147b 97            	ld	xl,a
7194  147c 58            	sllw	x
7195  147d 9093          	ldw	y,x
7196  147f 90ee26        	ldw	y,(_x,y)
7197  1482 90a30065      	cpw	y,#101
7198  1486 2f0b          	jrslt	L3723
7201  1488 7b01          	ld	a,(OFST+0,sp)
7202  148a 5f            	clrw	x
7203  148b 97            	ld	xl,a
7204  148c 58            	sllw	x
7205  148d 90ae0064      	ldw	y,#100
7206  1491 ef26          	ldw	(_x,x),y
7207  1493               L3723:
7208                     ; 1435 			if(x[i]<-100)x[i]=-100;
7210  1493 9c            	rvf
7211  1494 7b01          	ld	a,(OFST+0,sp)
7212  1496 5f            	clrw	x
7213  1497 97            	ld	xl,a
7214  1498 58            	sllw	x
7215  1499 9093          	ldw	y,x
7216  149b 90ee26        	ldw	y,(_x,y)
7217  149e 90a3ff9c      	cpw	y,#65436
7218  14a2 2e0b          	jrsge	L3623
7221  14a4 7b01          	ld	a,(OFST+0,sp)
7222  14a6 5f            	clrw	x
7223  14a7 97            	ld	xl,a
7224  14a8 58            	sllw	x
7225  14a9 90aeff9c      	ldw	y,#65436
7226  14ad ef26          	ldw	(_x,x),y
7227  14af               L3623:
7228                     ; 1428 	for(i=0;i<6;i++)
7230  14af 0c01          	inc	(OFST+0,sp)
7233  14b1 7b01          	ld	a,(OFST+0,sp)
7234  14b3 a106          	cp	a,#6
7235  14b5 2403cc1418    	jrult	L5523
7236  14ba               L7123:
7237                     ; 1442 }
7240  14ba 84            	pop	a
7241  14bb 81            	ret
7264                     ; 1445 void init_CAN(void) {
7265                     	switch	.text
7266  14bc               _init_CAN:
7270                     ; 1446 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7272  14bc 72135420      	bres	21536,#1
7273                     ; 1447 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7275  14c0 72105420      	bset	21536,#0
7277  14c4               L1133:
7278                     ; 1448 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7280  14c4 c65421        	ld	a,21537
7281  14c7 a501          	bcp	a,#1
7282  14c9 27f9          	jreq	L1133
7283                     ; 1450 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7285  14cb 72185420      	bset	21536,#4
7286                     ; 1452 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7288  14cf 35025427      	mov	21543,#2
7289                     ; 1461 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7291  14d3 35135428      	mov	21544,#19
7292                     ; 1462 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7294  14d7 35c05429      	mov	21545,#192
7295                     ; 1463 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7297  14db 357f542c      	mov	21548,#127
7298                     ; 1464 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7300  14df 35e0542d      	mov	21549,#224
7301                     ; 1466 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7303  14e3 35315430      	mov	21552,#49
7304                     ; 1467 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7306  14e7 35c05431      	mov	21553,#192
7307                     ; 1468 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7309  14eb 357f5434      	mov	21556,#127
7310                     ; 1469 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7312  14ef 35e05435      	mov	21557,#224
7313                     ; 1473 	CAN->PSR= 6;									// set page 6
7315  14f3 35065427      	mov	21543,#6
7316                     ; 1478 	CAN->Page.Config.FMR1&=~3;								//mask mode
7318  14f7 c65430        	ld	a,21552
7319  14fa a4fc          	and	a,#252
7320  14fc c75430        	ld	21552,a
7321                     ; 1484 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7323  14ff 35065432      	mov	21554,#6
7324                     ; 1485 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7326  1503 35605432      	mov	21554,#96
7327                     ; 1488 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7329  1507 72105432      	bset	21554,#0
7330                     ; 1489 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7332  150b 72185432      	bset	21554,#4
7333                     ; 1492 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7335  150f 35065427      	mov	21543,#6
7336                     ; 1494 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7338  1513 3509542c      	mov	21548,#9
7339                     ; 1495 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7341  1517 35e7542d      	mov	21549,#231
7342                     ; 1497 	CAN->IER|=(1<<1);
7344  151b 72125425      	bset	21541,#1
7345                     ; 1500 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7347  151f 72115420      	bres	21536,#0
7349  1523               L7133:
7350                     ; 1501 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7352  1523 c65421        	ld	a,21537
7353  1526 a501          	bcp	a,#1
7354  1528 26f9          	jrne	L7133
7355                     ; 1502 }
7358  152a 81            	ret
7466                     ; 1505 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7466                     ; 1506 {
7467                     	switch	.text
7468  152b               _can_transmit:
7470  152b 89            	pushw	x
7471       00000000      OFST:	set	0
7474                     ; 1508 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7476  152c b674          	ld	a,_can_buff_wr_ptr
7477  152e a104          	cp	a,#4
7478  1530 2502          	jrult	L1043
7481  1532 3f74          	clr	_can_buff_wr_ptr
7482  1534               L1043:
7483                     ; 1510 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7485  1534 b674          	ld	a,_can_buff_wr_ptr
7486  1536 97            	ld	xl,a
7487  1537 a610          	ld	a,#16
7488  1539 42            	mul	x,a
7489  153a 1601          	ldw	y,(OFST+1,sp)
7490  153c a606          	ld	a,#6
7491  153e               L441:
7492  153e 9054          	srlw	y
7493  1540 4a            	dec	a
7494  1541 26fb          	jrne	L441
7495  1543 909f          	ld	a,yl
7496  1545 e775          	ld	(_can_out_buff,x),a
7497                     ; 1511 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7499  1547 b674          	ld	a,_can_buff_wr_ptr
7500  1549 97            	ld	xl,a
7501  154a a610          	ld	a,#16
7502  154c 42            	mul	x,a
7503  154d 7b02          	ld	a,(OFST+2,sp)
7504  154f 48            	sll	a
7505  1550 48            	sll	a
7506  1551 e776          	ld	(_can_out_buff+1,x),a
7507                     ; 1513 can_out_buff[can_buff_wr_ptr][2]=data0;
7509  1553 b674          	ld	a,_can_buff_wr_ptr
7510  1555 97            	ld	xl,a
7511  1556 a610          	ld	a,#16
7512  1558 42            	mul	x,a
7513  1559 7b05          	ld	a,(OFST+5,sp)
7514  155b e777          	ld	(_can_out_buff+2,x),a
7515                     ; 1514 can_out_buff[can_buff_wr_ptr][3]=data1;
7517  155d b674          	ld	a,_can_buff_wr_ptr
7518  155f 97            	ld	xl,a
7519  1560 a610          	ld	a,#16
7520  1562 42            	mul	x,a
7521  1563 7b06          	ld	a,(OFST+6,sp)
7522  1565 e778          	ld	(_can_out_buff+3,x),a
7523                     ; 1515 can_out_buff[can_buff_wr_ptr][4]=data2;
7525  1567 b674          	ld	a,_can_buff_wr_ptr
7526  1569 97            	ld	xl,a
7527  156a a610          	ld	a,#16
7528  156c 42            	mul	x,a
7529  156d 7b07          	ld	a,(OFST+7,sp)
7530  156f e779          	ld	(_can_out_buff+4,x),a
7531                     ; 1516 can_out_buff[can_buff_wr_ptr][5]=data3;
7533  1571 b674          	ld	a,_can_buff_wr_ptr
7534  1573 97            	ld	xl,a
7535  1574 a610          	ld	a,#16
7536  1576 42            	mul	x,a
7537  1577 7b08          	ld	a,(OFST+8,sp)
7538  1579 e77a          	ld	(_can_out_buff+5,x),a
7539                     ; 1517 can_out_buff[can_buff_wr_ptr][6]=data4;
7541  157b b674          	ld	a,_can_buff_wr_ptr
7542  157d 97            	ld	xl,a
7543  157e a610          	ld	a,#16
7544  1580 42            	mul	x,a
7545  1581 7b09          	ld	a,(OFST+9,sp)
7546  1583 e77b          	ld	(_can_out_buff+6,x),a
7547                     ; 1518 can_out_buff[can_buff_wr_ptr][7]=data5;
7549  1585 b674          	ld	a,_can_buff_wr_ptr
7550  1587 97            	ld	xl,a
7551  1588 a610          	ld	a,#16
7552  158a 42            	mul	x,a
7553  158b 7b0a          	ld	a,(OFST+10,sp)
7554  158d e77c          	ld	(_can_out_buff+7,x),a
7555                     ; 1519 can_out_buff[can_buff_wr_ptr][8]=data6;
7557  158f b674          	ld	a,_can_buff_wr_ptr
7558  1591 97            	ld	xl,a
7559  1592 a610          	ld	a,#16
7560  1594 42            	mul	x,a
7561  1595 7b0b          	ld	a,(OFST+11,sp)
7562  1597 e77d          	ld	(_can_out_buff+8,x),a
7563                     ; 1520 can_out_buff[can_buff_wr_ptr][9]=data7;
7565  1599 b674          	ld	a,_can_buff_wr_ptr
7566  159b 97            	ld	xl,a
7567  159c a610          	ld	a,#16
7568  159e 42            	mul	x,a
7569  159f 7b0c          	ld	a,(OFST+12,sp)
7570  15a1 e77e          	ld	(_can_out_buff+9,x),a
7571                     ; 1522 can_buff_wr_ptr++;
7573  15a3 3c74          	inc	_can_buff_wr_ptr
7574                     ; 1523 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7576  15a5 b674          	ld	a,_can_buff_wr_ptr
7577  15a7 a104          	cp	a,#4
7578  15a9 2502          	jrult	L3043
7581  15ab 3f74          	clr	_can_buff_wr_ptr
7582  15ad               L3043:
7583                     ; 1524 } 
7586  15ad 85            	popw	x
7587  15ae 81            	ret
7616                     ; 1527 void can_tx_hndl(void)
7616                     ; 1528 {
7617                     	switch	.text
7618  15af               _can_tx_hndl:
7622                     ; 1529 if(bTX_FREE)
7624  15af 3d09          	tnz	_bTX_FREE
7625  15b1 2757          	jreq	L5143
7626                     ; 1531 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7628  15b3 b673          	ld	a,_can_buff_rd_ptr
7629  15b5 b174          	cp	a,_can_buff_wr_ptr
7630  15b7 275f          	jreq	L3243
7631                     ; 1533 		bTX_FREE=0;
7633  15b9 3f09          	clr	_bTX_FREE
7634                     ; 1535 		CAN->PSR= 0;
7636  15bb 725f5427      	clr	21543
7637                     ; 1536 		CAN->Page.TxMailbox.MDLCR=8;
7639  15bf 35085429      	mov	21545,#8
7640                     ; 1537 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7642  15c3 b673          	ld	a,_can_buff_rd_ptr
7643  15c5 97            	ld	xl,a
7644  15c6 a610          	ld	a,#16
7645  15c8 42            	mul	x,a
7646  15c9 e675          	ld	a,(_can_out_buff,x)
7647  15cb c7542a        	ld	21546,a
7648                     ; 1538 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7650  15ce b673          	ld	a,_can_buff_rd_ptr
7651  15d0 97            	ld	xl,a
7652  15d1 a610          	ld	a,#16
7653  15d3 42            	mul	x,a
7654  15d4 e676          	ld	a,(_can_out_buff+1,x)
7655  15d6 c7542b        	ld	21547,a
7656                     ; 1540 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7658  15d9 b673          	ld	a,_can_buff_rd_ptr
7659  15db 97            	ld	xl,a
7660  15dc a610          	ld	a,#16
7661  15de 42            	mul	x,a
7662  15df 01            	rrwa	x,a
7663  15e0 ab77          	add	a,#_can_out_buff+2
7664  15e2 2401          	jrnc	L051
7665  15e4 5c            	incw	x
7666  15e5               L051:
7667  15e5 5f            	clrw	x
7668  15e6 97            	ld	xl,a
7669  15e7 bf00          	ldw	c_x,x
7670  15e9 ae0008        	ldw	x,#8
7671  15ec               L251:
7672  15ec 5a            	decw	x
7673  15ed 92d600        	ld	a,([c_x],x)
7674  15f0 d7542e        	ld	(21550,x),a
7675  15f3 5d            	tnzw	x
7676  15f4 26f6          	jrne	L251
7677                     ; 1542 		can_buff_rd_ptr++;
7679  15f6 3c73          	inc	_can_buff_rd_ptr
7680                     ; 1543 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7682  15f8 b673          	ld	a,_can_buff_rd_ptr
7683  15fa a104          	cp	a,#4
7684  15fc 2502          	jrult	L1243
7687  15fe 3f73          	clr	_can_buff_rd_ptr
7688  1600               L1243:
7689                     ; 1545 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7691  1600 72105428      	bset	21544,#0
7692                     ; 1546 		CAN->IER|=(1<<0);
7694  1604 72105425      	bset	21541,#0
7695  1608 200e          	jra	L3243
7696  160a               L5143:
7697                     ; 1551 	tx_busy_cnt++;
7699  160a 3c72          	inc	_tx_busy_cnt
7700                     ; 1552 	if(tx_busy_cnt>=100)
7702  160c b672          	ld	a,_tx_busy_cnt
7703  160e a164          	cp	a,#100
7704  1610 2506          	jrult	L3243
7705                     ; 1554 		tx_busy_cnt=0;
7707  1612 3f72          	clr	_tx_busy_cnt
7708                     ; 1555 		bTX_FREE=1;
7710  1614 35010009      	mov	_bTX_FREE,#1
7711  1618               L3243:
7712                     ; 1558 }
7715  1618 81            	ret
7754                     ; 1561 void net_drv(void)
7754                     ; 1562 { 
7755                     	switch	.text
7756  1619               _net_drv:
7760                     ; 1564 if(bMAIN)
7762                     	btst	_bMAIN
7763  161e 2503          	jrult	L651
7764  1620 cc16c6        	jp	L7343
7765  1623               L651:
7766                     ; 1566 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7768  1623 3c32          	inc	_cnt_net_drv
7769  1625 b632          	ld	a,_cnt_net_drv
7770  1627 a107          	cp	a,#7
7771  1629 2502          	jrult	L1443
7774  162b 3f32          	clr	_cnt_net_drv
7775  162d               L1443:
7776                     ; 1568 	if(cnt_net_drv<=5) 
7778  162d b632          	ld	a,_cnt_net_drv
7779  162f a106          	cp	a,#6
7780  1631 244c          	jruge	L3443
7781                     ; 1570 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7783  1633 4be8          	push	#232
7784  1635 4be8          	push	#232
7785  1637 b632          	ld	a,_cnt_net_drv
7786  1639 5f            	clrw	x
7787  163a 97            	ld	xl,a
7788  163b 58            	sllw	x
7789  163c ee26          	ldw	x,(_x,x)
7790  163e 72bb001f      	addw	x,_volum_u_main_
7791  1642 90ae0100      	ldw	y,#256
7792  1646 cd0000        	call	c_idiv
7794  1649 9f            	ld	a,xl
7795  164a 88            	push	a
7796  164b b632          	ld	a,_cnt_net_drv
7797  164d 5f            	clrw	x
7798  164e 97            	ld	xl,a
7799  164f 58            	sllw	x
7800  1650 e627          	ld	a,(_x+1,x)
7801  1652 bb20          	add	a,_volum_u_main_+1
7802  1654 88            	push	a
7803  1655 4b00          	push	#0
7804  1657 4bed          	push	#237
7805  1659 3b0032        	push	_cnt_net_drv
7806  165c 3b0032        	push	_cnt_net_drv
7807  165f ae009e        	ldw	x,#158
7808  1662 cd152b        	call	_can_transmit
7810  1665 5b08          	addw	sp,#8
7811                     ; 1571 		i_main_bps_cnt[cnt_net_drv]++;
7813  1667 b632          	ld	a,_cnt_net_drv
7814  1669 5f            	clrw	x
7815  166a 97            	ld	xl,a
7816  166b 6c09          	inc	(_i_main_bps_cnt,x)
7817                     ; 1572 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7819  166d b632          	ld	a,_cnt_net_drv
7820  166f 5f            	clrw	x
7821  1670 97            	ld	xl,a
7822  1671 e609          	ld	a,(_i_main_bps_cnt,x)
7823  1673 a10b          	cp	a,#11
7824  1675 254f          	jrult	L7343
7827  1677 b632          	ld	a,_cnt_net_drv
7828  1679 5f            	clrw	x
7829  167a 97            	ld	xl,a
7830  167b 6f14          	clr	(_i_main_flag,x)
7831  167d 2047          	jra	L7343
7832  167f               L3443:
7833                     ; 1574 	else if(cnt_net_drv==6)
7835  167f b632          	ld	a,_cnt_net_drv
7836  1681 a106          	cp	a,#6
7837  1683 2641          	jrne	L7343
7838                     ; 1576 		plazma_int[2]=pwm_u;
7840  1685 be0e          	ldw	x,_pwm_u
7841  1687 bf37          	ldw	_plazma_int+4,x
7842                     ; 1577 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7844  1689 3b006b        	push	_Ui
7845  168c 3b006c        	push	_Ui+1
7846  168f 3b006d        	push	_Un
7847  1692 3b006e        	push	_Un+1
7848  1695 3b006f        	push	_I
7849  1698 3b0070        	push	_I+1
7850  169b 4bda          	push	#218
7851  169d 3b0005        	push	_adress
7852  16a0 ae018e        	ldw	x,#398
7853  16a3 cd152b        	call	_can_transmit
7855  16a6 5b08          	addw	sp,#8
7856                     ; 1578 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7858  16a8 3b0037        	push	_plazma_int+4
7859  16ab 3b0038        	push	_plazma_int+5
7860  16ae 3b005f        	push	__x_+1
7861  16b1 3b000b        	push	_flags
7862  16b4 4b00          	push	#0
7863  16b6 3b0068        	push	_T
7864  16b9 4bdb          	push	#219
7865  16bb 3b0005        	push	_adress
7866  16be ae018e        	ldw	x,#398
7867  16c1 cd152b        	call	_can_transmit
7869  16c4 5b08          	addw	sp,#8
7870  16c6               L7343:
7871                     ; 1581 }
7874  16c6 81            	ret
7988                     ; 1584 void can_in_an(void)
7988                     ; 1585 {
7989                     	switch	.text
7990  16c7               _can_in_an:
7992  16c7 5205          	subw	sp,#5
7993       00000005      OFST:	set	5
7996                     ; 1595 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7998  16c9 b6ca          	ld	a,_mess+6
7999  16cb c10005        	cp	a,_adress
8000  16ce 2703          	jreq	L002
8001  16d0 cc17ec        	jp	L7053
8002  16d3               L002:
8004  16d3 b6cb          	ld	a,_mess+7
8005  16d5 c10005        	cp	a,_adress
8006  16d8 2703          	jreq	L202
8007  16da cc17ec        	jp	L7053
8008  16dd               L202:
8010  16dd b6cc          	ld	a,_mess+8
8011  16df a1ed          	cp	a,#237
8012  16e1 2703          	jreq	L402
8013  16e3 cc17ec        	jp	L7053
8014  16e6               L402:
8015                     ; 1598 	can_error_cnt=0;
8017  16e6 3f71          	clr	_can_error_cnt
8018                     ; 1600 	bMAIN=0;
8020  16e8 72110001      	bres	_bMAIN
8021                     ; 1601  	flags_tu=mess[9];
8023  16ec 45cd60        	mov	_flags_tu,_mess+9
8024                     ; 1602  	if(flags_tu&0b00000001)
8026  16ef b660          	ld	a,_flags_tu
8027  16f1 a501          	bcp	a,#1
8028  16f3 2706          	jreq	L1153
8029                     ; 1607  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8031  16f5 721a000b      	bset	_flags,#5
8033  16f9 200e          	jra	L3153
8034  16fb               L1153:
8035                     ; 1618  				flags&=0b11011111; 
8037  16fb 721b000b      	bres	_flags,#5
8038                     ; 1619  				off_bp_cnt=5*ee_TZAS;
8040  16ff c60017        	ld	a,_ee_TZAS+1
8041  1702 97            	ld	xl,a
8042  1703 a605          	ld	a,#5
8043  1705 42            	mul	x,a
8044  1706 9f            	ld	a,xl
8045  1707 b753          	ld	_off_bp_cnt,a
8046  1709               L3153:
8047                     ; 1625  	if(flags_tu&0b00000010) flags|=0b01000000;
8049  1709 b660          	ld	a,_flags_tu
8050  170b a502          	bcp	a,#2
8051  170d 2706          	jreq	L5153
8054  170f 721c000b      	bset	_flags,#6
8056  1713 2004          	jra	L7153
8057  1715               L5153:
8058                     ; 1626  	else flags&=0b10111111; 
8060  1715 721d000b      	bres	_flags,#6
8061  1719               L7153:
8062                     ; 1628  	vol_u_temp=mess[10]+mess[11]*256;
8064  1719 b6cf          	ld	a,_mess+11
8065  171b 5f            	clrw	x
8066  171c 97            	ld	xl,a
8067  171d 4f            	clr	a
8068  171e 02            	rlwa	x,a
8069  171f 01            	rrwa	x,a
8070  1720 bbce          	add	a,_mess+10
8071  1722 2401          	jrnc	L261
8072  1724 5c            	incw	x
8073  1725               L261:
8074  1725 b759          	ld	_vol_u_temp+1,a
8075  1727 9f            	ld	a,xl
8076  1728 b758          	ld	_vol_u_temp,a
8077                     ; 1629  	vol_i_temp=mess[12]+mess[13]*256;  
8079  172a b6d1          	ld	a,_mess+13
8080  172c 5f            	clrw	x
8081  172d 97            	ld	xl,a
8082  172e 4f            	clr	a
8083  172f 02            	rlwa	x,a
8084  1730 01            	rrwa	x,a
8085  1731 bbd0          	add	a,_mess+12
8086  1733 2401          	jrnc	L461
8087  1735 5c            	incw	x
8088  1736               L461:
8089  1736 b757          	ld	_vol_i_temp+1,a
8090  1738 9f            	ld	a,xl
8091  1739 b756          	ld	_vol_i_temp,a
8092                     ; 1638 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
8094  173b b601          	ld	a,_vent_resurs_tx_cnt
8095  173d a102          	cp	a,#2
8096  173f 2507          	jrult	L1253
8099  1741 ce0000        	ldw	x,_vent_resurs
8100  1744 bf37          	ldw	_plazma_int+4,x
8102  1746 2004          	jra	L3253
8103  1748               L1253:
8104                     ; 1639 	else plazma_int[2]=vent_resurs_sec_cnt;
8106  1748 be02          	ldw	x,_vent_resurs_sec_cnt
8107  174a bf37          	ldw	_plazma_int+4,x
8108  174c               L3253:
8109                     ; 1640  	rotor_int=flags_tu+(((short)flags)<<8);
8111  174c b60b          	ld	a,_flags
8112  174e 5f            	clrw	x
8113  174f 97            	ld	xl,a
8114  1750 4f            	clr	a
8115  1751 02            	rlwa	x,a
8116  1752 01            	rrwa	x,a
8117  1753 bb60          	add	a,_flags_tu
8118  1755 2401          	jrnc	L661
8119  1757 5c            	incw	x
8120  1758               L661:
8121  1758 b71e          	ld	_rotor_int+1,a
8122  175a 9f            	ld	a,xl
8123  175b b71d          	ld	_rotor_int,a
8124                     ; 1641 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8126  175d 3b006b        	push	_Ui
8127  1760 3b006c        	push	_Ui+1
8128  1763 3b006d        	push	_Un
8129  1766 3b006e        	push	_Un+1
8130  1769 3b006f        	push	_I
8131  176c 3b0070        	push	_I+1
8132  176f 4bda          	push	#218
8133  1771 3b0005        	push	_adress
8134  1774 ae018e        	ldw	x,#398
8135  1777 cd152b        	call	_can_transmit
8137  177a 5b08          	addw	sp,#8
8138                     ; 1642 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8140  177c 3b0037        	push	_plazma_int+4
8141  177f 3b0038        	push	_plazma_int+5
8142  1782 3b005f        	push	__x_+1
8143  1785 3b000b        	push	_flags
8144  1788 b601          	ld	a,_vent_resurs_tx_cnt
8145  178a 5f            	clrw	x
8146  178b 97            	ld	xl,a
8147  178c d60000        	ld	a,(_vent_resurs_buff,x)
8148  178f 88            	push	a
8149  1790 3b0068        	push	_T
8150  1793 4bdb          	push	#219
8151  1795 3b0005        	push	_adress
8152  1798 ae018e        	ldw	x,#398
8153  179b cd152b        	call	_can_transmit
8155  179e 5b08          	addw	sp,#8
8156                     ; 1643      link_cnt=0;
8158  17a0 5f            	clrw	x
8159  17a1 bf61          	ldw	_link_cnt,x
8160                     ; 1644      link=ON;
8162  17a3 35550063      	mov	_link,#85
8163                     ; 1646      if(flags_tu&0b10000000)
8165  17a7 b660          	ld	a,_flags_tu
8166  17a9 a580          	bcp	a,#128
8167  17ab 2716          	jreq	L5253
8168                     ; 1648      	if(!res_fl)
8170  17ad 725d000b      	tnz	_res_fl
8171  17b1 2625          	jrne	L1353
8172                     ; 1650      		res_fl=1;
8174  17b3 a601          	ld	a,#1
8175  17b5 ae000b        	ldw	x,#_res_fl
8176  17b8 cd0000        	call	c_eewrc
8178                     ; 1651      		bRES=1;
8180  17bb 35010012      	mov	_bRES,#1
8181                     ; 1652      		res_fl_cnt=0;
8183  17bf 3f41          	clr	_res_fl_cnt
8184  17c1 2015          	jra	L1353
8185  17c3               L5253:
8186                     ; 1657      	if(main_cnt>20)
8188  17c3 9c            	rvf
8189  17c4 be51          	ldw	x,_main_cnt
8190  17c6 a30015        	cpw	x,#21
8191  17c9 2f0d          	jrslt	L1353
8192                     ; 1659     			if(res_fl)
8194  17cb 725d000b      	tnz	_res_fl
8195  17cf 2707          	jreq	L1353
8196                     ; 1661      			res_fl=0;
8198  17d1 4f            	clr	a
8199  17d2 ae000b        	ldw	x,#_res_fl
8200  17d5 cd0000        	call	c_eewrc
8202  17d8               L1353:
8203                     ; 1666       if(res_fl_)
8205  17d8 725d000a      	tnz	_res_fl_
8206  17dc 2603          	jrne	L602
8207  17de cc1d37        	jp	L3543
8208  17e1               L602:
8209                     ; 1668       	res_fl_=0;
8211  17e1 4f            	clr	a
8212  17e2 ae000a        	ldw	x,#_res_fl_
8213  17e5 cd0000        	call	c_eewrc
8215  17e8 ac371d37      	jpf	L3543
8216  17ec               L7053:
8217                     ; 1671 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8219  17ec b6ca          	ld	a,_mess+6
8220  17ee c10005        	cp	a,_adress
8221  17f1 2703          	jreq	L012
8222  17f3 cc1a03        	jp	L3453
8223  17f6               L012:
8225  17f6 b6cb          	ld	a,_mess+7
8226  17f8 c10005        	cp	a,_adress
8227  17fb 2703          	jreq	L212
8228  17fd cc1a03        	jp	L3453
8229  1800               L212:
8231  1800 b6cc          	ld	a,_mess+8
8232  1802 a1ee          	cp	a,#238
8233  1804 2703          	jreq	L412
8234  1806 cc1a03        	jp	L3453
8235  1809               L412:
8237  1809 b6cd          	ld	a,_mess+9
8238  180b b1ce          	cp	a,_mess+10
8239  180d 2703          	jreq	L612
8240  180f cc1a03        	jp	L3453
8241  1812               L612:
8242                     ; 1673 	rotor_int++;
8244  1812 be1d          	ldw	x,_rotor_int
8245  1814 1c0001        	addw	x,#1
8246  1817 bf1d          	ldw	_rotor_int,x
8247                     ; 1674 	if((mess[9]&0xf0)==0x20)
8249  1819 b6cd          	ld	a,_mess+9
8250  181b a4f0          	and	a,#240
8251  181d a120          	cp	a,#32
8252  181f 2673          	jrne	L5453
8253                     ; 1676 		if((mess[9]&0x0f)==0x01)
8255  1821 b6cd          	ld	a,_mess+9
8256  1823 a40f          	and	a,#15
8257  1825 a101          	cp	a,#1
8258  1827 260d          	jrne	L7453
8259                     ; 1678 			ee_K[0][0]=adc_buff_[4];
8261  1829 ce0011        	ldw	x,_adc_buff_+8
8262  182c 89            	pushw	x
8263  182d ae001a        	ldw	x,#_ee_K
8264  1830 cd0000        	call	c_eewrw
8266  1833 85            	popw	x
8268  1834 204a          	jra	L1553
8269  1836               L7453:
8270                     ; 1680 		else if((mess[9]&0x0f)==0x02)
8272  1836 b6cd          	ld	a,_mess+9
8273  1838 a40f          	and	a,#15
8274  183a a102          	cp	a,#2
8275  183c 260b          	jrne	L3553
8276                     ; 1682 			ee_K[0][1]++;
8278  183e ce001c        	ldw	x,_ee_K+2
8279  1841 1c0001        	addw	x,#1
8280  1844 cf001c        	ldw	_ee_K+2,x
8282  1847 2037          	jra	L1553
8283  1849               L3553:
8284                     ; 1684 		else if((mess[9]&0x0f)==0x03)
8286  1849 b6cd          	ld	a,_mess+9
8287  184b a40f          	and	a,#15
8288  184d a103          	cp	a,#3
8289  184f 260b          	jrne	L7553
8290                     ; 1686 			ee_K[0][1]+=10;
8292  1851 ce001c        	ldw	x,_ee_K+2
8293  1854 1c000a        	addw	x,#10
8294  1857 cf001c        	ldw	_ee_K+2,x
8296  185a 2024          	jra	L1553
8297  185c               L7553:
8298                     ; 1688 		else if((mess[9]&0x0f)==0x04)
8300  185c b6cd          	ld	a,_mess+9
8301  185e a40f          	and	a,#15
8302  1860 a104          	cp	a,#4
8303  1862 260b          	jrne	L3653
8304                     ; 1690 			ee_K[0][1]--;
8306  1864 ce001c        	ldw	x,_ee_K+2
8307  1867 1d0001        	subw	x,#1
8308  186a cf001c        	ldw	_ee_K+2,x
8310  186d 2011          	jra	L1553
8311  186f               L3653:
8312                     ; 1692 		else if((mess[9]&0x0f)==0x05)
8314  186f b6cd          	ld	a,_mess+9
8315  1871 a40f          	and	a,#15
8316  1873 a105          	cp	a,#5
8317  1875 2609          	jrne	L1553
8318                     ; 1694 			ee_K[0][1]-=10;
8320  1877 ce001c        	ldw	x,_ee_K+2
8321  187a 1d000a        	subw	x,#10
8322  187d cf001c        	ldw	_ee_K+2,x
8323  1880               L1553:
8324                     ; 1696 		granee(&ee_K[0][1],50,3000);									
8326  1880 ae0bb8        	ldw	x,#3000
8327  1883 89            	pushw	x
8328  1884 ae0032        	ldw	x,#50
8329  1887 89            	pushw	x
8330  1888 ae001c        	ldw	x,#_ee_K+2
8331  188b cd00f2        	call	_granee
8333  188e 5b04          	addw	sp,#4
8335  1890 ace819e8      	jpf	L1753
8336  1894               L5453:
8337                     ; 1698 	else if((mess[9]&0xf0)==0x10)
8339  1894 b6cd          	ld	a,_mess+9
8340  1896 a4f0          	and	a,#240
8341  1898 a110          	cp	a,#16
8342  189a 2673          	jrne	L3753
8343                     ; 1700 		if((mess[9]&0x0f)==0x01)
8345  189c b6cd          	ld	a,_mess+9
8346  189e a40f          	and	a,#15
8347  18a0 a101          	cp	a,#1
8348  18a2 260d          	jrne	L5753
8349                     ; 1702 			ee_K[1][0]=adc_buff_[1];
8351  18a4 ce000b        	ldw	x,_adc_buff_+2
8352  18a7 89            	pushw	x
8353  18a8 ae001e        	ldw	x,#_ee_K+4
8354  18ab cd0000        	call	c_eewrw
8356  18ae 85            	popw	x
8358  18af 204a          	jra	L7753
8359  18b1               L5753:
8360                     ; 1704 		else if((mess[9]&0x0f)==0x02)
8362  18b1 b6cd          	ld	a,_mess+9
8363  18b3 a40f          	and	a,#15
8364  18b5 a102          	cp	a,#2
8365  18b7 260b          	jrne	L1063
8366                     ; 1706 			ee_K[1][1]++;
8368  18b9 ce0020        	ldw	x,_ee_K+6
8369  18bc 1c0001        	addw	x,#1
8370  18bf cf0020        	ldw	_ee_K+6,x
8372  18c2 2037          	jra	L7753
8373  18c4               L1063:
8374                     ; 1708 		else if((mess[9]&0x0f)==0x03)
8376  18c4 b6cd          	ld	a,_mess+9
8377  18c6 a40f          	and	a,#15
8378  18c8 a103          	cp	a,#3
8379  18ca 260b          	jrne	L5063
8380                     ; 1710 			ee_K[1][1]+=10;
8382  18cc ce0020        	ldw	x,_ee_K+6
8383  18cf 1c000a        	addw	x,#10
8384  18d2 cf0020        	ldw	_ee_K+6,x
8386  18d5 2024          	jra	L7753
8387  18d7               L5063:
8388                     ; 1712 		else if((mess[9]&0x0f)==0x04)
8390  18d7 b6cd          	ld	a,_mess+9
8391  18d9 a40f          	and	a,#15
8392  18db a104          	cp	a,#4
8393  18dd 260b          	jrne	L1163
8394                     ; 1714 			ee_K[1][1]--;
8396  18df ce0020        	ldw	x,_ee_K+6
8397  18e2 1d0001        	subw	x,#1
8398  18e5 cf0020        	ldw	_ee_K+6,x
8400  18e8 2011          	jra	L7753
8401  18ea               L1163:
8402                     ; 1716 		else if((mess[9]&0x0f)==0x05)
8404  18ea b6cd          	ld	a,_mess+9
8405  18ec a40f          	and	a,#15
8406  18ee a105          	cp	a,#5
8407  18f0 2609          	jrne	L7753
8408                     ; 1718 			ee_K[1][1]-=10;
8410  18f2 ce0020        	ldw	x,_ee_K+6
8411  18f5 1d000a        	subw	x,#10
8412  18f8 cf0020        	ldw	_ee_K+6,x
8413  18fb               L7753:
8414                     ; 1723 		granee(&ee_K[1][1],10,30000);
8416  18fb ae7530        	ldw	x,#30000
8417  18fe 89            	pushw	x
8418  18ff ae000a        	ldw	x,#10
8419  1902 89            	pushw	x
8420  1903 ae0020        	ldw	x,#_ee_K+6
8421  1906 cd00f2        	call	_granee
8423  1909 5b04          	addw	sp,#4
8425  190b ace819e8      	jpf	L1753
8426  190f               L3753:
8427                     ; 1727 	else if((mess[9]&0xf0)==0x00)
8429  190f b6cd          	ld	a,_mess+9
8430  1911 a5f0          	bcp	a,#240
8431  1913 2671          	jrne	L1263
8432                     ; 1729 		if((mess[9]&0x0f)==0x01)
8434  1915 b6cd          	ld	a,_mess+9
8435  1917 a40f          	and	a,#15
8436  1919 a101          	cp	a,#1
8437  191b 260d          	jrne	L3263
8438                     ; 1731 			ee_K[2][0]=adc_buff_[2];
8440  191d ce000d        	ldw	x,_adc_buff_+4
8441  1920 89            	pushw	x
8442  1921 ae0022        	ldw	x,#_ee_K+8
8443  1924 cd0000        	call	c_eewrw
8445  1927 85            	popw	x
8447  1928 204a          	jra	L5263
8448  192a               L3263:
8449                     ; 1733 		else if((mess[9]&0x0f)==0x02)
8451  192a b6cd          	ld	a,_mess+9
8452  192c a40f          	and	a,#15
8453  192e a102          	cp	a,#2
8454  1930 260b          	jrne	L7263
8455                     ; 1735 			ee_K[2][1]++;
8457  1932 ce0024        	ldw	x,_ee_K+10
8458  1935 1c0001        	addw	x,#1
8459  1938 cf0024        	ldw	_ee_K+10,x
8461  193b 2037          	jra	L5263
8462  193d               L7263:
8463                     ; 1737 		else if((mess[9]&0x0f)==0x03)
8465  193d b6cd          	ld	a,_mess+9
8466  193f a40f          	and	a,#15
8467  1941 a103          	cp	a,#3
8468  1943 260b          	jrne	L3363
8469                     ; 1739 			ee_K[2][1]+=10;
8471  1945 ce0024        	ldw	x,_ee_K+10
8472  1948 1c000a        	addw	x,#10
8473  194b cf0024        	ldw	_ee_K+10,x
8475  194e 2024          	jra	L5263
8476  1950               L3363:
8477                     ; 1741 		else if((mess[9]&0x0f)==0x04)
8479  1950 b6cd          	ld	a,_mess+9
8480  1952 a40f          	and	a,#15
8481  1954 a104          	cp	a,#4
8482  1956 260b          	jrne	L7363
8483                     ; 1743 			ee_K[2][1]--;
8485  1958 ce0024        	ldw	x,_ee_K+10
8486  195b 1d0001        	subw	x,#1
8487  195e cf0024        	ldw	_ee_K+10,x
8489  1961 2011          	jra	L5263
8490  1963               L7363:
8491                     ; 1745 		else if((mess[9]&0x0f)==0x05)
8493  1963 b6cd          	ld	a,_mess+9
8494  1965 a40f          	and	a,#15
8495  1967 a105          	cp	a,#5
8496  1969 2609          	jrne	L5263
8497                     ; 1747 			ee_K[2][1]-=10;
8499  196b ce0024        	ldw	x,_ee_K+10
8500  196e 1d000a        	subw	x,#10
8501  1971 cf0024        	ldw	_ee_K+10,x
8502  1974               L5263:
8503                     ; 1752 		granee(&ee_K[2][1],10,30000);
8505  1974 ae7530        	ldw	x,#30000
8506  1977 89            	pushw	x
8507  1978 ae000a        	ldw	x,#10
8508  197b 89            	pushw	x
8509  197c ae0024        	ldw	x,#_ee_K+10
8510  197f cd00f2        	call	_granee
8512  1982 5b04          	addw	sp,#4
8514  1984 2062          	jra	L1753
8515  1986               L1263:
8516                     ; 1756 	else if((mess[9]&0xf0)==0x30)
8518  1986 b6cd          	ld	a,_mess+9
8519  1988 a4f0          	and	a,#240
8520  198a a130          	cp	a,#48
8521  198c 265a          	jrne	L1753
8522                     ; 1758 		if((mess[9]&0x0f)==0x02)
8524  198e b6cd          	ld	a,_mess+9
8525  1990 a40f          	and	a,#15
8526  1992 a102          	cp	a,#2
8527  1994 260b          	jrne	L1563
8528                     ; 1760 			ee_K[3][1]++;
8530  1996 ce0028        	ldw	x,_ee_K+14
8531  1999 1c0001        	addw	x,#1
8532  199c cf0028        	ldw	_ee_K+14,x
8534  199f 2037          	jra	L3563
8535  19a1               L1563:
8536                     ; 1762 		else if((mess[9]&0x0f)==0x03)
8538  19a1 b6cd          	ld	a,_mess+9
8539  19a3 a40f          	and	a,#15
8540  19a5 a103          	cp	a,#3
8541  19a7 260b          	jrne	L5563
8542                     ; 1764 			ee_K[3][1]+=10;
8544  19a9 ce0028        	ldw	x,_ee_K+14
8545  19ac 1c000a        	addw	x,#10
8546  19af cf0028        	ldw	_ee_K+14,x
8548  19b2 2024          	jra	L3563
8549  19b4               L5563:
8550                     ; 1766 		else if((mess[9]&0x0f)==0x04)
8552  19b4 b6cd          	ld	a,_mess+9
8553  19b6 a40f          	and	a,#15
8554  19b8 a104          	cp	a,#4
8555  19ba 260b          	jrne	L1663
8556                     ; 1768 			ee_K[3][1]--;
8558  19bc ce0028        	ldw	x,_ee_K+14
8559  19bf 1d0001        	subw	x,#1
8560  19c2 cf0028        	ldw	_ee_K+14,x
8562  19c5 2011          	jra	L3563
8563  19c7               L1663:
8564                     ; 1770 		else if((mess[9]&0x0f)==0x05)
8566  19c7 b6cd          	ld	a,_mess+9
8567  19c9 a40f          	and	a,#15
8568  19cb a105          	cp	a,#5
8569  19cd 2609          	jrne	L3563
8570                     ; 1772 			ee_K[3][1]-=10;
8572  19cf ce0028        	ldw	x,_ee_K+14
8573  19d2 1d000a        	subw	x,#10
8574  19d5 cf0028        	ldw	_ee_K+14,x
8575  19d8               L3563:
8576                     ; 1774 		granee(&ee_K[3][1],300,517);									
8578  19d8 ae0205        	ldw	x,#517
8579  19db 89            	pushw	x
8580  19dc ae012c        	ldw	x,#300
8581  19df 89            	pushw	x
8582  19e0 ae0028        	ldw	x,#_ee_K+14
8583  19e3 cd00f2        	call	_granee
8585  19e6 5b04          	addw	sp,#4
8586  19e8               L1753:
8587                     ; 1777 	link_cnt=0;
8589  19e8 5f            	clrw	x
8590  19e9 bf61          	ldw	_link_cnt,x
8591                     ; 1778      link=ON;
8593  19eb 35550063      	mov	_link,#85
8594                     ; 1779      if(res_fl_)
8596  19ef 725d000a      	tnz	_res_fl_
8597  19f3 2603          	jrne	L022
8598  19f5 cc1d37        	jp	L3543
8599  19f8               L022:
8600                     ; 1781       	res_fl_=0;
8602  19f8 4f            	clr	a
8603  19f9 ae000a        	ldw	x,#_res_fl_
8604  19fc cd0000        	call	c_eewrc
8606  19ff ac371d37      	jpf	L3543
8607  1a03               L3453:
8608                     ; 1787 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8610  1a03 b6ca          	ld	a,_mess+6
8611  1a05 a1ff          	cp	a,#255
8612  1a07 2703          	jreq	L222
8613  1a09 cc1a97        	jp	L3763
8614  1a0c               L222:
8616  1a0c b6cb          	ld	a,_mess+7
8617  1a0e a1ff          	cp	a,#255
8618  1a10 2703          	jreq	L422
8619  1a12 cc1a97        	jp	L3763
8620  1a15               L422:
8622  1a15 b6cc          	ld	a,_mess+8
8623  1a17 a162          	cp	a,#98
8624  1a19 267c          	jrne	L3763
8625                     ; 1790 	tempSS=mess[9]+(mess[10]*256);
8627  1a1b b6ce          	ld	a,_mess+10
8628  1a1d 5f            	clrw	x
8629  1a1e 97            	ld	xl,a
8630  1a1f 4f            	clr	a
8631  1a20 02            	rlwa	x,a
8632  1a21 01            	rrwa	x,a
8633  1a22 bbcd          	add	a,_mess+9
8634  1a24 2401          	jrnc	L071
8635  1a26 5c            	incw	x
8636  1a27               L071:
8637  1a27 02            	rlwa	x,a
8638  1a28 1f04          	ldw	(OFST-1,sp),x
8639  1a2a 01            	rrwa	x,a
8640                     ; 1791 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8642  1a2b ce0014        	ldw	x,_ee_Umax
8643  1a2e 1304          	cpw	x,(OFST-1,sp)
8644  1a30 270a          	jreq	L5763
8647  1a32 1e04          	ldw	x,(OFST-1,sp)
8648  1a34 89            	pushw	x
8649  1a35 ae0014        	ldw	x,#_ee_Umax
8650  1a38 cd0000        	call	c_eewrw
8652  1a3b 85            	popw	x
8653  1a3c               L5763:
8654                     ; 1792 	tempSS=mess[11]+(mess[12]*256);
8656  1a3c b6d0          	ld	a,_mess+12
8657  1a3e 5f            	clrw	x
8658  1a3f 97            	ld	xl,a
8659  1a40 4f            	clr	a
8660  1a41 02            	rlwa	x,a
8661  1a42 01            	rrwa	x,a
8662  1a43 bbcf          	add	a,_mess+11
8663  1a45 2401          	jrnc	L271
8664  1a47 5c            	incw	x
8665  1a48               L271:
8666  1a48 02            	rlwa	x,a
8667  1a49 1f04          	ldw	(OFST-1,sp),x
8668  1a4b 01            	rrwa	x,a
8669                     ; 1793 	if(ee_dU!=tempSS) ee_dU=tempSS;
8671  1a4c ce0012        	ldw	x,_ee_dU
8672  1a4f 1304          	cpw	x,(OFST-1,sp)
8673  1a51 270a          	jreq	L7763
8676  1a53 1e04          	ldw	x,(OFST-1,sp)
8677  1a55 89            	pushw	x
8678  1a56 ae0012        	ldw	x,#_ee_dU
8679  1a59 cd0000        	call	c_eewrw
8681  1a5c 85            	popw	x
8682  1a5d               L7763:
8683                     ; 1794 	if((mess[13]&0x0f)==0x5)
8685  1a5d b6d1          	ld	a,_mess+13
8686  1a5f a40f          	and	a,#15
8687  1a61 a105          	cp	a,#5
8688  1a63 261a          	jrne	L1073
8689                     ; 1796 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8691  1a65 ce0006        	ldw	x,_ee_AVT_MODE
8692  1a68 a30055        	cpw	x,#85
8693  1a6b 2603          	jrne	L622
8694  1a6d cc1d37        	jp	L3543
8695  1a70               L622:
8698  1a70 ae0055        	ldw	x,#85
8699  1a73 89            	pushw	x
8700  1a74 ae0006        	ldw	x,#_ee_AVT_MODE
8701  1a77 cd0000        	call	c_eewrw
8703  1a7a 85            	popw	x
8704  1a7b ac371d37      	jpf	L3543
8705  1a7f               L1073:
8706                     ; 1798 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8708  1a7f ce0006        	ldw	x,_ee_AVT_MODE
8709  1a82 a30055        	cpw	x,#85
8710  1a85 2703          	jreq	L032
8711  1a87 cc1d37        	jp	L3543
8712  1a8a               L032:
8715  1a8a 5f            	clrw	x
8716  1a8b 89            	pushw	x
8717  1a8c ae0006        	ldw	x,#_ee_AVT_MODE
8718  1a8f cd0000        	call	c_eewrw
8720  1a92 85            	popw	x
8721  1a93 ac371d37      	jpf	L3543
8722  1a97               L3763:
8723                     ; 1801 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8725  1a97 b6ca          	ld	a,_mess+6
8726  1a99 a1ff          	cp	a,#255
8727  1a9b 2703          	jreq	L232
8728  1a9d cc1b6e        	jp	L3173
8729  1aa0               L232:
8731  1aa0 b6cb          	ld	a,_mess+7
8732  1aa2 a1ff          	cp	a,#255
8733  1aa4 2703          	jreq	L432
8734  1aa6 cc1b6e        	jp	L3173
8735  1aa9               L432:
8737  1aa9 b6cc          	ld	a,_mess+8
8738  1aab a126          	cp	a,#38
8739  1aad 2709          	jreq	L5173
8741  1aaf b6cc          	ld	a,_mess+8
8742  1ab1 a129          	cp	a,#41
8743  1ab3 2703          	jreq	L632
8744  1ab5 cc1b6e        	jp	L3173
8745  1ab8               L632:
8746  1ab8               L5173:
8747                     ; 1804 	tempSS=mess[9]+(mess[10]*256);
8749  1ab8 b6ce          	ld	a,_mess+10
8750  1aba 5f            	clrw	x
8751  1abb 97            	ld	xl,a
8752  1abc 4f            	clr	a
8753  1abd 02            	rlwa	x,a
8754  1abe 01            	rrwa	x,a
8755  1abf bbcd          	add	a,_mess+9
8756  1ac1 2401          	jrnc	L471
8757  1ac3 5c            	incw	x
8758  1ac4               L471:
8759  1ac4 02            	rlwa	x,a
8760  1ac5 1f04          	ldw	(OFST-1,sp),x
8761  1ac7 01            	rrwa	x,a
8762                     ; 1805 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8764  1ac8 ce0010        	ldw	x,_ee_tmax
8765  1acb 1304          	cpw	x,(OFST-1,sp)
8766  1acd 270a          	jreq	L7173
8769  1acf 1e04          	ldw	x,(OFST-1,sp)
8770  1ad1 89            	pushw	x
8771  1ad2 ae0010        	ldw	x,#_ee_tmax
8772  1ad5 cd0000        	call	c_eewrw
8774  1ad8 85            	popw	x
8775  1ad9               L7173:
8776                     ; 1806 	tempSS=mess[11]+(mess[12]*256);
8778  1ad9 b6d0          	ld	a,_mess+12
8779  1adb 5f            	clrw	x
8780  1adc 97            	ld	xl,a
8781  1add 4f            	clr	a
8782  1ade 02            	rlwa	x,a
8783  1adf 01            	rrwa	x,a
8784  1ae0 bbcf          	add	a,_mess+11
8785  1ae2 2401          	jrnc	L671
8786  1ae4 5c            	incw	x
8787  1ae5               L671:
8788  1ae5 02            	rlwa	x,a
8789  1ae6 1f04          	ldw	(OFST-1,sp),x
8790  1ae8 01            	rrwa	x,a
8791                     ; 1807 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8793  1ae9 ce000e        	ldw	x,_ee_tsign
8794  1aec 1304          	cpw	x,(OFST-1,sp)
8795  1aee 270a          	jreq	L1273
8798  1af0 1e04          	ldw	x,(OFST-1,sp)
8799  1af2 89            	pushw	x
8800  1af3 ae000e        	ldw	x,#_ee_tsign
8801  1af6 cd0000        	call	c_eewrw
8803  1af9 85            	popw	x
8804  1afa               L1273:
8805                     ; 1810 	if(mess[8]==MEM_KF1)
8807  1afa b6cc          	ld	a,_mess+8
8808  1afc a126          	cp	a,#38
8809  1afe 2623          	jrne	L3273
8810                     ; 1812 		if(ee_DEVICE!=0)ee_DEVICE=0;
8812  1b00 ce0004        	ldw	x,_ee_DEVICE
8813  1b03 2709          	jreq	L5273
8816  1b05 5f            	clrw	x
8817  1b06 89            	pushw	x
8818  1b07 ae0004        	ldw	x,#_ee_DEVICE
8819  1b0a cd0000        	call	c_eewrw
8821  1b0d 85            	popw	x
8822  1b0e               L5273:
8823                     ; 1813 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8825  1b0e b6d1          	ld	a,_mess+13
8826  1b10 5f            	clrw	x
8827  1b11 97            	ld	xl,a
8828  1b12 c30016        	cpw	x,_ee_TZAS
8829  1b15 270c          	jreq	L3273
8832  1b17 b6d1          	ld	a,_mess+13
8833  1b19 5f            	clrw	x
8834  1b1a 97            	ld	xl,a
8835  1b1b 89            	pushw	x
8836  1b1c ae0016        	ldw	x,#_ee_TZAS
8837  1b1f cd0000        	call	c_eewrw
8839  1b22 85            	popw	x
8840  1b23               L3273:
8841                     ; 1815 	if(mess[8]==MEM_KF4)	//MEM_KF4 �������� ������ ���, ��� ����� ������ ���������� ������ � ���, ��������-���������, ������ �� ��� ����
8843  1b23 b6cc          	ld	a,_mess+8
8844  1b25 a129          	cp	a,#41
8845  1b27 2703          	jreq	L042
8846  1b29 cc1d37        	jp	L3543
8847  1b2c               L042:
8848                     ; 1817 		if(ee_DEVICE!=1)ee_DEVICE=1;
8850  1b2c ce0004        	ldw	x,_ee_DEVICE
8851  1b2f a30001        	cpw	x,#1
8852  1b32 270b          	jreq	L3373
8855  1b34 ae0001        	ldw	x,#1
8856  1b37 89            	pushw	x
8857  1b38 ae0004        	ldw	x,#_ee_DEVICE
8858  1b3b cd0000        	call	c_eewrw
8860  1b3e 85            	popw	x
8861  1b3f               L3373:
8862                     ; 1818 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8864  1b3f b6d1          	ld	a,_mess+13
8865  1b41 5f            	clrw	x
8866  1b42 97            	ld	xl,a
8867  1b43 c30002        	cpw	x,_ee_IMAXVENT
8868  1b46 270c          	jreq	L5373
8871  1b48 b6d1          	ld	a,_mess+13
8872  1b4a 5f            	clrw	x
8873  1b4b 97            	ld	xl,a
8874  1b4c 89            	pushw	x
8875  1b4d ae0002        	ldw	x,#_ee_IMAXVENT
8876  1b50 cd0000        	call	c_eewrw
8878  1b53 85            	popw	x
8879  1b54               L5373:
8880                     ; 1819 			if(ee_TZAS!=3) ee_TZAS=3;
8882  1b54 ce0016        	ldw	x,_ee_TZAS
8883  1b57 a30003        	cpw	x,#3
8884  1b5a 2603          	jrne	L242
8885  1b5c cc1d37        	jp	L3543
8886  1b5f               L242:
8889  1b5f ae0003        	ldw	x,#3
8890  1b62 89            	pushw	x
8891  1b63 ae0016        	ldw	x,#_ee_TZAS
8892  1b66 cd0000        	call	c_eewrw
8894  1b69 85            	popw	x
8895  1b6a ac371d37      	jpf	L3543
8896  1b6e               L3173:
8897                     ; 1823 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8899  1b6e b6ca          	ld	a,_mess+6
8900  1b70 c10005        	cp	a,_adress
8901  1b73 262d          	jrne	L3473
8903  1b75 b6cb          	ld	a,_mess+7
8904  1b77 c10005        	cp	a,_adress
8905  1b7a 2626          	jrne	L3473
8907  1b7c b6cc          	ld	a,_mess+8
8908  1b7e a116          	cp	a,#22
8909  1b80 2620          	jrne	L3473
8911  1b82 b6cd          	ld	a,_mess+9
8912  1b84 a163          	cp	a,#99
8913  1b86 261a          	jrne	L3473
8914                     ; 1825 	flags&=0b11100001;
8916  1b88 b60b          	ld	a,_flags
8917  1b8a a4e1          	and	a,#225
8918  1b8c b70b          	ld	_flags,a
8919                     ; 1826 	tsign_cnt=0;
8921  1b8e 5f            	clrw	x
8922  1b8f bf4d          	ldw	_tsign_cnt,x
8923                     ; 1827 	tmax_cnt=0;
8925  1b91 5f            	clrw	x
8926  1b92 bf4b          	ldw	_tmax_cnt,x
8927                     ; 1828 	umax_cnt=0;
8929  1b94 5f            	clrw	x
8930  1b95 bf66          	ldw	_umax_cnt,x
8931                     ; 1829 	umin_cnt=0;
8933  1b97 5f            	clrw	x
8934  1b98 bf64          	ldw	_umin_cnt,x
8935                     ; 1830 	led_drv_cnt=30;
8937  1b9a 351e001c      	mov	_led_drv_cnt,#30
8939  1b9e ac371d37      	jpf	L3543
8940  1ba2               L3473:
8941                     ; 1833 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8943  1ba2 b6ca          	ld	a,_mess+6
8944  1ba4 c10005        	cp	a,_adress
8945  1ba7 2620          	jrne	L7473
8947  1ba9 b6cb          	ld	a,_mess+7
8948  1bab c10005        	cp	a,_adress
8949  1bae 2619          	jrne	L7473
8951  1bb0 b6cc          	ld	a,_mess+8
8952  1bb2 a116          	cp	a,#22
8953  1bb4 2613          	jrne	L7473
8955  1bb6 b6cd          	ld	a,_mess+9
8956  1bb8 a164          	cp	a,#100
8957  1bba 260d          	jrne	L7473
8958                     ; 1835 	vent_resurs=0;
8960  1bbc 5f            	clrw	x
8961  1bbd 89            	pushw	x
8962  1bbe ae0000        	ldw	x,#_vent_resurs
8963  1bc1 cd0000        	call	c_eewrw
8965  1bc4 85            	popw	x
8967  1bc5 ac371d37      	jpf	L3543
8968  1bc9               L7473:
8969                     ; 1839 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8971  1bc9 b6ca          	ld	a,_mess+6
8972  1bcb a1ff          	cp	a,#255
8973  1bcd 265f          	jrne	L3573
8975  1bcf b6cb          	ld	a,_mess+7
8976  1bd1 a1ff          	cp	a,#255
8977  1bd3 2659          	jrne	L3573
8979  1bd5 b6cc          	ld	a,_mess+8
8980  1bd7 a116          	cp	a,#22
8981  1bd9 2653          	jrne	L3573
8983  1bdb b6cd          	ld	a,_mess+9
8984  1bdd a116          	cp	a,#22
8985  1bdf 264d          	jrne	L3573
8986                     ; 1841 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8988  1be1 b6ce          	ld	a,_mess+10
8989  1be3 a155          	cp	a,#85
8990  1be5 260f          	jrne	L5573
8992  1be7 b6cf          	ld	a,_mess+11
8993  1be9 a155          	cp	a,#85
8994  1beb 2609          	jrne	L5573
8997  1bed be5e          	ldw	x,__x_
8998  1bef 1c0001        	addw	x,#1
8999  1bf2 bf5e          	ldw	__x_,x
9001  1bf4 2024          	jra	L7573
9002  1bf6               L5573:
9003                     ; 1842 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9005  1bf6 b6ce          	ld	a,_mess+10
9006  1bf8 a166          	cp	a,#102
9007  1bfa 260f          	jrne	L1673
9009  1bfc b6cf          	ld	a,_mess+11
9010  1bfe a166          	cp	a,#102
9011  1c00 2609          	jrne	L1673
9014  1c02 be5e          	ldw	x,__x_
9015  1c04 1d0001        	subw	x,#1
9016  1c07 bf5e          	ldw	__x_,x
9018  1c09 200f          	jra	L7573
9019  1c0b               L1673:
9020                     ; 1843 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9022  1c0b b6ce          	ld	a,_mess+10
9023  1c0d a177          	cp	a,#119
9024  1c0f 2609          	jrne	L7573
9026  1c11 b6cf          	ld	a,_mess+11
9027  1c13 a177          	cp	a,#119
9028  1c15 2603          	jrne	L7573
9031  1c17 5f            	clrw	x
9032  1c18 bf5e          	ldw	__x_,x
9033  1c1a               L7573:
9034                     ; 1844      gran(&_x_,-XMAX,XMAX);
9036  1c1a ae0019        	ldw	x,#25
9037  1c1d 89            	pushw	x
9038  1c1e aeffe7        	ldw	x,#65511
9039  1c21 89            	pushw	x
9040  1c22 ae005e        	ldw	x,#__x_
9041  1c25 cd00d1        	call	_gran
9043  1c28 5b04          	addw	sp,#4
9045  1c2a ac371d37      	jpf	L3543
9046  1c2e               L3573:
9047                     ; 1846 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9049  1c2e b6ca          	ld	a,_mess+6
9050  1c30 c10005        	cp	a,_adress
9051  1c33 2665          	jrne	L1773
9053  1c35 b6cb          	ld	a,_mess+7
9054  1c37 c10005        	cp	a,_adress
9055  1c3a 265e          	jrne	L1773
9057  1c3c b6cc          	ld	a,_mess+8
9058  1c3e a116          	cp	a,#22
9059  1c40 2658          	jrne	L1773
9061  1c42 b6cd          	ld	a,_mess+9
9062  1c44 b1ce          	cp	a,_mess+10
9063  1c46 2652          	jrne	L1773
9065  1c48 b6cd          	ld	a,_mess+9
9066  1c4a a1ee          	cp	a,#238
9067  1c4c 264c          	jrne	L1773
9068                     ; 1848 	rotor_int++;
9070  1c4e be1d          	ldw	x,_rotor_int
9071  1c50 1c0001        	addw	x,#1
9072  1c53 bf1d          	ldw	_rotor_int,x
9073                     ; 1849      tempI=pwm_u;
9075  1c55 be0e          	ldw	x,_pwm_u
9076  1c57 1f04          	ldw	(OFST-1,sp),x
9077                     ; 1850 	ee_U_AVT=tempI;
9079  1c59 1e04          	ldw	x,(OFST-1,sp)
9080  1c5b 89            	pushw	x
9081  1c5c ae000c        	ldw	x,#_ee_U_AVT
9082  1c5f cd0000        	call	c_eewrw
9084  1c62 85            	popw	x
9085                     ; 1851 	UU_AVT=Un;
9087  1c63 be6d          	ldw	x,_Un
9088  1c65 89            	pushw	x
9089  1c66 ae0008        	ldw	x,#_UU_AVT
9090  1c69 cd0000        	call	c_eewrw
9092  1c6c 85            	popw	x
9093                     ; 1852 	delay_ms(100);
9095  1c6d ae0064        	ldw	x,#100
9096  1c70 cd011d        	call	_delay_ms
9098                     ; 1853 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9100  1c73 ce000c        	ldw	x,_ee_U_AVT
9101  1c76 1304          	cpw	x,(OFST-1,sp)
9102  1c78 2703          	jreq	L442
9103  1c7a cc1d37        	jp	L3543
9104  1c7d               L442:
9107  1c7d 4b00          	push	#0
9108  1c7f 4b00          	push	#0
9109  1c81 4b00          	push	#0
9110  1c83 4b00          	push	#0
9111  1c85 4bdd          	push	#221
9112  1c87 4bdd          	push	#221
9113  1c89 4b91          	push	#145
9114  1c8b 3b0005        	push	_adress
9115  1c8e ae018e        	ldw	x,#398
9116  1c91 cd152b        	call	_can_transmit
9118  1c94 5b08          	addw	sp,#8
9119  1c96 ac371d37      	jpf	L3543
9120  1c9a               L1773:
9121                     ; 1858 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9123  1c9a b6cb          	ld	a,_mess+7
9124  1c9c a1da          	cp	a,#218
9125  1c9e 2652          	jrne	L7773
9127  1ca0 b6ca          	ld	a,_mess+6
9128  1ca2 c10005        	cp	a,_adress
9129  1ca5 274b          	jreq	L7773
9131  1ca7 b6ca          	ld	a,_mess+6
9132  1ca9 a106          	cp	a,#6
9133  1cab 2445          	jruge	L7773
9134                     ; 1860 	i_main_bps_cnt[mess[6]]=0;
9136  1cad b6ca          	ld	a,_mess+6
9137  1caf 5f            	clrw	x
9138  1cb0 97            	ld	xl,a
9139  1cb1 6f09          	clr	(_i_main_bps_cnt,x)
9140                     ; 1861 	i_main_flag[mess[6]]=1;
9142  1cb3 b6ca          	ld	a,_mess+6
9143  1cb5 5f            	clrw	x
9144  1cb6 97            	ld	xl,a
9145  1cb7 a601          	ld	a,#1
9146  1cb9 e714          	ld	(_i_main_flag,x),a
9147                     ; 1862 	if(bMAIN)
9149                     	btst	_bMAIN
9150  1cc0 2475          	jruge	L3543
9151                     ; 1864 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9153  1cc2 b6cd          	ld	a,_mess+9
9154  1cc4 5f            	clrw	x
9155  1cc5 97            	ld	xl,a
9156  1cc6 4f            	clr	a
9157  1cc7 02            	rlwa	x,a
9158  1cc8 1f01          	ldw	(OFST-4,sp),x
9159  1cca b6cc          	ld	a,_mess+8
9160  1ccc 5f            	clrw	x
9161  1ccd 97            	ld	xl,a
9162  1cce 72fb01        	addw	x,(OFST-4,sp)
9163  1cd1 b6ca          	ld	a,_mess+6
9164  1cd3 905f          	clrw	y
9165  1cd5 9097          	ld	yl,a
9166  1cd7 9058          	sllw	y
9167  1cd9 90ef1a        	ldw	(_i_main,y),x
9168                     ; 1865 		i_main[adress]=I;
9170  1cdc c60005        	ld	a,_adress
9171  1cdf 5f            	clrw	x
9172  1ce0 97            	ld	xl,a
9173  1ce1 58            	sllw	x
9174  1ce2 90be6f        	ldw	y,_I
9175  1ce5 ef1a          	ldw	(_i_main,x),y
9176                     ; 1866      	i_main_flag[adress]=1;
9178  1ce7 c60005        	ld	a,_adress
9179  1cea 5f            	clrw	x
9180  1ceb 97            	ld	xl,a
9181  1cec a601          	ld	a,#1
9182  1cee e714          	ld	(_i_main_flag,x),a
9183  1cf0 2045          	jra	L3543
9184  1cf2               L7773:
9185                     ; 1870 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9187  1cf2 b6cb          	ld	a,_mess+7
9188  1cf4 a1db          	cp	a,#219
9189  1cf6 263f          	jrne	L3543
9191  1cf8 b6ca          	ld	a,_mess+6
9192  1cfa c10005        	cp	a,_adress
9193  1cfd 2738          	jreq	L3543
9195  1cff b6ca          	ld	a,_mess+6
9196  1d01 a106          	cp	a,#6
9197  1d03 2432          	jruge	L3543
9198                     ; 1872 	i_main_bps_cnt[mess[6]]=0;
9200  1d05 b6ca          	ld	a,_mess+6
9201  1d07 5f            	clrw	x
9202  1d08 97            	ld	xl,a
9203  1d09 6f09          	clr	(_i_main_bps_cnt,x)
9204                     ; 1873 	i_main_flag[mess[6]]=1;		
9206  1d0b b6ca          	ld	a,_mess+6
9207  1d0d 5f            	clrw	x
9208  1d0e 97            	ld	xl,a
9209  1d0f a601          	ld	a,#1
9210  1d11 e714          	ld	(_i_main_flag,x),a
9211                     ; 1874 	if(bMAIN)
9213                     	btst	_bMAIN
9214  1d18 241d          	jruge	L3543
9215                     ; 1876 		if(mess[9]==0)i_main_flag[i]=1;
9217  1d1a 3dcd          	tnz	_mess+9
9218  1d1c 260a          	jrne	L1104
9221  1d1e 7b03          	ld	a,(OFST-2,sp)
9222  1d20 5f            	clrw	x
9223  1d21 97            	ld	xl,a
9224  1d22 a601          	ld	a,#1
9225  1d24 e714          	ld	(_i_main_flag,x),a
9227  1d26 2006          	jra	L3104
9228  1d28               L1104:
9229                     ; 1877 		else i_main_flag[i]=0;
9231  1d28 7b03          	ld	a,(OFST-2,sp)
9232  1d2a 5f            	clrw	x
9233  1d2b 97            	ld	xl,a
9234  1d2c 6f14          	clr	(_i_main_flag,x)
9235  1d2e               L3104:
9236                     ; 1878 		i_main_flag[adress]=1;
9238  1d2e c60005        	ld	a,_adress
9239  1d31 5f            	clrw	x
9240  1d32 97            	ld	xl,a
9241  1d33 a601          	ld	a,#1
9242  1d35 e714          	ld	(_i_main_flag,x),a
9243  1d37               L3543:
9244                     ; 1884 can_in_an_end:
9244                     ; 1885 bCAN_RX=0;
9246  1d37 3f0a          	clr	_bCAN_RX
9247                     ; 1886 }   
9250  1d39 5b05          	addw	sp,#5
9251  1d3b 81            	ret
9274                     ; 1889 void t4_init(void){
9275                     	switch	.text
9276  1d3c               _t4_init:
9280                     ; 1890 	TIM4->PSCR = 4;
9282  1d3c 35045345      	mov	21317,#4
9283                     ; 1891 	TIM4->ARR= 61;
9285  1d40 353d5346      	mov	21318,#61
9286                     ; 1892 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9288  1d44 72105341      	bset	21313,#0
9289                     ; 1894 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9291  1d48 35855340      	mov	21312,#133
9292                     ; 1896 }
9295  1d4c 81            	ret
9318                     ; 1899 void t1_init(void)
9318                     ; 1900 {
9319                     	switch	.text
9320  1d4d               _t1_init:
9324                     ; 1901 TIM1->ARRH= 0x03;
9326  1d4d 35035262      	mov	21090,#3
9327                     ; 1902 TIM1->ARRL= 0xff;
9329  1d51 35ff5263      	mov	21091,#255
9330                     ; 1903 TIM1->CCR1H= 0x00;	
9332  1d55 725f5265      	clr	21093
9333                     ; 1904 TIM1->CCR1L= 0xff;
9335  1d59 35ff5266      	mov	21094,#255
9336                     ; 1905 TIM1->CCR2H= 0x00;	
9338  1d5d 725f5267      	clr	21095
9339                     ; 1906 TIM1->CCR2L= 0x00;
9341  1d61 725f5268      	clr	21096
9342                     ; 1907 TIM1->CCR3H= 0x00;	
9344  1d65 725f5269      	clr	21097
9345                     ; 1908 TIM1->CCR3L= 0x64;
9347  1d69 3564526a      	mov	21098,#100
9348                     ; 1910 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9350  1d6d 35685258      	mov	21080,#104
9351                     ; 1911 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9353  1d71 35685259      	mov	21081,#104
9354                     ; 1912 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9356  1d75 3568525a      	mov	21082,#104
9357                     ; 1913 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9359  1d79 3511525c      	mov	21084,#17
9360                     ; 1914 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9362  1d7d 3501525d      	mov	21085,#1
9363                     ; 1915 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9365  1d81 35815250      	mov	21072,#129
9366                     ; 1916 TIM1->BKR|= TIM1_BKR_AOE;
9368  1d85 721c526d      	bset	21101,#6
9369                     ; 1917 }
9372  1d89 81            	ret
9397                     ; 1921 void adc2_init(void)
9397                     ; 1922 {
9398                     	switch	.text
9399  1d8a               _adc2_init:
9403                     ; 1923 adc_plazma[0]++;
9405  1d8a beb6          	ldw	x,_adc_plazma
9406  1d8c 1c0001        	addw	x,#1
9407  1d8f bfb6          	ldw	_adc_plazma,x
9408                     ; 1947 GPIOB->DDR&=~(1<<4);
9410  1d91 72195007      	bres	20487,#4
9411                     ; 1948 GPIOB->CR1&=~(1<<4);
9413  1d95 72195008      	bres	20488,#4
9414                     ; 1949 GPIOB->CR2&=~(1<<4);
9416  1d99 72195009      	bres	20489,#4
9417                     ; 1951 GPIOB->DDR&=~(1<<5);
9419  1d9d 721b5007      	bres	20487,#5
9420                     ; 1952 GPIOB->CR1&=~(1<<5);
9422  1da1 721b5008      	bres	20488,#5
9423                     ; 1953 GPIOB->CR2&=~(1<<5);
9425  1da5 721b5009      	bres	20489,#5
9426                     ; 1955 GPIOB->DDR&=~(1<<6);
9428  1da9 721d5007      	bres	20487,#6
9429                     ; 1956 GPIOB->CR1&=~(1<<6);
9431  1dad 721d5008      	bres	20488,#6
9432                     ; 1957 GPIOB->CR2&=~(1<<6);
9434  1db1 721d5009      	bres	20489,#6
9435                     ; 1959 GPIOB->DDR&=~(1<<7);
9437  1db5 721f5007      	bres	20487,#7
9438                     ; 1960 GPIOB->CR1&=~(1<<7);
9440  1db9 721f5008      	bres	20488,#7
9441                     ; 1961 GPIOB->CR2&=~(1<<7);
9443  1dbd 721f5009      	bres	20489,#7
9444                     ; 1971 ADC2->TDRL=0xff;
9446  1dc1 35ff5407      	mov	21511,#255
9447                     ; 1973 ADC2->CR2=0x08;
9449  1dc5 35085402      	mov	21506,#8
9450                     ; 1974 ADC2->CR1=0x40;
9452  1dc9 35405401      	mov	21505,#64
9453                     ; 1977 	ADC2->CSR=0x20+adc_ch+3;
9455  1dcd b6c3          	ld	a,_adc_ch
9456  1dcf ab23          	add	a,#35
9457  1dd1 c75400        	ld	21504,a
9458                     ; 1979 	ADC2->CR1|=1;
9460  1dd4 72105401      	bset	21505,#0
9461                     ; 1980 	ADC2->CR1|=1;
9463  1dd8 72105401      	bset	21505,#0
9464                     ; 1983 adc_plazma[1]=adc_ch;
9466  1ddc b6c3          	ld	a,_adc_ch
9467  1dde 5f            	clrw	x
9468  1ddf 97            	ld	xl,a
9469  1de0 bfb8          	ldw	_adc_plazma+2,x
9470                     ; 1984 }
9473  1de2 81            	ret
9507                     ; 1993 @far @interrupt void TIM4_UPD_Interrupt (void) 
9507                     ; 1994 {
9509                     	switch	.text
9510  1de3               f_TIM4_UPD_Interrupt:
9514                     ; 1995 TIM4->SR1&=~TIM4_SR1_UIF;
9516  1de3 72115342      	bres	21314,#0
9517                     ; 1997 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9519  1de7 3c08          	inc	_pwm_vent_cnt
9520  1de9 b608          	ld	a,_pwm_vent_cnt
9521  1deb a10a          	cp	a,#10
9522  1ded 2502          	jrult	L5504
9525  1def 3f08          	clr	_pwm_vent_cnt
9526  1df1               L5504:
9527                     ; 1998 GPIOB->ODR|=(1<<3);
9529  1df1 72165005      	bset	20485,#3
9530                     ; 1999 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9532  1df5 b608          	ld	a,_pwm_vent_cnt
9533  1df7 a105          	cp	a,#5
9534  1df9 2504          	jrult	L7504
9537  1dfb 72175005      	bres	20485,#3
9538  1dff               L7504:
9539                     ; 2004 if(++t0_cnt0>=100)
9541  1dff 9c            	rvf
9542  1e00 be01          	ldw	x,_t0_cnt0
9543  1e02 1c0001        	addw	x,#1
9544  1e05 bf01          	ldw	_t0_cnt0,x
9545  1e07 a30064        	cpw	x,#100
9546  1e0a 2f3f          	jrslt	L1604
9547                     ; 2006 	t0_cnt0=0;
9549  1e0c 5f            	clrw	x
9550  1e0d bf01          	ldw	_t0_cnt0,x
9551                     ; 2007 	b100Hz=1;
9553  1e0f 72100008      	bset	_b100Hz
9554                     ; 2009 	if(++t0_cnt1>=10)
9556  1e13 3c03          	inc	_t0_cnt1
9557  1e15 b603          	ld	a,_t0_cnt1
9558  1e17 a10a          	cp	a,#10
9559  1e19 2506          	jrult	L3604
9560                     ; 2011 		t0_cnt1=0;
9562  1e1b 3f03          	clr	_t0_cnt1
9563                     ; 2012 		b10Hz=1;
9565  1e1d 72100007      	bset	_b10Hz
9566  1e21               L3604:
9567                     ; 2015 	if(++t0_cnt2>=20)
9569  1e21 3c04          	inc	_t0_cnt2
9570  1e23 b604          	ld	a,_t0_cnt2
9571  1e25 a114          	cp	a,#20
9572  1e27 2506          	jrult	L5604
9573                     ; 2017 		t0_cnt2=0;
9575  1e29 3f04          	clr	_t0_cnt2
9576                     ; 2018 		b5Hz=1;
9578  1e2b 72100006      	bset	_b5Hz
9579  1e2f               L5604:
9580                     ; 2022 	if(++t0_cnt4>=50)
9582  1e2f 3c06          	inc	_t0_cnt4
9583  1e31 b606          	ld	a,_t0_cnt4
9584  1e33 a132          	cp	a,#50
9585  1e35 2506          	jrult	L7604
9586                     ; 2024 		t0_cnt4=0;
9588  1e37 3f06          	clr	_t0_cnt4
9589                     ; 2025 		b2Hz=1;
9591  1e39 72100005      	bset	_b2Hz
9592  1e3d               L7604:
9593                     ; 2028 	if(++t0_cnt3>=100)
9595  1e3d 3c05          	inc	_t0_cnt3
9596  1e3f b605          	ld	a,_t0_cnt3
9597  1e41 a164          	cp	a,#100
9598  1e43 2506          	jrult	L1604
9599                     ; 2030 		t0_cnt3=0;
9601  1e45 3f05          	clr	_t0_cnt3
9602                     ; 2031 		b1Hz=1;
9604  1e47 72100004      	bset	_b1Hz
9605  1e4b               L1604:
9606                     ; 2037 }
9609  1e4b 80            	iret
9634                     ; 2040 @far @interrupt void CAN_RX_Interrupt (void) 
9634                     ; 2041 {
9635                     	switch	.text
9636  1e4c               f_CAN_RX_Interrupt:
9640                     ; 2043 CAN->PSR= 7;									// page 7 - read messsage
9642  1e4c 35075427      	mov	21543,#7
9643                     ; 2045 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9645  1e50 ae000e        	ldw	x,#14
9646  1e53               L062:
9647  1e53 d65427        	ld	a,(21543,x)
9648  1e56 e7c3          	ld	(_mess-1,x),a
9649  1e58 5a            	decw	x
9650  1e59 26f8          	jrne	L062
9651                     ; 2056 bCAN_RX=1;
9653  1e5b 3501000a      	mov	_bCAN_RX,#1
9654                     ; 2057 CAN->RFR|=(1<<5);
9656  1e5f 721a5424      	bset	21540,#5
9657                     ; 2059 }
9660  1e63 80            	iret
9683                     ; 2062 @far @interrupt void CAN_TX_Interrupt (void) 
9683                     ; 2063 {
9684                     	switch	.text
9685  1e64               f_CAN_TX_Interrupt:
9689                     ; 2064 if((CAN->TSR)&(1<<0))
9691  1e64 c65422        	ld	a,21538
9692  1e67 a501          	bcp	a,#1
9693  1e69 2708          	jreq	L3114
9694                     ; 2066 	bTX_FREE=1;	
9696  1e6b 35010009      	mov	_bTX_FREE,#1
9697                     ; 2068 	CAN->TSR|=(1<<0);
9699  1e6f 72105422      	bset	21538,#0
9700  1e73               L3114:
9701                     ; 2070 }
9704  1e73 80            	iret
9762                     ; 2073 @far @interrupt void ADC2_EOC_Interrupt (void) {
9763                     	switch	.text
9764  1e74               f_ADC2_EOC_Interrupt:
9766       00000009      OFST:	set	9
9767  1e74 be00          	ldw	x,c_x
9768  1e76 89            	pushw	x
9769  1e77 be00          	ldw	x,c_y
9770  1e79 89            	pushw	x
9771  1e7a be02          	ldw	x,c_lreg+2
9772  1e7c 89            	pushw	x
9773  1e7d be00          	ldw	x,c_lreg
9774  1e7f 89            	pushw	x
9775  1e80 5209          	subw	sp,#9
9778                     ; 2078 adc_plazma[2]++;
9780  1e82 beba          	ldw	x,_adc_plazma+4
9781  1e84 1c0001        	addw	x,#1
9782  1e87 bfba          	ldw	_adc_plazma+4,x
9783                     ; 2085 ADC2->CSR&=~(1<<7);
9785  1e89 721f5400      	bres	21504,#7
9786                     ; 2087 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9788  1e8d c65405        	ld	a,21509
9789  1e90 b703          	ld	c_lreg+3,a
9790  1e92 3f02          	clr	c_lreg+2
9791  1e94 3f01          	clr	c_lreg+1
9792  1e96 3f00          	clr	c_lreg
9793  1e98 96            	ldw	x,sp
9794  1e99 1c0001        	addw	x,#OFST-8
9795  1e9c cd0000        	call	c_rtol
9797  1e9f c65404        	ld	a,21508
9798  1ea2 5f            	clrw	x
9799  1ea3 97            	ld	xl,a
9800  1ea4 90ae0100      	ldw	y,#256
9801  1ea8 cd0000        	call	c_umul
9803  1eab 96            	ldw	x,sp
9804  1eac 1c0001        	addw	x,#OFST-8
9805  1eaf cd0000        	call	c_ladd
9807  1eb2 96            	ldw	x,sp
9808  1eb3 1c0006        	addw	x,#OFST-3
9809  1eb6 cd0000        	call	c_rtol
9811                     ; 2092 if(adr_drv_stat==1)
9813  1eb9 b608          	ld	a,_adr_drv_stat
9814  1ebb a101          	cp	a,#1
9815  1ebd 260b          	jrne	L3414
9816                     ; 2094 	adr_drv_stat=2;
9818  1ebf 35020008      	mov	_adr_drv_stat,#2
9819                     ; 2095 	adc_buff_[0]=temp_adc;
9821  1ec3 1e08          	ldw	x,(OFST-1,sp)
9822  1ec5 cf0009        	ldw	_adc_buff_,x
9824  1ec8 2020          	jra	L5414
9825  1eca               L3414:
9826                     ; 2098 else if(adr_drv_stat==3)
9828  1eca b608          	ld	a,_adr_drv_stat
9829  1ecc a103          	cp	a,#3
9830  1ece 260b          	jrne	L7414
9831                     ; 2100 	adr_drv_stat=4;
9833  1ed0 35040008      	mov	_adr_drv_stat,#4
9834                     ; 2101 	adc_buff_[1]=temp_adc;
9836  1ed4 1e08          	ldw	x,(OFST-1,sp)
9837  1ed6 cf000b        	ldw	_adc_buff_+2,x
9839  1ed9 200f          	jra	L5414
9840  1edb               L7414:
9841                     ; 2104 else if(adr_drv_stat==5)
9843  1edb b608          	ld	a,_adr_drv_stat
9844  1edd a105          	cp	a,#5
9845  1edf 2609          	jrne	L5414
9846                     ; 2106 	adr_drv_stat=6;
9848  1ee1 35060008      	mov	_adr_drv_stat,#6
9849                     ; 2107 	adc_buff_[9]=temp_adc;
9851  1ee5 1e08          	ldw	x,(OFST-1,sp)
9852  1ee7 cf001b        	ldw	_adc_buff_+18,x
9853  1eea               L5414:
9854                     ; 2110 adc_buff[adc_ch][adc_cnt]=temp_adc;
9856  1eea b6c2          	ld	a,_adc_cnt
9857  1eec 5f            	clrw	x
9858  1eed 97            	ld	xl,a
9859  1eee 58            	sllw	x
9860  1eef 1f03          	ldw	(OFST-6,sp),x
9861  1ef1 b6c3          	ld	a,_adc_ch
9862  1ef3 97            	ld	xl,a
9863  1ef4 a620          	ld	a,#32
9864  1ef6 42            	mul	x,a
9865  1ef7 72fb03        	addw	x,(OFST-6,sp)
9866  1efa 1608          	ldw	y,(OFST-1,sp)
9867  1efc df001d        	ldw	(_adc_buff,x),y
9868                     ; 2116 adc_ch++;
9870  1eff 3cc3          	inc	_adc_ch
9871                     ; 2117 if(adc_ch>=5)
9873  1f01 b6c3          	ld	a,_adc_ch
9874  1f03 a105          	cp	a,#5
9875  1f05 250c          	jrult	L5514
9876                     ; 2120 	adc_ch=0;
9878  1f07 3fc3          	clr	_adc_ch
9879                     ; 2121 	adc_cnt++;
9881  1f09 3cc2          	inc	_adc_cnt
9882                     ; 2122 	if(adc_cnt>=16)
9884  1f0b b6c2          	ld	a,_adc_cnt
9885  1f0d a110          	cp	a,#16
9886  1f0f 2502          	jrult	L5514
9887                     ; 2124 		adc_cnt=0;
9889  1f11 3fc2          	clr	_adc_cnt
9890  1f13               L5514:
9891                     ; 2128 if((adc_cnt&0x03)==0)
9893  1f13 b6c2          	ld	a,_adc_cnt
9894  1f15 a503          	bcp	a,#3
9895  1f17 264b          	jrne	L1614
9896                     ; 2132 	tempSS=0;
9898  1f19 ae0000        	ldw	x,#0
9899  1f1c 1f08          	ldw	(OFST-1,sp),x
9900  1f1e ae0000        	ldw	x,#0
9901  1f21 1f06          	ldw	(OFST-3,sp),x
9902                     ; 2133 	for(i=0;i<16;i++)
9904  1f23 0f05          	clr	(OFST-4,sp)
9905  1f25               L3614:
9906                     ; 2135 		tempSS+=(signed long)adc_buff[adc_ch][i];
9908  1f25 7b05          	ld	a,(OFST-4,sp)
9909  1f27 5f            	clrw	x
9910  1f28 97            	ld	xl,a
9911  1f29 58            	sllw	x
9912  1f2a 1f03          	ldw	(OFST-6,sp),x
9913  1f2c b6c3          	ld	a,_adc_ch
9914  1f2e 97            	ld	xl,a
9915  1f2f a620          	ld	a,#32
9916  1f31 42            	mul	x,a
9917  1f32 72fb03        	addw	x,(OFST-6,sp)
9918  1f35 de001d        	ldw	x,(_adc_buff,x)
9919  1f38 cd0000        	call	c_itolx
9921  1f3b 96            	ldw	x,sp
9922  1f3c 1c0006        	addw	x,#OFST-3
9923  1f3f cd0000        	call	c_lgadd
9925                     ; 2133 	for(i=0;i<16;i++)
9927  1f42 0c05          	inc	(OFST-4,sp)
9930  1f44 7b05          	ld	a,(OFST-4,sp)
9931  1f46 a110          	cp	a,#16
9932  1f48 25db          	jrult	L3614
9933                     ; 2137 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9935  1f4a 96            	ldw	x,sp
9936  1f4b 1c0006        	addw	x,#OFST-3
9937  1f4e cd0000        	call	c_ltor
9939  1f51 a604          	ld	a,#4
9940  1f53 cd0000        	call	c_lrsh
9942  1f56 be02          	ldw	x,c_lreg+2
9943  1f58 b6c3          	ld	a,_adc_ch
9944  1f5a 905f          	clrw	y
9945  1f5c 9097          	ld	yl,a
9946  1f5e 9058          	sllw	y
9947  1f60 90df0009      	ldw	(_adc_buff_,y),x
9948  1f64               L1614:
9949                     ; 2148 adc_plazma_short++;
9951  1f64 bec0          	ldw	x,_adc_plazma_short
9952  1f66 1c0001        	addw	x,#1
9953  1f69 bfc0          	ldw	_adc_plazma_short,x
9954                     ; 2163 }
9957  1f6b 5b09          	addw	sp,#9
9958  1f6d 85            	popw	x
9959  1f6e bf00          	ldw	c_lreg,x
9960  1f70 85            	popw	x
9961  1f71 bf02          	ldw	c_lreg+2,x
9962  1f73 85            	popw	x
9963  1f74 bf00          	ldw	c_y,x
9964  1f76 85            	popw	x
9965  1f77 bf00          	ldw	c_x,x
9966  1f79 80            	iret
10030                     ; 2171 main()
10030                     ; 2172 {
10032                     	switch	.text
10033  1f7a               _main:
10037                     ; 2174 CLK->ECKR|=1;
10039  1f7a 721050c1      	bset	20673,#0
10041  1f7e               L3024:
10042                     ; 2175 while((CLK->ECKR & 2) == 0);
10044  1f7e c650c1        	ld	a,20673
10045  1f81 a502          	bcp	a,#2
10046  1f83 27f9          	jreq	L3024
10047                     ; 2176 CLK->SWCR|=2;
10049  1f85 721250c5      	bset	20677,#1
10050                     ; 2177 CLK->SWR=0xB4;
10052  1f89 35b450c4      	mov	20676,#180
10053                     ; 2179 delay_ms(200);
10055  1f8d ae00c8        	ldw	x,#200
10056  1f90 cd011d        	call	_delay_ms
10058                     ; 2180 FLASH_DUKR=0xae;
10060  1f93 35ae5064      	mov	_FLASH_DUKR,#174
10061                     ; 2181 FLASH_DUKR=0x56;
10063  1f97 35565064      	mov	_FLASH_DUKR,#86
10064                     ; 2182 enableInterrupts();
10067  1f9b 9a            rim
10069                     ; 2185 adr_drv_v3();
10072  1f9c cd1179        	call	_adr_drv_v3
10074                     ; 2189 t4_init();
10076  1f9f cd1d3c        	call	_t4_init
10078                     ; 2191 		GPIOG->DDR|=(1<<0);
10080  1fa2 72105020      	bset	20512,#0
10081                     ; 2192 		GPIOG->CR1|=(1<<0);
10083  1fa6 72105021      	bset	20513,#0
10084                     ; 2193 		GPIOG->CR2&=~(1<<0);	
10086  1faa 72115022      	bres	20514,#0
10087                     ; 2196 		GPIOG->DDR&=~(1<<1);
10089  1fae 72135020      	bres	20512,#1
10090                     ; 2197 		GPIOG->CR1|=(1<<1);
10092  1fb2 72125021      	bset	20513,#1
10093                     ; 2198 		GPIOG->CR2&=~(1<<1);
10095  1fb6 72135022      	bres	20514,#1
10096                     ; 2200 init_CAN();
10098  1fba cd14bc        	call	_init_CAN
10100                     ; 2205 GPIOC->DDR|=(1<<1);
10102  1fbd 7212500c      	bset	20492,#1
10103                     ; 2206 GPIOC->CR1|=(1<<1);
10105  1fc1 7212500d      	bset	20493,#1
10106                     ; 2207 GPIOC->CR2|=(1<<1);
10108  1fc5 7212500e      	bset	20494,#1
10109                     ; 2209 GPIOC->DDR|=(1<<2);
10111  1fc9 7214500c      	bset	20492,#2
10112                     ; 2210 GPIOC->CR1|=(1<<2);
10114  1fcd 7214500d      	bset	20493,#2
10115                     ; 2211 GPIOC->CR2|=(1<<2);
10117  1fd1 7214500e      	bset	20494,#2
10118                     ; 2218 t1_init();
10120  1fd5 cd1d4d        	call	_t1_init
10122                     ; 2220 GPIOA->DDR|=(1<<5);
10124  1fd8 721a5002      	bset	20482,#5
10125                     ; 2221 GPIOA->CR1|=(1<<5);
10127  1fdc 721a5003      	bset	20483,#5
10128                     ; 2222 GPIOA->CR2&=~(1<<5);
10130  1fe0 721b5004      	bres	20484,#5
10131                     ; 2228 GPIOB->DDR&=~(1<<3);
10133  1fe4 72175007      	bres	20487,#3
10134                     ; 2229 GPIOB->CR1&=~(1<<3);
10136  1fe8 72175008      	bres	20488,#3
10137                     ; 2230 GPIOB->CR2&=~(1<<3);
10139  1fec 72175009      	bres	20489,#3
10140                     ; 2232 GPIOC->DDR|=(1<<3);
10142  1ff0 7216500c      	bset	20492,#3
10143                     ; 2233 GPIOC->CR1|=(1<<3);
10145  1ff4 7216500d      	bset	20493,#3
10146                     ; 2234 GPIOC->CR2|=(1<<3);
10148  1ff8 7216500e      	bset	20494,#3
10149                     ; 2237 if(bps_class==bpsIPS) 
10151  1ffc b604          	ld	a,_bps_class
10152  1ffe a101          	cp	a,#1
10153  2000 260a          	jrne	L1124
10154                     ; 2239 	pwm_u=ee_U_AVT;
10156  2002 ce000c        	ldw	x,_ee_U_AVT
10157  2005 bf0e          	ldw	_pwm_u,x
10158                     ; 2240 	volum_u_main_=ee_U_AVT;
10160  2007 ce000c        	ldw	x,_ee_U_AVT
10161  200a bf1f          	ldw	_volum_u_main_,x
10162  200c               L1124:
10163                     ; 2247 	if(bCAN_RX)
10165  200c 3d0a          	tnz	_bCAN_RX
10166  200e 2705          	jreq	L5124
10167                     ; 2249 		bCAN_RX=0;
10169  2010 3f0a          	clr	_bCAN_RX
10170                     ; 2250 		can_in_an();	
10172  2012 cd16c7        	call	_can_in_an
10174  2015               L5124:
10175                     ; 2252 	if(b100Hz)
10177                     	btst	_b100Hz
10178  201a 240a          	jruge	L7124
10179                     ; 2254 		b100Hz=0;
10181  201c 72110008      	bres	_b100Hz
10182                     ; 2263 		adc2_init();
10184  2020 cd1d8a        	call	_adc2_init
10186                     ; 2264 		can_tx_hndl();
10188  2023 cd15af        	call	_can_tx_hndl
10190  2026               L7124:
10191                     ; 2267 	if(b10Hz)
10193                     	btst	_b10Hz
10194  202b 2419          	jruge	L1224
10195                     ; 2269 		b10Hz=0;
10197  202d 72110007      	bres	_b10Hz
10198                     ; 2271 		matemat();
10200  2031 cd0ce0        	call	_matemat
10202                     ; 2272 		led_drv(); 
10204  2034 cd07e2        	call	_led_drv
10206                     ; 2273 	  link_drv();
10208  2037 cd08d0        	call	_link_drv
10210                     ; 2274 	  pwr_hndl();		//���������� ����������� �� ����
10212  203a cd0bab        	call	_pwr_hndl
10214                     ; 2275 	  JP_drv();
10216  203d cd0845        	call	_JP_drv
10218                     ; 2276 	  flags_drv();
10220  2040 cd112e        	call	_flags_drv
10222                     ; 2277 		net_drv();
10224  2043 cd1619        	call	_net_drv
10226  2046               L1224:
10227                     ; 2280 	if(b5Hz)
10229                     	btst	_b5Hz
10230  204b 240d          	jruge	L3224
10231                     ; 2282 		b5Hz=0;
10233  204d 72110006      	bres	_b5Hz
10234                     ; 2284 		pwr_drv();		//����������� �� ����
10236  2051 cd0a8b        	call	_pwr_drv
10238                     ; 2285 		led_hndl();
10240  2054 cd015f        	call	_led_hndl
10242                     ; 2287 		vent_drv();
10244  2057 cd0928        	call	_vent_drv
10246  205a               L3224:
10247                     ; 2290 	if(b2Hz)
10249                     	btst	_b2Hz
10250  205f 2404          	jruge	L5224
10251                     ; 2292 		b2Hz=0;
10253  2061 72110005      	bres	_b2Hz
10254  2065               L5224:
10255                     ; 2301 	if(b1Hz)
10257                     	btst	_b1Hz
10258  206a 24a0          	jruge	L1124
10259                     ; 2303 		b1Hz=0;
10261  206c 72110004      	bres	_b1Hz
10262                     ; 2305 		temper_drv();			//���������� ������ �����������
10264  2070 cd0e5e        	call	_temper_drv
10266                     ; 2306 		u_drv();
10268  2073 cd0f35        	call	_u_drv
10270                     ; 2307           x_drv();
10272  2076 cd1015        	call	_x_drv
10274                     ; 2308           if(main_cnt<1000)main_cnt++;
10276  2079 9c            	rvf
10277  207a be51          	ldw	x,_main_cnt
10278  207c a303e8        	cpw	x,#1000
10279  207f 2e07          	jrsge	L1324
10282  2081 be51          	ldw	x,_main_cnt
10283  2083 1c0001        	addw	x,#1
10284  2086 bf51          	ldw	_main_cnt,x
10285  2088               L1324:
10286                     ; 2309   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10288  2088 b663          	ld	a,_link
10289  208a a1aa          	cp	a,#170
10290  208c 2706          	jreq	L5324
10292  208e b64a          	ld	a,_jp_mode
10293  2090 a103          	cp	a,#3
10294  2092 2603          	jrne	L3324
10295  2094               L5324:
10298  2094 cd108f        	call	_apv_hndl
10300  2097               L3324:
10301                     ; 2312   		can_error_cnt++;
10303  2097 3c71          	inc	_can_error_cnt
10304                     ; 2313   		if(can_error_cnt>=10)
10306  2099 b671          	ld	a,_can_error_cnt
10307  209b a10a          	cp	a,#10
10308  209d 2505          	jrult	L7324
10309                     ; 2315   			can_error_cnt=0;
10311  209f 3f71          	clr	_can_error_cnt
10312                     ; 2316 			init_CAN();
10314  20a1 cd14bc        	call	_init_CAN
10316  20a4               L7324:
10317                     ; 2320 		volum_u_main_drv();
10319  20a4 cd1369        	call	_volum_u_main_drv
10321                     ; 2322 		pwm_stat++;
10323  20a7 3c07          	inc	_pwm_stat
10324                     ; 2323 		if(pwm_stat>=10)pwm_stat=0;
10326  20a9 b607          	ld	a,_pwm_stat
10327  20ab a10a          	cp	a,#10
10328  20ad 2502          	jrult	L1424
10331  20af 3f07          	clr	_pwm_stat
10332  20b1               L1424:
10333                     ; 2324 adc_plazma_short++;
10335  20b1 bec0          	ldw	x,_adc_plazma_short
10336  20b3 1c0001        	addw	x,#1
10337  20b6 bfc0          	ldw	_adc_plazma_short,x
10338                     ; 2326 		vent_resurs_hndl();
10340  20b8 cd0000        	call	_vent_resurs_hndl
10342  20bb ac0c200c      	jpf	L1124
11412                     	xdef	_main
11413                     	xdef	f_ADC2_EOC_Interrupt
11414                     	xdef	f_CAN_TX_Interrupt
11415                     	xdef	f_CAN_RX_Interrupt
11416                     	xdef	f_TIM4_UPD_Interrupt
11417                     	xdef	_adc2_init
11418                     	xdef	_t1_init
11419                     	xdef	_t4_init
11420                     	xdef	_can_in_an
11421                     	xdef	_net_drv
11422                     	xdef	_can_tx_hndl
11423                     	xdef	_can_transmit
11424                     	xdef	_init_CAN
11425                     	xdef	_volum_u_main_drv
11426                     	xdef	_adr_drv_v3
11427                     	xdef	_adr_drv_v4
11428                     	xdef	_flags_drv
11429                     	xdef	_apv_hndl
11430                     	xdef	_apv_stop
11431                     	xdef	_apv_start
11432                     	xdef	_x_drv
11433                     	xdef	_u_drv
11434                     	xdef	_temper_drv
11435                     	xdef	_matemat
11436                     	xdef	_pwr_hndl
11437                     	xdef	_pwr_drv
11438                     	xdef	_vent_drv
11439                     	xdef	_link_drv
11440                     	xdef	_JP_drv
11441                     	xdef	_led_drv
11442                     	xdef	_led_hndl
11443                     	xdef	_delay_ms
11444                     	xdef	_granee
11445                     	xdef	_gran
11446                     	xdef	_vent_resurs_hndl
11447                     	switch	.ubsct
11448  0001               _vent_resurs_tx_cnt:
11449  0001 00            	ds.b	1
11450                     	xdef	_vent_resurs_tx_cnt
11451                     	switch	.bss
11452  0000               _vent_resurs_buff:
11453  0000 00000000      	ds.b	4
11454                     	xdef	_vent_resurs_buff
11455                     	switch	.ubsct
11456  0002               _vent_resurs_sec_cnt:
11457  0002 0000          	ds.b	2
11458                     	xdef	_vent_resurs_sec_cnt
11459                     .eeprom:	section	.data
11460  0000               _vent_resurs:
11461  0000 0000          	ds.b	2
11462                     	xdef	_vent_resurs
11463  0002               _ee_IMAXVENT:
11464  0002 0000          	ds.b	2
11465                     	xdef	_ee_IMAXVENT
11466                     	switch	.ubsct
11467  0004               _bps_class:
11468  0004 00            	ds.b	1
11469                     	xdef	_bps_class
11470  0005               _vent_pwm:
11471  0005 0000          	ds.b	2
11472                     	xdef	_vent_pwm
11473  0007               _pwm_stat:
11474  0007 00            	ds.b	1
11475                     	xdef	_pwm_stat
11476  0008               _pwm_vent_cnt:
11477  0008 00            	ds.b	1
11478                     	xdef	_pwm_vent_cnt
11479                     	switch	.eeprom
11480  0004               _ee_DEVICE:
11481  0004 0000          	ds.b	2
11482                     	xdef	_ee_DEVICE
11483  0006               _ee_AVT_MODE:
11484  0006 0000          	ds.b	2
11485                     	xdef	_ee_AVT_MODE
11486                     	switch	.ubsct
11487  0009               _i_main_bps_cnt:
11488  0009 000000000000  	ds.b	6
11489                     	xdef	_i_main_bps_cnt
11490  000f               _i_main_sigma:
11491  000f 0000          	ds.b	2
11492                     	xdef	_i_main_sigma
11493  0011               _i_main_num_of_bps:
11494  0011 00            	ds.b	1
11495                     	xdef	_i_main_num_of_bps
11496  0012               _i_main_avg:
11497  0012 0000          	ds.b	2
11498                     	xdef	_i_main_avg
11499  0014               _i_main_flag:
11500  0014 000000000000  	ds.b	6
11501                     	xdef	_i_main_flag
11502  001a               _i_main:
11503  001a 000000000000  	ds.b	12
11504                     	xdef	_i_main
11505  0026               _x:
11506  0026 000000000000  	ds.b	12
11507                     	xdef	_x
11508                     	xdef	_volum_u_main_
11509                     	switch	.eeprom
11510  0008               _UU_AVT:
11511  0008 0000          	ds.b	2
11512                     	xdef	_UU_AVT
11513                     	switch	.ubsct
11514  0032               _cnt_net_drv:
11515  0032 00            	ds.b	1
11516                     	xdef	_cnt_net_drv
11517                     	switch	.bit
11518  0001               _bMAIN:
11519  0001 00            	ds.b	1
11520                     	xdef	_bMAIN
11521                     	switch	.ubsct
11522  0033               _plazma_int:
11523  0033 000000000000  	ds.b	6
11524                     	xdef	_plazma_int
11525                     	xdef	_rotor_int
11526  0039               _led_green_buff:
11527  0039 00000000      	ds.b	4
11528                     	xdef	_led_green_buff
11529  003d               _led_red_buff:
11530  003d 00000000      	ds.b	4
11531                     	xdef	_led_red_buff
11532                     	xdef	_led_drv_cnt
11533                     	xdef	_led_green
11534                     	xdef	_led_red
11535  0041               _res_fl_cnt:
11536  0041 00            	ds.b	1
11537                     	xdef	_res_fl_cnt
11538                     	xdef	_bRES_
11539                     	xdef	_bRES
11540                     	switch	.eeprom
11541  000a               _res_fl_:
11542  000a 00            	ds.b	1
11543                     	xdef	_res_fl_
11544  000b               _res_fl:
11545  000b 00            	ds.b	1
11546                     	xdef	_res_fl
11547                     	switch	.ubsct
11548  0042               _cnt_apv_off:
11549  0042 00            	ds.b	1
11550                     	xdef	_cnt_apv_off
11551                     	switch	.bit
11552  0002               _bAPV:
11553  0002 00            	ds.b	1
11554                     	xdef	_bAPV
11555                     	switch	.ubsct
11556  0043               _apv_cnt_:
11557  0043 0000          	ds.b	2
11558                     	xdef	_apv_cnt_
11559  0045               _apv_cnt:
11560  0045 000000        	ds.b	3
11561                     	xdef	_apv_cnt
11562                     	xdef	_bBL_IPS
11563                     	switch	.bit
11564  0003               _bBL:
11565  0003 00            	ds.b	1
11566                     	xdef	_bBL
11567                     	switch	.ubsct
11568  0048               _cnt_JP1:
11569  0048 00            	ds.b	1
11570                     	xdef	_cnt_JP1
11571  0049               _cnt_JP0:
11572  0049 00            	ds.b	1
11573                     	xdef	_cnt_JP0
11574  004a               _jp_mode:
11575  004a 00            	ds.b	1
11576                     	xdef	_jp_mode
11577                     	xdef	_pwm_i
11578                     	xdef	_pwm_u
11579  004b               _tmax_cnt:
11580  004b 0000          	ds.b	2
11581                     	xdef	_tmax_cnt
11582  004d               _tsign_cnt:
11583  004d 0000          	ds.b	2
11584                     	xdef	_tsign_cnt
11585                     	switch	.eeprom
11586  000c               _ee_U_AVT:
11587  000c 0000          	ds.b	2
11588                     	xdef	_ee_U_AVT
11589  000e               _ee_tsign:
11590  000e 0000          	ds.b	2
11591                     	xdef	_ee_tsign
11592  0010               _ee_tmax:
11593  0010 0000          	ds.b	2
11594                     	xdef	_ee_tmax
11595  0012               _ee_dU:
11596  0012 0000          	ds.b	2
11597                     	xdef	_ee_dU
11598  0014               _ee_Umax:
11599  0014 0000          	ds.b	2
11600                     	xdef	_ee_Umax
11601  0016               _ee_TZAS:
11602  0016 0000          	ds.b	2
11603                     	xdef	_ee_TZAS
11604                     	switch	.ubsct
11605  004f               _main_cnt1:
11606  004f 0000          	ds.b	2
11607                     	xdef	_main_cnt1
11608  0051               _main_cnt:
11609  0051 0000          	ds.b	2
11610                     	xdef	_main_cnt
11611  0053               _off_bp_cnt:
11612  0053 00            	ds.b	1
11613                     	xdef	_off_bp_cnt
11614                     	xdef	_vol_i_temp_avar
11615  0054               _flags_tu_cnt_off:
11616  0054 00            	ds.b	1
11617                     	xdef	_flags_tu_cnt_off
11618  0055               _flags_tu_cnt_on:
11619  0055 00            	ds.b	1
11620                     	xdef	_flags_tu_cnt_on
11621  0056               _vol_i_temp:
11622  0056 0000          	ds.b	2
11623                     	xdef	_vol_i_temp
11624  0058               _vol_u_temp:
11625  0058 0000          	ds.b	2
11626                     	xdef	_vol_u_temp
11627                     	switch	.eeprom
11628  0018               __x_ee_:
11629  0018 0000          	ds.b	2
11630                     	xdef	__x_ee_
11631                     	switch	.ubsct
11632  005a               __x_cnt:
11633  005a 0000          	ds.b	2
11634                     	xdef	__x_cnt
11635  005c               __x__:
11636  005c 0000          	ds.b	2
11637                     	xdef	__x__
11638  005e               __x_:
11639  005e 0000          	ds.b	2
11640                     	xdef	__x_
11641  0060               _flags_tu:
11642  0060 00            	ds.b	1
11643                     	xdef	_flags_tu
11644                     	xdef	_flags
11645  0061               _link_cnt:
11646  0061 0000          	ds.b	2
11647                     	xdef	_link_cnt
11648  0063               _link:
11649  0063 00            	ds.b	1
11650                     	xdef	_link
11651  0064               _umin_cnt:
11652  0064 0000          	ds.b	2
11653                     	xdef	_umin_cnt
11654  0066               _umax_cnt:
11655  0066 0000          	ds.b	2
11656                     	xdef	_umax_cnt
11657                     	switch	.eeprom
11658  001a               _ee_K:
11659  001a 000000000000  	ds.b	16
11660                     	xdef	_ee_K
11661                     	switch	.ubsct
11662  0068               _T:
11663  0068 00            	ds.b	1
11664                     	xdef	_T
11665  0069               _Udb:
11666  0069 0000          	ds.b	2
11667                     	xdef	_Udb
11668  006b               _Ui:
11669  006b 0000          	ds.b	2
11670                     	xdef	_Ui
11671  006d               _Un:
11672  006d 0000          	ds.b	2
11673                     	xdef	_Un
11674  006f               _I:
11675  006f 0000          	ds.b	2
11676                     	xdef	_I
11677  0071               _can_error_cnt:
11678  0071 00            	ds.b	1
11679                     	xdef	_can_error_cnt
11680                     	xdef	_bCAN_RX
11681  0072               _tx_busy_cnt:
11682  0072 00            	ds.b	1
11683                     	xdef	_tx_busy_cnt
11684                     	xdef	_bTX_FREE
11685  0073               _can_buff_rd_ptr:
11686  0073 00            	ds.b	1
11687                     	xdef	_can_buff_rd_ptr
11688  0074               _can_buff_wr_ptr:
11689  0074 00            	ds.b	1
11690                     	xdef	_can_buff_wr_ptr
11691  0075               _can_out_buff:
11692  0075 000000000000  	ds.b	64
11693                     	xdef	_can_out_buff
11694                     	switch	.bss
11695  0004               _adress_error:
11696  0004 00            	ds.b	1
11697                     	xdef	_adress_error
11698  0005               _adress:
11699  0005 00            	ds.b	1
11700                     	xdef	_adress
11701  0006               _adr:
11702  0006 000000        	ds.b	3
11703                     	xdef	_adr
11704                     	xdef	_adr_drv_stat
11705                     	xdef	_led_ind
11706                     	switch	.ubsct
11707  00b5               _led_ind_cnt:
11708  00b5 00            	ds.b	1
11709                     	xdef	_led_ind_cnt
11710  00b6               _adc_plazma:
11711  00b6 000000000000  	ds.b	10
11712                     	xdef	_adc_plazma
11713  00c0               _adc_plazma_short:
11714  00c0 0000          	ds.b	2
11715                     	xdef	_adc_plazma_short
11716  00c2               _adc_cnt:
11717  00c2 00            	ds.b	1
11718                     	xdef	_adc_cnt
11719  00c3               _adc_ch:
11720  00c3 00            	ds.b	1
11721                     	xdef	_adc_ch
11722                     	switch	.bss
11723  0009               _adc_buff_:
11724  0009 000000000000  	ds.b	20
11725                     	xdef	_adc_buff_
11726  001d               _adc_buff:
11727  001d 000000000000  	ds.b	320
11728                     	xdef	_adc_buff
11729                     	switch	.ubsct
11730  00c4               _mess:
11731  00c4 000000000000  	ds.b	14
11732                     	xdef	_mess
11733                     	switch	.bit
11734  0004               _b1Hz:
11735  0004 00            	ds.b	1
11736                     	xdef	_b1Hz
11737  0005               _b2Hz:
11738  0005 00            	ds.b	1
11739                     	xdef	_b2Hz
11740  0006               _b5Hz:
11741  0006 00            	ds.b	1
11742                     	xdef	_b5Hz
11743  0007               _b10Hz:
11744  0007 00            	ds.b	1
11745                     	xdef	_b10Hz
11746  0008               _b100Hz:
11747  0008 00            	ds.b	1
11748                     	xdef	_b100Hz
11749                     	xdef	_t0_cnt4
11750                     	xdef	_t0_cnt3
11751                     	xdef	_t0_cnt2
11752                     	xdef	_t0_cnt1
11753                     	xdef	_t0_cnt0
11754                     	xdef	_bVENT_BLOCK
11755                     	xref.b	c_lreg
11756                     	xref.b	c_x
11757                     	xref.b	c_y
11777                     	xref	c_lrsh
11778                     	xref	c_lgadd
11779                     	xref	c_ladd
11780                     	xref	c_umul
11781                     	xref	c_lgmul
11782                     	xref	c_lgsub
11783                     	xref	c_lsbc
11784                     	xref	c_idiv
11785                     	xref	c_ldiv
11786                     	xref	c_itolx
11787                     	xref	c_eewrc
11788                     	xref	c_imul
11789                     	xref	c_ltor
11790                     	xref	c_lgadc
11791                     	xref	c_rtol
11792                     	xref	c_vmul
11793                     	xref	c_eewrw
11794                     	xref	c_lcmp
11795                     	xref	c_uitolx
11796                     	end
