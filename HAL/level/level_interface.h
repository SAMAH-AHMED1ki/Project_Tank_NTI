#ifndef LEVEL_INTERFACE_H
#define LEVEL_INTERFACE_H

#include "STD_TYPES.h"
#include "ADC_interface.h"

typedef enum
{
    LEVEL_BAND_CRITICAL_LOW = 0, /* 0  - 9%  : Pump on, LOW warning on LCD */
    LEVEL_BAND_LOW,              /* 10 - 29% : Pump on                    */
    LEVEL_BAND_NORMAL,           /* 30 - 89% : Hysteresis zone - state held*/
    LEVEL_BAND_HIGH,             /* 90 - 98% : Pump off                   */
    LEVEL_BAND_OVERFLOW          /* 99 - 100%: Trip                       */
} LevelBand_t;

STD_ReturnType LEVEL_Init(uint8 adcChannel);

STD_ReturnType LEVEL_ReadPercentage(uint8 adcChannel, uint8 *pPercentage);

STD_ReturnType LEVEL_GetBand(uint8 levelPercent, LevelBand_t *pBand);

#endif