#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "BUTTONS_interface.h"

/* ============================================================
 * Configuration
 * ============================================================ */

#define DEBOUNCE_TICKS 5u   /* 5 × 10 ms = 50 ms */
#define ACK_HOLD_TICKS 100u /* 100 × 10 ms = 1 second */

/* ============================================================
 * Internal button structure
 * ============================================================ */

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

/* ============================================================
 * Button objects
 * ============================================================ */

static ButtonState_t s_buttons[BTN_COUNT] =
    {
        [BTN_MODE] =
            {
                .pinBit = BTN_MODE_PIN,
                .rawState = 0u,
                .debouncedState = 0u,
                .lastDebouncedState = 0u,
                .debounceCounter = 0u,
                .pressDurationTicks = 0u,
                .longHoldReported = 0u,
                .pendingEvent = BTN_EVENT_NONE},

        [BTN_MANUAL_START] =
            {
                .pinBit = BTN_MANUAL_START_PIN,
                .rawState = 0u,
                .debouncedState = 0u,
                .lastDebouncedState = 0u,
                .debounceCounter = 0u,
                .pressDurationTicks = 0u,
                .longHoldReported = 0u,
                .pendingEvent = BTN_EVENT_NONE},

        [BTN_ACK] =
            {
                .pinBit = BTN_ACK_PIN,
                .rawState = 0u,
                .debouncedState = 0u,
                .lastDebouncedState = 0u,
                .debounceCounter = 0u,
                .pressDurationTicks = 0u,
                .longHoldReported = 0u,
                .pendingEvent = BTN_EVENT_NONE}};

/* ============================================================
 * BTN_Init
 * ============================================================ */

STD_ReturnType BTN_Init(uint8 port)
{
    STD_ReturnType status = E_OK;

    /* Configure pins as inputs */
    status |= GPIO_SetPinDirection(port,
                                   BTN_MODE_PIN,
                                   GPIO_INPUT);

    status |= GPIO_SetPinDirection(port,
                                   BTN_MANUAL_START_PIN,
                                   GPIO_INPUT);

    status |= GPIO_SetPinDirection(port,
                                   BTN_ACK_PIN,
                                   GPIO_INPUT);

    /* Enable internal pull-up resistors */
    status |= GPIO_SetPinValue(port,
                               BTN_MODE_PIN,
                               GPIO_HIGH);

    status |= GPIO_SetPinValue(port,
                               BTN_MANUAL_START_PIN,
                               GPIO_HIGH);

    status |= GPIO_SetPinValue(port,
                               BTN_ACK_PIN,
                               GPIO_HIGH);

    return status;
}

/* ============================================================
 * BTN_Update10ms
 *
 * Must be called every 10 ms
 * ============================================================ */

void BTN_Update10ms(uint8 port)
{
    uint8 i;
    uint8 pinValue;
    uint8 currentRawState;

    for (i = 0u; i < BTN_COUNT; i++)
    {
        /* Read physical pin */
        GPIO_GetPinValue(port,
                         s_buttons[i].pinBit,
                         &pinValue);

        /*
         * Active LOW:
         *
         * Pin = LOW  -> Button pressed
         * Pin = HIGH -> Button released
         */
        if (pinValue == GPIO_LOW)
        {
            currentRawState = 1u;
        }
        else
        {
            currentRawState = 0u;
        }

        /* ====================================================
         * Debouncing
         * ==================================================== */

        if (currentRawState == s_buttons[i].rawState)
        {
            if (s_buttons[i].debounceCounter < DEBOUNCE_TICKS)
            {
                s_buttons[i].debounceCounter++;
            }
        }
        else
        {
            /*
             * Raw state changed.
             * Start a new stability period.
             */
            s_buttons[i].rawState = currentRawState;
            s_buttons[i].debounceCounter = 0u;
        }

        /*
         * State has remained stable for 50 ms
         */
        if (s_buttons[i].debounceCounter >= DEBOUNCE_TICKS)
        {
            s_buttons[i].debouncedState =
                s_buttons[i].rawState;
        }

        /* ====================================================
         * Detect state change
         * ==================================================== */

        if (s_buttons[i].debouncedState !=
            s_buttons[i].lastDebouncedState)
        {
            /* ---------------- PRESSED ---------------- */

            if (s_buttons[i].debouncedState == 1u)
            {
                s_buttons[i].pendingEvent =
                    BTN_EVENT_PRESSED;

                s_buttons[i].pressDurationTicks = 0u;
                s_buttons[i].longHoldReported = 0u;
            }

            /* ---------------- RELEASED ---------------- */

            else
            {
                /*
                 * ACK:
                 * If it reached 1 second, report LONG_HOLD.
                 *
                 * Otherwise report SHORT_PRESS.
                 */
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

        /* ====================================================
         * Hold timing
         * ==================================================== */

        if (s_buttons[i].debouncedState == 1u)
        {
            if (s_buttons[i].pressDurationTicks <
                ACK_HOLD_TICKS)
            {
                s_buttons[i].pressDurationTicks++;
            }

            /*
             * Only ACK has a meaningful 1-second hold.
             */
            if ((i == BTN_ACK) &&
                (s_buttons[i].pressDurationTicks >=
                 ACK_HOLD_TICKS) &&
                (s_buttons[i].longHoldReported == 0u))
            {
                s_buttons[i].pendingEvent =
                    BTN_EVENT_LONG_HOLD_1S;

                s_buttons[i].longHoldReported = 1u;
            }
        }
    }
}

/* ============================================================
 * BTN_GetEvent
 * ============================================================ */

STD_ReturnType BTN_GetEvent(ButtonID_t btn,
                            ButtonEvent_t *pEvent)
{
    if ((btn >= BTN_COUNT) || (pEvent == NULL))
    {
        return E_NOK;
    }

    *pEvent = s_buttons[btn].pendingEvent;

    /* Event consumed */
    s_buttons[btn].pendingEvent = BTN_EVENT_NONE;

    return E_OK;
}

/* ============================================================
 * BTN_IsPressed
 * ============================================================ */

STD_ReturnType BTN_IsPressed(uint8 port,
                             ButtonID_t btn,
                             uint8 *pIsPressed)
{
    if ((btn >= BTN_COUNT) ||
        (pIsPressed == NULL))
    {
        return E_NOK;
    }

    *pIsPressed = s_buttons[btn].debouncedState;

    return E_OK;
}