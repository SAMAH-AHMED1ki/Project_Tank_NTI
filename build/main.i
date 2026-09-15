# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"
# 10 "main.c"
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
# 11 "main.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 12 "main.c" 2
# 1 "HAL/Shiftreg/Shiftreg_interface.h" 1






STD_ReturnType SHIFTREG_Init(void);


STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data);
# 13 "main.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 29 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 73 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);







STD_ReturnType TIMER1_ExternalCounterInit(void);




uint16 TIMER1_GetCounter(void);




STD_ReturnType TIMER1_ResetCounter(void);
# 14 "main.c" 2
# 1 "Logic/Scheduler/Scheduler_interface.h" 1
# 12 "Logic/Scheduler/Scheduler_interface.h"
typedef void (*SchedulerTaskFunction_t)(void);


typedef struct
{
    SchedulerTaskFunction_t TaskFunction;

    uint32 PeriodMs;
    uint32 RemainingTimeMs;
    uint8 Active;
    uint8 Ready;

} SchedulerTask_t;




STD_ReturnType SCHEDULER_Init(void);







STD_ReturnType SCHEDULER_AddTask(
    SchedulerTaskFunction_t TaskFunction,
    uint32 PeriodMs);




void SCHEDULER_Tick(void);






void SCHEDULER_Run(void);
# 15 "main.c" 2

static uint8 g_u8Count = 0u;

static void Task_Count(void)
{
    g_u8Count++;
}

int main(void)
{
    uint16 Local_u16TickIndex;
    uint8 Local_u8PollIndex;

    SPI_InitMaster(1u);
    SHIFTREG_Init();
    TIMER0_Init();

    SCHEDULER_Init();
    SCHEDULER_AddTask(Task_Count, 200u);


    for (Local_u16TickIndex = 0u; Local_u16TickIndex < 400u; Local_u16TickIndex++)
    {
        TIMER0_DelayMS(10u);
        SCHEDULER_Tick();


        for (Local_u8PollIndex = 0u; Local_u8PollIndex < 4u; Local_u8PollIndex++)
        {
            SCHEDULER_Run();
        }
    }


    SHIFTREG_SendByte(g_u8Count);

    while (1)
    {

    }

    return 0;
}
