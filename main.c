/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * AVR_NTI application entry.
 * Layers: LIB (types) -> MCAL (drivers) -> HAL (devices) -> Logic (app) ->
 * main.
 */
/*
 * main.c — Timer1 external counter test
 *
 * Purpose: verify TIMER1_ExternalCounterInit / TIMER1_GetCounter /
 * TIMER1_ResetCounter, not the full flow-meter module.
 *
 * Hardware (SimulIDE):
 *   Clock/square-wave source -> ATmega32 PB1 (T1)   [pulse train in]
 *   ATmega32 PB4 (RCLK) -> 74HC595 pin 12
 *   ATmega32 PB5 (MOSI) -> 74HC595 pin 14
 *   ATmega32 PB7 (SCK)  -> 74HC595 pin 11
 *   74HC595 OE -> GND, MR -> VCC, Q0..Q7 -> 8 LEDs (same wiring as the
 *   earlier SPI/shiftreg test).
 *
 * What to check:
 *   Set the Clock component to a known frequency (e.g. 10 Hz), run the
 *   simulation, and confirm the LED bar shows ~10 in binary after each
 *   1-second window (00001010 -> LED0, LED1, LED3 on). Raise the clock to
 *   75 Hz (the spec's example for 10 L/min) and confirm the reading tracks
 *   it (01001011 = 75).
 *
 * IMPORTANT — this is a test-only measurement method, not the final
 * flow-meter design: it calls TIMER1_ResetCounter() every second, which is
 * fine for eyeballing a count but throws away pulses that land exactly on
 * the reset instant. The project spec requires the wrap-safe subtraction
 * method instead (read TCNT1, subtract from the previous reading, handle
 * the 16-bit wrap with unsigned subtraction) — do NOT reset TCNT1 in the
 * real flowmeter.c.
 */

#include "STD_TYPES.h"
#include "SPI_interface.h"
#include "Shiftreg_interface.h"
#include "TIMER_interface.h"

int main(void)
{
    uint16 Local_u16Pulses;

    /* Timer0 only provides the 1-second measurement window here.
       Timer1 is fully dedicated to external pulse counting on T1/PB1 —
       do not call TIMER1_Init/TIMER1_DelayMS/TIMER1_PWM in this test,
       they would reconfigure TCCR1A/B and break the counter mode. */
    TIMER0_Init();

    /* SPI + shift register are only the readout for this test. */
    SPI_InitMaster(SPI_PRESC_16);
    SHIFTREG_Init();

    TIMER1_ExternalCounterInit();

    while (1)
    {
        TIMER1_ResetCounter();                 /* start of the window   */
        TIMER0_DelayS(1);                      /* exactly 1 second      */
        Local_u16Pulses = TIMER1_GetCounter(); /* pulses in that second */

        /* Low byte of the count, shown as raw binary on the LED bar. */
        SHIFTREG_SendByte((uint8)Local_u16Pulses);
    }

    return 0;
}