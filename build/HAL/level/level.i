# 0 "HAL/level/level.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/level/level.c"







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
# 9 "HAL/level/level.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 10 "HAL/level/level.c" 2
# 1 "HAL/level/level_interface.h" 1
# 19 "HAL/level/level_interface.h"
STD_ReturnType LVL_Init(void);







STD_ReturnType LVL_Update(uint8 Copy_u8Channel, uint8 *Copy_pu8Percentage);






STD_ReturnType LVL_GetPercent(uint8 *Copy_pu8Percentage);






STD_ReturnType LVL_GetRate(sint8 *Copy_pi8Rate);
# 11 "HAL/level/level.c" 2
# 1 "HAL/level/level_private.h" 1
# 18 "HAL/level/level_private.h"
static uint16 LVL_GetMedian(uint16 a, uint16 b, uint16 c);
# 12 "HAL/level/level.c" 2


static uint8 loc_u8PreviousPercent = 0;
static uint8 loc_u8IsFirstRead = 1;




static uint16 LVL_GetMedian(uint16 a, uint16 b, uint16 c)
{
    uint16 median;

    if ((a > b) ^ (a > c))
    {
        median = a;
    }
    else if ((b > a) ^ (b > c))
    {
        median = b;
    }
    else
    {
        median = c;
    }

    return median;
}




STD_ReturnType LVL_Init(void)
{
    loc_u8PreviousPercent = 0;
    loc_u8IsFirstRead = 1;
    return E_OK;
}




STD_ReturnType LVL_Update(uint8 Copy_u8Channel, uint8 *Copy_pu8Percentage)
{
    if (Copy_pu8Percentage == ((void *)0))
    {
        return E_NOK;
    }

    uint16 reading1 = 0;
    uint16 reading2 = 0;
    uint16 reading3 = 0;
    uint16 medianVal = 0;
    uint32 scaledVal = 0;

    if (ADC_ReadChannel(Copy_u8Channel, &reading1) != E_OK)
        return E_NOK;
    if (ADC_ReadChannel(Copy_u8Channel, &reading2) != E_OK)
        return E_NOK;
    if (ADC_ReadChannel(Copy_u8Channel, &reading3) != E_OK)
        return E_NOK;

    medianVal = LVL_GetMedian(reading1, reading2, reading3);

    if (medianVal > 1023)
    {
        medianVal = 1023;
    }

    scaledVal = ((uint32)medianVal * 100UL) / 1023UL;

    if (scaledVal > 100)
    {
        scaledVal = 100;
    }

    *Copy_pu8Percentage = (uint8)scaledVal;

    if (Copy_u8Channel == 0)
    {
        if (loc_u8IsFirstRead)
        {
            loc_u8PreviousPercent = (uint8)scaledVal;
            loc_u8IsFirstRead = 0;
        }
    }

    return E_OK;
}




STD_ReturnType LVL_GetPercent(uint8 *Copy_pu8Percentage)
{
    if (Copy_pu8Percentage == ((void *)0))
    {
        return E_NOK;
    }

    return LVL_Update(0, Copy_pu8Percentage);
}




STD_ReturnType LVL_GetRate(signed char *Copy_pi8Rate)
{
    if (Copy_pi8Rate == ((void *)0))
    {
        return E_NOK;
    }

    uint8 currentPercent = 0;
    if (LVL_GetPercent(&currentPercent) != E_OK)
    {
        return E_NOK;
    }


    signed short diff = (signed short)currentPercent - (signed short)loc_u8PreviousPercent;

    *Copy_pi8Rate = (signed char)diff;

    loc_u8PreviousPercent = currentPercent;

    return E_OK;
}
