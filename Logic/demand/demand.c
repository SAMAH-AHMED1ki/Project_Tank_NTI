/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Application Pump Demand Logic
 */

#include "STD_TYPES.h"
#include "level_interface.h"
#include "floats.h"
#include "interlocks.h"
#include "demand.h"

static uint8 Global_u8PumpDemand = 0;

STD_ReturnType DEM_Init(void)
{
    Global_u8PumpDemand = 0;
    return E_OK;
}

STD_ReturnType DEM_Update(void)
{
    /* لو النظام في حالة فصل طوارئ (Trip)، ممنوع تماماً تشغيل المضخة */
    if (INT_IsSystemTripped() == 1)
    {
        Global_u8PumpDemand = 0;
        return E_OK;
    }

    /* مثال للمنطق: لو مفتاح التعويم السفلي بيشير لوجود نقص، أو الـ level قليل */
    /* (يمكن تعديل الشرط حسب تصميم المشروع الدقيق لمستويات الخزان) */
    if (FLT_IsLowActive() == 1)
    {
        Global_u8PumpDemand = 1; /* اطلب تشغيل المضخة */
    }
    else if (FLT_IsHighActive() == 1)
    {
        Global_u8PumpDemand = 0; /* الخزان اتملى، أوقف الطلب */
    }

    return E_OK;
}

uint8 DEM_GetPumpDemand(void)
{
    return Global_u8PumpDemand;
}