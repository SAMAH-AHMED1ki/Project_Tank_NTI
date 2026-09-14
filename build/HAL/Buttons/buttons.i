# 0 "HAL/Buttons/buttons.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Buttons/buttons.c"
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
# 2 "HAL/Buttons/buttons.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "HAL/Buttons/buttons.c" 2
# 1 "HAL/Buttons/BUTTONS_interface.h" 1
# 11 "HAL/Buttons/BUTTONS_interface.h"
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
# 4 "HAL/Buttons/buttons.c" 2




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
    [BTN_MODE] = {.pinBit = 4u, .debounceCounter = 0, .rawState = 0, .debouncedState = 0, .lastDebouncedState = 0, .pressDurationTicks = 0, .longHoldReported = 0, .pendingEvent = BTN_EVENT_NONE},
    [BTN_MANUAL_START] = {.pinBit = 5u, .debounceCounter = 0, .rawState = 0, .debouncedState = 0, .lastDebouncedState = 0, .pressDurationTicks = 0, .longHoldReported = 0, .pendingEvent = BTN_EVENT_NONE},
    [BTN_ACK] = {.pinBit = 3u, .debounceCounter = 0, .rawState = 0, .debouncedState = 0, .lastDebouncedState = 0, .pressDurationTicks = 0, .longHoldReported = 0, .pendingEvent = BTN_EVENT_NONE}};

STD_ReturnType BTN_Init(uint8 port)
{
    STD_ReturnType status = E_OK;

    status |= GPIO_SetPinDirection(port, 4u, 0u);
    status |= GPIO_SetPinDirection(port, 5u, 0u);
    status |= GPIO_SetPinDirection(port, 3u, 0u);


    status |= GPIO_SetPinValue(port, 4u, 1u);
    status |= GPIO_SetPinValue(port, 5u, 1u);
    status |= GPIO_SetPinValue(port, 3u, 1u);

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


        uint8 currentRaw = (pinVal == 0u) ? 1u : 0u;


        if (currentRaw == btn->rawState)
        {
            if (btn->debounceCounter < 5u)
            {
                btn->debounceCounter++;
                if (btn->debounceCounter >= 5u)
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


        if (btn->debouncedState != 0u)
        {
            btn->pressDurationTicks++;
            if ((btn->pressDurationTicks >= 100u) && (btn->longHoldReported == 0u))
            {
                btn->pendingEvent = BTN_EVENT_LONG_HOLD_1S;
                btn->longHoldReported = 1u;
            }
        }
    }
}

STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent)
{
    if ((btn >= BTN_COUNT) || (pEvent == ((void *)0)))
    {
        return E_NOK;
    }

    *pEvent = s_buttons[btn].pendingEvent;
    s_buttons[btn].pendingEvent = BTN_EVENT_NONE;

    return E_OK;
}

STD_ReturnType BTN_IsPressed(uint8 port, ButtonID_t btn, uint8 *pIsPressed)
{
    if ((btn >= BTN_COUNT) || (pIsPressed == ((void *)0)))
    {
        return E_NOK;
    }

    *pIsPressed = s_buttons[btn].debouncedState;

    return E_OK;
}
