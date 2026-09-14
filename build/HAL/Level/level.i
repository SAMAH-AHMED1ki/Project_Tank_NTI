# 0 "HAL/Level/level.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Level/level.c"
# 1 "LIB/STD_TYPES.h" 1
# 12 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1,
    E_PORT_NOT_VALID = 2,
    E_PIN_NOT_VALID = 3,
} STD_ReturnType;
# 2 "HAL/Level/level.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 3 "HAL/Level/level.c" 2
# 1 "HAL/Level/LEVEL_interface.h" 1






typedef enum
{
    LEVEL_BAND_CRITICAL_LOW = 0,
    LEVEL_BAND_LOW,
    LEVEL_BAND_NORMAL,
    LEVEL_BAND_HIGH,
    LEVEL_BAND_OVERFLOW
} LevelBand_t;

STD_ReturnType LEVEL_Init(uint8 adcChannel);

STD_ReturnType LEVEL_ReadPercentage(uint8 adcChannel, uint8 *pPercentage);

STD_ReturnType LEVEL_GetBand(uint8 levelPercent, LevelBand_t *pBand);
# 4 "HAL/Level/level.c" 2
# 12 "HAL/Level/level.c"
STD_ReturnType LEVEL_Init(uint8 adcChannel)
{
    return ADC_Init(1u, 6u);
}

STD_ReturnType LEVEL_ReadPercentage(uint8 adcChannel, uint8 *pPercentage)
{
    STD_ReturnType status = E_OK;
    uint16 samples[3];
    uint16 medianAdc;

    if (pPercentage == ((void *)0))
    {
        return E_NOK;
    }


    status |= ADC_ReadChannel(adcChannel, &samples[0]);
    status |= ADC_ReadChannel(adcChannel, &samples[1]);
    status |= ADC_ReadChannel(adcChannel, &samples[2]);

    if (status != E_OK)
    {
        return E_NOK;
    }


    if (samples[0] > samples[1])
        { uint16 temp = (samples[0]); (samples[0]) = (samples[1]); (samples[1]) = temp; };
    if (samples[1] > samples[2])
        { uint16 temp = (samples[1]); (samples[1]) = (samples[2]); (samples[2]) = temp; };
    if (samples[0] > samples[1])
        { uint16 temp = (samples[0]); (samples[0]) = (samples[1]); (samples[1]) = temp; };

    medianAdc = samples[1];


    uint32 calculatedPercent = ((uint32)medianAdc * 100u) / 1023u;

    if (calculatedPercent > 100u)
    {
        calculatedPercent = 100u;
    }

    *pPercentage = (uint8)calculatedPercent;

    return E_OK;
}

STD_ReturnType LEVEL_GetBand(uint8 levelPercent, LevelBand_t *pBand)
{
    if (pBand == ((void *)0))
    {
        return E_NOK;
    }

    if (levelPercent <= 9u)
    {
        *pBand = LEVEL_BAND_CRITICAL_LOW;
    }
    else if (levelPercent <= 29u)
    {
        *pBand = LEVEL_BAND_LOW;
    }
    else if (levelPercent <= 89u)
    {
        *pBand = LEVEL_BAND_NORMAL;
    }
    else if (levelPercent <= 98u)
    {
        *pBand = LEVEL_BAND_HIGH;
    }
    else
    {
        *pBand = LEVEL_BAND_OVERFLOW;
    }

    return E_OK;
}
