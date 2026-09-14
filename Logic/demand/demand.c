/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Application Pump Demand Logic
 */

#include "STD_TYPES.h"
#include "demand.h"

#define DEM_START_LEVEL_PCT 30u
#define DEM_STOP_LEVEL_PCT 90u

static uint8 Global_u8PumpDemand = 0u;

STD_ReturnType DEM_Init(void)
{
    Global_u8PumpDemand = 0u;

    return E_OK;
}

STD_ReturnType DEM_Update(const TankData_t *Copy_pstData)
{
    if (Copy_pstData == NULL)
    {
        return E_NOK;
    }

    /*
     * Start filling below 30%
     */
    if (Copy_pstData->levelPct < DEM_START_LEVEL_PCT)
    {
        Global_u8PumpDemand = 1u;
    }

    /*
     * Stop filling above 90%
     */
    else if (Copy_pstData->levelPct > DEM_STOP_LEVEL_PCT)
    {
        Global_u8PumpDemand = 0u;
    }

    /*
     * Between 30% and 90%:
     * keep the previous demand.
     */

    return E_OK;
}

uint8 DEM_GetPumpDemand(void)
{
    return Global_u8PumpDemand;
}