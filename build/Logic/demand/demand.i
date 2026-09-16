# 0 "Logic/demand/demand.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/demand/demand.c"





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
# 7 "Logic/demand/demand.c" 2
# 1 "Logic/demand/demand.h" 1




# 1 "Logic/interlocks/tank_types.h" 1



# 1 "LIB/DATA.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/DATA.h" 2

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
    uint8 trip;
    uint32 timeSec;
    uint8 levelPct;
    uint8 reservoirPct;
    uint16 currentmA;
} FaultRec_t;




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
    uint8 levelRatePctMin;
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
# 5 "Logic/interlocks/tank_types.h" 2
# 6 "Logic/demand/demand.h" 2

STD_ReturnType DEM_Init(void);
STD_ReturnType DEM_Update(const TankData_t *Copy_pstData);
uint8 DEM_GetPumpDemand(void);
# 8 "Logic/demand/demand.c" 2




static uint8 Global_u8PumpDemand = 0u;

STD_ReturnType DEM_Init(void)
{
    Global_u8PumpDemand = 0u;

    return E_OK;
}

STD_ReturnType DEM_Update(const TankData_t *Copy_pstData)
{
    if (Copy_pstData == ((void *)0))
    {
        return E_NOK;
    }




    if (Copy_pstData->levelPct < 30u)
    {
        Global_u8PumpDemand = 1u;
    }




    else if (Copy_pstData->levelPct > 90u)
    {
        Global_u8PumpDemand = 0u;
    }






    return E_OK;
}

uint8 DEM_GetPumpDemand(void)
{
    return Global_u8PumpDemand;
}
