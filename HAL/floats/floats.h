/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Float Switches HAL Driver - Header
 */

#ifndef FLOATS_H_
#define FLOATS_H_

#include "STD_TYPES.h"

STD_ReturnType FLT_Init(void);
STD_ReturnType FLT_Update(void);

uint8 FLT_IsHighActive(void);
uint8 FLT_IsLowActive(void);

#endif /* FLOATS_H_ */