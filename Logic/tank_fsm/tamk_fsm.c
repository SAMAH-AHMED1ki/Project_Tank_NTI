/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Tank Finite State Machine
 */

#include "STD_TYPES.h"
#include "interlocks.h"
#include "demand.h"
#include "tank_fsm.h"

static Tank_State_t Global_CurrentState = FSM_STATE_IDLE;

STD_ReturnType FSM_Init(void)
{
    Global_CurrentState = FSM_STATE_IDLE;
    return E_OK;
}

STD_ReturnType FSM_Run(void)
{
    /* 1. فحص الحماية أولاً (الأولوية القصوى لأي فصل طوارئ) */
    if (INT_IsSystemTripped() == 1)
    {
        Global_CurrentState = FSM_STATE_TRIPPED;
        return E_OK;
    }

    /* 2. إدارة الحالات بناءً على الحالة الحالية وطلب التشغيل */
    switch (Global_CurrentState)
    {
    case FSM_STATE_IDLE:
        if (DEM_GetPumpDemand() == 1)
        {
            Global_CurrentState = FSM_STATE_FILLING;
        }
        break;

    case FSM_STATE_FILLING:
        if (DEM_GetPumpDemand() == 0)
        {
            Global_CurrentState = FSM_STATE_IDLE;
        }
        break;

    case FSM_STATE_TRIPPED:
        /* لا يخرج من حالة الطوارئ تلقائياً، يحتاج إلى ACK بعد زوال السبب */
        break;

    case FSM_STATE_SERVICE:
        /* حالات الصيانة اليدوية */
        break;

    default:
        Global_CurrentState = FSM_STATE_IDLE;
        break;
    }

    return E_OK;
}

Tank_State_t FSM_GetState(void)
{
    return Global_CurrentState;
}

STD_ReturnType FSM_Ack(void)
{
    /* لا يتم مسح Trip إلا إذا زال السبب من قسم الحماية أولاً */
    if (INT_IsSystemTripped() == 0)
    {
        Global_CurrentState = FSM_STATE_IDLE;
        return E_OK;
    }

    return E_NOK; /* لا يمكن عمل ACK طالما سبب العطل قائماً */
}