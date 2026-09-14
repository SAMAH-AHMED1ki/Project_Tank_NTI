# 0 "Logic/FaultLog/faultlog.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/FaultLog/faultlog.c"





# 1 "Logic/FaultLog/faultlog.h" 1
# 9 "Logic/FaultLog/faultlog.h"
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
# 10 "Logic/FaultLog/faultlog.h" 2
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
# 11 "Logic/FaultLog/faultlog.h" 2



typedef struct
{
    FaultRec_t entries[16U];
    uint8 head;
    uint8 tail;
    uint8 count;
} FLG_Buffer_t;


void FLG_Init(FLG_Buffer_t *pLog);


STD_ReturnType FLG_Append(FLG_Buffer_t *pLog, const FaultRec_t *pRecord);


uint8 FLG_GetCount(const FLG_Buffer_t *pLog);


uint8 FLG_IsFull(const FLG_Buffer_t *pLog);


STD_ReturnType FLG_GetNewestFirst(const FLG_Buffer_t *pLog,
                                 uint8 offsetFromNewest,
                                 FaultRec_t *pRecord);


void FLG_Clear(FLG_Buffer_t *pLog);







void FLG_Dump(const FLG_Buffer_t *pLog, void (*WriteChar)(char));
# 7 "Logic/FaultLog/faultlog.c" 2

static uint8 FLG_NextIndex(uint8 index)
{
    index++;
    if (index >= 16U)
    {
        index = 0U;
    }
    return index;
}

static void FLG_WriteUint32(uint32 value, void (*WriteChar)(char))
{
    uint8 digits[10];
    uint8 count = 0U;
    uint8 i;

    if (WriteChar == ((void *)0))
    {
        return;
    }

    if (value == 0U)
    {
        WriteChar('0');
        return;
    }

    while (value > 0U)
    {
        digits[count] = (uint8)(value % 10U);
        value /= 10U;
        count++;
    }

    for (i = 0U; i < count; i++)
    {
        uint8 digit = digits[count - 1U - i];
        WriteChar((char)('0' + digit));
    }
}

static void FLG_WriteUint16(uint16 value, void (*WriteChar)(char))
{
    FLG_WriteUint32((uint32)value, WriteChar);
}

static void FLG_WriteString(const char *str, void (*WriteChar)(char))
{
    while (*str != '\0')
    {
        WriteChar(*str);
        str++;
    }
}

static void FLG_WriteFaultLine(const FaultRec_t *pRecord,
                              uint8 index,
                              void (*WriteChar)(char))
{
    if ((pRecord == ((void *)0)) || (WriteChar == ((void *)0)))
    {
        return;
    }

    FLG_WriteString("FLT,", WriteChar);
    FLG_WriteUint16(index, WriteChar);
    WriteChar(',');
    FLG_WriteUint16((uint16)pRecord->trip, WriteChar);
    WriteChar(',');
    FLG_WriteUint32(pRecord->timeSec, WriteChar);
    WriteChar(',');
    FLG_WriteUint16(pRecord->levelPct, WriteChar);
    WriteChar(',');
    FLG_WriteUint16(pRecord->reservoirPct, WriteChar);
    WriteChar(',');
    FLG_WriteUint16(pRecord->currentmA, WriteChar);
    WriteChar('\r');
    WriteChar('\n');
}

void FLG_Init(FLG_Buffer_t *pLog)
{
    uint8 i;

    if (pLog == ((void *)0))
    {
        return;
    }

    for (i = 0U; i < 16U; i++)
    {
        pLog->entries[i].trip = TRIP_NONE;
        pLog->entries[i].timeSec = 0U;
        pLog->entries[i].levelPct = 0U;
        pLog->entries[i].reservoirPct = 0U;
        pLog->entries[i].currentmA = 0U;
    }

    pLog->head = 0U;
    pLog->tail = 0U;
    pLog->count = 0U;
}

STD_ReturnType FLG_Append(FLG_Buffer_t *pLog, const FaultRec_t *pRecord)
{
    if ((pLog == ((void *)0)) || (pRecord == ((void *)0)))
    {
        return E_NOK;
    }

    if (pLog->count >= 16U)
    {


        pLog->entries[pLog->head] = *pRecord;
        pLog->head = FLG_NextIndex(pLog->head);
        pLog->tail = FLG_NextIndex(pLog->tail);
        return E_OK;
    }

    pLog->entries[pLog->head] = *pRecord;
    pLog->head = FLG_NextIndex(pLog->head);
    pLog->count++;
    return E_OK;
}

uint8 FLG_GetCount(const FLG_Buffer_t *pLog)
{
    if (pLog == ((void *)0))
    {
        return 0U;
    }

    return pLog->count;
}

uint8 FLG_IsFull(const FLG_Buffer_t *pLog)
{
    if (pLog == ((void *)0))
    {
        return 0U;
    }

    return (pLog->count >= 16U) ? 1U : 0U;
}

STD_ReturnType FLG_GetNewestFirst(const FLG_Buffer_t *pLog,
                                 uint8 offsetFromNewest,
                                 FaultRec_t *pRecord)
{
    uint8 index;

    if ((pLog == ((void *)0)) || (pRecord == ((void *)0)))
    {
        return E_NOK;
    }

    if (offsetFromNewest >= pLog->count)
    {
        return E_NOK;
    }

    index = (pLog->head + 16U - 1U - offsetFromNewest) % 16U;
    *pRecord = pLog->entries[index];
    return E_OK;
}

void FLG_Clear(FLG_Buffer_t *pLog)
{
    if (pLog == ((void *)0))
    {
        return;
    }

    FLG_Init(pLog);
}

void FLG_Dump(const FLG_Buffer_t *pLog, void (*WriteChar)(char))
{
    uint8 i;
    uint8 index;
    FaultRec_t record;

    if ((pLog == ((void *)0)) || (WriteChar == ((void *)0)))
    {
        return;
    }

    if (pLog->count == 0U)
    {
        return;
    }

    for (i = 0U; i < pLog->count; i++)
    {
        index = (pLog->head + 16U - 1U - i) % 16U;
        record = pLog->entries[index];
        FLG_WriteFaultLine(&record, i, WriteChar);
    }
}
