#define F_CPU 8000000UL
#include <avr/io.h>
#include "STD_TYPES.h"

/* ========================= MCAL ========================= */
#include "GPIO_interface.h"
#include "ADC_interface.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "SPI_interface.h"
#include "I2C_interface.h"
#include "Scheduler_interface.h"
#include "UART_interface.h"
/* ========================== HAL ========================== */
#include "LCD_I2C_interface.h"
#include "Flowmeter_interface.h"
#include "Shiftreg_interface.h"
/* ========================== APP ========================== */
#include "tank_types.h"
#include "level_interface.h"
#include "current.h"
#include "floats.h"
#include "buttons_interface.h"
#include "Pump_interface.h"
#include "Valve_interface.h"
#include "demand.h"
#include "interlocks.h"
#include "tank_fsm.h"
#include "faultlog.h"
#include "console.h"
/* =========================================================
 * Global application data
 * ========================================================= */

static TankData_t Global_stTankData;

static FLG_Buffer_t Global_stFaultLog;
/* =========================================================
 * INT0 Callback
 *
 * High-float emergency hardware guard.
 * Immediately switches OFF:
 *      Pump
 *      Inlet valve
 * ========================================================= */

static void APP_HighFloatISR(void)
{
    PMP_Set(0u);
    Valve_Set(0u);
}

/* =========================================================
 * Read / Update Application Data
 * ========================================================= */

static void APP_UpdateData(void)
{
    uint16 Local_u16Raw;
    uint8 Local_u8Value;
    uint8 Local_u8Pump;
    uint8 Local_u8Valve;
    uint32 Local_u32Value;
    uint32 Local_u32VolumeMl;

    /* -----------------------------------------------------
     * Roof Tank Raw Level
     * ----------------------------------------------------- */

    if (ADC_ReadChannel(
            ADC_CHANNEL_0,
            &Local_u16Raw) == E_OK)
    {
        Global_stTankData.levelRaw = Local_u16Raw;
    }

    /* -----------------------------------------------------
     * Reservoir Raw Level
     * ----------------------------------------------------- */

    if (ADC_ReadChannel(
            ADC_CHANNEL_1,
            &Local_u16Raw) == E_OK)
    {
        Global_stTankData.reservoirRaw = Local_u16Raw;
    }

    /* -----------------------------------------------------
     * Roof Tank Level Percentage
     * ----------------------------------------------------- */

    if (LEVEL_ReadPercentage(
            ADC_CHANNEL_0,
            &Local_u8Value) == E_OK)
    {
        Global_stTankData.levelPct = Local_u8Value;
    }

    /* -----------------------------------------------------
     * Reservoir Level Percentage
     * ----------------------------------------------------- */

    if (LEVEL_ReadPercentage(
            ADC_CHANNEL_1,
            &Local_u8Value) == E_OK)
    {
        Global_stTankData.reservoirPct = Local_u8Value;
    }

    /* -----------------------------------------------------
     * Current
     * ----------------------------------------------------- */

    if (CUR_GetmA(
            &Global_stTankData.currentmA) != E_OK)
    {
        Global_stTankData.currentmA = 0u;
    }

    /* -----------------------------------------------------
     * Flow
     * ----------------------------------------------------- */

    Global_stTankData.flowLpmX10 =
        FLOWMETER_GetFlowLpmX10();

    /* -----------------------------------------------------
     * Total Volume
     * ----------------------------------------------------- */

    Local_u32VolumeMl =
        FLOWMETER_GetTotalMilliliters();

    Global_stTankData.totalLitres =
        Local_u32VolumeMl / 1000UL;

    /* -----------------------------------------------------
     * Float Switches
     * ----------------------------------------------------- */

    Global_stTankData.highFloat =
        FLT_IsHighActive();

    Global_stTankData.lowFloat =
        FLT_IsLowActive();

    /* -----------------------------------------------------
     * Pump State
     * ----------------------------------------------------- */
    if (PMP_GetState(&Local_u8Pump) == E_OK)
    {
        Global_stTankData.pumpOn =
            Local_u8Pump;
    }
    else
    {
        Global_stTankData.pumpOn = 0u;
    }
    /* -----------------------------------------------------
     * Valve State
     * ----------------------------------------------------- */

    if (Valve_GetState(&Local_u8Valve) == E_OK)
    {
        Global_stTankData.valveOn =
            Local_u8Valve;
    }
    else
    {
        Global_stTankData.valveOn = 0u;
    }

    /* -----------------------------------------------------
     * Pump Current Run Time
     * ----------------------------------------------------- */

    if (PMP_RunSeconds(&Local_u32Value) == E_OK)
    {
        Global_stTankData.pumpRunSec =
            (uint16)Local_u32Value;
    }
    else
    {
        Global_stTankData.pumpRunSec = 0u;
    }

    /* -----------------------------------------------------
     * Pump Total Run Time
     * ----------------------------------------------------- */

    if (PMP_TotalSeconds(
            &Global_stTankData.pumpTotalSec) != E_OK)
    {
        Global_stTankData.pumpTotalSec = 0UL;
    }

    /* -----------------------------------------------------
     * Pump Cycles
     * ----------------------------------------------------- */

    if (PMP_Cycles(&Local_u32Value) == E_OK)
    {
        Global_stTankData.pumpCycles =
            (uint16)Local_u32Value;
    }
    else
    {
        Global_stTankData.pumpCycles = 0u;
    }

    /* -----------------------------------------------------
     * FSM State
     * ----------------------------------------------------- */

    Global_stTankData.state =
        (uint8)FSM_GetState();
}

/* =========================================================
 * 10 ms Application Task
 *
 * Order:
 *
 * 1. Update input drivers
 * 2. Read application data
 * 3. Update demand
 * 4. Run FSM
 *
 * IMPORTANT:
 * FSM_Run() already calls ILK_Evaluate().
 * Therefore ILK_Evaluate() is NOT called here again.
 * ========================================================= */

static void APP_Task10ms(void)
{
    /* Update buttons */
    BTN_Update10ms(GPIO_PORTD);

    /* Update float switches */
    FLT_Update();

    /* Update current sensor */
    CUR_Update();

    /* Read all current data */
    APP_UpdateData();

    /* Update automatic demand */
    DEM_Update(&Global_stTankData);

    /*
     * FSM handles:
     * - Interlocks
     * - Trips
     * - Automatic mode
     * - Manual mode
     * - Service mode
     * - Pump / valve control
     */
    FSM_Run(&Global_stTankData);

    /* Refresh state after FSM */
    Global_stTankData.state =
        (uint8)FSM_GetState();
}

/* =========================================================
 * 500 ms Application Task
 *
 * LCD update
 * ========================================================= */

static void APP_Task500ms(void)
{
    uint16 Local_u16FlowInteger;
    uint8 Local_u8FlowDecimal;

    Local_u16FlowInteger =
        Global_stTankData.flowLpmX10 / 10u;

    Local_u8FlowDecimal =
        Global_stTankData.flowLpmX10 % 10u;

    /* Clear LCD */
    LCD_I2C_Clear();

    /* -----------------------------------------------------
     * LCD Line 1
     * ----------------------------------------------------- */

    LCD_I2C_SetCursor(
        LCD_ROW_1,
        LCD_COL_1);

    LCD_I2C_SendString("L:");

    LCD_I2C_SendNumber(
        Global_stTankData.levelPct);

    LCD_I2C_SendString("% R:");

    LCD_I2C_SendNumber(
        Global_stTankData.reservoirPct);

    LCD_I2C_SendString("%");

    /* -----------------------------------------------------
     * LCD Line 2
     * ----------------------------------------------------- */

    LCD_I2C_SetCursor(
        LCD_ROW_2,
        LCD_COL_1);

    LCD_I2C_SendString("F:");

    LCD_I2C_SendNumber(
        Local_u16FlowInteger);

    LCD_I2C_SendString(".");

    LCD_I2C_SendNumber(
        Local_u8FlowDecimal);

    LCD_I2C_SendString("L/m ");

    /* Pump status */

    if (Global_stTankData.pumpOn)
    {
        LCD_I2C_SendString("RUN");
    }
    else
    {
        LCD_I2C_SendString("OFF");
    }
}

/* =========================================================
 * 1 Second Application Task
 * ========================================================= */

static void APP_Task1s(void)
{
    /* Update pump run-time counters */
    PMP_Update1s();

    /* Calculate flow once per second */
    FLOWMETER_Update1Hz();

    /* System uptime */
    Global_stTankData.upTimeSec++;

    /* Refresh application data */
    APP_UpdateData();
}

/* =========================================================
 * Shift Register Status
 *
 * 74HC595 status byte:
 *
 * bit 0 -> Pump
 * bit 1 -> Valve
 * bit 2 -> High Float
 * bit 3 -> Low Float
 * bit 4 -> System Tripped
 * bit 5 -> Manual Mode
 * bit 6 -> Service Mode
 * bit 7 -> Reserved
 * ========================================================= */

static void APP_UpdateShiftRegister(void)
{
    uint8 Local_u8Status = 0u;

    TankState_t Local_enState;

    Local_enState =
        FSM_GetState();

    /* Pump */
    if (Global_stTankData.pumpOn)
    {
        Local_u8Status |= (1u << 0);
    }

    /* Valve */
    if (Global_stTankData.valveOn)
    {
        Local_u8Status |= (1u << 1);
    }

    /* High Float */
    if (Global_stTankData.highFloat)
    {
        Local_u8Status |= (1u << 2);
    }

    /* Low Float */
    if (Global_stTankData.lowFloat)
    {
        Local_u8Status |= (1u << 3);
    }

    /* System Tripped */
    if (Local_enState == ST_TRIPPED)
    {
        Local_u8Status |= (1u << 4);
    }

    /* Manual Mode */
    if (Local_enState == ST_MANUAL)
    {
        Local_u8Status |= (1u << 5);
    }

    /* Service Mode */
    if (Local_enState == ST_SERVICE)
    {
        Local_u8Status |= (1u << 6);
    }

    /* Send status byte */
    SHIFTREG_SendByte(Local_u8Status);
}

/* =========================================================
 * MAIN
 * ========================================================= */

int main(void)
{
    /* =====================================================
     * Initialize Application Data
     * ===================================================== */

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
    /* =====================================================
     * MCAL Initialization
     * ===================================================== */

    /* Timer0: used by scheduler delay */
    TIMER0_Init();

    /* ADC + Level */
    LEVEL_Init(ADC_CHANNEL_0);

    /*
     * SPI:
     * ATmega32 @ 8 MHz
     * Prescaler = 16
     * SPI clock = 500 kHz
     */
    SPI_InitMaster(SPI_PRESC_16);

    /* 74HC595 */
    SHIFTREG_Init();

    /* =====================================================
     * HAL / Driver Initialization
     * ===================================================== */

    PMP_Init();
    Valve_Init();
    FLT_Init();
    CUR_Init();
    BTN_Init(GPIO_PORTD);

    /*
     * Flowmeter initialization.
     * Flowmeter driver owns Timer1 external counter.
     */
    FLOWMETER_Init();

    I2C_InitMaster(100000UL);

    /* LCD through I2C */
    LCD_I2C_Init();
    /* =====================================================
     * Application Initialization
     * ===================================================== */

    DEM_Init();

    INT_Init();

    FSM_Init();

    /* Fault log */
    FLG_Init(&Global_stFaultLog);

    /* UART console */
    CON_Init();

    /* =====================================================
     * INT0 High Float Emergency Protection
     * ===================================================== */

    EXTI_SetCallback(
        EXTI_INT0,
        APP_HighFloatISR);

    EXTI_SetSense(
        EXTI_INT0,
        EXTI_FALLING_EDGE);

    EXTI_ClearFlag(
        EXTI_INT0);

    EXTI_Enable(
        EXTI_INT0);

    /* Enable global interrupts */
    INTERRUPT_EnableGlobal();

    /* =====================================================
     * Scheduler Initialization
     * ===================================================== */

    SCHEDULER_Init();
    /*
     * Main control task:
     * 10 ms
     */
    SCHEDULER_AddTask(
        APP_Task10ms,
        10u);
    /*
     * LCD:
     * 500 ms
     */
    SCHEDULER_AddTask(
        APP_Task500ms,
        500u);

    /*
     * Pump / flow / uptime:
     * 1 second
     */
    SCHEDULER_AddTask(
        APP_Task1s,
        1000u);
    /* =====================================================
     * First Data Update
     * ===================================================== */

    APP_UpdateData();

    Global_stTankData.state =
        (uint8)FSM_GetState();

    /* =====================================================
     * Main Loop
     * ===================================================== */

    while (1)
    {
        /*
         * Generate the 10 ms scheduler tick.
         *
         * This follows the same software-tick mechanism
         * used in the provided scheduler test.
         */
        TIMER0_DelayMS(10u);
        /* Update scheduler timing */
        SCHEDULER_Tick();
        /* Execute ready tasks */
        SCHEDULER_Run();
        /* Process UART console commands */
        CON_Run();

        /* Update 74HC595 status */
        APP_UpdateShiftRegister();
    }
    return 0;
}