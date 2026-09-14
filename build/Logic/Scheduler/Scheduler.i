# 0 "Logic/Scheduler/Scheduler.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/Scheduler/Scheduler.c"
# 1 "Logic/Scheduler/Scheduler_interface.h" 1



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
# 5 "Logic/Scheduler/Scheduler_interface.h" 2







typedef void (*SchedulerTaskFunction_t)(void);


typedef struct
{
    SchedulerTaskFunction_t TaskFunction;

    uint32 PeriodMs;

    uint32 RemainingTimeMs;

    uint8 Active;

} SchedulerTask_t;




STD_ReturnType SCHEDULER_Init(void);







STD_ReturnType SCHEDULER_AddTask(
    SchedulerTaskFunction_t TaskFunction,
    uint32 PeriodMs);




void SCHEDULER_Tick(void);






void SCHEDULER_Run(void);
# 2 "Logic/Scheduler/Scheduler.c" 2

static SchedulerTask_t
    Scheduler_Tasks[8u];

static uint8
    Scheduler_Initialized = 0u;




STD_ReturnType SCHEDULER_Init(void)
{
    uint8 Local_u8Index;

    for (Local_u8Index = 0u;
         Local_u8Index < 8u;
         Local_u8Index++)
    {
        Scheduler_Tasks[Local_u8Index].TaskFunction = ((void *)0);
        Scheduler_Tasks[Local_u8Index].PeriodMs = 0u;
        Scheduler_Tasks[Local_u8Index].RemainingTimeMs = 0u;
        Scheduler_Tasks[Local_u8Index].Active = 0u;
    }

    Scheduler_Initialized = 1u;

    return E_OK;
}




STD_ReturnType SCHEDULER_AddTask(
    SchedulerTaskFunction_t TaskFunction,
    uint32 PeriodMs)
{
    uint8 Local_u8Index;

    if (Scheduler_Initialized == 0u)
    {
        return E_NOK;
    }

    if ((TaskFunction == ((void *)0)) || (PeriodMs < 10u))
    {
        return E_NOK;
    }

    if ((PeriodMs % 10u) != 0u)
    {
        return E_NOK;
    }

    for (Local_u8Index = 0u;
         Local_u8Index < 8u;
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






void SCHEDULER_Tick(void)
{
    uint8 Local_u8Index;

    if (Scheduler_Initialized == 0u)
    {
        return;
    }

    for (Local_u8Index = 0u;
         Local_u8Index < 8u;
         Local_u8Index++)
    {
        if (Scheduler_Tasks[Local_u8Index].Active == 1u)
        {
            if (Scheduler_Tasks[Local_u8Index].RemainingTimeMs >= 10u)
            {
                Scheduler_Tasks[Local_u8Index].RemainingTimeMs -=
                    10u;
            }

            if (Scheduler_Tasks[Local_u8Index].RemainingTimeMs == 0u)
            {
                Scheduler_Tasks[Local_u8Index].RemainingTimeMs =
                    Scheduler_Tasks[Local_u8Index].PeriodMs;
            }
        }
    }
}




void SCHEDULER_Run(void)
{
    uint8 Local_u8Index;

    if (Scheduler_Initialized == 0u)
    {
        return;
    }

    for (Local_u8Index = 0u;
         Local_u8Index < 8u;
         Local_u8Index++)
    {
        if (Scheduler_Tasks[Local_u8Index].Active == 1u)
        {
            if (Scheduler_Tasks[Local_u8Index].RemainingTimeMs == Scheduler_Tasks[Local_u8Index].PeriodMs)
            {





                Scheduler_Tasks[Local_u8Index].TaskFunction();





                Scheduler_Tasks[Local_u8Index].RemainingTimeMs =
                    Scheduler_Tasks[Local_u8Index].PeriodMs;
            }
        }
    }
}
