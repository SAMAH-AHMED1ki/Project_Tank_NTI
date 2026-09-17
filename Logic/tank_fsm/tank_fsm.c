/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Tank Finite State Machine
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "Pump_interface.h"
#include "Valve_interface.h"
#include "Buttons_interface.h"
#include "interlocks.h"
#include "demand.h"
#include "tank_fsm.h"

#define FSM_SETTLING_TICKS 500u
#define FSM_MIN_OFF_TICKS 6000u

static TankState_t Global_eCurrentState = ST_INIT;

static uint16 Global_u16SettlingTicks = 0u;
static uint16 Global_u16MinOffTicks = FSM_MIN_OFF_TICKS;
static uint8 Global_u8BuzzerSilenced = GPIO_LOW;

/* ---------------------------------------------------------- */
/* Stop both pump and valve                                   */
/* ---------------------------------------------------------- */

static void FSM_StopOutputs(void)
{
    PMP_Set(GPIO_LOW);
    Valve_Set(GPIO_LOW);
}

/* ---------------------------------------------------------- */
/* Start filling                                               */
/* ---------------------------------------------------------- */

static void FSM_StartFilling(void)
{
    PMP_Set(GPIO_HIGH);
    Valve_Set(GPIO_HIGH);
}

/* ---------------------------------------------------------- */
/* Update minimum OFF timer                                    */
/* ---------------------------------------------------------- */

static void FSM_UpdateMinOffTimer(uint8 Copy_u8PumpOn)
{
    if (Copy_u8PumpOn == GPIO_LOW)
    {
        if (Global_u16MinOffTicks < FSM_MIN_OFF_TICKS)
        {
            Global_u16MinOffTicks++;
        }
    }
    else
    {
        /*
         * Pump is running:
         * minimum-OFF timer must restart from zero.
         */
        Global_u16MinOffTicks = 0u;
    }
}

/* ---------------------------------------------------------- */
/* Initialization                                              */
/* ---------------------------------------------------------- */

STD_ReturnType FSM_Init(void)
{
    STD_ReturnType Local_Status;

    Global_eCurrentState = ST_INIT;

    Global_u16SettlingTicks = 0u;
    Global_u16MinOffTicks = FSM_MIN_OFF_TICKS;
    Global_u8BuzzerSilenced = GPIO_LOW;

    Local_Status = PMP_Set(GPIO_LOW);

    if (Local_Status != E_OK)
    {
        return Local_Status;
    }

    Local_Status = Valve_Set(GPIO_LOW);

    if (Local_Status != E_OK)
    {
        return Local_Status;
    }

    return E_OK;
}

/* ---------------------------------------------------------- */
/* Main FSM cycle                                              */
/* ---------------------------------------------------------- */

STD_ReturnType FSM_Run(const TankData_t *Copy_pstData)
{
    Trip_t Local_eTrip = TRIP_NONE;

    ButtonEvent_t Local_eModeEvent = BTN_EVENT_NONE;
    ButtonEvent_t Local_eManualEvent = BTN_EVENT_NONE;
    ButtonEvent_t Local_eAckEvent = BTN_EVENT_NONE;

    if (Copy_pstData == NULL)
    {
        return E_NOK;
    }

    /* ====================================================== */
    /* Update minimum OFF timer                                */
    /* ====================================================== */

    FSM_UpdateMinOffTimer(Copy_pstData->pumpOn);

    /* ====================================================== */
    /* Read button events                                      */
    /* ====================================================== */

    BTN_GetEvent(BTN_MODE, &Local_eModeEvent);
    BTN_GetEvent(BTN_MANUAL_START, &Local_eManualEvent);
    BTN_GetEvent(BTN_ACK, &Local_eAckEvent);

    /* ====================================================== */
    /* Interlocks ALWAYS have priority                         */
    /* ====================================================== */

    Local_eTrip = ILK_Evaluate(Copy_pstData);

    if (Local_eTrip != TRIP_NONE)
    {
        /*
         * Any active trip has absolute priority.
         */
        FSM_StopOutputs();

        if (Global_eCurrentState != ST_TRIPPED)
        {
            Global_u8BuzzerSilenced = GPIO_LOW;
        }

        Global_eCurrentState = ST_TRIPPED;

        /*
         * ACK is handled below only through FSM_Ack().
         * The interlock itself decides when the fault
         * is actually safe to clear.
         */
    }

    /* ====================================================== */
    /* ACK button                                               */
    /* ====================================================== */

    if ((Local_eAckEvent == BTN_EVENT_SHORT_PRESS) ||
        (Local_eAckEvent == BTN_EVENT_LONG_HOLD_1S))
    {
        FSM_Ack();
    }

    /*
     * If a trip existed at the beginning of this cycle,
     * do not allow MODE or MANUAL commands to operate
     * the pump in this same cycle.
     */
    if (Local_eTrip != TRIP_NONE)
    {
        /*
         * Re-checking the interlock here is intentionally
         * avoided. ILK_Evaluate() must run once per cycle.
         *
         * The actual clear will be observed on the next
         * FSM cycle after ACK + safe conditions.
         */
        FSM_StopOutputs();

        return E_OK;
    }

    /* ====================================================== */
    /* MODE button: AUTO <-> MANUAL                            */
    /* ====================================================== */

    if (Local_eModeEvent == BTN_EVENT_SHORT_PRESS)
    {
        if (Global_eCurrentState == ST_MANUAL)
        {
            FSM_StopOutputs();

            Global_eCurrentState = ST_IDLE;
        }
        else if ((Global_eCurrentState == ST_IDLE) ||
                 (Global_eCurrentState == ST_FILLING))
        {
            FSM_StopOutputs();

            Global_eCurrentState = ST_MANUAL;
        }
    }

    /* ====================================================== */
    /* State machine                                            */
    /* ====================================================== */

    switch (Global_eCurrentState)
    {
    case ST_INIT:

        FSM_StopOutputs();

        Global_u16SettlingTicks = 0u;

        Global_eCurrentState = ST_IDLE;

        break;

    case ST_IDLE:

        FSM_StopOutputs();

        Global_u16SettlingTicks = 0u;

        /*
         * Reservoir below 25%:
         * wait for enough water.
         */
        if (Copy_pstData->reservoirPct < 25u)
        {
            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }

        /*
         * Tank demands filling and minimum OFF time
         * has expired.
         */
        else if ((DEM_GetPumpDemand() != 0u) &&
                 (Global_u16MinOffTicks >= FSM_MIN_OFF_TICKS))
        {
            Global_eCurrentState = ST_FILLING;
        }

        break;

    case ST_FILLING:

        /*
         * Reservoir became low.
         */
        if (Copy_pstData->reservoirPct < 25u)
        {
            FSM_StopOutputs();

            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }

        /*
         * Demand disappeared.
         */
        else if (DEM_GetPumpDemand() == 0u)
        {
            FSM_StopOutputs();

            Global_u16SettlingTicks = 0u;

            Global_eCurrentState = ST_SETTLING;
        }

        /*
         * Continue filling.
         */
        else
        {
            FSM_StartFilling();
        }

        break;

    case ST_SETTLING:

        FSM_StopOutputs();

        if (Global_u16SettlingTicks < FSM_SETTLING_TICKS)
        {
            Global_u16SettlingTicks++;
        }

        if (Global_u16SettlingTicks >= FSM_SETTLING_TICKS)
        {
            Global_u16SettlingTicks = 0u;

            Global_eCurrentState = ST_IDLE;
        }

        break;

    case ST_RESERVOIR_WAIT:

        FSM_StopOutputs();

        if (Copy_pstData->reservoirPct >= 25u)
        {
            Global_eCurrentState = ST_IDLE;
        }

        break;

    case ST_TRIPPED:

        /*
         * Always keep outputs OFF.
         *
         * ILK_Evaluate() is called once at the beginning
         * of the cycle. If the trip was cleared there,
         * Local_eTrip will be TRIP_NONE.
         */
        FSM_StopOutputs();

        /*
         * We only reach this case when the interlock was
         * already clear at the beginning of this cycle.
         */

        break;

    case ST_MANUAL:

        /*
         * Manual start still cannot bypass interlocks.
         *
         * Minimum OFF time must have expired.
         */
        if (Local_eManualEvent == BTN_EVENT_SHORT_PRESS)
        {
            if (Global_u16MinOffTicks >= FSM_MIN_OFF_TICKS)
            {
                PMP_Set(GPIO_HIGH);
                Valve_Set(GPIO_HIGH);
            }
        }

        /*
         * Keep valve open while pump is running.
         */
        if (Copy_pstData->pumpOn != GPIO_LOW)
        {
            Valve_Set(GPIO_HIGH);
        }

        break;

    case ST_SERVICE:

        /*
         * Service mode keeps outputs OFF.
         *
         * Safety interlocks remain active.
         */
        FSM_StopOutputs();

        break;

    default:

        FSM_StopOutputs();

        Global_eCurrentState = ST_TRIPPED;

        break;
    }

    return E_OK;
}

/* ---------------------------------------------------------- */
/* Get current FSM state                                      */
/* ---------------------------------------------------------- */

TankState_t FSM_GetState(void)
{
    return Global_eCurrentState;
}

/* ---------------------------------------------------------- */
/* Acknowledge current trip                                   */
/* ---------------------------------------------------------- */

STD_ReturnType FSM_Ack(void)
{
    STD_ReturnType Local_Status;

    Global_u8BuzzerSilenced = GPIO_HIGH;

    Local_Status = ILK_Reset();

    /* لو الإنفجار/الخطأ اتصفى، نرجع الستيت لـ ST_IDLE بأمان */
    if (Local_Status == E_OK)
    {
        Global_eCurrentState = ST_IDLE;
    }

    return Local_Status;
}

/* ---------------------------------------------------------- */
/* Check buzzer status                                        */
/* ---------------------------------------------------------- */

uint8 FSM_IsBuzzerEnabled(void)
{
    if ((Global_eCurrentState == ST_TRIPPED) &&
        (Global_u8BuzzerSilenced == GPIO_LOW))
    {
        return GPIO_HIGH;
    }

    return GPIO_LOW;
}