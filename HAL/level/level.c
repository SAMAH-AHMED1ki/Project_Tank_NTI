/**
 * @file level.c
 * @author Samah Ahmed (Process Sensing & Demand Logic)
 * @brief Implementation of tank level acquisition, median noise filtering,
 *        scaling from ADC raw values to percentages, and rate-of-change calculation.
 */

#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "level_interface.h"
#include "level_private.h"

/* Static variables for rate of change calculation */
static uint8 loc_u8PreviousPercent = 0;
static uint8 loc_u8IsFirstRead = 1;

/**
 * @brief Filters noise by taking 3 consecutive readings and returning the median.
 */
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

/**
 * @brief Initializes the level module.
 */
STD_ReturnType LVL_Init(void)
{
    loc_u8PreviousPercent = 0;
    loc_u8IsFirstRead = 1;
    return E_OK;
}

/**
 * @brief Samples the given ADC channel 3 times, filters noise, and scales to 0-100%.
 */
STD_ReturnType LVL_Update(uint8 Copy_u8Channel, uint8 *Copy_pu8Percentage)
{
    if (Copy_pu8Percentage == NULL)
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

    if (Copy_u8Channel == LVL_ROOF_CHANNEL)
    {
        if (loc_u8IsFirstRead)
        {
            loc_u8PreviousPercent = (uint8)scaledVal;
            loc_u8IsFirstRead = 0;
        }
    }

    return E_OK;
}

/**
 * @brief Convenience function to get the roof tank level percentage.
 */
STD_ReturnType LVL_GetPercent(uint8 *Copy_pu8Percentage)
{
    if (Copy_pu8Percentage == NULL)
    {
        return E_NOK;
    }

    return LVL_Update(LVL_ROOF_CHANNEL, Copy_pu8Percentage);
}

/**
 * @brief Calculate the rate of change of the level (%/min).
 */
STD_ReturnType LVL_GetRate(signed char *Copy_pi8Rate)
{
    if (Copy_pi8Rate == NULL)
    {
        return E_NOK;
    }

    uint8 currentPercent = 0;
    if (LVL_GetPercent(&currentPercent) != E_OK)
    {
        return E_NOK;
    }

    /* Use signed int safely or standard calculation */
    signed short diff = (signed short)currentPercent - (signed short)loc_u8PreviousPercent;

    *Copy_pi8Rate = (signed char)diff;

    loc_u8PreviousPercent = currentPercent;

    return E_OK;
}