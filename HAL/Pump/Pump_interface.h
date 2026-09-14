#ifndef PUMP_H
#define PUMP_H

#include "STD_TYPES.h"

STD_ReturnType PMP_Init(void);
STD_ReturnType PMP_Set(uint8 Copy_u8State);
STD_ReturnType PMP_GetState(uint8 *Copy_pu8State);
STD_ReturnType PMP_RunSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_TotalSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_Cycles(uint32 *Copy_pu32Cycles);
STD_ReturnType PMP_Update1s(void);

#endif