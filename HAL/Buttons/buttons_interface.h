#ifndef BUTTONS_INTERFACE_H
#define BUTTONS_INTERFACE_H

#include "STD_TYPES.h"
#include "GPIO_interface.h"

#define BTN_MODE_PIN GPIO_PIN4
#define BTN_MANUAL_START_PIN GPIO_PIN5
#define BTN_ACK_PIN GPIO_PIN3

typedef enum
{
    BTN_MODE = 0,
    BTN_MANUAL_START = 1,
    BTN_ACK = 2,
    BTN_COUNT = 3
} ButtonID_t;

typedef enum
{
    BTN_EVENT_NONE = 0,
    BTN_EVENT_PRESSED = 1,
    BTN_EVENT_RELEASED = 2,
    BTN_EVENT_SHORT_PRESS = 3,
    BTN_EVENT_LONG_HOLD_1S = 4
} ButtonEvent_t;

STD_ReturnType BTN_Init(uint8 port);
void BTN_Update10ms(uint8 port);
STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent);
STD_ReturnType BTN_IsPressed(uint8 port, ButtonID_t btn, uint8 *pIsPressed);

#endif