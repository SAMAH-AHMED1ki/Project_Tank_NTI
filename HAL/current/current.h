/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Current Sensor HAL Driver - Header
 */

#ifndef CURRENT_H_
#define CURRENT_H_

#include "STD_TYPES.h"

/* Public APIs required by the project specifications */
STD_ReturnType CUR_Init(void);
STD_ReturnType CUR_Update(void);
STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA);
uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA);

#endif /* CURRENT_H_ */