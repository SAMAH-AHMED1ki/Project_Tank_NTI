/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Tank Finite State Machine - Header
 */

#ifndef TANK_FSM_H_
#define TANK_FSM_H_

#include "STD_TYPES.h"

/* تعريف حالات النظام (States) */
typedef enum
{
    FSM_STATE_IDLE = 0,
    FSM_STATE_FILLING,
    FSM_STATE_TRIPPED,
    FSM_STATE_SERVICE
} Tank_State_t;

/* تهيئة الـ FSM */
STD_ReturnType FSM_Init(void);

/* تنفيذ دورة الـ FSM وحساب الحالة الحالية */
STD_ReturnType FSM_Run(void);

/* إرجاع الحالة الحالية للنظام */
Tank_State_t FSM_GetState(void);

/* استقبال إشارة مسح الأعطال (Acknowledge) */
STD_ReturnType FSM_Ack(void);

#endif /* TANK_FSM_H_ */