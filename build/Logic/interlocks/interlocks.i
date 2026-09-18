# 0 "Logic/interlocks/interlocks.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/interlocks/interlocks.c"
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
# 2 "Logic/interlocks/interlocks.c" 2
# 1 "Logic/interlocks/interlocks.h" 1




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
# 6 "Logic/interlocks/interlocks.h" 2

STD_ReturnType INT_Init(void);
# 17 "Logic/interlocks/interlocks.h"
Trip_t ILK_Evaluate(const TankData_t *Copy_pstData);







STD_ReturnType ILK_Reset(void);
# 3 "Logic/interlocks/interlocks.c" 2
# 28 "Logic/interlocks/interlocks.c"
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





static void ResetTimers(void)
{
    Global_u16OverflowTicks = 0u;
    Global_u16OverCurrentTicks = 0u;
    Global_u16NoCurrentTicks = 0u;
    Global_u16DryRunTicks = 0u;
    Global_u16LevelSensorTicks = 0u;

    Global_u16LeakTicks = 0u;
    Global_u16NoRiseTicks = 0u;

    Global_u8LeakStartLevel = 0u;
    Global_u8NoRiseStartLevel = 0u;
}





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





static uint8 CanClear(Trip_t trip, const TankData_t *data)
{
    if (data == ((void *)0))
    {
        return 0u;
    }

    switch (trip)
    {
    case TRIP_OVERFLOW:

        return ((data->levelPct <= 95u) &&
                (data->highFloat == 0u));

    case TRIP_OVERCURRENT:

        return ((data->currentmA < 1000u) &&
                (data->pumpOn == 0u));

    case TRIP_DRY_RESERVOIR:

        return ((data->reservoirPct >= 25u) &&
                (data->lowFloat == 0u));

    case TRIP_DRY_RUN:

        return (data->reservoirPct >= 25u);

    case TRIP_NO_CURRENT:

        return (data->pumpOn == 0u);

    case TRIP_MAX_RUNTIME:

        return (data->pumpOn == 0u);

    case TRIP_LEVEL_SENSOR:

        return ((data->levelRaw > 0u) &&
                (data->levelRaw < 1023u));

    case TRIP_LEAK:
    case TRIP_NO_RISE:

        return (data->pumpOn == 0u);

    case TRIP_NONE:
    default:

        return 1u;
    }
}





STD_ReturnType INT_Init(void)
{
    Global_eTrip = TRIP_NONE;
    Global_u8Ack = 0u;

    ResetTimers();

    return E_OK;
}





STD_ReturnType ILK_Reset(void)
{






    if (Global_eTrip != TRIP_NONE)
    {
        Global_u8Ack = 1u;
    }

    return E_OK;
}





Trip_t ILK_Evaluate(const TankData_t *data)
{
    Trip_t newTrip = TRIP_NONE;
    uint8 Local_u8Rise = 0u;

    if (data == ((void *)0))
    {
        return Global_eTrip;
    }





    if (Global_eTrip != TRIP_NONE)
    {
# 203 "Logic/interlocks/interlocks.c"
        if ((Global_u8Ack != 0u) &&
            (CanClear(Global_eTrip, data) != 0u))
        {
            Global_eTrip = TRIP_NONE;
            Global_u8Ack = 0u;

            ResetTimers();
        }

        return Global_eTrip;
    }





    if (data->highFloat != 0u)
    {




        newTrip = TRIP_OVERFLOW;
    }
    else if (data->levelPct >= 99u)
    {




        if (Global_u16OverflowTicks < 200u)
        {
            Global_u16OverflowTicks++;
        }

        if (Global_u16OverflowTicks >= 200u)
        {
            newTrip = TRIP_OVERFLOW;
        }
    }
    else
    {
        Global_u16OverflowTicks = 0u;
    }





    if (newTrip == TRIP_NONE)
    {
        if (data->currentmA > 8000u)
        {
            if (Global_u16OverCurrentTicks <
                50u)
            {
                Global_u16OverCurrentTicks++;
            }

            if (Global_u16OverCurrentTicks >=
                50u)
            {
                newTrip = TRIP_OVERCURRENT;
            }
        }
        else
        {
            Global_u16OverCurrentTicks = 0u;
        }
    }





    if (newTrip == TRIP_NONE)
    {
        if ((data->lowFloat != 0u) ||
            (data->reservoirPct < 10u))
        {




            newTrip = TRIP_DRY_RESERVOIR;
        }
    }





    if (newTrip == TRIP_NONE)
    {
        if ((data->pumpOn != 0u) &&
            (data->flowLpmX10 < 10u))
        {




            if (Global_u16DryRunTicks < 1000u)
            {
                Global_u16DryRunTicks++;
            }

            if (Global_u16DryRunTicks >=
                1000u)
            {
                newTrip = TRIP_DRY_RUN;
            }
        }
        else
        {
            Global_u16DryRunTicks = 0u;
        }
    }





    if (newTrip == TRIP_NONE)
    {
        if ((data->pumpOn != 0u) &&
            (data->currentmA < 500u))
        {




            if (Global_u16NoCurrentTicks <
                300u)
            {
                Global_u16NoCurrentTicks++;
            }

            if (Global_u16NoCurrentTicks >=
                300u)
            {
                newTrip = TRIP_NO_CURRENT;
            }
        }
        else
        {
            Global_u16NoCurrentTicks = 0u;
        }
    }





    if ((newTrip == TRIP_NONE) &&
        (data->pumpRunSec > 900u))
    {




        newTrip = TRIP_MAX_RUNTIME;
    }





    if (newTrip == TRIP_NONE)
    {
        if ((data->levelRaw == 0u) ||
            (data->levelRaw == 1023u))
        {




            if (Global_u16LevelSensorTicks <
                500u)
            {
                Global_u16LevelSensorTicks++;
            }

            if (Global_u16LevelSensorTicks >=
                500u)
            {
                newTrip = TRIP_LEVEL_SENSOR;
            }
        }
        else
        {
            Global_u16LevelSensorTicks = 0u;
        }
    }





    if ((newTrip == TRIP_NONE) &&
        (IsSuppressed(data->state) == 0u))
    {
        if (data->pumpOn == 0u)
        {



            if (Global_u16LeakTicks == 0u)
            {
                Global_u8LeakStartLevel = data->levelPct;
            }

            if (Global_u16LeakTicks < 6000u)
            {
                Global_u16LeakTicks++;
            }

            if (Global_u16LeakTicks >= 6000u)
            {




                if ((Global_u8LeakStartLevel > data->levelPct) &&
                    ((Global_u8LeakStartLevel -
                      data->levelPct) > 5u))
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





    if ((newTrip == TRIP_NONE) &&
        (IsSuppressed(data->state) == 0u))
    {
        if (data->pumpOn != 0u)
        {



            if (Global_u16NoRiseTicks == 0u)
            {
                Global_u8NoRiseStartLevel = data->levelPct;
            }

            if (Global_u16NoRiseTicks < 12000u)
            {
                Global_u16NoRiseTicks++;
            }

            if (data->levelPct > Global_u8NoRiseStartLevel)
            {
                Local_u8Rise =
                    data->levelPct -
                    Global_u8NoRiseStartLevel;
            }
            else
            {
                Local_u8Rise = 0u;
            }






            if ((Global_u16NoRiseTicks >= 12000u) &&
                (Local_u8Rise < 2u))
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





    if (newTrip != TRIP_NONE)
    {
        Global_eTrip = newTrip;




        Global_u8Ack = 0u;

        ResetTimers();
    }

    return Global_eTrip;
}
