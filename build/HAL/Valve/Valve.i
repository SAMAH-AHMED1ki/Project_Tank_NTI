# 0 "HAL/Valve/Valve.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Valve/Valve.c"
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
# 2 "HAL/Valve/Valve.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "HAL/Valve/Valve.c" 2
# 1 "HAL/Valve/Valve_interface.h" 1





STD_ReturnType Valve_Init(void);
STD_ReturnType Valve_Set(uint8 Copy_u8State);
STD_ReturnType Valve_GetState(uint8 *Copy_pu8State);
# 4 "HAL/Valve/Valve.c" 2




static uint8 Valve_u8State = 0u;

STD_ReturnType Valve_Init(void)
{
 STD_ReturnType Local_xError;

 Local_xError = GPIO_SetPinDirection(1u, 2u, 1u);
 if (Local_xError != E_OK)
 {
  return Local_xError;
 }

 Local_xError = GPIO_SetPinValue(1u, 2u, 0u);
 if (Local_xError == E_OK)
 {
  Valve_u8State = 0u;
 }

 return Local_xError;
}

STD_ReturnType Valve_Set(uint8 Copy_u8State)
{
 STD_ReturnType Local_xError;

 if ((Copy_u8State != 0u) && (Copy_u8State != 1u))
 {
  return E_NOK;
 }

 Local_xError = GPIO_SetPinValue(1u, 2u, Copy_u8State);
 if (Local_xError == E_OK)
 {
  Valve_u8State = Copy_u8State;
 }

 return Local_xError;
}

STD_ReturnType Valve_GetState(uint8 *Copy_pu8State)
{
 if (Copy_pu8State == ((void *)0))
 {
  return E_NOK;
 }

 *Copy_pu8State = Valve_u8State;
 return E_OK;
}
