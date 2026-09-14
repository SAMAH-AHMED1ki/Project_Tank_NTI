# 0 "Logic/Flowmeter/Flowmeter.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/Flowmeter/Flowmeter.c"
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
# 2 "Logic/Flowmeter/Flowmeter.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "Logic/Flowmeter/Flowmeter.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 29 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 73 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);







STD_ReturnType TIMER1_ExternalCounterInit(void);




uint16 TIMER1_GetCounter(void);




STD_ReturnType TIMER1_ResetCounter(void);
# 4 "Logic/Flowmeter/Flowmeter.c" 2
# 1 "Logic/Flowmeter/Flowmeter_interface.h" 1
# 10 "Logic/Flowmeter/Flowmeter_interface.h"
STD_ReturnType FLOWMETER_Init(void);


STD_ReturnType FLOWMETER_StartMeasurement(void);


STD_ReturnType FLOWMETER_GetPulseCount(uint16 *Copy_pu16PulseCount);


STD_ReturnType FLOWMETER_GetLiters(uint16 *Copy_pu16Liters);


STD_ReturnType FLOWMETER_ResetMeasurement(void);
# 5 "Logic/Flowmeter/Flowmeter.c" 2







STD_ReturnType FLOWMETER_Init(void)
{
    STD_ReturnType Local_u8ErrorState = E_OK;




    Local_u8ErrorState =
        GPIO_SetPinDirection(1u, 1u, 0u);




    if (Local_u8ErrorState == E_OK)
    {
        Local_u8ErrorState = TIMER1_ExternalCounterInit();
    }

    return Local_u8ErrorState;
}






STD_ReturnType FLOWMETER_StartMeasurement(void)
{
    STD_ReturnType Local_u8ErrorState;

    Local_u8ErrorState = TIMER1_ResetCounter();

    return Local_u8ErrorState;
}




uint16 FLOWMETER_GetPulses(void)
{
    uint16 Local_u16Pulses;

    Local_u16Pulses = TIMER1_GetCounter();

    return Local_u16Pulses;
}
# 67 "Logic/Flowmeter/Flowmeter.c"
uint16 FLOWMETER_GetMilliliters(void)
{
    uint16 Local_u16Pulses;
    uint32 Local_u32Milliliters;

    Local_u16Pulses = FLOWMETER_GetPulses();

    Local_u32Milliliters =
        ((uint32)Local_u16Pulses * 1000UL) / 450UL;

    return (uint16)Local_u32Milliliters;
}




STD_ReturnType FLOWMETER_ResetMeasurement(void)
{
    return TIMER1_ResetCounter();
}
