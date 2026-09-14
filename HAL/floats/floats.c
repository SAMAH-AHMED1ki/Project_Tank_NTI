/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Float Switches HAL Driver
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "floats.h"

/* Project wiring:
 * High float -> PD2 / INT0
 * Low float  -> PD6
 */

#define HIGH_FLOAT_PORT GPIO_PORTD
#define HIGH_FLOAT_PIN GPIO_PIN2

#define LOW_FLOAT_PORT GPIO_PORTD
#define LOW_FLOAT_PIN GPIO_PIN6

/* Cached float states */
static uint8 Global_u8HighState = 0u;
static uint8 Global_u8LowState = 0u;

STD_ReturnType FLT_Init(void)
{
    STD_ReturnType Local_Status;

    /* Configure high float as input with internal pull-up */
    Local_Status =
        GPIO_SetPinDirection(
            HIGH_FLOAT_PORT,
            HIGH_FLOAT_PIN,
            GPIO_INPUT_PULLUP);

    if (Local_Status != E_OK)
    {
        return E_NOK;
    }

    /* Configure low float as input with internal pull-up */
    Local_Status =
        GPIO_SetPinDirection(
            LOW_FLOAT_PORT,
            LOW_FLOAT_PIN,
            GPIO_INPUT_PULLUP);

    if (Local_Status != E_OK)
    {
        return E_NOK;
    }

    /* Initial states */
    Global_u8HighState = 0u;
    Global_u8LowState = 0u;

    return E_OK;
}

STD_ReturnType FLT_Update(void)
{
    uint8 Local_u8PinHighVal = 0u;
    uint8 Local_u8PinLowVal = 0u;
    STD_ReturnType Local_Status;

    /* Read high float */
    Local_Status =
        GPIO_GetPinValue(
            HIGH_FLOAT_PORT,
            HIGH_FLOAT_PIN,
            &Local_u8PinHighVal);

    if (Local_Status != E_OK)
    {
        return E_NOK;
    }

    /* Read low float */
    Local_Status =
        GPIO_GetPinValue(
            LOW_FLOAT_PORT,
            LOW_FLOAT_PIN,
            &Local_u8PinLowVal);

    if (Local_Status != E_OK)
    {
        return E_NOK;
    }

    /*
     * INPUT_PULLUP:
     * Pin = 1 -> float inactive
     * Pin = 0 -> float active
     */
    Global_u8HighState =
        (Local_u8PinHighVal == 0u) ? 1u : 0u;

    Global_u8LowState =
        (Local_u8PinLowVal == 0u) ? 1u : 0u;

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