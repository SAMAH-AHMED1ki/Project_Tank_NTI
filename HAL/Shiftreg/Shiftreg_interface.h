#ifndef SHIFTREG_H
#define SHIFTREG_H

#include "STD_TYPES.h"

/* Initialize Shift Register */
STD_ReturnType SHIFTREG_Init(void);

/* Send one byte to the Shift Register */
STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data);

#endif