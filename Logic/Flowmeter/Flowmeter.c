#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "TIMER_interface.h"
#include "Flowmeter_interface.h"

static uint16 g_lastCount = 0u;
static uint16 g_pulsesLastSecond = 0u;
static uint32 g_totalPulses = 0u;

STD_ReturnType FLOWMETER_Init(void)
{
    STD_ReturnType Local_u8ErrorState;

    Local_u8ErrorState =
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN1, GPIO_INPUT);

    if (Local_u8ErrorState == E_OK)
    {
        Local_u8ErrorState = TIMER1_ExternalCounterInit();
    }

    /* TIMER1_ExternalCounterInit() clears TCNT1, so the baseline for the
       first wrap-safe diff is 0 too. */
    g_lastCount = 0u;
    g_pulsesLastSecond = 0u;
    g_totalPulses = 0u;

    return Local_u8ErrorState;
}

STD_ReturnType FLOWMETER_Update1Hz(void)
{
    uint16 Local_u16Now;
    uint16 Local_u16Diff;

    Local_u16Now = TIMER1_GetCounter();

    /* Wrap-safe: unsigned subtraction handles the 16-bit TCNT1 rollover
       transparently. Never cast this to a signed type. */
    Local_u16Diff = (uint16)(Local_u16Now - g_lastCount);
    g_lastCount = Local_u16Now;

    g_pulsesLastSecond = Local_u16Diff;
    g_totalPulses += Local_u16Diff;

    return E_OK;
}

uint16 FLOWMETER_GetPulsesPerSec(void)
{
    return g_pulsesLastSecond;
}

uint16 FLOWMETER_GetFlowLpmX10(void)
{
    /* Lpm x10 = pulses_per_sec * 10 / 7.5 = pulses_per_sec * 4 / 3 */
    return (uint16)(((uint32)g_pulsesLastSecond * 4UL) / 3UL);
}

uint32 FLOWMETER_GetTotalMilliliters(void)
{
    return (uint32)((g_totalPulses * 1000UL) / FLOWMETER_PULSES_PER_LITER);
}

STD_ReturnType FLOWMETER_ResetTotaliser(void)
{
    g_totalPulses = 0u;
    return E_OK;
}