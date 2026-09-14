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
# 1 "HAL/level/level_interface.h" 1
# 8 "Logic/demand/demand.c" 2
# 1 "HAL/floats/floats.h" 1
# 11 "HAL/floats/floats.h"
STD_ReturnType FLT_Init(void);
STD_ReturnType FLT_Update(void);
uint8 FLT_IsHighActive(void);
uint8 FLT_IsLowActive(void);
# 9 "Logic/demand/demand.c" 2
# 1 "Logic/interlocks/interlocks.h" 1
# 12 "Logic/interlocks/interlocks.h"
STD_ReturnType INT_Init(void);


STD_ReturnType INT_Update(void);


uint8 INT_IsSystemTripped(void);
# 10 "Logic/demand/demand.c" 2
# 1 "Logic/demand/demand.h" 1
# 12 "Logic/demand/demand.h"
STD_ReturnType DEM_Init(void);


STD_ReturnType DEM_Update(void);


uint8 DEM_GetPumpDemand(void);
# 11 "Logic/demand/demand.c" 2

static uint8 Global_u8PumpDemand = 0;

STD_ReturnType DEM_Init(void)
{
    Global_u8PumpDemand = 0;
    return E_OK;
}

STD_ReturnType DEM_Update(void)
{

    if (INT_IsSystemTripped() == 1)
    {
        Global_u8PumpDemand = 0;
        return E_OK;
    }



    if (FLT_IsLowActive() == 1)
    {
        Global_u8PumpDemand = 1;
    }
    else if (FLT_IsHighActive() == 1)
    {
        Global_u8PumpDemand = 0;
    }

    return E_OK;
}

uint8 DEM_GetPumpDemand(void)
{
    return Global_u8PumpDemand;
}
