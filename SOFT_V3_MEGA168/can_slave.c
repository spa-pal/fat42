#define CS_DDR	DDRB.0
#define CS	PORTB.0  
#define SPI_PORT_INIT  DDRB|=0b00101100;DDRB.4=0; 
//#define _220_
//#define _24_
#include "mcp2510.h"
#include "curr_version.h"

extern flash char Table87[];
extern flash char Table95[];
extern void gran(signed int *adr, signed int min, signed int max);
/*


char cob1[10],cib1[20];

char ch_cnt1;
bit bch_1Hz1;
bit bADRISON1,bADRISRQWST1;
char random1[4];
char tr_buff1[8];





char bd1[25]; 
*/
//#define CNF1_init	0b00000100  //tq=500ns   //20MHz
/*
#define CNF1_init	0b11000000  //tq=500ns   //8MHz
#define CNF2_init	0b11110001  //Ps1=7tq,Pr=2tq 
#define CNF3_init	0b00000010  //Ps2=6tq */

#if(KAN_XTAL==8)
#define CNF1_init	0b11000011  //tq=500ns   //8MHz
#define CNF2_init	0b11111011  //Ps1=7tq,Pr=2tq 
#define CNF3_init	0b00000010  //Ps2=6tq   
#elif(KAN_XTAL==10)
#define CNF1_init	0b11000011  //tq=500ns   //10MHz
#define CNF2_init	0b11111110  //Ps1=7tq,Pr=2tq 
#define CNF3_init	0b00000011  //Ps2=6tq
#elif(KAN_XTAL==20)
#define CNF1_init	0b11000111  //tq=500ns   //20MHz
#define CNF2_init	0b11111110  //Ps1=7tq,Pr=2tq 
#define CNF3_init	0b00000011  //Ps2=6tq
#endif

char can_st1,can_st_old1;
char RXBUFF1[40],RXBUFF_1[40],TXBUFF1[40];
char bR1,bIN1,bOUT11;
char bR_cnt1,TX_len1;
char cnt_rcpt1,cnt_trsmt1;
char bOUT_free1;
bit bOUT1; 


char can_out_buff[8][4];
char can_buff_wr_ptr;
char can_buff_rd_ptr;

extern void granee(eeprom signed int *adr, signed int min, signed int max);
signed rotor_int=123;
//-----------------------------------------------
void can_transmit1(char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
{
if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;

can_out_buff[0][can_buff_wr_ptr]=data0;
can_out_buff[1][can_buff_wr_ptr]=data1;
can_out_buff[2][can_buff_wr_ptr]=data2;
can_out_buff[3][can_buff_wr_ptr]=data3;
can_out_buff[4][can_buff_wr_ptr]=data4;
can_out_buff[5][can_buff_wr_ptr]=data5;
can_out_buff[6][can_buff_wr_ptr]=data6;
can_out_buff[7][can_buff_wr_ptr]=data7;

can_buff_wr_ptr++;
if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
} 
//-----------------------------------------------
void can_init1(void)
{
char spi_temp;                 

mcp_reset();
spi_temp=spi_read(CANSTAT);
if((spi_temp&0xe0)!=0x80)
	{
	spi_bit_modify(CANCTRL,0xe0,0x80);
	}
delay_us(10);		
spi_write(CNF1,CNF1_init);
spi_write(CNF2,CNF2_init);
spi_write(CNF3,CNF3_init);

spi_write(RXB0CTRL,0b00100000);
spi_write(RXB1CTRL,0b00100000);

delay_ms(10);

spi_write(RXM0SIDH, 0xFF); 
spi_write(RXM0SIDL, 0xFF); 
spi_write(RXF0SIDH, 0xFF); 
spi_write(RXF0SIDL, 0xFF); 
spi_write(RXF1SIDH, 0xFF);
spi_write(RXF1SIDL, 0xFF); 

spi_write(RXM1SIDH, 0xff); 
spi_write(RXM1SIDL, 0xe0); 

spi_write(RXF2SIDH, 0x13); 
spi_write(RXF2SIDL, 0xc0); 

spi_write(RXF3SIDH, 0x00); 
spi_write(RXF3SIDL, 0x00); 

spi_write(RXF4SIDH, 0x00); 
spi_write(RXF4SIDL, 0x00); 

spi_write(RXF5SIDH, 0x00); 
spi_write(RXF5SIDL, 0x00); 

spi_write(TXB2SIDH, 0x31); 
spi_write(TXB2SIDL, 0xc0); 

spi_write(TXB1SIDH, 0x31); 
spi_write(TXB1SIDL, 0xc0); 

spi_write(TXB0SIDH, 0x31); 
spi_write(TXB0SIDL, 0xc0); 



spi_bit_modify(CANCTRL,0xe7,0b00000101);

spi_write(CANINTE,0b00000110);
delay_ms(100);
spi_write(BFPCTRL,0b00000000);  

}



//-----------------------------------------------
void can_hndl1(void)
{
unsigned char temp,j,temp_index,c_temp;
static char ch_cnt;
#asm("cli")

can_st1=spi_read_status();
can_st_old1|=can_st1;

if(can_st1&0b00000010)
	{
	
	for(j=0;j<8;j++)
		{
		RXBUFF1[j]=spi_read(RXB1D0+j);
		}
	
	spi_bit_modify(CANINTF,0b00000010,0x00);
     bIN1=1;
	}
           
           
else if(/*(can_st1&0b10101000)&&*/(!(can_st1&0b01010100)))
	{
	char n;
     spi_bit_modify(CANINTF,0b00011100,0x00);
     
     if(can_buff_rd_ptr!=can_buff_wr_ptr)
     	{
         	for(n=0;n<8;n++)
			{ 
			spi_write(TXB0D0+n,can_out_buff[n][can_buff_rd_ptr]);
			} 
    		spi_write(TXB0DLC,8);
    		spi_rts(0); 
    		
    		can_buff_rd_ptr++;
    		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
    		} 
 	} 	
		
#asm("sei") 
}




//-----------------------------------------------
void can_in_an1(void)
{
char temp,i;
signed temp_S;
int tempI;



if((RXBUFF1[0]==1)&&(RXBUFF1[1]==2)&&(RXBUFF1[2]==3)&&(RXBUFF1[3]==4)&&(RXBUFF1[4]==5)&&(RXBUFF1[5]==6)&&(RXBUFF1[6]==7)&&(RXBUFF1[7]==8))can_transmit1(1,2,3,4,5,6,7,8);


if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&((RXBUFF1[2]==GETTM) || (RXBUFF1[2]==GETTM1) || (RXBUFF1[2]==GETTM2)))	
	{ 
	
	can_error_cnt=0;
	
	
 	flags_tu=RXBUFF1[3];
 	if(flags_tu&0b00000001)
 		{
 		if(flags_tu_cnt_off<4)
 			{
 			flags_tu_cnt_off++;
 			if(flags_tu_cnt_off>=4)flags|=0b00100000;
 			}
 		else flags_tu_cnt_off=4;
 		}
 	else  		
 		{
 		if(flags_tu_cnt_off)
 			{
 			flags_tu_cnt_off--;
 			if(flags_tu_cnt_off<=0)
 				{
 				flags&=0b11011111; 
 				off_bp_cnt=5*TZAS;
 				}
 			}
 		else flags_tu_cnt_off=0;
 		}
 		 
 	if(flags_tu&0b00000010) flags|=0b01000000;
 	else flags&=0b10111111; 
 		
 	vol_u_temp=RXBUFF1[4]+RXBUFF1[5]*256;
 	vol_i_temp=RXBUFF1[6]+RXBUFF1[7]*256;  
 	
 	//I=1234;
    //	Un=6543;
 	//Ui=6789;
 	//T=246;
 	//flags=0x55;
 	//_x_=33;
 	//rotor_int=1000;
 	rotor_int=flags_tu+(((int)flags)<<8); 
    //flags = 0x55;     
    plazma_int[1]=((short)flags)*10;
	can_transmit1(adress,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),*(((char*)&/*plazma_int[1]*/Ui)+1));
	can_transmit1(adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+1));
	if(RXBUFF1[2]==GETTM)	can_transmit1(adress,PUTTM3,/**(((char*)&debug_info_to_uku[0])+1)*/0,/**((char*)&debug_info_to_uku[0])*/0,/**(((char*)&debug_info_to_uku[1])+1)*/0,/**((char*)&	debug_info_to_uku[1])*/0,/**(((char*)&debug_info_to_uku[2])+1)*/0,/**((char*)&debug_info_to_uku[2])*/0);
	if(RXBUFF1[2]==GETTM1)	can_transmit1(adress,PUTTM31,*(((char*)&HARDVARE_VERSION)+1),*((char*)&HARDVARE_VERSION),*(((char*)&SOFT_VERSION)+1),*((char*)&SOFT_VERSION),*(((char*)&BUILD)+1),*((char*)&BUILD));
	if(RXBUFF1[2]==GETTM2)	can_transmit1(adress,PUTTM32,*(((char*)&BUILD_YEAR)+1),*((char*)&BUILD_YEAR),*(((char*)&BUILD_MONTH)+1),*((char*)&BUILD_MONTH),*(((char*)&BUILD_DAY)+1),*((char*)&BUILD_DAY));

     link_cnt=0;
     link=ON;
     
     if(flags_tu&0b10000000)
     	{
     	if(!res_fl)
     		{             
     		res_fl=1;
     		bRES=1;
     		res_fl_cnt=0;
     		}
     	}
     else 
     	{
     	if(main_cnt>20)
     		{
    			if(res_fl)
     			{
     			res_fl=0;
     			}
     		}
     	}	
     	
      if(res_fl_)
      	{
      	res_fl_=0;
      	}     	
	}
else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==KLBR)&&(RXBUFF1[3]==RXBUFF1[4]))
	{
	rotor_int++;
	if((RXBUFF1[3]&0xf0)==0x20)
		{
		if((RXBUFF1[3]&0x0f)==0x01)
			{
			K[0][0]=adc_buff_[0];
			}
		else if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[0][1]++;
			} 
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[0][1]+=10;
			}	 
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[0][1]--;
			} 
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[0][1]-=10;
			}
		granee(&K[0][1],300,5000);									
		}
	else if((RXBUFF1[3]&0xf0)==0x10)
		{
		/*if((RXBUFF1[3]&0x0f)==0x01)
			{
			K[1][0]=adc_buff_[1];
			}
		else*/ if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[1][1]++;
			} 
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[1][1]+=10;
			}	 
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[1][1]--;
			} 
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[1][1]-=10;
			}
		/*#ifdef _220_
		granee(&K[1][1],4500,5500);
		#else
		granee(&K[1][1],1360,1700);
		#endif*/									
		}		
		 
	else if((RXBUFF1[3]&0xf0)==0x00)
		{
		if((RXBUFF1[3]&0x0f)==0x01)
			{
			K[2][0]=adc_buff_[0];
			}
		else if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[2][1]++;
			} 
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[2][1]+=10;
			}	 
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[2][1]--;
			} 
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[2][1]-=10;
			}
		/*#ifdef _220_
		granee(&K[2][1],4500,5500);
		#else
		granee(&K[2][1],1360,1700);
		#endif	*/								
		}		 
		
	else if((RXBUFF1[3]&0xf0)==0x30)
		{
		if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[3][1]++;
			} 
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[3][1]+=10;
			}	 
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[3][1]--;
			} 
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[3][1]-=10;
			}
		granee(&K[3][1],/*480*/200,/*497*/1000);									
		}     
		
/*	else if((RXBUFF1[3]&0xf0)==0xA0)    //изменение адреса(инкремент и декремент)
		{
		//rotor++;
		if((RXBUFF1[3]&0x0f)==0x02)
			{
			adr_ee++;
			} 
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			adr_ee+=10;
			}	 
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			adr_ee--;
			} 
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			adr_ee-=10;
			}
		} */		
/*	else if((RXBUFF1[3]&0xf0)==0xB0)   //установка адреса(дл€ ворот)
		{      
		//rotor--;
		adr_ee=(RXBUFF1[3]&0x0f);
		}  */				
	link_cnt=0;
     link=ON;
     if(res_fl_)
      	{
      	res_fl_=0;
      	}       	
	
	
	} 

else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF))
	{
	//rotor_int++;	
	if(ee_Umax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_Umax=(RXBUFF1[3]+(RXBUFF1[4]*256)); 
	if(ee_dU!=(RXBUFF1[5]+(RXBUFF1[6]*256))) ee_dU=(RXBUFF1[5]+(RXBUFF1[6]*256));
	
    if((RXBUFF1[7]&0x0f)==0x05)
		{
		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
		}
	else if((RXBUFF1[7]&0x0f)==0x0a) 
        {
        if(ee_AVT_MODE!=0)ee_AVT_MODE=0;
        }
	}

else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&((RXBUFF1[2]==MEM_KF1)||(RXBUFF1[2]==MEM_KF4)))
	{
	if(ee_tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	if(ee_tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) ee_tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
	//if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7]; 

	if(RXBUFF1[2]==MEM_KF1)
		{
		if(ee_DEVICE!=0)ee_DEVICE=0;
		if(ee_TZAS!=(signed short)RXBUFF1[7]) ee_TZAS=(signed short)RXBUFF1[7];
		}
	if(RXBUFF1[2]==MEM_KF4)	//MEM_KF4 передают ” ”шки там, где нужно полное управление Ѕѕ—ами с ” ”, включить-выключить, короче не дл€ »ЅЁѕ
		{
		if(ee_DEVICE!=1)ee_DEVICE=1;
		if(ee_IMAXVENT!=(signed short)RXBUFF1[7]) ee_IMAXVENT=(signed short)RXBUFF1[7];
			if(ee_TZAS!=3) ee_TZAS=3;
		}
        	
	}

else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	{
	flags&=0b11100001;
	tsign_cnt=0;
	tmax_cnt=0;
	umax_cnt=0;
	umin_cnt=0;
	led_drv_cnt=30;
	}
else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==VENT_RES))
	{
	vent_resurs=0;
	}    		
else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	{
	if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--; 
	else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
     gran(&_x_,-XMAX,XMAX);
	}
else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==RXBUFF1[4])&&(RXBUFF1[3]==0xee))
	{
	rotor_int++;
     tempI=pwm_u;
	ee_U_AVT=tempI;
	delay_ms(100);
	if(ee_U_AVT==tempI)can_transmit1(adress,PUTID,0xdd,0xdd,0,0,0,0);
      
	}	





can_in_an1_end:
bIN1=0;
}

//-----------------------------------------------
void net_drv(void)
{ 
//char temp_;    
if(bMAIN)
	{
	if(++cnt_net_drv>=7) cnt_net_drv=0; 
	
	if(cnt_net_drv<=5) 
		{ 
		can_transmit1(cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
		i_main_bps_cnt[cnt_net_drv]++;
		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
		}
	else if(cnt_net_drv==6)
		{
		plazma_int[2]=pwm_u;
		can_transmit1(adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
		can_transmit1(adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
		}
	}
}   








 





