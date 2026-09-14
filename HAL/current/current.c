/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Current Sensor HAL Driver
 */

#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "current.h"

#define CURRENT_ADC_CHANNEL ADC_CHANNEL_2 /* قناة الـ ADC الخاصة بقراءة التيار */
#define CURRENT_MAX_MA 10000              /* أقصى تيار 10 أمبير = 10000 ملي أمبير */
#define CURRENT_ADC_MAX_VAL 1023.0        /* أقصى قيمة لـ ADC 10-bit */

static uint16 Global_u16CurrentmA = 0;

STD_ReturnType CUR_Init(void)
{
    Global_u16CurrentmA = 0;
    return E_OK;
}

STD_ReturnType CUR_Update(void)
{
    uint16 Local_u16AdcReading = 0;
    STD_ReturnType Local_Status = E_NOK;

    Local_Status = ADC_ReadChannel(CURRENT_ADC_CHANNEL, &Local_u16AdcReading);
    if (Local_Status == E_OK)
    {
        /* معادلة تحويل قراءة الـ ADC إلى ملي أمبير مع تصفية للتشوش */
        uint32 Local_u32CalculatedmA = ((uint32)Local_u16AdcReading * CURRENT_MAX_MA) / (uint32)CURRENT_ADC_MAX_VAL;

        /* فلتر بسيط لتثبيت القراءة (Exponential Smoothing) */
        Global_u16CurrentmA = (uint16)((Global_u16CurrentmA * 3 + Local_u32CalculatedmA) / 4);
    }

    return Local_Status;
}

STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA)
{
    if (Copy_pu16CurrentmA == NULL)
    {
        return E_NOK;
    }

    *Copy_pu16CurrentmA = Global_u16CurrentmA;
    return E_OK;
}

uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA)
{
    if (Global_u16CurrentmA > Copy_u16LimitmA)
    {
        return 1; /* متجاوز للحد الأقصى */
    }
    return 0;
}