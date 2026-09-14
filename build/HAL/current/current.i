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
# 7 "HAL/current/current.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 8 "HAL/current/current.c" 2
# 1 "HAL/current/current.h" 1
# 12 "HAL/current/current.h"
STD_ReturnType CUR_Init(void);
STD_ReturnType CUR_Update(void);
STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA);
uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA);
# 9 "HAL/current/current.c" 2





static uint16 Global_u16CurrentmA = 0;

STD_ReturnType CUR_Init(void)
{
    Global_u16CurrentmA = 0;
    return E_OK;
}

STD_ReturnType CUR_Update(void)
{
    uint16 Local_u16AdcReading = 0;
    STD_ReturnType Local_Status = E_NOK;

    Local_Status = ADC_ReadChannel(2u, &Local_u16AdcReading);
    if (Local_Status == E_OK)
    {

        uint32 Local_u32CalculatedmA = ((uint32)Local_u16AdcReading * 10000) / (uint32)1023.0;


        Global_u16CurrentmA = (uint16)((Global_u16CurrentmA * 3 + Local_u32CalculatedmA) / 4);
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
        return 1;
    }
    return 0;
}
