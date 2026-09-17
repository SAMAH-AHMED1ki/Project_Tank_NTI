/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Tank Finite State Machine - Header
 */

#ifndef TANK_FSM_H_
#define TANK_FSM_H_

#include "STD_TYPES.h"
#include "tank_types.h"

/* Initialize the FSM */
STD_ReturnType FSM_Init(void);

/* Run one FSM cycle */
STD_ReturnType FSM_Run(const TankData_t *Copy_pstData);

/* Get current FSM state */
TankState_t FSM_GetState(void);

/* Request acknowledgement of a latched trip */
STD_ReturnType FSM_Ack(void);

/* Check whether the trip buzzer should be active */
uint8 FSM_IsBuzzerEnabled(void);
#endif /* TANK_FSM_H_ */

Trip_t FSM_GetActiveTrip(void);