/*
 * Author: Doaa Shaker Mohamed Aziz Awad
 * Module: Fault log ring buffer
 */

#include "faultlog.h"

static uint8 FLG_NextIndex(uint8 index)
{
    index++;
    if (index >= FLG_MAX_ENTRIES)
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

    if (WriteChar == NULL)
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
    if ((pRecord == NULL) || (WriteChar == NULL))
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

    if (pLog == NULL)
    {
        return;
    }

    for (i = 0U; i < FLG_MAX_ENTRIES; i++)
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
    if ((pLog == NULL) || (pRecord == NULL))
    {
        return E_NOK;
    }

    if (pLog->count >= FLG_MAX_ENTRIES)
    {
        /* The newest record overwrites the oldest record in-place. Advance the
         * oldest index as the ring wraps so the log remains newest-first. */
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
    if (pLog == NULL)
    {
        return 0U;
    }

    return pLog->count;
}

uint8 FLG_IsFull(const FLG_Buffer_t *pLog)
{
    if (pLog == NULL)
    {
        return 0U;
    }

    return (pLog->count >= FLG_MAX_ENTRIES) ? 1U : 0U;
}

STD_ReturnType FLG_GetNewestFirst(const FLG_Buffer_t *pLog,
                                 uint8 offsetFromNewest,
                                 FaultRec_t *pRecord)
{
    uint8 index;

    if ((pLog == NULL) || (pRecord == NULL))
    {
        return E_NOK;
    }

    if (offsetFromNewest >= pLog->count)
    {
        return E_NOK;
    }

    index = (pLog->head + FLG_MAX_ENTRIES - 1U - offsetFromNewest) % FLG_MAX_ENTRIES;
    *pRecord = pLog->entries[index];
    return E_OK;
}

void FLG_Clear(FLG_Buffer_t *pLog)
{
    if (pLog == NULL)
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

    if ((pLog == NULL) || (WriteChar == NULL))
    {
        return;
    }

    if (pLog->count == 0U)
    {
        return;
    }

    for (i = 0U; i < pLog->count; i++)
    {
        index = (pLog->head + FLG_MAX_ENTRIES - 1U - i) % FLG_MAX_ENTRIES;
        record = pLog->entries[index];
        FLG_WriteFaultLine(&record, i, WriteChar);
    }
}
