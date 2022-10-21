//***********************************************
@far @interrupt void ADC2_EOC_Interrupt (void) {

signed long temp_adc;


adc_plazma[2]++;

/*		GPIOA->DDR|=(1<<1);
		GPIOA->CR1|=(1<<1);
		GPIOA->CR2&=~(1<<1);	
		GPIOA->ODR|=(1<<1);*/

ADC2->CSR&=~(1<<7);

temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));

//temp_adc=4000;
//temp_adc=720;

if(adr_drv_stat==1)
	{
	adr_drv_stat=2;
	adc_buff_[0]=temp_adc;
	}

else if(adr_drv_stat==3)
	{
	adr_drv_stat=4;
	adc_buff_[1]=temp_adc;
	}

else if(adr_drv_stat==5)
	{
	adr_drv_stat=6;
	adc_buff_[9]=temp_adc;
	}

adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;

adc_ch++;
if(adc_ch>=6)
	{
	adc_ch=0;
	adc_cnt_cnt++;
	if(adc_cnt_cnt>=8)
		{
		signed long tempSS;
		char i;
		adc_cnt_cnt=0;
		for(i=0;i<8;i++)
			{
			tempSS+=(signed long)adc_buff_buff[adc_ch][i];
			}
		adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
		
		adc_cnt++;
		if((adc_cnt&0x03)==0)
			{
			signed long tempSS;
			char i;
			tempSS=0;
			for(i=0;i<16;i++)
				{
				tempSS+=(signed long)adc_buff[adc_ch][i];
				}
			adc_buff_[adc_ch]=(signed short)(tempSS>>4);
			}
		}
	}



if(adc_ch==0)adc_buff_5=temp_adc;
if(adc_ch==2)adc_buff_1=temp_adc;

adc_plazma_short++;

}


//***********************************************
@far @interrupt void ADC2_EOC_Interrupt (void) {

signed long temp_adc;


adc_plazma[2]++;

/*		GPIOA->DDR|=(1<<1);
		GPIOA->CR1|=(1<<1);
		GPIOA->CR2&=~(1<<1);	
		GPIOA->ODR|=(1<<1);*/

ADC2->CSR&=~(1<<7);

temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));

//temp_adc=4000;
//temp_adc=720;

if(adr_drv_stat==1)
	{
	adr_drv_stat=2;
	adc_buff_[0]=temp_adc;
	}

else if(adr_drv_stat==3)
	{
	adr_drv_stat=4;
	adc_buff_[1]=temp_adc;
	}

else if(adr_drv_stat==5)
	{
	adr_drv_stat=6;
	adc_buff_[9]=temp_adc;
	}

adc_buff[adc_ch][adc_cnt]=temp_adc;

//adc_plazma=ADC1->DR;
//if(adc_ch==0)adc_plazma_short=temp_adc;



adc_ch++;
if(adc_ch>=6)
	{
//	adc_plazma++;
	adc_ch=0;
	adc_cnt++;
	if(adc_cnt>=16)
		{
		adc_cnt=0;
		}
	}

if((adc_cnt&0x03)==0)
	{
	signed long tempSS;
	char i;
	tempSS=0;
	for(i=0;i<16;i++)
		{
		tempSS+=(signed long)adc_buff[adc_ch][i];
		}
	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
	//else adc_buff_[adc_ch]=(signed short)(tempSS>>4);
	}

if(adc_ch==0)adc_buff_5=temp_adc;
if(adc_ch==2)adc_buff_1=temp_adc;

//adc_buff_[adc_ch]=adc_ch*10;

//GPIOD->ODR&=~(1<<0);

//ADC1->CR1&=~(1<<0);

//adc_plazma_short=adc_buff_[1];
adc_plazma_short++;

/*
adcw[0]=(ADC1->DB0RL)+((ADC1->DB0RH)*256);
adcw[1]=(ADC1->DB1RL)+((ADC1->DB1RH)*256);
adcw[2]=(ADC1->DB2RL)+((ADC1->DB2RH)*256);*/




//GPIOD->ODR|=(1<<0);


	
		//GPIOA->ODR&=~(1<<1);
}