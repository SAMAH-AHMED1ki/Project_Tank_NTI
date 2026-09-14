# 0 "Logic/interlocks/interlocks.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/interlocks/interlocks.c"





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
# 7 "Logic/interlocks/interlocks.c" 2
# 1 "HAL/current/current.h" 1
# 12 "HAL/current/current.h"
STD_ReturnType CUR_Init(void);
STD_ReturnType CUR_Update(void);
STD_ReturnType CUR_GetmA(uint16 *Copy_pu16CurrentmA);
uint8 CUR_IsOverLimit(uint16 Copy_u16LimitmA);
# 8 "Logic/interlocks/interlocks.c" 2
# 1 "HAL/floats/floats.h" 1
# 11 "HAL/floats/floats.h"
STD_ReturnType FLT_Init(void);
STD_ReturnType FLT_Update(void);
uint8 FLT_IsHighActive(void);
uint8 FLT_IsLowActive(void);
# 9 "Logic/interlocks/interlocks.c" 2
# 1 "Logic/interlocks/interlocks.h" 1
# 12 "Logic/interlocks/interlocks.h"
STD_ReturnType INT_Init(void);


STD_ReturnType INT_Update(void);


uint8 INT_IsSystemTripped(void);
# 10 "Logic/interlocks/interlocks.c" 2


static uint8 Global_u8TripStatus = 0;

STD_ReturnType INT_Init(void)
{
    Global_u8TripStatus = 0;
    return E_OK;
}

STD_ReturnType INT_Update(void)
{

    if (CUR_IsOverLimit(8000) == 1)
    {
        Global_u8TripStatus = 1;
    }
    else
    {

        Global_u8TripStatus = 0;
    }

    return E_OK;
}

uint8 INT_IsSystemTripped(void)
{
    return Global_u8TripStatus;
}
