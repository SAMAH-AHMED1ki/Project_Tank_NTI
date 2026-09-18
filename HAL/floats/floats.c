#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "floats.h"

#define HIGH_FLOAT_PORT GPIO_PORTD
#define HIGH_FLOAT_PIN GPIO_PIN2

#define LOW_FLOAT_PORT GPIO_PORTD
#define LOW_FLOAT_PIN GPIO_PIN6

static uint8 Global_u8HighState = 0u;
static uint8 Global_u8LowState = 0u;

STD_ReturnType FLT_Init(void)
{
    STD_ReturnType Local_Status;

    Local_Status = GPIO_SetPinDirection(
        HIGH_FLOAT_PORT,
        HIGH_FLOAT_PIN,
        GPIO_INPUT_PULLUP);

    if (Local_Status != E_OK)
    {
        return E_NOK;
    }

    Local_Status = GPIO_SetPinDirection(
        LOW_FLOAT_PORT,
        LOW_FLOAT_PIN,
        GPIO_INPUT_PULLUP);

    if (Local_Status != E_OK)
    {
        return E_NOK;
    }

    Global_u8HighState = 0u;
    Global_u8LowState = 0u;

    return E_OK;
}

STD_ReturnType FLT_Update(void)
{
    uint8 Local_u8HighRaw = 0u;
    uint8 Local_u8LowRaw = 0u;

    GPIO_GetPinValue(
        HIGH_FLOAT_PORT,
        HIGH_FLOAT_PIN,
        &Local_u8HighRaw);

    GPIO_GetPinValue(
        LOW_FLOAT_PORT,
        LOW_FLOAT_PIN,
        &Local_u8LowRaw);

    /*
     * Pull-up logic:
     * Raw HIGH -> Float inactive
     * Raw LOW  -> Float active
     */
    Global_u8HighState = (Local_u8HighRaw == GPIO_LOW) ? 1u : 0u;
    Global_u8LowState = (Local_u8LowRaw == GPIO_LOW) ? 1u : 0u;

    return E_OK;
}

uint8 FLT_IsHighActive(void)
{
    return Global_u8HighState;
}

uint8 FLT_IsLowActive(void)
{
    return Global_u8LowState;
}