#ifndef DATA_H
#define DATA_H

#include "STD_TYPES.h"

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
    uint8  trip;
    uint32 timeSec;
    uint8  levelPct;
    uint8  reservoirPct;
    uint16 currentmA;
} FaultRec_t;

#define TNK_MAGIC   0x5754u
#define TNK_VERSION 0x01u

typedef struct
{
    uint16 magic;
    uint8  version;
    uint8  startPct;
    uint8  stopPct;
    uint8  reserveMinPct;
    uint8  overflowPct;
    uint8  overCurrentA_X10;
    uint8  minCurrentA_X10;
    uint8  minFlowLpm;
    uint16 maxRunSec;
    uint16 minOffSec;
    uint8  leakDropPct;
    uint32 totalLitres;
    uint32 pumpTotalSec;
    uint16 pumpCycles;
    uint8  faultHead;
    uint8  checksum;
} TankCfg_t;

typedef struct
{
    uint16 levelRaw;
    uint16 reservoirRaw;
    uint16 currentRaw;
    uint8  levelPct;
    uint8  reservoirPct;
    uint16 currentmA;
    uint16 flowLpmX10;
    uint32 totalLitres;
    uint8   levelRatePctMin;
    uint8  pumpOn    : 1;
    uint8  valveOn   : 1;
    uint8  highFloat : 1;
    uint8  lowFloat  : 1;
    uint8  reserved  : 4;
    uint8  state;
    uint8  activeTrip;
    uint16 pumpRunSec;
    uint32 pumpTotalSec;
    uint16 pumpCycles;
    uint32 upTimeSec;
} TankData_t;

#endif