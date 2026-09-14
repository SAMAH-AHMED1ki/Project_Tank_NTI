#include "STD_TYPES.h"
#include "interlocks.h"

#define OVERCURRENT_LIMIT_MA 8000u
#define OVERCURRENT_CLEAR_MA 1000u

#define DRY_RESERVOIR_LIMIT 10u
#define DRY_RESERVOIR_CLEAR 25u

#define DRY_RUN_FLOW_X10 10u
#define NO_CURRENT_LIMIT_MA 500u

#define OVERFLOW_LEVEL 99u
#define OVERFLOW_CLEAR_LEVEL 95u

#define OVERFLOW_DELAY_TICKS 200u
#define LEVEL_SENSOR_DELAY_TICKS 500u
#define OVERCURRENT_DELAY_TICKS 50u
#define NO_CURRENT_DELAY_TICKS 300u
#define DRY_RUN_DELAY_TICKS 1000u
#define LEAK_DELAY_TICKS 6000u
#define NO_RISE_DELAY_TICKS 12000u

#define MAX_RUNTIME_SEC 900u
#define LEAK_DROP_PERCENT 5u
#define NO_RISE_PERCENT 2u

static Trip_t Global_eTrip = TRIP_NONE;

static uint16 Global_u16OverflowTicks = 0u;
static uint16 Global_u16OverCurrentTicks = 0u;
static uint16 Global_u16NoCurrentTicks = 0u;
static uint16 Global_u16DryRunTicks = 0u;
static uint16 Global_u16LevelSensorTicks = 0u;

static uint16 Global_u16LeakTicks = 0u;
static uint16 Global_u16NoRiseTicks = 0u;

static uint8 Global_u8LeakStartLevel = 0u;
static uint8 Global_u8NoRiseStartLevel = 0u;

static uint8 Global_u8Ack = 0u;

/* Reset temporary timers */
static void ResetTimers(void)
{
    Global_u16OverflowTicks = 0u;
    Global_u16OverCurrentTicks = 0u;
    Global_u16NoCurrentTicks = 0u;
    Global_u16DryRunTicks = 0u;
    Global_u16LevelSensorTicks = 0u;
    Global_u16LeakTicks = 0u;
    Global_u16NoRiseTicks = 0u;
}

/* Check if Leak / No-Rise should be disabled */
static uint8 IsSuppressed(uint8 state)
{
    if ((state == ST_MANUAL) ||
        (state == ST_SERVICE) ||
        (state == ST_SETTLING))
    {
        return 1u;
    }

    return 0u;
}

/* Check if the latched trip can be cleared */
static uint8 CanClear(Trip_t trip, const TankData_t *data)
{
    switch (trip)
    {
    case TRIP_OVERFLOW:
        return ((data->levelPct <= OVERFLOW_CLEAR_LEVEL) &&
                (data->highFloat == 0u));

    case TRIP_OVERCURRENT:
        return ((data->currentmA < OVERCURRENT_CLEAR_MA) &&
                (data->pumpOn == 0u));

    case TRIP_DRY_RESERVOIR:
        return ((data->reservoirPct >= DRY_RESERVOIR_CLEAR) &&
                (data->lowFloat == 0u));

    case TRIP_DRY_RUN:
        return (data->reservoirPct >= DRY_RESERVOIR_CLEAR);

    case TRIP_NO_CURRENT:
    case TRIP_LEAK:
    case TRIP_NO_RISE:
        return 1u;

    case TRIP_MAX_RUNTIME:
        return (data->pumpOn == 0u);

    case TRIP_LEVEL_SENSOR:
        return ((data->levelRaw > 0u) &&
                (data->levelRaw < 1023u));

    default:
        return 1u;
    }
}

STD_ReturnType INT_Init(void)
{
    Global_eTrip = TRIP_NONE;
    Global_u8Ack = 0u;

    ResetTimers();

    Global_u8LeakStartLevel = 0u;
    Global_u8NoRiseStartLevel = 0u;

    return E_OK;
}

STD_ReturnType ILK_Reset(void)
{
    Global_u8Ack = 1u;

    return E_OK;
}

Trip_t ILK_Evaluate(const TankData_t *data)
{
    Trip_t newTrip = TRIP_NONE;
    uint8 Local_u8Rise = 0u;

    /* Existing latched fault */
    if (Global_eTrip != TRIP_NONE)
    {
        if (Global_u8Ack != 0u)
        {
            /*
             * ACK is consumed whether the condition
             * is clear or still active.
             */
            Global_u8Ack = 0u;

            if (CanClear(Global_eTrip, data) != 0u)
            {
                Global_eTrip = TRIP_NONE;
                ResetTimers();
            }
        }

        return Global_eTrip;
    }

    /* 1. Overflow */
    if (data->highFloat != 0u)
    {
        /* High float causes immediate trip */
        newTrip = TRIP_OVERFLOW;
    }
    else if (data->levelPct >= OVERFLOW_LEVEL)
    {
        /* Analog overflow must remain for 2 seconds */
        if (Global_u16OverflowTicks < OVERFLOW_DELAY_TICKS)
            Global_u16OverflowTicks++;

        if (Global_u16OverflowTicks >= OVERFLOW_DELAY_TICKS)
            newTrip = TRIP_OVERFLOW;
    }
    else
    {
        Global_u16OverflowTicks = 0u;
    }

    /* 2. Overcurrent */
    if (newTrip == TRIP_NONE)
    {
        if (data->currentmA > OVERCURRENT_LIMIT_MA)
        {
            if (Global_u16OverCurrentTicks <
                OVERCURRENT_DELAY_TICKS)
            {
                Global_u16OverCurrentTicks++;
            }

            if (Global_u16OverCurrentTicks >=
                OVERCURRENT_DELAY_TICKS)
            {
                newTrip = TRIP_OVERCURRENT;
            }
        }
        else
        {
            Global_u16OverCurrentTicks = 0u;
        }
    }

    /* 3. Dry reservoir */
    if (newTrip == TRIP_NONE)
    {
        if ((data->lowFloat != 0u) ||
            (data->reservoirPct < DRY_RESERVOIR_LIMIT))
        {
            newTrip = TRIP_DRY_RESERVOIR;
        }
    }

    /* 4. Dry run */
    if (newTrip == TRIP_NONE)
    {
        if ((data->pumpOn != 0u) &&
            (data->flowLpmX10 < DRY_RUN_FLOW_X10))
        {
            if (Global_u16DryRunTicks < DRY_RUN_DELAY_TICKS)
                Global_u16DryRunTicks++;

            if (Global_u16DryRunTicks >=
                DRY_RUN_DELAY_TICKS)
            {
                newTrip = TRIP_DRY_RUN;
            }
        }
        else
        {
            Global_u16DryRunTicks = 0u;
        }
    }

    /* 5. No current */
    if (newTrip == TRIP_NONE)
    {
        if ((data->pumpOn != 0u) &&
            (data->currentmA < NO_CURRENT_LIMIT_MA))
        {
            if (Global_u16NoCurrentTicks <
                NO_CURRENT_DELAY_TICKS)
            {
                Global_u16NoCurrentTicks++;
            }

            if (Global_u16NoCurrentTicks >=
                NO_CURRENT_DELAY_TICKS)
            {
                newTrip = TRIP_NO_CURRENT;
            }
        }
        else
        {
            Global_u16NoCurrentTicks = 0u;
        }
    }

    /* 6. Maximum runtime */
    if ((newTrip == TRIP_NONE) &&
        (data->pumpRunSec > MAX_RUNTIME_SEC))
    {
        newTrip = TRIP_MAX_RUNTIME;
    }

    /* 7. Level sensor */
    if (newTrip == TRIP_NONE)
    {
        if ((data->levelRaw == 0u) ||
            (data->levelRaw == 1023u))
        {
            if (Global_u16LevelSensorTicks <
                LEVEL_SENSOR_DELAY_TICKS)
            {
                Global_u16LevelSensorTicks++;
            }

            if (Global_u16LevelSensorTicks >=
                LEVEL_SENSOR_DELAY_TICKS)
            {
                newTrip = TRIP_LEVEL_SENSOR;
            }
        }
        else
        {
            Global_u16LevelSensorTicks = 0u;
        }
    }

    /* 8. Leak */
    if ((newTrip == TRIP_NONE) &&
        (IsSuppressed(data->state) == 0u))
    {
        if (data->pumpOn == 0u)
        {
            if (Global_u16LeakTicks == 0u)
                Global_u8LeakStartLevel = data->levelPct;

            if (Global_u16LeakTicks < LEAK_DELAY_TICKS)
                Global_u16LeakTicks++;

            if (Global_u16LeakTicks >= LEAK_DELAY_TICKS)
            {
                if ((Global_u8LeakStartLevel > data->levelPct) &&
                    ((Global_u8LeakStartLevel -
                      data->levelPct) > LEAK_DROP_PERCENT))
                {
                    newTrip = TRIP_LEAK;
                }

                Global_u16LeakTicks = 0u;
            }
        }
        else
        {
            Global_u16LeakTicks = 0u;
        }
    }
    else
    {
        Global_u16LeakTicks = 0u;
    }

    /* 9. No rise */
    if ((newTrip == TRIP_NONE) &&
        (IsSuppressed(data->state) == 0u))
    {
        if (data->pumpOn != 0u)
        {
            if (Global_u16NoRiseTicks == 0u)
                Global_u8NoRiseStartLevel = data->levelPct;

            if (Global_u16NoRiseTicks < NO_RISE_DELAY_TICKS)
                Global_u16NoRiseTicks++;

            if (data->levelPct > Global_u8NoRiseStartLevel)
            {
                Local_u8Rise =
                    data->levelPct - Global_u8NoRiseStartLevel;
            }
            else
            {
                Local_u8Rise = 0u;
            }

            if ((Global_u16NoRiseTicks >= NO_RISE_DELAY_TICKS) &&
                (Local_u8Rise < NO_RISE_PERCENT))
            {
                newTrip = TRIP_NO_RISE;
            }
        }
        else
        {
            Global_u16NoRiseTicks = 0u;
        }
    }
    else
    {
        Global_u16NoRiseTicks = 0u;
    }

    /* Latch trip */
    if (newTrip != TRIP_NONE)
    {
        Global_eTrip = newTrip;
        ResetTimers();
    }

    return Global_eTrip;
}