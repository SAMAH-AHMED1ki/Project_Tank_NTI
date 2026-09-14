#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "TIMER_interface.h"
#include "Flowmeter_interface.h"

/*
 * Initialize the Flowmeter.
 *
 * Flowmeter signal is connected to:
 * PB1 / T1
 */
STD_ReturnType FLOWMETER_Init(void)
{
    STD_ReturnType Local_u8ErrorState = E_OK;

    /*
     * Set PB1/T1 as input.
     */
    Local_u8ErrorState =
        GPIO_SetPinDirection(GPIO_PORTB, GPIO_PIN1, GPIO_INPUT);

    /*
     * Initialize Timer1 as an external counter.
     */
    if (Local_u8ErrorState == E_OK)
    {
        Local_u8ErrorState = TIMER1_ExternalCounterInit();
    }

    return Local_u8ErrorState;
}

/*
 * Start a new flow measurement.
 *
 * The counter is reset to zero before starting.
 */
STD_ReturnType FLOWMETER_StartMeasurement(void)
{
    STD_ReturnType Local_u8ErrorState;

    Local_u8ErrorState = TIMER1_ResetCounter();

    return Local_u8ErrorState;
}

/*
 * Return the number of pulses counted by Timer1.
 */
uint16 FLOWMETER_GetPulses(void)
{
    uint16 Local_u16Pulses;

    Local_u16Pulses = TIMER1_GetCounter();

    return Local_u16Pulses;
}

/*
 * Convert pulses to milliliters.
 *
 * 450 pulses = 1 liter
 * 1 liter = 1000 milliliters
 *
 * milliliters = pulses * 1000 / 450
 */
uint16 FLOWMETER_GetMilliliters(void)
{
    uint16 Local_u16Pulses;
    uint32 Local_u32Milliliters;

    Local_u16Pulses = FLOWMETER_GetPulses();

    Local_u32Milliliters =
        ((uint32)Local_u16Pulses * 1000UL) / FLOWMETER_PULSES_PER_LITER;

    return (uint16)Local_u32Milliliters;
}

/*
 * Reset the flow measurement counter.
 */
STD_ReturnType FLOWMETER_ResetMeasurement(void)
{
    return TIMER1_ResetCounter();
}