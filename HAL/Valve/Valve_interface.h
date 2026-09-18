#ifndef VALVE_H
#define VALVE_H

#include "STD_TYPES.h"

STD_ReturnType Valve_Init(void);
STD_ReturnType Valve_Set(uint8 Copy_u8State);
STD_ReturnType Valve_GetState(uint8 *Copy_pu8State);

#endif