# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"


# 1 "C:/avr-gcc/avr/include/avr/io.h" 1 3
# 99 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 1 3
# 126 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 3
# 1 "C:/avr-gcc/avr/include/inttypes.h" 1 3
# 37 "C:/avr-gcc/avr/include/inttypes.h" 3
# 1 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 1 3 4
# 9 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/avr-gcc/avr/include/stdint.h" 1 3 4
# 125 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 12 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 38 "C:/avr-gcc/avr/include/inttypes.h" 2 3
# 77 "C:/avr-gcc/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 127 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 2 3
# 100 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 230 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/iom32.h" 1 3
# 720 "C:/avr-gcc/avr/include/avr/iom32.h" 3
       
# 721 "C:/avr-gcc/avr/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 231 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 785 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/portpins.h" 1 3
# 786 "C:/avr-gcc/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr/include/avr/common.h" 1 3
# 788 "C:/avr-gcc/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr/include/avr/version.h" 1 3
# 790 "C:/avr-gcc/avr/include/avr/io.h" 2 3






# 1 "C:/avr-gcc/avr/include/avr/fuse.h" 1 3
# 248 "C:/avr-gcc/avr/include/avr/fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 797 "C:/avr-gcc/avr/include/avr/io.h" 2 3


# 1 "C:/avr-gcc/avr/include/avr/lock.h" 1 3
# 800 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 4 "main.c" 2
# 1 "LIB/STD_TYPES.h" 1
# 12 "LIB/STD_TYPES.h"

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
# 5 "main.c" 2


# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 8 "main.c" 2
# 1 "MCAL/ADC/ADC_interface.h" 1
# 46 "MCAL/ADC/ADC_interface.h"
STD_ReturnType ADC_Init(uint8 Copy_u8Ref, uint8 Copy_u8Prescaler);





STD_ReturnType ADC_ReadChannel(uint8 Copy_u8Channel, uint16 *Copy_pu16Reading);




STD_ReturnType ADC_StartConversion(uint8 Copy_u8Channel);





STD_ReturnType ADC_GetResult(uint16 *Copy_pu16Reading);





STD_ReturnType ADC_SetInterrupt(uint8 Copy_u8State);
# 9 "main.c" 2
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
# 10 "main.c" 2
# 1 "MCAL/INTERRUPT/INTERRUPT_interface.h" 1
# 30 "MCAL/INTERRUPT/INTERRUPT_interface.h"
STD_ReturnType INTERRUPT_EnableGlobal(void);




STD_ReturnType INTERRUPT_DisableGlobal(void);





STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense);





STD_ReturnType EXTI_Enable(uint8 Copy_u8Int);




STD_ReturnType EXTI_Disable(uint8 Copy_u8Int);




STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int);

typedef void (*EXTI_CallbackType)(void);

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, EXTI_CallbackType Copy_pfCallback);
# 11 "main.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 12 "main.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 13 "main.c" 2
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
# 14 "main.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 15 "MCAL/UART/UART_interface.h"
# 1 "LIB/Ringbuffer/Ringbuffer.h" 1
# 19 "LIB/Ringbuffer/Ringbuffer.h"
typedef struct
{
    uint8 buffer[64U];
    volatile uint8 head;
    volatile uint8 tail;
    volatile uint8 count;
} RingBuffer_t;





void RB_Init(RingBuffer_t *pRb);
# 40 "LIB/Ringbuffer/Ringbuffer.h"
STD_ReturnType RB_Put(RingBuffer_t *pRb, uint8 data);
# 49 "LIB/Ringbuffer/Ringbuffer.h"
STD_ReturnType RB_Get(RingBuffer_t *pRb, uint8 *pData);


uint8 RB_IsEmpty(const RingBuffer_t *pRb);


uint8 RB_IsFull(const RingBuffer_t *pRb);
# 16 "MCAL/UART/UART_interface.h" 2





STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);





STD_ReturnType UART_SetRxBuffer(RingBuffer_t *Copy_pRxBuffer);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 15 "main.c" 2

# 1 "HAL/lcd_i2c/LCD_I2C_interface.h" 1
# 30 "HAL/lcd_i2c/LCD_I2C_interface.h"
STD_ReturnType LCD_I2C_Init(void);

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command);

STD_ReturnType LCD_I2C_SendData(uint8 Copy_u8Data);

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char);

STD_ReturnType LCD_I2C_SendString(const char *Copy_pcString);

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Column);

STD_ReturnType LCD_I2C_Clear(void);

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Number);
# 17 "main.c" 2
# 1 "Logic/Flowmeter/Flowmeter_interface.h" 1
# 11 "Logic/Flowmeter/Flowmeter_interface.h"
STD_ReturnType FLOWMETER_Init(void);







STD_ReturnType FLOWMETER_Update1Hz(void);


uint16 FLOWMETER_GetPulsesPerSec(void);


uint16 FLOWMETER_GetFlowLpmX10(void);




uint32 FLOWMETER_GetTotalMilliliters(void);





STD_ReturnType FLOWMETER_ResetTotaliser(void);
# 18 "main.c" 2
# 1 "HAL/Shiftreg/Shiftreg_interface.h" 1






STD_ReturnType SHIFTREG_Init(void);


STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data);
# 19 "main.c" 2

# 1 "Logic/interlocks/tank_types.h" 1







typedef enum
{
    ST_INIT = 0,
    ST_IDLE,
    ST_FILLING,
    ST_SETTLING,
    ST_RESERVOIR_WAIT,
    ST_TRIPPED,
    ST_MANUAL,
    ST_SERVICE

} TankState_t;



typedef enum
{
    TRIP_NONE = 0,

    TRIP_OVERFLOW,
    TRIP_OVERCURRENT,
    TRIP_DRY_RESERVOIR,
    TRIP_DRY_RUN,
    TRIP_NO_CURRENT,
    TRIP_MAX_RUNTIME,
    TRIP_LEVEL_SENSOR,
    TRIP_LEAK,
    TRIP_NO_RISE

} Trip_t;



typedef struct
{
    uint16 levelRaw;
    uint16 reservoirRaw;
    uint16 currentRaw;

    uint8 levelPct;
    uint8 reservoirPct;

    uint16 currentmA;
    uint16 flowLpmX10;

    uint32 totalLitres;

    sint8 levelRatePctMin;

    uint8 pumpOn : 1;
    uint8 valveOn : 1;
    uint8 highFloat : 1;
    uint8 lowFloat : 1;
    uint8 reserved : 4;

    uint8 state;
    uint8 activeTrip;

    uint16 pumpRunSec;
    uint32 pumpTotalSec;
    uint16 pumpCycles;

    uint32 upTimeSec;

} TankData_t;






typedef struct
{
    uint16 magic;
    uint8 version;

    uint8 startPct;
    uint8 stopPct;
    uint8 reserveMinPct;
    uint8 overflowPct;

    uint8 overCurrentA_X10;
    uint8 minCurrentA_X10;
    uint8 minFlowLpm;

    uint16 maxRunSec;
    uint16 minOffSec;

    uint8 leakDropPct;

    uint32 totalLitres;
    uint32 pumpTotalSec;
    uint16 pumpCycles;

    uint8 faultHead;
    uint8 checksum;

} TankCfg_t;
# 21 "main.c" 2
# 1 "HAL/Level/level_interface.h" 1






typedef enum
{
    LEVEL_BAND_CRITICAL_LOW = 0,
    LEVEL_BAND_LOW,
    LEVEL_BAND_NORMAL,
    LEVEL_BAND_HIGH,
    LEVEL_BAND_OVERFLOW
} LevelBand_t;

STD_ReturnType LEVEL_Init(uint8 adcChannel);

STD_ReturnType LEVEL_ReadPercentage(uint8 adcChannel, uint8 *pPercentage);

STD_ReturnType LEVEL_GetBand(uint8 levelPercent, LevelBand_t *pBand);
# 22 "main.c" 2
# 1 "HAL/current/current.h" 1
# 12 "HAL/current/current.h"
STD_ReturnType CUR_Init(void);
STD_ReturnType CUR_Update(void);
STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA);
uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA);
# 23 "main.c" 2
# 1 "HAL/floats/floats.h" 1
# 11 "HAL/floats/floats.h"
STD_ReturnType FLT_Init(void);
STD_ReturnType FLT_Update(void);

uint8 FLT_IsHighActive(void);
uint8 FLT_IsLowActive(void);
# 24 "main.c" 2
# 1 "HAL/Buttons/buttons_interface.h" 1
# 12 "HAL/Buttons/buttons_interface.h"
typedef enum
{
    BTN_MODE = 0,
    BTN_MANUAL_START,
    BTN_ACK,
    BTN_COUNT
} ButtonID_t;

typedef enum
{
    BTN_EVENT_NONE = 0,
    BTN_EVENT_PRESSED,
    BTN_EVENT_RELEASED,
    BTN_EVENT_SHORT_PRESS,
    BTN_EVENT_LONG_HOLD_1S
} ButtonEvent_t;


STD_ReturnType BTN_Init(uint8 port);


void BTN_Update10ms(uint8 port);


STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent);


STD_ReturnType BTN_IsPressed(uint8 port,
                             ButtonID_t btn,
                             uint8 *pIsPressed);
# 25 "main.c" 2
# 1 "HAL/Pump/Pump_interface.h" 1





STD_ReturnType PMP_Init(void);
STD_ReturnType PMP_Set(uint8 Copy_u8State);
STD_ReturnType PMP_GetState(uint8 *Copy_pu8State);
STD_ReturnType PMP_RunSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_TotalSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_Cycles(uint32 *Copy_pu32Cycles);
STD_ReturnType PMP_Update1s(void);
# 26 "main.c" 2
# 1 "HAL/Valve/Valve_interface.h" 1





STD_ReturnType Valve_Init(void);
STD_ReturnType Valve_Set(uint8 Copy_u8State);
STD_ReturnType Valve_GetState(uint8 *Copy_pu8State);
# 27 "main.c" 2
# 1 "Logic/demand/demand.h" 1






STD_ReturnType DEM_Init(void);
STD_ReturnType DEM_Update(const TankData_t *Copy_pstData);
uint8 DEM_GetPumpDemand(void);
# 28 "main.c" 2
# 1 "Logic/interlocks/interlocks.h" 1




# 1 "Logic/interlocks/tank_types.h" 1
# 6 "Logic/interlocks/interlocks.h" 2

STD_ReturnType INT_Init(void);
# 17 "Logic/interlocks/interlocks.h"
Trip_t ILK_Evaluate(const TankData_t *Copy_pstData);







STD_ReturnType ILK_Reset(void);
# 29 "main.c" 2
# 1 "Logic/tank_fsm/tank_fsm.h" 1
# 13 "Logic/tank_fsm/tank_fsm.h"
STD_ReturnType FSM_Init(void);


STD_ReturnType FSM_Run(const TankData_t *Copy_pstData);


TankState_t FSM_GetState(void);


STD_ReturnType FSM_Ack(void);
# 30 "main.c" 2
# 1 "Logic/FaultLog/faultlog.h" 1
# 10 "Logic/FaultLog/faultlog.h"
# 1 "LIB/DATA.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/DATA.h" 2


typedef struct
{
    uint8 trip;
    uint32 timeSec;
    uint8 levelPct;
    uint8 reservoirPct;
    uint16 currentmA;
} FaultRec_t;
# 11 "Logic/FaultLog/faultlog.h" 2



typedef struct
{
    FaultRec_t entries[16U];
    uint8 head;
    uint8 tail;
    uint8 count;
} FLG_Buffer_t;


void FLG_Init(FLG_Buffer_t *pLog);


STD_ReturnType FLG_Append(FLG_Buffer_t *pLog, const FaultRec_t *pRecord);


uint8 FLG_GetCount(const FLG_Buffer_t *pLog);


uint8 FLG_IsFull(const FLG_Buffer_t *pLog);


STD_ReturnType FLG_GetNewestFirst(const FLG_Buffer_t *pLog,
                                 uint8 offsetFromNewest,
                                 FaultRec_t *pRecord);


void FLG_Clear(FLG_Buffer_t *pLog);







void FLG_Dump(const FLG_Buffer_t *pLog, void (*WriteChar)(char));
# 31 "main.c" 2
# 1 "Logic/Console/console.h" 1
# 16 "Logic/Console/console.h"
typedef enum
{
    CON_RES_OK = 0,
    CON_RES_ERR_CMD,
    CON_RES_ERR_RANGE,
    CON_RES_ERR_MODE,
    CON_RES_ERR_INTERLOCK,
    CON_RES_ERR_ACTIVE,
    CON_RES_ERR_LONG,
    CON_RES_OK_NOOP
} CON_Result_t;


STD_ReturnType CON_Init(void);


void CON_Run(void);


STD_ReturnType CON_ProcessCommand(const uint8 *pCommandLine);


void CON_SendStatus(void);


void CON_SendHelp(void);


STD_ReturnType CON_SendFaults(void);
# 32 "main.c" 2




static TankData_t Global_stTankData;

static FLG_Buffer_t Global_stFaultLog;
# 48 "main.c"
static void APP_HighFloatISR(void)
{
    PMP_Set(0u);
    Valve_Set(0u);
}





static void APP_UpdateData(void)
{
    uint16 Local_u16Raw;
    uint8 Local_u8Value;
    uint8 Local_u8Pump;
    uint8 Local_u8Valve;
    uint32 Local_u32Value;
    uint32 Local_u32VolumeMl;





    if (ADC_ReadChannel(
            0u,
            &Local_u16Raw) == E_OK)
    {
        Global_stTankData.levelRaw = Local_u16Raw;
    }





    if (ADC_ReadChannel(
            1u,
            &Local_u16Raw) == E_OK)
    {
        Global_stTankData.reservoirRaw = Local_u16Raw;
    }





    if (LEVEL_ReadPercentage(
            0u,
            &Local_u8Value) == E_OK)
    {
        Global_stTankData.levelPct = Local_u8Value;
    }





    if (LEVEL_ReadPercentage(
            1u,
            &Local_u8Value) == E_OK)
    {
        Global_stTankData.reservoirPct = Local_u8Value;
    }





    if (CUR_GetmA(
            &Global_stTankData.currentmA) != E_OK)
    {
        Global_stTankData.currentmA = 0u;
    }





    Global_stTankData.flowLpmX10 =
        FLOWMETER_GetFlowLpmX10();





    Local_u32VolumeMl =
        FLOWMETER_GetTotalMilliliters();

    Global_stTankData.totalLitres =
        Local_u32VolumeMl / 1000UL;





    Global_stTankData.highFloat =
        FLT_IsHighActive();

    Global_stTankData.lowFloat =
        FLT_IsLowActive();




    if (PMP_GetState(&Local_u8Pump) == E_OK)
    {
        Global_stTankData.pumpOn =
            Local_u8Pump;
    }
    else
    {
        Global_stTankData.pumpOn = 0u;
    }




    if (Valve_GetState(&Local_u8Valve) == E_OK)
    {
        Global_stTankData.valveOn =
            Local_u8Valve;
    }
    else
    {
        Global_stTankData.valveOn = 0u;
    }





    if (PMP_RunSeconds(&Local_u32Value) == E_OK)
    {
        Global_stTankData.pumpRunSec =
            (uint16)Local_u32Value;
    }
    else
    {
        Global_stTankData.pumpRunSec = 0u;
    }





    if (PMP_TotalSeconds(
            &Global_stTankData.pumpTotalSec) != E_OK)
    {
        Global_stTankData.pumpTotalSec = 0UL;
    }





    if (PMP_Cycles(&Local_u32Value) == E_OK)
    {
        Global_stTankData.pumpCycles =
            (uint16)Local_u32Value;
    }
    else
    {
        Global_stTankData.pumpCycles = 0u;
    }





    Global_stTankData.state =
        (uint8)FSM_GetState();
}
# 235 "main.c"
static void APP_Task10ms(void)
{

    BTN_Update10ms(3u);


    FLT_Update();


    CUR_Update();


    APP_UpdateData();


    DEM_Update(&Global_stTankData);
# 261 "main.c"
    FSM_Run(&Global_stTankData);


    Global_stTankData.state =
        (uint8)FSM_GetState();
}







static void APP_Task500ms(void)
{
    uint16 Local_u16FlowInteger;
    uint8 Local_u8FlowDecimal;

    Local_u16FlowInteger =
        Global_stTankData.flowLpmX10 / 10u;

    Local_u8FlowDecimal =
        Global_stTankData.flowLpmX10 % 10u;


    LCD_I2C_Clear();





    LCD_I2C_SetCursor(
        0u,
        0u);

    LCD_I2C_SendString("L:");

    LCD_I2C_SendNumber(
        Global_stTankData.levelPct);

    LCD_I2C_SendString("% R:");

    LCD_I2C_SendNumber(
        Global_stTankData.reservoirPct);

    LCD_I2C_SendString("%");





    LCD_I2C_SetCursor(
        1u,
        0u);

    LCD_I2C_SendString("F:");

    LCD_I2C_SendNumber(
        Local_u16FlowInteger);

    LCD_I2C_SendString(".");

    LCD_I2C_SendNumber(
        Local_u8FlowDecimal);

    LCD_I2C_SendString("L/m ");



    if (Global_stTankData.pumpOn)
    {
        LCD_I2C_SendString("RUN");
    }
    else
    {
        LCD_I2C_SendString("OFF");
    }
}





static void APP_Task1s(void)
{

    PMP_Update1s();


    FLOWMETER_Update1Hz();


    Global_stTankData.upTimeSec++;


    APP_UpdateData();
}
# 374 "main.c"
static void APP_UpdateShiftRegister(void)
{
    uint8 Local_u8Status = 0u;

    TankState_t Local_enState;

    Local_enState =
        FSM_GetState();


    if (Global_stTankData.pumpOn)
    {
        Local_u8Status |= (1u << 0);
    }


    if (Global_stTankData.valveOn)
    {
        Local_u8Status |= (1u << 1);
    }


    if (Global_stTankData.highFloat)
    {
        Local_u8Status |= (1u << 2);
    }


    if (Global_stTankData.lowFloat)
    {
        Local_u8Status |= (1u << 3);
    }


    if (Local_enState == ST_TRIPPED)
    {
        Local_u8Status |= (1u << 4);
    }


    if (Local_enState == ST_MANUAL)
    {
        Local_u8Status |= (1u << 5);
    }


    if (Local_enState == ST_SERVICE)
    {
        Local_u8Status |= (1u << 6);
    }


    SHIFTREG_SendByte(Local_u8Status);
}





int main(void)
{




    Global_stTankData.levelRaw = 0u;
    Global_stTankData.reservoirRaw = 0u;
    Global_stTankData.currentRaw = 0u;

    Global_stTankData.levelPct = 0u;
    Global_stTankData.reservoirPct = 0u;

    Global_stTankData.currentmA = 0u;
    Global_stTankData.flowLpmX10 = 0u;

    Global_stTankData.totalLitres = 0UL;
    Global_stTankData.levelRatePctMin = 0;

    Global_stTankData.pumpOn = 0u;
    Global_stTankData.valveOn = 0u;

    Global_stTankData.highFloat = 0u;
    Global_stTankData.lowFloat = 0u;

    Global_stTankData.state =
        (uint8)ST_INIT;

    Global_stTankData.activeTrip =
        (uint8)TRIP_NONE;

    Global_stTankData.pumpRunSec = 0u;
    Global_stTankData.pumpTotalSec = 0UL;
    Global_stTankData.pumpCycles = 0u;

    Global_stTankData.upTimeSec = 0UL;





    TIMER0_Init();


    LEVEL_Init(0u);







    SPI_InitMaster(1u);


    SHIFTREG_Init();





    PMP_Init();
    Valve_Init();
    FLT_Init();
    CUR_Init();
    BTN_Init(3u);





    FLOWMETER_Init();

    I2C_InitMaster(100000UL);


    LCD_I2C_Init();




    DEM_Init();

    INT_Init();

    FSM_Init();


    FLG_Init(&Global_stFaultLog);


    CON_Init();





    EXTI_SetCallback(
        0u,
        APP_HighFloatISR);

    EXTI_SetSense(
        0u,
        2u);

    EXTI_ClearFlag(
        0u);

    EXTI_Enable(
        0u);


    INTERRUPT_EnableGlobal();





    SCHEDULER_Init();




    SCHEDULER_AddTask(
        APP_Task10ms,
        10u);




    SCHEDULER_AddTask(
        APP_Task500ms,
        500u);





    SCHEDULER_AddTask(
        APP_Task1s,
        1000u);




    APP_UpdateData();

    Global_stTankData.state =
        (uint8)FSM_GetState();





    while (1)
    {






        TIMER0_DelayMS(10u);

        SCHEDULER_Tick();

        SCHEDULER_Run();

        CON_Run();


        APP_UpdateShiftRegister();
    }
    return 0;
}
