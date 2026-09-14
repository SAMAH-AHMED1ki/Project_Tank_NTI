# 0 "Logic/tank_fsm/tank_fsm.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/tank_fsm/tank_fsm.c"





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
# 7 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 8 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "HAL/Pump/Pump_interface.h" 1





STD_ReturnType PMP_Init(void);
STD_ReturnType PMP_Set(uint8 Copy_u8State);
STD_ReturnType PMP_GetState(uint8 *Copy_pu8State);
STD_ReturnType PMP_RunSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_TotalSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_Cycles(uint32 *Copy_pu32Cycles);
STD_ReturnType PMP_Update1s(void);
# 9 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "HAL/Valve/Valve_interface.h" 1





STD_ReturnType Valve_Init(void);
STD_ReturnType Valve_Set(uint8 Copy_u8State);
STD_ReturnType Valve_GetState(uint8 *Copy_pu8State);
# 10 "Logic/tank_fsm/tank_fsm.c" 2
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
# 11 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "Logic/demand/demand.h" 1




# 1 "Logic/interlocks/tank_types.h" 1
# 6 "Logic/demand/demand.h" 2

STD_ReturnType DEM_Init(void);
STD_ReturnType DEM_Update(const TankData_t *Copy_pstData);
uint8 DEM_GetPumpDemand(void);
# 12 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "Logic/tank_fsm/tank_fsm.h" 1
# 13 "Logic/tank_fsm/tank_fsm.h"
STD_ReturnType FSM_Init(void);


STD_ReturnType FSM_Run(const TankData_t *Copy_pstData);


TankState_t FSM_GetState(void);


STD_ReturnType FSM_Ack(void);
# 13 "Logic/tank_fsm/tank_fsm.c" 2

static TankState_t Global_eCurrentState = ST_INIT;

STD_ReturnType FSM_Init(void)
{
    STD_ReturnType Local_Status;

    Global_eCurrentState = ST_INIT;

    Local_Status = PMP_Set(0u);
    if (Local_Status != E_OK)
    {
        return Local_Status;
    }

    Local_Status = Valve_Set(0u);
    if (Local_Status != E_OK)
    {
        return Local_Status;
    }

    return E_OK;
}

STD_ReturnType FSM_Run(const TankData_t *Copy_pstData)
{
    Trip_t Local_eTrip;

    if (Copy_pstData == ((void *)0))
    {
        return E_NOK;
    }




    Local_eTrip = ILK_Evaluate(Copy_pstData);

    if (Local_eTrip != TRIP_NONE)
    {
        PMP_Set(0u);
        Valve_Set(0u);

        Global_eCurrentState = ST_TRIPPED;

        return E_OK;
    }

    switch (Global_eCurrentState)
    {
    case ST_INIT:

        PMP_Set(0u);
        Valve_Set(0u);

        Global_eCurrentState = ST_IDLE;

        break;

    case ST_IDLE:

        PMP_Set(0u);
        Valve_Set(0u);

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
            PMP_Set(0u);
            Valve_Set(0u);

            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }
        else if (DEM_GetPumpDemand() == 0u)
        {
            PMP_Set(0u);
            Valve_Set(0u);

            Global_eCurrentState = ST_SETTLING;
        }
        else
        {
            PMP_Set(1u);
            Valve_Set(1u);
        }

        break;

    case ST_SETTLING:

        PMP_Set(0u);
        Valve_Set(0u);






        Global_eCurrentState = ST_IDLE;

        break;

    case ST_RESERVOIR_WAIT:

        PMP_Set(0u);
        Valve_Set(0u);

        if (Copy_pstData->reservoirPct >= 25u)
        {
            Global_eCurrentState = ST_IDLE;
        }

        break;

    case ST_TRIPPED:

        PMP_Set(0u);
        Valve_Set(0u);






        break;

    case ST_MANUAL:






        break;

    case ST_SERVICE:

        PMP_Set(0u);
        Valve_Set(0u);

        break;

    default:

        PMP_Set(0u);
        Valve_Set(0u);

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




    return ILK_Reset();
}
