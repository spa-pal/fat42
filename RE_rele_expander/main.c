/*
#define BLOCK_INIT  GPIOB->DDR|=(1<<2);GPIOB->CR1|=(1<<2);GPIOB->CR2&=~(1<<2);
#define BLOCK_ON 	{GPIOB->ODR|=(1<<2);bVENT_BLOCK=1;}
#define BLOCK_OFF 	{GPIOB->ODR&=~(1<<2);bVENT_BLOCK=0;}
#define BLOCK_IS_ON (GPIOB->ODR&(1<<2))
*/
#include "string.h"
//#include <iostm8s208.h>
#include <iostm8s103.h>
#include <stdlib.h>
#include "stm8s.h"
//#include "main.h"
@near short t0_cnt00=0;
@near short t0_cnt0=0;
@near char t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;
_Bool b100Hz, b10Hz, b5Hz, b2Hz, b1Hz, b1000Hz;

u8 mess[14];
@near short main_cnt;
/*
@near signed short adc_buff[10][16],adc_buff_[10],adc_buff_5,adc_buff_1;
char adc_ch,adc_cnt;
signed short adc_plazma_short,adc_plazma[5];*/
char led_ind_cnt;
char led_ind=5;
char adr_drv_stat=0;
/*@near char adr[3],adress;*/
@near char adress_error;
/*@near signed short adc_buff_buff[10][8];*/
/*char adc_cnt_cnt;
@near signed short pwm_u_buff[32],pwm_u_buff_;
@near char pwm_u_buff_ptr;
@near char pwm_u_buff_cnt;*/

#define BPS_MESS_STID	0x018e
#define BPS_MESS_STID_MASK	0x03ff
#define UKU_MESS_STID	0x009e
#define UKU_MESS_STID_MASK	0x03ff

#define XMAX 		25

#define CMND		0x16
#define MEM_KF 	0x62 
#define MEM_KF1 	0x26
#define MEM_KF4 	0x29
#define MEM_KF2 	0x27
#define ALRM_RES 	0x63
#define VENT_RES 	0x64
#define GETID 		0x90
#define PUTID 		0x91
#define PUTTM1 		0xDA
#define PUTTM2 	0xDB
#define PUTTM3 	0xDC
#define PUTTM 		0xDE
#define GETTM 		0xED 
#define KLBR 		0xEE
#define RELE_DATA		0x17

#define ON 0x55
#define OFF 0xaa

//КАН
char can_out_buff[4][16];
char can_buff_wr_ptr;
char can_buff_rd_ptr;
char bTX_FREE=1;
char tx_busy_cnt;
char bCAN_RX=0;
char can_error_cnt;

@near signed short I,Un,Ui,Udb,Unecc,U_out_const,Usum,Uin;
signed char T;
@eeprom signed short ee_K[5][2];


signed short umax_cnt,umin_cnt;
char link;
short link_cnt;

signed short main_cnt, main_cnt1;

//signed short tsign_cnt,tmax_cnt; 

//signed short pwm_u=200,pwm_i=50,pwm_u_;
enum {jp0,jp1,jp2,jp3} jp_mode;
char cnt_JP0,cnt_JP1;
_Bool bBL;
_Bool bBL_IPS=0;

char bRES=0;
char bRES_=0; 
char res_fl_cnt;

//Управление светодиодами
long led_red=0x00000000L;
long led_green=0x03030303L;
char led_drv_cnt=30;
long led_red_buff;
long led_green_buff;

//Отладка
signed short rotor_int=123;
signed short plazma_int[3];


_Bool bMAIN;
char cnt_net_drv;

//-----------------------------------------------
//Управление реле
char rele_data[2];

//-----------------------------------------------
void gran(signed short *adr, signed short min, signed short max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void granee(@eeprom signed short *adr, signed short min, signed short max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
}

//-----------------------------------------------
long delay_ms(short in)
{
long i,ii,iii;

i=((long)in)*100UL;

for(ii=0;ii<i;ii++)
	{
		iii++;
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

//else if(bps_class==bpsIBEP)	//если блок ИБЭПный
	{
	if(jp_mode!=jp3)
		{
	if((link==ON))
			{
			led_red=0x00055555L;
			led_green=0xffffffffL;
			} 

		else  if(link==OFF)
			{
			led_red=0x55555555L;
			led_green=0xffffffffL;
			}
				    
		else if((link==ON))
			{
			led_red=0x00000000L;
			led_green=0xffffffffL;
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
	led_red=0x00000000L;
	led_green=0xfffffffeL;			
		}		
	else if(jp_mode==jp3)
		{
		
		}
	}
//else if(bps_class==bpsIPS)	//если блок ИПСный
	{
	if(jp_mode!=jp3)
		{
		if(link==ON)
			{
			led_red=0x00055555L;
			led_green=0xffffffffL;
			} 

		else  if(link==OFF)
			{

			}
				    
					
	
		else if(link==ON)
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
		 
		}
	led_red=0xffffffffL;
	led_green=0x00000000L;		
	}
}

//-----------------------------------------------
void led_drv(void)
{
//Красный светодиод
GPIOA->DDR|=(1<<4);
GPIOA->CR1|=(1<<4);
GPIOA->CR2&=~(1<<4);
if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
else GPIOA->ODR&=~(1<<4); 

//Зеленый светодиод
GPIOA->DDR|=(1<<5);
GPIOA->CR1|=(1<<5);
GPIOA->CR2&=~(1<<5);	
if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
else GPIOA->ODR&=~(1<<5);


led_red_buff>>=1;
led_green_buff>>=1;
if(++led_drv_cnt>32)
	{
	led_drv_cnt=0;
	led_red_buff=led_red;
	led_green_buff=led_green;
	}

//?
//GPIOB->ODR|=(1<<4);
//GPIOB->ODR|=(1<<5);
} 

//-----------------------------------------------
void JP_drv(void)
{

GPIOD->DDR&=~(1<<6);
GPIOD->CR1|=(1<<6);
GPIOD->CR2&=~(1<<6);

GPIOD->DDR&=~(1<<7);
GPIOD->CR1|=(1<<7);
GPIOD->CR2&=~(1<<7);

if(GPIOD->IDR&(1<<6))
	{
	if(cnt_JP0<10)
		{
		cnt_JP0++;
		}			     
	}
else if(!(GPIOD->IDR&(1<<6)))
	{
	if(cnt_JP0)
		{
		cnt_JP0--;
		}	
	}
	 
if(GPIOD->IDR&(1<<7))
	{
	if(cnt_JP1<10)
		{
		cnt_JP1++;
		}			     
	}
else if(!(GPIOD->IDR&(1<<7)))
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
void link_drv(void)		//10Hz
{
if(jp_mode!=jp3)
	{
	if(link_cnt<602)link_cnt++;
	if(link_cnt==100)
		{
		link=OFF;
		
		//попробую вместо
		//if((AVT_MODE!=0x55)&&(!eeDEVICE))bMAIN=1;
		//написать
		//if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
		//else bMAIN=0;

		cnt_net_drv=0;
//    		if(!res_fl_)
			{
	    		bRES_=1;
//	    		res_fl_=1;
	    		}
    		}            
	}
else link=OFF;	
} 


//-----------------------------------------------
//Обслуживание реле
void rele_hndl(void)
{
}

/* -------------------------------------------------------------------------- */
void init_CAN(void) {
	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
	
	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
	
	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
	


//#ifdef ID_SCALE_8					// accepted range of IDs on filter 0
//	CAN->Page.Filter01.F0R1= MY_MESS_STID>>3;			// 8 bits mode
//	CAN->Page.Filter01.F0R2= MY_MESS_STID_MASK>>3;
//#endif
//#ifdef ID_SCALE_16
	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
	
	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
	
//#endif

	CAN->PSR= 6;									// set page 6
//#ifdef ID_LIST_MODE
//	CAN->Page.Config.FMR1|= 3;								//list mode
//#endif
//#ifdef ID_MASK_MODE
	CAN->Page.Config.FMR1&=~3;								//mask mode
//#endif
//#ifdef ID_SCALE_8
//	CAN->Page.Config.FCR1&= ~(CAN_FCR1_FSC00 | CAN_FCR1_FSC01);			//8 bit scale 
//#endif
//#ifdef ID_SCALE_16
	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
//#endif

	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
	
	
	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
	
	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
	
	CAN->IER|=(1<<1);
	
	
	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
}

//-----------------------------------------------
void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
{

if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;

can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);

can_out_buff[can_buff_wr_ptr][2]=data0;
can_out_buff[can_buff_wr_ptr][3]=data1;
can_out_buff[can_buff_wr_ptr][4]=data2;
can_out_buff[can_buff_wr_ptr][5]=data3;
can_out_buff[can_buff_wr_ptr][6]=data4;
can_out_buff[can_buff_wr_ptr][7]=data5;
can_out_buff[can_buff_wr_ptr][8]=data6;
can_out_buff[can_buff_wr_ptr][9]=data7;

can_buff_wr_ptr++;
if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
} 

//-----------------------------------------------
void can_tx_hndl(void)
{
if(bTX_FREE)
	{
	if(can_buff_rd_ptr!=can_buff_wr_ptr)
		{
		bTX_FREE=0;

		CAN->PSR= 0;
		CAN->Page.TxMailbox.MDLCR=8;
		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];

		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);

		can_buff_rd_ptr++;
		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;

		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
		CAN->IER|=(1<<0);
		}
	}
else 
	{
	tx_busy_cnt++;
	if(tx_busy_cnt>=100)
		{
		tx_busy_cnt=0;
		bTX_FREE=1;
		}
	}
}

//-----------------------------------------------
void can_in_an(void)
{
if((mess[6]==RELE_DATA)&&(mess[7]==RELE_DATA))
	{
	rele_data[0]=mess[8];
	rele_data[1]=mess[9];
	}

can_in_an_end:
bCAN_RX=0;
}   

//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 4;
	TIM4->ARR= 61;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//-----------------------------------------------
void t1_init(void)
{
TIM1->ARRH= 0x03;
TIM1->ARRL= 0xff;
TIM1->CCR1H= 0x00;	
TIM1->CCR1L= 0xff;
TIM1->CCR2H= 0x00;	
TIM1->CCR2L= 0x00;
TIM1->CCR3H= 0x00;	
TIM1->CCR3L= 0x64;

TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
TIM1->BKR|= TIM1_BKR_AOE;
}



//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{
TIM4->SR1&=~TIM4_SR1_UIF;


//GPIOB->ODR|=(1<<3);

if(++t0_cnt00>=10)
	{
	t0_cnt00=0;
	b1000Hz=1;
	}

if(++t0_cnt0>=100)
	{
	t0_cnt0=0;
	b100Hz=1;

	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;

		}
		
	if(++t0_cnt4>=50)
		{
		t0_cnt4=0;
		b2Hz=1;
		}
		
	if(++t0_cnt3>=100)
		{
		t0_cnt3=0;
		b1Hz=1;
		}
	}

			// disable break interrupt
//GPIOA->ODR&=~(1<<4);	
}

//***********************************************
@far @interrupt void CAN_RX_Interrupt (void) 
{
	
CAN->PSR= 7;									// page 7 - read messsage
//while (CAN->RFR & CAN_RFR_FMP01) {				// make up all received messages
memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
//				for(i=5; i<MY_MESS_DLC+5; ++i)
//					if(mess[i+1]!=MY_MESS[i]) { tout= 0; break;	};
//				if(tout)
//					set_Rx_LEDs();
//				CAN->RFR|= CAN_RFR_RFOM;				// release received message
//				while(CAN->RFR & CAN_RFR_RFOM);		// wait until the current message is released

//adress=30;
//if((mess[8]==0xeD)&&(mess[6]==adress)) GPIOA->ODR^=(1<<5);	

bCAN_RX=1;
CAN->RFR|=(1<<5);

}

//***********************************************
@far @interrupt void CAN_TX_Interrupt (void) 
{
if((CAN->TSR)&(1<<0))
	{
	bTX_FREE=1;	
	//GPIOA->ODR^=(1<<5);
	CAN->TSR|=(1<<0);
	}
}

//***********************************************
@far @interrupt void ADC2_EOC_Interrupt (void) {

ADC2->CSR&=~(1<<7);



}



//===============================================
//===============================================
//===============================================
//===============================================

main()
{

CLK->ECKR|=1;
while((CLK->ECKR & 2) == 0);
CLK->SWCR|=2;
CLK->SWR=0xB4;

delay_ms(200);
FLASH_DUKR=0xae;
FLASH_DUKR=0x56;
enableInterrupts();



t4_init();

		GPIOG->DDR|=(1<<0);
		GPIOG->CR1|=(1<<0);
		GPIOG->CR2&=~(1<<0);	
		//GPIOG->ODR^=(1<<0);

		GPIOG->DDR&=~(1<<1);
		GPIOG->CR1|=(1<<1);
		GPIOG->CR2&=~(1<<1);

//init_CAN();
//adc2_init();

//CAN->DGR&=0xfc;

GPIOC->DDR|=(1<<1);
GPIOC->CR1|=(1<<1);
GPIOC->CR2|=(1<<1);

GPIOC->DDR|=(1<<2);
GPIOC->CR1|=(1<<2);
GPIOC->CR2|=(1<<2);

/*
GPIOB->DDR|=(1<<2);
GPIOB->CR1|=(1<<2);
GPIOB->CR2|=(1<<2);
*/
t1_init();

GPIOA->DDR|=(1<<5);
GPIOA->CR1|=(1<<5);
GPIOA->CR2&=~(1<<5);
/*
GPIOB->DDR|=(1<<2);
GPIOB->CR1|=(1<<2);
GPIOB->CR2&=~(1<<2);
*/
GPIOB->DDR&=~(1<<3);
GPIOB->CR1&=~(1<<3);
GPIOB->CR2&=~(1<<3);

GPIOC->DDR|=(1<<3);
GPIOC->CR1|=(1<<3);
GPIOC->CR2|=(1<<3);


//Красный светодиод
GPIOA->DDR|=(1<<4);
GPIOA->CR1|=(1<<4);
GPIOA->CR2&=~(1<<4);

//Зеленый светодиод
GPIOA->DDR|=(1<<5);
GPIOA->CR1|=(1<<5);
GPIOA->CR2&=~(1<<5);	


while (1)
	{

	if(b1000Hz)
		{
		b1000Hz=0;

		}
	if(bCAN_RX)
		{
		bCAN_RX=0;
		can_in_an();	
		}
	if(b100Hz)
		{
		b100Hz=0;

		/*GPIOB->DDR|=(1<<5);
		GPIOB->CR1|=(1<<5);
		GPIOB->CR2&=~(1<<5);	
		GPIOB->ODR^=(1<<5);*/

		//GPIOC->ODR^=(1<<1);
		
		//adc2_init();
		can_tx_hndl();
      	}  
      	
	if(b10Hz)
		{
		b10Hz=0;
		
		//led_drv(); 
	  link_drv();

	  JP_drv();
		if(main_cnt<100)main_cnt++;
		
		rele_hndl();
		}

	if(b5Hz)
		{
		b5Hz=0;
		
		led_hndl();
   	}
      	
	if(b2Hz)
		{
		b2Hz=0;
//led_ind=adc_buff_[0]/100;

//		GPIOA->ODR^=(1<<5);


		
		}
      	
	if(b1Hz)
		{
		b1Hz=0;

	  		
          if(main_cnt<1000)main_cnt++;
  		
		//Пересброс КАНа в случае зависания
  		can_error_cnt++;
  		if(can_error_cnt>=10)
  			{
  			can_error_cnt=0;
			init_CAN();
  			}
		//
		GPIOA->ODR^=(1<<4)|(1<<5);
		}

	}
}