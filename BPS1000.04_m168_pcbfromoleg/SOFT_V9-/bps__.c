#define F_REF 8000000L
#define F_COMP 10000L
#include <Mega168.h>
#include <delay.h>

//#define KAN_XTAL	8
#define KAN_XTAL	10
//#define KAN_XTAL	20
#include "cmd.c"
//-----------------------------------------------
// Символы передач
#define REGU 0xf5
#define REGI 0xf6
#define GetTemp 0xfc
#define TVOL0 0x75
#define TVOL1 0x76
#define TVOL2 0x77
#define TTEMPER	0x7c
#define CSTART  0x1a
#define CMND	0x16
#define Blok_flip	0x57
#define END 	0x0A
#define QWEST	0x25
#define IM	0x52
#define Add_kf 0x60
#define Sub_kf 0x61
#define ALRM_RES 0x63
#define Zero_kf2 0x64
#define MEM_KF 0x62
#define MEM_KF1 0x26
#define MEM_KF2 0x27
#define BLKON 0x80
#define BLKOFF 0x81
//#define Put_reg 0x90
#define GETID 0x90
#define PUTID 0x91
#define PUTTM1 0xDA
#define PUTTM2 0xDB
#define PUTTM 0xDE
#define GETTM 0xED
#define KLBR 0xEE
#define XMAX 25

#include <stdio.h>
#include <math.h>

#define ON 0x55
#define OFF 0xaa

//#define _220_
//#define _24_
//#define _110_
//#define _48/60_

bit bJP; //джампер одет
bit b100Hz;
bit b33Hz;
bit b10Hz;
bit b5Hz;
bit b1Hz;
bit bFl_;
bit bBL;

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

unsigned int adc_buff[4][16],adc_buff_[4];
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
long led_red=0x55555550L,led_green=0xaaaaaaaaL;
char link,link_cnt;
char led_drv_cnt=30;
eeprom signed int Umax,dU,tmax,tsign;
signed tsign_cnt,tmax_cnt;
unsigned int pwm_u=50,pwm_i=50;
signed umax_cnt,umin_cnt;
char flags_tu_cnt_on,flags_tu_cnt_off;
char adr_new,adr_old,adr_temp,adr_cnt;
eeprom char adr;
char cnt_JP0,cnt_JP1;
enum {jp0,jp1,jp2,jp3} jp_mode;
int main_cnt1;
signed _x_=13,_x__;
int _x_cnt;
eeprom signed _x_ee_;
eeprom int U_AVT;
eeprom char U_AVT_ON;

int main_cnt;
eeprom char TZAS;
char plazma;
int plazma_int[3];
int adc_ch_2_max,adc_ch_2_min;
char adc_ch_2_delta;
char cnt_adc_ch_2_delta;
char apv_cnt[3];
int apv_cnt_;
bit bAPV;
char cnt_apv_off;

eeprom char res_fl,res_fl_;
bit bRES=0;
bit bRES_=0;
char res_fl_cnt;
char off_bp_cnt;
//eeprom char adr_ee;

flash char CONST_ADR[]={0b00000111,0b00000111,0b00000111,0b00000010,0b00000011,0b00000001,0b00000000,0b00000111};

char can_error_cnt;
char link_cnt63;

#include "can_slave.c"
#define CS_DDR	DDRD.1
#define CS	PORTD.1
#define SPI_PORT_INIT  DDRB|=0b00101100;DDRB.4=0;
//#define _220_
//#define _24_
//#define _110_
#include "mcp2510.h"

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
bit bR1,bIN1,bOUT11;
char bR_cnt1,TX_len1;
char cnt_rcpt1,cnt_trsmt1;
bit bOUT_free1;
bit bOUT1;


char can_out_buff[8,4];
char can_buff_wr_ptr;
char can_buff_rd_ptr;

extern void granee(eeprom signed int *adr, signed int min, signed int max);
signed rotor_int=123;
short I63;
//-----------------------------------------------
void can_transmit1(char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
{
if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;

can_out_buff[0,can_buff_wr_ptr]=data0;
can_out_buff[1,can_buff_wr_ptr]=data1;
can_out_buff[2,can_buff_wr_ptr]=data2;
can_out_buff[3,can_buff_wr_ptr]=data3;
can_out_buff[4,can_buff_wr_ptr]=data4;
can_out_buff[5,can_buff_wr_ptr]=data5;
can_out_buff[6,can_buff_wr_ptr]=data6;
can_out_buff[7,can_buff_wr_ptr]=data7;

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

if(adr==62)
        {
        spi_write(RXF2SIDH, 0x31);
        spi_write(RXF2SIDL, 0xc0);
        }
else
        {
        spi_write(RXF2SIDH, 0x13);
        spi_write(RXF2SIDL, 0xc0);
        }

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
			spi_write(TXB0D0+n,can_out_buff[n,can_buff_rd_ptr]);
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


if(adr==62)
        {
        if((RXBUFF1[1]==0x33)&&(RXBUFF1[0]==1))
                {
                I63=RXBUFF1[2]+(RXBUFF1[3]*256);
                //_x_=I63;
                link_cnt63=0;
                }
        }
else if(adr==63)
        {

        }
else
        {

if((RXBUFF1[0]==1)&&(RXBUFF1[1]==2)&&(RXBUFF1[2]==3)&&(RXBUFF1[3]==4)&&(RXBUFF1[4]==5)&&(RXBUFF1[5]==6)&&(RXBUFF1[6]==7)&&(RXBUFF1[7]==8))can_transmit1(1,2,3,4,5,6,7,8);


if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==GETTM))
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
	can_transmit1(adr,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),*(((char*)&/*plazma_int[1]*/Ui)+1));
	can_transmit1(adr,PUTTM2,T,0,flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+1));
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
else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==KLBR)&&(RXBUFF1[3]==RXBUFF1[4]))
	{
	rotor_int++;
	if((RXBUFF1[3]&0xf0)==0x20)
		{
		if((RXBUFF1[3]&0x0f)==0x01)
			{
			K[0,0]=adc_buff_[0];
			}
		else if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[0,1]++;
			}
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[0,1]+=10;
			}
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[0,1]--;
			}
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[0,1]-=10;
			}
		granee(&K[0,1],420,1100);
		}
	else if((RXBUFF1[3]&0xf0)==0x10)
		{
		if((RXBUFF1[3]&0x0f)==0x01)
			{
			K[1,0]=adc_buff_[1];
			}
		else if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[1,1]++;
			}
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[1,1]+=10;
			}
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[1,1]--;
			}
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[1,1]-=10;
			}
		#ifdef _220_
		granee(&K[1,1],4500,5500);
		#endif
		#ifdef _110_
		granee(&K[1,1],2200,3500);
		#endif
		#ifdef _48/60_
		granee(&K[1,1],1360,1700);
		#endif
		#ifdef _24_
		granee(&K[1,1],1360,1700);
		#endif
		}

	else if((RXBUFF1[3]&0xf0)==0x00)
		{
		if((RXBUFF1[3]&0x0f)==0x01)
			{
			K[2,0]=adc_buff_[2];
			}
		else if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[2,1]++;
			}
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[2,1]+=10;
			}
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[2,1]--;
			}
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[2,1]-=10;
			}
		#ifdef _220_
		granee(&K[2,1],4500,5500);
		#endif
		#ifdef _110_
		granee(&K[2,1],2200,3500);
		#endif
		#ifdef _48/60_
		granee(&K[2,1],1360,1700);
		#endif
		#ifdef _24_
		granee(&K[2,1],1360,1700);
		#endif
		}

	else if((RXBUFF1[3]&0xf0)==0x30)
		{
		if((RXBUFF1[3]&0x0f)==0x02)
			{
			K[3,1]++;
			}
		else if((RXBUFF1[3]&0x0f)==0x03)
			{
			K[3,1]+=10;
			}
		else if((RXBUFF1[3]&0x0f)==0x04)
			{
			K[3,1]--;
			}
		else if((RXBUFF1[3]&0x0f)==0x05)
			{
			K[3,1]-=10;
			}
		granee(&K[3,1],425,517);
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
/*	else if((RXBUFF1[3]&0xf0)==0xB0)   //установка адреса(для ворот)
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
	if(Umax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) Umax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	if(dU!=(RXBUFF1[5]+(RXBUFF1[6]*256))) dU=(RXBUFF1[5]+(RXBUFF1[6]*256));

	}

else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF1))
	{
	if(tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	if(tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
	if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7];

	}

else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	{
	flags&=0b11100001;
	tsign_cnt=0;
	tmax_cnt=0;
	umax_cnt=0;
	umin_cnt=0;
	led_drv_cnt=30;
	}
else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	{
	if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--;
	else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
     gran(&_x_,-XMAX,XMAX);
	}
else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==RXBUFF1[4])&&(RXBUFF1[3]==0xee))
	{
	rotor_int++;
     tempI=pwm_u;
	U_AVT=tempI;
	delay_ms(100);
	if(U_AVT==tempI)can_transmit1(adr,PUTID,0xdd,0xdd,0,0,0,0);

	}


	}





can_in_an1_end:
bIN1=0;
}














//-----------------------------------------------
void t0_init(void)
{
TCCR0A=0x00;
TCCR0B=0x05;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

TCNT0=-8;
TIMSK0|=0b00000001;


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

if((adr==62)&&(link_cnt63<5))
        {
        //_x_=25;
        if((I>I63)&&((I-I63)>1))
                {
	        if(_x_cnt<5)
		        {
		        _x_cnt++;
		        if(_x_cnt>=5)
			        {
			        _x_--;
			        _x_cnt=0;
			        }
		        }
                }

        else if((I<I63)&&((I63-I)>1))
                {
	        if(_x_cnt<5)
		        {
		        _x_cnt++;
		        if(_x_cnt>=5)
			        {
			        _x_++;
			        _x_cnt=0;
			        }
		        }
                }
        else _x_cnt=0;

        gran(&_x_,-XMAX,XMAX);
        }
else if(adr==63)
        {
        }
else
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
void av_wrk_drv_(void)
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
void led_drv(void)
{

static long led_red_buff,led_green_buff;

DDRB.0=1;
if(led_green_buff&0b1L) PORTB.0=1;
else PORTB.0=0;
DDRD.7=1;
if(led_red_buff&0b1L) PORTD.7=1;
else PORTD.7=0;


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
	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000))))
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
signed tempSI;
char aaa[3];
char aaaa[3];
DDRC=0b00000000;
PORTC=0b00011110;
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



ADMUX=0b01000111;
ADCSRA=0b10100110;
ADCSRA|=0b01000000;
delay_ms(10);
//plazma_int[0]=ADCW;
aaa[0]=adr_gran(ADCW);
tempSI=ADCW/200;
gran(&tempSI,0,3);
aaaa[0]=(char)tempSI;

ADMUX=0b01000000;
ADCSRA=0b10100110;
ADCSRA|=0b01000000;
delay_ms(10);
//plazma_int[1]=ADCW;
aaa[1]=adr_gran(ADCW);
tempSI=ADCW/200;
gran(&tempSI,0,3);
aaaa[1]=(char)tempSI;


ADMUX=0b01000101;
ADCSRA=0b10100110;
ADCSRA|=0b01000000;
delay_ms(10);
//plazma_int[2]=ADCW;
aaa[2]=adr_gran(ADCW);
tempSI=ADCW/200;
gran(&tempSI,0,3);
aaaa[2]=(char)tempSI;

adr=100;
//adr=0;//aaa[0]+ (aaa[1]*4)+ (aaa[2]*16);

if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
	{
	if(aaa[0]==0)
		{
		if(aaa[1]==0)adr=3;
		else adr=0;
		}
	else if(aaa[1]==0)adr=1;
	else if(aaa[2]==0)adr=2;

	//adr=1;
	}
else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adr=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
   /*	{
	adr=0;
	} */
else adr=100;
/*if(adr_gran(aaa[2])==100)adr=2;
else *///adr=adr_gran(aaa[2]);
///adr=0;
//plazma=adr;
//if(adr==100)adr=0;

//plazma

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
		cnt_adc_ch_2_delta=0;
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
		cnt_adc_ch_2_delta=0;
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
		cnt_adc_ch_2_delta=0;
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

if((umin_cnt==0)&&(umax_cnt==0)&&(cnt_adc_ch_2_delta==0)&&(PORTD.2==0))
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
void link_drv(void)
{
if(jp_mode!=jp3)
	{
	if(link_cnt==49)flags&=0b11000001;
	if((++link_cnt>=50)&&(adr!=62)&&(adr!=63))
		{
		link_cnt=50;
    		link=OFF;
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

if(T>tsign) tsign_cnt++;
else if (T<(tsign-1)) tsign_cnt--;

gran(&tsign_cnt,0,60);

if(tsign_cnt>=55)
	{
	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100;
	}
else if (tsign_cnt<=5) flags&=0b11111011;




if(T>tmax) tmax_cnt++;
else if (T<(tmax-1)) tmax_cnt--;

gran(&tmax_cnt,0,60);

if(tmax_cnt>=55)
	{
	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	}
else if (tmax_cnt<=5) flags&=0b11111101;


}

//-----------------------------------------------
void u_drv(void)
{
if(jp_mode!=jp3)
	{
	if(Ui>Umax)umax_cnt++;
	else umax_cnt=0;
	gran(&umax_cnt,0,10);
	if(umax_cnt>=10)flags|=0b00001000;


	if((Ui<Un)&&((Un-Ui)>dU)&&(!PORTB.2))umin_cnt++;
	else umin_cnt=0;
	gran(&umin_cnt,0,10);
	if((umin_cnt>=10)&&(adr!=62)&&(adr!=63))flags|=0b00010000;
	}
else if(jp_mode==jp3)
	{
	if(Ui>700)umax_cnt++;
	else umax_cnt=0;
	gran(&umax_cnt,0,10);
	if(umax_cnt>=10)flags|=0b00001000;


	if((Ui<200)&&(!PORTB.2))umin_cnt++;
	else umin_cnt=0;
	gran(&umin_cnt,0,10);
	if(umin_cnt>=10)flags|=0b00010000;
	}
}

//-----------------------------------------------
void led_hndl(void)
{

if(adr==62)
	{
	if(main_cnt1<(5*TZAS))
		{
		led_red=0x00000000L;
		led_green=0x03030303L;
		}
	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
		{
		led_red=0x00000000L;
		led_green=0xffffffffL;
		}
	else if(((flags&0b00001110)==0))
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
        }
else if(adr==63)
	{
	if(main_cnt1<(5*TZAS))
		{
		led_red=0x00000000L;
		led_green=0x03030303L;
		}
	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
		{
		led_red=0x00000000L;
		led_green=0xfffffffeL;
		}
	else if(((flags&0b00001110)==0))
		{
		led_red=0x00000000L;
		led_green=0xfffffffeL;
		}
	else if((flags&0b00111110)==0b00000100)
		{
		led_red=0x00010001L;
		led_green=0xfffffffeL;
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
        }
else if(jp_mode!=jp3)
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
void pwr_drv(void)
{
DDRB.2=1;

if(main_cnt1<150)main_cnt1++;

if(main_cnt1<(5*TZAS))
	{
	PORTB.2=1;
	}
else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
	{
	PORTB.2=0;
	}
else if(bBL)
	{
	PORTB.2=1;
	}
else if(!bBL)
	{
	PORTB.2=0;
	}

DDRB|=0b00000010;

gran(&pwm_u,2,1020);


///OCR1AL=pwm_u;
/*PORTB.2=1;
OCR1A=0;*/
*((short*)&OCR1AL)=pwm_u;
//PORTB.2=0;
}

//-----------------------------------------------
void pwr_hndl(void)
{
//vol_u_temp=800;
if(adr==63)
        {
        if((flags&0b00001010)==0)
		{
		pwm_u=950;
		bBL=0;
		}
	else if(flags&0b00001010)
		{
		pwm_u=0;
		bBL=1;
		}
        }
else if(adr==62)
        {
        if((flags&0b00001010)==0)
		{
		pwm_u=950+_x_;
		bBL=0;
		}
	else if(flags&0b00001010)
		{
		pwm_u=0;
		bBL=1;
		}
        }
else if(jp_mode==jp3)
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
		pwm_u=U_AVT;
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
//pwm_u=500;
//pwm_i=500;
//bBL=1;
}

//-----------------------------------------------
void JP_drv(void)
{

DDRD.5=1;
DDRD.6=1;
PORTD.5=1;
PORTD.6=1;

if(PIND.5)
	{
	if(cnt_JP0<10)
		{
		cnt_JP0++;
		}
	}
else if(!PIND.5)
	{
	if(cnt_JP0)
		{
		cnt_JP0--;
		}
	}

if(PIND.6)
	{
	if(cnt_JP1<10)
		{
		cnt_JP1++;
		}
	}
else if(!PIND.6)
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
adc_buff[adc_ch,adc_cnt]=tempUI;
if(adc_ch==2)
	{
	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
	}

if((adc_cnt&0x03)==0)
	{
	char i;
	adc_buff_[adc_ch]=0;
	for(i=0;i<16;i++)
		{
		adc_buff_[adc_ch]+=adc_buff[adc_ch,i];
		}
	adc_buff_[adc_ch]>>=4;
	}

if(++adc_ch>=4)
	{
	adc_ch=0;
	if(++adc_cnt>=16)
		{
		adc_cnt=0;
		}
	}
DDRC&=0b11000000;
PORTC&=0b11000000;

if(adc_ch==0) ADMUX=0b01000010; //ток
else if(adc_ch==1) ADMUX=0b01000100; //напр ист
else if(adc_ch==2) ADMUX=0b01000011; //напр нагр
else if(adc_ch==3) ADMUX=0b01000001; //темпер

ADCSRA=0b10100110;
ADCSRA|=0b01000000;

}

//-----------------------------------------------
void matemat(void)
{
signed long temp_SL;
/*
#ifdef _220_
temp_SL=adc_buff_[0];
temp_SL-=K[0,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0,1];
temp_SL/=2400;
I=(signed int)temp_SL;
#else
*/
/*
#ifdef _110_
temp_SL=adc_buff_[0];
temp_SL-=K[0,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0,1];
temp_SL/=2400;
I=(signed int)temp_SL;
//I=53;
#else
*/

#ifdef _24_
temp_SL=adc_buff_[0];
temp_SL-=K[0,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0,1];
temp_SL/=400;
I=(signed int)temp_SL;
//I=234;
#endif

#ifdef _48/60_
temp_SL=adc_buff_[0];
temp_SL-=K[0,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0,1];
temp_SL/=250;
I=(signed int)temp_SL;
#endif

#ifdef _220_
temp_SL=adc_buff_[0];
temp_SL-=K[0,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0,1];
temp_SL/=1200;
I=(signed int)temp_SL;
#endif
//I=456;

#ifdef _110_
temp_SL=adc_buff_[0];
temp_SL-=K[0,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[0,1];
temp_SL/=1200;
I=(signed int)temp_SL;
#endif



#ifdef _24_
temp_SL=adc_buff_[1];
//temp_SL-=K[1,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[2,1];
temp_SL/=1000;
Ui=(unsigned)temp_SL;
#endif

#ifdef _48/60_
temp_SL=adc_buff_[1];
//temp_SL-=K[1,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[2,1];
temp_SL/=2000;
Ui=(unsigned)temp_SL;
#endif

#ifdef _110_
temp_SL=adc_buff_[1];
//temp_SL-=K[1,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[2,1];
temp_SL/=1000;
Ui=(unsigned)temp_SL;
#endif


#ifdef _220_
temp_SL=adc_buff_[1];
//temp_SL-=K[1,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[2,1];
temp_SL/=1000;
Ui=(unsigned)temp_SL;
#endif

#ifdef _24_
temp_SL=adc_buff_[2];
//temp_SL-=K[2,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[1,1];
temp_SL/=1000;
Un=(unsigned)temp_SL;
#endif

#ifdef _48/60_
temp_SL=adc_buff_[2];
//temp_SL-=K[2,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[1,1];
temp_SL/=2000;
Un=(unsigned)temp_SL;
#endif

#ifdef _110_
temp_SL=adc_buff_[2];
//temp_SL-=K[2,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[1,1];
temp_SL/=1000;
Un=(unsigned)temp_SL;
#endif

#ifdef _220_
temp_SL=adc_buff_[2];
//temp_SL-=K[2,0];
if(temp_SL<0) temp_SL=0;
temp_SL*=K[1,1];
temp_SL/=1000;
Un=(unsigned)temp_SL;
#endif


temp_SL=adc_buff_[3];
temp_SL*=K[3,1];
temp_SL/=1000;
T=(signed)(temp_SL-273);

Udb=flags;



}

//***********************************************
//***********************************************
//***********************************************
//***********************************************
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
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

DDRD.2=1;
PORTD.2=1;

DDRB.0=1;
PORTB.0=0;

PORTB.2=1;
DDRB.2=1;

DDRB|=0b00110110;

TCCR1A=0x83;
TCCR1B=0x09;
TCNT1H=0x00;
TCNT1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

SPCR=0x5D;
SPSR=0x00;


delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
delay_ms(100);
adr_hndl();

if(adr==100)
	{
	adr_hndl();
	delay_ms(100);
	}
if(adr==100)
	{
	adr_hndl();
	delay_ms(100);
	}

t0_init();



link_cnt=0;
link=ON;

main_cnt1=0;
//_x_ee_=20;
_x_=_x_ee_;

if((_x_>XMAX)||(_x_<-XMAX))_x_=0;

if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;

#asm("sei")
granee(&K[0,1],420,1100);

#ifdef _220_
granee(&K[1,1],4500,5500);
granee(&K[2,1],4500,5500);
#else
#ifdef _110_
granee(&K[1,1],2200,3500);
granee(&K[2,1],2200,3500);
#ifdef _48/60_
granee(&K[1,1],1000,5500);
granee(&K[2,1],1000,5500);
#else
granee(&K[1,1],1360,1700);
granee(&K[2,1],1360,1700);
#endif
#endif
#endif
//granee(&K[1,1],1510,1850);
//granee(&K[2,1],1510,1850);
DDRD.2=1;
PORTD.2=0;
delay_ms(100);
PORTD.2=1;
can_init1();

while (1)
	{
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
	        pwr_hndl();
	        JP_drv();
	        flags_drv();
		}
	if(b5Hz)
		{
		b5Hz=0;
 	        pwr_drv();
 		led_hndl();
		}
    	if(b1Hz)
		{
		b1Hz=0;
		temper_drv();
		u_drv();
                x_drv();

                if(main_cnt<1000)main_cnt++;
  		if((link==OFF)||(jp_mode==jp3))apv_hndl();

  		can_error_cnt++;
  		if(can_error_cnt>=10)
  			{
  			can_error_cnt=0;
  			DDRD.2=1;
			PORTD.2=0;
			delay_ms(100);
			PORTD.2=1;

			can_init1();
  			}
  		//can_transmit1(adr,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),*(((char*)&/*plazma_int[1]*/Ui)+1));
		//can_transmit1(adr,PUTTM2,T,0,flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+1));

		if((adr==62)||(adr==63))
		        {
		        can_transmit1(adr-62,0x33,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),*(((char*)&/*plazma_int[1]*/Ui)+1));
	                can_transmit1(adr-62,0x34,T,0,flags,(char) _x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+1));
		        }

		if(link_cnt63<20)link_cnt63++;

 		}
     #asm("wdr")
	}
}
