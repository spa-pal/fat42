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
2314                     ; 188 vent_resurs=12543;
2316  002e ae30ff        	ldw	x,#12543
2317  0031 89            	pushw	x
2318  0032 ae0000        	ldw	x,#_vent_resurs
2319  0035 cd0000        	call	c_eewrw
2321  0038 85            	popw	x
2322                     ; 190 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2324  0039 350f0000      	mov	_vent_resurs_buff,#15
2325                     ; 191 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2327  003d 354f0001      	mov	_vent_resurs_buff+1,#79
2328                     ; 192 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2330  0041 35800002      	mov	_vent_resurs_buff+2,#128
2331                     ; 193 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2333  0045 35c30003      	mov	_vent_resurs_buff+3,#195
2334                     ; 195 temp=vent_resurs_buff[0]&0x0f;
2336  0049 a60f          	ld	a,#15
2337  004b 6b01          	ld	(OFST+0,sp),a
2338                     ; 196 temp^=vent_resurs_buff[1]&0x0f;
2340  004d 7b01          	ld	a,(OFST+0,sp)
2341  004f a80f          	xor	a,	#15
2342  0051 6b01          	ld	(OFST+0,sp),a
2343                     ; 197 temp^=vent_resurs_buff[2]&0x0f;
2345                     ; 198 temp^=vent_resurs_buff[3]&0x0f;
2347  0053 7b01          	ld	a,(OFST+0,sp)
2348  0055 a803          	xor	a,	#3
2349  0057 6b01          	ld	(OFST+0,sp),a
2350                     ; 200 vent_resurs_buff[0]|=(temp&0x03)<<4;
2352  0059 c60000        	ld	a,_vent_resurs_buff
2353  005c aa30          	or	a,#48
2354  005e c70000        	ld	_vent_resurs_buff,a
2355                     ; 201 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2357                     ; 202 vent_resurs_buff[2]|=(temp&0x30);
2359                     ; 203 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2361                     ; 206 vent_resurs_tx_cnt++;
2363  0061 3c01          	inc	_vent_resurs_tx_cnt
2364                     ; 207 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2366  0063 b601          	ld	a,_vent_resurs_tx_cnt
2367  0065 a104          	cp	a,#4
2368  0067 2502          	jrult	L5541
2371  0069 3f01          	clr	_vent_resurs_tx_cnt
2372  006b               L5541:
2373                     ; 210 }
2376  006b 84            	pop	a
2377  006c 81            	ret
2430                     ; 213 void gran(signed short *adr, signed short min, signed short max)
2430                     ; 214 {
2431                     	switch	.text
2432  006d               _gran:
2434  006d 89            	pushw	x
2435       00000000      OFST:	set	0
2438                     ; 215 if (*adr<min) *adr=min;
2440  006e 9c            	rvf
2441  006f 9093          	ldw	y,x
2442  0071 51            	exgw	x,y
2443  0072 fe            	ldw	x,(x)
2444  0073 1305          	cpw	x,(OFST+5,sp)
2445  0075 51            	exgw	x,y
2446  0076 2e03          	jrsge	L5051
2449  0078 1605          	ldw	y,(OFST+5,sp)
2450  007a ff            	ldw	(x),y
2451  007b               L5051:
2452                     ; 216 if (*adr>max) *adr=max; 
2454  007b 9c            	rvf
2455  007c 1e01          	ldw	x,(OFST+1,sp)
2456  007e 9093          	ldw	y,x
2457  0080 51            	exgw	x,y
2458  0081 fe            	ldw	x,(x)
2459  0082 1307          	cpw	x,(OFST+7,sp)
2460  0084 51            	exgw	x,y
2461  0085 2d05          	jrsle	L7051
2464  0087 1e01          	ldw	x,(OFST+1,sp)
2465  0089 1607          	ldw	y,(OFST+7,sp)
2466  008b ff            	ldw	(x),y
2467  008c               L7051:
2468                     ; 217 } 
2471  008c 85            	popw	x
2472  008d 81            	ret
2525                     ; 220 void granee(@eeprom signed short *adr, signed short min, signed short max)
2525                     ; 221 {
2526                     	switch	.text
2527  008e               _granee:
2529  008e 89            	pushw	x
2530       00000000      OFST:	set	0
2533                     ; 222 if (*adr<min) *adr=min;
2535  008f 9c            	rvf
2536  0090 9093          	ldw	y,x
2537  0092 51            	exgw	x,y
2538  0093 fe            	ldw	x,(x)
2539  0094 1305          	cpw	x,(OFST+5,sp)
2540  0096 51            	exgw	x,y
2541  0097 2e09          	jrsge	L7351
2544  0099 1e05          	ldw	x,(OFST+5,sp)
2545  009b 89            	pushw	x
2546  009c 1e03          	ldw	x,(OFST+3,sp)
2547  009e cd0000        	call	c_eewrw
2549  00a1 85            	popw	x
2550  00a2               L7351:
2551                     ; 223 if (*adr>max) *adr=max; 
2553  00a2 9c            	rvf
2554  00a3 1e01          	ldw	x,(OFST+1,sp)
2555  00a5 9093          	ldw	y,x
2556  00a7 51            	exgw	x,y
2557  00a8 fe            	ldw	x,(x)
2558  00a9 1307          	cpw	x,(OFST+7,sp)
2559  00ab 51            	exgw	x,y
2560  00ac 2d09          	jrsle	L1451
2563  00ae 1e07          	ldw	x,(OFST+7,sp)
2564  00b0 89            	pushw	x
2565  00b1 1e03          	ldw	x,(OFST+3,sp)
2566  00b3 cd0000        	call	c_eewrw
2568  00b6 85            	popw	x
2569  00b7               L1451:
2570                     ; 224 }
2573  00b7 85            	popw	x
2574  00b8 81            	ret
2635                     ; 227 long delay_ms(short in)
2635                     ; 228 {
2636                     	switch	.text
2637  00b9               _delay_ms:
2639  00b9 520c          	subw	sp,#12
2640       0000000c      OFST:	set	12
2643                     ; 231 i=((long)in)*100UL;
2645  00bb 90ae0064      	ldw	y,#100
2646  00bf cd0000        	call	c_vmul
2648  00c2 96            	ldw	x,sp
2649  00c3 1c0005        	addw	x,#OFST-7
2650  00c6 cd0000        	call	c_rtol
2652                     ; 233 for(ii=0;ii<i;ii++)
2654  00c9 ae0000        	ldw	x,#0
2655  00cc 1f0b          	ldw	(OFST-1,sp),x
2656  00ce ae0000        	ldw	x,#0
2657  00d1 1f09          	ldw	(OFST-3,sp),x
2659  00d3 2012          	jra	L1061
2660  00d5               L5751:
2661                     ; 235 		iii++;
2663  00d5 96            	ldw	x,sp
2664  00d6 1c0001        	addw	x,#OFST-11
2665  00d9 a601          	ld	a,#1
2666  00db cd0000        	call	c_lgadc
2668                     ; 233 for(ii=0;ii<i;ii++)
2670  00de 96            	ldw	x,sp
2671  00df 1c0009        	addw	x,#OFST-3
2672  00e2 a601          	ld	a,#1
2673  00e4 cd0000        	call	c_lgadc
2675  00e7               L1061:
2678  00e7 9c            	rvf
2679  00e8 96            	ldw	x,sp
2680  00e9 1c0009        	addw	x,#OFST-3
2681  00ec cd0000        	call	c_ltor
2683  00ef 96            	ldw	x,sp
2684  00f0 1c0005        	addw	x,#OFST-7
2685  00f3 cd0000        	call	c_lcmp
2687  00f6 2fdd          	jrslt	L5751
2688                     ; 238 }
2691  00f8 5b0c          	addw	sp,#12
2692  00fa 81            	ret
2728                     ; 241 void led_hndl(void)
2728                     ; 242 {
2729                     	switch	.text
2730  00fb               _led_hndl:
2734                     ; 243 if(adress_error)
2736  00fb 725d0004      	tnz	_adress_error
2737  00ff 2718          	jreq	L5161
2738                     ; 245 	led_red=0x55555555L;
2740  0101 ae5555        	ldw	x,#21845
2741  0104 bf16          	ldw	_led_red+2,x
2742  0106 ae5555        	ldw	x,#21845
2743  0109 bf14          	ldw	_led_red,x
2744                     ; 246 	led_green=0x55555555L;
2746  010b ae5555        	ldw	x,#21845
2747  010e bf1a          	ldw	_led_green+2,x
2748  0110 ae5555        	ldw	x,#21845
2749  0113 bf18          	ldw	_led_green,x
2751  0115 ac7d077d      	jpf	L7161
2752  0119               L5161:
2753                     ; 262 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2755  0119 3d04          	tnz	_bps_class
2756  011b 2703          	jreq	L02
2757  011d cc03d0        	jp	L1261
2758  0120               L02:
2759                     ; 264 	if(jp_mode!=jp3)
2761  0120 b64a          	ld	a,_jp_mode
2762  0122 a103          	cp	a,#3
2763  0124 2603          	jrne	L22
2764  0126 cc02cc        	jp	L3261
2765  0129               L22:
2766                     ; 266 		if(main_cnt1<(5*ee_TZAS))
2768  0129 9c            	rvf
2769  012a ce0016        	ldw	x,_ee_TZAS
2770  012d 90ae0005      	ldw	y,#5
2771  0131 cd0000        	call	c_imul
2773  0134 b34f          	cpw	x,_main_cnt1
2774  0136 2d18          	jrsle	L5261
2775                     ; 268 			led_red=0x00000000L;
2777  0138 ae0000        	ldw	x,#0
2778  013b bf16          	ldw	_led_red+2,x
2779  013d ae0000        	ldw	x,#0
2780  0140 bf14          	ldw	_led_red,x
2781                     ; 269 			led_green=0x03030303L;
2783  0142 ae0303        	ldw	x,#771
2784  0145 bf1a          	ldw	_led_green+2,x
2785  0147 ae0303        	ldw	x,#771
2786  014a bf18          	ldw	_led_green,x
2788  014c ac8d028d      	jpf	L7261
2789  0150               L5261:
2790                     ; 272 		else if((link==ON)&&(flags_tu&0b10000000))
2792  0150 b663          	ld	a,_link
2793  0152 a155          	cp	a,#85
2794  0154 261e          	jrne	L1361
2796  0156 b660          	ld	a,_flags_tu
2797  0158 a580          	bcp	a,#128
2798  015a 2718          	jreq	L1361
2799                     ; 274 			led_red=0x00055555L;
2801  015c ae5555        	ldw	x,#21845
2802  015f bf16          	ldw	_led_red+2,x
2803  0161 ae0005        	ldw	x,#5
2804  0164 bf14          	ldw	_led_red,x
2805                     ; 275 			led_green=0xffffffffL;
2807  0166 aeffff        	ldw	x,#65535
2808  0169 bf1a          	ldw	_led_green+2,x
2809  016b aeffff        	ldw	x,#-1
2810  016e bf18          	ldw	_led_green,x
2812  0170 ac8d028d      	jpf	L7261
2813  0174               L1361:
2814                     ; 278 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2816  0174 9c            	rvf
2817  0175 ce0016        	ldw	x,_ee_TZAS
2818  0178 90ae0005      	ldw	y,#5
2819  017c cd0000        	call	c_imul
2821  017f b34f          	cpw	x,_main_cnt1
2822  0181 2e37          	jrsge	L5361
2824  0183 9c            	rvf
2825  0184 ce0016        	ldw	x,_ee_TZAS
2826  0187 90ae0005      	ldw	y,#5
2827  018b cd0000        	call	c_imul
2829  018e 1c0064        	addw	x,#100
2830  0191 b34f          	cpw	x,_main_cnt1
2831  0193 2d25          	jrsle	L5361
2833  0195 ce0006        	ldw	x,_ee_AVT_MODE
2834  0198 a30055        	cpw	x,#85
2835  019b 271d          	jreq	L5361
2837  019d ce0004        	ldw	x,_ee_DEVICE
2838  01a0 2618          	jrne	L5361
2839                     ; 280 			led_red=0x00000000L;
2841  01a2 ae0000        	ldw	x,#0
2842  01a5 bf16          	ldw	_led_red+2,x
2843  01a7 ae0000        	ldw	x,#0
2844  01aa bf14          	ldw	_led_red,x
2845                     ; 281 			led_green=0xffffffffL;	
2847  01ac aeffff        	ldw	x,#65535
2848  01af bf1a          	ldw	_led_green+2,x
2849  01b1 aeffff        	ldw	x,#-1
2850  01b4 bf18          	ldw	_led_green,x
2852  01b6 ac8d028d      	jpf	L7261
2853  01ba               L5361:
2854                     ; 284 		else  if(link==OFF)
2856  01ba b663          	ld	a,_link
2857  01bc a1aa          	cp	a,#170
2858  01be 2618          	jrne	L1461
2859                     ; 286 			led_red=0x55555555L;
2861  01c0 ae5555        	ldw	x,#21845
2862  01c3 bf16          	ldw	_led_red+2,x
2863  01c5 ae5555        	ldw	x,#21845
2864  01c8 bf14          	ldw	_led_red,x
2865                     ; 287 			led_green=0xffffffffL;
2867  01ca aeffff        	ldw	x,#65535
2868  01cd bf1a          	ldw	_led_green+2,x
2869  01cf aeffff        	ldw	x,#-1
2870  01d2 bf18          	ldw	_led_green,x
2872  01d4 ac8d028d      	jpf	L7261
2873  01d8               L1461:
2874                     ; 290 		else if((link==ON)&&((flags&0b00111110)==0))
2876  01d8 b663          	ld	a,_link
2877  01da a155          	cp	a,#85
2878  01dc 261d          	jrne	L5461
2880  01de b60b          	ld	a,_flags
2881  01e0 a53e          	bcp	a,#62
2882  01e2 2617          	jrne	L5461
2883                     ; 292 			led_red=0x00000000L;
2885  01e4 ae0000        	ldw	x,#0
2886  01e7 bf16          	ldw	_led_red+2,x
2887  01e9 ae0000        	ldw	x,#0
2888  01ec bf14          	ldw	_led_red,x
2889                     ; 293 			led_green=0xffffffffL;
2891  01ee aeffff        	ldw	x,#65535
2892  01f1 bf1a          	ldw	_led_green+2,x
2893  01f3 aeffff        	ldw	x,#-1
2894  01f6 bf18          	ldw	_led_green,x
2896  01f8 cc028d        	jra	L7261
2897  01fb               L5461:
2898                     ; 296 		else if((flags&0b00111110)==0b00000100)
2900  01fb b60b          	ld	a,_flags
2901  01fd a43e          	and	a,#62
2902  01ff a104          	cp	a,#4
2903  0201 2616          	jrne	L1561
2904                     ; 298 			led_red=0x00010001L;
2906  0203 ae0001        	ldw	x,#1
2907  0206 bf16          	ldw	_led_red+2,x
2908  0208 ae0001        	ldw	x,#1
2909  020b bf14          	ldw	_led_red,x
2910                     ; 299 			led_green=0xffffffffL;	
2912  020d aeffff        	ldw	x,#65535
2913  0210 bf1a          	ldw	_led_green+2,x
2914  0212 aeffff        	ldw	x,#-1
2915  0215 bf18          	ldw	_led_green,x
2917  0217 2074          	jra	L7261
2918  0219               L1561:
2919                     ; 301 		else if(flags&0b00000010)
2921  0219 b60b          	ld	a,_flags
2922  021b a502          	bcp	a,#2
2923  021d 2716          	jreq	L5561
2924                     ; 303 			led_red=0x00010001L;
2926  021f ae0001        	ldw	x,#1
2927  0222 bf16          	ldw	_led_red+2,x
2928  0224 ae0001        	ldw	x,#1
2929  0227 bf14          	ldw	_led_red,x
2930                     ; 304 			led_green=0x00000000L;	
2932  0229 ae0000        	ldw	x,#0
2933  022c bf1a          	ldw	_led_green+2,x
2934  022e ae0000        	ldw	x,#0
2935  0231 bf18          	ldw	_led_green,x
2937  0233 2058          	jra	L7261
2938  0235               L5561:
2939                     ; 306 		else if(flags&0b00001000)
2941  0235 b60b          	ld	a,_flags
2942  0237 a508          	bcp	a,#8
2943  0239 2716          	jreq	L1661
2944                     ; 308 			led_red=0x00090009L;
2946  023b ae0009        	ldw	x,#9
2947  023e bf16          	ldw	_led_red+2,x
2948  0240 ae0009        	ldw	x,#9
2949  0243 bf14          	ldw	_led_red,x
2950                     ; 309 			led_green=0x00000000L;	
2952  0245 ae0000        	ldw	x,#0
2953  0248 bf1a          	ldw	_led_green+2,x
2954  024a ae0000        	ldw	x,#0
2955  024d bf18          	ldw	_led_green,x
2957  024f 203c          	jra	L7261
2958  0251               L1661:
2959                     ; 311 		else if(flags&0b00010000)
2961  0251 b60b          	ld	a,_flags
2962  0253 a510          	bcp	a,#16
2963  0255 2716          	jreq	L5661
2964                     ; 313 			led_red=0x00490049L;
2966  0257 ae0049        	ldw	x,#73
2967  025a bf16          	ldw	_led_red+2,x
2968  025c ae0049        	ldw	x,#73
2969  025f bf14          	ldw	_led_red,x
2970                     ; 314 			led_green=0x00000000L;	
2972  0261 ae0000        	ldw	x,#0
2973  0264 bf1a          	ldw	_led_green+2,x
2974  0266 ae0000        	ldw	x,#0
2975  0269 bf18          	ldw	_led_green,x
2977  026b 2020          	jra	L7261
2978  026d               L5661:
2979                     ; 317 		else if((link==ON)&&(flags&0b00100000))
2981  026d b663          	ld	a,_link
2982  026f a155          	cp	a,#85
2983  0271 261a          	jrne	L7261
2985  0273 b60b          	ld	a,_flags
2986  0275 a520          	bcp	a,#32
2987  0277 2714          	jreq	L7261
2988                     ; 319 			led_red=0x00000000L;
2990  0279 ae0000        	ldw	x,#0
2991  027c bf16          	ldw	_led_red+2,x
2992  027e ae0000        	ldw	x,#0
2993  0281 bf14          	ldw	_led_red,x
2994                     ; 320 			led_green=0x00030003L;
2996  0283 ae0003        	ldw	x,#3
2997  0286 bf1a          	ldw	_led_green+2,x
2998  0288 ae0003        	ldw	x,#3
2999  028b bf18          	ldw	_led_green,x
3000  028d               L7261:
3001                     ; 323 		if((jp_mode==jp1))
3003  028d b64a          	ld	a,_jp_mode
3004  028f a101          	cp	a,#1
3005  0291 2618          	jrne	L3761
3006                     ; 325 			led_red=0x00000000L;
3008  0293 ae0000        	ldw	x,#0
3009  0296 bf16          	ldw	_led_red+2,x
3010  0298 ae0000        	ldw	x,#0
3011  029b bf14          	ldw	_led_red,x
3012                     ; 326 			led_green=0x33333333L;
3014  029d ae3333        	ldw	x,#13107
3015  02a0 bf1a          	ldw	_led_green+2,x
3016  02a2 ae3333        	ldw	x,#13107
3017  02a5 bf18          	ldw	_led_green,x
3019  02a7 ac7d077d      	jpf	L7161
3020  02ab               L3761:
3021                     ; 328 		else if((jp_mode==jp2))
3023  02ab b64a          	ld	a,_jp_mode
3024  02ad a102          	cp	a,#2
3025  02af 2703          	jreq	L42
3026  02b1 cc077d        	jp	L7161
3027  02b4               L42:
3028                     ; 330 			led_red=0xccccccccL;
3030  02b4 aecccc        	ldw	x,#52428
3031  02b7 bf16          	ldw	_led_red+2,x
3032  02b9 aecccc        	ldw	x,#-13108
3033  02bc bf14          	ldw	_led_red,x
3034                     ; 331 			led_green=0x00000000L;
3036  02be ae0000        	ldw	x,#0
3037  02c1 bf1a          	ldw	_led_green+2,x
3038  02c3 ae0000        	ldw	x,#0
3039  02c6 bf18          	ldw	_led_green,x
3040  02c8 ac7d077d      	jpf	L7161
3041  02cc               L3261:
3042                     ; 334 	else if(jp_mode==jp3)
3044  02cc b64a          	ld	a,_jp_mode
3045  02ce a103          	cp	a,#3
3046  02d0 2703          	jreq	L62
3047  02d2 cc077d        	jp	L7161
3048  02d5               L62:
3049                     ; 336 		if(main_cnt1<(5*ee_TZAS))
3051  02d5 9c            	rvf
3052  02d6 ce0016        	ldw	x,_ee_TZAS
3053  02d9 90ae0005      	ldw	y,#5
3054  02dd cd0000        	call	c_imul
3056  02e0 b34f          	cpw	x,_main_cnt1
3057  02e2 2d18          	jrsle	L5071
3058                     ; 338 			led_red=0x00000000L;
3060  02e4 ae0000        	ldw	x,#0
3061  02e7 bf16          	ldw	_led_red+2,x
3062  02e9 ae0000        	ldw	x,#0
3063  02ec bf14          	ldw	_led_red,x
3064                     ; 339 			led_green=0x03030303L;
3066  02ee ae0303        	ldw	x,#771
3067  02f1 bf1a          	ldw	_led_green+2,x
3068  02f3 ae0303        	ldw	x,#771
3069  02f6 bf18          	ldw	_led_green,x
3071  02f8 ac7d077d      	jpf	L7161
3072  02fc               L5071:
3073                     ; 341 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3075  02fc 9c            	rvf
3076  02fd ce0016        	ldw	x,_ee_TZAS
3077  0300 90ae0005      	ldw	y,#5
3078  0304 cd0000        	call	c_imul
3080  0307 b34f          	cpw	x,_main_cnt1
3081  0309 2e2a          	jrsge	L1171
3083  030b 9c            	rvf
3084  030c ce0016        	ldw	x,_ee_TZAS
3085  030f 90ae0005      	ldw	y,#5
3086  0313 cd0000        	call	c_imul
3088  0316 1c0046        	addw	x,#70
3089  0319 b34f          	cpw	x,_main_cnt1
3090  031b 2d18          	jrsle	L1171
3091                     ; 343 			led_red=0x00000000L;
3093  031d ae0000        	ldw	x,#0
3094  0320 bf16          	ldw	_led_red+2,x
3095  0322 ae0000        	ldw	x,#0
3096  0325 bf14          	ldw	_led_red,x
3097                     ; 344 			led_green=0xffffffffL;	
3099  0327 aeffff        	ldw	x,#65535
3100  032a bf1a          	ldw	_led_green+2,x
3101  032c aeffff        	ldw	x,#-1
3102  032f bf18          	ldw	_led_green,x
3104  0331 ac7d077d      	jpf	L7161
3105  0335               L1171:
3106                     ; 347 		else if((flags&0b00011110)==0)
3108  0335 b60b          	ld	a,_flags
3109  0337 a51e          	bcp	a,#30
3110  0339 2618          	jrne	L5171
3111                     ; 349 			led_red=0x00000000L;
3113  033b ae0000        	ldw	x,#0
3114  033e bf16          	ldw	_led_red+2,x
3115  0340 ae0000        	ldw	x,#0
3116  0343 bf14          	ldw	_led_red,x
3117                     ; 350 			led_green=0xffffffffL;
3119  0345 aeffff        	ldw	x,#65535
3120  0348 bf1a          	ldw	_led_green+2,x
3121  034a aeffff        	ldw	x,#-1
3122  034d bf18          	ldw	_led_green,x
3124  034f ac7d077d      	jpf	L7161
3125  0353               L5171:
3126                     ; 354 		else if((flags&0b00111110)==0b00000100)
3128  0353 b60b          	ld	a,_flags
3129  0355 a43e          	and	a,#62
3130  0357 a104          	cp	a,#4
3131  0359 2618          	jrne	L1271
3132                     ; 356 			led_red=0x00010001L;
3134  035b ae0001        	ldw	x,#1
3135  035e bf16          	ldw	_led_red+2,x
3136  0360 ae0001        	ldw	x,#1
3137  0363 bf14          	ldw	_led_red,x
3138                     ; 357 			led_green=0xffffffffL;	
3140  0365 aeffff        	ldw	x,#65535
3141  0368 bf1a          	ldw	_led_green+2,x
3142  036a aeffff        	ldw	x,#-1
3143  036d bf18          	ldw	_led_green,x
3145  036f ac7d077d      	jpf	L7161
3146  0373               L1271:
3147                     ; 359 		else if(flags&0b00000010)
3149  0373 b60b          	ld	a,_flags
3150  0375 a502          	bcp	a,#2
3151  0377 2718          	jreq	L5271
3152                     ; 361 			led_red=0x00010001L;
3154  0379 ae0001        	ldw	x,#1
3155  037c bf16          	ldw	_led_red+2,x
3156  037e ae0001        	ldw	x,#1
3157  0381 bf14          	ldw	_led_red,x
3158                     ; 362 			led_green=0x00000000L;	
3160  0383 ae0000        	ldw	x,#0
3161  0386 bf1a          	ldw	_led_green+2,x
3162  0388 ae0000        	ldw	x,#0
3163  038b bf18          	ldw	_led_green,x
3165  038d ac7d077d      	jpf	L7161
3166  0391               L5271:
3167                     ; 364 		else if(flags&0b00001000)
3169  0391 b60b          	ld	a,_flags
3170  0393 a508          	bcp	a,#8
3171  0395 2718          	jreq	L1371
3172                     ; 366 			led_red=0x00090009L;
3174  0397 ae0009        	ldw	x,#9
3175  039a bf16          	ldw	_led_red+2,x
3176  039c ae0009        	ldw	x,#9
3177  039f bf14          	ldw	_led_red,x
3178                     ; 367 			led_green=0x00000000L;	
3180  03a1 ae0000        	ldw	x,#0
3181  03a4 bf1a          	ldw	_led_green+2,x
3182  03a6 ae0000        	ldw	x,#0
3183  03a9 bf18          	ldw	_led_green,x
3185  03ab ac7d077d      	jpf	L7161
3186  03af               L1371:
3187                     ; 369 		else if(flags&0b00010000)
3189  03af b60b          	ld	a,_flags
3190  03b1 a510          	bcp	a,#16
3191  03b3 2603          	jrne	L03
3192  03b5 cc077d        	jp	L7161
3193  03b8               L03:
3194                     ; 371 			led_red=0x00490049L;
3196  03b8 ae0049        	ldw	x,#73
3197  03bb bf16          	ldw	_led_red+2,x
3198  03bd ae0049        	ldw	x,#73
3199  03c0 bf14          	ldw	_led_red,x
3200                     ; 372 			led_green=0xffffffffL;	
3202  03c2 aeffff        	ldw	x,#65535
3203  03c5 bf1a          	ldw	_led_green+2,x
3204  03c7 aeffff        	ldw	x,#-1
3205  03ca bf18          	ldw	_led_green,x
3206  03cc ac7d077d      	jpf	L7161
3207  03d0               L1261:
3208                     ; 376 else if(bps_class==bpsIPS)	//если блок ИПСный
3210  03d0 b604          	ld	a,_bps_class
3211  03d2 a101          	cp	a,#1
3212  03d4 2703          	jreq	L23
3213  03d6 cc077d        	jp	L7161
3214  03d9               L23:
3215                     ; 378 	if(jp_mode!=jp3)
3217  03d9 b64a          	ld	a,_jp_mode
3218  03db a103          	cp	a,#3
3219  03dd 2603          	jrne	L43
3220  03df cc0689        	jp	L3471
3221  03e2               L43:
3222                     ; 380 		if(main_cnt1<(5*ee_TZAS))
3224  03e2 9c            	rvf
3225  03e3 ce0016        	ldw	x,_ee_TZAS
3226  03e6 90ae0005      	ldw	y,#5
3227  03ea cd0000        	call	c_imul
3229  03ed b34f          	cpw	x,_main_cnt1
3230  03ef 2d18          	jrsle	L5471
3231                     ; 382 			led_red=0x00000000L;
3233  03f1 ae0000        	ldw	x,#0
3234  03f4 bf16          	ldw	_led_red+2,x
3235  03f6 ae0000        	ldw	x,#0
3236  03f9 bf14          	ldw	_led_red,x
3237                     ; 383 			led_green=0x03030303L;
3239  03fb ae0303        	ldw	x,#771
3240  03fe bf1a          	ldw	_led_green+2,x
3241  0400 ae0303        	ldw	x,#771
3242  0403 bf18          	ldw	_led_green,x
3244  0405 ac4a064a      	jpf	L7471
3245  0409               L5471:
3246                     ; 386 		else if((link==ON)&&(flags_tu&0b10000000))
3248  0409 b663          	ld	a,_link
3249  040b a155          	cp	a,#85
3250  040d 261e          	jrne	L1571
3252  040f b660          	ld	a,_flags_tu
3253  0411 a580          	bcp	a,#128
3254  0413 2718          	jreq	L1571
3255                     ; 388 			led_red=0x00055555L;
3257  0415 ae5555        	ldw	x,#21845
3258  0418 bf16          	ldw	_led_red+2,x
3259  041a ae0005        	ldw	x,#5
3260  041d bf14          	ldw	_led_red,x
3261                     ; 389 			led_green=0xffffffffL;
3263  041f aeffff        	ldw	x,#65535
3264  0422 bf1a          	ldw	_led_green+2,x
3265  0424 aeffff        	ldw	x,#-1
3266  0427 bf18          	ldw	_led_green,x
3268  0429 ac4a064a      	jpf	L7471
3269  042d               L1571:
3270                     ; 392 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3272  042d 9c            	rvf
3273  042e ce0016        	ldw	x,_ee_TZAS
3274  0431 90ae0005      	ldw	y,#5
3275  0435 cd0000        	call	c_imul
3277  0438 b34f          	cpw	x,_main_cnt1
3278  043a 2e37          	jrsge	L5571
3280  043c 9c            	rvf
3281  043d ce0016        	ldw	x,_ee_TZAS
3282  0440 90ae0005      	ldw	y,#5
3283  0444 cd0000        	call	c_imul
3285  0447 1c0064        	addw	x,#100
3286  044a b34f          	cpw	x,_main_cnt1
3287  044c 2d25          	jrsle	L5571
3289  044e ce0006        	ldw	x,_ee_AVT_MODE
3290  0451 a30055        	cpw	x,#85
3291  0454 271d          	jreq	L5571
3293  0456 ce0004        	ldw	x,_ee_DEVICE
3294  0459 2618          	jrne	L5571
3295                     ; 394 			led_red=0x00000000L;
3297  045b ae0000        	ldw	x,#0
3298  045e bf16          	ldw	_led_red+2,x
3299  0460 ae0000        	ldw	x,#0
3300  0463 bf14          	ldw	_led_red,x
3301                     ; 395 			led_green=0xffffffffL;	
3303  0465 aeffff        	ldw	x,#65535
3304  0468 bf1a          	ldw	_led_green+2,x
3305  046a aeffff        	ldw	x,#-1
3306  046d bf18          	ldw	_led_green,x
3308  046f ac4a064a      	jpf	L7471
3309  0473               L5571:
3310                     ; 398 		else  if(link==OFF)
3312  0473 b663          	ld	a,_link
3313  0475 a1aa          	cp	a,#170
3314  0477 2703          	jreq	L63
3315  0479 cc0595        	jp	L1671
3316  047c               L63:
3317                     ; 400 			if((flags&0b00011110)==0)
3319  047c b60b          	ld	a,_flags
3320  047e a51e          	bcp	a,#30
3321  0480 262d          	jrne	L3671
3322                     ; 402 				led_red=0x00000000L;
3324  0482 ae0000        	ldw	x,#0
3325  0485 bf16          	ldw	_led_red+2,x
3326  0487 ae0000        	ldw	x,#0
3327  048a bf14          	ldw	_led_red,x
3328                     ; 403 				if(bMAIN)led_green=0xfffffff5L;
3330                     	btst	_bMAIN
3331  0491 240e          	jruge	L5671
3334  0493 aefff5        	ldw	x,#65525
3335  0496 bf1a          	ldw	_led_green+2,x
3336  0498 aeffff        	ldw	x,#-1
3337  049b bf18          	ldw	_led_green,x
3339  049d ac4a064a      	jpf	L7471
3340  04a1               L5671:
3341                     ; 404 				else led_green=0xffffffffL;
3343  04a1 aeffff        	ldw	x,#65535
3344  04a4 bf1a          	ldw	_led_green+2,x
3345  04a6 aeffff        	ldw	x,#-1
3346  04a9 bf18          	ldw	_led_green,x
3347  04ab ac4a064a      	jpf	L7471
3348  04af               L3671:
3349                     ; 407 			else if((flags&0b00111110)==0b00000100)
3351  04af b60b          	ld	a,_flags
3352  04b1 a43e          	and	a,#62
3353  04b3 a104          	cp	a,#4
3354  04b5 262d          	jrne	L3771
3355                     ; 409 				led_red=0x00010001L;
3357  04b7 ae0001        	ldw	x,#1
3358  04ba bf16          	ldw	_led_red+2,x
3359  04bc ae0001        	ldw	x,#1
3360  04bf bf14          	ldw	_led_red,x
3361                     ; 410 				if(bMAIN)led_green=0xfffffff5L;
3363                     	btst	_bMAIN
3364  04c6 240e          	jruge	L5771
3367  04c8 aefff5        	ldw	x,#65525
3368  04cb bf1a          	ldw	_led_green+2,x
3369  04cd aeffff        	ldw	x,#-1
3370  04d0 bf18          	ldw	_led_green,x
3372  04d2 ac4a064a      	jpf	L7471
3373  04d6               L5771:
3374                     ; 411 				else led_green=0xffffffffL;	
3376  04d6 aeffff        	ldw	x,#65535
3377  04d9 bf1a          	ldw	_led_green+2,x
3378  04db aeffff        	ldw	x,#-1
3379  04de bf18          	ldw	_led_green,x
3380  04e0 ac4a064a      	jpf	L7471
3381  04e4               L3771:
3382                     ; 413 			else if(flags&0b00000010)
3384  04e4 b60b          	ld	a,_flags
3385  04e6 a502          	bcp	a,#2
3386  04e8 272d          	jreq	L3002
3387                     ; 415 				led_red=0x00010001L;
3389  04ea ae0001        	ldw	x,#1
3390  04ed bf16          	ldw	_led_red+2,x
3391  04ef ae0001        	ldw	x,#1
3392  04f2 bf14          	ldw	_led_red,x
3393                     ; 416 				if(bMAIN)led_green=0x00000005L;
3395                     	btst	_bMAIN
3396  04f9 240e          	jruge	L5002
3399  04fb ae0005        	ldw	x,#5
3400  04fe bf1a          	ldw	_led_green+2,x
3401  0500 ae0000        	ldw	x,#0
3402  0503 bf18          	ldw	_led_green,x
3404  0505 ac4a064a      	jpf	L7471
3405  0509               L5002:
3406                     ; 417 				else led_green=0x00000000L;
3408  0509 ae0000        	ldw	x,#0
3409  050c bf1a          	ldw	_led_green+2,x
3410  050e ae0000        	ldw	x,#0
3411  0511 bf18          	ldw	_led_green,x
3412  0513 ac4a064a      	jpf	L7471
3413  0517               L3002:
3414                     ; 419 			else if(flags&0b00001000)
3416  0517 b60b          	ld	a,_flags
3417  0519 a508          	bcp	a,#8
3418  051b 272d          	jreq	L3102
3419                     ; 421 				led_red=0x00090009L;
3421  051d ae0009        	ldw	x,#9
3422  0520 bf16          	ldw	_led_red+2,x
3423  0522 ae0009        	ldw	x,#9
3424  0525 bf14          	ldw	_led_red,x
3425                     ; 422 				if(bMAIN)led_green=0x00000005L;
3427                     	btst	_bMAIN
3428  052c 240e          	jruge	L5102
3431  052e ae0005        	ldw	x,#5
3432  0531 bf1a          	ldw	_led_green+2,x
3433  0533 ae0000        	ldw	x,#0
3434  0536 bf18          	ldw	_led_green,x
3436  0538 ac4a064a      	jpf	L7471
3437  053c               L5102:
3438                     ; 423 				else led_green=0x00000000L;	
3440  053c ae0000        	ldw	x,#0
3441  053f bf1a          	ldw	_led_green+2,x
3442  0541 ae0000        	ldw	x,#0
3443  0544 bf18          	ldw	_led_green,x
3444  0546 ac4a064a      	jpf	L7471
3445  054a               L3102:
3446                     ; 425 			else if(flags&0b00010000)
3448  054a b60b          	ld	a,_flags
3449  054c a510          	bcp	a,#16
3450  054e 272d          	jreq	L3202
3451                     ; 427 				led_red=0x00490049L;
3453  0550 ae0049        	ldw	x,#73
3454  0553 bf16          	ldw	_led_red+2,x
3455  0555 ae0049        	ldw	x,#73
3456  0558 bf14          	ldw	_led_red,x
3457                     ; 428 				if(bMAIN)led_green=0x00000005L;
3459                     	btst	_bMAIN
3460  055f 240e          	jruge	L5202
3463  0561 ae0005        	ldw	x,#5
3464  0564 bf1a          	ldw	_led_green+2,x
3465  0566 ae0000        	ldw	x,#0
3466  0569 bf18          	ldw	_led_green,x
3468  056b ac4a064a      	jpf	L7471
3469  056f               L5202:
3470                     ; 429 				else led_green=0x00000000L;	
3472  056f ae0000        	ldw	x,#0
3473  0572 bf1a          	ldw	_led_green+2,x
3474  0574 ae0000        	ldw	x,#0
3475  0577 bf18          	ldw	_led_green,x
3476  0579 ac4a064a      	jpf	L7471
3477  057d               L3202:
3478                     ; 433 				led_red=0x55555555L;
3480  057d ae5555        	ldw	x,#21845
3481  0580 bf16          	ldw	_led_red+2,x
3482  0582 ae5555        	ldw	x,#21845
3483  0585 bf14          	ldw	_led_red,x
3484                     ; 434 				led_green=0xffffffffL;
3486  0587 aeffff        	ldw	x,#65535
3487  058a bf1a          	ldw	_led_green+2,x
3488  058c aeffff        	ldw	x,#-1
3489  058f bf18          	ldw	_led_green,x
3490  0591 ac4a064a      	jpf	L7471
3491  0595               L1671:
3492                     ; 450 		else if((link==ON)&&((flags&0b00111110)==0))
3494  0595 b663          	ld	a,_link
3495  0597 a155          	cp	a,#85
3496  0599 261d          	jrne	L5302
3498  059b b60b          	ld	a,_flags
3499  059d a53e          	bcp	a,#62
3500  059f 2617          	jrne	L5302
3501                     ; 452 			led_red=0x00000000L;
3503  05a1 ae0000        	ldw	x,#0
3504  05a4 bf16          	ldw	_led_red+2,x
3505  05a6 ae0000        	ldw	x,#0
3506  05a9 bf14          	ldw	_led_red,x
3507                     ; 453 			led_green=0xffffffffL;
3509  05ab aeffff        	ldw	x,#65535
3510  05ae bf1a          	ldw	_led_green+2,x
3511  05b0 aeffff        	ldw	x,#-1
3512  05b3 bf18          	ldw	_led_green,x
3514  05b5 cc064a        	jra	L7471
3515  05b8               L5302:
3516                     ; 456 		else if((flags&0b00111110)==0b00000100)
3518  05b8 b60b          	ld	a,_flags
3519  05ba a43e          	and	a,#62
3520  05bc a104          	cp	a,#4
3521  05be 2616          	jrne	L1402
3522                     ; 458 			led_red=0x00010001L;
3524  05c0 ae0001        	ldw	x,#1
3525  05c3 bf16          	ldw	_led_red+2,x
3526  05c5 ae0001        	ldw	x,#1
3527  05c8 bf14          	ldw	_led_red,x
3528                     ; 459 			led_green=0xffffffffL;	
3530  05ca aeffff        	ldw	x,#65535
3531  05cd bf1a          	ldw	_led_green+2,x
3532  05cf aeffff        	ldw	x,#-1
3533  05d2 bf18          	ldw	_led_green,x
3535  05d4 2074          	jra	L7471
3536  05d6               L1402:
3537                     ; 461 		else if(flags&0b00000010)
3539  05d6 b60b          	ld	a,_flags
3540  05d8 a502          	bcp	a,#2
3541  05da 2716          	jreq	L5402
3542                     ; 463 			led_red=0x00010001L;
3544  05dc ae0001        	ldw	x,#1
3545  05df bf16          	ldw	_led_red+2,x
3546  05e1 ae0001        	ldw	x,#1
3547  05e4 bf14          	ldw	_led_red,x
3548                     ; 464 			led_green=0x00000000L;	
3550  05e6 ae0000        	ldw	x,#0
3551  05e9 bf1a          	ldw	_led_green+2,x
3552  05eb ae0000        	ldw	x,#0
3553  05ee bf18          	ldw	_led_green,x
3555  05f0 2058          	jra	L7471
3556  05f2               L5402:
3557                     ; 466 		else if(flags&0b00001000)
3559  05f2 b60b          	ld	a,_flags
3560  05f4 a508          	bcp	a,#8
3561  05f6 2716          	jreq	L1502
3562                     ; 468 			led_red=0x00090009L;
3564  05f8 ae0009        	ldw	x,#9
3565  05fb bf16          	ldw	_led_red+2,x
3566  05fd ae0009        	ldw	x,#9
3567  0600 bf14          	ldw	_led_red,x
3568                     ; 469 			led_green=0x00000000L;	
3570  0602 ae0000        	ldw	x,#0
3571  0605 bf1a          	ldw	_led_green+2,x
3572  0607 ae0000        	ldw	x,#0
3573  060a bf18          	ldw	_led_green,x
3575  060c 203c          	jra	L7471
3576  060e               L1502:
3577                     ; 471 		else if(flags&0b00010000)
3579  060e b60b          	ld	a,_flags
3580  0610 a510          	bcp	a,#16
3581  0612 2716          	jreq	L5502
3582                     ; 473 			led_red=0x00490049L;
3584  0614 ae0049        	ldw	x,#73
3585  0617 bf16          	ldw	_led_red+2,x
3586  0619 ae0049        	ldw	x,#73
3587  061c bf14          	ldw	_led_red,x
3588                     ; 474 			led_green=0x00000000L;	
3590  061e ae0000        	ldw	x,#0
3591  0621 bf1a          	ldw	_led_green+2,x
3592  0623 ae0000        	ldw	x,#0
3593  0626 bf18          	ldw	_led_green,x
3595  0628 2020          	jra	L7471
3596  062a               L5502:
3597                     ; 477 		else if((link==ON)&&(flags&0b00100000))
3599  062a b663          	ld	a,_link
3600  062c a155          	cp	a,#85
3601  062e 261a          	jrne	L7471
3603  0630 b60b          	ld	a,_flags
3604  0632 a520          	bcp	a,#32
3605  0634 2714          	jreq	L7471
3606                     ; 479 			led_red=0x00000000L;
3608  0636 ae0000        	ldw	x,#0
3609  0639 bf16          	ldw	_led_red+2,x
3610  063b ae0000        	ldw	x,#0
3611  063e bf14          	ldw	_led_red,x
3612                     ; 480 			led_green=0x00030003L;
3614  0640 ae0003        	ldw	x,#3
3615  0643 bf1a          	ldw	_led_green+2,x
3616  0645 ae0003        	ldw	x,#3
3617  0648 bf18          	ldw	_led_green,x
3618  064a               L7471:
3619                     ; 483 		if((jp_mode==jp1))
3621  064a b64a          	ld	a,_jp_mode
3622  064c a101          	cp	a,#1
3623  064e 2618          	jrne	L3602
3624                     ; 485 			led_red=0x00000000L;
3626  0650 ae0000        	ldw	x,#0
3627  0653 bf16          	ldw	_led_red+2,x
3628  0655 ae0000        	ldw	x,#0
3629  0658 bf14          	ldw	_led_red,x
3630                     ; 486 			led_green=0x33333333L;
3632  065a ae3333        	ldw	x,#13107
3633  065d bf1a          	ldw	_led_green+2,x
3634  065f ae3333        	ldw	x,#13107
3635  0662 bf18          	ldw	_led_green,x
3637  0664 ac7d077d      	jpf	L7161
3638  0668               L3602:
3639                     ; 488 		else if((jp_mode==jp2))
3641  0668 b64a          	ld	a,_jp_mode
3642  066a a102          	cp	a,#2
3643  066c 2703          	jreq	L04
3644  066e cc077d        	jp	L7161
3645  0671               L04:
3646                     ; 492 			led_red=0xccccccccL;
3648  0671 aecccc        	ldw	x,#52428
3649  0674 bf16          	ldw	_led_red+2,x
3650  0676 aecccc        	ldw	x,#-13108
3651  0679 bf14          	ldw	_led_red,x
3652                     ; 493 			led_green=0x00000000L;
3654  067b ae0000        	ldw	x,#0
3655  067e bf1a          	ldw	_led_green+2,x
3656  0680 ae0000        	ldw	x,#0
3657  0683 bf18          	ldw	_led_green,x
3658  0685 ac7d077d      	jpf	L7161
3659  0689               L3471:
3660                     ; 496 	else if(jp_mode==jp3)
3662  0689 b64a          	ld	a,_jp_mode
3663  068b a103          	cp	a,#3
3664  068d 2703          	jreq	L24
3665  068f cc077d        	jp	L7161
3666  0692               L24:
3667                     ; 498 		if(main_cnt1<(5*ee_TZAS))
3669  0692 9c            	rvf
3670  0693 ce0016        	ldw	x,_ee_TZAS
3671  0696 90ae0005      	ldw	y,#5
3672  069a cd0000        	call	c_imul
3674  069d b34f          	cpw	x,_main_cnt1
3675  069f 2d18          	jrsle	L5702
3676                     ; 500 			led_red=0x00000000L;
3678  06a1 ae0000        	ldw	x,#0
3679  06a4 bf16          	ldw	_led_red+2,x
3680  06a6 ae0000        	ldw	x,#0
3681  06a9 bf14          	ldw	_led_red,x
3682                     ; 501 			led_green=0x03030303L;
3684  06ab ae0303        	ldw	x,#771
3685  06ae bf1a          	ldw	_led_green+2,x
3686  06b0 ae0303        	ldw	x,#771
3687  06b3 bf18          	ldw	_led_green,x
3689  06b5 ac7d077d      	jpf	L7161
3690  06b9               L5702:
3691                     ; 503 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3693  06b9 9c            	rvf
3694  06ba ce0016        	ldw	x,_ee_TZAS
3695  06bd 90ae0005      	ldw	y,#5
3696  06c1 cd0000        	call	c_imul
3698  06c4 b34f          	cpw	x,_main_cnt1
3699  06c6 2e29          	jrsge	L1012
3701  06c8 9c            	rvf
3702  06c9 ce0016        	ldw	x,_ee_TZAS
3703  06cc 90ae0005      	ldw	y,#5
3704  06d0 cd0000        	call	c_imul
3706  06d3 1c0046        	addw	x,#70
3707  06d6 b34f          	cpw	x,_main_cnt1
3708  06d8 2d17          	jrsle	L1012
3709                     ; 505 			led_red=0x00000000L;
3711  06da ae0000        	ldw	x,#0
3712  06dd bf16          	ldw	_led_red+2,x
3713  06df ae0000        	ldw	x,#0
3714  06e2 bf14          	ldw	_led_red,x
3715                     ; 506 			led_green=0xffffffffL;	
3717  06e4 aeffff        	ldw	x,#65535
3718  06e7 bf1a          	ldw	_led_green+2,x
3719  06e9 aeffff        	ldw	x,#-1
3720  06ec bf18          	ldw	_led_green,x
3722  06ee cc077d        	jra	L7161
3723  06f1               L1012:
3724                     ; 509 		else if((flags&0b00011110)==0)
3726  06f1 b60b          	ld	a,_flags
3727  06f3 a51e          	bcp	a,#30
3728  06f5 2616          	jrne	L5012
3729                     ; 511 			led_red=0x00000000L;
3731  06f7 ae0000        	ldw	x,#0
3732  06fa bf16          	ldw	_led_red+2,x
3733  06fc ae0000        	ldw	x,#0
3734  06ff bf14          	ldw	_led_red,x
3735                     ; 512 			led_green=0xffffffffL;
3737  0701 aeffff        	ldw	x,#65535
3738  0704 bf1a          	ldw	_led_green+2,x
3739  0706 aeffff        	ldw	x,#-1
3740  0709 bf18          	ldw	_led_green,x
3742  070b 2070          	jra	L7161
3743  070d               L5012:
3744                     ; 516 		else if((flags&0b00111110)==0b00000100)
3746  070d b60b          	ld	a,_flags
3747  070f a43e          	and	a,#62
3748  0711 a104          	cp	a,#4
3749  0713 2616          	jrne	L1112
3750                     ; 518 			led_red=0x00010001L;
3752  0715 ae0001        	ldw	x,#1
3753  0718 bf16          	ldw	_led_red+2,x
3754  071a ae0001        	ldw	x,#1
3755  071d bf14          	ldw	_led_red,x
3756                     ; 519 			led_green=0xffffffffL;	
3758  071f aeffff        	ldw	x,#65535
3759  0722 bf1a          	ldw	_led_green+2,x
3760  0724 aeffff        	ldw	x,#-1
3761  0727 bf18          	ldw	_led_green,x
3763  0729 2052          	jra	L7161
3764  072b               L1112:
3765                     ; 521 		else if(flags&0b00000010)
3767  072b b60b          	ld	a,_flags
3768  072d a502          	bcp	a,#2
3769  072f 2716          	jreq	L5112
3770                     ; 523 			led_red=0x00010001L;
3772  0731 ae0001        	ldw	x,#1
3773  0734 bf16          	ldw	_led_red+2,x
3774  0736 ae0001        	ldw	x,#1
3775  0739 bf14          	ldw	_led_red,x
3776                     ; 524 			led_green=0x00000000L;	
3778  073b ae0000        	ldw	x,#0
3779  073e bf1a          	ldw	_led_green+2,x
3780  0740 ae0000        	ldw	x,#0
3781  0743 bf18          	ldw	_led_green,x
3783  0745 2036          	jra	L7161
3784  0747               L5112:
3785                     ; 526 		else if(flags&0b00001000)
3787  0747 b60b          	ld	a,_flags
3788  0749 a508          	bcp	a,#8
3789  074b 2716          	jreq	L1212
3790                     ; 528 			led_red=0x00090009L;
3792  074d ae0009        	ldw	x,#9
3793  0750 bf16          	ldw	_led_red+2,x
3794  0752 ae0009        	ldw	x,#9
3795  0755 bf14          	ldw	_led_red,x
3796                     ; 529 			led_green=0x00000000L;	
3798  0757 ae0000        	ldw	x,#0
3799  075a bf1a          	ldw	_led_green+2,x
3800  075c ae0000        	ldw	x,#0
3801  075f bf18          	ldw	_led_green,x
3803  0761 201a          	jra	L7161
3804  0763               L1212:
3805                     ; 531 		else if(flags&0b00010000)
3807  0763 b60b          	ld	a,_flags
3808  0765 a510          	bcp	a,#16
3809  0767 2714          	jreq	L7161
3810                     ; 533 			led_red=0x00490049L;
3812  0769 ae0049        	ldw	x,#73
3813  076c bf16          	ldw	_led_red+2,x
3814  076e ae0049        	ldw	x,#73
3815  0771 bf14          	ldw	_led_red,x
3816                     ; 534 			led_green=0xffffffffL;	
3818  0773 aeffff        	ldw	x,#65535
3819  0776 bf1a          	ldw	_led_green+2,x
3820  0778 aeffff        	ldw	x,#-1
3821  077b bf18          	ldw	_led_green,x
3822  077d               L7161:
3823                     ; 541 }
3826  077d 81            	ret
3854                     ; 544 void led_drv(void)
3854                     ; 545 {
3855                     	switch	.text
3856  077e               _led_drv:
3860                     ; 547 GPIOA->DDR|=(1<<6);
3862  077e 721c5002      	bset	20482,#6
3863                     ; 548 GPIOA->CR1|=(1<<6);
3865  0782 721c5003      	bset	20483,#6
3866                     ; 549 GPIOA->CR2&=~(1<<6);
3868  0786 721d5004      	bres	20484,#6
3869                     ; 550 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<6); 	//Горит если в led_red_buff 1 и на ножке 1
3871  078a b640          	ld	a,_led_red_buff+3
3872  078c a501          	bcp	a,#1
3873  078e 2706          	jreq	L7312
3876  0790 721c5000      	bset	20480,#6
3878  0794 2004          	jra	L1412
3879  0796               L7312:
3880                     ; 551 else GPIOA->ODR&=~(1<<6); 
3882  0796 721d5000      	bres	20480,#6
3883  079a               L1412:
3884                     ; 554 GPIOA->DDR|=(1<<5);
3886  079a 721a5002      	bset	20482,#5
3887                     ; 555 GPIOA->CR1|=(1<<5);
3889  079e 721a5003      	bset	20483,#5
3890                     ; 556 GPIOA->CR2&=~(1<<5);	
3892  07a2 721b5004      	bres	20484,#5
3893                     ; 557 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3895  07a6 b63c          	ld	a,_led_green_buff+3
3896  07a8 a501          	bcp	a,#1
3897  07aa 2706          	jreq	L3412
3900  07ac 721a5000      	bset	20480,#5
3902  07b0 2004          	jra	L5412
3903  07b2               L3412:
3904                     ; 558 else GPIOA->ODR&=~(1<<5);
3906  07b2 721b5000      	bres	20480,#5
3907  07b6               L5412:
3908                     ; 561 led_red_buff>>=1;
3910  07b6 373d          	sra	_led_red_buff
3911  07b8 363e          	rrc	_led_red_buff+1
3912  07ba 363f          	rrc	_led_red_buff+2
3913  07bc 3640          	rrc	_led_red_buff+3
3914                     ; 562 led_green_buff>>=1;
3916  07be 3739          	sra	_led_green_buff
3917  07c0 363a          	rrc	_led_green_buff+1
3918  07c2 363b          	rrc	_led_green_buff+2
3919  07c4 363c          	rrc	_led_green_buff+3
3920                     ; 563 if(++led_drv_cnt>32)
3922  07c6 3c1c          	inc	_led_drv_cnt
3923  07c8 b61c          	ld	a,_led_drv_cnt
3924  07ca a121          	cp	a,#33
3925  07cc 2512          	jrult	L7412
3926                     ; 565 	led_drv_cnt=0;
3928  07ce 3f1c          	clr	_led_drv_cnt
3929                     ; 566 	led_red_buff=led_red;
3931  07d0 be16          	ldw	x,_led_red+2
3932  07d2 bf3f          	ldw	_led_red_buff+2,x
3933  07d4 be14          	ldw	x,_led_red
3934  07d6 bf3d          	ldw	_led_red_buff,x
3935                     ; 567 	led_green_buff=led_green;
3937  07d8 be1a          	ldw	x,_led_green+2
3938  07da bf3b          	ldw	_led_green_buff+2,x
3939  07dc be18          	ldw	x,_led_green
3940  07de bf39          	ldw	_led_green_buff,x
3941  07e0               L7412:
3942                     ; 573 } 
3945  07e0 81            	ret
3971                     ; 576 void JP_drv(void)
3971                     ; 577 {
3972                     	switch	.text
3973  07e1               _JP_drv:
3977                     ; 579 GPIOD->DDR&=~(1<<6);
3979  07e1 721d5011      	bres	20497,#6
3980                     ; 580 GPIOD->CR1|=(1<<6);
3982  07e5 721c5012      	bset	20498,#6
3983                     ; 581 GPIOD->CR2&=~(1<<6);
3985  07e9 721d5013      	bres	20499,#6
3986                     ; 583 GPIOD->DDR&=~(1<<7);
3988  07ed 721f5011      	bres	20497,#7
3989                     ; 584 GPIOD->CR1|=(1<<7);
3991  07f1 721e5012      	bset	20498,#7
3992                     ; 585 GPIOD->CR2&=~(1<<7);
3994  07f5 721f5013      	bres	20499,#7
3995                     ; 587 if(GPIOD->IDR&(1<<6))
3997  07f9 c65010        	ld	a,20496
3998  07fc a540          	bcp	a,#64
3999  07fe 270a          	jreq	L1612
4000                     ; 589 	if(cnt_JP0<10)
4002  0800 b649          	ld	a,_cnt_JP0
4003  0802 a10a          	cp	a,#10
4004  0804 2411          	jruge	L5612
4005                     ; 591 		cnt_JP0++;
4007  0806 3c49          	inc	_cnt_JP0
4008  0808 200d          	jra	L5612
4009  080a               L1612:
4010                     ; 594 else if(!(GPIOD->IDR&(1<<6)))
4012  080a c65010        	ld	a,20496
4013  080d a540          	bcp	a,#64
4014  080f 2606          	jrne	L5612
4015                     ; 596 	if(cnt_JP0)
4017  0811 3d49          	tnz	_cnt_JP0
4018  0813 2702          	jreq	L5612
4019                     ; 598 		cnt_JP0--;
4021  0815 3a49          	dec	_cnt_JP0
4022  0817               L5612:
4023                     ; 602 if(GPIOD->IDR&(1<<7))
4025  0817 c65010        	ld	a,20496
4026  081a a580          	bcp	a,#128
4027  081c 270a          	jreq	L3712
4028                     ; 604 	if(cnt_JP1<10)
4030  081e b648          	ld	a,_cnt_JP1
4031  0820 a10a          	cp	a,#10
4032  0822 2411          	jruge	L7712
4033                     ; 606 		cnt_JP1++;
4035  0824 3c48          	inc	_cnt_JP1
4036  0826 200d          	jra	L7712
4037  0828               L3712:
4038                     ; 609 else if(!(GPIOD->IDR&(1<<7)))
4040  0828 c65010        	ld	a,20496
4041  082b a580          	bcp	a,#128
4042  082d 2606          	jrne	L7712
4043                     ; 611 	if(cnt_JP1)
4045  082f 3d48          	tnz	_cnt_JP1
4046  0831 2702          	jreq	L7712
4047                     ; 613 		cnt_JP1--;
4049  0833 3a48          	dec	_cnt_JP1
4050  0835               L7712:
4051                     ; 618 if((cnt_JP0==10)&&(cnt_JP1==10))
4053  0835 b649          	ld	a,_cnt_JP0
4054  0837 a10a          	cp	a,#10
4055  0839 2608          	jrne	L5022
4057  083b b648          	ld	a,_cnt_JP1
4058  083d a10a          	cp	a,#10
4059  083f 2602          	jrne	L5022
4060                     ; 620 	jp_mode=jp0;
4062  0841 3f4a          	clr	_jp_mode
4063  0843               L5022:
4064                     ; 622 if((cnt_JP0==0)&&(cnt_JP1==10))
4066  0843 3d49          	tnz	_cnt_JP0
4067  0845 260a          	jrne	L7022
4069  0847 b648          	ld	a,_cnt_JP1
4070  0849 a10a          	cp	a,#10
4071  084b 2604          	jrne	L7022
4072                     ; 624 	jp_mode=jp1;
4074  084d 3501004a      	mov	_jp_mode,#1
4075  0851               L7022:
4076                     ; 626 if((cnt_JP0==10)&&(cnt_JP1==0))
4078  0851 b649          	ld	a,_cnt_JP0
4079  0853 a10a          	cp	a,#10
4080  0855 2608          	jrne	L1122
4082  0857 3d48          	tnz	_cnt_JP1
4083  0859 2604          	jrne	L1122
4084                     ; 628 	jp_mode=jp2;
4086  085b 3502004a      	mov	_jp_mode,#2
4087  085f               L1122:
4088                     ; 630 if((cnt_JP0==0)&&(cnt_JP1==0))
4090  085f 3d49          	tnz	_cnt_JP0
4091  0861 2608          	jrne	L3122
4093  0863 3d48          	tnz	_cnt_JP1
4094  0865 2604          	jrne	L3122
4095                     ; 632 	jp_mode=jp3;
4097  0867 3503004a      	mov	_jp_mode,#3
4098  086b               L3122:
4099                     ; 635 }
4102  086b 81            	ret
4134                     ; 638 void link_drv(void)		//10Hz
4134                     ; 639 {
4135                     	switch	.text
4136  086c               _link_drv:
4140                     ; 640 if(jp_mode!=jp3)
4142  086c b64a          	ld	a,_jp_mode
4143  086e a103          	cp	a,#3
4144  0870 274d          	jreq	L5222
4145                     ; 642 	if(link_cnt<602)link_cnt++;
4147  0872 9c            	rvf
4148  0873 be61          	ldw	x,_link_cnt
4149  0875 a3025a        	cpw	x,#602
4150  0878 2e07          	jrsge	L7222
4153  087a be61          	ldw	x,_link_cnt
4154  087c 1c0001        	addw	x,#1
4155  087f bf61          	ldw	_link_cnt,x
4156  0881               L7222:
4157                     ; 643 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4159  0881 be61          	ldw	x,_link_cnt
4160  0883 a3024e        	cpw	x,#590
4161  0886 2606          	jrne	L1322
4164  0888 b60b          	ld	a,_flags
4165  088a a4c1          	and	a,#193
4166  088c b70b          	ld	_flags,a
4167  088e               L1322:
4168                     ; 644 	if(link_cnt==600)
4170  088e be61          	ldw	x,_link_cnt
4171  0890 a30258        	cpw	x,#600
4172  0893 262e          	jrne	L3422
4173                     ; 646 		link=OFF;
4175  0895 35aa0063      	mov	_link,#170
4176                     ; 651 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4178  0899 b604          	ld	a,_bps_class
4179  089b a101          	cp	a,#1
4180  089d 2606          	jrne	L5322
4183  089f 72100002      	bset	_bMAIN
4185  08a3 2004          	jra	L7322
4186  08a5               L5322:
4187                     ; 652 		else bMAIN=0;
4189  08a5 72110002      	bres	_bMAIN
4190  08a9               L7322:
4191                     ; 654 		cnt_net_drv=0;
4193  08a9 3f32          	clr	_cnt_net_drv
4194                     ; 655     		if(!res_fl_)
4196  08ab 725d000a      	tnz	_res_fl_
4197  08af 2612          	jrne	L3422
4198                     ; 657 	    		bRES_=1;
4200  08b1 35010013      	mov	_bRES_,#1
4201                     ; 658 	    		res_fl_=1;
4203  08b5 a601          	ld	a,#1
4204  08b7 ae000a        	ldw	x,#_res_fl_
4205  08ba cd0000        	call	c_eewrc
4207  08bd 2004          	jra	L3422
4208  08bf               L5222:
4209                     ; 662 else link=OFF;	
4211  08bf 35aa0063      	mov	_link,#170
4212  08c3               L3422:
4213                     ; 663 } 
4216  08c3 81            	ret
4286                     	switch	.const
4287  0004               L45:
4288  0004 0000000b      	dc.l	11
4289  0008               L65:
4290  0008 00000001      	dc.l	1
4291                     ; 667 void vent_drv(void)
4291                     ; 668 {
4292                     	switch	.text
4293  08c4               _vent_drv:
4295  08c4 520e          	subw	sp,#14
4296       0000000e      OFST:	set	14
4299                     ; 671 	short vent_pwm_i_necc=400;
4301  08c6 ae0190        	ldw	x,#400
4302  08c9 1f07          	ldw	(OFST-7,sp),x
4303                     ; 672 	short vent_pwm_t_necc=400;
4305  08cb ae0190        	ldw	x,#400
4306  08ce 1f09          	ldw	(OFST-5,sp),x
4307                     ; 673 	short vent_pwm_max_necc=400;
4309                     ; 678 	tempSL=36000L/(signed long)ee_Umax;
4311  08d0 ce0014        	ldw	x,_ee_Umax
4312  08d3 cd0000        	call	c_itolx
4314  08d6 96            	ldw	x,sp
4315  08d7 1c0001        	addw	x,#OFST-13
4316  08da cd0000        	call	c_rtol
4318  08dd ae8ca0        	ldw	x,#36000
4319  08e0 bf02          	ldw	c_lreg+2,x
4320  08e2 ae0000        	ldw	x,#0
4321  08e5 bf00          	ldw	c_lreg,x
4322  08e7 96            	ldw	x,sp
4323  08e8 1c0001        	addw	x,#OFST-13
4324  08eb cd0000        	call	c_ldiv
4326  08ee 96            	ldw	x,sp
4327  08ef 1c000b        	addw	x,#OFST-3
4328  08f2 cd0000        	call	c_rtol
4330                     ; 679 	tempSL=(signed long)I/tempSL;
4332  08f5 be6f          	ldw	x,_I
4333  08f7 cd0000        	call	c_itolx
4335  08fa 96            	ldw	x,sp
4336  08fb 1c000b        	addw	x,#OFST-3
4337  08fe cd0000        	call	c_ldiv
4339  0901 96            	ldw	x,sp
4340  0902 1c000b        	addw	x,#OFST-3
4341  0905 cd0000        	call	c_rtol
4343                     ; 681 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4345  0908 ce0004        	ldw	x,_ee_DEVICE
4346  090b a30001        	cpw	x,#1
4347  090e 2613          	jrne	L7722
4350  0910 be6f          	ldw	x,_I
4351  0912 90ce0002      	ldw	y,_ee_IMAXVENT
4352  0916 cd0000        	call	c_idiv
4354  0919 cd0000        	call	c_itolx
4356  091c 96            	ldw	x,sp
4357  091d 1c000b        	addw	x,#OFST-3
4358  0920 cd0000        	call	c_rtol
4360  0923               L7722:
4361                     ; 683 	if(tempSL>10)vent_pwm_i_necc=1000;
4363  0923 9c            	rvf
4364  0924 96            	ldw	x,sp
4365  0925 1c000b        	addw	x,#OFST-3
4366  0928 cd0000        	call	c_ltor
4368  092b ae0004        	ldw	x,#L45
4369  092e cd0000        	call	c_lcmp
4371  0931 2f07          	jrslt	L1032
4374  0933 ae03e8        	ldw	x,#1000
4375  0936 1f07          	ldw	(OFST-7,sp),x
4377  0938 2025          	jra	L3032
4378  093a               L1032:
4379                     ; 684 	else if(tempSL<1)vent_pwm_i_necc=400;
4381  093a 9c            	rvf
4382  093b 96            	ldw	x,sp
4383  093c 1c000b        	addw	x,#OFST-3
4384  093f cd0000        	call	c_ltor
4386  0942 ae0008        	ldw	x,#L65
4387  0945 cd0000        	call	c_lcmp
4389  0948 2e07          	jrsge	L5032
4392  094a ae0190        	ldw	x,#400
4393  094d 1f07          	ldw	(OFST-7,sp),x
4395  094f 200e          	jra	L3032
4396  0951               L5032:
4397                     ; 685 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4399  0951 1e0d          	ldw	x,(OFST-1,sp)
4400  0953 90ae003c      	ldw	y,#60
4401  0957 cd0000        	call	c_imul
4403  095a 1c0190        	addw	x,#400
4404  095d 1f07          	ldw	(OFST-7,sp),x
4405  095f               L3032:
4406                     ; 686 	gran(&vent_pwm_i_necc,400,1000);
4408  095f ae03e8        	ldw	x,#1000
4409  0962 89            	pushw	x
4410  0963 ae0190        	ldw	x,#400
4411  0966 89            	pushw	x
4412  0967 96            	ldw	x,sp
4413  0968 1c000b        	addw	x,#OFST-3
4414  096b cd006d        	call	_gran
4416  096e 5b04          	addw	sp,#4
4417                     ; 688 	tempSL=(signed long)T;
4419  0970 b668          	ld	a,_T
4420  0972 b703          	ld	c_lreg+3,a
4421  0974 48            	sll	a
4422  0975 4f            	clr	a
4423  0976 a200          	sbc	a,#0
4424  0978 b702          	ld	c_lreg+2,a
4425  097a b701          	ld	c_lreg+1,a
4426  097c b700          	ld	c_lreg,a
4427  097e 96            	ldw	x,sp
4428  097f 1c000b        	addw	x,#OFST-3
4429  0982 cd0000        	call	c_rtol
4431                     ; 689 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4433  0985 9c            	rvf
4434  0986 ce000e        	ldw	x,_ee_tsign
4435  0989 cd0000        	call	c_itolx
4437  098c a61e          	ld	a,#30
4438  098e cd0000        	call	c_lsbc
4440  0991 96            	ldw	x,sp
4441  0992 1c000b        	addw	x,#OFST-3
4442  0995 cd0000        	call	c_lcmp
4444  0998 2f07          	jrslt	L1132
4447  099a ae0190        	ldw	x,#400
4448  099d 1f09          	ldw	(OFST-5,sp),x
4450  099f 2030          	jra	L3132
4451  09a1               L1132:
4452                     ; 690 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4454  09a1 9c            	rvf
4455  09a2 ce000e        	ldw	x,_ee_tsign
4456  09a5 cd0000        	call	c_itolx
4458  09a8 96            	ldw	x,sp
4459  09a9 1c000b        	addw	x,#OFST-3
4460  09ac cd0000        	call	c_lcmp
4462  09af 2c07          	jrsgt	L5132
4465  09b1 ae03e8        	ldw	x,#1000
4466  09b4 1f09          	ldw	(OFST-5,sp),x
4468  09b6 2019          	jra	L3132
4469  09b8               L5132:
4470                     ; 691 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4472  09b8 ce000e        	ldw	x,_ee_tsign
4473  09bb 1d001e        	subw	x,#30
4474  09be 1f03          	ldw	(OFST-11,sp),x
4475  09c0 1e0d          	ldw	x,(OFST-1,sp)
4476  09c2 72f003        	subw	x,(OFST-11,sp)
4477  09c5 90ae0014      	ldw	y,#20
4478  09c9 cd0000        	call	c_imul
4480  09cc 1c0190        	addw	x,#400
4481  09cf 1f09          	ldw	(OFST-5,sp),x
4482  09d1               L3132:
4483                     ; 692 	gran(&vent_pwm_t_necc,400,1000);
4485  09d1 ae03e8        	ldw	x,#1000
4486  09d4 89            	pushw	x
4487  09d5 ae0190        	ldw	x,#400
4488  09d8 89            	pushw	x
4489  09d9 96            	ldw	x,sp
4490  09da 1c000d        	addw	x,#OFST-1
4491  09dd cd006d        	call	_gran
4493  09e0 5b04          	addw	sp,#4
4494                     ; 694 	vent_pwm_max_necc=vent_pwm_i_necc;
4496  09e2 1e07          	ldw	x,(OFST-7,sp)
4497  09e4 1f05          	ldw	(OFST-9,sp),x
4498                     ; 695 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4500  09e6 9c            	rvf
4501  09e7 1e09          	ldw	x,(OFST-5,sp)
4502  09e9 1307          	cpw	x,(OFST-7,sp)
4503  09eb 2d04          	jrsle	L1232
4506  09ed 1e09          	ldw	x,(OFST-5,sp)
4507  09ef 1f05          	ldw	(OFST-9,sp),x
4508  09f1               L1232:
4509                     ; 697 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4511  09f1 9c            	rvf
4512  09f2 be05          	ldw	x,_vent_pwm
4513  09f4 1305          	cpw	x,(OFST-9,sp)
4514  09f6 2e07          	jrsge	L3232
4517  09f8 be05          	ldw	x,_vent_pwm
4518  09fa 1c000a        	addw	x,#10
4519  09fd bf05          	ldw	_vent_pwm,x
4520  09ff               L3232:
4521                     ; 698 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4523  09ff 9c            	rvf
4524  0a00 be05          	ldw	x,_vent_pwm
4525  0a02 1305          	cpw	x,(OFST-9,sp)
4526  0a04 2d07          	jrsle	L5232
4529  0a06 be05          	ldw	x,_vent_pwm
4530  0a08 1d000a        	subw	x,#10
4531  0a0b bf05          	ldw	_vent_pwm,x
4532  0a0d               L5232:
4533                     ; 699 	gran(&vent_pwm,400,1000);
4535  0a0d ae03e8        	ldw	x,#1000
4536  0a10 89            	pushw	x
4537  0a11 ae0190        	ldw	x,#400
4538  0a14 89            	pushw	x
4539  0a15 ae0005        	ldw	x,#_vent_pwm
4540  0a18 cd006d        	call	_gran
4542  0a1b 5b04          	addw	sp,#4
4543                     ; 703 	if(bVENT_BLOCK)vent_pwm=0;
4545  0a1d 3d00          	tnz	_bVENT_BLOCK
4546  0a1f 2703          	jreq	L7232
4549  0a21 5f            	clrw	x
4550  0a22 bf05          	ldw	_vent_pwm,x
4551  0a24               L7232:
4552                     ; 704 }
4555  0a24 5b0e          	addw	sp,#14
4556  0a26 81            	ret
4591                     ; 709 void pwr_drv(void)
4591                     ; 710 {
4592                     	switch	.text
4593  0a27               _pwr_drv:
4597                     ; 714 BLOCK_INIT
4599  0a27 72145007      	bset	20487,#2
4602  0a2b 72145008      	bset	20488,#2
4605  0a2f 72155009      	bres	20489,#2
4606                     ; 716 if(main_cnt1<1500)main_cnt1++;
4608  0a33 9c            	rvf
4609  0a34 be4f          	ldw	x,_main_cnt1
4610  0a36 a305dc        	cpw	x,#1500
4611  0a39 2e07          	jrsge	L1432
4614  0a3b be4f          	ldw	x,_main_cnt1
4615  0a3d 1c0001        	addw	x,#1
4616  0a40 bf4f          	ldw	_main_cnt1,x
4617  0a42               L1432:
4618                     ; 723 if((ee_DEVICE))
4620  0a42 ce0004        	ldw	x,_ee_DEVICE
4621  0a45 2727          	jreq	L3432
4622                     ; 725 	if(bBL)
4624                     	btst	_bBL
4625  0a4c 240c          	jruge	L5432
4626                     ; 727 		BLOCK_ON
4628  0a4e 72145005      	bset	20485,#2
4631  0a52 35010000      	mov	_bVENT_BLOCK,#1
4633  0a56 ac2c0b2c      	jpf	L3532
4634  0a5a               L5432:
4635                     ; 729 	else if(!bBL)
4637                     	btst	_bBL
4638  0a5f 2403          	jruge	L26
4639  0a61 cc0b2c        	jp	L3532
4640  0a64               L26:
4641                     ; 731 		BLOCK_OFF
4643  0a64 72155005      	bres	20485,#2
4646  0a68 3f00          	clr	_bVENT_BLOCK
4647  0a6a ac2c0b2c      	jpf	L3532
4648  0a6e               L3432:
4649                     ; 734 else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4651  0a6e 9c            	rvf
4652  0a6f ce0016        	ldw	x,_ee_TZAS
4653  0a72 90ae0005      	ldw	y,#5
4654  0a76 cd0000        	call	c_imul
4656  0a79 b34f          	cpw	x,_main_cnt1
4657  0a7b 2d12          	jrsle	L5532
4659  0a7d b604          	ld	a,_bps_class
4660  0a7f a101          	cp	a,#1
4661  0a81 270c          	jreq	L5532
4662                     ; 736 	BLOCK_ON
4664  0a83 72145005      	bset	20485,#2
4667  0a87 35010000      	mov	_bVENT_BLOCK,#1
4669  0a8b ac2c0b2c      	jpf	L3532
4670  0a8f               L5532:
4671                     ; 739 else if(bps_class==bpsIPS)
4673  0a8f b604          	ld	a,_bps_class
4674  0a91 a101          	cp	a,#1
4675  0a93 2621          	jrne	L1632
4676                     ; 742 		if(bBL_IPS)
4678                     	btst	_bBL_IPS
4679  0a9a 240b          	jruge	L3632
4680                     ; 744 			 BLOCK_ON
4682  0a9c 72145005      	bset	20485,#2
4685  0aa0 35010000      	mov	_bVENT_BLOCK,#1
4687  0aa4 cc0b2c        	jra	L3532
4688  0aa7               L3632:
4689                     ; 747 		else if(!bBL_IPS)
4691                     	btst	_bBL_IPS
4692  0aac 257e          	jrult	L3532
4693                     ; 749 			  BLOCK_OFF
4695  0aae 72155005      	bres	20485,#2
4698  0ab2 3f00          	clr	_bVENT_BLOCK
4699  0ab4 2076          	jra	L3532
4700  0ab6               L1632:
4701                     ; 753 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4703  0ab6 9c            	rvf
4704  0ab7 ce0016        	ldw	x,_ee_TZAS
4705  0aba 90ae0005      	ldw	y,#5
4706  0abe cd0000        	call	c_imul
4708  0ac1 b34f          	cpw	x,_main_cnt1
4709  0ac3 2e49          	jrsge	L3732
4711  0ac5 9c            	rvf
4712  0ac6 ce0016        	ldw	x,_ee_TZAS
4713  0ac9 90ae0005      	ldw	y,#5
4714  0acd cd0000        	call	c_imul
4716  0ad0 1c0046        	addw	x,#70
4717  0ad3 b34f          	cpw	x,_main_cnt1
4718  0ad5 2d37          	jrsle	L3732
4719                     ; 755 	if(bps_class==bpsIPS)
4721  0ad7 b604          	ld	a,_bps_class
4722  0ad9 a101          	cp	a,#1
4723  0adb 2608          	jrne	L5732
4724                     ; 757 		  BLOCK_OFF
4726  0add 72155005      	bres	20485,#2
4729  0ae1 3f00          	clr	_bVENT_BLOCK
4731  0ae3 2047          	jra	L3532
4732  0ae5               L5732:
4733                     ; 760 	else if(bps_class==bpsIBEP)
4735  0ae5 3d04          	tnz	_bps_class
4736  0ae7 2643          	jrne	L3532
4737                     ; 762 		if(ee_DEVICE)
4739  0ae9 ce0004        	ldw	x,_ee_DEVICE
4740  0aec 2718          	jreq	L3042
4741                     ; 764 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4743  0aee b60b          	ld	a,_flags
4744  0af0 a520          	bcp	a,#32
4745  0af2 270a          	jreq	L5042
4748  0af4 72145005      	bset	20485,#2
4751  0af8 35010000      	mov	_bVENT_BLOCK,#1
4753  0afc 202e          	jra	L3532
4754  0afe               L5042:
4755                     ; 765 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4757  0afe 72155005      	bres	20485,#2
4760  0b02 3f00          	clr	_bVENT_BLOCK
4761  0b04 2026          	jra	L3532
4762  0b06               L3042:
4763                     ; 769 			BLOCK_OFF
4765  0b06 72155005      	bres	20485,#2
4768  0b0a 3f00          	clr	_bVENT_BLOCK
4769  0b0c 201e          	jra	L3532
4770  0b0e               L3732:
4771                     ; 774 else if(bBL)
4773                     	btst	_bBL
4774  0b13 240a          	jruge	L5142
4775                     ; 776 	BLOCK_ON
4777  0b15 72145005      	bset	20485,#2
4780  0b19 35010000      	mov	_bVENT_BLOCK,#1
4782  0b1d 200d          	jra	L3532
4783  0b1f               L5142:
4784                     ; 779 else if(!bBL)
4786                     	btst	_bBL
4787  0b24 2506          	jrult	L3532
4788                     ; 781 	BLOCK_OFF
4790  0b26 72155005      	bres	20485,#2
4793  0b2a 3f00          	clr	_bVENT_BLOCK
4794  0b2c               L3532:
4795                     ; 785 gran(&pwm_u,2,1020);
4797  0b2c ae03fc        	ldw	x,#1020
4798  0b2f 89            	pushw	x
4799  0b30 ae0002        	ldw	x,#2
4800  0b33 89            	pushw	x
4801  0b34 ae000e        	ldw	x,#_pwm_u
4802  0b37 cd006d        	call	_gran
4804  0b3a 5b04          	addw	sp,#4
4805                     ; 786 gran(&pwm_i,2,1020);
4807  0b3c ae03fc        	ldw	x,#1020
4808  0b3f 89            	pushw	x
4809  0b40 ae0002        	ldw	x,#2
4810  0b43 89            	pushw	x
4811  0b44 ae0010        	ldw	x,#_pwm_i
4812  0b47 cd006d        	call	_gran
4814  0b4a 5b04          	addw	sp,#4
4815                     ; 788 if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
4817  0b4c ce0004        	ldw	x,_ee_DEVICE
4818  0b4f 2617          	jrne	L3242
4820  0b51 9c            	rvf
4821  0b52 ce0016        	ldw	x,_ee_TZAS
4822  0b55 90ae0005      	ldw	y,#5
4823  0b59 cd0000        	call	c_imul
4825  0b5c 1c0032        	addw	x,#50
4826  0b5f b34f          	cpw	x,_main_cnt1
4827  0b61 2d05          	jrsle	L3242
4830  0b63 ae000a        	ldw	x,#10
4831  0b66 bf0e          	ldw	_pwm_u,x
4832  0b68               L3242:
4833                     ; 798 TIM1->CCR2H= (char)(pwm_u/256);	
4835  0b68 be0e          	ldw	x,_pwm_u
4836  0b6a 90ae0100      	ldw	y,#256
4837  0b6e cd0000        	call	c_idiv
4839  0b71 9f            	ld	a,xl
4840  0b72 c75267        	ld	21095,a
4841                     ; 799 TIM1->CCR2L= (char)pwm_u;
4843  0b75 55000f5268    	mov	21096,_pwm_u+1
4844                     ; 801 TIM1->CCR1H= (char)(pwm_i/256);	
4846  0b7a be10          	ldw	x,_pwm_i
4847  0b7c 90ae0100      	ldw	y,#256
4848  0b80 cd0000        	call	c_idiv
4850  0b83 9f            	ld	a,xl
4851  0b84 c75265        	ld	21093,a
4852                     ; 802 TIM1->CCR1L= (char)pwm_i;
4854  0b87 5500115266    	mov	21094,_pwm_i+1
4855                     ; 804 TIM1->CCR3H= (char)(vent_pwm/256);	
4857  0b8c be05          	ldw	x,_vent_pwm
4858  0b8e 90ae0100      	ldw	y,#256
4859  0b92 cd0000        	call	c_idiv
4861  0b95 9f            	ld	a,xl
4862  0b96 c75269        	ld	21097,a
4863                     ; 805 TIM1->CCR3L= (char)vent_pwm;
4865  0b99 550006526a    	mov	21098,_vent_pwm+1
4866                     ; 806 }
4869  0b9e 81            	ret
4908                     ; 811 void pwr_hndl(void)				
4908                     ; 812 {
4909                     	switch	.text
4910  0b9f               _pwr_hndl:
4914                     ; 813 if(jp_mode==jp3)
4916  0b9f b64a          	ld	a,_jp_mode
4917  0ba1 a103          	cp	a,#3
4918  0ba3 2646          	jrne	L5342
4919                     ; 815 	if((flags&0b00001010)==0)
4921  0ba5 b60b          	ld	a,_flags
4922  0ba7 a50a          	bcp	a,#10
4923  0ba9 2629          	jrne	L7342
4924                     ; 817 		pwm_u=500;
4926  0bab ae01f4        	ldw	x,#500
4927  0bae bf0e          	ldw	_pwm_u,x
4928                     ; 818 		if(pwm_i<1020)
4930  0bb0 9c            	rvf
4931  0bb1 be10          	ldw	x,_pwm_i
4932  0bb3 a303fc        	cpw	x,#1020
4933  0bb6 2e14          	jrsge	L1442
4934                     ; 820 			pwm_i+=30;
4936  0bb8 be10          	ldw	x,_pwm_i
4937  0bba 1c001e        	addw	x,#30
4938  0bbd bf10          	ldw	_pwm_i,x
4939                     ; 821 			if(pwm_i>1020)pwm_i=1020;
4941  0bbf 9c            	rvf
4942  0bc0 be10          	ldw	x,_pwm_i
4943  0bc2 a303fd        	cpw	x,#1021
4944  0bc5 2f05          	jrslt	L1442
4947  0bc7 ae03fc        	ldw	x,#1020
4948  0bca bf10          	ldw	_pwm_i,x
4949  0bcc               L1442:
4950                     ; 823 		bBL=0;
4952  0bcc 72110000      	bres	_bBL
4954  0bd0 ac9b0d9b      	jpf	L1542
4955  0bd4               L7342:
4956                     ; 825 	else if(flags&0b00001010)
4958  0bd4 b60b          	ld	a,_flags
4959  0bd6 a50a          	bcp	a,#10
4960  0bd8 2603          	jrne	L66
4961  0bda cc0d9b        	jp	L1542
4962  0bdd               L66:
4963                     ; 827 		pwm_u=0;
4965  0bdd 5f            	clrw	x
4966  0bde bf0e          	ldw	_pwm_u,x
4967                     ; 828 		pwm_i=0;
4969  0be0 5f            	clrw	x
4970  0be1 bf10          	ldw	_pwm_i,x
4971                     ; 829 		bBL=1;
4973  0be3 72100000      	bset	_bBL
4974  0be7 ac9b0d9b      	jpf	L1542
4975  0beb               L5342:
4976                     ; 833 else if(jp_mode==jp2)
4978  0beb b64a          	ld	a,_jp_mode
4979  0bed a102          	cp	a,#2
4980  0bef 2627          	jrne	L3542
4981                     ; 835 	pwm_u=0;
4983  0bf1 5f            	clrw	x
4984  0bf2 bf0e          	ldw	_pwm_u,x
4985                     ; 837 	if(pwm_i<1020)
4987  0bf4 9c            	rvf
4988  0bf5 be10          	ldw	x,_pwm_i
4989  0bf7 a303fc        	cpw	x,#1020
4990  0bfa 2e14          	jrsge	L5542
4991                     ; 839 		pwm_i+=30;
4993  0bfc be10          	ldw	x,_pwm_i
4994  0bfe 1c001e        	addw	x,#30
4995  0c01 bf10          	ldw	_pwm_i,x
4996                     ; 840 		if(pwm_i>1020)pwm_i=1020;
4998  0c03 9c            	rvf
4999  0c04 be10          	ldw	x,_pwm_i
5000  0c06 a303fd        	cpw	x,#1021
5001  0c09 2f05          	jrslt	L5542
5004  0c0b ae03fc        	ldw	x,#1020
5005  0c0e bf10          	ldw	_pwm_i,x
5006  0c10               L5542:
5007                     ; 842 	bBL=0;
5009  0c10 72110000      	bres	_bBL
5011  0c14 ac9b0d9b      	jpf	L1542
5012  0c18               L3542:
5013                     ; 844 else if(jp_mode==jp1)
5015  0c18 b64a          	ld	a,_jp_mode
5016  0c1a a101          	cp	a,#1
5017  0c1c 2629          	jrne	L3642
5018                     ; 846 	pwm_u=0x3ff;
5020  0c1e ae03ff        	ldw	x,#1023
5021  0c21 bf0e          	ldw	_pwm_u,x
5022                     ; 848 	if(pwm_i<1020)
5024  0c23 9c            	rvf
5025  0c24 be10          	ldw	x,_pwm_i
5026  0c26 a303fc        	cpw	x,#1020
5027  0c29 2e14          	jrsge	L5642
5028                     ; 850 		pwm_i+=30;
5030  0c2b be10          	ldw	x,_pwm_i
5031  0c2d 1c001e        	addw	x,#30
5032  0c30 bf10          	ldw	_pwm_i,x
5033                     ; 851 		if(pwm_i>1020)pwm_i=1020;
5035  0c32 9c            	rvf
5036  0c33 be10          	ldw	x,_pwm_i
5037  0c35 a303fd        	cpw	x,#1021
5038  0c38 2f05          	jrslt	L5642
5041  0c3a ae03fc        	ldw	x,#1020
5042  0c3d bf10          	ldw	_pwm_i,x
5043  0c3f               L5642:
5044                     ; 853 	bBL=0;
5046  0c3f 72110000      	bres	_bBL
5048  0c43 ac9b0d9b      	jpf	L1542
5049  0c47               L3642:
5050                     ; 856 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
5052                     	btst	_bMAIN
5053  0c4c 242e          	jruge	L3742
5055  0c4e b663          	ld	a,_link
5056  0c50 a155          	cp	a,#85
5057  0c52 2628          	jrne	L3742
5058                     ; 858 	pwm_u=volum_u_main_;
5060  0c54 be1f          	ldw	x,_volum_u_main_
5061  0c56 bf0e          	ldw	_pwm_u,x
5062                     ; 860 	if(pwm_i<1020)
5064  0c58 9c            	rvf
5065  0c59 be10          	ldw	x,_pwm_i
5066  0c5b a303fc        	cpw	x,#1020
5067  0c5e 2e14          	jrsge	L5742
5068                     ; 862 		pwm_i+=30;
5070  0c60 be10          	ldw	x,_pwm_i
5071  0c62 1c001e        	addw	x,#30
5072  0c65 bf10          	ldw	_pwm_i,x
5073                     ; 863 		if(pwm_i>1020)pwm_i=1020;
5075  0c67 9c            	rvf
5076  0c68 be10          	ldw	x,_pwm_i
5077  0c6a a303fd        	cpw	x,#1021
5078  0c6d 2f05          	jrslt	L5742
5081  0c6f ae03fc        	ldw	x,#1020
5082  0c72 bf10          	ldw	_pwm_i,x
5083  0c74               L5742:
5084                     ; 865 	bBL_IPS=0;
5086  0c74 72110001      	bres	_bBL_IPS
5088  0c78 ac9b0d9b      	jpf	L1542
5089  0c7c               L3742:
5090                     ; 868 else if(link==OFF)
5092  0c7c b663          	ld	a,_link
5093  0c7e a1aa          	cp	a,#170
5094  0c80 266f          	jrne	L3052
5095                     ; 877  	if(ee_DEVICE)
5097  0c82 ce0004        	ldw	x,_ee_DEVICE
5098  0c85 270e          	jreq	L5052
5099                     ; 879 		pwm_u=0x00;
5101  0c87 5f            	clrw	x
5102  0c88 bf0e          	ldw	_pwm_u,x
5103                     ; 880 		pwm_i=0x00;
5105  0c8a 5f            	clrw	x
5106  0c8b bf10          	ldw	_pwm_i,x
5107                     ; 881 		bBL=1;
5109  0c8d 72100000      	bset	_bBL
5111  0c91 ac9b0d9b      	jpf	L1542
5112  0c95               L5052:
5113                     ; 885 		if((flags&0b00011010)==0)
5115  0c95 b60b          	ld	a,_flags
5116  0c97 a51a          	bcp	a,#26
5117  0c99 263b          	jrne	L1152
5118                     ; 887 			pwm_u=ee_U_AVT;
5120  0c9b ce000c        	ldw	x,_ee_U_AVT
5121  0c9e bf0e          	ldw	_pwm_u,x
5122                     ; 888 			gran(&pwm_u,0,1020);
5124  0ca0 ae03fc        	ldw	x,#1020
5125  0ca3 89            	pushw	x
5126  0ca4 5f            	clrw	x
5127  0ca5 89            	pushw	x
5128  0ca6 ae000e        	ldw	x,#_pwm_u
5129  0ca9 cd006d        	call	_gran
5131  0cac 5b04          	addw	sp,#4
5132                     ; 890 			if(pwm_i<1020)
5134  0cae 9c            	rvf
5135  0caf be10          	ldw	x,_pwm_i
5136  0cb1 a303fc        	cpw	x,#1020
5137  0cb4 2e14          	jrsge	L3152
5138                     ; 892 				pwm_i+=30;
5140  0cb6 be10          	ldw	x,_pwm_i
5141  0cb8 1c001e        	addw	x,#30
5142  0cbb bf10          	ldw	_pwm_i,x
5143                     ; 893 				if(pwm_i>1020)pwm_i=1020;
5145  0cbd 9c            	rvf
5146  0cbe be10          	ldw	x,_pwm_i
5147  0cc0 a303fd        	cpw	x,#1021
5148  0cc3 2f05          	jrslt	L3152
5151  0cc5 ae03fc        	ldw	x,#1020
5152  0cc8 bf10          	ldw	_pwm_i,x
5153  0cca               L3152:
5154                     ; 895 			bBL=0;
5156  0cca 72110000      	bres	_bBL
5157                     ; 896 			bBL_IPS=0;
5159  0cce 72110001      	bres	_bBL_IPS
5161  0cd2 ac9b0d9b      	jpf	L1542
5162  0cd6               L1152:
5163                     ; 898 		else if(flags&0b00011010)
5165  0cd6 b60b          	ld	a,_flags
5166  0cd8 a51a          	bcp	a,#26
5167  0cda 2603          	jrne	L07
5168  0cdc cc0d9b        	jp	L1542
5169  0cdf               L07:
5170                     ; 900 			pwm_u=0;
5172  0cdf 5f            	clrw	x
5173  0ce0 bf0e          	ldw	_pwm_u,x
5174                     ; 901 			pwm_i=0;
5176  0ce2 5f            	clrw	x
5177  0ce3 bf10          	ldw	_pwm_i,x
5178                     ; 902 			bBL=1;
5180  0ce5 72100000      	bset	_bBL
5181                     ; 903 			bBL_IPS=1;
5183  0ce9 72100001      	bset	_bBL_IPS
5184  0ced ac9b0d9b      	jpf	L1542
5185  0cf1               L3052:
5186                     ; 912 else	if(link==ON)				//если есть связьvol_i_temp_avar
5188  0cf1 b663          	ld	a,_link
5189  0cf3 a155          	cp	a,#85
5190  0cf5 2703          	jreq	L27
5191  0cf7 cc0d9b        	jp	L1542
5192  0cfa               L27:
5193                     ; 914 	if((flags&0b00100000)==0)	//если нет блокировки извне
5195  0cfa b60b          	ld	a,_flags
5196  0cfc a520          	bcp	a,#32
5197  0cfe 2703cc0d8b    	jrne	L7252
5198                     ; 916 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
5200  0d03 b60b          	ld	a,_flags
5201  0d05 a41e          	and	a,#30
5202  0d07 a104          	cp	a,#4
5203  0d09 2630          	jrne	L1352
5204                     ; 918 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5206  0d0b be5e          	ldw	x,__x_
5207  0d0d 72bb0058      	addw	x,_vol_u_temp
5208  0d11 bf0e          	ldw	_pwm_u,x
5209                     ; 919 			if(!ee_DEVICE)
5211  0d13 ce0004        	ldw	x,_ee_DEVICE
5212  0d16 261b          	jrne	L3352
5213                     ; 921 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
5215  0d18 be10          	ldw	x,_pwm_i
5216  0d1a b30c          	cpw	x,_vol_i_temp_avar
5217  0d1c 240f          	jruge	L5352
5220  0d1e be0c          	ldw	x,_vol_i_temp_avar
5221  0d20 90ae001e      	ldw	y,#30
5222  0d24 65            	divw	x,y
5223  0d25 72bb0010      	addw	x,_pwm_i
5224  0d29 bf10          	ldw	_pwm_i,x
5226  0d2b 200a          	jra	L1452
5227  0d2d               L5352:
5228                     ; 922 				else	pwm_i=vol_i_temp_avar;
5230  0d2d be0c          	ldw	x,_vol_i_temp_avar
5231  0d2f bf10          	ldw	_pwm_i,x
5232  0d31 2004          	jra	L1452
5233  0d33               L3352:
5234                     ; 924 			else pwm_i=vol_i_temp_avar;
5236  0d33 be0c          	ldw	x,_vol_i_temp_avar
5237  0d35 bf10          	ldw	_pwm_i,x
5238  0d37               L1452:
5239                     ; 926 			bBL=0;
5241  0d37 72110000      	bres	_bBL
5242  0d3b               L1352:
5243                     ; 928 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5245  0d3b b60b          	ld	a,_flags
5246  0d3d a51a          	bcp	a,#26
5247  0d3f 2706          	jreq	L5452
5249  0d41 b60b          	ld	a,_flags
5250  0d43 a540          	bcp	a,#64
5251  0d45 2732          	jreq	L3452
5252  0d47               L5452:
5253                     ; 930 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5255  0d47 be5e          	ldw	x,__x_
5256  0d49 72bb0058      	addw	x,_vol_u_temp
5257  0d4d bf0e          	ldw	_pwm_u,x
5258                     ; 932 			if(!ee_DEVICE)
5260  0d4f ce0004        	ldw	x,_ee_DEVICE
5261  0d52 261b          	jrne	L7452
5262                     ; 934 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
5264  0d54 be10          	ldw	x,_pwm_i
5265  0d56 b356          	cpw	x,_vol_i_temp
5266  0d58 240f          	jruge	L1552
5269  0d5a be56          	ldw	x,_vol_i_temp
5270  0d5c 90ae001e      	ldw	y,#30
5271  0d60 65            	divw	x,y
5272  0d61 72bb0010      	addw	x,_pwm_i
5273  0d65 bf10          	ldw	_pwm_i,x
5275  0d67 200a          	jra	L5552
5276  0d69               L1552:
5277                     ; 935 				else	pwm_i=vol_i_temp;
5279  0d69 be56          	ldw	x,_vol_i_temp
5280  0d6b bf10          	ldw	_pwm_i,x
5281  0d6d 2004          	jra	L5552
5282  0d6f               L7452:
5283                     ; 937 			else pwm_i=vol_i_temp;			
5285  0d6f be56          	ldw	x,_vol_i_temp
5286  0d71 bf10          	ldw	_pwm_i,x
5287  0d73               L5552:
5288                     ; 938 			bBL=0;
5290  0d73 72110000      	bres	_bBL
5292  0d77 2022          	jra	L1542
5293  0d79               L3452:
5294                     ; 940 		else if(flags&0b00011010)					//если есть аварии
5296  0d79 b60b          	ld	a,_flags
5297  0d7b a51a          	bcp	a,#26
5298  0d7d 271c          	jreq	L1542
5299                     ; 942 			pwm_u=0;								//то полный стоп
5301  0d7f 5f            	clrw	x
5302  0d80 bf0e          	ldw	_pwm_u,x
5303                     ; 943 			pwm_i=0;
5305  0d82 5f            	clrw	x
5306  0d83 bf10          	ldw	_pwm_i,x
5307                     ; 944 			bBL=1;
5309  0d85 72100000      	bset	_bBL
5310  0d89 2010          	jra	L1542
5311  0d8b               L7252:
5312                     ; 947 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5314  0d8b b60b          	ld	a,_flags
5315  0d8d a520          	bcp	a,#32
5316  0d8f 270a          	jreq	L1542
5317                     ; 949 		pwm_u=0;
5319  0d91 5f            	clrw	x
5320  0d92 bf0e          	ldw	_pwm_u,x
5321                     ; 950 	    	pwm_i=0;
5323  0d94 5f            	clrw	x
5324  0d95 bf10          	ldw	_pwm_i,x
5325                     ; 951 		bBL=1;
5327  0d97 72100000      	bset	_bBL
5328  0d9b               L1542:
5329                     ; 957 }
5332  0d9b 81            	ret
5377                     	switch	.const
5378  000c               L67:
5379  000c 00000258      	dc.l	600
5380  0010               L001:
5381  0010 000003e8      	dc.l	1000
5382                     ; 960 void matemat(void)
5382                     ; 961 {
5383                     	switch	.text
5384  0d9c               _matemat:
5386  0d9c 5208          	subw	sp,#8
5387       00000008      OFST:	set	8
5390                     ; 982 temp_SL=adc_buff_[4];
5392  0d9e ce0011        	ldw	x,_adc_buff_+8
5393  0da1 cd0000        	call	c_itolx
5395  0da4 96            	ldw	x,sp
5396  0da5 1c0005        	addw	x,#OFST-3
5397  0da8 cd0000        	call	c_rtol
5399                     ; 983 temp_SL-=ee_K[0][0];
5401  0dab ce001a        	ldw	x,_ee_K
5402  0dae cd0000        	call	c_itolx
5404  0db1 96            	ldw	x,sp
5405  0db2 1c0005        	addw	x,#OFST-3
5406  0db5 cd0000        	call	c_lgsub
5408                     ; 984 if(temp_SL<0) temp_SL=0;
5410  0db8 9c            	rvf
5411  0db9 0d05          	tnz	(OFST-3,sp)
5412  0dbb 2e0a          	jrsge	L5062
5415  0dbd ae0000        	ldw	x,#0
5416  0dc0 1f07          	ldw	(OFST-1,sp),x
5417  0dc2 ae0000        	ldw	x,#0
5418  0dc5 1f05          	ldw	(OFST-3,sp),x
5419  0dc7               L5062:
5420                     ; 985 temp_SL*=ee_K[0][1];
5422  0dc7 ce001c        	ldw	x,_ee_K+2
5423  0dca cd0000        	call	c_itolx
5425  0dcd 96            	ldw	x,sp
5426  0dce 1c0005        	addw	x,#OFST-3
5427  0dd1 cd0000        	call	c_lgmul
5429                     ; 986 temp_SL/=600;
5431  0dd4 96            	ldw	x,sp
5432  0dd5 1c0005        	addw	x,#OFST-3
5433  0dd8 cd0000        	call	c_ltor
5435  0ddb ae000c        	ldw	x,#L67
5436  0dde cd0000        	call	c_ldiv
5438  0de1 96            	ldw	x,sp
5439  0de2 1c0005        	addw	x,#OFST-3
5440  0de5 cd0000        	call	c_rtol
5442                     ; 987 I=(signed short)temp_SL;
5444  0de8 1e07          	ldw	x,(OFST-1,sp)
5445  0dea bf6f          	ldw	_I,x
5446                     ; 992 temp_SL=(signed long)adc_buff_[1];
5448  0dec ce000b        	ldw	x,_adc_buff_+2
5449  0def cd0000        	call	c_itolx
5451  0df2 96            	ldw	x,sp
5452  0df3 1c0005        	addw	x,#OFST-3
5453  0df6 cd0000        	call	c_rtol
5455                     ; 994 if(temp_SL<0) temp_SL=0;
5457  0df9 9c            	rvf
5458  0dfa 0d05          	tnz	(OFST-3,sp)
5459  0dfc 2e0a          	jrsge	L7062
5462  0dfe ae0000        	ldw	x,#0
5463  0e01 1f07          	ldw	(OFST-1,sp),x
5464  0e03 ae0000        	ldw	x,#0
5465  0e06 1f05          	ldw	(OFST-3,sp),x
5466  0e08               L7062:
5467                     ; 995 temp_SL*=(signed long)ee_K[2][1];
5469  0e08 ce0024        	ldw	x,_ee_K+10
5470  0e0b cd0000        	call	c_itolx
5472  0e0e 96            	ldw	x,sp
5473  0e0f 1c0005        	addw	x,#OFST-3
5474  0e12 cd0000        	call	c_lgmul
5476                     ; 996 temp_SL/=1000L;
5478  0e15 96            	ldw	x,sp
5479  0e16 1c0005        	addw	x,#OFST-3
5480  0e19 cd0000        	call	c_ltor
5482  0e1c ae0010        	ldw	x,#L001
5483  0e1f cd0000        	call	c_ldiv
5485  0e22 96            	ldw	x,sp
5486  0e23 1c0005        	addw	x,#OFST-3
5487  0e26 cd0000        	call	c_rtol
5489                     ; 997 Ui=(unsigned short)temp_SL;
5491  0e29 1e07          	ldw	x,(OFST-1,sp)
5492  0e2b bf6b          	ldw	_Ui,x
5493                     ; 1004 temp_SL=adc_buff_[3];
5495  0e2d ce000f        	ldw	x,_adc_buff_+6
5496  0e30 cd0000        	call	c_itolx
5498  0e33 96            	ldw	x,sp
5499  0e34 1c0005        	addw	x,#OFST-3
5500  0e37 cd0000        	call	c_rtol
5502                     ; 1006 if(temp_SL<0) temp_SL=0;
5504  0e3a 9c            	rvf
5505  0e3b 0d05          	tnz	(OFST-3,sp)
5506  0e3d 2e0a          	jrsge	L1162
5509  0e3f ae0000        	ldw	x,#0
5510  0e42 1f07          	ldw	(OFST-1,sp),x
5511  0e44 ae0000        	ldw	x,#0
5512  0e47 1f05          	ldw	(OFST-3,sp),x
5513  0e49               L1162:
5514                     ; 1007 temp_SL*=ee_K[1][1];
5516  0e49 ce0020        	ldw	x,_ee_K+6
5517  0e4c cd0000        	call	c_itolx
5519  0e4f 96            	ldw	x,sp
5520  0e50 1c0005        	addw	x,#OFST-3
5521  0e53 cd0000        	call	c_lgmul
5523                     ; 1008 temp_SL/=1000;
5525  0e56 96            	ldw	x,sp
5526  0e57 1c0005        	addw	x,#OFST-3
5527  0e5a cd0000        	call	c_ltor
5529  0e5d ae0010        	ldw	x,#L001
5530  0e60 cd0000        	call	c_ldiv
5532  0e63 96            	ldw	x,sp
5533  0e64 1c0005        	addw	x,#OFST-3
5534  0e67 cd0000        	call	c_rtol
5536                     ; 1009 Un=(unsigned short)temp_SL;
5538  0e6a 1e07          	ldw	x,(OFST-1,sp)
5539  0e6c bf6d          	ldw	_Un,x
5540                     ; 1012 temp_SL=adc_buff_[2];
5542  0e6e ce000d        	ldw	x,_adc_buff_+4
5543  0e71 cd0000        	call	c_itolx
5545  0e74 96            	ldw	x,sp
5546  0e75 1c0005        	addw	x,#OFST-3
5547  0e78 cd0000        	call	c_rtol
5549                     ; 1013 temp_SL*=ee_K[3][1];
5551  0e7b ce0028        	ldw	x,_ee_K+14
5552  0e7e cd0000        	call	c_itolx
5554  0e81 96            	ldw	x,sp
5555  0e82 1c0005        	addw	x,#OFST-3
5556  0e85 cd0000        	call	c_lgmul
5558                     ; 1014 temp_SL/=1000;
5560  0e88 96            	ldw	x,sp
5561  0e89 1c0005        	addw	x,#OFST-3
5562  0e8c cd0000        	call	c_ltor
5564  0e8f ae0010        	ldw	x,#L001
5565  0e92 cd0000        	call	c_ldiv
5567  0e95 96            	ldw	x,sp
5568  0e96 1c0005        	addw	x,#OFST-3
5569  0e99 cd0000        	call	c_rtol
5571                     ; 1015 T=(signed short)(temp_SL-273L);
5573  0e9c 7b08          	ld	a,(OFST+0,sp)
5574  0e9e 5f            	clrw	x
5575  0e9f 4d            	tnz	a
5576  0ea0 2a01          	jrpl	L201
5577  0ea2 53            	cplw	x
5578  0ea3               L201:
5579  0ea3 97            	ld	xl,a
5580  0ea4 1d0111        	subw	x,#273
5581  0ea7 01            	rrwa	x,a
5582  0ea8 b768          	ld	_T,a
5583  0eaa 02            	rlwa	x,a
5584                     ; 1016 if(T<-30)T=-30;
5586  0eab 9c            	rvf
5587  0eac b668          	ld	a,_T
5588  0eae a1e2          	cp	a,#226
5589  0eb0 2e04          	jrsge	L3162
5592  0eb2 35e20068      	mov	_T,#226
5593  0eb6               L3162:
5594                     ; 1017 if(T>120)T=120;
5596  0eb6 9c            	rvf
5597  0eb7 b668          	ld	a,_T
5598  0eb9 a179          	cp	a,#121
5599  0ebb 2f04          	jrslt	L5162
5602  0ebd 35780068      	mov	_T,#120
5603  0ec1               L5162:
5604                     ; 1019 Udb=flags;
5606  0ec1 b60b          	ld	a,_flags
5607  0ec3 5f            	clrw	x
5608  0ec4 97            	ld	xl,a
5609  0ec5 bf69          	ldw	_Udb,x
5610                     ; 1025 temp_SL=(signed long)(T-ee_tsign);
5612  0ec7 5f            	clrw	x
5613  0ec8 b668          	ld	a,_T
5614  0eca 2a01          	jrpl	L401
5615  0ecc 53            	cplw	x
5616  0ecd               L401:
5617  0ecd 97            	ld	xl,a
5618  0ece 72b0000e      	subw	x,_ee_tsign
5619  0ed2 cd0000        	call	c_itolx
5621  0ed5 96            	ldw	x,sp
5622  0ed6 1c0005        	addw	x,#OFST-3
5623  0ed9 cd0000        	call	c_rtol
5625                     ; 1026 temp_SL*=1000L;
5627  0edc ae03e8        	ldw	x,#1000
5628  0edf bf02          	ldw	c_lreg+2,x
5629  0ee1 ae0000        	ldw	x,#0
5630  0ee4 bf00          	ldw	c_lreg,x
5631  0ee6 96            	ldw	x,sp
5632  0ee7 1c0005        	addw	x,#OFST-3
5633  0eea cd0000        	call	c_lgmul
5635                     ; 1027 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5637  0eed ce0010        	ldw	x,_ee_tmax
5638  0ef0 72b0000e      	subw	x,_ee_tsign
5639  0ef4 cd0000        	call	c_itolx
5641  0ef7 96            	ldw	x,sp
5642  0ef8 1c0001        	addw	x,#OFST-7
5643  0efb cd0000        	call	c_rtol
5645  0efe 96            	ldw	x,sp
5646  0eff 1c0005        	addw	x,#OFST-3
5647  0f02 cd0000        	call	c_ltor
5649  0f05 96            	ldw	x,sp
5650  0f06 1c0001        	addw	x,#OFST-7
5651  0f09 cd0000        	call	c_ldiv
5653  0f0c 96            	ldw	x,sp
5654  0f0d 1c0005        	addw	x,#OFST-3
5655  0f10 cd0000        	call	c_rtol
5657                     ; 1029 vol_i_temp_avar=(unsigned short)temp_SL; 
5659  0f13 1e07          	ldw	x,(OFST-1,sp)
5660  0f15 bf0c          	ldw	_vol_i_temp_avar,x
5661                     ; 1031 }
5664  0f17 5b08          	addw	sp,#8
5665  0f19 81            	ret
5696                     ; 1034 void temper_drv(void)		//1 Hz
5696                     ; 1035 {
5697                     	switch	.text
5698  0f1a               _temper_drv:
5702                     ; 1037 if(T>ee_tsign) tsign_cnt++;
5704  0f1a 9c            	rvf
5705  0f1b 5f            	clrw	x
5706  0f1c b668          	ld	a,_T
5707  0f1e 2a01          	jrpl	L011
5708  0f20 53            	cplw	x
5709  0f21               L011:
5710  0f21 97            	ld	xl,a
5711  0f22 c3000e        	cpw	x,_ee_tsign
5712  0f25 2d09          	jrsle	L7262
5715  0f27 be4d          	ldw	x,_tsign_cnt
5716  0f29 1c0001        	addw	x,#1
5717  0f2c bf4d          	ldw	_tsign_cnt,x
5719  0f2e 201d          	jra	L1362
5720  0f30               L7262:
5721                     ; 1038 else if (T<(ee_tsign-1)) tsign_cnt--;
5723  0f30 9c            	rvf
5724  0f31 ce000e        	ldw	x,_ee_tsign
5725  0f34 5a            	decw	x
5726  0f35 905f          	clrw	y
5727  0f37 b668          	ld	a,_T
5728  0f39 2a02          	jrpl	L211
5729  0f3b 9053          	cplw	y
5730  0f3d               L211:
5731  0f3d 9097          	ld	yl,a
5732  0f3f 90bf00        	ldw	c_y,y
5733  0f42 b300          	cpw	x,c_y
5734  0f44 2d07          	jrsle	L1362
5737  0f46 be4d          	ldw	x,_tsign_cnt
5738  0f48 1d0001        	subw	x,#1
5739  0f4b bf4d          	ldw	_tsign_cnt,x
5740  0f4d               L1362:
5741                     ; 1040 gran(&tsign_cnt,0,60);
5743  0f4d ae003c        	ldw	x,#60
5744  0f50 89            	pushw	x
5745  0f51 5f            	clrw	x
5746  0f52 89            	pushw	x
5747  0f53 ae004d        	ldw	x,#_tsign_cnt
5748  0f56 cd006d        	call	_gran
5750  0f59 5b04          	addw	sp,#4
5751                     ; 1042 if(tsign_cnt>=55)
5753  0f5b 9c            	rvf
5754  0f5c be4d          	ldw	x,_tsign_cnt
5755  0f5e a30037        	cpw	x,#55
5756  0f61 2f16          	jrslt	L5362
5757                     ; 1044 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5759  0f63 3d4a          	tnz	_jp_mode
5760  0f65 2606          	jrne	L3462
5762  0f67 b60b          	ld	a,_flags
5763  0f69 a540          	bcp	a,#64
5764  0f6b 2706          	jreq	L1462
5765  0f6d               L3462:
5767  0f6d b64a          	ld	a,_jp_mode
5768  0f6f a103          	cp	a,#3
5769  0f71 2612          	jrne	L5462
5770  0f73               L1462:
5773  0f73 7214000b      	bset	_flags,#2
5774  0f77 200c          	jra	L5462
5775  0f79               L5362:
5776                     ; 1046 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5778  0f79 9c            	rvf
5779  0f7a be4d          	ldw	x,_tsign_cnt
5780  0f7c a30006        	cpw	x,#6
5781  0f7f 2e04          	jrsge	L5462
5784  0f81 7215000b      	bres	_flags,#2
5785  0f85               L5462:
5786                     ; 1051 if(T>ee_tmax) tmax_cnt++;
5788  0f85 9c            	rvf
5789  0f86 5f            	clrw	x
5790  0f87 b668          	ld	a,_T
5791  0f89 2a01          	jrpl	L411
5792  0f8b 53            	cplw	x
5793  0f8c               L411:
5794  0f8c 97            	ld	xl,a
5795  0f8d c30010        	cpw	x,_ee_tmax
5796  0f90 2d09          	jrsle	L1562
5799  0f92 be4b          	ldw	x,_tmax_cnt
5800  0f94 1c0001        	addw	x,#1
5801  0f97 bf4b          	ldw	_tmax_cnt,x
5803  0f99 201d          	jra	L3562
5804  0f9b               L1562:
5805                     ; 1052 else if (T<(ee_tmax-1)) tmax_cnt--;
5807  0f9b 9c            	rvf
5808  0f9c ce0010        	ldw	x,_ee_tmax
5809  0f9f 5a            	decw	x
5810  0fa0 905f          	clrw	y
5811  0fa2 b668          	ld	a,_T
5812  0fa4 2a02          	jrpl	L611
5813  0fa6 9053          	cplw	y
5814  0fa8               L611:
5815  0fa8 9097          	ld	yl,a
5816  0faa 90bf00        	ldw	c_y,y
5817  0fad b300          	cpw	x,c_y
5818  0faf 2d07          	jrsle	L3562
5821  0fb1 be4b          	ldw	x,_tmax_cnt
5822  0fb3 1d0001        	subw	x,#1
5823  0fb6 bf4b          	ldw	_tmax_cnt,x
5824  0fb8               L3562:
5825                     ; 1054 gran(&tmax_cnt,0,60);
5827  0fb8 ae003c        	ldw	x,#60
5828  0fbb 89            	pushw	x
5829  0fbc 5f            	clrw	x
5830  0fbd 89            	pushw	x
5831  0fbe ae004b        	ldw	x,#_tmax_cnt
5832  0fc1 cd006d        	call	_gran
5834  0fc4 5b04          	addw	sp,#4
5835                     ; 1056 if(tmax_cnt>=55)
5837  0fc6 9c            	rvf
5838  0fc7 be4b          	ldw	x,_tmax_cnt
5839  0fc9 a30037        	cpw	x,#55
5840  0fcc 2f16          	jrslt	L7562
5841                     ; 1058 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5843  0fce 3d4a          	tnz	_jp_mode
5844  0fd0 2606          	jrne	L5662
5846  0fd2 b60b          	ld	a,_flags
5847  0fd4 a540          	bcp	a,#64
5848  0fd6 2706          	jreq	L3662
5849  0fd8               L5662:
5851  0fd8 b64a          	ld	a,_jp_mode
5852  0fda a103          	cp	a,#3
5853  0fdc 2612          	jrne	L7662
5854  0fde               L3662:
5857  0fde 7212000b      	bset	_flags,#1
5858  0fe2 200c          	jra	L7662
5859  0fe4               L7562:
5860                     ; 1060 else if (tmax_cnt<=5) flags&=0b11111101;
5862  0fe4 9c            	rvf
5863  0fe5 be4b          	ldw	x,_tmax_cnt
5864  0fe7 a30006        	cpw	x,#6
5865  0fea 2e04          	jrsge	L7662
5868  0fec 7213000b      	bres	_flags,#1
5869  0ff0               L7662:
5870                     ; 1063 } 
5873  0ff0 81            	ret
5905                     ; 1066 void u_drv(void)		//1Hz
5905                     ; 1067 { 
5906                     	switch	.text
5907  0ff1               _u_drv:
5911                     ; 1068 if(jp_mode!=jp3)
5913  0ff1 b64a          	ld	a,_jp_mode
5914  0ff3 a103          	cp	a,#3
5915  0ff5 2770          	jreq	L3072
5916                     ; 1070 	if(Ui>ee_Umax)umax_cnt++;
5918  0ff7 9c            	rvf
5919  0ff8 be6b          	ldw	x,_Ui
5920  0ffa c30014        	cpw	x,_ee_Umax
5921  0ffd 2d09          	jrsle	L5072
5924  0fff be66          	ldw	x,_umax_cnt
5925  1001 1c0001        	addw	x,#1
5926  1004 bf66          	ldw	_umax_cnt,x
5928  1006 2003          	jra	L7072
5929  1008               L5072:
5930                     ; 1071 	else umax_cnt=0;
5932  1008 5f            	clrw	x
5933  1009 bf66          	ldw	_umax_cnt,x
5934  100b               L7072:
5935                     ; 1072 	gran(&umax_cnt,0,10);
5937  100b ae000a        	ldw	x,#10
5938  100e 89            	pushw	x
5939  100f 5f            	clrw	x
5940  1010 89            	pushw	x
5941  1011 ae0066        	ldw	x,#_umax_cnt
5942  1014 cd006d        	call	_gran
5944  1017 5b04          	addw	sp,#4
5945                     ; 1073 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5947  1019 9c            	rvf
5948  101a be66          	ldw	x,_umax_cnt
5949  101c a3000a        	cpw	x,#10
5950  101f 2f04          	jrslt	L1172
5953  1021 7216000b      	bset	_flags,#3
5954  1025               L1172:
5955                     ; 1076 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5957  1025 9c            	rvf
5958  1026 be6b          	ldw	x,_Ui
5959  1028 b36d          	cpw	x,_Un
5960  102a 2e1c          	jrsge	L3172
5962  102c 9c            	rvf
5963  102d be6d          	ldw	x,_Un
5964  102f 72b0006b      	subw	x,_Ui
5965  1033 c30012        	cpw	x,_ee_dU
5966  1036 2d10          	jrsle	L3172
5968  1038 c65005        	ld	a,20485
5969  103b a504          	bcp	a,#4
5970  103d 2609          	jrne	L3172
5973  103f be64          	ldw	x,_umin_cnt
5974  1041 1c0001        	addw	x,#1
5975  1044 bf64          	ldw	_umin_cnt,x
5977  1046 2003          	jra	L5172
5978  1048               L3172:
5979                     ; 1077 	else umin_cnt=0;
5981  1048 5f            	clrw	x
5982  1049 bf64          	ldw	_umin_cnt,x
5983  104b               L5172:
5984                     ; 1078 	gran(&umin_cnt,0,10);	
5986  104b ae000a        	ldw	x,#10
5987  104e 89            	pushw	x
5988  104f 5f            	clrw	x
5989  1050 89            	pushw	x
5990  1051 ae0064        	ldw	x,#_umin_cnt
5991  1054 cd006d        	call	_gran
5993  1057 5b04          	addw	sp,#4
5994                     ; 1079 	if(umin_cnt>=10)flags|=0b00010000;	  
5996  1059 9c            	rvf
5997  105a be64          	ldw	x,_umin_cnt
5998  105c a3000a        	cpw	x,#10
5999  105f 2f6f          	jrslt	L1272
6002  1061 7218000b      	bset	_flags,#4
6003  1065 2069          	jra	L1272
6004  1067               L3072:
6005                     ; 1081 else if(jp_mode==jp3)
6007  1067 b64a          	ld	a,_jp_mode
6008  1069 a103          	cp	a,#3
6009  106b 2663          	jrne	L1272
6010                     ; 1083 	if(Ui>700)umax_cnt++;
6012  106d 9c            	rvf
6013  106e be6b          	ldw	x,_Ui
6014  1070 a302bd        	cpw	x,#701
6015  1073 2f09          	jrslt	L5272
6018  1075 be66          	ldw	x,_umax_cnt
6019  1077 1c0001        	addw	x,#1
6020  107a bf66          	ldw	_umax_cnt,x
6022  107c 2003          	jra	L7272
6023  107e               L5272:
6024                     ; 1084 	else umax_cnt=0;
6026  107e 5f            	clrw	x
6027  107f bf66          	ldw	_umax_cnt,x
6028  1081               L7272:
6029                     ; 1085 	gran(&umax_cnt,0,10);
6031  1081 ae000a        	ldw	x,#10
6032  1084 89            	pushw	x
6033  1085 5f            	clrw	x
6034  1086 89            	pushw	x
6035  1087 ae0066        	ldw	x,#_umax_cnt
6036  108a cd006d        	call	_gran
6038  108d 5b04          	addw	sp,#4
6039                     ; 1086 	if(umax_cnt>=10)flags|=0b00001000;
6041  108f 9c            	rvf
6042  1090 be66          	ldw	x,_umax_cnt
6043  1092 a3000a        	cpw	x,#10
6044  1095 2f04          	jrslt	L1372
6047  1097 7216000b      	bset	_flags,#3
6048  109b               L1372:
6049                     ; 1089 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6051  109b 9c            	rvf
6052  109c be6b          	ldw	x,_Ui
6053  109e a300c8        	cpw	x,#200
6054  10a1 2e10          	jrsge	L3372
6056  10a3 c65005        	ld	a,20485
6057  10a6 a504          	bcp	a,#4
6058  10a8 2609          	jrne	L3372
6061  10aa be64          	ldw	x,_umin_cnt
6062  10ac 1c0001        	addw	x,#1
6063  10af bf64          	ldw	_umin_cnt,x
6065  10b1 2003          	jra	L5372
6066  10b3               L3372:
6067                     ; 1090 	else umin_cnt=0;
6069  10b3 5f            	clrw	x
6070  10b4 bf64          	ldw	_umin_cnt,x
6071  10b6               L5372:
6072                     ; 1091 	gran(&umin_cnt,0,10);	
6074  10b6 ae000a        	ldw	x,#10
6075  10b9 89            	pushw	x
6076  10ba 5f            	clrw	x
6077  10bb 89            	pushw	x
6078  10bc ae0064        	ldw	x,#_umin_cnt
6079  10bf cd006d        	call	_gran
6081  10c2 5b04          	addw	sp,#4
6082                     ; 1092 	if(umin_cnt>=10)flags|=0b00010000;	  
6084  10c4 9c            	rvf
6085  10c5 be64          	ldw	x,_umin_cnt
6086  10c7 a3000a        	cpw	x,#10
6087  10ca 2f04          	jrslt	L1272
6090  10cc 7218000b      	bset	_flags,#4
6091  10d0               L1272:
6092                     ; 1094 }
6095  10d0 81            	ret
6122                     ; 1097 void x_drv(void)
6122                     ; 1098 {
6123                     	switch	.text
6124  10d1               _x_drv:
6128                     ; 1099 if(_x__==_x_)
6130  10d1 be5c          	ldw	x,__x__
6131  10d3 b35e          	cpw	x,__x_
6132  10d5 262a          	jrne	L1572
6133                     ; 1101 	if(_x_cnt<60)
6135  10d7 9c            	rvf
6136  10d8 be5a          	ldw	x,__x_cnt
6137  10da a3003c        	cpw	x,#60
6138  10dd 2e25          	jrsge	L1672
6139                     ; 1103 		_x_cnt++;
6141  10df be5a          	ldw	x,__x_cnt
6142  10e1 1c0001        	addw	x,#1
6143  10e4 bf5a          	ldw	__x_cnt,x
6144                     ; 1104 		if(_x_cnt>=60)
6146  10e6 9c            	rvf
6147  10e7 be5a          	ldw	x,__x_cnt
6148  10e9 a3003c        	cpw	x,#60
6149  10ec 2f16          	jrslt	L1672
6150                     ; 1106 			if(_x_ee_!=_x_)_x_ee_=_x_;
6152  10ee ce0018        	ldw	x,__x_ee_
6153  10f1 b35e          	cpw	x,__x_
6154  10f3 270f          	jreq	L1672
6157  10f5 be5e          	ldw	x,__x_
6158  10f7 89            	pushw	x
6159  10f8 ae0018        	ldw	x,#__x_ee_
6160  10fb cd0000        	call	c_eewrw
6162  10fe 85            	popw	x
6163  10ff 2003          	jra	L1672
6164  1101               L1572:
6165                     ; 1111 else _x_cnt=0;
6167  1101 5f            	clrw	x
6168  1102 bf5a          	ldw	__x_cnt,x
6169  1104               L1672:
6170                     ; 1113 if(_x_cnt>60) _x_cnt=0;	
6172  1104 9c            	rvf
6173  1105 be5a          	ldw	x,__x_cnt
6174  1107 a3003d        	cpw	x,#61
6175  110a 2f03          	jrslt	L3672
6178  110c 5f            	clrw	x
6179  110d bf5a          	ldw	__x_cnt,x
6180  110f               L3672:
6181                     ; 1115 _x__=_x_;
6183  110f be5e          	ldw	x,__x_
6184  1111 bf5c          	ldw	__x__,x
6185                     ; 1116 }
6188  1113 81            	ret
6214                     ; 1119 void apv_start(void)
6214                     ; 1120 {
6215                     	switch	.text
6216  1114               _apv_start:
6220                     ; 1121 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6222  1114 3d45          	tnz	_apv_cnt
6223  1116 2624          	jrne	L5772
6225  1118 3d46          	tnz	_apv_cnt+1
6226  111a 2620          	jrne	L5772
6228  111c 3d47          	tnz	_apv_cnt+2
6229  111e 261c          	jrne	L5772
6231                     	btst	_bAPV
6232  1125 2515          	jrult	L5772
6233                     ; 1123 	apv_cnt[0]=60;
6235  1127 353c0045      	mov	_apv_cnt,#60
6236                     ; 1124 	apv_cnt[1]=60;
6238  112b 353c0046      	mov	_apv_cnt+1,#60
6239                     ; 1125 	apv_cnt[2]=60;
6241  112f 353c0047      	mov	_apv_cnt+2,#60
6242                     ; 1126 	apv_cnt_=3600;
6244  1133 ae0e10        	ldw	x,#3600
6245  1136 bf43          	ldw	_apv_cnt_,x
6246                     ; 1127 	bAPV=1;	
6248  1138 72100003      	bset	_bAPV
6249  113c               L5772:
6250                     ; 1129 }
6253  113c 81            	ret
6279                     ; 1132 void apv_stop(void)
6279                     ; 1133 {
6280                     	switch	.text
6281  113d               _apv_stop:
6285                     ; 1134 apv_cnt[0]=0;
6287  113d 3f45          	clr	_apv_cnt
6288                     ; 1135 apv_cnt[1]=0;
6290  113f 3f46          	clr	_apv_cnt+1
6291                     ; 1136 apv_cnt[2]=0;
6293  1141 3f47          	clr	_apv_cnt+2
6294                     ; 1137 apv_cnt_=0;	
6296  1143 5f            	clrw	x
6297  1144 bf43          	ldw	_apv_cnt_,x
6298                     ; 1138 bAPV=0;
6300  1146 72110003      	bres	_bAPV
6301                     ; 1139 }
6304  114a 81            	ret
6339                     ; 1143 void apv_hndl(void)
6339                     ; 1144 {
6340                     	switch	.text
6341  114b               _apv_hndl:
6345                     ; 1145 if(apv_cnt[0])
6347  114b 3d45          	tnz	_apv_cnt
6348  114d 271e          	jreq	L7103
6349                     ; 1147 	apv_cnt[0]--;
6351  114f 3a45          	dec	_apv_cnt
6352                     ; 1148 	if(apv_cnt[0]==0)
6354  1151 3d45          	tnz	_apv_cnt
6355  1153 265a          	jrne	L3203
6356                     ; 1150 		flags&=0b11100001;
6358  1155 b60b          	ld	a,_flags
6359  1157 a4e1          	and	a,#225
6360  1159 b70b          	ld	_flags,a
6361                     ; 1151 		tsign_cnt=0;
6363  115b 5f            	clrw	x
6364  115c bf4d          	ldw	_tsign_cnt,x
6365                     ; 1152 		tmax_cnt=0;
6367  115e 5f            	clrw	x
6368  115f bf4b          	ldw	_tmax_cnt,x
6369                     ; 1153 		umax_cnt=0;
6371  1161 5f            	clrw	x
6372  1162 bf66          	ldw	_umax_cnt,x
6373                     ; 1154 		umin_cnt=0;
6375  1164 5f            	clrw	x
6376  1165 bf64          	ldw	_umin_cnt,x
6377                     ; 1156 		led_drv_cnt=30;
6379  1167 351e001c      	mov	_led_drv_cnt,#30
6380  116b 2042          	jra	L3203
6381  116d               L7103:
6382                     ; 1159 else if(apv_cnt[1])
6384  116d 3d46          	tnz	_apv_cnt+1
6385  116f 271e          	jreq	L5203
6386                     ; 1161 	apv_cnt[1]--;
6388  1171 3a46          	dec	_apv_cnt+1
6389                     ; 1162 	if(apv_cnt[1]==0)
6391  1173 3d46          	tnz	_apv_cnt+1
6392  1175 2638          	jrne	L3203
6393                     ; 1164 		flags&=0b11100001;
6395  1177 b60b          	ld	a,_flags
6396  1179 a4e1          	and	a,#225
6397  117b b70b          	ld	_flags,a
6398                     ; 1165 		tsign_cnt=0;
6400  117d 5f            	clrw	x
6401  117e bf4d          	ldw	_tsign_cnt,x
6402                     ; 1166 		tmax_cnt=0;
6404  1180 5f            	clrw	x
6405  1181 bf4b          	ldw	_tmax_cnt,x
6406                     ; 1167 		umax_cnt=0;
6408  1183 5f            	clrw	x
6409  1184 bf66          	ldw	_umax_cnt,x
6410                     ; 1168 		umin_cnt=0;
6412  1186 5f            	clrw	x
6413  1187 bf64          	ldw	_umin_cnt,x
6414                     ; 1170 		led_drv_cnt=30;
6416  1189 351e001c      	mov	_led_drv_cnt,#30
6417  118d 2020          	jra	L3203
6418  118f               L5203:
6419                     ; 1173 else if(apv_cnt[2])
6421  118f 3d47          	tnz	_apv_cnt+2
6422  1191 271c          	jreq	L3203
6423                     ; 1175 	apv_cnt[2]--;
6425  1193 3a47          	dec	_apv_cnt+2
6426                     ; 1176 	if(apv_cnt[2]==0)
6428  1195 3d47          	tnz	_apv_cnt+2
6429  1197 2616          	jrne	L3203
6430                     ; 1178 		flags&=0b11100001;
6432  1199 b60b          	ld	a,_flags
6433  119b a4e1          	and	a,#225
6434  119d b70b          	ld	_flags,a
6435                     ; 1179 		tsign_cnt=0;
6437  119f 5f            	clrw	x
6438  11a0 bf4d          	ldw	_tsign_cnt,x
6439                     ; 1180 		tmax_cnt=0;
6441  11a2 5f            	clrw	x
6442  11a3 bf4b          	ldw	_tmax_cnt,x
6443                     ; 1181 		umax_cnt=0;
6445  11a5 5f            	clrw	x
6446  11a6 bf66          	ldw	_umax_cnt,x
6447                     ; 1182 		umin_cnt=0;          
6449  11a8 5f            	clrw	x
6450  11a9 bf64          	ldw	_umin_cnt,x
6451                     ; 1184 		led_drv_cnt=30;
6453  11ab 351e001c      	mov	_led_drv_cnt,#30
6454  11af               L3203:
6455                     ; 1188 if(apv_cnt_)
6457  11af be43          	ldw	x,_apv_cnt_
6458  11b1 2712          	jreq	L7303
6459                     ; 1190 	apv_cnt_--;
6461  11b3 be43          	ldw	x,_apv_cnt_
6462  11b5 1d0001        	subw	x,#1
6463  11b8 bf43          	ldw	_apv_cnt_,x
6464                     ; 1191 	if(apv_cnt_==0) 
6466  11ba be43          	ldw	x,_apv_cnt_
6467  11bc 2607          	jrne	L7303
6468                     ; 1193 		bAPV=0;
6470  11be 72110003      	bres	_bAPV
6471                     ; 1194 		apv_start();
6473  11c2 cd1114        	call	_apv_start
6475  11c5               L7303:
6476                     ; 1198 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6478  11c5 be64          	ldw	x,_umin_cnt
6479  11c7 261e          	jrne	L3403
6481  11c9 be66          	ldw	x,_umax_cnt
6482  11cb 261a          	jrne	L3403
6484  11cd c65005        	ld	a,20485
6485  11d0 a504          	bcp	a,#4
6486  11d2 2613          	jrne	L3403
6487                     ; 1200 	if(cnt_apv_off<20)
6489  11d4 b642          	ld	a,_cnt_apv_off
6490  11d6 a114          	cp	a,#20
6491  11d8 240f          	jruge	L1503
6492                     ; 1202 		cnt_apv_off++;
6494  11da 3c42          	inc	_cnt_apv_off
6495                     ; 1203 		if(cnt_apv_off>=20)
6497  11dc b642          	ld	a,_cnt_apv_off
6498  11de a114          	cp	a,#20
6499  11e0 2507          	jrult	L1503
6500                     ; 1205 			apv_stop();
6502  11e2 cd113d        	call	_apv_stop
6504  11e5 2002          	jra	L1503
6505  11e7               L3403:
6506                     ; 1209 else cnt_apv_off=0;	
6508  11e7 3f42          	clr	_cnt_apv_off
6509  11e9               L1503:
6510                     ; 1211 }
6513  11e9 81            	ret
6516                     	switch	.ubsct
6517  0000               L3503_flags_old:
6518  0000 00            	ds.b	1
6554                     ; 1214 void flags_drv(void)
6554                     ; 1215 {
6555                     	switch	.text
6556  11ea               _flags_drv:
6560                     ; 1217 if(jp_mode!=jp3) 
6562  11ea b64a          	ld	a,_jp_mode
6563  11ec a103          	cp	a,#3
6564  11ee 2723          	jreq	L3703
6565                     ; 1219 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6567  11f0 b60b          	ld	a,_flags
6568  11f2 a508          	bcp	a,#8
6569  11f4 2706          	jreq	L1013
6571  11f6 b600          	ld	a,L3503_flags_old
6572  11f8 a508          	bcp	a,#8
6573  11fa 270c          	jreq	L7703
6574  11fc               L1013:
6576  11fc b60b          	ld	a,_flags
6577  11fe a510          	bcp	a,#16
6578  1200 2726          	jreq	L5013
6580  1202 b600          	ld	a,L3503_flags_old
6581  1204 a510          	bcp	a,#16
6582  1206 2620          	jrne	L5013
6583  1208               L7703:
6584                     ; 1221     		if(link==OFF)apv_start();
6586  1208 b663          	ld	a,_link
6587  120a a1aa          	cp	a,#170
6588  120c 261a          	jrne	L5013
6591  120e cd1114        	call	_apv_start
6593  1211 2015          	jra	L5013
6594  1213               L3703:
6595                     ; 1224 else if(jp_mode==jp3) 
6597  1213 b64a          	ld	a,_jp_mode
6598  1215 a103          	cp	a,#3
6599  1217 260f          	jrne	L5013
6600                     ; 1226 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6602  1219 b60b          	ld	a,_flags
6603  121b a508          	bcp	a,#8
6604  121d 2709          	jreq	L5013
6606  121f b600          	ld	a,L3503_flags_old
6607  1221 a508          	bcp	a,#8
6608  1223 2603          	jrne	L5013
6609                     ; 1228     		apv_start();
6611  1225 cd1114        	call	_apv_start
6613  1228               L5013:
6614                     ; 1231 flags_old=flags;
6616  1228 450b00        	mov	L3503_flags_old,_flags
6617                     ; 1233 } 
6620  122b 81            	ret
6655                     ; 1370 void adr_drv_v4(char in)
6655                     ; 1371 {
6656                     	switch	.text
6657  122c               _adr_drv_v4:
6661                     ; 1372 if(adress!=in)adress=in;
6663  122c c10005        	cp	a,_adress
6664  122f 2703          	jreq	L1313
6667  1231 c70005        	ld	_adress,a
6668  1234               L1313:
6669                     ; 1373 }
6672  1234 81            	ret
6701                     ; 1376 void adr_drv_v3(void)
6701                     ; 1377 {
6702                     	switch	.text
6703  1235               _adr_drv_v3:
6705  1235 88            	push	a
6706       00000001      OFST:	set	1
6709                     ; 1383 GPIOB->DDR&=~(1<<0);
6711  1236 72115007      	bres	20487,#0
6712                     ; 1384 GPIOB->CR1&=~(1<<0);
6714  123a 72115008      	bres	20488,#0
6715                     ; 1385 GPIOB->CR2&=~(1<<0);
6717  123e 72115009      	bres	20489,#0
6718                     ; 1386 ADC2->CR2=0x08;
6720  1242 35085402      	mov	21506,#8
6721                     ; 1387 ADC2->CR1=0x40;
6723  1246 35405401      	mov	21505,#64
6724                     ; 1388 ADC2->CSR=0x20+0;
6726  124a 35205400      	mov	21504,#32
6727                     ; 1389 ADC2->CR1|=1;
6729  124e 72105401      	bset	21505,#0
6730                     ; 1390 ADC2->CR1|=1;
6732  1252 72105401      	bset	21505,#0
6733                     ; 1391 adr_drv_stat=1;
6735  1256 35010008      	mov	_adr_drv_stat,#1
6736  125a               L3413:
6737                     ; 1392 while(adr_drv_stat==1);
6740  125a b608          	ld	a,_adr_drv_stat
6741  125c a101          	cp	a,#1
6742  125e 27fa          	jreq	L3413
6743                     ; 1394 GPIOB->DDR&=~(1<<1);
6745  1260 72135007      	bres	20487,#1
6746                     ; 1395 GPIOB->CR1&=~(1<<1);
6748  1264 72135008      	bres	20488,#1
6749                     ; 1396 GPIOB->CR2&=~(1<<1);
6751  1268 72135009      	bres	20489,#1
6752                     ; 1397 ADC2->CR2=0x08;
6754  126c 35085402      	mov	21506,#8
6755                     ; 1398 ADC2->CR1=0x40;
6757  1270 35405401      	mov	21505,#64
6758                     ; 1399 ADC2->CSR=0x20+1;
6760  1274 35215400      	mov	21504,#33
6761                     ; 1400 ADC2->CR1|=1;
6763  1278 72105401      	bset	21505,#0
6764                     ; 1401 ADC2->CR1|=1;
6766  127c 72105401      	bset	21505,#0
6767                     ; 1402 adr_drv_stat=3;
6769  1280 35030008      	mov	_adr_drv_stat,#3
6770  1284               L1513:
6771                     ; 1403 while(adr_drv_stat==3);
6774  1284 b608          	ld	a,_adr_drv_stat
6775  1286 a103          	cp	a,#3
6776  1288 27fa          	jreq	L1513
6777                     ; 1405 GPIOE->DDR&=~(1<<6);
6779  128a 721d5016      	bres	20502,#6
6780                     ; 1406 GPIOE->CR1&=~(1<<6);
6782  128e 721d5017      	bres	20503,#6
6783                     ; 1407 GPIOE->CR2&=~(1<<6);
6785  1292 721d5018      	bres	20504,#6
6786                     ; 1408 ADC2->CR2=0x08;
6788  1296 35085402      	mov	21506,#8
6789                     ; 1409 ADC2->CR1=0x40;
6791  129a 35405401      	mov	21505,#64
6792                     ; 1410 ADC2->CSR=0x20+9;
6794  129e 35295400      	mov	21504,#41
6795                     ; 1411 ADC2->CR1|=1;
6797  12a2 72105401      	bset	21505,#0
6798                     ; 1412 ADC2->CR1|=1;
6800  12a6 72105401      	bset	21505,#0
6801                     ; 1413 adr_drv_stat=5;
6803  12aa 35050008      	mov	_adr_drv_stat,#5
6804  12ae               L7513:
6805                     ; 1414 while(adr_drv_stat==5);
6808  12ae b608          	ld	a,_adr_drv_stat
6809  12b0 a105          	cp	a,#5
6810  12b2 27fa          	jreq	L7513
6811                     ; 1418 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6813  12b4 9c            	rvf
6814  12b5 ce0009        	ldw	x,_adc_buff_
6815  12b8 a3022a        	cpw	x,#554
6816  12bb 2f0f          	jrslt	L5613
6818  12bd 9c            	rvf
6819  12be ce0009        	ldw	x,_adc_buff_
6820  12c1 a30253        	cpw	x,#595
6821  12c4 2e06          	jrsge	L5613
6824  12c6 725f0006      	clr	_adr
6826  12ca 204c          	jra	L7613
6827  12cc               L5613:
6828                     ; 1419 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6830  12cc 9c            	rvf
6831  12cd ce0009        	ldw	x,_adc_buff_
6832  12d0 a3036d        	cpw	x,#877
6833  12d3 2f0f          	jrslt	L1713
6835  12d5 9c            	rvf
6836  12d6 ce0009        	ldw	x,_adc_buff_
6837  12d9 a30396        	cpw	x,#918
6838  12dc 2e06          	jrsge	L1713
6841  12de 35010006      	mov	_adr,#1
6843  12e2 2034          	jra	L7613
6844  12e4               L1713:
6845                     ; 1420 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6847  12e4 9c            	rvf
6848  12e5 ce0009        	ldw	x,_adc_buff_
6849  12e8 a302a3        	cpw	x,#675
6850  12eb 2f0f          	jrslt	L5713
6852  12ed 9c            	rvf
6853  12ee ce0009        	ldw	x,_adc_buff_
6854  12f1 a302cc        	cpw	x,#716
6855  12f4 2e06          	jrsge	L5713
6858  12f6 35020006      	mov	_adr,#2
6860  12fa 201c          	jra	L7613
6861  12fc               L5713:
6862                     ; 1421 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6864  12fc 9c            	rvf
6865  12fd ce0009        	ldw	x,_adc_buff_
6866  1300 a303e3        	cpw	x,#995
6867  1303 2f0f          	jrslt	L1023
6869  1305 9c            	rvf
6870  1306 ce0009        	ldw	x,_adc_buff_
6871  1309 a3040c        	cpw	x,#1036
6872  130c 2e06          	jrsge	L1023
6875  130e 35030006      	mov	_adr,#3
6877  1312 2004          	jra	L7613
6878  1314               L1023:
6879                     ; 1422 else adr[0]=5;
6881  1314 35050006      	mov	_adr,#5
6882  1318               L7613:
6883                     ; 1424 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6885  1318 9c            	rvf
6886  1319 ce000b        	ldw	x,_adc_buff_+2
6887  131c a3022a        	cpw	x,#554
6888  131f 2f0f          	jrslt	L5023
6890  1321 9c            	rvf
6891  1322 ce000b        	ldw	x,_adc_buff_+2
6892  1325 a30253        	cpw	x,#595
6893  1328 2e06          	jrsge	L5023
6896  132a 725f0007      	clr	_adr+1
6898  132e 204c          	jra	L7023
6899  1330               L5023:
6900                     ; 1425 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6902  1330 9c            	rvf
6903  1331 ce000b        	ldw	x,_adc_buff_+2
6904  1334 a3036d        	cpw	x,#877
6905  1337 2f0f          	jrslt	L1123
6907  1339 9c            	rvf
6908  133a ce000b        	ldw	x,_adc_buff_+2
6909  133d a30396        	cpw	x,#918
6910  1340 2e06          	jrsge	L1123
6913  1342 35010007      	mov	_adr+1,#1
6915  1346 2034          	jra	L7023
6916  1348               L1123:
6917                     ; 1426 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6919  1348 9c            	rvf
6920  1349 ce000b        	ldw	x,_adc_buff_+2
6921  134c a302a3        	cpw	x,#675
6922  134f 2f0f          	jrslt	L5123
6924  1351 9c            	rvf
6925  1352 ce000b        	ldw	x,_adc_buff_+2
6926  1355 a302cc        	cpw	x,#716
6927  1358 2e06          	jrsge	L5123
6930  135a 35020007      	mov	_adr+1,#2
6932  135e 201c          	jra	L7023
6933  1360               L5123:
6934                     ; 1427 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6936  1360 9c            	rvf
6937  1361 ce000b        	ldw	x,_adc_buff_+2
6938  1364 a303e3        	cpw	x,#995
6939  1367 2f0f          	jrslt	L1223
6941  1369 9c            	rvf
6942  136a ce000b        	ldw	x,_adc_buff_+2
6943  136d a3040c        	cpw	x,#1036
6944  1370 2e06          	jrsge	L1223
6947  1372 35030007      	mov	_adr+1,#3
6949  1376 2004          	jra	L7023
6950  1378               L1223:
6951                     ; 1428 else adr[1]=5;
6953  1378 35050007      	mov	_adr+1,#5
6954  137c               L7023:
6955                     ; 1430 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6957  137c 9c            	rvf
6958  137d ce001b        	ldw	x,_adc_buff_+18
6959  1380 a3022a        	cpw	x,#554
6960  1383 2f0f          	jrslt	L5223
6962  1385 9c            	rvf
6963  1386 ce001b        	ldw	x,_adc_buff_+18
6964  1389 a30253        	cpw	x,#595
6965  138c 2e06          	jrsge	L5223
6968  138e 725f0008      	clr	_adr+2
6970  1392 204c          	jra	L7223
6971  1394               L5223:
6972                     ; 1431 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6974  1394 9c            	rvf
6975  1395 ce001b        	ldw	x,_adc_buff_+18
6976  1398 a3036d        	cpw	x,#877
6977  139b 2f0f          	jrslt	L1323
6979  139d 9c            	rvf
6980  139e ce001b        	ldw	x,_adc_buff_+18
6981  13a1 a30396        	cpw	x,#918
6982  13a4 2e06          	jrsge	L1323
6985  13a6 35010008      	mov	_adr+2,#1
6987  13aa 2034          	jra	L7223
6988  13ac               L1323:
6989                     ; 1432 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6991  13ac 9c            	rvf
6992  13ad ce001b        	ldw	x,_adc_buff_+18
6993  13b0 a302a3        	cpw	x,#675
6994  13b3 2f0f          	jrslt	L5323
6996  13b5 9c            	rvf
6997  13b6 ce001b        	ldw	x,_adc_buff_+18
6998  13b9 a302cc        	cpw	x,#716
6999  13bc 2e06          	jrsge	L5323
7002  13be 35020008      	mov	_adr+2,#2
7004  13c2 201c          	jra	L7223
7005  13c4               L5323:
7006                     ; 1433 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
7008  13c4 9c            	rvf
7009  13c5 ce001b        	ldw	x,_adc_buff_+18
7010  13c8 a303e3        	cpw	x,#995
7011  13cb 2f0f          	jrslt	L1423
7013  13cd 9c            	rvf
7014  13ce ce001b        	ldw	x,_adc_buff_+18
7015  13d1 a3040c        	cpw	x,#1036
7016  13d4 2e06          	jrsge	L1423
7019  13d6 35030008      	mov	_adr+2,#3
7021  13da 2004          	jra	L7223
7022  13dc               L1423:
7023                     ; 1434 else adr[2]=5;
7025  13dc 35050008      	mov	_adr+2,#5
7026  13e0               L7223:
7027                     ; 1438 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
7029  13e0 c60006        	ld	a,_adr
7030  13e3 a105          	cp	a,#5
7031  13e5 270e          	jreq	L7423
7033  13e7 c60007        	ld	a,_adr+1
7034  13ea a105          	cp	a,#5
7035  13ec 2707          	jreq	L7423
7037  13ee c60008        	ld	a,_adr+2
7038  13f1 a105          	cp	a,#5
7039  13f3 2606          	jrne	L5423
7040  13f5               L7423:
7041                     ; 1441 	adress_error=1;
7043  13f5 35010004      	mov	_adress_error,#1
7045  13f9               L3523:
7046                     ; 1452 }
7049  13f9 84            	pop	a
7050  13fa 81            	ret
7051  13fb               L5423:
7052                     ; 1445 	if(adr[2]&0x02) bps_class=bpsIPS;
7054  13fb c60008        	ld	a,_adr+2
7055  13fe a502          	bcp	a,#2
7056  1400 2706          	jreq	L5523
7059  1402 35010004      	mov	_bps_class,#1
7061  1406 2002          	jra	L7523
7062  1408               L5523:
7063                     ; 1446 	else bps_class=bpsIBEP;
7065  1408 3f04          	clr	_bps_class
7066  140a               L7523:
7067                     ; 1448 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
7069  140a c60008        	ld	a,_adr+2
7070  140d a401          	and	a,#1
7071  140f 97            	ld	xl,a
7072  1410 a610          	ld	a,#16
7073  1412 42            	mul	x,a
7074  1413 9f            	ld	a,xl
7075  1414 6b01          	ld	(OFST+0,sp),a
7076  1416 c60007        	ld	a,_adr+1
7077  1419 48            	sll	a
7078  141a 48            	sll	a
7079  141b cb0006        	add	a,_adr
7080  141e 1b01          	add	a,(OFST+0,sp)
7081  1420 c70005        	ld	_adress,a
7082  1423 20d4          	jra	L3523
7126                     ; 1455 void volum_u_main_drv(void)
7126                     ; 1456 {
7127                     	switch	.text
7128  1425               _volum_u_main_drv:
7130  1425 88            	push	a
7131       00000001      OFST:	set	1
7134                     ; 1459 if(bMAIN)
7136                     	btst	_bMAIN
7137  142b 2503          	jrult	L241
7138  142d cc1576        	jp	L7723
7139  1430               L241:
7140                     ; 1461 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7142  1430 9c            	rvf
7143  1431 ce0008        	ldw	x,_UU_AVT
7144  1434 1d000a        	subw	x,#10
7145  1437 b36d          	cpw	x,_Un
7146  1439 2d09          	jrsle	L1033
7149  143b be1f          	ldw	x,_volum_u_main_
7150  143d 1c0005        	addw	x,#5
7151  1440 bf1f          	ldw	_volum_u_main_,x
7153  1442 2036          	jra	L3033
7154  1444               L1033:
7155                     ; 1462 	else if(Un<(UU_AVT-1))volum_u_main_++;
7157  1444 9c            	rvf
7158  1445 ce0008        	ldw	x,_UU_AVT
7159  1448 5a            	decw	x
7160  1449 b36d          	cpw	x,_Un
7161  144b 2d09          	jrsle	L5033
7164  144d be1f          	ldw	x,_volum_u_main_
7165  144f 1c0001        	addw	x,#1
7166  1452 bf1f          	ldw	_volum_u_main_,x
7168  1454 2024          	jra	L3033
7169  1456               L5033:
7170                     ; 1463 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7172  1456 9c            	rvf
7173  1457 ce0008        	ldw	x,_UU_AVT
7174  145a 1c000a        	addw	x,#10
7175  145d b36d          	cpw	x,_Un
7176  145f 2e09          	jrsge	L1133
7179  1461 be1f          	ldw	x,_volum_u_main_
7180  1463 1d000a        	subw	x,#10
7181  1466 bf1f          	ldw	_volum_u_main_,x
7183  1468 2010          	jra	L3033
7184  146a               L1133:
7185                     ; 1464 	else if(Un>(UU_AVT+1))volum_u_main_--;
7187  146a 9c            	rvf
7188  146b ce0008        	ldw	x,_UU_AVT
7189  146e 5c            	incw	x
7190  146f b36d          	cpw	x,_Un
7191  1471 2e07          	jrsge	L3033
7194  1473 be1f          	ldw	x,_volum_u_main_
7195  1475 1d0001        	subw	x,#1
7196  1478 bf1f          	ldw	_volum_u_main_,x
7197  147a               L3033:
7198                     ; 1465 	if(volum_u_main_>1020)volum_u_main_=1020;
7200  147a 9c            	rvf
7201  147b be1f          	ldw	x,_volum_u_main_
7202  147d a303fd        	cpw	x,#1021
7203  1480 2f05          	jrslt	L7133
7206  1482 ae03fc        	ldw	x,#1020
7207  1485 bf1f          	ldw	_volum_u_main_,x
7208  1487               L7133:
7209                     ; 1466 	if(volum_u_main_<0)volum_u_main_=0;
7211  1487 9c            	rvf
7212  1488 be1f          	ldw	x,_volum_u_main_
7213  148a 2e03          	jrsge	L1233
7216  148c 5f            	clrw	x
7217  148d bf1f          	ldw	_volum_u_main_,x
7218  148f               L1233:
7219                     ; 1469 	i_main_sigma=0;
7221  148f 5f            	clrw	x
7222  1490 bf0f          	ldw	_i_main_sigma,x
7223                     ; 1470 	i_main_num_of_bps=0;
7225  1492 3f11          	clr	_i_main_num_of_bps
7226                     ; 1471 	for(i=0;i<6;i++)
7228  1494 0f01          	clr	(OFST+0,sp)
7229  1496               L3233:
7230                     ; 1473 		if(i_main_flag[i])
7232  1496 7b01          	ld	a,(OFST+0,sp)
7233  1498 5f            	clrw	x
7234  1499 97            	ld	xl,a
7235  149a 6d14          	tnz	(_i_main_flag,x)
7236  149c 2719          	jreq	L1333
7237                     ; 1475 			i_main_sigma+=i_main[i];
7239  149e 7b01          	ld	a,(OFST+0,sp)
7240  14a0 5f            	clrw	x
7241  14a1 97            	ld	xl,a
7242  14a2 58            	sllw	x
7243  14a3 ee1a          	ldw	x,(_i_main,x)
7244  14a5 72bb000f      	addw	x,_i_main_sigma
7245  14a9 bf0f          	ldw	_i_main_sigma,x
7246                     ; 1476 			i_main_flag[i]=1;
7248  14ab 7b01          	ld	a,(OFST+0,sp)
7249  14ad 5f            	clrw	x
7250  14ae 97            	ld	xl,a
7251  14af a601          	ld	a,#1
7252  14b1 e714          	ld	(_i_main_flag,x),a
7253                     ; 1477 			i_main_num_of_bps++;
7255  14b3 3c11          	inc	_i_main_num_of_bps
7257  14b5 2006          	jra	L3333
7258  14b7               L1333:
7259                     ; 1481 			i_main_flag[i]=0;	
7261  14b7 7b01          	ld	a,(OFST+0,sp)
7262  14b9 5f            	clrw	x
7263  14ba 97            	ld	xl,a
7264  14bb 6f14          	clr	(_i_main_flag,x)
7265  14bd               L3333:
7266                     ; 1471 	for(i=0;i<6;i++)
7268  14bd 0c01          	inc	(OFST+0,sp)
7271  14bf 7b01          	ld	a,(OFST+0,sp)
7272  14c1 a106          	cp	a,#6
7273  14c3 25d1          	jrult	L3233
7274                     ; 1484 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7276  14c5 be0f          	ldw	x,_i_main_sigma
7277  14c7 b611          	ld	a,_i_main_num_of_bps
7278  14c9 905f          	clrw	y
7279  14cb 9097          	ld	yl,a
7280  14cd cd0000        	call	c_idiv
7282  14d0 bf12          	ldw	_i_main_avg,x
7283                     ; 1485 	for(i=0;i<6;i++)
7285  14d2 0f01          	clr	(OFST+0,sp)
7286  14d4               L5333:
7287                     ; 1487 		if(i_main_flag[i])
7289  14d4 7b01          	ld	a,(OFST+0,sp)
7290  14d6 5f            	clrw	x
7291  14d7 97            	ld	xl,a
7292  14d8 6d14          	tnz	(_i_main_flag,x)
7293  14da 2603cc156b    	jreq	L3433
7294                     ; 1489 			if(i_main[i]<(i_main_avg-10))x[i]++;
7296  14df 9c            	rvf
7297  14e0 7b01          	ld	a,(OFST+0,sp)
7298  14e2 5f            	clrw	x
7299  14e3 97            	ld	xl,a
7300  14e4 58            	sllw	x
7301  14e5 90be12        	ldw	y,_i_main_avg
7302  14e8 72a2000a      	subw	y,#10
7303  14ec 90bf00        	ldw	c_y,y
7304  14ef 9093          	ldw	y,x
7305  14f1 90ee1a        	ldw	y,(_i_main,y)
7306  14f4 90b300        	cpw	y,c_y
7307  14f7 2e11          	jrsge	L5433
7310  14f9 7b01          	ld	a,(OFST+0,sp)
7311  14fb 5f            	clrw	x
7312  14fc 97            	ld	xl,a
7313  14fd 58            	sllw	x
7314  14fe 9093          	ldw	y,x
7315  1500 ee26          	ldw	x,(_x,x)
7316  1502 1c0001        	addw	x,#1
7317  1505 90ef26        	ldw	(_x,y),x
7319  1508 2029          	jra	L7433
7320  150a               L5433:
7321                     ; 1490 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7323  150a 9c            	rvf
7324  150b 7b01          	ld	a,(OFST+0,sp)
7325  150d 5f            	clrw	x
7326  150e 97            	ld	xl,a
7327  150f 58            	sllw	x
7328  1510 90be12        	ldw	y,_i_main_avg
7329  1513 72a9000a      	addw	y,#10
7330  1517 90bf00        	ldw	c_y,y
7331  151a 9093          	ldw	y,x
7332  151c 90ee1a        	ldw	y,(_i_main,y)
7333  151f 90b300        	cpw	y,c_y
7334  1522 2d0f          	jrsle	L7433
7337  1524 7b01          	ld	a,(OFST+0,sp)
7338  1526 5f            	clrw	x
7339  1527 97            	ld	xl,a
7340  1528 58            	sllw	x
7341  1529 9093          	ldw	y,x
7342  152b ee26          	ldw	x,(_x,x)
7343  152d 1d0001        	subw	x,#1
7344  1530 90ef26        	ldw	(_x,y),x
7345  1533               L7433:
7346                     ; 1491 			if(x[i]>100)x[i]=100;
7348  1533 9c            	rvf
7349  1534 7b01          	ld	a,(OFST+0,sp)
7350  1536 5f            	clrw	x
7351  1537 97            	ld	xl,a
7352  1538 58            	sllw	x
7353  1539 9093          	ldw	y,x
7354  153b 90ee26        	ldw	y,(_x,y)
7355  153e 90a30065      	cpw	y,#101
7356  1542 2f0b          	jrslt	L3533
7359  1544 7b01          	ld	a,(OFST+0,sp)
7360  1546 5f            	clrw	x
7361  1547 97            	ld	xl,a
7362  1548 58            	sllw	x
7363  1549 90ae0064      	ldw	y,#100
7364  154d ef26          	ldw	(_x,x),y
7365  154f               L3533:
7366                     ; 1492 			if(x[i]<-100)x[i]=-100;
7368  154f 9c            	rvf
7369  1550 7b01          	ld	a,(OFST+0,sp)
7370  1552 5f            	clrw	x
7371  1553 97            	ld	xl,a
7372  1554 58            	sllw	x
7373  1555 9093          	ldw	y,x
7374  1557 90ee26        	ldw	y,(_x,y)
7375  155a 90a3ff9c      	cpw	y,#65436
7376  155e 2e0b          	jrsge	L3433
7379  1560 7b01          	ld	a,(OFST+0,sp)
7380  1562 5f            	clrw	x
7381  1563 97            	ld	xl,a
7382  1564 58            	sllw	x
7383  1565 90aeff9c      	ldw	y,#65436
7384  1569 ef26          	ldw	(_x,x),y
7385  156b               L3433:
7386                     ; 1485 	for(i=0;i<6;i++)
7388  156b 0c01          	inc	(OFST+0,sp)
7391  156d 7b01          	ld	a,(OFST+0,sp)
7392  156f a106          	cp	a,#6
7393  1571 2403cc14d4    	jrult	L5333
7394  1576               L7723:
7395                     ; 1499 }
7398  1576 84            	pop	a
7399  1577 81            	ret
7422                     ; 1502 void init_CAN(void) {
7423                     	switch	.text
7424  1578               _init_CAN:
7428                     ; 1503 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7430  1578 72135420      	bres	21536,#1
7431                     ; 1504 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7433  157c 72105420      	bset	21536,#0
7435  1580               L1733:
7436                     ; 1505 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7438  1580 c65421        	ld	a,21537
7439  1583 a501          	bcp	a,#1
7440  1585 27f9          	jreq	L1733
7441                     ; 1507 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7443  1587 72185420      	bset	21536,#4
7444                     ; 1509 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7446  158b 35025427      	mov	21543,#2
7447                     ; 1518 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7449  158f 35135428      	mov	21544,#19
7450                     ; 1519 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7452  1593 35c05429      	mov	21545,#192
7453                     ; 1520 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7455  1597 357f542c      	mov	21548,#127
7456                     ; 1521 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7458  159b 35e0542d      	mov	21549,#224
7459                     ; 1523 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7461  159f 35315430      	mov	21552,#49
7462                     ; 1524 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7464  15a3 35c05431      	mov	21553,#192
7465                     ; 1525 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7467  15a7 357f5434      	mov	21556,#127
7468                     ; 1526 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7470  15ab 35e05435      	mov	21557,#224
7471                     ; 1530 	CAN->PSR= 6;									// set page 6
7473  15af 35065427      	mov	21543,#6
7474                     ; 1535 	CAN->Page.Config.FMR1&=~3;								//mask mode
7476  15b3 c65430        	ld	a,21552
7477  15b6 a4fc          	and	a,#252
7478  15b8 c75430        	ld	21552,a
7479                     ; 1541 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7481  15bb 35065432      	mov	21554,#6
7482                     ; 1542 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7484  15bf 35605432      	mov	21554,#96
7485                     ; 1545 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7487  15c3 72105432      	bset	21554,#0
7488                     ; 1546 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7490  15c7 72185432      	bset	21554,#4
7491                     ; 1549 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7493  15cb 35065427      	mov	21543,#6
7494                     ; 1551 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7496  15cf 3509542c      	mov	21548,#9
7497                     ; 1552 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7499  15d3 35e7542d      	mov	21549,#231
7500                     ; 1554 	CAN->IER|=(1<<1);
7502  15d7 72125425      	bset	21541,#1
7503                     ; 1557 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7505  15db 72115420      	bres	21536,#0
7507  15df               L7733:
7508                     ; 1558 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7510  15df c65421        	ld	a,21537
7511  15e2 a501          	bcp	a,#1
7512  15e4 26f9          	jrne	L7733
7513                     ; 1559 }
7516  15e6 81            	ret
7624                     ; 1562 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7624                     ; 1563 {
7625                     	switch	.text
7626  15e7               _can_transmit:
7628  15e7 89            	pushw	x
7629       00000000      OFST:	set	0
7632                     ; 1565 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7634  15e8 b674          	ld	a,_can_buff_wr_ptr
7635  15ea a104          	cp	a,#4
7636  15ec 2502          	jrult	L1643
7639  15ee 3f74          	clr	_can_buff_wr_ptr
7640  15f0               L1643:
7641                     ; 1567 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7643  15f0 b674          	ld	a,_can_buff_wr_ptr
7644  15f2 97            	ld	xl,a
7645  15f3 a610          	ld	a,#16
7646  15f5 42            	mul	x,a
7647  15f6 1601          	ldw	y,(OFST+1,sp)
7648  15f8 a606          	ld	a,#6
7649  15fa               L051:
7650  15fa 9054          	srlw	y
7651  15fc 4a            	dec	a
7652  15fd 26fb          	jrne	L051
7653  15ff 909f          	ld	a,yl
7654  1601 e775          	ld	(_can_out_buff,x),a
7655                     ; 1568 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7657  1603 b674          	ld	a,_can_buff_wr_ptr
7658  1605 97            	ld	xl,a
7659  1606 a610          	ld	a,#16
7660  1608 42            	mul	x,a
7661  1609 7b02          	ld	a,(OFST+2,sp)
7662  160b 48            	sll	a
7663  160c 48            	sll	a
7664  160d e776          	ld	(_can_out_buff+1,x),a
7665                     ; 1570 can_out_buff[can_buff_wr_ptr][2]=data0;
7667  160f b674          	ld	a,_can_buff_wr_ptr
7668  1611 97            	ld	xl,a
7669  1612 a610          	ld	a,#16
7670  1614 42            	mul	x,a
7671  1615 7b05          	ld	a,(OFST+5,sp)
7672  1617 e777          	ld	(_can_out_buff+2,x),a
7673                     ; 1571 can_out_buff[can_buff_wr_ptr][3]=data1;
7675  1619 b674          	ld	a,_can_buff_wr_ptr
7676  161b 97            	ld	xl,a
7677  161c a610          	ld	a,#16
7678  161e 42            	mul	x,a
7679  161f 7b06          	ld	a,(OFST+6,sp)
7680  1621 e778          	ld	(_can_out_buff+3,x),a
7681                     ; 1572 can_out_buff[can_buff_wr_ptr][4]=data2;
7683  1623 b674          	ld	a,_can_buff_wr_ptr
7684  1625 97            	ld	xl,a
7685  1626 a610          	ld	a,#16
7686  1628 42            	mul	x,a
7687  1629 7b07          	ld	a,(OFST+7,sp)
7688  162b e779          	ld	(_can_out_buff+4,x),a
7689                     ; 1573 can_out_buff[can_buff_wr_ptr][5]=data3;
7691  162d b674          	ld	a,_can_buff_wr_ptr
7692  162f 97            	ld	xl,a
7693  1630 a610          	ld	a,#16
7694  1632 42            	mul	x,a
7695  1633 7b08          	ld	a,(OFST+8,sp)
7696  1635 e77a          	ld	(_can_out_buff+5,x),a
7697                     ; 1574 can_out_buff[can_buff_wr_ptr][6]=data4;
7699  1637 b674          	ld	a,_can_buff_wr_ptr
7700  1639 97            	ld	xl,a
7701  163a a610          	ld	a,#16
7702  163c 42            	mul	x,a
7703  163d 7b09          	ld	a,(OFST+9,sp)
7704  163f e77b          	ld	(_can_out_buff+6,x),a
7705                     ; 1575 can_out_buff[can_buff_wr_ptr][7]=data5;
7707  1641 b674          	ld	a,_can_buff_wr_ptr
7708  1643 97            	ld	xl,a
7709  1644 a610          	ld	a,#16
7710  1646 42            	mul	x,a
7711  1647 7b0a          	ld	a,(OFST+10,sp)
7712  1649 e77c          	ld	(_can_out_buff+7,x),a
7713                     ; 1576 can_out_buff[can_buff_wr_ptr][8]=data6;
7715  164b b674          	ld	a,_can_buff_wr_ptr
7716  164d 97            	ld	xl,a
7717  164e a610          	ld	a,#16
7718  1650 42            	mul	x,a
7719  1651 7b0b          	ld	a,(OFST+11,sp)
7720  1653 e77d          	ld	(_can_out_buff+8,x),a
7721                     ; 1577 can_out_buff[can_buff_wr_ptr][9]=data7;
7723  1655 b674          	ld	a,_can_buff_wr_ptr
7724  1657 97            	ld	xl,a
7725  1658 a610          	ld	a,#16
7726  165a 42            	mul	x,a
7727  165b 7b0c          	ld	a,(OFST+12,sp)
7728  165d e77e          	ld	(_can_out_buff+9,x),a
7729                     ; 1579 can_buff_wr_ptr++;
7731  165f 3c74          	inc	_can_buff_wr_ptr
7732                     ; 1580 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7734  1661 b674          	ld	a,_can_buff_wr_ptr
7735  1663 a104          	cp	a,#4
7736  1665 2502          	jrult	L3643
7739  1667 3f74          	clr	_can_buff_wr_ptr
7740  1669               L3643:
7741                     ; 1581 } 
7744  1669 85            	popw	x
7745  166a 81            	ret
7774                     ; 1584 void can_tx_hndl(void)
7774                     ; 1585 {
7775                     	switch	.text
7776  166b               _can_tx_hndl:
7780                     ; 1586 if(bTX_FREE)
7782  166b 3d09          	tnz	_bTX_FREE
7783  166d 2757          	jreq	L5743
7784                     ; 1588 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7786  166f b673          	ld	a,_can_buff_rd_ptr
7787  1671 b174          	cp	a,_can_buff_wr_ptr
7788  1673 275f          	jreq	L3053
7789                     ; 1590 		bTX_FREE=0;
7791  1675 3f09          	clr	_bTX_FREE
7792                     ; 1592 		CAN->PSR= 0;
7794  1677 725f5427      	clr	21543
7795                     ; 1593 		CAN->Page.TxMailbox.MDLCR=8;
7797  167b 35085429      	mov	21545,#8
7798                     ; 1594 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7800  167f b673          	ld	a,_can_buff_rd_ptr
7801  1681 97            	ld	xl,a
7802  1682 a610          	ld	a,#16
7803  1684 42            	mul	x,a
7804  1685 e675          	ld	a,(_can_out_buff,x)
7805  1687 c7542a        	ld	21546,a
7806                     ; 1595 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7808  168a b673          	ld	a,_can_buff_rd_ptr
7809  168c 97            	ld	xl,a
7810  168d a610          	ld	a,#16
7811  168f 42            	mul	x,a
7812  1690 e676          	ld	a,(_can_out_buff+1,x)
7813  1692 c7542b        	ld	21547,a
7814                     ; 1597 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7816  1695 b673          	ld	a,_can_buff_rd_ptr
7817  1697 97            	ld	xl,a
7818  1698 a610          	ld	a,#16
7819  169a 42            	mul	x,a
7820  169b 01            	rrwa	x,a
7821  169c ab77          	add	a,#_can_out_buff+2
7822  169e 2401          	jrnc	L451
7823  16a0 5c            	incw	x
7824  16a1               L451:
7825  16a1 5f            	clrw	x
7826  16a2 97            	ld	xl,a
7827  16a3 bf00          	ldw	c_x,x
7828  16a5 ae0008        	ldw	x,#8
7829  16a8               L651:
7830  16a8 5a            	decw	x
7831  16a9 92d600        	ld	a,([c_x],x)
7832  16ac d7542e        	ld	(21550,x),a
7833  16af 5d            	tnzw	x
7834  16b0 26f6          	jrne	L651
7835                     ; 1599 		can_buff_rd_ptr++;
7837  16b2 3c73          	inc	_can_buff_rd_ptr
7838                     ; 1600 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7840  16b4 b673          	ld	a,_can_buff_rd_ptr
7841  16b6 a104          	cp	a,#4
7842  16b8 2502          	jrult	L1053
7845  16ba 3f73          	clr	_can_buff_rd_ptr
7846  16bc               L1053:
7847                     ; 1602 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7849  16bc 72105428      	bset	21544,#0
7850                     ; 1603 		CAN->IER|=(1<<0);
7852  16c0 72105425      	bset	21541,#0
7853  16c4 200e          	jra	L3053
7854  16c6               L5743:
7855                     ; 1608 	tx_busy_cnt++;
7857  16c6 3c72          	inc	_tx_busy_cnt
7858                     ; 1609 	if(tx_busy_cnt>=100)
7860  16c8 b672          	ld	a,_tx_busy_cnt
7861  16ca a164          	cp	a,#100
7862  16cc 2506          	jrult	L3053
7863                     ; 1611 		tx_busy_cnt=0;
7865  16ce 3f72          	clr	_tx_busy_cnt
7866                     ; 1612 		bTX_FREE=1;
7868  16d0 35010009      	mov	_bTX_FREE,#1
7869  16d4               L3053:
7870                     ; 1615 }
7873  16d4 81            	ret
7912                     ; 1618 void net_drv(void)
7912                     ; 1619 { 
7913                     	switch	.text
7914  16d5               _net_drv:
7918                     ; 1621 if(bMAIN)
7920                     	btst	_bMAIN
7921  16da 2503          	jrult	L261
7922  16dc cc1782        	jp	L7153
7923  16df               L261:
7924                     ; 1623 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7926  16df 3c32          	inc	_cnt_net_drv
7927  16e1 b632          	ld	a,_cnt_net_drv
7928  16e3 a107          	cp	a,#7
7929  16e5 2502          	jrult	L1253
7932  16e7 3f32          	clr	_cnt_net_drv
7933  16e9               L1253:
7934                     ; 1625 	if(cnt_net_drv<=5) 
7936  16e9 b632          	ld	a,_cnt_net_drv
7937  16eb a106          	cp	a,#6
7938  16ed 244c          	jruge	L3253
7939                     ; 1627 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7941  16ef 4be8          	push	#232
7942  16f1 4be8          	push	#232
7943  16f3 b632          	ld	a,_cnt_net_drv
7944  16f5 5f            	clrw	x
7945  16f6 97            	ld	xl,a
7946  16f7 58            	sllw	x
7947  16f8 ee26          	ldw	x,(_x,x)
7948  16fa 72bb001f      	addw	x,_volum_u_main_
7949  16fe 90ae0100      	ldw	y,#256
7950  1702 cd0000        	call	c_idiv
7952  1705 9f            	ld	a,xl
7953  1706 88            	push	a
7954  1707 b632          	ld	a,_cnt_net_drv
7955  1709 5f            	clrw	x
7956  170a 97            	ld	xl,a
7957  170b 58            	sllw	x
7958  170c e627          	ld	a,(_x+1,x)
7959  170e bb20          	add	a,_volum_u_main_+1
7960  1710 88            	push	a
7961  1711 4b00          	push	#0
7962  1713 4bed          	push	#237
7963  1715 3b0032        	push	_cnt_net_drv
7964  1718 3b0032        	push	_cnt_net_drv
7965  171b ae009e        	ldw	x,#158
7966  171e cd15e7        	call	_can_transmit
7968  1721 5b08          	addw	sp,#8
7969                     ; 1628 		i_main_bps_cnt[cnt_net_drv]++;
7971  1723 b632          	ld	a,_cnt_net_drv
7972  1725 5f            	clrw	x
7973  1726 97            	ld	xl,a
7974  1727 6c09          	inc	(_i_main_bps_cnt,x)
7975                     ; 1629 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7977  1729 b632          	ld	a,_cnt_net_drv
7978  172b 5f            	clrw	x
7979  172c 97            	ld	xl,a
7980  172d e609          	ld	a,(_i_main_bps_cnt,x)
7981  172f a10b          	cp	a,#11
7982  1731 254f          	jrult	L7153
7985  1733 b632          	ld	a,_cnt_net_drv
7986  1735 5f            	clrw	x
7987  1736 97            	ld	xl,a
7988  1737 6f14          	clr	(_i_main_flag,x)
7989  1739 2047          	jra	L7153
7990  173b               L3253:
7991                     ; 1631 	else if(cnt_net_drv==6)
7993  173b b632          	ld	a,_cnt_net_drv
7994  173d a106          	cp	a,#6
7995  173f 2641          	jrne	L7153
7996                     ; 1633 		plazma_int[2]=pwm_u;
7998  1741 be0e          	ldw	x,_pwm_u
7999  1743 bf37          	ldw	_plazma_int+4,x
8000                     ; 1634 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8002  1745 3b006b        	push	_Ui
8003  1748 3b006c        	push	_Ui+1
8004  174b 3b006d        	push	_Un
8005  174e 3b006e        	push	_Un+1
8006  1751 3b006f        	push	_I
8007  1754 3b0070        	push	_I+1
8008  1757 4bda          	push	#218
8009  1759 3b0005        	push	_adress
8010  175c ae018e        	ldw	x,#398
8011  175f cd15e7        	call	_can_transmit
8013  1762 5b08          	addw	sp,#8
8014                     ; 1635 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8016  1764 3b0037        	push	_plazma_int+4
8017  1767 3b0038        	push	_plazma_int+5
8018  176a 3b005f        	push	__x_+1
8019  176d 3b000b        	push	_flags
8020  1770 4b00          	push	#0
8021  1772 3b0068        	push	_T
8022  1775 4bdb          	push	#219
8023  1777 3b0005        	push	_adress
8024  177a ae018e        	ldw	x,#398
8025  177d cd15e7        	call	_can_transmit
8027  1780 5b08          	addw	sp,#8
8028  1782               L7153:
8029                     ; 1638 }
8032  1782 81            	ret
8146                     ; 1641 void can_in_an(void)
8146                     ; 1642 {
8147                     	switch	.text
8148  1783               _can_in_an:
8150  1783 5205          	subw	sp,#5
8151       00000005      OFST:	set	5
8154                     ; 1652 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8156  1785 b6ca          	ld	a,_mess+6
8157  1787 c10005        	cp	a,_adress
8158  178a 2703          	jreq	L402
8159  178c cc189b        	jp	L7653
8160  178f               L402:
8162  178f b6cb          	ld	a,_mess+7
8163  1791 c10005        	cp	a,_adress
8164  1794 2703          	jreq	L602
8165  1796 cc189b        	jp	L7653
8166  1799               L602:
8168  1799 b6cc          	ld	a,_mess+8
8169  179b a1ed          	cp	a,#237
8170  179d 2703          	jreq	L012
8171  179f cc189b        	jp	L7653
8172  17a2               L012:
8173                     ; 1655 	can_error_cnt=0;
8175  17a2 3f71          	clr	_can_error_cnt
8176                     ; 1657 	bMAIN=0;
8178  17a4 72110002      	bres	_bMAIN
8179                     ; 1658  	flags_tu=mess[9];
8181  17a8 45cd60        	mov	_flags_tu,_mess+9
8182                     ; 1659  	if(flags_tu&0b00000001)
8184  17ab b660          	ld	a,_flags_tu
8185  17ad a501          	bcp	a,#1
8186  17af 2706          	jreq	L1753
8187                     ; 1664  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8189  17b1 721a000b      	bset	_flags,#5
8191  17b5 200e          	jra	L3753
8192  17b7               L1753:
8193                     ; 1675  				flags&=0b11011111; 
8195  17b7 721b000b      	bres	_flags,#5
8196                     ; 1676  				off_bp_cnt=5*ee_TZAS;
8198  17bb c60017        	ld	a,_ee_TZAS+1
8199  17be 97            	ld	xl,a
8200  17bf a605          	ld	a,#5
8201  17c1 42            	mul	x,a
8202  17c2 9f            	ld	a,xl
8203  17c3 b753          	ld	_off_bp_cnt,a
8204  17c5               L3753:
8205                     ; 1682  	if(flags_tu&0b00000010) flags|=0b01000000;
8207  17c5 b660          	ld	a,_flags_tu
8208  17c7 a502          	bcp	a,#2
8209  17c9 2706          	jreq	L5753
8212  17cb 721c000b      	bset	_flags,#6
8214  17cf 2004          	jra	L7753
8215  17d1               L5753:
8216                     ; 1683  	else flags&=0b10111111; 
8218  17d1 721d000b      	bres	_flags,#6
8219  17d5               L7753:
8220                     ; 1685  	vol_u_temp=mess[10]+mess[11]*256;
8222  17d5 b6cf          	ld	a,_mess+11
8223  17d7 5f            	clrw	x
8224  17d8 97            	ld	xl,a
8225  17d9 4f            	clr	a
8226  17da 02            	rlwa	x,a
8227  17db 01            	rrwa	x,a
8228  17dc bbce          	add	a,_mess+10
8229  17de 2401          	jrnc	L661
8230  17e0 5c            	incw	x
8231  17e1               L661:
8232  17e1 b759          	ld	_vol_u_temp+1,a
8233  17e3 9f            	ld	a,xl
8234  17e4 b758          	ld	_vol_u_temp,a
8235                     ; 1686  	vol_i_temp=mess[12]+mess[13]*256;  
8237  17e6 b6d1          	ld	a,_mess+13
8238  17e8 5f            	clrw	x
8239  17e9 97            	ld	xl,a
8240  17ea 4f            	clr	a
8241  17eb 02            	rlwa	x,a
8242  17ec 01            	rrwa	x,a
8243  17ed bbd0          	add	a,_mess+12
8244  17ef 2401          	jrnc	L071
8245  17f1 5c            	incw	x
8246  17f2               L071:
8247  17f2 b757          	ld	_vol_i_temp+1,a
8248  17f4 9f            	ld	a,xl
8249  17f5 b756          	ld	_vol_i_temp,a
8250                     ; 1697 	plazma_int[2]=jp_mode;
8252  17f7 b64a          	ld	a,_jp_mode
8253  17f9 5f            	clrw	x
8254  17fa 97            	ld	xl,a
8255  17fb bf37          	ldw	_plazma_int+4,x
8256                     ; 1698  	rotor_int=flags_tu+(((short)flags)<<8);
8258  17fd b60b          	ld	a,_flags
8259  17ff 5f            	clrw	x
8260  1800 97            	ld	xl,a
8261  1801 4f            	clr	a
8262  1802 02            	rlwa	x,a
8263  1803 01            	rrwa	x,a
8264  1804 bb60          	add	a,_flags_tu
8265  1806 2401          	jrnc	L271
8266  1808 5c            	incw	x
8267  1809               L271:
8268  1809 b71e          	ld	_rotor_int+1,a
8269  180b 9f            	ld	a,xl
8270  180c b71d          	ld	_rotor_int,a
8271                     ; 1699 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8273  180e 3b006b        	push	_Ui
8274  1811 3b006c        	push	_Ui+1
8275  1814 3b006d        	push	_Un
8276  1817 3b006e        	push	_Un+1
8277  181a 3b006f        	push	_I
8278  181d 3b0070        	push	_I+1
8279  1820 4bda          	push	#218
8280  1822 3b0005        	push	_adress
8281  1825 ae018e        	ldw	x,#398
8282  1828 cd15e7        	call	_can_transmit
8284  182b 5b08          	addw	sp,#8
8285                     ; 1701 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,123,456);
8287  182d 4bc8          	push	#200
8288  182f 4b7b          	push	#123
8289  1831 3b005f        	push	__x_+1
8290  1834 3b000b        	push	_flags
8291  1837 b601          	ld	a,_vent_resurs_tx_cnt
8292  1839 5f            	clrw	x
8293  183a 97            	ld	xl,a
8294  183b d60000        	ld	a,(_vent_resurs_buff,x)
8295  183e 88            	push	a
8296  183f 3b0068        	push	_T
8297  1842 4bdb          	push	#219
8298  1844 3b0005        	push	_adress
8299  1847 ae018e        	ldw	x,#398
8300  184a cd15e7        	call	_can_transmit
8302  184d 5b08          	addw	sp,#8
8303                     ; 1702      link_cnt=0;
8305  184f 5f            	clrw	x
8306  1850 bf61          	ldw	_link_cnt,x
8307                     ; 1703      link=ON;
8309  1852 35550063      	mov	_link,#85
8310                     ; 1705      if(flags_tu&0b10000000)
8312  1856 b660          	ld	a,_flags_tu
8313  1858 a580          	bcp	a,#128
8314  185a 2716          	jreq	L1063
8315                     ; 1707      	if(!res_fl)
8317  185c 725d000b      	tnz	_res_fl
8318  1860 2625          	jrne	L5063
8319                     ; 1709      		res_fl=1;
8321  1862 a601          	ld	a,#1
8322  1864 ae000b        	ldw	x,#_res_fl
8323  1867 cd0000        	call	c_eewrc
8325                     ; 1710      		bRES=1;
8327  186a 35010012      	mov	_bRES,#1
8328                     ; 1711      		res_fl_cnt=0;
8330  186e 3f41          	clr	_res_fl_cnt
8331  1870 2015          	jra	L5063
8332  1872               L1063:
8333                     ; 1716      	if(main_cnt>20)
8335  1872 9c            	rvf
8336  1873 be51          	ldw	x,_main_cnt
8337  1875 a30015        	cpw	x,#21
8338  1878 2f0d          	jrslt	L5063
8339                     ; 1718     			if(res_fl)
8341  187a 725d000b      	tnz	_res_fl
8342  187e 2707          	jreq	L5063
8343                     ; 1720      			res_fl=0;
8345  1880 4f            	clr	a
8346  1881 ae000b        	ldw	x,#_res_fl
8347  1884 cd0000        	call	c_eewrc
8349  1887               L5063:
8350                     ; 1725       if(res_fl_)
8352  1887 725d000a      	tnz	_res_fl_
8353  188b 2603          	jrne	L212
8354  188d cc1de6        	jp	L3353
8355  1890               L212:
8356                     ; 1727       	res_fl_=0;
8358  1890 4f            	clr	a
8359  1891 ae000a        	ldw	x,#_res_fl_
8360  1894 cd0000        	call	c_eewrc
8362  1897 ace61de6      	jpf	L3353
8363  189b               L7653:
8364                     ; 1730 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8366  189b b6ca          	ld	a,_mess+6
8367  189d c10005        	cp	a,_adress
8368  18a0 2703          	jreq	L412
8369  18a2 cc1ab2        	jp	L7163
8370  18a5               L412:
8372  18a5 b6cb          	ld	a,_mess+7
8373  18a7 c10005        	cp	a,_adress
8374  18aa 2703          	jreq	L612
8375  18ac cc1ab2        	jp	L7163
8376  18af               L612:
8378  18af b6cc          	ld	a,_mess+8
8379  18b1 a1ee          	cp	a,#238
8380  18b3 2703          	jreq	L022
8381  18b5 cc1ab2        	jp	L7163
8382  18b8               L022:
8384  18b8 b6cd          	ld	a,_mess+9
8385  18ba b1ce          	cp	a,_mess+10
8386  18bc 2703          	jreq	L222
8387  18be cc1ab2        	jp	L7163
8388  18c1               L222:
8389                     ; 1732 	rotor_int++;
8391  18c1 be1d          	ldw	x,_rotor_int
8392  18c3 1c0001        	addw	x,#1
8393  18c6 bf1d          	ldw	_rotor_int,x
8394                     ; 1733 	if((mess[9]&0xf0)==0x20)
8396  18c8 b6cd          	ld	a,_mess+9
8397  18ca a4f0          	and	a,#240
8398  18cc a120          	cp	a,#32
8399  18ce 2673          	jrne	L1263
8400                     ; 1735 		if((mess[9]&0x0f)==0x01)
8402  18d0 b6cd          	ld	a,_mess+9
8403  18d2 a40f          	and	a,#15
8404  18d4 a101          	cp	a,#1
8405  18d6 260d          	jrne	L3263
8406                     ; 1737 			ee_K[0][0]=adc_buff_[4];
8408  18d8 ce0011        	ldw	x,_adc_buff_+8
8409  18db 89            	pushw	x
8410  18dc ae001a        	ldw	x,#_ee_K
8411  18df cd0000        	call	c_eewrw
8413  18e2 85            	popw	x
8415  18e3 204a          	jra	L5263
8416  18e5               L3263:
8417                     ; 1739 		else if((mess[9]&0x0f)==0x02)
8419  18e5 b6cd          	ld	a,_mess+9
8420  18e7 a40f          	and	a,#15
8421  18e9 a102          	cp	a,#2
8422  18eb 260b          	jrne	L7263
8423                     ; 1741 			ee_K[0][1]++;
8425  18ed ce001c        	ldw	x,_ee_K+2
8426  18f0 1c0001        	addw	x,#1
8427  18f3 cf001c        	ldw	_ee_K+2,x
8429  18f6 2037          	jra	L5263
8430  18f8               L7263:
8431                     ; 1743 		else if((mess[9]&0x0f)==0x03)
8433  18f8 b6cd          	ld	a,_mess+9
8434  18fa a40f          	and	a,#15
8435  18fc a103          	cp	a,#3
8436  18fe 260b          	jrne	L3363
8437                     ; 1745 			ee_K[0][1]+=10;
8439  1900 ce001c        	ldw	x,_ee_K+2
8440  1903 1c000a        	addw	x,#10
8441  1906 cf001c        	ldw	_ee_K+2,x
8443  1909 2024          	jra	L5263
8444  190b               L3363:
8445                     ; 1747 		else if((mess[9]&0x0f)==0x04)
8447  190b b6cd          	ld	a,_mess+9
8448  190d a40f          	and	a,#15
8449  190f a104          	cp	a,#4
8450  1911 260b          	jrne	L7363
8451                     ; 1749 			ee_K[0][1]--;
8453  1913 ce001c        	ldw	x,_ee_K+2
8454  1916 1d0001        	subw	x,#1
8455  1919 cf001c        	ldw	_ee_K+2,x
8457  191c 2011          	jra	L5263
8458  191e               L7363:
8459                     ; 1751 		else if((mess[9]&0x0f)==0x05)
8461  191e b6cd          	ld	a,_mess+9
8462  1920 a40f          	and	a,#15
8463  1922 a105          	cp	a,#5
8464  1924 2609          	jrne	L5263
8465                     ; 1753 			ee_K[0][1]-=10;
8467  1926 ce001c        	ldw	x,_ee_K+2
8468  1929 1d000a        	subw	x,#10
8469  192c cf001c        	ldw	_ee_K+2,x
8470  192f               L5263:
8471                     ; 1755 		granee(&ee_K[0][1],10,30000);									
8473  192f ae7530        	ldw	x,#30000
8474  1932 89            	pushw	x
8475  1933 ae000a        	ldw	x,#10
8476  1936 89            	pushw	x
8477  1937 ae001c        	ldw	x,#_ee_K+2
8478  193a cd008e        	call	_granee
8480  193d 5b04          	addw	sp,#4
8482  193f ac971a97      	jpf	L5463
8483  1943               L1263:
8484                     ; 1757 	else if((mess[9]&0xf0)==0x10)
8486  1943 b6cd          	ld	a,_mess+9
8487  1945 a4f0          	and	a,#240
8488  1947 a110          	cp	a,#16
8489  1949 2673          	jrne	L7463
8490                     ; 1759 		if((mess[9]&0x0f)==0x01)
8492  194b b6cd          	ld	a,_mess+9
8493  194d a40f          	and	a,#15
8494  194f a101          	cp	a,#1
8495  1951 260d          	jrne	L1563
8496                     ; 1761 			ee_K[1][0]=adc_buff_[1];
8498  1953 ce000b        	ldw	x,_adc_buff_+2
8499  1956 89            	pushw	x
8500  1957 ae001e        	ldw	x,#_ee_K+4
8501  195a cd0000        	call	c_eewrw
8503  195d 85            	popw	x
8505  195e 204a          	jra	L3563
8506  1960               L1563:
8507                     ; 1763 		else if((mess[9]&0x0f)==0x02)
8509  1960 b6cd          	ld	a,_mess+9
8510  1962 a40f          	and	a,#15
8511  1964 a102          	cp	a,#2
8512  1966 260b          	jrne	L5563
8513                     ; 1765 			ee_K[1][1]++;
8515  1968 ce0020        	ldw	x,_ee_K+6
8516  196b 1c0001        	addw	x,#1
8517  196e cf0020        	ldw	_ee_K+6,x
8519  1971 2037          	jra	L3563
8520  1973               L5563:
8521                     ; 1767 		else if((mess[9]&0x0f)==0x03)
8523  1973 b6cd          	ld	a,_mess+9
8524  1975 a40f          	and	a,#15
8525  1977 a103          	cp	a,#3
8526  1979 260b          	jrne	L1663
8527                     ; 1769 			ee_K[1][1]+=10;
8529  197b ce0020        	ldw	x,_ee_K+6
8530  197e 1c000a        	addw	x,#10
8531  1981 cf0020        	ldw	_ee_K+6,x
8533  1984 2024          	jra	L3563
8534  1986               L1663:
8535                     ; 1771 		else if((mess[9]&0x0f)==0x04)
8537  1986 b6cd          	ld	a,_mess+9
8538  1988 a40f          	and	a,#15
8539  198a a104          	cp	a,#4
8540  198c 260b          	jrne	L5663
8541                     ; 1773 			ee_K[1][1]--;
8543  198e ce0020        	ldw	x,_ee_K+6
8544  1991 1d0001        	subw	x,#1
8545  1994 cf0020        	ldw	_ee_K+6,x
8547  1997 2011          	jra	L3563
8548  1999               L5663:
8549                     ; 1775 		else if((mess[9]&0x0f)==0x05)
8551  1999 b6cd          	ld	a,_mess+9
8552  199b a40f          	and	a,#15
8553  199d a105          	cp	a,#5
8554  199f 2609          	jrne	L3563
8555                     ; 1777 			ee_K[1][1]-=10;
8557  19a1 ce0020        	ldw	x,_ee_K+6
8558  19a4 1d000a        	subw	x,#10
8559  19a7 cf0020        	ldw	_ee_K+6,x
8560  19aa               L3563:
8561                     ; 1782 		granee(&ee_K[1][1],10,30000);
8563  19aa ae7530        	ldw	x,#30000
8564  19ad 89            	pushw	x
8565  19ae ae000a        	ldw	x,#10
8566  19b1 89            	pushw	x
8567  19b2 ae0020        	ldw	x,#_ee_K+6
8568  19b5 cd008e        	call	_granee
8570  19b8 5b04          	addw	sp,#4
8572  19ba ac971a97      	jpf	L5463
8573  19be               L7463:
8574                     ; 1786 	else if((mess[9]&0xf0)==0x00)
8576  19be b6cd          	ld	a,_mess+9
8577  19c0 a5f0          	bcp	a,#240
8578  19c2 2671          	jrne	L5763
8579                     ; 1788 		if((mess[9]&0x0f)==0x01)
8581  19c4 b6cd          	ld	a,_mess+9
8582  19c6 a40f          	and	a,#15
8583  19c8 a101          	cp	a,#1
8584  19ca 260d          	jrne	L7763
8585                     ; 1790 			ee_K[2][0]=adc_buff_[2];
8587  19cc ce000d        	ldw	x,_adc_buff_+4
8588  19cf 89            	pushw	x
8589  19d0 ae0022        	ldw	x,#_ee_K+8
8590  19d3 cd0000        	call	c_eewrw
8592  19d6 85            	popw	x
8594  19d7 204a          	jra	L1073
8595  19d9               L7763:
8596                     ; 1792 		else if((mess[9]&0x0f)==0x02)
8598  19d9 b6cd          	ld	a,_mess+9
8599  19db a40f          	and	a,#15
8600  19dd a102          	cp	a,#2
8601  19df 260b          	jrne	L3073
8602                     ; 1794 			ee_K[2][1]++;
8604  19e1 ce0024        	ldw	x,_ee_K+10
8605  19e4 1c0001        	addw	x,#1
8606  19e7 cf0024        	ldw	_ee_K+10,x
8608  19ea 2037          	jra	L1073
8609  19ec               L3073:
8610                     ; 1796 		else if((mess[9]&0x0f)==0x03)
8612  19ec b6cd          	ld	a,_mess+9
8613  19ee a40f          	and	a,#15
8614  19f0 a103          	cp	a,#3
8615  19f2 260b          	jrne	L7073
8616                     ; 1798 			ee_K[2][1]+=10;
8618  19f4 ce0024        	ldw	x,_ee_K+10
8619  19f7 1c000a        	addw	x,#10
8620  19fa cf0024        	ldw	_ee_K+10,x
8622  19fd 2024          	jra	L1073
8623  19ff               L7073:
8624                     ; 1800 		else if((mess[9]&0x0f)==0x04)
8626  19ff b6cd          	ld	a,_mess+9
8627  1a01 a40f          	and	a,#15
8628  1a03 a104          	cp	a,#4
8629  1a05 260b          	jrne	L3173
8630                     ; 1802 			ee_K[2][1]--;
8632  1a07 ce0024        	ldw	x,_ee_K+10
8633  1a0a 1d0001        	subw	x,#1
8634  1a0d cf0024        	ldw	_ee_K+10,x
8636  1a10 2011          	jra	L1073
8637  1a12               L3173:
8638                     ; 1804 		else if((mess[9]&0x0f)==0x05)
8640  1a12 b6cd          	ld	a,_mess+9
8641  1a14 a40f          	and	a,#15
8642  1a16 a105          	cp	a,#5
8643  1a18 2609          	jrne	L1073
8644                     ; 1806 			ee_K[2][1]-=10;
8646  1a1a ce0024        	ldw	x,_ee_K+10
8647  1a1d 1d000a        	subw	x,#10
8648  1a20 cf0024        	ldw	_ee_K+10,x
8649  1a23               L1073:
8650                     ; 1811 		granee(&ee_K[2][1],10,30000);
8652  1a23 ae7530        	ldw	x,#30000
8653  1a26 89            	pushw	x
8654  1a27 ae000a        	ldw	x,#10
8655  1a2a 89            	pushw	x
8656  1a2b ae0024        	ldw	x,#_ee_K+10
8657  1a2e cd008e        	call	_granee
8659  1a31 5b04          	addw	sp,#4
8661  1a33 2062          	jra	L5463
8662  1a35               L5763:
8663                     ; 1815 	else if((mess[9]&0xf0)==0x30)
8665  1a35 b6cd          	ld	a,_mess+9
8666  1a37 a4f0          	and	a,#240
8667  1a39 a130          	cp	a,#48
8668  1a3b 265a          	jrne	L5463
8669                     ; 1817 		if((mess[9]&0x0f)==0x02)
8671  1a3d b6cd          	ld	a,_mess+9
8672  1a3f a40f          	and	a,#15
8673  1a41 a102          	cp	a,#2
8674  1a43 260b          	jrne	L5273
8675                     ; 1819 			ee_K[3][1]++;
8677  1a45 ce0028        	ldw	x,_ee_K+14
8678  1a48 1c0001        	addw	x,#1
8679  1a4b cf0028        	ldw	_ee_K+14,x
8681  1a4e 2037          	jra	L7273
8682  1a50               L5273:
8683                     ; 1821 		else if((mess[9]&0x0f)==0x03)
8685  1a50 b6cd          	ld	a,_mess+9
8686  1a52 a40f          	and	a,#15
8687  1a54 a103          	cp	a,#3
8688  1a56 260b          	jrne	L1373
8689                     ; 1823 			ee_K[3][1]+=10;
8691  1a58 ce0028        	ldw	x,_ee_K+14
8692  1a5b 1c000a        	addw	x,#10
8693  1a5e cf0028        	ldw	_ee_K+14,x
8695  1a61 2024          	jra	L7273
8696  1a63               L1373:
8697                     ; 1825 		else if((mess[9]&0x0f)==0x04)
8699  1a63 b6cd          	ld	a,_mess+9
8700  1a65 a40f          	and	a,#15
8701  1a67 a104          	cp	a,#4
8702  1a69 260b          	jrne	L5373
8703                     ; 1827 			ee_K[3][1]--;
8705  1a6b ce0028        	ldw	x,_ee_K+14
8706  1a6e 1d0001        	subw	x,#1
8707  1a71 cf0028        	ldw	_ee_K+14,x
8709  1a74 2011          	jra	L7273
8710  1a76               L5373:
8711                     ; 1829 		else if((mess[9]&0x0f)==0x05)
8713  1a76 b6cd          	ld	a,_mess+9
8714  1a78 a40f          	and	a,#15
8715  1a7a a105          	cp	a,#5
8716  1a7c 2609          	jrne	L7273
8717                     ; 1831 			ee_K[3][1]-=10;
8719  1a7e ce0028        	ldw	x,_ee_K+14
8720  1a81 1d000a        	subw	x,#10
8721  1a84 cf0028        	ldw	_ee_K+14,x
8722  1a87               L7273:
8723                     ; 1833 		granee(&ee_K[3][1],300,517);									
8725  1a87 ae0205        	ldw	x,#517
8726  1a8a 89            	pushw	x
8727  1a8b ae012c        	ldw	x,#300
8728  1a8e 89            	pushw	x
8729  1a8f ae0028        	ldw	x,#_ee_K+14
8730  1a92 cd008e        	call	_granee
8732  1a95 5b04          	addw	sp,#4
8733  1a97               L5463:
8734                     ; 1836 	link_cnt=0;
8736  1a97 5f            	clrw	x
8737  1a98 bf61          	ldw	_link_cnt,x
8738                     ; 1837      link=ON;
8740  1a9a 35550063      	mov	_link,#85
8741                     ; 1838      if(res_fl_)
8743  1a9e 725d000a      	tnz	_res_fl_
8744  1aa2 2603          	jrne	L422
8745  1aa4 cc1de6        	jp	L3353
8746  1aa7               L422:
8747                     ; 1840       	res_fl_=0;
8749  1aa7 4f            	clr	a
8750  1aa8 ae000a        	ldw	x,#_res_fl_
8751  1aab cd0000        	call	c_eewrc
8753  1aae ace61de6      	jpf	L3353
8754  1ab2               L7163:
8755                     ; 1846 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8757  1ab2 b6ca          	ld	a,_mess+6
8758  1ab4 a1ff          	cp	a,#255
8759  1ab6 2703          	jreq	L622
8760  1ab8 cc1b46        	jp	L7473
8761  1abb               L622:
8763  1abb b6cb          	ld	a,_mess+7
8764  1abd a1ff          	cp	a,#255
8765  1abf 2703          	jreq	L032
8766  1ac1 cc1b46        	jp	L7473
8767  1ac4               L032:
8769  1ac4 b6cc          	ld	a,_mess+8
8770  1ac6 a162          	cp	a,#98
8771  1ac8 267c          	jrne	L7473
8772                     ; 1849 	tempSS=mess[9]+(mess[10]*256);
8774  1aca b6ce          	ld	a,_mess+10
8775  1acc 5f            	clrw	x
8776  1acd 97            	ld	xl,a
8777  1ace 4f            	clr	a
8778  1acf 02            	rlwa	x,a
8779  1ad0 01            	rrwa	x,a
8780  1ad1 bbcd          	add	a,_mess+9
8781  1ad3 2401          	jrnc	L471
8782  1ad5 5c            	incw	x
8783  1ad6               L471:
8784  1ad6 02            	rlwa	x,a
8785  1ad7 1f04          	ldw	(OFST-1,sp),x
8786  1ad9 01            	rrwa	x,a
8787                     ; 1850 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8789  1ada ce0014        	ldw	x,_ee_Umax
8790  1add 1304          	cpw	x,(OFST-1,sp)
8791  1adf 270a          	jreq	L1573
8794  1ae1 1e04          	ldw	x,(OFST-1,sp)
8795  1ae3 89            	pushw	x
8796  1ae4 ae0014        	ldw	x,#_ee_Umax
8797  1ae7 cd0000        	call	c_eewrw
8799  1aea 85            	popw	x
8800  1aeb               L1573:
8801                     ; 1851 	tempSS=mess[11]+(mess[12]*256);
8803  1aeb b6d0          	ld	a,_mess+12
8804  1aed 5f            	clrw	x
8805  1aee 97            	ld	xl,a
8806  1aef 4f            	clr	a
8807  1af0 02            	rlwa	x,a
8808  1af1 01            	rrwa	x,a
8809  1af2 bbcf          	add	a,_mess+11
8810  1af4 2401          	jrnc	L671
8811  1af6 5c            	incw	x
8812  1af7               L671:
8813  1af7 02            	rlwa	x,a
8814  1af8 1f04          	ldw	(OFST-1,sp),x
8815  1afa 01            	rrwa	x,a
8816                     ; 1852 	if(ee_dU!=tempSS) ee_dU=tempSS;
8818  1afb ce0012        	ldw	x,_ee_dU
8819  1afe 1304          	cpw	x,(OFST-1,sp)
8820  1b00 270a          	jreq	L3573
8823  1b02 1e04          	ldw	x,(OFST-1,sp)
8824  1b04 89            	pushw	x
8825  1b05 ae0012        	ldw	x,#_ee_dU
8826  1b08 cd0000        	call	c_eewrw
8828  1b0b 85            	popw	x
8829  1b0c               L3573:
8830                     ; 1853 	if((mess[13]&0x0f)==0x5)
8832  1b0c b6d1          	ld	a,_mess+13
8833  1b0e a40f          	and	a,#15
8834  1b10 a105          	cp	a,#5
8835  1b12 261a          	jrne	L5573
8836                     ; 1855 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8838  1b14 ce0006        	ldw	x,_ee_AVT_MODE
8839  1b17 a30055        	cpw	x,#85
8840  1b1a 2603          	jrne	L232
8841  1b1c cc1de6        	jp	L3353
8842  1b1f               L232:
8845  1b1f ae0055        	ldw	x,#85
8846  1b22 89            	pushw	x
8847  1b23 ae0006        	ldw	x,#_ee_AVT_MODE
8848  1b26 cd0000        	call	c_eewrw
8850  1b29 85            	popw	x
8851  1b2a ace61de6      	jpf	L3353
8852  1b2e               L5573:
8853                     ; 1857 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8855  1b2e ce0006        	ldw	x,_ee_AVT_MODE
8856  1b31 a30055        	cpw	x,#85
8857  1b34 2703          	jreq	L432
8858  1b36 cc1de6        	jp	L3353
8859  1b39               L432:
8862  1b39 5f            	clrw	x
8863  1b3a 89            	pushw	x
8864  1b3b ae0006        	ldw	x,#_ee_AVT_MODE
8865  1b3e cd0000        	call	c_eewrw
8867  1b41 85            	popw	x
8868  1b42 ace61de6      	jpf	L3353
8869  1b46               L7473:
8870                     ; 1860 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8872  1b46 b6ca          	ld	a,_mess+6
8873  1b48 a1ff          	cp	a,#255
8874  1b4a 2703          	jreq	L632
8875  1b4c cc1c1d        	jp	L7673
8876  1b4f               L632:
8878  1b4f b6cb          	ld	a,_mess+7
8879  1b51 a1ff          	cp	a,#255
8880  1b53 2703          	jreq	L042
8881  1b55 cc1c1d        	jp	L7673
8882  1b58               L042:
8884  1b58 b6cc          	ld	a,_mess+8
8885  1b5a a126          	cp	a,#38
8886  1b5c 2709          	jreq	L1773
8888  1b5e b6cc          	ld	a,_mess+8
8889  1b60 a129          	cp	a,#41
8890  1b62 2703          	jreq	L242
8891  1b64 cc1c1d        	jp	L7673
8892  1b67               L242:
8893  1b67               L1773:
8894                     ; 1863 	tempSS=mess[9]+(mess[10]*256);
8896  1b67 b6ce          	ld	a,_mess+10
8897  1b69 5f            	clrw	x
8898  1b6a 97            	ld	xl,a
8899  1b6b 4f            	clr	a
8900  1b6c 02            	rlwa	x,a
8901  1b6d 01            	rrwa	x,a
8902  1b6e bbcd          	add	a,_mess+9
8903  1b70 2401          	jrnc	L002
8904  1b72 5c            	incw	x
8905  1b73               L002:
8906  1b73 02            	rlwa	x,a
8907  1b74 1f04          	ldw	(OFST-1,sp),x
8908  1b76 01            	rrwa	x,a
8909                     ; 1864 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8911  1b77 ce0010        	ldw	x,_ee_tmax
8912  1b7a 1304          	cpw	x,(OFST-1,sp)
8913  1b7c 270a          	jreq	L3773
8916  1b7e 1e04          	ldw	x,(OFST-1,sp)
8917  1b80 89            	pushw	x
8918  1b81 ae0010        	ldw	x,#_ee_tmax
8919  1b84 cd0000        	call	c_eewrw
8921  1b87 85            	popw	x
8922  1b88               L3773:
8923                     ; 1865 	tempSS=mess[11]+(mess[12]*256);
8925  1b88 b6d0          	ld	a,_mess+12
8926  1b8a 5f            	clrw	x
8927  1b8b 97            	ld	xl,a
8928  1b8c 4f            	clr	a
8929  1b8d 02            	rlwa	x,a
8930  1b8e 01            	rrwa	x,a
8931  1b8f bbcf          	add	a,_mess+11
8932  1b91 2401          	jrnc	L202
8933  1b93 5c            	incw	x
8934  1b94               L202:
8935  1b94 02            	rlwa	x,a
8936  1b95 1f04          	ldw	(OFST-1,sp),x
8937  1b97 01            	rrwa	x,a
8938                     ; 1866 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8940  1b98 ce000e        	ldw	x,_ee_tsign
8941  1b9b 1304          	cpw	x,(OFST-1,sp)
8942  1b9d 270a          	jreq	L5773
8945  1b9f 1e04          	ldw	x,(OFST-1,sp)
8946  1ba1 89            	pushw	x
8947  1ba2 ae000e        	ldw	x,#_ee_tsign
8948  1ba5 cd0000        	call	c_eewrw
8950  1ba8 85            	popw	x
8951  1ba9               L5773:
8952                     ; 1869 	if(mess[8]==MEM_KF1)
8954  1ba9 b6cc          	ld	a,_mess+8
8955  1bab a126          	cp	a,#38
8956  1bad 2623          	jrne	L7773
8957                     ; 1871 		if(ee_DEVICE!=0)ee_DEVICE=0;
8959  1baf ce0004        	ldw	x,_ee_DEVICE
8960  1bb2 2709          	jreq	L1004
8963  1bb4 5f            	clrw	x
8964  1bb5 89            	pushw	x
8965  1bb6 ae0004        	ldw	x,#_ee_DEVICE
8966  1bb9 cd0000        	call	c_eewrw
8968  1bbc 85            	popw	x
8969  1bbd               L1004:
8970                     ; 1872 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8972  1bbd b6d1          	ld	a,_mess+13
8973  1bbf 5f            	clrw	x
8974  1bc0 97            	ld	xl,a
8975  1bc1 c30016        	cpw	x,_ee_TZAS
8976  1bc4 270c          	jreq	L7773
8979  1bc6 b6d1          	ld	a,_mess+13
8980  1bc8 5f            	clrw	x
8981  1bc9 97            	ld	xl,a
8982  1bca 89            	pushw	x
8983  1bcb ae0016        	ldw	x,#_ee_TZAS
8984  1bce cd0000        	call	c_eewrw
8986  1bd1 85            	popw	x
8987  1bd2               L7773:
8988                     ; 1874 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8990  1bd2 b6cc          	ld	a,_mess+8
8991  1bd4 a129          	cp	a,#41
8992  1bd6 2703          	jreq	L442
8993  1bd8 cc1de6        	jp	L3353
8994  1bdb               L442:
8995                     ; 1876 		if(ee_DEVICE!=1)ee_DEVICE=1;
8997  1bdb ce0004        	ldw	x,_ee_DEVICE
8998  1bde a30001        	cpw	x,#1
8999  1be1 270b          	jreq	L7004
9002  1be3 ae0001        	ldw	x,#1
9003  1be6 89            	pushw	x
9004  1be7 ae0004        	ldw	x,#_ee_DEVICE
9005  1bea cd0000        	call	c_eewrw
9007  1bed 85            	popw	x
9008  1bee               L7004:
9009                     ; 1877 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
9011  1bee b6d1          	ld	a,_mess+13
9012  1bf0 5f            	clrw	x
9013  1bf1 97            	ld	xl,a
9014  1bf2 c30002        	cpw	x,_ee_IMAXVENT
9015  1bf5 270c          	jreq	L1104
9018  1bf7 b6d1          	ld	a,_mess+13
9019  1bf9 5f            	clrw	x
9020  1bfa 97            	ld	xl,a
9021  1bfb 89            	pushw	x
9022  1bfc ae0002        	ldw	x,#_ee_IMAXVENT
9023  1bff cd0000        	call	c_eewrw
9025  1c02 85            	popw	x
9026  1c03               L1104:
9027                     ; 1878 			if(ee_TZAS!=3) ee_TZAS=3;
9029  1c03 ce0016        	ldw	x,_ee_TZAS
9030  1c06 a30003        	cpw	x,#3
9031  1c09 2603          	jrne	L642
9032  1c0b cc1de6        	jp	L3353
9033  1c0e               L642:
9036  1c0e ae0003        	ldw	x,#3
9037  1c11 89            	pushw	x
9038  1c12 ae0016        	ldw	x,#_ee_TZAS
9039  1c15 cd0000        	call	c_eewrw
9041  1c18 85            	popw	x
9042  1c19 ace61de6      	jpf	L3353
9043  1c1d               L7673:
9044                     ; 1882 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
9046  1c1d b6ca          	ld	a,_mess+6
9047  1c1f c10005        	cp	a,_adress
9048  1c22 262d          	jrne	L7104
9050  1c24 b6cb          	ld	a,_mess+7
9051  1c26 c10005        	cp	a,_adress
9052  1c29 2626          	jrne	L7104
9054  1c2b b6cc          	ld	a,_mess+8
9055  1c2d a116          	cp	a,#22
9056  1c2f 2620          	jrne	L7104
9058  1c31 b6cd          	ld	a,_mess+9
9059  1c33 a163          	cp	a,#99
9060  1c35 261a          	jrne	L7104
9061                     ; 1884 	flags&=0b11100001;
9063  1c37 b60b          	ld	a,_flags
9064  1c39 a4e1          	and	a,#225
9065  1c3b b70b          	ld	_flags,a
9066                     ; 1885 	tsign_cnt=0;
9068  1c3d 5f            	clrw	x
9069  1c3e bf4d          	ldw	_tsign_cnt,x
9070                     ; 1886 	tmax_cnt=0;
9072  1c40 5f            	clrw	x
9073  1c41 bf4b          	ldw	_tmax_cnt,x
9074                     ; 1887 	umax_cnt=0;
9076  1c43 5f            	clrw	x
9077  1c44 bf66          	ldw	_umax_cnt,x
9078                     ; 1888 	umin_cnt=0;
9080  1c46 5f            	clrw	x
9081  1c47 bf64          	ldw	_umin_cnt,x
9082                     ; 1889 	led_drv_cnt=30;
9084  1c49 351e001c      	mov	_led_drv_cnt,#30
9086  1c4d ace61de6      	jpf	L3353
9087  1c51               L7104:
9088                     ; 1892 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
9090  1c51 b6ca          	ld	a,_mess+6
9091  1c53 c10005        	cp	a,_adress
9092  1c56 2620          	jrne	L3204
9094  1c58 b6cb          	ld	a,_mess+7
9095  1c5a c10005        	cp	a,_adress
9096  1c5d 2619          	jrne	L3204
9098  1c5f b6cc          	ld	a,_mess+8
9099  1c61 a116          	cp	a,#22
9100  1c63 2613          	jrne	L3204
9102  1c65 b6cd          	ld	a,_mess+9
9103  1c67 a164          	cp	a,#100
9104  1c69 260d          	jrne	L3204
9105                     ; 1894 	vent_resurs=0;
9107  1c6b 5f            	clrw	x
9108  1c6c 89            	pushw	x
9109  1c6d ae0000        	ldw	x,#_vent_resurs
9110  1c70 cd0000        	call	c_eewrw
9112  1c73 85            	popw	x
9114  1c74 ace61de6      	jpf	L3353
9115  1c78               L3204:
9116                     ; 1898 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
9118  1c78 b6ca          	ld	a,_mess+6
9119  1c7a a1ff          	cp	a,#255
9120  1c7c 265f          	jrne	L7204
9122  1c7e b6cb          	ld	a,_mess+7
9123  1c80 a1ff          	cp	a,#255
9124  1c82 2659          	jrne	L7204
9126  1c84 b6cc          	ld	a,_mess+8
9127  1c86 a116          	cp	a,#22
9128  1c88 2653          	jrne	L7204
9130  1c8a b6cd          	ld	a,_mess+9
9131  1c8c a116          	cp	a,#22
9132  1c8e 264d          	jrne	L7204
9133                     ; 1900 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9135  1c90 b6ce          	ld	a,_mess+10
9136  1c92 a155          	cp	a,#85
9137  1c94 260f          	jrne	L1304
9139  1c96 b6cf          	ld	a,_mess+11
9140  1c98 a155          	cp	a,#85
9141  1c9a 2609          	jrne	L1304
9144  1c9c be5e          	ldw	x,__x_
9145  1c9e 1c0001        	addw	x,#1
9146  1ca1 bf5e          	ldw	__x_,x
9148  1ca3 2024          	jra	L3304
9149  1ca5               L1304:
9150                     ; 1901 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9152  1ca5 b6ce          	ld	a,_mess+10
9153  1ca7 a166          	cp	a,#102
9154  1ca9 260f          	jrne	L5304
9156  1cab b6cf          	ld	a,_mess+11
9157  1cad a166          	cp	a,#102
9158  1caf 2609          	jrne	L5304
9161  1cb1 be5e          	ldw	x,__x_
9162  1cb3 1d0001        	subw	x,#1
9163  1cb6 bf5e          	ldw	__x_,x
9165  1cb8 200f          	jra	L3304
9166  1cba               L5304:
9167                     ; 1902 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9169  1cba b6ce          	ld	a,_mess+10
9170  1cbc a177          	cp	a,#119
9171  1cbe 2609          	jrne	L3304
9173  1cc0 b6cf          	ld	a,_mess+11
9174  1cc2 a177          	cp	a,#119
9175  1cc4 2603          	jrne	L3304
9178  1cc6 5f            	clrw	x
9179  1cc7 bf5e          	ldw	__x_,x
9180  1cc9               L3304:
9181                     ; 1903      gran(&_x_,-XMAX,XMAX);
9183  1cc9 ae0019        	ldw	x,#25
9184  1ccc 89            	pushw	x
9185  1ccd aeffe7        	ldw	x,#65511
9186  1cd0 89            	pushw	x
9187  1cd1 ae005e        	ldw	x,#__x_
9188  1cd4 cd006d        	call	_gran
9190  1cd7 5b04          	addw	sp,#4
9192  1cd9 ace61de6      	jpf	L3353
9193  1cdd               L7204:
9194                     ; 1905 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9196  1cdd b6ca          	ld	a,_mess+6
9197  1cdf c10005        	cp	a,_adress
9198  1ce2 2665          	jrne	L5404
9200  1ce4 b6cb          	ld	a,_mess+7
9201  1ce6 c10005        	cp	a,_adress
9202  1ce9 265e          	jrne	L5404
9204  1ceb b6cc          	ld	a,_mess+8
9205  1ced a116          	cp	a,#22
9206  1cef 2658          	jrne	L5404
9208  1cf1 b6cd          	ld	a,_mess+9
9209  1cf3 b1ce          	cp	a,_mess+10
9210  1cf5 2652          	jrne	L5404
9212  1cf7 b6cd          	ld	a,_mess+9
9213  1cf9 a1ee          	cp	a,#238
9214  1cfb 264c          	jrne	L5404
9215                     ; 1907 	rotor_int++;
9217  1cfd be1d          	ldw	x,_rotor_int
9218  1cff 1c0001        	addw	x,#1
9219  1d02 bf1d          	ldw	_rotor_int,x
9220                     ; 1908      tempI=pwm_u;
9222  1d04 be0e          	ldw	x,_pwm_u
9223  1d06 1f04          	ldw	(OFST-1,sp),x
9224                     ; 1909 	ee_U_AVT=tempI;
9226  1d08 1e04          	ldw	x,(OFST-1,sp)
9227  1d0a 89            	pushw	x
9228  1d0b ae000c        	ldw	x,#_ee_U_AVT
9229  1d0e cd0000        	call	c_eewrw
9231  1d11 85            	popw	x
9232                     ; 1910 	UU_AVT=Un;
9234  1d12 be6d          	ldw	x,_Un
9235  1d14 89            	pushw	x
9236  1d15 ae0008        	ldw	x,#_UU_AVT
9237  1d18 cd0000        	call	c_eewrw
9239  1d1b 85            	popw	x
9240                     ; 1911 	delay_ms(100);
9242  1d1c ae0064        	ldw	x,#100
9243  1d1f cd00b9        	call	_delay_ms
9245                     ; 1912 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9247  1d22 ce000c        	ldw	x,_ee_U_AVT
9248  1d25 1304          	cpw	x,(OFST-1,sp)
9249  1d27 2703          	jreq	L052
9250  1d29 cc1de6        	jp	L3353
9251  1d2c               L052:
9254  1d2c 4b00          	push	#0
9255  1d2e 4b00          	push	#0
9256  1d30 4b00          	push	#0
9257  1d32 4b00          	push	#0
9258  1d34 4bdd          	push	#221
9259  1d36 4bdd          	push	#221
9260  1d38 4b91          	push	#145
9261  1d3a 3b0005        	push	_adress
9262  1d3d ae018e        	ldw	x,#398
9263  1d40 cd15e7        	call	_can_transmit
9265  1d43 5b08          	addw	sp,#8
9266  1d45 ace61de6      	jpf	L3353
9267  1d49               L5404:
9268                     ; 1917 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9270  1d49 b6cb          	ld	a,_mess+7
9271  1d4b a1da          	cp	a,#218
9272  1d4d 2652          	jrne	L3504
9274  1d4f b6ca          	ld	a,_mess+6
9275  1d51 c10005        	cp	a,_adress
9276  1d54 274b          	jreq	L3504
9278  1d56 b6ca          	ld	a,_mess+6
9279  1d58 a106          	cp	a,#6
9280  1d5a 2445          	jruge	L3504
9281                     ; 1919 	i_main_bps_cnt[mess[6]]=0;
9283  1d5c b6ca          	ld	a,_mess+6
9284  1d5e 5f            	clrw	x
9285  1d5f 97            	ld	xl,a
9286  1d60 6f09          	clr	(_i_main_bps_cnt,x)
9287                     ; 1920 	i_main_flag[mess[6]]=1;
9289  1d62 b6ca          	ld	a,_mess+6
9290  1d64 5f            	clrw	x
9291  1d65 97            	ld	xl,a
9292  1d66 a601          	ld	a,#1
9293  1d68 e714          	ld	(_i_main_flag,x),a
9294                     ; 1921 	if(bMAIN)
9296                     	btst	_bMAIN
9297  1d6f 2475          	jruge	L3353
9298                     ; 1923 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9300  1d71 b6cd          	ld	a,_mess+9
9301  1d73 5f            	clrw	x
9302  1d74 97            	ld	xl,a
9303  1d75 4f            	clr	a
9304  1d76 02            	rlwa	x,a
9305  1d77 1f01          	ldw	(OFST-4,sp),x
9306  1d79 b6cc          	ld	a,_mess+8
9307  1d7b 5f            	clrw	x
9308  1d7c 97            	ld	xl,a
9309  1d7d 72fb01        	addw	x,(OFST-4,sp)
9310  1d80 b6ca          	ld	a,_mess+6
9311  1d82 905f          	clrw	y
9312  1d84 9097          	ld	yl,a
9313  1d86 9058          	sllw	y
9314  1d88 90ef1a        	ldw	(_i_main,y),x
9315                     ; 1924 		i_main[adress]=I;
9317  1d8b c60005        	ld	a,_adress
9318  1d8e 5f            	clrw	x
9319  1d8f 97            	ld	xl,a
9320  1d90 58            	sllw	x
9321  1d91 90be6f        	ldw	y,_I
9322  1d94 ef1a          	ldw	(_i_main,x),y
9323                     ; 1925      	i_main_flag[adress]=1;
9325  1d96 c60005        	ld	a,_adress
9326  1d99 5f            	clrw	x
9327  1d9a 97            	ld	xl,a
9328  1d9b a601          	ld	a,#1
9329  1d9d e714          	ld	(_i_main_flag,x),a
9330  1d9f 2045          	jra	L3353
9331  1da1               L3504:
9332                     ; 1929 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9334  1da1 b6cb          	ld	a,_mess+7
9335  1da3 a1db          	cp	a,#219
9336  1da5 263f          	jrne	L3353
9338  1da7 b6ca          	ld	a,_mess+6
9339  1da9 c10005        	cp	a,_adress
9340  1dac 2738          	jreq	L3353
9342  1dae b6ca          	ld	a,_mess+6
9343  1db0 a106          	cp	a,#6
9344  1db2 2432          	jruge	L3353
9345                     ; 1931 	i_main_bps_cnt[mess[6]]=0;
9347  1db4 b6ca          	ld	a,_mess+6
9348  1db6 5f            	clrw	x
9349  1db7 97            	ld	xl,a
9350  1db8 6f09          	clr	(_i_main_bps_cnt,x)
9351                     ; 1932 	i_main_flag[mess[6]]=1;		
9353  1dba b6ca          	ld	a,_mess+6
9354  1dbc 5f            	clrw	x
9355  1dbd 97            	ld	xl,a
9356  1dbe a601          	ld	a,#1
9357  1dc0 e714          	ld	(_i_main_flag,x),a
9358                     ; 1933 	if(bMAIN)
9360                     	btst	_bMAIN
9361  1dc7 241d          	jruge	L3353
9362                     ; 1935 		if(mess[9]==0)i_main_flag[i]=1;
9364  1dc9 3dcd          	tnz	_mess+9
9365  1dcb 260a          	jrne	L5604
9368  1dcd 7b03          	ld	a,(OFST-2,sp)
9369  1dcf 5f            	clrw	x
9370  1dd0 97            	ld	xl,a
9371  1dd1 a601          	ld	a,#1
9372  1dd3 e714          	ld	(_i_main_flag,x),a
9374  1dd5 2006          	jra	L7604
9375  1dd7               L5604:
9376                     ; 1936 		else i_main_flag[i]=0;
9378  1dd7 7b03          	ld	a,(OFST-2,sp)
9379  1dd9 5f            	clrw	x
9380  1dda 97            	ld	xl,a
9381  1ddb 6f14          	clr	(_i_main_flag,x)
9382  1ddd               L7604:
9383                     ; 1937 		i_main_flag[adress]=1;
9385  1ddd c60005        	ld	a,_adress
9386  1de0 5f            	clrw	x
9387  1de1 97            	ld	xl,a
9388  1de2 a601          	ld	a,#1
9389  1de4 e714          	ld	(_i_main_flag,x),a
9390  1de6               L3353:
9391                     ; 1943 can_in_an_end:
9391                     ; 1944 bCAN_RX=0;
9393  1de6 3f0a          	clr	_bCAN_RX
9394                     ; 1945 }   
9397  1de8 5b05          	addw	sp,#5
9398  1dea 81            	ret
9421                     ; 1948 void t4_init(void){
9422                     	switch	.text
9423  1deb               _t4_init:
9427                     ; 1949 	TIM4->PSCR = 4;
9429  1deb 35045345      	mov	21317,#4
9430                     ; 1950 	TIM4->ARR= 61;
9432  1def 353d5346      	mov	21318,#61
9433                     ; 1951 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9435  1df3 72105341      	bset	21313,#0
9436                     ; 1953 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9438  1df7 35855340      	mov	21312,#133
9439                     ; 1955 }
9442  1dfb 81            	ret
9465                     ; 1958 void t1_init(void)
9465                     ; 1959 {
9466                     	switch	.text
9467  1dfc               _t1_init:
9471                     ; 1960 TIM1->ARRH= 0x03;
9473  1dfc 35035262      	mov	21090,#3
9474                     ; 1961 TIM1->ARRL= 0xff;
9476  1e00 35ff5263      	mov	21091,#255
9477                     ; 1962 TIM1->CCR1H= 0x00;	
9479  1e04 725f5265      	clr	21093
9480                     ; 1963 TIM1->CCR1L= 0xff;
9482  1e08 35ff5266      	mov	21094,#255
9483                     ; 1964 TIM1->CCR2H= 0x00;	
9485  1e0c 725f5267      	clr	21095
9486                     ; 1965 TIM1->CCR2L= 0x00;
9488  1e10 725f5268      	clr	21096
9489                     ; 1966 TIM1->CCR3H= 0x00;	
9491  1e14 725f5269      	clr	21097
9492                     ; 1967 TIM1->CCR3L= 0x64;
9494  1e18 3564526a      	mov	21098,#100
9495                     ; 1969 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9497  1e1c 35685258      	mov	21080,#104
9498                     ; 1970 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9500  1e20 35685259      	mov	21081,#104
9501                     ; 1971 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9503  1e24 3568525a      	mov	21082,#104
9504                     ; 1972 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9506  1e28 3511525c      	mov	21084,#17
9507                     ; 1973 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9509  1e2c 3501525d      	mov	21085,#1
9510                     ; 1974 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9512  1e30 35815250      	mov	21072,#129
9513                     ; 1975 TIM1->BKR|= TIM1_BKR_AOE;
9515  1e34 721c526d      	bset	21101,#6
9516                     ; 1976 }
9519  1e38 81            	ret
9544                     ; 1980 void adc2_init(void)
9544                     ; 1981 {
9545                     	switch	.text
9546  1e39               _adc2_init:
9550                     ; 1982 adc_plazma[0]++;
9552  1e39 beb6          	ldw	x,_adc_plazma
9553  1e3b 1c0001        	addw	x,#1
9554  1e3e bfb6          	ldw	_adc_plazma,x
9555                     ; 2006 GPIOB->DDR&=~(1<<4);
9557  1e40 72195007      	bres	20487,#4
9558                     ; 2007 GPIOB->CR1&=~(1<<4);
9560  1e44 72195008      	bres	20488,#4
9561                     ; 2008 GPIOB->CR2&=~(1<<4);
9563  1e48 72195009      	bres	20489,#4
9564                     ; 2010 GPIOB->DDR&=~(1<<5);
9566  1e4c 721b5007      	bres	20487,#5
9567                     ; 2011 GPIOB->CR1&=~(1<<5);
9569  1e50 721b5008      	bres	20488,#5
9570                     ; 2012 GPIOB->CR2&=~(1<<5);
9572  1e54 721b5009      	bres	20489,#5
9573                     ; 2014 GPIOB->DDR&=~(1<<6);
9575  1e58 721d5007      	bres	20487,#6
9576                     ; 2015 GPIOB->CR1&=~(1<<6);
9578  1e5c 721d5008      	bres	20488,#6
9579                     ; 2016 GPIOB->CR2&=~(1<<6);
9581  1e60 721d5009      	bres	20489,#6
9582                     ; 2018 GPIOB->DDR&=~(1<<7);
9584  1e64 721f5007      	bres	20487,#7
9585                     ; 2019 GPIOB->CR1&=~(1<<7);
9587  1e68 721f5008      	bres	20488,#7
9588                     ; 2020 GPIOB->CR2&=~(1<<7);
9590  1e6c 721f5009      	bres	20489,#7
9591                     ; 2030 ADC2->TDRL=0xff;
9593  1e70 35ff5407      	mov	21511,#255
9594                     ; 2032 ADC2->CR2=0x08;
9596  1e74 35085402      	mov	21506,#8
9597                     ; 2033 ADC2->CR1=0x40;
9599  1e78 35405401      	mov	21505,#64
9600                     ; 2036 	ADC2->CSR=0x20+adc_ch+3;
9602  1e7c b6c3          	ld	a,_adc_ch
9603  1e7e ab23          	add	a,#35
9604  1e80 c75400        	ld	21504,a
9605                     ; 2038 	ADC2->CR1|=1;
9607  1e83 72105401      	bset	21505,#0
9608                     ; 2039 	ADC2->CR1|=1;
9610  1e87 72105401      	bset	21505,#0
9611                     ; 2042 adc_plazma[1]=adc_ch;
9613  1e8b b6c3          	ld	a,_adc_ch
9614  1e8d 5f            	clrw	x
9615  1e8e 97            	ld	xl,a
9616  1e8f bfb8          	ldw	_adc_plazma+2,x
9617                     ; 2043 }
9620  1e91 81            	ret
9654                     ; 2052 @far @interrupt void TIM4_UPD_Interrupt (void) 
9654                     ; 2053 {
9656                     	switch	.text
9657  1e92               f_TIM4_UPD_Interrupt:
9661                     ; 2054 TIM4->SR1&=~TIM4_SR1_UIF;
9663  1e92 72115342      	bres	21314,#0
9664                     ; 2056 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9666  1e96 3c08          	inc	_pwm_vent_cnt
9667  1e98 b608          	ld	a,_pwm_vent_cnt
9668  1e9a a10a          	cp	a,#10
9669  1e9c 2502          	jrult	L1314
9672  1e9e 3f08          	clr	_pwm_vent_cnt
9673  1ea0               L1314:
9674                     ; 2057 GPIOB->ODR|=(1<<3);
9676  1ea0 72165005      	bset	20485,#3
9677                     ; 2058 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9679  1ea4 b608          	ld	a,_pwm_vent_cnt
9680  1ea6 a105          	cp	a,#5
9681  1ea8 2504          	jrult	L3314
9684  1eaa 72175005      	bres	20485,#3
9685  1eae               L3314:
9686                     ; 2063 if(++t0_cnt0>=100)
9688  1eae 9c            	rvf
9689  1eaf be01          	ldw	x,_t0_cnt0
9690  1eb1 1c0001        	addw	x,#1
9691  1eb4 bf01          	ldw	_t0_cnt0,x
9692  1eb6 a30064        	cpw	x,#100
9693  1eb9 2f3f          	jrslt	L5314
9694                     ; 2065 	t0_cnt0=0;
9696  1ebb 5f            	clrw	x
9697  1ebc bf01          	ldw	_t0_cnt0,x
9698                     ; 2066 	b100Hz=1;
9700  1ebe 72100008      	bset	_b100Hz
9701                     ; 2068 	if(++t0_cnt1>=10)
9703  1ec2 3c03          	inc	_t0_cnt1
9704  1ec4 b603          	ld	a,_t0_cnt1
9705  1ec6 a10a          	cp	a,#10
9706  1ec8 2506          	jrult	L7314
9707                     ; 2070 		t0_cnt1=0;
9709  1eca 3f03          	clr	_t0_cnt1
9710                     ; 2071 		b10Hz=1;
9712  1ecc 72100007      	bset	_b10Hz
9713  1ed0               L7314:
9714                     ; 2074 	if(++t0_cnt2>=20)
9716  1ed0 3c04          	inc	_t0_cnt2
9717  1ed2 b604          	ld	a,_t0_cnt2
9718  1ed4 a114          	cp	a,#20
9719  1ed6 2506          	jrult	L1414
9720                     ; 2076 		t0_cnt2=0;
9722  1ed8 3f04          	clr	_t0_cnt2
9723                     ; 2077 		b5Hz=1;
9725  1eda 72100006      	bset	_b5Hz
9726  1ede               L1414:
9727                     ; 2081 	if(++t0_cnt4>=50)
9729  1ede 3c06          	inc	_t0_cnt4
9730  1ee0 b606          	ld	a,_t0_cnt4
9731  1ee2 a132          	cp	a,#50
9732  1ee4 2506          	jrult	L3414
9733                     ; 2083 		t0_cnt4=0;
9735  1ee6 3f06          	clr	_t0_cnt4
9736                     ; 2084 		b2Hz=1;
9738  1ee8 72100005      	bset	_b2Hz
9739  1eec               L3414:
9740                     ; 2087 	if(++t0_cnt3>=100)
9742  1eec 3c05          	inc	_t0_cnt3
9743  1eee b605          	ld	a,_t0_cnt3
9744  1ef0 a164          	cp	a,#100
9745  1ef2 2506          	jrult	L5314
9746                     ; 2089 		t0_cnt3=0;
9748  1ef4 3f05          	clr	_t0_cnt3
9749                     ; 2090 		b1Hz=1;
9751  1ef6 72100004      	bset	_b1Hz
9752  1efa               L5314:
9753                     ; 2096 }
9756  1efa 80            	iret
9781                     ; 2099 @far @interrupt void CAN_RX_Interrupt (void) 
9781                     ; 2100 {
9782                     	switch	.text
9783  1efb               f_CAN_RX_Interrupt:
9787                     ; 2102 CAN->PSR= 7;									// page 7 - read messsage
9789  1efb 35075427      	mov	21543,#7
9790                     ; 2104 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9792  1eff ae000e        	ldw	x,#14
9793  1f02               L462:
9794  1f02 d65427        	ld	a,(21543,x)
9795  1f05 e7c3          	ld	(_mess-1,x),a
9796  1f07 5a            	decw	x
9797  1f08 26f8          	jrne	L462
9798                     ; 2115 bCAN_RX=1;
9800  1f0a 3501000a      	mov	_bCAN_RX,#1
9801                     ; 2116 CAN->RFR|=(1<<5);
9803  1f0e 721a5424      	bset	21540,#5
9804                     ; 2118 }
9807  1f12 80            	iret
9830                     ; 2121 @far @interrupt void CAN_TX_Interrupt (void) 
9830                     ; 2122 {
9831                     	switch	.text
9832  1f13               f_CAN_TX_Interrupt:
9836                     ; 2123 if((CAN->TSR)&(1<<0))
9838  1f13 c65422        	ld	a,21538
9839  1f16 a501          	bcp	a,#1
9840  1f18 2708          	jreq	L7614
9841                     ; 2125 	bTX_FREE=1;	
9843  1f1a 35010009      	mov	_bTX_FREE,#1
9844                     ; 2127 	CAN->TSR|=(1<<0);
9846  1f1e 72105422      	bset	21538,#0
9847  1f22               L7614:
9848                     ; 2129 }
9851  1f22 80            	iret
9909                     ; 2132 @far @interrupt void ADC2_EOC_Interrupt (void) {
9910                     	switch	.text
9911  1f23               f_ADC2_EOC_Interrupt:
9913       00000009      OFST:	set	9
9914  1f23 be00          	ldw	x,c_x
9915  1f25 89            	pushw	x
9916  1f26 be00          	ldw	x,c_y
9917  1f28 89            	pushw	x
9918  1f29 be02          	ldw	x,c_lreg+2
9919  1f2b 89            	pushw	x
9920  1f2c be00          	ldw	x,c_lreg
9921  1f2e 89            	pushw	x
9922  1f2f 5209          	subw	sp,#9
9925                     ; 2137 adc_plazma[2]++;
9927  1f31 beba          	ldw	x,_adc_plazma+4
9928  1f33 1c0001        	addw	x,#1
9929  1f36 bfba          	ldw	_adc_plazma+4,x
9930                     ; 2144 ADC2->CSR&=~(1<<7);
9932  1f38 721f5400      	bres	21504,#7
9933                     ; 2146 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9935  1f3c c65405        	ld	a,21509
9936  1f3f b703          	ld	c_lreg+3,a
9937  1f41 3f02          	clr	c_lreg+2
9938  1f43 3f01          	clr	c_lreg+1
9939  1f45 3f00          	clr	c_lreg
9940  1f47 96            	ldw	x,sp
9941  1f48 1c0001        	addw	x,#OFST-8
9942  1f4b cd0000        	call	c_rtol
9944  1f4e c65404        	ld	a,21508
9945  1f51 5f            	clrw	x
9946  1f52 97            	ld	xl,a
9947  1f53 90ae0100      	ldw	y,#256
9948  1f57 cd0000        	call	c_umul
9950  1f5a 96            	ldw	x,sp
9951  1f5b 1c0001        	addw	x,#OFST-8
9952  1f5e cd0000        	call	c_ladd
9954  1f61 96            	ldw	x,sp
9955  1f62 1c0006        	addw	x,#OFST-3
9956  1f65 cd0000        	call	c_rtol
9958                     ; 2151 if(adr_drv_stat==1)
9960  1f68 b608          	ld	a,_adr_drv_stat
9961  1f6a a101          	cp	a,#1
9962  1f6c 260b          	jrne	L7124
9963                     ; 2153 	adr_drv_stat=2;
9965  1f6e 35020008      	mov	_adr_drv_stat,#2
9966                     ; 2154 	adc_buff_[0]=temp_adc;
9968  1f72 1e08          	ldw	x,(OFST-1,sp)
9969  1f74 cf0009        	ldw	_adc_buff_,x
9971  1f77 2020          	jra	L1224
9972  1f79               L7124:
9973                     ; 2157 else if(adr_drv_stat==3)
9975  1f79 b608          	ld	a,_adr_drv_stat
9976  1f7b a103          	cp	a,#3
9977  1f7d 260b          	jrne	L3224
9978                     ; 2159 	adr_drv_stat=4;
9980  1f7f 35040008      	mov	_adr_drv_stat,#4
9981                     ; 2160 	adc_buff_[1]=temp_adc;
9983  1f83 1e08          	ldw	x,(OFST-1,sp)
9984  1f85 cf000b        	ldw	_adc_buff_+2,x
9986  1f88 200f          	jra	L1224
9987  1f8a               L3224:
9988                     ; 2163 else if(adr_drv_stat==5)
9990  1f8a b608          	ld	a,_adr_drv_stat
9991  1f8c a105          	cp	a,#5
9992  1f8e 2609          	jrne	L1224
9993                     ; 2165 	adr_drv_stat=6;
9995  1f90 35060008      	mov	_adr_drv_stat,#6
9996                     ; 2166 	adc_buff_[9]=temp_adc;
9998  1f94 1e08          	ldw	x,(OFST-1,sp)
9999  1f96 cf001b        	ldw	_adc_buff_+18,x
10000  1f99               L1224:
10001                     ; 2169 adc_buff[adc_ch][adc_cnt]=temp_adc;
10003  1f99 b6c2          	ld	a,_adc_cnt
10004  1f9b 5f            	clrw	x
10005  1f9c 97            	ld	xl,a
10006  1f9d 58            	sllw	x
10007  1f9e 1f03          	ldw	(OFST-6,sp),x
10008  1fa0 b6c3          	ld	a,_adc_ch
10009  1fa2 97            	ld	xl,a
10010  1fa3 a620          	ld	a,#32
10011  1fa5 42            	mul	x,a
10012  1fa6 72fb03        	addw	x,(OFST-6,sp)
10013  1fa9 1608          	ldw	y,(OFST-1,sp)
10014  1fab df001d        	ldw	(_adc_buff,x),y
10015                     ; 2175 adc_ch++;
10017  1fae 3cc3          	inc	_adc_ch
10018                     ; 2176 if(adc_ch>=5)
10020  1fb0 b6c3          	ld	a,_adc_ch
10021  1fb2 a105          	cp	a,#5
10022  1fb4 250c          	jrult	L1324
10023                     ; 2179 	adc_ch=0;
10025  1fb6 3fc3          	clr	_adc_ch
10026                     ; 2180 	adc_cnt++;
10028  1fb8 3cc2          	inc	_adc_cnt
10029                     ; 2181 	if(adc_cnt>=16)
10031  1fba b6c2          	ld	a,_adc_cnt
10032  1fbc a110          	cp	a,#16
10033  1fbe 2502          	jrult	L1324
10034                     ; 2183 		adc_cnt=0;
10036  1fc0 3fc2          	clr	_adc_cnt
10037  1fc2               L1324:
10038                     ; 2187 if((adc_cnt&0x03)==0)
10040  1fc2 b6c2          	ld	a,_adc_cnt
10041  1fc4 a503          	bcp	a,#3
10042  1fc6 264b          	jrne	L5324
10043                     ; 2191 	tempSS=0;
10045  1fc8 ae0000        	ldw	x,#0
10046  1fcb 1f08          	ldw	(OFST-1,sp),x
10047  1fcd ae0000        	ldw	x,#0
10048  1fd0 1f06          	ldw	(OFST-3,sp),x
10049                     ; 2192 	for(i=0;i<16;i++)
10051  1fd2 0f05          	clr	(OFST-4,sp)
10052  1fd4               L7324:
10053                     ; 2194 		tempSS+=(signed long)adc_buff[adc_ch][i];
10055  1fd4 7b05          	ld	a,(OFST-4,sp)
10056  1fd6 5f            	clrw	x
10057  1fd7 97            	ld	xl,a
10058  1fd8 58            	sllw	x
10059  1fd9 1f03          	ldw	(OFST-6,sp),x
10060  1fdb b6c3          	ld	a,_adc_ch
10061  1fdd 97            	ld	xl,a
10062  1fde a620          	ld	a,#32
10063  1fe0 42            	mul	x,a
10064  1fe1 72fb03        	addw	x,(OFST-6,sp)
10065  1fe4 de001d        	ldw	x,(_adc_buff,x)
10066  1fe7 cd0000        	call	c_itolx
10068  1fea 96            	ldw	x,sp
10069  1feb 1c0006        	addw	x,#OFST-3
10070  1fee cd0000        	call	c_lgadd
10072                     ; 2192 	for(i=0;i<16;i++)
10074  1ff1 0c05          	inc	(OFST-4,sp)
10077  1ff3 7b05          	ld	a,(OFST-4,sp)
10078  1ff5 a110          	cp	a,#16
10079  1ff7 25db          	jrult	L7324
10080                     ; 2196 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
10082  1ff9 96            	ldw	x,sp
10083  1ffa 1c0006        	addw	x,#OFST-3
10084  1ffd cd0000        	call	c_ltor
10086  2000 a604          	ld	a,#4
10087  2002 cd0000        	call	c_lrsh
10089  2005 be02          	ldw	x,c_lreg+2
10090  2007 b6c3          	ld	a,_adc_ch
10091  2009 905f          	clrw	y
10092  200b 9097          	ld	yl,a
10093  200d 9058          	sllw	y
10094  200f 90df0009      	ldw	(_adc_buff_,y),x
10095  2013               L5324:
10096                     ; 2207 adc_plazma_short++;
10098  2013 bec0          	ldw	x,_adc_plazma_short
10099  2015 1c0001        	addw	x,#1
10100  2018 bfc0          	ldw	_adc_plazma_short,x
10101                     ; 2222 }
10104  201a 5b09          	addw	sp,#9
10105  201c 85            	popw	x
10106  201d bf00          	ldw	c_lreg,x
10107  201f 85            	popw	x
10108  2020 bf02          	ldw	c_lreg+2,x
10109  2022 85            	popw	x
10110  2023 bf00          	ldw	c_y,x
10111  2025 85            	popw	x
10112  2026 bf00          	ldw	c_x,x
10113  2028 80            	iret
10177                     ; 2230 main()
10177                     ; 2231 {
10179                     	switch	.text
10180  2029               _main:
10184                     ; 2233 CLK->ECKR|=1;
10186  2029 721050c1      	bset	20673,#0
10188  202d               L7524:
10189                     ; 2234 while((CLK->ECKR & 2) == 0);
10191  202d c650c1        	ld	a,20673
10192  2030 a502          	bcp	a,#2
10193  2032 27f9          	jreq	L7524
10194                     ; 2235 CLK->SWCR|=2;
10196  2034 721250c5      	bset	20677,#1
10197                     ; 2236 CLK->SWR=0xB4;
10199  2038 35b450c4      	mov	20676,#180
10200                     ; 2238 delay_ms(200);
10202  203c ae00c8        	ldw	x,#200
10203  203f cd00b9        	call	_delay_ms
10205                     ; 2239 FLASH_DUKR=0xae;
10207  2042 35ae5064      	mov	_FLASH_DUKR,#174
10208                     ; 2240 FLASH_DUKR=0x56;
10210  2046 35565064      	mov	_FLASH_DUKR,#86
10211                     ; 2241 enableInterrupts();
10214  204a 9a            rim
10216                     ; 2244 adr_drv_v3();
10219  204b cd1235        	call	_adr_drv_v3
10221                     ; 2247 BLOCK_INIT
10223  204e 72145007      	bset	20487,#2
10226  2052 72145008      	bset	20488,#2
10229  2056 72155009      	bres	20489,#2
10230                     ; 2249 t4_init();
10232  205a cd1deb        	call	_t4_init
10234                     ; 2251 		GPIOG->DDR|=(1<<0);
10236  205d 72105020      	bset	20512,#0
10237                     ; 2252 		GPIOG->CR1|=(1<<0);
10239  2061 72105021      	bset	20513,#0
10240                     ; 2253 		GPIOG->CR2&=~(1<<0);	
10242  2065 72115022      	bres	20514,#0
10243                     ; 2256 		GPIOG->DDR&=~(1<<1);
10245  2069 72135020      	bres	20512,#1
10246                     ; 2257 		GPIOG->CR1|=(1<<1);
10248  206d 72125021      	bset	20513,#1
10249                     ; 2258 		GPIOG->CR2&=~(1<<1);
10251  2071 72135022      	bres	20514,#1
10252                     ; 2260 init_CAN();
10254  2075 cd1578        	call	_init_CAN
10256                     ; 2265 GPIOC->DDR|=(1<<1);
10258  2078 7212500c      	bset	20492,#1
10259                     ; 2266 GPIOC->CR1|=(1<<1);
10261  207c 7212500d      	bset	20493,#1
10262                     ; 2267 GPIOC->CR2|=(1<<1);
10264  2080 7212500e      	bset	20494,#1
10265                     ; 2269 GPIOC->DDR|=(1<<2);
10267  2084 7214500c      	bset	20492,#2
10268                     ; 2270 GPIOC->CR1|=(1<<2);
10270  2088 7214500d      	bset	20493,#2
10271                     ; 2271 GPIOC->CR2|=(1<<2);
10273  208c 7214500e      	bset	20494,#2
10274                     ; 2278 t1_init();
10276  2090 cd1dfc        	call	_t1_init
10278                     ; 2280 GPIOA->DDR|=(1<<5);
10280  2093 721a5002      	bset	20482,#5
10281                     ; 2281 GPIOA->CR1|=(1<<5);
10283  2097 721a5003      	bset	20483,#5
10284                     ; 2282 GPIOA->CR2&=~(1<<5);
10286  209b 721b5004      	bres	20484,#5
10287                     ; 2288 GPIOB->DDR&=~(1<<3);
10289  209f 72175007      	bres	20487,#3
10290                     ; 2289 GPIOB->CR1&=~(1<<3);
10292  20a3 72175008      	bres	20488,#3
10293                     ; 2290 GPIOB->CR2&=~(1<<3);
10295  20a7 72175009      	bres	20489,#3
10296                     ; 2292 GPIOC->DDR|=(1<<3);
10298  20ab 7216500c      	bset	20492,#3
10299                     ; 2293 GPIOC->CR1|=(1<<3);
10301  20af 7216500d      	bset	20493,#3
10302                     ; 2294 GPIOC->CR2|=(1<<3);
10304  20b3 7216500e      	bset	20494,#3
10305                     ; 2297 if(bps_class==bpsIPS) 
10307  20b7 b604          	ld	a,_bps_class
10308  20b9 a101          	cp	a,#1
10309  20bb 260a          	jrne	L5624
10310                     ; 2299 	pwm_u=ee_U_AVT;
10312  20bd ce000c        	ldw	x,_ee_U_AVT
10313  20c0 bf0e          	ldw	_pwm_u,x
10314                     ; 2300 	volum_u_main_=ee_U_AVT;
10316  20c2 ce000c        	ldw	x,_ee_U_AVT
10317  20c5 bf1f          	ldw	_volum_u_main_,x
10318  20c7               L5624:
10319                     ; 2307 	if(bCAN_RX)
10321  20c7 3d0a          	tnz	_bCAN_RX
10322  20c9 2705          	jreq	L1724
10323                     ; 2309 		bCAN_RX=0;
10325  20cb 3f0a          	clr	_bCAN_RX
10326                     ; 2310 		can_in_an();	
10328  20cd cd1783        	call	_can_in_an
10330  20d0               L1724:
10331                     ; 2312 	if(b100Hz)
10333                     	btst	_b100Hz
10334  20d5 240a          	jruge	L3724
10335                     ; 2314 		b100Hz=0;
10337  20d7 72110008      	bres	_b100Hz
10338                     ; 2323 		adc2_init();
10340  20db cd1e39        	call	_adc2_init
10342                     ; 2324 		can_tx_hndl();
10344  20de cd166b        	call	_can_tx_hndl
10346  20e1               L3724:
10347                     ; 2327 	if(b10Hz)
10349                     	btst	_b10Hz
10350  20e6 2419          	jruge	L5724
10351                     ; 2329 		b10Hz=0;
10353  20e8 72110007      	bres	_b10Hz
10354                     ; 2331 		matemat();
10356  20ec cd0d9c        	call	_matemat
10358                     ; 2332 		led_drv(); 
10360  20ef cd077e        	call	_led_drv
10362                     ; 2333 	  link_drv();
10364  20f2 cd086c        	call	_link_drv
10366                     ; 2334 	  pwr_hndl();		//вычисление воздействий на силу
10368  20f5 cd0b9f        	call	_pwr_hndl
10370                     ; 2335 	  JP_drv();
10372  20f8 cd07e1        	call	_JP_drv
10374                     ; 2336 	  flags_drv();
10376  20fb cd11ea        	call	_flags_drv
10378                     ; 2337 		net_drv();
10380  20fe cd16d5        	call	_net_drv
10382  2101               L5724:
10383                     ; 2340 	if(b5Hz)
10385                     	btst	_b5Hz
10386  2106 240d          	jruge	L7724
10387                     ; 2342 		b5Hz=0;
10389  2108 72110006      	bres	_b5Hz
10390                     ; 2344 		pwr_drv();		//воздействие на силу
10392  210c cd0a27        	call	_pwr_drv
10394                     ; 2345 		led_hndl();
10396  210f cd00fb        	call	_led_hndl
10398                     ; 2347 		vent_drv();
10400  2112 cd08c4        	call	_vent_drv
10402  2115               L7724:
10403                     ; 2350 	if(b2Hz)
10405                     	btst	_b2Hz
10406  211a 2404          	jruge	L1034
10407                     ; 2352 		b2Hz=0;
10409  211c 72110005      	bres	_b2Hz
10410  2120               L1034:
10411                     ; 2361 	if(b1Hz)
10413                     	btst	_b1Hz
10414  2125 24a0          	jruge	L5624
10415                     ; 2363 		b1Hz=0;
10417  2127 72110004      	bres	_b1Hz
10418                     ; 2365 		temper_drv();			//вычисление аварий температуры
10420  212b cd0f1a        	call	_temper_drv
10422                     ; 2366 		u_drv();
10424  212e cd0ff1        	call	_u_drv
10426                     ; 2367           x_drv();
10428  2131 cd10d1        	call	_x_drv
10430                     ; 2368           if(main_cnt<1000)main_cnt++;
10432  2134 9c            	rvf
10433  2135 be51          	ldw	x,_main_cnt
10434  2137 a303e8        	cpw	x,#1000
10435  213a 2e07          	jrsge	L5034
10438  213c be51          	ldw	x,_main_cnt
10439  213e 1c0001        	addw	x,#1
10440  2141 bf51          	ldw	_main_cnt,x
10441  2143               L5034:
10442                     ; 2369   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10444  2143 b663          	ld	a,_link
10445  2145 a1aa          	cp	a,#170
10446  2147 2706          	jreq	L1134
10448  2149 b64a          	ld	a,_jp_mode
10449  214b a103          	cp	a,#3
10450  214d 2603          	jrne	L7034
10451  214f               L1134:
10454  214f cd114b        	call	_apv_hndl
10456  2152               L7034:
10457                     ; 2372   		can_error_cnt++;
10459  2152 3c71          	inc	_can_error_cnt
10460                     ; 2373   		if(can_error_cnt>=10)
10462  2154 b671          	ld	a,_can_error_cnt
10463  2156 a10a          	cp	a,#10
10464  2158 2505          	jrult	L3134
10465                     ; 2375   			can_error_cnt=0;
10467  215a 3f71          	clr	_can_error_cnt
10468                     ; 2376 			init_CAN();
10470  215c cd1578        	call	_init_CAN
10472  215f               L3134:
10473                     ; 2380 		volum_u_main_drv();
10475  215f cd1425        	call	_volum_u_main_drv
10477                     ; 2382 		pwm_stat++;
10479  2162 3c07          	inc	_pwm_stat
10480                     ; 2383 		if(pwm_stat>=10)pwm_stat=0;
10482  2164 b607          	ld	a,_pwm_stat
10483  2166 a10a          	cp	a,#10
10484  2168 2502          	jrult	L5134
10487  216a 3f07          	clr	_pwm_stat
10488  216c               L5134:
10489                     ; 2384 adc_plazma_short++;
10491  216c bec0          	ldw	x,_adc_plazma_short
10492  216e 1c0001        	addw	x,#1
10493  2171 bfc0          	ldw	_adc_plazma_short,x
10494                     ; 2386 		vent_resurs_hndl();
10496  2173 cd0000        	call	_vent_resurs_hndl
10498  2176 acc720c7      	jpf	L5624
11568                     	xdef	_main
11569                     	xdef	f_ADC2_EOC_Interrupt
11570                     	xdef	f_CAN_TX_Interrupt
11571                     	xdef	f_CAN_RX_Interrupt
11572                     	xdef	f_TIM4_UPD_Interrupt
11573                     	xdef	_adc2_init
11574                     	xdef	_t1_init
11575                     	xdef	_t4_init
11576                     	xdef	_can_in_an
11577                     	xdef	_net_drv
11578                     	xdef	_can_tx_hndl
11579                     	xdef	_can_transmit
11580                     	xdef	_init_CAN
11581                     	xdef	_volum_u_main_drv
11582                     	xdef	_adr_drv_v3
11583                     	xdef	_adr_drv_v4
11584                     	xdef	_flags_drv
11585                     	xdef	_apv_hndl
11586                     	xdef	_apv_stop
11587                     	xdef	_apv_start
11588                     	xdef	_x_drv
11589                     	xdef	_u_drv
11590                     	xdef	_temper_drv
11591                     	xdef	_matemat
11592                     	xdef	_pwr_hndl
11593                     	xdef	_pwr_drv
11594                     	xdef	_vent_drv
11595                     	xdef	_link_drv
11596                     	xdef	_JP_drv
11597                     	xdef	_led_drv
11598                     	xdef	_led_hndl
11599                     	xdef	_delay_ms
11600                     	xdef	_granee
11601                     	xdef	_gran
11602                     	xdef	_vent_resurs_hndl
11603                     	switch	.ubsct
11604  0001               _vent_resurs_tx_cnt:
11605  0001 00            	ds.b	1
11606                     	xdef	_vent_resurs_tx_cnt
11607                     	switch	.bss
11608  0000               _vent_resurs_buff:
11609  0000 00000000      	ds.b	4
11610                     	xdef	_vent_resurs_buff
11611                     	switch	.ubsct
11612  0002               _vent_resurs_sec_cnt:
11613  0002 0000          	ds.b	2
11614                     	xdef	_vent_resurs_sec_cnt
11615                     .eeprom:	section	.data
11616  0000               _vent_resurs:
11617  0000 0000          	ds.b	2
11618                     	xdef	_vent_resurs
11619  0002               _ee_IMAXVENT:
11620  0002 0000          	ds.b	2
11621                     	xdef	_ee_IMAXVENT
11622                     	switch	.ubsct
11623  0004               _bps_class:
11624  0004 00            	ds.b	1
11625                     	xdef	_bps_class
11626  0005               _vent_pwm:
11627  0005 0000          	ds.b	2
11628                     	xdef	_vent_pwm
11629  0007               _pwm_stat:
11630  0007 00            	ds.b	1
11631                     	xdef	_pwm_stat
11632  0008               _pwm_vent_cnt:
11633  0008 00            	ds.b	1
11634                     	xdef	_pwm_vent_cnt
11635                     	switch	.eeprom
11636  0004               _ee_DEVICE:
11637  0004 0000          	ds.b	2
11638                     	xdef	_ee_DEVICE
11639  0006               _ee_AVT_MODE:
11640  0006 0000          	ds.b	2
11641                     	xdef	_ee_AVT_MODE
11642                     	switch	.ubsct
11643  0009               _i_main_bps_cnt:
11644  0009 000000000000  	ds.b	6
11645                     	xdef	_i_main_bps_cnt
11646  000f               _i_main_sigma:
11647  000f 0000          	ds.b	2
11648                     	xdef	_i_main_sigma
11649  0011               _i_main_num_of_bps:
11650  0011 00            	ds.b	1
11651                     	xdef	_i_main_num_of_bps
11652  0012               _i_main_avg:
11653  0012 0000          	ds.b	2
11654                     	xdef	_i_main_avg
11655  0014               _i_main_flag:
11656  0014 000000000000  	ds.b	6
11657                     	xdef	_i_main_flag
11658  001a               _i_main:
11659  001a 000000000000  	ds.b	12
11660                     	xdef	_i_main
11661  0026               _x:
11662  0026 000000000000  	ds.b	12
11663                     	xdef	_x
11664                     	xdef	_volum_u_main_
11665                     	switch	.eeprom
11666  0008               _UU_AVT:
11667  0008 0000          	ds.b	2
11668                     	xdef	_UU_AVT
11669                     	switch	.ubsct
11670  0032               _cnt_net_drv:
11671  0032 00            	ds.b	1
11672                     	xdef	_cnt_net_drv
11673                     	switch	.bit
11674  0002               _bMAIN:
11675  0002 00            	ds.b	1
11676                     	xdef	_bMAIN
11677                     	switch	.ubsct
11678  0033               _plazma_int:
11679  0033 000000000000  	ds.b	6
11680                     	xdef	_plazma_int
11681                     	xdef	_rotor_int
11682  0039               _led_green_buff:
11683  0039 00000000      	ds.b	4
11684                     	xdef	_led_green_buff
11685  003d               _led_red_buff:
11686  003d 00000000      	ds.b	4
11687                     	xdef	_led_red_buff
11688                     	xdef	_led_drv_cnt
11689                     	xdef	_led_green
11690                     	xdef	_led_red
11691  0041               _res_fl_cnt:
11692  0041 00            	ds.b	1
11693                     	xdef	_res_fl_cnt
11694                     	xdef	_bRES_
11695                     	xdef	_bRES
11696                     	switch	.eeprom
11697  000a               _res_fl_:
11698  000a 00            	ds.b	1
11699                     	xdef	_res_fl_
11700  000b               _res_fl:
11701  000b 00            	ds.b	1
11702                     	xdef	_res_fl
11703                     	switch	.ubsct
11704  0042               _cnt_apv_off:
11705  0042 00            	ds.b	1
11706                     	xdef	_cnt_apv_off
11707                     	switch	.bit
11708  0003               _bAPV:
11709  0003 00            	ds.b	1
11710                     	xdef	_bAPV
11711                     	switch	.ubsct
11712  0043               _apv_cnt_:
11713  0043 0000          	ds.b	2
11714                     	xdef	_apv_cnt_
11715  0045               _apv_cnt:
11716  0045 000000        	ds.b	3
11717                     	xdef	_apv_cnt
11718                     	xdef	_bBL_IPS
11719                     	xdef	_bBL
11720  0048               _cnt_JP1:
11721  0048 00            	ds.b	1
11722                     	xdef	_cnt_JP1
11723  0049               _cnt_JP0:
11724  0049 00            	ds.b	1
11725                     	xdef	_cnt_JP0
11726  004a               _jp_mode:
11727  004a 00            	ds.b	1
11728                     	xdef	_jp_mode
11729                     	xdef	_pwm_i
11730                     	xdef	_pwm_u
11731  004b               _tmax_cnt:
11732  004b 0000          	ds.b	2
11733                     	xdef	_tmax_cnt
11734  004d               _tsign_cnt:
11735  004d 0000          	ds.b	2
11736                     	xdef	_tsign_cnt
11737                     	switch	.eeprom
11738  000c               _ee_U_AVT:
11739  000c 0000          	ds.b	2
11740                     	xdef	_ee_U_AVT
11741  000e               _ee_tsign:
11742  000e 0000          	ds.b	2
11743                     	xdef	_ee_tsign
11744  0010               _ee_tmax:
11745  0010 0000          	ds.b	2
11746                     	xdef	_ee_tmax
11747  0012               _ee_dU:
11748  0012 0000          	ds.b	2
11749                     	xdef	_ee_dU
11750  0014               _ee_Umax:
11751  0014 0000          	ds.b	2
11752                     	xdef	_ee_Umax
11753  0016               _ee_TZAS:
11754  0016 0000          	ds.b	2
11755                     	xdef	_ee_TZAS
11756                     	switch	.ubsct
11757  004f               _main_cnt1:
11758  004f 0000          	ds.b	2
11759                     	xdef	_main_cnt1
11760  0051               _main_cnt:
11761  0051 0000          	ds.b	2
11762                     	xdef	_main_cnt
11763  0053               _off_bp_cnt:
11764  0053 00            	ds.b	1
11765                     	xdef	_off_bp_cnt
11766                     	xdef	_vol_i_temp_avar
11767  0054               _flags_tu_cnt_off:
11768  0054 00            	ds.b	1
11769                     	xdef	_flags_tu_cnt_off
11770  0055               _flags_tu_cnt_on:
11771  0055 00            	ds.b	1
11772                     	xdef	_flags_tu_cnt_on
11773  0056               _vol_i_temp:
11774  0056 0000          	ds.b	2
11775                     	xdef	_vol_i_temp
11776  0058               _vol_u_temp:
11777  0058 0000          	ds.b	2
11778                     	xdef	_vol_u_temp
11779                     	switch	.eeprom
11780  0018               __x_ee_:
11781  0018 0000          	ds.b	2
11782                     	xdef	__x_ee_
11783                     	switch	.ubsct
11784  005a               __x_cnt:
11785  005a 0000          	ds.b	2
11786                     	xdef	__x_cnt
11787  005c               __x__:
11788  005c 0000          	ds.b	2
11789                     	xdef	__x__
11790  005e               __x_:
11791  005e 0000          	ds.b	2
11792                     	xdef	__x_
11793  0060               _flags_tu:
11794  0060 00            	ds.b	1
11795                     	xdef	_flags_tu
11796                     	xdef	_flags
11797  0061               _link_cnt:
11798  0061 0000          	ds.b	2
11799                     	xdef	_link_cnt
11800  0063               _link:
11801  0063 00            	ds.b	1
11802                     	xdef	_link
11803  0064               _umin_cnt:
11804  0064 0000          	ds.b	2
11805                     	xdef	_umin_cnt
11806  0066               _umax_cnt:
11807  0066 0000          	ds.b	2
11808                     	xdef	_umax_cnt
11809                     	switch	.eeprom
11810  001a               _ee_K:
11811  001a 000000000000  	ds.b	16
11812                     	xdef	_ee_K
11813                     	switch	.ubsct
11814  0068               _T:
11815  0068 00            	ds.b	1
11816                     	xdef	_T
11817  0069               _Udb:
11818  0069 0000          	ds.b	2
11819                     	xdef	_Udb
11820  006b               _Ui:
11821  006b 0000          	ds.b	2
11822                     	xdef	_Ui
11823  006d               _Un:
11824  006d 0000          	ds.b	2
11825                     	xdef	_Un
11826  006f               _I:
11827  006f 0000          	ds.b	2
11828                     	xdef	_I
11829  0071               _can_error_cnt:
11830  0071 00            	ds.b	1
11831                     	xdef	_can_error_cnt
11832                     	xdef	_bCAN_RX
11833  0072               _tx_busy_cnt:
11834  0072 00            	ds.b	1
11835                     	xdef	_tx_busy_cnt
11836                     	xdef	_bTX_FREE
11837  0073               _can_buff_rd_ptr:
11838  0073 00            	ds.b	1
11839                     	xdef	_can_buff_rd_ptr
11840  0074               _can_buff_wr_ptr:
11841  0074 00            	ds.b	1
11842                     	xdef	_can_buff_wr_ptr
11843  0075               _can_out_buff:
11844  0075 000000000000  	ds.b	64
11845                     	xdef	_can_out_buff
11846                     	switch	.bss
11847  0004               _adress_error:
11848  0004 00            	ds.b	1
11849                     	xdef	_adress_error
11850  0005               _adress:
11851  0005 00            	ds.b	1
11852                     	xdef	_adress
11853  0006               _adr:
11854  0006 000000        	ds.b	3
11855                     	xdef	_adr
11856                     	xdef	_adr_drv_stat
11857                     	xdef	_led_ind
11858                     	switch	.ubsct
11859  00b5               _led_ind_cnt:
11860  00b5 00            	ds.b	1
11861                     	xdef	_led_ind_cnt
11862  00b6               _adc_plazma:
11863  00b6 000000000000  	ds.b	10
11864                     	xdef	_adc_plazma
11865  00c0               _adc_plazma_short:
11866  00c0 0000          	ds.b	2
11867                     	xdef	_adc_plazma_short
11868  00c2               _adc_cnt:
11869  00c2 00            	ds.b	1
11870                     	xdef	_adc_cnt
11871  00c3               _adc_ch:
11872  00c3 00            	ds.b	1
11873                     	xdef	_adc_ch
11874                     	switch	.bss
11875  0009               _adc_buff_:
11876  0009 000000000000  	ds.b	20
11877                     	xdef	_adc_buff_
11878  001d               _adc_buff:
11879  001d 000000000000  	ds.b	320
11880                     	xdef	_adc_buff
11881                     	switch	.ubsct
11882  00c4               _mess:
11883  00c4 000000000000  	ds.b	14
11884                     	xdef	_mess
11885                     	switch	.bit
11886  0004               _b1Hz:
11887  0004 00            	ds.b	1
11888                     	xdef	_b1Hz
11889  0005               _b2Hz:
11890  0005 00            	ds.b	1
11891                     	xdef	_b2Hz
11892  0006               _b5Hz:
11893  0006 00            	ds.b	1
11894                     	xdef	_b5Hz
11895  0007               _b10Hz:
11896  0007 00            	ds.b	1
11897                     	xdef	_b10Hz
11898  0008               _b100Hz:
11899  0008 00            	ds.b	1
11900                     	xdef	_b100Hz
11901                     	xdef	_t0_cnt4
11902                     	xdef	_t0_cnt3
11903                     	xdef	_t0_cnt2
11904                     	xdef	_t0_cnt1
11905                     	xdef	_t0_cnt0
11906                     	xdef	_bVENT_BLOCK
11907                     	xref.b	c_lreg
11908                     	xref.b	c_x
11909                     	xref.b	c_y
11929                     	xref	c_lrsh
11930                     	xref	c_lgadd
11931                     	xref	c_ladd
11932                     	xref	c_umul
11933                     	xref	c_lgmul
11934                     	xref	c_lgsub
11935                     	xref	c_lsbc
11936                     	xref	c_idiv
11937                     	xref	c_ldiv
11938                     	xref	c_itolx
11939                     	xref	c_eewrc
11940                     	xref	c_imul
11941                     	xref	c_ltor
11942                     	xref	c_lgadc
11943                     	xref	c_rtol
11944                     	xref	c_vmul
11945                     	xref	c_eewrw
11946                     	xref	c_lcmp
11947                     	xref	c_uitolx
11948                     	end
