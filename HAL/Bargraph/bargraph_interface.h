#ifndef BARGRAPH_INTERFACE_H
#define BARGRAPH_INTERFACE_H

#include "STD_TYPES.h"
#include "GPIO_interface.h"

/* Level Indicator LED Pin Definitions (System Spec: PC2 - PC5) */
#define BARGRAPH_LED0_PIN GPIO_PIN2 /* Level >= 25% */
#define BARGRAPH_LED1_PIN GPIO_PIN3 /* Level >= 50% */
#define BARGRAPH_LED2_PIN GPIO_PIN4 /* Level >= 75% */
#define BARGRAPH_LED3_PIN GPIO_PIN5 /* Level >= 100% */

STD_ReturnType BARGRAPH_Init(uint8 port);

STD_ReturnType BARGRAPH_SetLevel(uint8 port, uint8 levelPercent);

STD_ReturnType BARGRAPH_Off(uint8 port);

#endif