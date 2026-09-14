/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Float Switches HAL Driver
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "floats.h"

/* تحديد البنوت الخاصة بمفاتيح التعويم (مثلاً على بورت A) */
#define HIGH_FLOAT_PORT GPIO_PORTA
#define HIGH_FLOAT_PIN GPIO_PIN0

#define LOW_FLOAT_PORT GPIO_PORTA
#define LOW_FLOAT_PIN GPIO_PIN1

static uint8 Global_u8HighState = 0;
static uint8 Global_u8LowState = 0;

STD_ReturnType FLT_Init(void)
{
    STD_ReturnType Local_Status = E_OK;

    /* ضبط أطراف مفاتيح التعويم كدخل مع تفعيل الـ Pull-up الداخلي للأمان */
    Local_Status &= GPIO_SetPinDirection(HIGH_FLOAT_PORT, HIGH_FLOAT_PIN, GPIO_INPUT_PULLUP);
    Local_Status &= GPIO_SetPinDirection(LOW_FLOAT_PORT, LOW_FLOAT_PIN, GPIO_INPUT_PULLUP);

    Global_u8HighState = 0;
    Global_u8LowState = 0;

    return Local_Status;
}

STD_ReturnType FLT_Update(void)
{
    uint8 Local_u8PinHighVal = 0;
    uint8 Local_u8PinLowVal = 0;
    STD_ReturnType Local_Status = E_OK;

    /* قراءة الحالة الحالية للأطراف باستخدام GPIO_GetPinValue */
    Local_Status |= GPIO_GetPinValue(HIGH_FLOAT_PORT, HIGH_FLOAT_PIN, &Local_u8PinHighVal);
    Local_Status |= GPIO_GetPinValue(LOW_FLOAT_PORT, LOW_FLOAT_PIN, &Local_u8PinLowVal);

    if (Local_Status == E_OK)
    {
        Global_u8HighState = Local_u8PinHighVal;
        Global_u8LowState = Local_u8PinLowVal;
    }

    return Local_Status;
}

uint8 FLT_IsHighActive(void)
{
    return Global_u8HighState;
}

uint8 FLT_IsLowActive(void)
{
    return Global_u8LowState;
}