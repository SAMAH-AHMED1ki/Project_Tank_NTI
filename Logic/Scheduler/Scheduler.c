#include "Scheduler_interface.h"

static SchedulerTask_t
    Scheduler_Tasks[SCHEDULER_MAX_TASKS];

static uint8
    Scheduler_Initialized = 0u;

/*
 * Initialize all scheduler tasks.
 */
STD_ReturnType SCHEDULER_Init(void)
{
    uint8 Local_u8Index;

    for (Local_u8Index = 0u;
         Local_u8Index < SCHEDULER_MAX_TASKS;
         Local_u8Index++)
    {
        Scheduler_Tasks[Local_u8Index].TaskFunction = NULL;
        Scheduler_Tasks[Local_u8Index].PeriodMs = 0u;
        Scheduler_Tasks[Local_u8Index].RemainingTimeMs = 0u;
        Scheduler_Tasks[Local_u8Index].Active = 0u;
    }

    Scheduler_Initialized = 1u;

    return E_OK;
}

/*
 * Add a periodic task to the scheduler.
 */
STD_ReturnType SCHEDULER_AddTask(
    SchedulerTaskFunction_t TaskFunction,
    uint32 PeriodMs)
{
    uint8 Local_u8Index;

    if (Scheduler_Initialized == 0u)
    {
        return E_NOK;
    }

    if ((TaskFunction == NULL) || (PeriodMs < SCHEDULER_TICK_MS))
    {
        return E_NOK;
    }

    if ((PeriodMs % SCHEDULER_TICK_MS) != 0u)
    {
        return E_NOK;
    }

    for (Local_u8Index = 0u;
         Local_u8Index < SCHEDULER_MAX_TASKS;
         Local_u8Index++)
    {
        if (Scheduler_Tasks[Local_u8Index].Active == 0u)
        {
            Scheduler_Tasks[Local_u8Index].TaskFunction = TaskFunction;

            Scheduler_Tasks[Local_u8Index].PeriodMs = PeriodMs;

            Scheduler_Tasks[Local_u8Index].RemainingTimeMs =
                PeriodMs;

            Scheduler_Tasks[Local_u8Index].Active = 1u;

            return E_OK;
        }
    }

    return E_NOK;
}

/*
 * Scheduler time base.
 *
 * This function must be called every 10 ms.
 */
void SCHEDULER_Tick(void)
{
    uint8 Local_u8Index;

    if (Scheduler_Initialized == 0u)
    {
        return;
    }

    for (Local_u8Index = 0u;
         Local_u8Index < SCHEDULER_MAX_TASKS;
         Local_u8Index++)
    {
        if (Scheduler_Tasks[Local_u8Index].Active == 1u)
        {
            if (Scheduler_Tasks[Local_u8Index].RemainingTimeMs >= SCHEDULER_TICK_MS)
            {
                Scheduler_Tasks[Local_u8Index].RemainingTimeMs -=
                    SCHEDULER_TICK_MS;
            }

            if (Scheduler_Tasks[Local_u8Index].RemainingTimeMs == 0u)
            {
                Scheduler_Tasks[Local_u8Index].RemainingTimeMs =
                    Scheduler_Tasks[Local_u8Index].PeriodMs;
            }
        }
    }
}

/*
 * Execute ready tasks.
 */
void SCHEDULER_Run(void)
{
    uint8 Local_u8Index;

    if (Scheduler_Initialized == 0u)
    {
        return;
    }

    for (Local_u8Index = 0u;
         Local_u8Index < SCHEDULER_MAX_TASKS;
         Local_u8Index++)
    {
        if (Scheduler_Tasks[Local_u8Index].Active == 1u)
        {
            if (Scheduler_Tasks[Local_u8Index].RemainingTimeMs == Scheduler_Tasks[Local_u8Index].PeriodMs)
            {
                /*
                 * The task period has elapsed.
                 *
                 * Execute the task once.
                 */
                Scheduler_Tasks[Local_u8Index].TaskFunction();

                /*
                 * Prevent the task from executing repeatedly
                 * until the next tick cycle.
                 */
                Scheduler_Tasks[Local_u8Index].RemainingTimeMs =
                    Scheduler_Tasks[Local_u8Index].PeriodMs;
            }
        }
    }
}