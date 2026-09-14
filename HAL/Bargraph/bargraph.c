#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "BARGRAPH_interface.h"

STD_ReturnType BARGRAPH_Init(uint8 port)
{
    STD_ReturnType status = E_OK;

    /* Configure PC2, PC3, PC4, PC5 as Outputs */
    status |= GPIO_SetPinDirection(port, BARGRAPH_LED0_PIN, GPIO_OUTPUT);
    status |= GPIO_SetPinDirection(port, BARGRAPH_LED1_PIN, GPIO_OUTPUT);
    status |= GPIO_SetPinDirection(port, BARGRAPH_LED2_PIN, GPIO_OUTPUT);
    status |= GPIO_SetPinDirection(port, BARGRAPH_LED3_PIN, GPIO_OUTPUT);

    /* Initial state: turn all bargraph LEDs off */
    status |= BARGRAPH_Off(port);

    return status;
}

STD_ReturnType BARGRAPH_SetLevel(uint8 port, uint8 levelPercent)
{
    STD_ReturnType status = E_OK;

    if (levelPercent > 100u)
    {
        return E_NOK;
    }

    /* Threshold comparison mapping */
    uint8 led0State = (levelPercent >= 25u) ? GPIO_HIGH : GPIO_LOW;
    uint8 led1State = (levelPercent >= 50u) ? GPIO_HIGH : GPIO_LOW;
    uint8 led2State = (levelPercent >= 75u) ? GPIO_HIGH : GPIO_LOW;
    uint8 led3State = (levelPercent == 100u) ? GPIO_HIGH : GPIO_LOW;

    status |= GPIO_SetPinValue(port, BARGRAPH_LED0_PIN, led0State);
    status |= GPIO_SetPinValue(port, BARGRAPH_LED1_PIN, led1State);
    status |= GPIO_SetPinValue(port, BARGRAPH_LED2_PIN, led2State);
    status |= GPIO_SetPinValue(port, BARGRAPH_LED3_PIN, led3State);

    return status;
}

STD_ReturnType BARGRAPH_Off(uint8 port)
{
    STD_ReturnType status = E_OK;

    status |= GPIO_SetPinValue(port, BARGRAPH_LED0_PIN, GPIO_LOW);
    status |= GPIO_SetPinValue(port, BARGRAPH_LED1_PIN, GPIO_LOW);
    status |= GPIO_SetPinValue(port, BARGRAPH_LED2_PIN, GPIO_LOW);
    status |= GPIO_SetPinValue(port, BARGRAPH_LED3_PIN, GPIO_LOW);

    return status;
}