# 0 "HAL/Pump/Pump.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Pump/Pump.c"
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
# 2 "HAL/Pump/Pump.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "HAL/Pump/Pump.c" 2
# 1 "HAL/Pump/Pump_interface.h" 1





STD_ReturnType Pump_Init(void);
STD_ReturnType Pump_Set(uint8 Copy_u8State);
STD_ReturnType Pump_GetState(uint8 *Copy_pu8State);
STD_ReturnType Pump_GetRunSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType Pump_GetCycles(uint32 *Copy_pu32Cycles);
STD_ReturnType Pump_Update1s(void);
# 4 "HAL/Pump/Pump.c" 2




static uint8 Pump_u8State = 0u;
static uint32 Pump_u32RunSeconds = 0UL;
static uint32 Pump_u32Cycles = 0UL;

STD_ReturnType Pump_Init(void)
{
 STD_ReturnType Local_xError;

 Local_xError = GPIO_SetPinDirection(1u, 0u, 1u);
 if (Local_xError != E_OK)
 {
  return Local_xError;
 }

 Local_xError = GPIO_SetPinValue(1u, 0u, 0u);
 if (Local_xError == E_OK)
 {
  Pump_u8State = 0u;
  Pump_u32RunSeconds = 0UL;
  Pump_u32Cycles = 0UL;
 }

 return Local_xError;
}

STD_ReturnType Pump_Set(uint8 Copy_u8State)
{
 STD_ReturnType Local_xError;

 if ((Copy_u8State != 0u) && (Copy_u8State != 1u))
 {
  return E_NOK;
 }

 Local_xError = GPIO_SetPinValue(1u, 0u, Copy_u8State);
 if (Local_xError != E_OK)
 {
  return Local_xError;
 }

 if ((Pump_u8State == 0u) && (Copy_u8State == 1u))
 {
  Pump_u32Cycles++;
 }

 Pump_u8State = Copy_u8State;
 return E_OK;
}

STD_ReturnType Pump_GetState(uint8 *Copy_pu8State)
{
 if (Copy_pu8State == ((void *)0))
 {
  return E_NOK;
 }

 *Copy_pu8State = Pump_u8State;
 return E_OK;
}

STD_ReturnType Pump_GetRunSeconds(uint32 *Copy_pu32Seconds)
{
 if (Copy_pu32Seconds == ((void *)0))
 {
  return E_NOK;
 }

 *Copy_pu32Seconds = Pump_u32RunSeconds;
 return E_OK;
}

STD_ReturnType Pump_GetCycles(uint32 *Copy_pu32Cycles)
{
 if (Copy_pu32Cycles == ((void *)0))
 {
  return E_NOK;
 }

 *Copy_pu32Cycles = Pump_u32Cycles;
 return E_OK;
}

STD_ReturnType Pump_Update1s(void)
{
 if (Pump_u8State == 1u)
 {
  Pump_u32RunSeconds++;
 }

 return E_OK;
}
