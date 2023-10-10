#define F_REF 8000000L
#define F_COMP 10000L
#include <mega168.h>
#include "mega168_bits.h"
#include <delay.h> 
#include "curr_version.h"

//#define KAN_XTAL	8
#define KAN_XTAL	10  
//#define KAN_XTAL	20 
#include "cmd.c"
#define XMAX 25
  
#include <stdio.h>
#include <math.h>

#define ON 0x55
#define OFF 0xaa

#define BLOCK_INIT  DDRD.4=1;
#define BLOCK_ON 	{PORTD.4=1;bVENT_BLOCK=1;}
#define BLOCK_OFF 	{PORTD.4=0;bVENT_BLOCK=0;}
#define BLOCK_IS_ON (PIND.4==1)

#define _220_
//#define _24_

bit bJP; //джампер одет 
bit b100Hz;
bit b33Hz;
bit b10Hz;
bit b5Hz;
bit b1Hz;
bit bFl_; 
bit bBL;
bit bBL_IPS=0;

char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4,cnt_ind,adc_cnt0,adc_cnt1; 
/*bit l_but;	//идет длинное нажатие на кнопку
bit n_but=0;     //произошло нажатие
bit speed;	//разрешение ускорения перебора
bit bFl_;

bit zero_on;		
bit bFr_ch=0;
bit bR;
bit bT1;

enum char {iH,iT,iPrl,iK,iSet}ind; 
signed char sub_ind;
unsigned int adc_bank[4][16],adc_bank_[4];
bit bCh;*/

signed int tabl[]={0/*0*/,72/*40*/,125/*80*/,177/*120*/,217/*160*/,254/*200*/,286/*240*/,318/*280*/,346/*320*/,372/*360*/,400/*400*/,427,453,478,502,525};

eeprom int freq;
eeprom char stereo,p_out;

char lcd_flash0=0; 
char lcd_flashx0=0;
char lcd_flashy0=0;
//char lcd_flash1=0; 
//char lcd_flashx1=0;
//char lcd_flashy1=0;
unsigned char volum;
eeprom unsigned char volum_ee;


int vol_u,vol_i;

unsigned int adc_buff[5][16],adc_buff_[5];
char adc_cnt,adc_ch;

eeprom signed int K[4][2]; 

unsigned int I,Un,Ui,Udb;
signed T;
char flags=0; // состояние источника
// 0 -  если одет джампер то 0, если нет то 1
// 1 -  авария по Tmax (1-активн.);
// 2 -  авария по Tsign (1-активн.);
// 3 -  авария по Umax (1-активн.);
// 4 -  авария по Umin (1-активн.);
// 5 -  блокировка извне (1-активн.); 
// 6 -  блокировка извне защит(1-активн.);

char flags_tu; // управляющее слово от хоста
// 0 -  блокировка, если 1 то заблокировать 
// 1 -  блокировка извне защит(1-активн.); 

unsigned int  vol_u_temp,vol_i_temp;
//Управление светодиодами
long led_red=0x00000000L;
long led_green=0x03030303L;
char led_drv_cnt=30;
long led_red_buff;
long led_green_buff;
char link;
short link_cnt;
eeprom signed int Umax_,dU_,tmax_,tsign_;
signed tsign_cnt,tmax_cnt; 
unsigned int pwm_u=50,pwm_i=50;
signed umax_cnt,umin_cnt;
char flags_tu_cnt_on,flags_tu_cnt_off; 
char adr_new,adr_old,adr_temp,adr_cnt;
//eeprom char adr;
char cnt_JP0,cnt_JP1;
enum {jp0,jp1,jp2,jp3} jp_mode;
int main_cnt1;
signed _x_,_x__; 
int _x_cnt;
eeprom signed _x_ee_;
eeprom int U_AVT_;
eeprom char U_AVT_ON_;

int main_cnt; 
eeprom char TZAS;             
char plazma;
int plazma_int[3];
int adc_ch_2_max,adc_ch_2_min;
char adc_ch_2_delta;
char cnt_adc_ch_2_delta;
char apv_cnt[3];
int apv_cnt_;
char bAPV;
char cnt_apv_off;

eeprom char res_fl,res_fl_;
char bRES=0;
char bRES_=0; 
char res_fl_cnt;
char off_bp_cnt;
//eeprom char adr_ee;

flash char CONST_ADR[]={0b00000111,0b00000111,0b00000111,0b00000010,0b00000011,0b00000001,0b00000000,0b00000111};

char can_error_cnt;


char adr_drv_stat=0;
char adr[3],adress;
char adress_error;

enum {bpsIBEP,bpsIPS,bpsIBEP_AVT} bps_class;

eeprom signed short ee_TZAS;
eeprom signed short ee_Umax;
eeprom signed short ee_dU;
eeprom signed short ee_tmax;
eeprom signed short ee_tsign;
eeprom signed short ee_U_AVT;
eeprom int ee_AVT_MODE;			//какой-то переключатель, переключается последним байтом в посылке с MEM_KF
eeprom signed short ee_DEVICE;	//переключатель, переключается MEM_KF4 или MEM_KF1, MEM_KF4 устанавливает его в 1
							// и означает что это БПС неибэпный, включается и выключается только по команде,
							//никакие TZAS, U_AVT не работают 
eeprom short ee_IMAXVENT;
                            
bit bMAIN;                            

short vent_pwm;
char bVENT_BLOCK=0;
signed short plazmaSS; 
char cnt_net_drv;

//Наработка вентилятора
eeprom unsigned short vent_resurs;
unsigned short vent_resurs_sec_cnt;
//#define VENT_RESURS_SEC_IN_HOUR	3600
#define VENT_RESURS_SEC_IN_HOUR	3600
unsigned char vent_resurs_buff[4];
unsigned char vent_resurs_tx_cnt;

eeprom int UU_AVT;
signed short volum_u_main_=700;
signed short x[6];
signed short i_main[6];
char i_main_flag[6];
signed short i_main_avg;
char i_main_num_of_bps;
signed short i_main_sigma;
char i_main_bps_cnt[6];
unsigned short vol_i_temp_avar=0;

//eeprom short AVT_MODE;

#include "can_slave.c"

//-----------------------------------------------
void t0_init(void)
{
TCCR0A=0x00;
TCCR0B=0x05;
TCNT0=-8;
TIMSK0=0x01;
}

//-----------------------------------------------
char adr_gran(signed short in)
{
if(in>800)return 1;
else if((in>80)&&(in<120))return 0;
else return 100;
} 


//-----------------------------------------------
void gran(signed int *adr, signed int min, signed int max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 


//-----------------------------------------------
void granee(eeprom signed int *adr, signed int min, signed int max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
}

//-----------------------------------------------
void x_drv(void)
{
if(_x__==_x_)
	{
	if(_x_cnt<60)
		{
		_x_cnt++;
		if(_x_cnt>=60)
			{
			if(_x_ee_!=_x_)_x_ee_=_x_;
			}
		}
		
	}
else _x_cnt=0;

if(_x_cnt>60) _x_cnt=0;	

_x__=_x_;
}

//-----------------------------------------------
void apv_start(void)
{
if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
	{
	apv_cnt[0]=60;
	apv_cnt[1]=60;
	apv_cnt[2]=60;
	apv_cnt_=3600;
	bAPV=1;	
	}
}

//-----------------------------------------------
void apv_stop(void)
{
apv_cnt[0]=0;
apv_cnt[1]=0;
apv_cnt[2]=0;
apv_cnt_=0;	
bAPV=0;
}


//-----------------------------------------------
void av_wrk_drv(void)
{                         
adc_ch_2_delta=(char)(adc_ch_2_max-adc_ch_2_min);
adc_ch_2_max=adc_buff_[2];
adc_ch_2_min=adc_buff_[2]; 
if(PORTD.7==0)
	{
	if(adc_ch_2_delta>=5)
		{
		cnt_adc_ch_2_delta++;
		if(cnt_adc_ch_2_delta>=10)
			{
			flags|=0x10;
			apv_start();
			}
		}    
	else 
		{
		cnt_adc_ch_2_delta=0;
		}
	}
else cnt_adc_ch_2_delta=0;			
}

//-----------------------------------------------
void led_drv_1(void)
{
DDRD.1=1;
if(led_green_buff&0b1L) PORTD.1=1;
else PORTD.1=0; 
DDRD.0=1;
if(led_red_buff&0b1L) PORTD.0=1;
else PORTD.0=0; 


led_red_buff>>=1;
led_green_buff>>=1;
if(++led_drv_cnt>32)
	{
	led_drv_cnt=0;
	led_red_buff=led_red;
	led_green_buff=led_green;
	}

} 

//-----------------------------------------------
void led_drv(void)
{
//Красный светодиод
DDRD.0=1;
if(led_red_buff&0b1L)   PORTD.0=1; 	//Горит если в led_red_buff 1 и на ножке 1
else                    PORTD.0=0; 

//Зеленый светодиод
DDRD.1=1;	
if(led_green_buff&0b1L) PORTD.1=1;	//Горит если в led_green_buff 1 и на ножке 1
else                    PORTD.1=0;


led_red_buff>>=1;
led_green_buff>>=1;
if(++led_drv_cnt>32)
	{
	led_drv_cnt=0;
	led_red_buff=led_red;
	led_green_buff=led_green;
	}

} 

//-----------------------------------------------
void flags_drv(void)
{
static char flags_old;
if(jp_mode!=jp3) 
	{
	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000))&&(ee_AVT_MODE!=0x55))) 
    		{	
    		if(link==OFF)apv_start();
    		}
     }
else if(jp_mode==jp3) 
	{
	if((flags&0b00001000)&&(!(flags_old&0b00001000))) 
    		{	
    		apv_start();
    		}
     }
flags_old=flags;

} 

//-----------------------------------------------
void adr_hndl(void)
{
#define ADR_CONST_0	574
#define ADR_CONST_1	897
#define ADR_CONST_2	695
#define ADR_CONST_3	1015

signed tempSI; 
short aaa[3];
char aaaa[3];
DDRC=0b00000000; 
PORTC=0b00000000;
/*char i; 
DDRD&=0b11100011;
PORTD|=0b00011100;

//adr_new=((char)(!PIND.2))+(((char)(!PIND.3))*2)+((char)(!PIND.4)*4);


adr_new=(PIND&0b00011100)>>2;

if(adr_new==adr_old) 
 	{
 	if(adr_cnt<100)
 		{
 		adr_cnt++;
 	     if(adr_cnt>=100)
 	     	{
 	     	adr_temp=adr_new;
 	     	}
 	     }	
   	}
else adr_cnt=0;
adr_old=adr_new;
if(adr!=CONST_ADR[adr_temp]) adr=CONST_ADR[adr_temp]; 


//if(adr!=0b00000011)adr=0b00000011;*/



ADMUX=0b00000110;
ADCSRA=0b10100110;
ADCSRA|=0b01000000;
delay_ms(10);
aaa[0]=ADCW;


ADMUX=0b00000111;
ADCSRA=0b10100110;
ADCSRA|=0b01000000;
delay_ms(10);
aaa[1]=ADCW;


ADMUX=0b00000000;
ADCSRA=0b10100110;
ADCSRA|=0b01000000;
delay_ms(10);
aaa[2]=ADCW;

if((aaa[0]>=(ADR_CONST_0-40))&&(aaa[0]<=(ADR_CONST_0+40))) adr[0]=0;
else if((aaa[0]>=(ADR_CONST_1-40))&&(aaa[0]<=(ADR_CONST_1+40))) adr[0]=1;
else if((aaa[0]>=(ADR_CONST_2-40))&&(aaa[0]<=(ADR_CONST_2+40))) adr[0]=2;
else if((aaa[0]>=(ADR_CONST_3-40))&&(aaa[0]<=(ADR_CONST_3+40))) adr[0]=3;
else adr[0]=5;

if((aaa[1]>=(ADR_CONST_0-40))&&(aaa[1]<=(ADR_CONST_0+40))) adr[1]=0;
else if((aaa[1]>=(ADR_CONST_1-40))&&(aaa[1]<=(ADR_CONST_1+40))) adr[1]=1;
else if((aaa[1]>=(ADR_CONST_2-40))&&(aaa[1]<=(ADR_CONST_2+40))) adr[1]=2;
else if((aaa[1]>=(ADR_CONST_3-40))&&(aaa[1]<=(ADR_CONST_3+40))) adr[1]=3;
else adr[1]=5;

if((aaa[2]>=(ADR_CONST_0-40))&&(aaa[2]<=(ADR_CONST_0+40))) adr[2]=0;
else if((aaa[2]>=(ADR_CONST_1-40))&&(aaa[2]<=(ADR_CONST_1+40))) adr[2]=1;
else if((aaa[2]>=(ADR_CONST_2-40))&&(aaa[2]<=(ADR_CONST_2+40))) adr[2]=2;
else if((aaa[2]>=(ADR_CONST_3-40))&&(aaa[2]<=(ADR_CONST_3+40))) adr[2]=3;
else adr[2]=5;

if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
	{
	//adress=100;
	adress_error=1;
	}
else 
	{
	if(adr[2]&0x02) bps_class=bpsIPS;
	else bps_class=bpsIBEP;

	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
	}
//plazmaSS=adress;    
//adress=0;

} 




//-----------------------------------------------
void apv_hndl(void)
{
if(apv_cnt[0])
	{
	apv_cnt[0]--;
	if(apv_cnt[0]==0)
		{
		flags&=0b11100001;
		tsign_cnt=0;
		tmax_cnt=0;
		umax_cnt=0;
		umin_cnt=0;
		//cnt_adc_ch_2_delta=0;
		led_drv_cnt=30;
		}
	}
else if(apv_cnt[1])
	{
	apv_cnt[1]--;
	if(apv_cnt[1]==0)
		{
		flags&=0b11100001;
		tsign_cnt=0;
		tmax_cnt=0;
		umax_cnt=0;
		umin_cnt=0;
//		cnt_adc_ch_2_delta=0;		
		led_drv_cnt=30;
		}
	}	       
else if(apv_cnt[2])
	{
	apv_cnt[2]--;
	if(apv_cnt[2]==0)
		{
		flags&=0b11100001;
		tsign_cnt=0;
		tmax_cnt=0;
		umax_cnt=0;
		umin_cnt=0;          
//		cnt_adc_ch_2_delta=0;		
		led_drv_cnt=30;
		}
	}	         
	
if(apv_cnt_)
	{
	apv_cnt_--;
	if(apv_cnt_==0) 
		{
		bAPV=0;
		apv_start();
		}
	}	   
	
if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
	{
	if(cnt_apv_off<20)
		{
		cnt_apv_off++;
		if(cnt_apv_off>=20)
			{
			apv_stop();
			}
		}
	}
else cnt_apv_off=0;	
	
}
      
//-----------------------------------------------
void link_drv(void)		//10Hz
{
if(jp_mode!=jp3)
	{
	if(link_cnt<602)link_cnt++;
	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
	if(link_cnt==600)
		{
		link=OFF;
		
		//попробую вместо
		//if((AVT_MODE!=0x55)&&(!eeDEVICE))bMAIN=1;
		//написать
		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
		else bMAIN=0;

		cnt_net_drv=0;
    		if(!res_fl_)
			{
	    		bRES_=1;
	    		res_fl_=1;
	    		}
    		}            
	}
else link=OFF;	
}  

//-----------------------------------------------
void temper_drv(void)
{
if(T>ee_tsign) tsign_cnt++;
else if (T<(ee_tsign-1)) tsign_cnt--;

gran(&tsign_cnt,0,60);

if(tsign_cnt>=55)
	{
	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
	}
else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева



	
if(T>ee_tmax) tmax_cnt++;
else if (T<(ee_tmax-1)) tmax_cnt--;

gran(&tmax_cnt,0,60);

if(tmax_cnt>=55)
	{
	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	}
else if (tmax_cnt<=5) flags&=0b11111101;


} 

//-----------------------------------------------
void u_drv(void)		//1Hz
{ 
if(jp_mode!=jp3)
	{        
	if(Ui>ee_Umax)umax_cnt++;
	else umax_cnt=0;
	gran(&umax_cnt,0,10);
	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения

    if(ee_AVT_MODE==0x55)
        {
        short temp=ee_Umax;
        temp/=10;
        temp*=9;
        if((Ui<temp)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
        else umin_cnt--;
        gran(&umin_cnt,0,10);	
        if(umin_cnt>=10)flags|=0b00010000;
        if(umin_cnt<=0)flags&=~0b00010000;
        }
    else
        {	
        if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
        else umin_cnt=0;
        gran(&umin_cnt,0,10);	
        if(umin_cnt>=10)flags|=0b00010000; 
        
        }
        
   // if(ee_AVT_MODE==0x55) && 
    	  
	}
else if(jp_mode==jp3)
	{        
	if(Ui>700)umax_cnt++;
	else umax_cnt=0;
	gran(&umax_cnt,0,10);
	if(umax_cnt>=10)flags|=0b00001000;

	
	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
	else umin_cnt=0;
	gran(&umin_cnt,0,10);	
	if(umin_cnt>=10)flags|=0b00010000;	  
	}
}

//-----------------------------------------------
void led_hndl_1(void)
{ 
if(jp_mode!=jp3)
	{
	if(main_cnt1<(5*TZAS))
		{
		led_red=0x00000000L;
		led_green=0x03030303L;
		}
	else if((link==ON)&&(flags_tu&0b10000000))
		{
		led_red=0x00055555L;
 		led_green=0xffffffffL;
 		} 
	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
		{
		led_red=0x00000000L;
		led_green=0xffffffffL;	
		}  
	
	else  if(link==OFF)
 		{
 		led_red=0x55555555L;
 		led_green=0xffffffffL;
 		}
		         
	else if((link==ON)&&((flags&0b00111110)==0))
		{
		led_red=0x00000000L;
		led_green=0xffffffffL;
		}


	

		
	else if((flags&0b00111110)==0b00000100)
		{
		led_red=0x00010001L;
		led_green=0xffffffffL;	
		}
	else if(flags&0b00000010)
		{
		led_red=0x00010001L;
		led_green=0x00000000L;	
		} 
	else if(flags&0b00001000)
		{
		led_red=0x00090009L;
		led_green=0x00000000L;	
		}
	else if(flags&0b00010000)
		{
		led_red=0x00490049L;
		led_green=0x00000000L;	
		}			

	else if((link==ON)&&(flags&0b00100000))
		{
		led_red=0x00000000L;
		led_green=0x00030003L;
		} 

	if((jp_mode==jp1))
		{
		led_red=0x00000000L;
		led_green=0x33333333L;
		}
	else if((jp_mode==jp2))
		{
		led_red=0xccccccccL;
		led_green=0x00000000L;
		}
	}		
else if(jp_mode==jp3)
	{
	if(main_cnt1<(5*TZAS))
		{
		led_red=0x00000000L;
		led_green=0x03030303L;
		}
	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
		{
		led_red=0x00000000L;
		led_green=0xffffffffL;	
		} 
		
	else if((flags&0b00011110)==0)
		{
		led_red=0x00000000L;
		led_green=0xffffffffL;
		}
    

	else if((flags&0b00111110)==0b00000100)
		{
		led_red=0x00010001L;
		led_green=0xffffffffL;	
		}
	else if(flags&0b00000010)
		{
		led_red=0x00010001L;
		led_green=0x00000000L;	
		} 
	else if(flags&0b00001000)
		{
		led_red=0x00090009L;
		led_green=0x00000000L;	
		}
	else if(flags&0b00010000)
		{
		led_red=0x00490049L;
		led_green=0xffffffffL;	
		}  
		/*led_green=0x33333333L;
		led_red=0xccccccccL;*/					
	}						

}

//-----------------------------------------------
void led_hndl(void)
{
if(adress_error)
	{
	led_red=0x55555555L;
	led_green=0x55555555L;
	}

/*else if(bps_class==bpsIBEP)		//проверка работы адресатора
	{
	if(adress==0)led_red=0x00000001L;
	if(adress==1)led_red=0x00000005L;
	if(adress==2)led_red=0x00000015L;
	if(adress==3)led_red=0x00000055L;
	if(adress==4)led_red=0x00000155L;
	if(adress==5)led_red=0x00111111L;
	if(adress==6)led_red=0x01111111L;
	if(adress==7)led_red=0x11111111L;
	led_green=0x00000000L;	
	}*/ 
/*		else  if(link==OFF)
			{
			led_red=0x555ff555L;
			led_green=0xffffffffL;
			}
else if(link_cnt>50)
	{
	led_red=0x5555ff55L;
	led_green=0x55555555L;
	} */
else if(ee_AVT_MODE==0x55)
	{ 
    
    led_red=0x00000000L;
	led_green=0xffffffffL;
            
	if(jp_mode!=jp3)
		{
/*		if(main_cnt1<(5*ee_TZAS))
			{
			led_red=0x00000000L;
			led_green=0x03030303L;
			}  

		else if((link==ON)&&(flags_tu&0b10000000))
			{
			led_red=0x00055555L;
			led_green=0xffffffffL;
			}   */

/*		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;	
			} */ 
		
/*		else  if(link==OFF)
			{
			led_red=0x55555555L;
			led_green=0xffffffffL;
			}
				    
		else*/ if((link==ON)&&((flags&0b00111110)==0))
			{
			led_red=0x00000111L;
			led_green=0x00000111L;
			}
			
		else if((flags&0b00111110)==0b00000100)
			{
			led_red=0x00010001L;
			led_green=0xffffffffL;	
			}
		else if(flags&0b00000010)
			{
			led_red=0x00010001L;
			led_green=0x00000000L;	
			} 
		else if(flags&0b00001000)
			{
			led_red=0x00090009L;
			led_green=0x00000000L;	
			}
		else if(flags&0b00010000)
			{
			led_red=0x00490049L;
			led_green=0xffffffffL;	
			}			
	
/*		else if((link==ON)&&(flags&0b00100000))
			{
			led_red=0x00000000L;
			led_green=0x00030003L;
			} */
	
		if((jp_mode==jp1))
			{
			led_red=0x00000000L;
			led_green=0x33333333L;
			}
		else if((jp_mode==jp2))
			{
			led_red=0xccccccccL;
			led_green=0x00000000L;
			}
		}		

/*    if(umin_cnt)
        {
        led_red=0x00c900c9L;
		led_green=0x00c000c0L;
        } */
	}
else if(bps_class==bpsIBEP)	//если блок ИБЭПный
	{
	if(jp_mode!=jp3)
		{
		if(main_cnt1<(5*ee_TZAS))
			{
			led_red=0x00000000L;
			led_green=0x03030303L;
			}

		else if((link==ON)&&(flags_tu&0b10000000))
			{
			led_red=0x00055555L;
			led_green=0xffffffffL;
			} 

		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;	
			}  
		
		else  if(link==OFF)
			{
			led_red=0x55555555L;
			led_green=0xffffffffL;
			}
				    
		else if((link==ON)&&((flags&0b00111110)==0))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;
			}
			
		else if((flags&0b00111110)==0b00000100)
			{
			led_red=0x00010001L;
			led_green=0xffffffffL;	
			}
		else if(flags&0b00000010)
			{
			led_red=0x00010001L;
			led_green=0x00000000L;	
			} 
		else if(flags&0b00001000)
			{
			led_red=0x00090009L;
			led_green=0x00000000L;	
			}
		else if(flags&0b00010000)
			{
			led_red=0x00490049L;
			led_green=0x00000000L;	
			}			
	
		else if((link==ON)&&(flags&0b00100000))
			{
			led_red=0x00000000L;
			led_green=0x00030003L;
			} 
	
		if((jp_mode==jp1))
			{
			led_red=0x00000000L;
			led_green=0x33333333L;
			}
		else if((jp_mode==jp2))
			{
			led_red=0xccccccccL;
			led_green=0x00000000L;
			}
		}		
	else if(jp_mode==jp3)
		{
		if(main_cnt1<(5*ee_TZAS))
			{
			led_red=0x00000000L;
			led_green=0x03030303L;
			}
		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;	
			} 
			
		else if((flags&0b00011110)==0)
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;
			}
	    
	
		else if((flags&0b00111110)==0b00000100)
			{
			led_red=0x00010001L;
			led_green=0xffffffffL;	
			}
		else if(flags&0b00000010)
			{
			led_red=0x00010001L;
			led_green=0x00000000L;	
			} 
		else if(flags&0b00001000)
			{
			led_red=0x00090009L;
			led_green=0x00000000L;	
			}
		else if(flags&0b00010000)
			{
			led_red=0x00490049L;
			led_green=0xffffffffL;	
			}  
		}
	}
else if(bps_class==bpsIPS)	//если блок ИПСный
	{
	if(jp_mode!=jp3)
		{
		if(main_cnt1<(5*ee_TZAS))
			{
			led_red=0x00000000L;
			led_green=0x03030303L;
			}

		else if((link==ON)&&(flags_tu&0b10000000))
			{
			led_red=0x00055555L;
			led_green=0xffffffffL;
			} 

		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;	
			}  
		
		else  if(link==OFF)
			{
			if((flags&0b00011110)==0)
				{
				led_red=0x00000000L;
				if(bMAIN)led_green=0xfffffff5L;
				else led_green=0xffffffffL;
				}
	    	
			else if((flags&0b00111110)==0b00000100)
				{
				led_red=0x00010001L;
				if(bMAIN)led_green=0xfffffff5L;
				else led_green=0xffffffffL;	
				}
			else if(flags&0b00000010)
				{
				led_red=0x00010001L;
				if(bMAIN)led_green=0x00000005L;
				else led_green=0x00000000L;
				} 
			else if(flags&0b00001000)
				{
				led_red=0x00090009L;
				if(bMAIN)led_green=0x00000005L;
				else led_green=0x00000000L;	
				}
			else if(flags&0b00010000)
				{
				led_red=0x00490049L;
				if(bMAIN)led_green=0x00000005L;
				else led_green=0x00000000L;	
				}  
			else
				{
				led_red=0x55555555L;
				led_green=0xffffffffL;
				}


/*			if(bMAIN)
				{
				led_red=0x0L;
				led_green=0xfffffff5L;
				}
			else
				{
				led_red=0x55555555L;
				led_green=0xffffffffL;
				}*/
			}
				    
		else if((link==ON)&&((flags&0b00111110)==0))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;
			}
			
		else if((flags&0b00111110)==0b00000100)
			{
			led_red=0x00010001L;
			led_green=0xffffffffL;	
			}
		else if(flags&0b00000010)
			{
			led_red=0x00010001L;
			led_green=0x00000000L;	
			} 
		else if(flags&0b00001000)
			{
			led_red=0x00090009L;
			led_green=0x00000000L;	
			}
		else if(flags&0b00010000)
			{
			led_red=0x00490049L;
			led_green=0x00000000L;	
			}			
	
		else if((link==ON)&&(flags&0b00100000))
			{
			led_red=0x00000000L;
			led_green=0x00030003L;
			} 
	
		if((jp_mode==jp1))
			{
			led_red=0x00000000L;
			led_green=0x33333333L;
			}
		else if((jp_mode==jp2))
			{
			//if(ee_DEVICE)led_red=0xccccccacL;
			//else led_red=0xcc0cccacL;			
			led_red=0xccccccccL;
			led_green=0x00000000L;
			}
		}		
	else if(jp_mode==jp3)
		{
		if(main_cnt1<(5*ee_TZAS))
			{
			led_red=0x00000000L;
			led_green=0x03030303L;
			}
		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;	
			} 
			
		else if((flags&0b00011110)==0)
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;
			}
	    
	
		else if((flags&0b00111110)==0b00000100)
			{
			led_red=0x00010001L;
			led_green=0xffffffffL;	
			}
		else if(flags&0b00000010)
			{
			led_red=0x00010001L;
			led_green=0x00000000L;	
			} 
		else if(flags&0b00001000)
			{
			led_red=0x00090009L;
			led_green=0x00000000L;	
			}
		else if(flags&0b00010000)
			{
			led_red=0x00490049L;
			led_green=0xffffffffL;	
			}  
		}
	}
}



 
//-----------------------------------------------
void pwr_drv_(void)
{
DDRD.4=1;

if(main_cnt1<150)main_cnt1++;

if(main_cnt1<(5*TZAS))
	{
	PORTD.4=1;
	}         
else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
	{
	PORTD.4=0;
	}    	
else if(bBL)
	{
	PORTD.4=1;
	}
else if(!bBL)
	{
	PORTD.4=0;
	}

//DDRB|=0b00000010;

gran(&pwm_u,2,1020);


OCR1A=pwm_u;
/*PORTB.2=1;
OCR1A=0;*/
} 

//-----------------------------------------------
//Вентилятор
void vent_drv(void)
{

	
	short vent_pwm_i_necc=400;
	short vent_pwm_t_necc=400;
	short vent_pwm_max_necc=400;
	signed long tempSL;

	//I=1200;

	tempSL=36000L/(signed long)ee_Umax;
	tempSL=(signed long)I/tempSL;
	
	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
	
	if(tempSL>10)vent_pwm_i_necc=1000;
	else if(tempSL<1)vent_pwm_i_necc=400;
	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
	gran(&vent_pwm_i_necc,400,1000);
	//vent_pwm_i_necc=400;
	tempSL=(signed long)T;
	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
	gran(&vent_pwm_t_necc,400,1000);
	
	vent_pwm_max_necc=vent_pwm_i_necc;
	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
	
	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
	gran(&vent_pwm,400,1000);
	
	//vent_pwm=1000-vent_pwm;	// Для нового блока. Там похоже нужна инверсия
	//vent_pwm=300;
	if(bVENT_BLOCK)vent_pwm=0;
}

//-----------------------------------------------
void vent_resurs_hndl(void)
{
unsigned char temp;
if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
	{
	if(vent_resurs<60000)vent_resurs++;
	vent_resurs_sec_cnt=0;
	}

//vent_resurs=12543;

vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));

temp=vent_resurs_buff[0]&0x0f;
temp^=vent_resurs_buff[1]&0x0f;
temp^=vent_resurs_buff[2]&0x0f;
temp^=vent_resurs_buff[3]&0x0f;

vent_resurs_buff[0]|=(temp&0x03)<<4;
vent_resurs_buff[1]|=(temp&0x0c)<<2;
vent_resurs_buff[2]|=(temp&0x30);
vent_resurs_buff[3]|=(temp&0xc0)>>2;


vent_resurs_tx_cnt++;
if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;


}

//-----------------------------------------------
void volum_u_main_drv(void)
{
char i;

if(bMAIN)
	{
	if(Un<(UU_AVT-10))volum_u_main_+=5;
	else if(Un<(UU_AVT-1))volum_u_main_++;
	else if(Un>(UU_AVT+10))volum_u_main_-=10;
	else if(Un>(UU_AVT+1))volum_u_main_--;
	if(volum_u_main_>1020)volum_u_main_=1020;
	if(volum_u_main_<0)volum_u_main_=0;
	//volum_u_main_=700;
	
	i_main_sigma=0;
	i_main_num_of_bps=0;
	for(i=0;i<6;i++)
		{
		if(i_main_flag[i])
			{
			i_main_sigma+=i_main[i];
			i_main_flag[i]=1;
			i_main_num_of_bps++;
			}
		else
			{
			i_main_flag[i]=0;	
			}
		}
	i_main_avg=i_main_sigma/i_main_num_of_bps;
	for(i=0;i<6;i++)
		{
		if(i_main_flag[i])
			{
			if(i_main[i]<(i_main_avg-10))x[i]++;
			else if(i_main[i]>(i_main_avg+10))x[i]--;
			if(x[i]>100)x[i]=100;
			if(x[i]<-100)x[i]=-100;
			//if()
			}
			
		}
	//plazma_int[2]=x[1];
	}
}

//-----------------------------------------------
//Вычисление воздействий на силу
//10Hz
void pwr_hndl(void)				
{
if(ee_AVT_MODE==0x55)
	{
/*	if(ee_Device==0x55)
		{
		pwm_u=0x3ff;
		pwm_i=0x3ff;
		bBL=0;
		}
	else
 	if(ee_DEVICE)
		{
		pwm_u=0x00;
		pwm_i=0x00;
		bBL=1;
		}
	else */
		{
		if((flags&0b00011010)==0)
			{
			pwm_u=ee_U_AVT;
			gran(&pwm_u,0,1020);
		    	//pwm_i=0x3ff;
			if(pwm_i<1020)
				{
				pwm_i+=30;
				if(pwm_i>1020)pwm_i=1020;
				}
			bBL=0;
			bBL_IPS=0;
			}
		else if(flags&0b00001010)
			{
			pwm_u=0;
			pwm_i=0;
			bBL=1;
			bBL_IPS=1;
			}
		}
//pwm_u=950;
//		pwm_i=950;
	}
    
else if(jp_mode==jp3)
	{
	if((flags&0b00001010)==0)
		{
		pwm_u=500;
		if(pwm_i<1020)
			{
			pwm_i+=30;
			if(pwm_i>1020)pwm_i=1020;
			}
		bBL=0;
		}
	else if(flags&0b00001010)
		{
		pwm_u=0;
		pwm_i=0;
		bBL=1;
		}	
	
	}  
else if(jp_mode==jp2)
	{
	pwm_u=0;
	//pwm_i=0x3ff;
	if(pwm_i<1020)
		{
		pwm_i+=30;
		if(pwm_i>1020)pwm_i=1020;
		}
	bBL=0;
	}     
else if(jp_mode==jp1)
	{
	pwm_u=0x3ff;
	//pwm_i=0x3ff;
	if(pwm_i<1020)
		{
		pwm_i+=30;
		if(pwm_i>1020)pwm_i=1020;
		}
	bBL=0;
	} 

else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
	{
	pwm_u=volum_u_main_;
	//pwm_i=0x3ff;
	if(pwm_i<1020)
		{
		pwm_i+=30;
		if(pwm_i>1020)pwm_i=1020;
		}
	bBL_IPS=0;
	}

else if(link==OFF)
	{
/*	if(ee_Device==0x55)
		{
		pwm_u=0x3ff;
		pwm_i=0x3ff;
		bBL=0;
		}
	else*/
 	if(ee_DEVICE)
		{
		pwm_u=0x00;
		pwm_i=0x00;
		bBL=1;
		}
	else 
		{
		if((flags&0b00011010)==0)
			{
			pwm_u=ee_U_AVT;
			gran(&pwm_u,0,1020);
		    	//pwm_i=0x3ff;
			if(pwm_i<1020)
				{
				pwm_i+=30;
				if(pwm_i>1020)pwm_i=1020;
				}
			bBL=0;
			bBL_IPS=0;
			}
		else if(flags&0b00011010)
			{
			pwm_u=0;
			pwm_i=0;
			bBL=1;
			bBL_IPS=1;
			}
		}
//pwm_u=950;
//		pwm_i=950;
	}
	
		

else	if(link==ON)				//если есть связьvol_i_temp_avar
	{
	if((flags&0b00100000)==0)	//если нет блокировки извне
		{
		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
			{
			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
			if(!ee_DEVICE)
				{
				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
				else	pwm_i=vol_i_temp_avar;
				}
			else pwm_i=vol_i_temp_avar;
			
			bBL=0;
			}	
		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
			{
			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
		    	//pwm_i=vol_i_temp;
			if(!ee_DEVICE)
				{
				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
				else	pwm_i=vol_i_temp;
				}
			else pwm_i=vol_i_temp;			
			bBL=0;
			}
		else if(flags&0b00011010)					//если есть аварии
			{
			pwm_u=0;								//то полный стоп
			pwm_i=0;
			bBL=1;
			}
		}
	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
		{
		pwm_u=0;
	    	pwm_i=0;
		bBL=1;
		}
/*pwm_u=950;
		pwm_i=950;*/ 		
	}	   
//pwm_u=vol_u_temp;		
}

//-----------------------------------------------
//Воздействие на силу
//5Hz
void pwr_drv(void)
{
/*GPIOB->DDR|=(1<<2);
GPIOB->CR1|=(1<<2);
GPIOB->CR2&=~(1<<2);*/
BLOCK_INIT

if(main_cnt1<1500)main_cnt1++;

if((main_cnt1<25)&&(ee_DEVICE))
	{
	BLOCK_ON	
	}
else if((ee_DEVICE))
	{
	if(bBL)
		{
		BLOCK_ON
		}
	else if(!bBL)
		{
		BLOCK_OFF
		}	
	}
else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
	{
	BLOCK_ON
	//GPIOB->ODR|=(1<<2);
	}
else if(bps_class==bpsIPS)
		{
//GPIOB->ODR|=(1<<2);
		if(bBL_IPS)
			{
			 BLOCK_ON
			//GPIOB->ODR|=(1<<2);
			}
		else if(!bBL_IPS)
			{
			  BLOCK_OFF
			//GPIOB->ODR&=~(1<<2);
			}
		}
else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
	{
	if(bps_class==bpsIPS)
		{
		  BLOCK_OFF
		//GPIOB->ODR&=~(1<<2);
		}
	else if(bps_class==bpsIBEP)
		{
		if(ee_DEVICE)
			{
			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
			}
		else
			{
			BLOCK_OFF
			//GPIOB->ODR&=~(1<<2);
			}
		}
	}    	
else if(bBL)
	{
	BLOCK_ON
	//GPIOB->ODR|=(1<<2);
	}
else if(!bBL)
	{
	BLOCK_OFF
	//GPIOB->ODR&=~(1<<2);
	}

//pwm_u=800;
//pwm_u=400;

gran(&pwm_u,1,1020);
gran(&pwm_i,1,1020);

if(ee_AVT_MODE!=0x55)
    {
    if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
    }

//pwm_u=1000;
//pwm_i=1000;

//GPIOB->ODR|=(1<<3);

//pwm_u=100;
//pwm_i=400;
//vent_pwm=200;


OCR1AH= (char)(pwm_u/256);	
OCR1AL= (char)pwm_u;

OCR1BH= (char)(pwm_i/256);	
OCR1BL= (char)pwm_i;
/*
TIM1->CCR1H= (char)(pwm_i/256);	
TIM1->CCR1L= (char)pwm_i;

TIM1->CCR3H= (char)(vent_pwm/256);	
TIM1->CCR3L= (char)vent_pwm;*/

//OCR1AL= 260;//pwm_u;
//OCR1B= 0;//pwm_i;

OCR2B=(char)(vent_pwm/4);

}

//-----------------------------------------------
void pwr_hndl_(void)
{
//vol_u_temp=800;
if(jp_mode==jp3)
	{
	if((flags&0b00001010)==0)
		{
		pwm_u=500;
		//pwm_i=0x3ff;
		bBL=0;
		}
	else if(flags&0b00001010)
		{
		pwm_u=0;
		//pwm_i=0;
		bBL=1;
		}	
	
	}  
else if(jp_mode==jp2)
	{
	pwm_u=0;
	//pwm_i=0x3ff;
	bBL=0;
	}     
else if(jp_mode==jp1)
	{
	pwm_u=0x3ff;
	//pwm_i=0x3ff;
	bBL=0;
	} 
	
else if(link==OFF)
	{ 
	if((flags&0b00011010)==0)
		{
		pwm_u=ee_U_AVT;
		gran(&pwm_u,0,1020);
	    //	pwm_i=0x3ff;
		bBL=0;
		}
	else if(flags&0b00011010)
		{
		pwm_u=0;
		//pwm_i=0;
		bBL=1;
		}		
	}

else	if(link==ON)
	{
	if((flags&0b00100000)==0)
		{
		if(((flags&0b00011010)==0)||(flags&0b01000000))
			{
			pwm_u=vol_u_temp+_x_;
		    //	pwm_i=0x3ff;
			bBL=0;
			}
		else if(flags&0b00011010)
			{
			pwm_u=0;
			//pwm_i=0;
			bBL=1;
			}
		}
	else if(flags&0b00100000)
		{
		pwm_u=0;
	    //	pwm_i=0;
		bBL=1;
		}			
	}	   
//pwm_u=vol_u_temp;		
}

//-----------------------------------------------
void JP_drv(void)
{

DDRB.6=1;
DDRB.7=1;
PORTB.6=1;
PORTB.7=1;

if(PINB.6)
	{
	if(cnt_JP0<10)
		{
		cnt_JP0++;
		}			     
	}
else if(!PINB.6)
	{
	if(cnt_JP0)
		{
		cnt_JP0--;
		}	
	}
	 
if(PINB.7)
	{
	if(cnt_JP1<10)
		{
		cnt_JP1++;
		}			     
	}
else if(!PINB.7)
	{
	if(cnt_JP1)
		{
		cnt_JP1--;
		}	
	}	


if((cnt_JP0==10)&&(cnt_JP1==10))
	{
	jp_mode=jp0;
	}
if((cnt_JP0==0)&&(cnt_JP1==10))
	{
	jp_mode=jp1;
	}
if((cnt_JP0==10)&&(cnt_JP1==0))
	{
	jp_mode=jp2;
	}		 
if((cnt_JP0==0)&&(cnt_JP1==0))
	{
	jp_mode=jp3;
	}	
		
}

//-----------------------------------------------
void adc_hndl(void)
{                        
unsigned tempUI;
tempUI=ADCW;
adc_buff[adc_ch][adc_cnt]=tempUI;
/*if(adc_ch==2)
	{
	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
	}  */

if((adc_cnt&0x03)==0)
	{
	char i;
	adc_buff_[adc_ch]=0;
	for(i=0;i<16;i++)
		{
		adc_buff_[adc_ch]+=adc_buff[adc_ch][i];
		}                                     
	adc_buff_[adc_ch]>>=4;	
    //adc_buff_[adc_ch]=(adc_ch+1)*100;
	}                     

if(++adc_ch>=5)
	{
	adc_ch=0;
	if(++adc_cnt>=16)
		{
		adc_cnt=0;
		}
	}	          
DDRC&=0b11000000;
PORTC&=0b11000000;

if(adc_ch==0)       ADMUX=0b00000001; //ток
else if(adc_ch==1)  ADMUX=0b00000100; //напр ист
else if(adc_ch==2)  ADMUX=0b00000010; //напр нагр
else if(adc_ch==3)  ADMUX=0b00000011; //темпер
else if(adc_ch==4)  ADMUX=0b00000101; //доп


ADCSRA=0b10100110;
ADCSRA|=0b01000000;	

}

//-----------------------------------------------
void matemat(void)
{
signed long temp_SL;

#ifdef _220_
temp_SL=adc_buff_[0];
temp_SL-=K[0][0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0][1];
temp_SL/=2400;
I=(signed int)temp_SL;
#else

#ifdef _24_
temp_SL=adc_buff_[0];
temp_SL-=K[0][0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0][1];
temp_SL/=800;
I=(signed int)temp_SL;
#else
temp_SL=adc_buff_[0];
temp_SL-=K[0][0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0][1];
temp_SL/=1200;
I=(signed int)temp_SL;
#endif 
#endif

//I=adc_buff_[0];

temp_SL=adc_buff_[1];
//temp_SL-=K[1,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[2][1];
temp_SL/=1000;
Ui=(unsigned)temp_SL;

//Ui=K[2][1];


temp_SL=adc_buff_[2];
//temp_SL-=K[2,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[1][1];
temp_SL/=1000;
Un=(unsigned)temp_SL;
//Un=K[1][1];

temp_SL=adc_buff_[3];
temp_SL*=K[3][1];
temp_SL/=1326;
T=(signed)(temp_SL-273);
//T=TZAS;

Udb=flags;



}

//***********************************************
//***********************************************
//***********************************************
//***********************************************
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
//DDRD.0=1;
//PORTD.0=1;

//PORTD.1=0;

t0_init();
 
can_hndl1();

if(++t0_cnt4>=10)
	{
	t0_cnt4=0;
//	b100Hz=1;


if(++t0_cnt0>=10)
	{
	t0_cnt0=0;
	b10Hz=1;
	} 
if(++t0_cnt3>=3)
	{
	t0_cnt3=0;
	b33Hz=1;
	} 	
if(++t0_cnt1>=20)
	{
	t0_cnt1=0;
	b5Hz=1;
     bFl_=!bFl_;
	}
if(++t0_cnt2>=100)
	{
	t0_cnt2=0;
	b1Hz=1;
	}		
}
}

   
//===============================================
//===============================================
//===============================================
//===============================================
void main(void)
{
//DDRD.0=1;
//PORTD.0=0;
//DDRD.1=1;
//PORTD.1=1;

//while (1)
	//{
    //}
    
///DDRD.2=1;
///PORTD.2=1;

///DDRB.0=1;
///PORTB.0=0;

	PORTB.2=1;
	DDRB.2=1;
DDRB|=0b00110110;



// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 8000.000 kHz
// Mode: Fast PWM top=0x03FF
// OC1A output: Non-Inverted PWM
// OC1B output: Non-Inverted PWM
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 0.128 ms
// Output Pulse(s):
// OC1A Period: 0.128 ms Width: 0.032031 ms
// OC1B Period: 0.128 ms Width: 0.032031 ms
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (1<<WGM11) | (1<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);

TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

DDRB.1=1;
DDRB.2=1;


// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 8000.000 kHz
// Mode: Fast PWM top=0xFF
// OC2A output: Disconnected
// OC2B output: Non-Inverted PWM
// Timer Period: 0.032 ms
// Output Pulse(s):
// OC2B Period: 0.032 ms Width: 6.0235 us
ASSR=(0<<EXCLK) | (0<<AS2);
TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (1<<COM2B1) | (0<<COM2B0) | (1<<WGM21) | (1<<WGM20);
TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (1<<CS20);
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x30;

DDRD.3=1;

/*

TCCR1A=0x83;
TCCR1B=0x09;
TCNT1H=0x00;
TCNT1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;  */

SPCR=0x5D;
SPSR=0x00;
/*delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);*/
///delay_ms(100);
///delay_ms(100);
///delay_ms(100);
///delay_ms(100);
///delay_ms(100); 
///adr_hndl();

///if(adr==100)
///	{
///	adr_hndl();
///	delay_ms(100);
///	}
///if(adr==100)	
///	{
///	adr_hndl();
///	delay_ms(100);
///	}
//adr_drv_v3();
//AVT_MODE=1;
adr_hndl();
t0_init();



link_cnt=0;
if(ee_AVT_MODE!=0x55)link=ON;
/*
Umax=1000;
dU=100;
tmax=60;
tsign=50;
*/
main_cnt1=0;
//_x_ee_=20;
_x_=_x_ee_;

if((_x_>XMAX)||(_x_<-XMAX))_x_=0;

if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;

#asm("sei")
//granee(&K[0][1],420,1100);

#ifdef _220_
//granee(&K[1][1],4500,5500);
//granee(&K[2][1],4500,5500);
#else
//granee(&K[1][1],1360,1700);
//granee(&K[2][1],1360,1700);
#endif									


//K[1][1]=123;
//K[2][1]=456;
//granee(&K[1,1],1510,1850);
//granee(&K[2,1],1510,1850);
///DDRD.2=1;
///PORTD.2=0;
///delay_ms(100);
///PORTD.2=1;
can_init1();

//DDRD.1=1;
//PORTD.1=0;
DDRD.0=1;

//ee_AVT_MODE=0x55;
		pwm_u=0x00;
		pwm_i=0x00;
		bBL=1;
        

while (1)
	{
     
    //delay_ms(100);
	if(bIN1) 
		{
		bIN1=0;
	
		can_in_an1();
		} 
			
/*	if(b100Hz)
		{
		b100Hz=0;
		}*/   
	if(b33Hz)
		{
		b33Hz=0;
        
        adc_hndl();
		}   		
	if(b10Hz)
		{ 
		b10Hz=0;
        
		matemat();
		led_drv(); 
	    link_drv();
	    pwr_hndl();		//вычисление воздействий на силу
	    JP_drv();
	    flags_drv();
		net_drv();
		}
	if(b5Hz)
		{
		b5Hz=0;
        
        pwr_drv();
 		led_hndl();
        vent_drv();
		} 
    if(b1Hz)
		{
		b1Hz=0;
		
        temper_drv();			//вычисление аварий температуры
		u_drv();
        x_drv();
        
        if(main_cnt<1000)main_cnt++;
  		if((link==OFF)||(jp_mode==jp3))apv_hndl();
  		
		//Пересброс КАНа в случае зависания
  		can_error_cnt++;
  		if(can_error_cnt>=10)
  			{
  			can_error_cnt=0;
			can_init1();;
  			}
		
		volum_u_main_drv();
		
		//pwm_stat++;
		//if(pwm_stat>=10)pwm_stat=0;
        //adc_plazma_short++;

		vent_resurs_hndl(); 		
        }
     #asm("wdr")	
	}
}