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
# 12 "Logic/interlocks/interlocks.h"
STD_ReturnType INT_Init(void);


STD_ReturnType INT_Update(void);


uint8 INT_IsSystemTripped(void);
# 8 "Logic/tank_fsm/tamk_fsm.c" 2
# 1 "Logic/demand/demand.h" 1
# 12 "Logic/demand/demand.h"
STD_ReturnType DEM_Init(void);


STD_ReturnType DEM_Update(void);


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
