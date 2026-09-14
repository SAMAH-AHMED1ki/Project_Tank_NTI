# 0 "HAL/Bargraph/bargraph.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Bargraph/bargraph.c"
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
# 2 "HAL/Bargraph/bargraph.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "HAL/Bargraph/bargraph.c" 2
# 1 "HAL/Bargraph/BARGRAPH_interface.h" 1
# 13 "HAL/Bargraph/BARGRAPH_interface.h"
STD_ReturnType BARGRAPH_Init(uint8 port);

STD_ReturnType BARGRAPH_SetLevel(uint8 port, uint8 levelPercent);

STD_ReturnType BARGRAPH_Off(uint8 port);
# 4 "HAL/Bargraph/bargraph.c" 2

STD_ReturnType BARGRAPH_Init(uint8 port)
{
    STD_ReturnType status = E_OK;


    status |= GPIO_SetPinDirection(port, 2u, 1u);
    status |= GPIO_SetPinDirection(port, 3u, 1u);
    status |= GPIO_SetPinDirection(port, 4u, 1u);
    status |= GPIO_SetPinDirection(port, 5u, 1u);


    status |= BARGRAPH_Off(port);

    return status;
}

STD_ReturnType BARGRAPH_SetLevel(uint8 port, uint8 levelPercent)
{
    STD_ReturnType status = E_OK;

    if (levelPercent > 100u)
    {
        return E_NOK;
    }


    uint8 led0State = (levelPercent >= 25u) ? 1u : 0u;
    uint8 led1State = (levelPercent >= 50u) ? 1u : 0u;
    uint8 led2State = (levelPercent >= 75u) ? 1u : 0u;
    uint8 led3State = (levelPercent == 100u) ? 1u : 0u;

    status |= GPIO_SetPinValue(port, 2u, led0State);
    status |= GPIO_SetPinValue(port, 3u, led1State);
    status |= GPIO_SetPinValue(port, 4u, led2State);
    status |= GPIO_SetPinValue(port, 5u, led3State);

    return status;
}

STD_ReturnType BARGRAPH_Off(uint8 port)
{
    STD_ReturnType status = E_OK;

    status |= GPIO_SetPinValue(port, 2u, 0u);
    status |= GPIO_SetPinValue(port, 3u, 0u);
    status |= GPIO_SetPinValue(port, 4u, 0u);
    status |= GPIO_SetPinValue(port, 5u, 0u);

    return status;
}
