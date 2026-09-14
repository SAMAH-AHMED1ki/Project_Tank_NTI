/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Tank Finite State Machine
 */

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "Pump_interface.h"
#include "Valve_interface.h"
#include "interlocks.h"
#include "demand.h"
#include "tank_fsm.h"

static TankState_t Global_eCurrentState = ST_INIT;

STD_ReturnType FSM_Init(void)
{
    STD_ReturnType Local_Status;

    Global_eCurrentState = ST_INIT;

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

STD_ReturnType FSM_Run(const TankData_t *Copy_pstData)
{
    Trip_t Local_eTrip;

    if (Copy_pstData == NULL)
    {
        return E_NOK;
    }

    /*
     * Interlocks are checked before state transitions.
     */
    Local_eTrip = ILK_Evaluate(Copy_pstData);

    if (Local_eTrip != TRIP_NONE)
    {
        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        Global_eCurrentState = ST_TRIPPED;

        return E_OK;
    }

    switch (Global_eCurrentState)
    {
    case ST_INIT:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        Global_eCurrentState = ST_IDLE;

        break;

    case ST_IDLE:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        if (Copy_pstData->reservoirPct < 25u)
        {
            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }
        else if (DEM_GetPumpDemand() != 0u)
        {
            Global_eCurrentState = ST_FILLING;
        }

        break;

    case ST_FILLING:

        if (Copy_pstData->reservoirPct < 25u)
        {
            PMP_Set(GPIO_LOW);
            Valve_Set(GPIO_LOW);

            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }
        else if (DEM_GetPumpDemand() == 0u)
        {
            PMP_Set(GPIO_LOW);
            Valve_Set(GPIO_LOW);

            Global_eCurrentState = ST_SETTLING;
        }
        else
        {
            PMP_Set(GPIO_HIGH);
            Valve_Set(GPIO_HIGH);
        }

        break;

    case ST_SETTLING:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        /*
         * Settling timer will be handled by the
         * interlock/FSM timing logic.
         */

        Global_eCurrentState = ST_IDLE;

        break;

    case ST_RESERVOIR_WAIT:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        if (Copy_pstData->reservoirPct >= 25u)
        {
            Global_eCurrentState = ST_IDLE;
        }

        break;

    case ST_TRIPPED:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        /*
         * ILK_Reset() is responsible for acknowledging
         * a latched fault.
         */

        break;

    case ST_MANUAL:

        /*
         * Manual mode still keeps all interlocks active.
         * Manual start is handled through the FSM/buttons.
         */

        break;

    case ST_SERVICE:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        break;

    default:

        PMP_Set(GPIO_LOW);
        Valve_Set(GPIO_LOW);

        Global_eCurrentState = ST_TRIPPED;

        break;
    }

    return E_OK;
}

TankState_t FSM_GetState(void)
{
    return Global_eCurrentState;
}

STD_ReturnType FSM_Ack(void)
{
    /*
     * Ask the interlock module to acknowledge the
     * currently latched trip.
     */
    return ILK_Reset();
}