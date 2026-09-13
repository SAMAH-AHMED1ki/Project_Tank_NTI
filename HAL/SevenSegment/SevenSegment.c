#include "SevenSegment_interface.h"

STD_ReturnType SevenSegment_Init(uint8 port)
{
    if (port > GPIO_PORTD)
    {
        return E_NOK;
    }
    // Set all pins of the specified port as output
    GPIO_SetPortDirection(port, 0xFF);
    return E_OK;
}
STD_ReturnType SevenSegment_DisplayNumber(uint8 port, uint8 digit)
{
    if (digit > 9)
    {
        return E_NOK; // Invalid number
    }

    // Define the segment patterns for numbers 0-9
    const uint8 segmentPatterns[10] = {
        0x3Fu, // 0: a b c d e f
        0x06u, // 1: b c
        0x5Bu, // 2: a b d e g
        0x4Fu, // 3: a b c d g
        0x66u, // 4: b c f g
        0x6Du, // 5: a c d f g
        0x7Du, // 6: a c d e f g
        0x07u, // 7: a b c
        0x7Fu, // 8: a b c d e f g
        0x6Fu  // 9: a b c d f g
    };

    // Set the port value to display the digit
    GPIO_SetPortValue(port, segmentPatterns[digit]);
    return E_OK;
}