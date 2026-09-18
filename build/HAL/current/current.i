# 0 "HAL/current/current.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/current/current.c"
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
# 2 "HAL/current/current.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 3 "HAL/current/current.c" 2
# 1 "HAL/current/current.h" 1
# 12 "HAL/current/current.h"
STD_ReturnType CUR_Init(void);
STD_ReturnType CUR_Update(void);
STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA);
uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA);
# 4 "HAL/current/current.c" 2







static uint16 Global_u16CurrentmA = 0;

static uint16 Global_u16Samples[4u] = {0};
static uint8 Global_u8SampleIndex = 0;
static uint32 Global_u32SampleSum = 0;

STD_ReturnType CUR_Init(void)
{
    uint8 Local_u8Index;

    Global_u16CurrentmA = 0;
    Global_u8SampleIndex = 0;
    Global_u32SampleSum = 0;

    for (Local_u8Index = 0;
         Local_u8Index < 4u;
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

    Local_Status = ADC_ReadChannel(2u, &Local_u16AdcReading);

    if (Local_Status == E_OK)
    {
        Local_u32CalculatedmA =
            ((uint32)Local_u16AdcReading * 10000u) / 1023u;

        Global_u32SampleSum -= Global_u16Samples[Global_u8SampleIndex];

        Global_u16Samples[Global_u8SampleIndex] =
            (uint16)Local_u32CalculatedmA;

        Global_u32SampleSum +=
            Global_u16Samples[Global_u8SampleIndex];

        Global_u8SampleIndex++;

        if (Global_u8SampleIndex >= 4u)
        {
            Global_u8SampleIndex = 0;
        }

        Global_u16CurrentmA =
            (uint16)(Global_u32SampleSum / 4u);
    }

    return Local_Status;
}

STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA)
{
    if (Copy_pu16CurrentmA == ((void *)0))
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
