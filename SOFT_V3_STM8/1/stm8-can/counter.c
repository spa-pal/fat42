/**
 * @authors
 * ����, 2012
 * @brief ���������� ���������� ���������
 * @file counter.c
 * @details
 * ������: Controller Area Network (CAN)
 * ���������������: STM8S208RB
 */

#include "main.h"
#include "counter.h"

//! �������, ������������� �������
volatile u8 uSeconds = 0;

/**
  * @brief �������� ������ � 2.
  * @par
  * ��������� �����������
  * @retval
  * ������������ �������� �����������
*/
void CounterTimerStart(void)
{
  TIM2_DeInit();
  
  TIM2_TimeBaseInit(TIM2_PRESCALER_32768, 610);
  
  TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);  
  
  TIM2_Cmd(ENABLE); 
}

/**
  * @brief ���������� ����������� ��������. ������ � 2.
  * @par
  * ��������� �����������
  * @retval
  * ������������ �������� �����������
*/
#ifdef _COSMIC_
@far @interrupt void TIM2_UPD_OVF_BRK_IRQHandler(void)
#else /* _RAISONANCE_ */
void TIM2_UPD_OVF_BRK_IRQHandler(void) interrupt 13
#endif /* _COSMIC_ */
{
  // �������� 1 �������
  ++uSeconds;
  TIM2_ClearITPendingBit(TIM2_IT_UPDATE);   
}
