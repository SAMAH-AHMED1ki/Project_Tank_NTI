#ifndef BUTTONS_INTERFACE_H
#define BUTTONS_INTERFACE_H

#include "STD_TYPES.h"
#include "GPIO_interface.h"

/* Button pins */
#define BTN_MODE_PIN GPIO_PIN4
#define BTN_MANUAL_START_PIN GPIO_PIN5
#define BTN_ACK_PIN GPIO_PIN3

typedef enum
{
    BTN_MODE = 0,
    BTN_MANUAL_START,
    BTN_ACK,
    BTN_COUNT
} ButtonID_t;

typedef enum
{
    BTN_EVENT_NONE = 0,
    BTN_EVENT_PRESSED,
    BTN_EVENT_RELEASED,
    BTN_EVENT_SHORT_PRESS,
    BTN_EVENT_LONG_HOLD_1S
} ButtonEvent_t;

/* Initialize buttons */
STD_ReturnType BTN_Init(uint8 port);

/* Call every 10 ms */
void BTN_Update10ms(uint8 port);

/* Get and clear pending event */
STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent);

/* Check current debounced state */
STD_ReturnType BTN_IsPressed(uint8 port,
                             ButtonID_t btn,
                             uint8 *pIsPressed);

#endif