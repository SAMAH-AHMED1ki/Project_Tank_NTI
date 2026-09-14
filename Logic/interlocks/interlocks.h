#ifndef INTERLOCKS_H_
#define INTERLOCKS_H_

#include "STD_TYPES.h"
#include "tank_types.h"

STD_ReturnType INT_Init(void);

/*
 * Must be called every 10 ms.
 *
 * Evaluates all safety interlocks according to the
 * fixed priority defined by the project specification.
 *
 * Returns the currently latched trip, or TRIP_NONE.
 */
Trip_t ILK_Evaluate(const TankData_t *Copy_pstData);

/*
 * Requests clearing of the currently latched trip.
 *
 * The trip is cleared only when its own clear condition
 * is satisfied.
 */
STD_ReturnType ILK_Reset(void);

#endif