# 0 "Logic/tank_fsm/tamk_fsm.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/tank_fsm/tamk_fsm.c"





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
# 7 "Logic/tank_fsm/tamk_fsm.c" 2
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
# 8 "Logic/tank_fsm/tamk_fsm.c" 2
# 1 "Logic/demand/demand.h" 1




# 1 "Logic/interlocks/tank_types.h" 1
# 6 "Logic/demand/demand.h" 2

STD_ReturnType DEM_Init(void);
STD_ReturnType DEM_Update(const TankData_t *Copy_pstData);
uint8 DEM_GetPumpDemand(void);
# 9 "Logic/tank_fsm/tamk_fsm.c" 2
# 1 "Logic/tank_fsm/tank_fsm.h" 1
# 12 "Logic/tank_fsm/tank_fsm.h"
typedef enum
{
    FSM_STATE_IDLE = 0,
    FSM_STATE_FILLING,
    FSM_STATE_TRIPPED,
    FSM_STATE_SERVICE
} Tank_State_t;


STD_ReturnType FSM_Init(void);


STD_ReturnType FSM_Run(void);


Tank_State_t FSM_GetState(void);


STD_ReturnType FSM_Ack(void);
# 10 "Logic/tank_fsm/tamk_fsm.c" 2

static Tank_State_t Global_CurrentState = FSM_STATE_IDLE;

STD_ReturnType FSM_Init(void)
{
    Global_CurrentState = FSM_STATE_IDLE;
    return E_OK;
}

STD_ReturnType FSM_Run(void)
{

    if (INT_IsSystemTripped() == 1)
    {
        Global_CurrentState = FSM_STATE_TRIPPED;
        return E_OK;
    }


    switch (Global_CurrentState)
    {
    case FSM_STATE_IDLE:
        if (DEM_GetPumpDemand() == 1)
        {
            Global_CurrentState = FSM_STATE_FILLING;
        }
        break;

    case FSM_STATE_FILLING:
        if (DEM_GetPumpDemand() == 0)
        {
            Global_CurrentState = FSM_STATE_IDLE;
        }
        break;

    case FSM_STATE_TRIPPED:

        break;

    case FSM_STATE_SERVICE:

        break;

    default:
        Global_CurrentState = FSM_STATE_IDLE;
        break;
    }

    return E_OK;
}

Tank_State_t FSM_GetState(void)
{
    return Global_CurrentState;
}

STD_ReturnType FSM_Ack(void)
{

    if (INT_IsSystemTripped() == 0)
    {
        Global_CurrentState = FSM_STATE_IDLE;
        return E_OK;
    }

    return E_NOK;
}
