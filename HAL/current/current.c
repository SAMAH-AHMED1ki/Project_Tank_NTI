#include "STD_TYPES.h"
#include "ADC_interface.h"
#include "current.h"

#define CURRENT_ADC_CHANNEL ADC_CHANNEL_2
#define CURRENT_MAX_MA 10000u
#define CURRENT_ADC_MAX_VAL 1023u

#define CURRENT_FILTER_SIZE 4u

static uint16 Global_u16CurrentmA = 0;

static uint16 Global_u16Samples[CURRENT_FILTER_SIZE] = {0};
static uint8 Global_u8SampleIndex = 0;
static uint32 Global_u32SampleSum = 0;

STD_ReturnType CUR_Init(void)
{
    uint8 Local_u8Index;

    Global_u16CurrentmA = 0;
    Global_u8SampleIndex = 0;
    Global_u32SampleSum = 0;

    for (Local_u8Index = 0;
         Local_u8Index < CURRENT_FILTER_SIZE;
         Local_u8Index++)
    {
        Global_u16Samples[Local_u8Index] = 0;
    }

    return E_OK;
}

STD_ReturnType CUR_Update(void)
{
    uint16 Local_u16AdcReading = 0;
    uint32 Local_u32CalculatedmA = 0;
    STD_ReturnType Local_Status;

    Local_Status =
        ADC_ReadChannel(CURRENT_ADC_CHANNEL, &Local_u16AdcReading);

    if (Local_Status == E_OK)
    {
        /*
         * Convert ADC reading (0..1023)
         * to current in mA (0..10000)
         */
        Local_u32CalculatedmA =
            ((uint32)Local_u16AdcReading * CURRENT_MAX_MA) / CURRENT_ADC_MAX_VAL;

        /*
         * Remove the oldest sample from the sum
         */
        Global_u32SampleSum -=
            Global_u16Samples[Global_u8SampleIndex];

        /*
         * Store the new sample
         */
        Global_u16Samples[Global_u8SampleIndex] =
            (uint16)Local_u32CalculatedmA;

        /*
         * Add the new sample to the sum
         */
        Global_u32SampleSum +=
            Global_u16Samples[Global_u8SampleIndex];

        /*
         * Move to the next position
         */
        Global_u8SampleIndex++;

        if (Global_u8SampleIndex >= CURRENT_FILTER_SIZE)
        {
            Global_u8SampleIndex = 0;
        }

        /*
         * 4-sample moving average
         */
        Global_u16CurrentmA =
            (uint16)(Global_u32SampleSum / CURRENT_FILTER_SIZE);
    }

    return Local_Status;
}

STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA)
{
    if (Copy_pu16CurrentmA == NULL)
    {
        return E_NOK;
    }

    *Copy_pu16CurrentmA = Global_u16CurrentmA;

    return E_OK;
}

uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA)
{
    if (Global_u16CurrentmA > Copy_u16LimitmA)
    {
        return 1u;
    }

    return 0u;
}
