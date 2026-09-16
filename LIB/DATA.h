#ifndef DATA_H
#define DATA_H

#include "STD_TYPES.h"
#include "tank_types.h"

typedef struct
{
    uint8 trip;
    uint32 timeSec;
    uint8 levelPct;
    uint8 reservoirPct;
    uint16 currentmA;
} FaultRec_t;

#endif