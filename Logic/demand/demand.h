#ifndef DEMAND_H_
#define DEMAND_H_

#include "STD_TYPES.h"
#include "tank_types.h"

STD_ReturnType DEM_Init(void);
STD_ReturnType DEM_Update(const TankData_t *Copy_pstData);
uint8 DEM_GetPumpDemand(void);

#endif /* DEMAND_H_ */