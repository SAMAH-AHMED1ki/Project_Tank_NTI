/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — TIMER.c  (ATmega32 Timer0 + Timer1, F_CPU = 8 MHz)
 * Implement every prototype from TIMER_interface.h.
 *
 * Rules for this file:
 *   - The application only ever sees what TIMER_interface.h declares.
 *   - Anything only this file needs is static, so no other .c can reach it.
 *   - Register names and bit numbers come from TIMER_private.h. Fill that in
 *     first, or nothing here will compile.
 *
 * Numbers you will need, all at 8 MHz:
 *   prescaler 64 -> 1 tick = 8 us      prescaler 8 -> 1 tick = 1 us
 *   A flag in TIFR is cleared by writing 1 to it, not 0.
 */

#include "STD_TYPES.h"
#include "MATH.h"
#include "TIMER_interface.h"
#include "TIMER_private.h"
#include <avr/io.h>

/*==================================================================
 *  Local helpers — static, used only inside TIMER.c
 *==================================================================*/

/*
 * TIMER_WaitFlag
 * 1. Sit in an empty while loop until the bit Copy_u8BitMask is set in the
 *    register Copy_pu8Register (that register is TIFR).
 * 2. Clear the flag by writing 1 to that bit, so the next period starts clean.
 * 3. Both delay functions call this, which is the whole reason it exists —
 *    the wait-then-clear pattern is written once and cannot drift apart.
 */
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);

/*
 * TIMER_DutyToCompare
 * 1. Turn a 0..100 percent into a compare value: (Top + 1) * percent / 100.
 * 2. Do the multiply in uint32. Timer1 can reach 20000 * 100 = 2,000,000,
 *    which overflows uint16 long before the divide happens.
 * 3. Return the result; the caller writes it to OCR0 or OCR1A.
 */
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);

/*==================================================================
 *  Timer0 — 8-bit
 *==================================================================*/

STD_ReturnType TIMER0_Init(void)
{
    TIMER0_REG_TCCR0 = (1 << WGM01);
    TIMER0_REG_OCR0 = 124;
    TIMER0_REG_TCNT0 = 0;
    TIMER0_REG_TCCR0 &= ~((1 << CS02) | (1 << CS01) | (1 << CS00));
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
    uint16 Local_u16Counter;
    TIFR_REG = (1 << OCF0);
    TIMER0_REG_TCCR0 |= (1 << CS01) | (1 << CS00);
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Milliseconds; Local_u16Counter++)
    {
        TIMER_WaitFlag(&TIFR_REG, (1 << OCF0));
    }

    TIMER0_REG_TCCR0 &= ~((1 << CS02) | (1 << CS01) | (1 << CS00));
    return E_OK;
}

STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds)
{
    uint16 Local_u16Counter;
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Seconds; Local_u16Counter++)
    {
        TIMER0_DelayMS(1000);
    }
    return E_OK;
}

STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100)
    {
        return E_NOK;
    }

    DDRB |= (1 << PB3);
    TIMER0_REG_TCCR0 |= (1 << WGM01) | (1 << WGM00);
    TIMER0_REG_TCCR0 |= (1 << COM01);
    TIMER0_REG_TCCR0 &= ~(1 << COM00);
    TIMER0_REG_OCR0 = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    TIMER0_REG_TCCR0 |= (1 << CS01) | (1 << CS00);
    return E_OK;
}

STD_ReturnType TIMER0_Stop(void)
{
    TIMER0_REG_TCCR0 &= ~((1 << CS02) | (1 << CS01) | (1 << CS00));
    TIMER0_REG_TCCR0 &= ~((1 << COM01) | (1 << COM00));
    return E_OK;
}

/*==================================================================
 *  Timer1 — 16-bit
 *==================================================================*/

STD_ReturnType TIMER1_Init(void)
{
    TIMER1_REG_TCCR1A = 0;
    TIMER1_REG_TCCR1B = (1 << WGM12);
    TIMER1_REG_OCR1A = 999;
    TIMER1_REG_TCNT1 = 0;
    TIMER1_REG_TCCR1B &= ~((1 << CS12) | (1 << CS11) | (1 << CS10));
    return E_OK;
}

STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds)
{
    uint16 Local_u16Counter;
    TIFR_REG = (1 << OCF1A);
    TIMER1_REG_TCCR1B |= (1 << CS11);
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Milliseconds; Local_u16Counter++)
    {
        TIMER_WaitFlag(&TIFR_REG, (1 << OCF1A));
    }
    TIMER1_REG_TCCR1B &= ~((1 << CS12) | (1 << CS11) | (1 << CS10));
    return E_OK;
}

STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent)
{
    uint32 Local_u32Top;
    if (Copy_u8DutyPercent > 100)
    {
        return E_NOK;
    }
    if ((Copy_u16FrequencyHz < 16) || (Copy_u16FrequencyHz > 20000))
    {
        return E_NOK;
    }
    DDRD |= (1 << PD5);
    TIMER1_REG_TCCR1A &= ~((1 << WGM11) | (1 << WGM10));
    TIMER1_REG_TCCR1A |= (1 << WGM11);
    TIMER1_REG_TCCR1B |= (1 << WGM13) | (1 << WGM12);
    TIMER1_REG_TCCR1A |= (1 << COM1A1);
    TIMER1_REG_TCCR1A &= ~(1 << COM1A0);
    Local_u32Top = (1000000UL / Copy_u16FrequencyHz) - 1;
    TIMER1_REG_ICR1 = (uint16)Local_u32Top;
    TIMER1_REG_OCR1A = TIMER_DutyToCompare(TIMER1_REG_ICR1, Copy_u8DutyPercent);
    TIMER1_REG_TCCR1B |= (1 << CS11);

    return E_OK;
}

STD_ReturnType TIMER1_Stop(void)
{
    TIMER1_REG_TCCR1B &= ~((1 << CS12) | (1 << CS11) | (1 << CS10));

    TIMER1_REG_TCCR1A &= ~((1 << COM1A1) | (1 << COM1A0));

    return E_OK;
}

/*==================================================================
 * Timer1 - External Counter for Flowmeter
 *==================================================================*/

STD_ReturnType TIMER1_ExternalCounterInit(void)
{
    /*
     * Stop Timer1 first.
     * CS12:0 = 000
     */
    TIMER1_REG_TCCR1B &=
        ~((1 << CS12) | (1 << CS11) | (1 << CS10));

    /*
     * Select Normal Mode.
     * WGM13:0 = 0000
     */
    TIMER1_REG_TCCR1A &=
        ~((1 << WGM11) | (1 << WGM10));

    TIMER1_REG_TCCR1B &=
        ~((1 << WGM13) | (1 << WGM12));

    /*
     * Clear Timer1 counter.
     */
    TIMER1_REG_TCNT1 = 0u;

    /*
     * Count external rising edges on T1/PB1.
     * CS12:0 = 111
     */
    TIMER1_REG_TCCR1B |= (1 << CS12) | (1 << CS11) | (1 << CS10);

    return E_OK;
}

uint16 TIMER1_GetCounter(void)
{
    uint16 Local_u16CounterValue;

    Local_u16CounterValue = TIMER1_REG_TCNT1;

    return Local_u16CounterValue;
}

STD_ReturnType TIMER1_ResetCounter(void)
{
    TIMER1_REG_TCNT1 = 0u;

    return E_OK;
}
/*==================================================================
 *  Local helper bodies
 *==================================================================*/

static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask)
{
    /*
     * 1. while ((*Copy_pu8Register & Copy_u8BitMask) == 0) { }  — spin until set.
     * 2. Then write 1 to that bit to clear it: *Copy_pu8Register = Copy_u8BitMask.
     *    Plain assignment, not |=. On TIFR a 1 clears and a 0 leaves alone, so
     *    assigning the single mask clears your flag and touches no other.
     */
    while ((*Copy_pu8Register & Copy_u8BitMask) == 0)
    {
    }

    *Copy_pu8Register = Copy_u8BitMask;
}

static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent)
{
    /*
     * 1. Promote first: ((uint32)Copy_u16Top + 1) * Copy_u8DutyPercent / 100.
     * 2. Cast the result back to uint16 and return it.
     * 3. Sanity check with Timer0: Top = 255, 50 percent -> 128.
     */
    return (uint16)((((uint32)Copy_u16Top + 1UL) * Copy_u8DutyPercent) / 100UL);
}