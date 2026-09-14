/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * AVR_NTI application entry.
 * Layers: LIB (types) -> MCAL (drivers) -> HAL (devices) -> Logic (app) ->
 * main.
 */
/*
#define F_CPU 8000000UL
#include "STD_TYPES.h"
#include "SPI_interface.h"
#include "Shiftreg_interface.h"
#include <util/delay.h>

int main(void)
{

    SPI_InitMaster(SPI_PRESC_16);


    SHIFTREG_Init();

    while (1)
    {

        SHIFTREG_SendByte(0xFF);
        _delay_ms(1000);


        SHIFTREG_SendByte(0x00);
        _delay_ms(1000);


        SHIFTREG_SendByte(0x01);
        _delay_ms(1000);

        SHIFTREG_SendByte(0x80);
        _delay_ms(1000);
    }

    return 0;
}
/*
 * main.c — Full integration test: SPI + 74HC595 shiftreg + Timer0 delay +
 * Timer1 external counter + Flowmeter, all together.
 *
 * Hardware (SimulIDE) — same wiring as every previous test:
 *   Clock/square-wave source -> ATmega32 PB1 (T1), set to 75 Hz
 *   ATmega32 PB4 (RCLK) -> 74HC595 pin 12
 *   ATmega32 PB5 (MOSI) -> 74HC595 pin 14
 *   ATmega32 PB7 (SCK)  -> 74HC595 pin 11
 *   74HC595 OE -> GND, MR -> VCC, Q0..Q7 -> 8 LEDs (Q0 = LSB, leftmost)
 *
 * Init order: SPI first (claims PB4 as SS, drives it HIGH), then shiftreg
 * (same physical pin, resting LOW as RCLK), then Timer0 (delay engine),
 * then Flowmeter last (owns Timer1 + PB1/T1 as a free-running counter).
 *
 * Sequence:
 *   Step 0 (2 s)  — wiring sanity check: all LEDs on, then all off.
 *   Step 1+       — FLOWMETER_Update1Hz() every single second, forever.
 *                   The LED bar cycles through three readings, 3 s each:
 *                     phase 0: pulses/sec        -> steady 75  = 0x4B
 *                     phase 1: flow rate Lpm x10 -> steady 100 = 0x64
 *                     phase 2: low byte of the running total (ml)
 *                              -> climbs by ~166/167 each second,
 *                                 changing every cycle — that's expected,
 *                                 it's the lifetime totaliser, not a
 *                                 constant.
 */

#include "STD_TYPES.h"
#include "SPI_interface.h"
#include "Shiftreg_interface.h"
#include "TIMER_interface.h"
#include "Flowmeter_interface.h"

#define PHASE_SECONDS 3u

int main(void)
{
    uint8 Local_u8SecInPhase = 0u;
    uint8 Local_u8Phase = 0u;
    uint16 Local_u16Value16;
    uint32 Local_u32Value32;

    SPI_InitMaster(SPI_PRESC_16);
    SHIFTREG_Init();
    TIMER0_Init();
    FLOWMETER_Init();

    /* --- Step 0: wiring sanity check --- */
    SHIFTREG_SendByte(0xFFu);
    TIMER0_DelayS(1);
    SHIFTREG_SendByte(0x00u);
    TIMER0_DelayS(1);

    /* --- Step 1+: flowmeter readout, cycling through 3 values --- */
    while (1)
    {
        TIMER0_DelayS(1);
        FLOWMETER_Update1Hz(); /* exactly once per second, no exceptions */

        switch (Local_u8Phase)
        {
        case 0:
            Local_u16Value16 = FLOWMETER_GetPulsesPerSec();
            SHIFTREG_SendByte((uint8)Local_u16Value16);
            break;

        case 1:
            Local_u16Value16 = FLOWMETER_GetFlowLpmX10();
            SHIFTREG_SendByte((uint8)Local_u16Value16);
            break;

        case 2:
        default:
            Local_u32Value32 = FLOWMETER_GetTotalMilliliters();
            SHIFTREG_SendByte((uint8)Local_u32Value32);
            break;
        }

        Local_u8SecInPhase++;
        if (Local_u8SecInPhase >= PHASE_SECONDS)
        {
            Local_u8SecInPhase = 0u;
            Local_u8Phase++;
            if (Local_u8Phase >= 3u)
            {
                Local_u8Phase = 0u;
            }
        }
    }

    return 0;
}