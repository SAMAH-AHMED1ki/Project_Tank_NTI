#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "BUTTONS_interface.h"

#define DEBOUNCE_TICKS 5u   /* 50 ms stability window */
#define ACK_HOLD_TICKS 100u /* 1000 ms hold window */

typedef struct
{
    uint8 pinBit;
    uint8 debounceCounter;
    uint8 rawState;
    uint8 debouncedState;
    uint8 lastDebouncedState;
    uint16 pressDurationTicks;
    uint8 longHoldReported;
    ButtonEvent_t pendingEvent;
} ButtonState_t;

static ButtonState_t s_buttons[BTN_COUNT] = {
    [BTN_MODE] = {.pinBit = BTN_MODE_PIN, .debounceCounter = 0, .rawState = 0, .debouncedState = 0, .lastDebouncedState = 0, .pressDurationTicks = 0, .longHoldReported = 0, .pendingEvent = BTN_EVENT_NONE},
    [BTN_MANUAL_START] = {.pinBit = BTN_MANUAL_START_PIN, .debounceCounter = 0, .rawState = 0, .debouncedState = 0, .lastDebouncedState = 0, .pressDurationTicks = 0, .longHoldReported = 0, .pendingEvent = BTN_EVENT_NONE},
    [BTN_ACK] = {.pinBit = BTN_ACK_PIN, .debounceCounter = 0, .rawState = 0, .debouncedState = 0, .lastDebouncedState = 0, .pressDurationTicks = 0, .longHoldReported = 0, .pendingEvent = BTN_EVENT_NONE}};

STD_ReturnType BTN_Init(uint8 port)
{
    STD_ReturnType status = E_OK;

    status |= GPIO_SetPinDirection(port, BTN_MODE_PIN, GPIO_INPUT);
    status |= GPIO_SetPinDirection(port, BTN_MANUAL_START_PIN, GPIO_INPUT);
    status |= GPIO_SetPinDirection(port, BTN_ACK_PIN, GPIO_INPUT);

    /* Enable Internal Pull-Ups */
    status |= GPIO_SetPinValue(port, BTN_MODE_PIN, GPIO_HIGH);
    status |= GPIO_SetPinValue(port, BTN_MANUAL_START_PIN, GPIO_HIGH);
    status |= GPIO_SetPinValue(port, BTN_ACK_PIN, GPIO_HIGH);

    return status;
}

void BTN_Update10ms(uint8 port)
{
    uint8 i;
    uint8 pinVal;

    for (i = 0; i < (uint8)BTN_COUNT; i++)
    {
        ButtonState_t *btn = &s_buttons[i];

        GPIO_GetPinValue(port, btn->pinBit, &pinVal);

        /* Active Low: Low pin state means pressed (1) */
        uint8 currentRaw = (pinVal == GPIO_LOW) ? 1u : 0u;

        /* Debounce Filter */
        if (currentRaw == btn->rawState)
        {
            if (btn->debounceCounter < DEBOUNCE_TICKS)
            {
                btn->debounceCounter++;
                if (btn->debounceCounter >= DEBOUNCE_TICKS)
                {
                    btn->debouncedState = currentRaw;
                }
            }
        }
        else
        {
            btn->rawState = currentRaw;
            btn->debounceCounter = 0;
        }

        /* Edge Detection */
        if (btn->debouncedState != btn->lastDebouncedState)
        {
            if (btn->debouncedState != 0u)
            {
                btn->pendingEvent = BTN_EVENT_PRESSED;
                btn->pressDurationTicks = 0;
                btn->longHoldReported = 0;
            }
            else
            {
                if (btn->longHoldReported == 0u)
                {
                    btn->pendingEvent = BTN_EVENT_SHORT_PRESS;
                }
                else
                {
                    btn->pendingEvent = BTN_EVENT_RELEASED;
                }
            }
            btn->lastDebouncedState = btn->debouncedState;
        }

        /* Hold Timing */
        if (btn->debouncedState != 0u)
        {
            btn->pressDurationTicks++;
            if ((btn->pressDurationTicks >= ACK_HOLD_TICKS) && (btn->longHoldReported == 0u))
            {
                btn->pendingEvent = BTN_EVENT_LONG_HOLD_1S;
                btn->longHoldReported = 1u;
            }
        }
    }
}

STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent)
{
    if ((btn >= BTN_COUNT) || (pEvent == NULL))
    {
        return E_NOK;
    }

    *pEvent = s_buttons[btn].pendingEvent;
    s_buttons[btn].pendingEvent = BTN_EVENT_NONE;

    return E_OK;
}

STD_ReturnType BTN_IsPressed(uint8 port, ButtonID_t btn, uint8 *pIsPressed)
{
    if ((btn >= BTN_COUNT) || (pIsPressed == NULL))
    {
        return E_NOK;
    }

    *pIsPressed = s_buttons[btn].debouncedState;

    return E_OK;
}