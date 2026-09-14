# 0 "HAL/floats/floats.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/floats/floats.c"





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
# 7 "HAL/floats/floats.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 8 "HAL/floats/floats.c" 2
# 1 "HAL/floats/floats.h" 1
# 11 "HAL/floats/floats.h"
STD_ReturnType FLT_Init(void);
STD_ReturnType FLT_Update(void);
uint8 FLT_IsHighActive(void);
uint8 FLT_IsLowActive(void);
# 9 "HAL/floats/floats.c" 2
# 17 "HAL/floats/floats.c"
static uint8 Global_u8HighState = 0;
static uint8 Global_u8LowState = 0;

STD_ReturnType FLT_Init(void)
{
    STD_ReturnType Local_Status = E_OK;


    Local_Status &= GPIO_SetPinDirection(0u, 0u, 2u);
    Local_Status &= GPIO_SetPinDirection(0u, 1u, 2u);

    Global_u8HighState = 0;
    Global_u8LowState = 0;

    return Local_Status;
}

STD_ReturnType FLT_Update(void)
{
    uint8 Local_u8PinHighVal = 0;
    uint8 Local_u8PinLowVal = 0;
    STD_ReturnType Local_Status = E_OK;


    Local_Status |= GPIO_GetPinValue(0u, 0u, &Local_u8PinHighVal);
    Local_Status |= GPIO_GetPinValue(0u, 1u, &Local_u8PinLowVal);

    if (Local_Status == E_OK)
    {
        Global_u8HighState = Local_u8PinHighVal;
        Global_u8LowState = Local_u8PinLowVal;
    }

    return Local_Status;
}

uint8 FLT_IsHighActive(void)
{
    return Global_u8HighState;
}

uint8 FLT_IsLowActive(void)
{
    return Global_u8LowState;
}
