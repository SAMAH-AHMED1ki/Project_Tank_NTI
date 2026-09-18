/*
 * Author: Doaa Shaker Mohamed Aziz Awad
 * Module: Fault log ring buffer - Header
 */

#ifndef FAULTLOG_H_
#define FAULTLOG_H_

#include "STD_TYPES.h"
#include "DATA.h"

#define FLG_MAX_ENTRIES 16U

typedef struct
{
    FaultRec_t entries[FLG_MAX_ENTRIES];
    uint8 head;  /* next write position */
    uint8 tail;  /* oldest valid entry */
    uint8 count; /* valid entries */
} FLG_Buffer_t;

/* Initializes the ring to empty. */
void FLG_Init(FLG_Buffer_t *pLog);

/* Appends one fault record. If full, the oldest record is overwritten. */
STD_ReturnType FLG_Append(FLG_Buffer_t *pLog, const FaultRec_t *pRecord);

/* Returns the number of valid entries currently stored. */
uint8 FLG_GetCount(const FLG_Buffer_t *pLog);

/* Returns TRUE if all 16 slots are in use. */
uint8 FLG_IsFull(const FLG_Buffer_t *pLog);

/* Returns the record offset from newest, where 0 means newest. */
STD_ReturnType FLG_GetNewestFirst(const FLG_Buffer_t *pLog,
                                 uint8 offsetFromNewest,
                                 FaultRec_t *pRecord);

/* Clears all entries in the log. */
void FLG_Clear(FLG_Buffer_t *pLog);

/*
 * Dumps the fault history as ASCII lines in README format:
 * FLT,n,trip,timeSec,L,R,I\r\n
 * newest-first, one line per record.
 * This is the README-facing public name for the dump API.
 */
void FLG_Dump(const FLG_Buffer_t *pLog, void (*WriteChar)(char));

#endif /* FAULTLOG_H_ */
