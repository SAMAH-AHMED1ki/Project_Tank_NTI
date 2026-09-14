/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Application Interlocks & Safety Layer
 */

#include "STD_TYPES.h"
#include "current.h"
#include "floats.h"
#include "interlocks.h"

/* متغير لتتبع حالة الفصل (Trip State) */
static uint8 Global_u8TripStatus = 0;

STD_ReturnType INT_Init(void)
{
    Global_u8TripStatus = 0;
    return E_OK;
}

STD_ReturnType INT_Update(void)
{
    /* فحص الحماية: مثلاً لو التيار تجاوز الحد الآمن (فليكن 8000 ملي أمبير كحماية للموتور) */
    if (CUR_IsOverLimit(8000) == 1)
    {
        Global_u8TripStatus = 1; /* تفعيل حالة الطوارئ وفصل النظام */
    }
    else
    {
        /* يمكن إضافة شروط أمان أخرى هنا */
        Global_u8TripStatus = 0;
    }

    return E_OK;
}

uint8 INT_IsSystemTripped(void)
{
    return Global_u8TripStatus;
}