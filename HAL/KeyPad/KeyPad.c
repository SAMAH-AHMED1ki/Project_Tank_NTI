#include "KeyPad_interface.h"

STD_ReturnType Keypad_Init(uint8 port)
{
    if (port > GPIO_PORTD)
    {
        return E_NOK;
    }

    GPIO_SetPortDirection(port, 0xF0);

    return E_OK;
}

STD_ReturnType KeyPad_GetPressedKey(uint8 port, uint8 *pressedKey)
{
    uint8 columnValues;

    if (port > GPIO_PORTD || pressedKey == NULL)
    {
        return E_NOK;
    }
    GPIO_SetPortDirection(port, 0xF0);

    GPIO_GetPortValue(port, &columnValues);

    for (uint8 row = 0; row < 4; row++)
    {
        GPIO_SetPortValue(port, ~(1u << (row + 4)));
        for (uint8 col = 0; col < 4; col++)
        {
            GPIO_GetPortValue(port, &columnValues);
            if (!(columnValues & (1 << col)))
            {
                *pressedKey = row * 4 + col;
                return E_OK;
            }
        }
    }
    *pressedKey = 0xFF;
    return E_NOK;
}