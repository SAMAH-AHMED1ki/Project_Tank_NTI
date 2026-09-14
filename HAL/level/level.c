#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "LEVEL_interface.h"

#define SWAP(a, b)         \
    {                      \
        uint16 temp = (a); \
        (a) = (b);         \
        (b) = temp;        \
    }

STD_ReturnType LEVEL_Init(uint8 adcChannel)
{
    return ADC_Init(ADC_REF_AVCC, ADC_PRESC_64);
}

STD_ReturnType LEVEL_ReadPercentage(uint8 adcChannel, uint8 *pPercentage)
{
    STD_ReturnType status = E_OK;
    uint16 samples[3];
    uint16 medianAdc;

    if (pPercentage == NULL)
    {
        return E_NOK;
    }

    /* 1. Take 3 consecutive ADC readings using ADC_ReadChannel from ADC.c */
    status |= ADC_ReadChannel(adcChannel, &samples[0]);
    status |= ADC_ReadChannel(adcChannel, &samples[1]);
    status |= ADC_ReadChannel(adcChannel, &samples[2]);

    if (status != E_OK)
    {
        return E_NOK;
    }

    /* 2. Sort the 3 samples to extract the median value (noise rejection) */
    if (samples[0] > samples[1])
        SWAP(samples[0], samples[1]);
    if (samples[1] > samples[2])
        SWAP(samples[1], samples[2]);
    if (samples[0] > samples[1])
        SWAP(samples[0], samples[1]);

    medianAdc = samples[1];

    /* 3. Convert 10-bit ADC value (0 - 1023) to percentage (0 - 100%) */
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
    if (pBand == NULL)
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