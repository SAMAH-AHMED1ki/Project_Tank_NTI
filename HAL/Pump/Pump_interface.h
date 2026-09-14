#ifndef PUMP_H
#define PUMP_H

#include "STD_TYPES.h"

STD_ReturnType Pump_Init(void);
STD_ReturnType Pump_Set(uint8 Copy_u8State);
STD_ReturnType Pump_GetState(uint8 *Copy_pu8State);
STD_ReturnType Pump_GetRunSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType Pump_GetCycles(uint32 *Copy_pu32Cycles);
STD_ReturnType Pump_Update1s(void);

#endif