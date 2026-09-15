/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * AVR_NTI application entry.
 * Layers: LIB (types) -> MCAL (drivers) -> HAL (devices) -> Logic (app) ->
 * main.
 */

#include "STD_TYPES.h"
#include "SPI_interface.h"
#include "Shiftreg_interface.h"
#include "TIMER_interface.h"
#include "Scheduler_interface.h"

static uint8 g_u8Count = 0u;

static void Task_Count(void)
{
    g_u8Count++;
}

int main(void)
{
    uint16 Local_u16TickIndex;
    uint8 Local_u8PollIndex;

    SPI_InitMaster(SPI_PRESC_16);
    SHIFTREG_Init();
    TIMER0_Init();

    SCHEDULER_Init();
    SCHEDULER_AddTask(Task_Count, 200u); /* 200 ms period */

    /* Run for exactly 4000 ms = 400 ticks of 10 ms each. */
    for (Local_u16TickIndex = 0u; Local_u16TickIndex < 400u; Local_u16TickIndex++)
    {
        TIMER0_DelayMS(SCHEDULER_TICK_MS);
        SCHEDULER_Tick();

        /* Simulate a busy main loop polling 4x between ticks. */
        for (Local_u8PollIndex = 0u; Local_u8PollIndex < 4u; Local_u8PollIndex++)
        {
            SCHEDULER_Run();
        }
    }

    /* Freeze the result on the LEDs: must read exactly 20 = 0x14. */
    SHIFTREG_SendByte(g_u8Count);

    while (1)
    {
        /* hold forever so the result stays visible */
    }

    return 0;
}