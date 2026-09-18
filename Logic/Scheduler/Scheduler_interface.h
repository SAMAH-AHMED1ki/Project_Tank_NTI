#ifndef SCHEDULER_H_
#define SCHEDULER_H_

#include "STD_TYPES.h"

/* Maximum number of tasks */
#define SCHEDULER_MAX_TASKS 8u

/* System tick period in milliseconds */
#define SCHEDULER_TICK_MS 10u

typedef void (*SchedulerTaskFunction_t)(void);

/* Task configuration */
typedef struct
{
    SchedulerTaskFunction_t TaskFunction;

    uint32 PeriodMs;
    uint32 RemainingTimeMs;
    uint8 Active;
    uint8 Ready; /* SCHEDULER_Tick يرفعه، SCHEDULER_Run ينزّله فور التنفيذ */

} SchedulerTask_t;

/*
 * Initialize the scheduler.
 */
STD_ReturnType SCHEDULER_Init(void);

/*
 * Add a new periodic task.
 *
 * TaskFunction : Function to be called periodically
 * PeriodMs     : Task period in milliseconds
 */
STD_ReturnType SCHEDULER_AddTask(
    SchedulerTaskFunction_t TaskFunction,
    uint32 PeriodMs);

/*
 * Called every 10 ms from the Timer0 ISR.
 */
void SCHEDULER_Tick(void);

/*
 * Execute tasks that are ready to run.
 *
 * This function should be called continuously inside main().
 */
void SCHEDULER_Run(void);

#endif /* SCHEDULER_H_ */