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
# 12 "HAL/Buttons/BUTTONS_interface.h"
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


STD_ReturnType BTN_Init(uint8 port);


void BTN_Update10ms(uint8 port);


STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent);


STD_ReturnType BTN_IsPressed(uint8 port,
                             ButtonID_t btn,
                             uint8 *pIsPressed);
# 4 "HAL/Buttons/buttons.c" 2
# 16 "HAL/Buttons/buttons.c"
typedef struct
{
    uint8 pinBit;

    uint8 rawState;
    uint8 debouncedState;
    uint8 lastDebouncedState;

    uint8 debounceCounter;

    uint16 pressDurationTicks;

    uint8 longHoldReported;

    ButtonEvent_t pendingEvent;

} ButtonState_t;





static ButtonState_t s_buttons[BTN_COUNT] =
    {
        [BTN_MODE] =
            {
                .pinBit = 4u,
                .rawState = 0u,
                .debouncedState = 0u,
                .lastDebouncedState = 0u,
                .debounceCounter = 0u,
                .pressDurationTicks = 0u,
                .longHoldReported = 0u,
                .pendingEvent = BTN_EVENT_NONE},

        [BTN_MANUAL_START] =
            {
                .pinBit = 5u,
                .rawState = 0u,
                .debouncedState = 0u,
                .lastDebouncedState = 0u,
                .debounceCounter = 0u,
                .pressDurationTicks = 0u,
                .longHoldReported = 0u,
                .pendingEvent = BTN_EVENT_NONE},

        [BTN_ACK] =
            {
                .pinBit = 3u,
                .rawState = 0u,
                .debouncedState = 0u,
                .lastDebouncedState = 0u,
                .debounceCounter = 0u,
                .pressDurationTicks = 0u,
                .longHoldReported = 0u,
                .pendingEvent = BTN_EVENT_NONE}};





STD_ReturnType BTN_Init(uint8 port)
{
    STD_ReturnType status = E_OK;


    status |= GPIO_SetPinDirection(port,
                                   4u,
                                   0u);

    status |= GPIO_SetPinDirection(port,
                                   5u,
                                   0u);

    status |= GPIO_SetPinDirection(port,
                                   3u,
                                   0u);


    status |= GPIO_SetPinValue(port,
                               4u,
                               1u);

    status |= GPIO_SetPinValue(port,
                               5u,
                               1u);

    status |= GPIO_SetPinValue(port,
                               3u,
                               1u);

    return status;
}







void BTN_Update10ms(uint8 port)
{
    uint8 i;
    uint8 pinValue;
    uint8 currentRawState;

    for (i = 0u; i < BTN_COUNT; i++)
    {

        GPIO_GetPinValue(port,
                         s_buttons[i].pinBit,
                         &pinValue);







        if (pinValue == 0u)
        {
            currentRawState = 1u;
        }
        else
        {
            currentRawState = 0u;
        }





        if (currentRawState == s_buttons[i].rawState)
        {
            if (s_buttons[i].debounceCounter < 5u)
            {
                s_buttons[i].debounceCounter++;
            }
        }
        else
        {




            s_buttons[i].rawState = currentRawState;
            s_buttons[i].debounceCounter = 0u;
        }




        if (s_buttons[i].debounceCounter >= 5u)
        {
            s_buttons[i].debouncedState =
                s_buttons[i].rawState;
        }





        if (s_buttons[i].debouncedState !=
            s_buttons[i].lastDebouncedState)
        {


            if (s_buttons[i].debouncedState == 1u)
            {
                s_buttons[i].pendingEvent =
                    BTN_EVENT_PRESSED;

                s_buttons[i].pressDurationTicks = 0u;
                s_buttons[i].longHoldReported = 0u;
            }



            else
            {






                if (s_buttons[i].longHoldReported == 0u)
                {
                    s_buttons[i].pendingEvent =
                        BTN_EVENT_SHORT_PRESS;
                }
                else
                {
                    s_buttons[i].pendingEvent =
                        BTN_EVENT_RELEASED;
                }
            }

            s_buttons[i].lastDebouncedState =
                s_buttons[i].debouncedState;
        }





        if (s_buttons[i].debouncedState == 1u)
        {
            if (s_buttons[i].pressDurationTicks <
                100u)
            {
                s_buttons[i].pressDurationTicks++;
            }




            if ((i == BTN_ACK) &&
                (s_buttons[i].pressDurationTicks >=
                 100u) &&
                (s_buttons[i].longHoldReported == 0u))
            {
                s_buttons[i].pendingEvent =
                    BTN_EVENT_LONG_HOLD_1S;

                s_buttons[i].longHoldReported = 1u;
            }
        }
    }
}





STD_ReturnType BTN_GetEvent(ButtonID_t btn,
                            ButtonEvent_t *pEvent)
{
    if ((btn >= BTN_COUNT) || (pEvent == ((void *)0)))
    {
        return E_NOK;
    }

    *pEvent = s_buttons[btn].pendingEvent;


    s_buttons[btn].pendingEvent = BTN_EVENT_NONE;

    return E_OK;
}





STD_ReturnType BTN_IsPressed(uint8 port,
                             ButtonID_t btn,
                             uint8 *pIsPressed)
{
    if ((btn >= BTN_COUNT) ||
        (pIsPressed == ((void *)0)))
    {
        return E_NOK;
    }

    *pIsPressed = s_buttons[btn].debouncedState;

    return E_OK;
}
