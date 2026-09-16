#define F_CPU 8000000UL

#include <avr/io.h>

#include "STD_TYPES.h"

/* ========================= MCAL ========================= */
#include "GPIO_interface.h"
#include "TIMER_interface.h"
#include "INTERRUPT_interface.h"
#include "Scheduler_interface.h"

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
 * INT0 callback
 *
 * High-float emergency hardware guard.
 * Pump and inlet valve are switched OFF immediately.
 * ========================================================= */

static void APP_HighFloatISR(void)
{
    PMP_Set(0u);
    Valve_Set(0u);
}

/* =========================================================
 * Read / update all application data
 * ========================================================= */

static void APP_UpdateData(void)
{
    uint16 Local_u16Raw;
    uint8 Local_u8Value;
    uint8 Local_u8Pump;
    uint8 Local_u8Valve;
    uint32 Local_u32Value;

    /* ---------------- Roof level raw ---------------- */

    if (ADC_ReadChannel(
            ADC_CHANNEL_0,
            &Local_u16Raw) == E_OK)
    {
        Global_stTankData.levelRaw = Local_u16Raw;
    }

    /* ---------------- Reservoir raw ---------------- */

    if (ADC_ReadChannel(
            ADC_CHANNEL_1,
            &Local_u16Raw) == E_OK)
    {
        Global_stTankData.reservoirRaw = Local_u16Raw;
    }

    /* ---------------- Roof level percentage ---------------- */

    if (LEVEL_ReadPercentage(
            ADC_CHANNEL_0,
            &Local_u8Value) == E_OK)
    {
        Global_stTankData.levelPct = Local_u8Value;
    }

    /* ---------------- Reservoir percentage ---------------- */

    if (LEVEL_ReadPercentage(
            ADC_CHANNEL_1,
            &Local_u8Value) == E_OK)
    {
        Global_stTankData.reservoirPct = Local_u8Value;
    }

    /* ---------------- Current ---------------- */

    if (CUR_GetmA(
            &Global_stTankData.currentmA) != E_OK)
    {
        Global_stTankData.currentmA = 0u;
    }

    /* ---------------- Flow ---------------- */

    Global_stTankData.flowLpmX10 =
        FLOWMETER_GetFlowLpmX10();

    /* ---------------- Floats ---------------- */

    Global_stTankData.highFloat =
        FLT_IsHighActive();

    Global_stTankData.lowFloat =
        FLT_IsLowActive();

    /* ---------------- Pump state ---------------- */

    if (PMP_GetState(&Local_u8Pump) == E_OK)
    {
        Global_stTankData.pumpOn =
            Local_u8Pump;
    }
    else
    {
        Global_stTankData.pumpOn = 0u;
    }

    /* ---------------- Valve state ---------------- */

    if (Valve_GetState(&Local_u8Valve) == E_OK)
    {
        Global_stTankData.valveOn =
            Local_u8Valve;
    }
    else
    {
        Global_stTankData.valveOn = 0u;
    }

    /* ---------------- Pump run time ---------------- */

    if (PMP_RunSeconds(&Local_u32Value) == E_OK)
    {
        Global_stTankData.pumpRunSec =
            (uint16)Local_u32Value;
    }
    else
    {
        Global_stTankData.pumpRunSec = 0u;
    }

    /* ---------------- Pump total time ---------------- */

    if (PMP_TotalSeconds(
            &Global_stTankData.pumpTotalSec) != E_OK)
    {
        Global_stTankData.pumpTotalSec = 0UL;
    }

    /* ---------------- Pump cycles ---------------- */

    if (PMP_Cycles(&Local_u32Value) == E_OK)
    {
        Global_stTankData.pumpCycles =
            (uint16)Local_u32Value;
    }
    else
    {
        Global_stTankData.pumpCycles = 0u;
    }

    /* ---------------- State ---------------- */

    Global_stTankData.state =
        (uint8)FSM_GetState();
}

/* =========================================================
 * 10 ms application task
 *
 * Important:
 * FSM_Run() internally calls ILK_Evaluate().
 * Therefore ILK_Evaluate() is NOT called again here.
 * ========================================================= */

static void APP_Task10ms(void)
{
    /* Update input drivers */
    BTN_Update10ms(GPIO_PORTD);

    FLT_Update();

    CUR_Update();

    /* Collect current sensor data */
    APP_UpdateData();

    /* Update automatic demand */
    DEM_Update(&Global_stTankData);

    /*
     * FSM handles:
     * - interlock evaluation
     * - trip handling
     * - automatic filling
     * - manual mode
     * - service mode
     */
    FSM_Run(&Global_stTankData);

    /* Refresh state after FSM execution */
    Global_stTankData.state =
        (uint8)FSM_GetState();
}

/* =========================================================
 * 500 ms task
 *
 * LCD display
 * ========================================================= */

static void APP_Task500ms(void)
{
    uint16 Local_u16FlowInteger;
    uint8 Local_u8FlowDecimal;

    Local_u16FlowInteger =
        Global_stTankData.flowLpmX10 / 10u;

    Local_u8FlowDecimal =
        Global_stTankData.flowLpmX10 % 10u;

    LCD_I2C_Clear();

    /* ---------- Line 1 ---------- */

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

    /* ---------- Line 2 ---------- */

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
 * 1 second task
 * ========================================================= */

static void APP_Task1s(void)
{
    PMP_Update1s();

    FLOWMETER_Update1Hz();

    Global_stTankData.upTimeSec++;

    APP_UpdateData();
}

/* =========================================================
 * Shift register status
 *
 * Byte assignment:
 *
 * bit 0 -> Pump
 * bit 1 -> Valve
 * bit 2 -> High float
 * bit 3 -> Low float
 * bit 4 -> FSM tripped
 * bit 5 -> Manual
 * bit 6 -> Service
 * bit 7 -> reserved
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

    /* High float */
    if (Global_stTankData.highFloat)
    {
        Local_u8Status |= (1u << 2);
    }

    /* Low float */
    if (Global_stTankData.lowFloat)
    {
        Local_u8Status |= (1u << 3);
    }

    /* System is tripped */
    if (Local_enState == ST_TRIPPED)
    {
        Local_u8Status |= (1u << 4);
    }

    /* Manual mode */
    if (Local_enState == ST_MANUAL)
    {
        Local_u8Status |= (1u << 5);
    }

    /* Service mode */
    if (Local_enState == ST_SERVICE)
    {
        Local_u8Status |= (1u << 6);
    }

    SHIFTREG_SendByte(Local_u8Status);
}

/* =========================================================
 * MAIN
 * ========================================================= */

int main(void)
{
    /* =====================================================
     * Initial application data
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
     * Hardware initialization
     * ===================================================== */

    TIMER0_Init();

    SHIFTREG_Init();

    LEVEL_Init(ADC_CHANNEL_0);

    PMP_Init();

    Valve_Init();

    FLT_Init();

    CUR_Init();

    BTN_Init(GPIO_PORTD);

    TIMER1_ExternalCounterInit();

    FLOWMETER_Init();

    LCD_I2C_Init();

    /* =====================================================
     * Application initialization
     * ===================================================== */

    DEM_Init();

    INT_Init();

    FSM_Init();

    FLG_Init(&Global_stFaultLog);

    CON_Init();

    /* =====================================================
     * INT0 HIGH FLOAT emergency protection
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

    INTERRUPT_EnableGlobal();

    /* =====================================================
     * Scheduler
     *
     * Base tick = 10 ms
     * ===================================================== */

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

    /* =====================================================
     * First sensor update
     * ===================================================== */

    APP_UpdateData();

    Global_stTankData.state =
        (uint8)FSM_GetState();

    /* =====================================================
     * Main loop
     * ===================================================== */

    while (1)
    {
        /*
         * Generate 10 ms scheduler tick.
         *
         * This follows the same software-tick mechanism
         * used by the provided scheduler test.
         */
        TIMER0_DelayMS(10u);

        SCHEDULER_Tick();

        SCHEDULER_Run();

        /*
         * Process UART console commands.
         */
        CON_Run();

        /*
         * Update 74HC595 status display.
         */
        APP_UpdateShiftRegister();
    }

    return 0;
}