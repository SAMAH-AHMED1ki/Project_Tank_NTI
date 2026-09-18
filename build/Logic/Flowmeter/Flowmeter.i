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
# 11 "Logic/Flowmeter/Flowmeter_interface.h"
STD_ReturnType FLOWMETER_Init(void);







STD_ReturnType FLOWMETER_Update1Hz(void);


uint16 FLOWMETER_GetPulsesPerSec(void);


uint16 FLOWMETER_GetFlowLpmX10(void);




uint32 FLOWMETER_GetTotalMilliliters(void);





STD_ReturnType FLOWMETER_ResetTotaliser(void);
# 5 "Logic/Flowmeter/Flowmeter.c" 2

static uint16 g_lastCount = 0u;
static uint16 g_pulsesLastSecond = 0u;
static uint32 g_totalPulses = 0u;

STD_ReturnType FLOWMETER_Init(void)
{
    STD_ReturnType Local_u8ErrorState;

    Local_u8ErrorState =
        GPIO_SetPinDirection(1u, 1u, 0u);

    if (Local_u8ErrorState == E_OK)
    {
        Local_u8ErrorState = TIMER1_ExternalCounterInit();
    }



    g_lastCount = 0u;
    g_pulsesLastSecond = 0u;
    g_totalPulses = 0u;

    return Local_u8ErrorState;
}

STD_ReturnType FLOWMETER_Update1Hz(void)
{
    uint16 Local_u16Now;
    uint16 Local_u16Diff;

    Local_u16Now = TIMER1_GetCounter();



    Local_u16Diff = (uint16)(Local_u16Now - g_lastCount);
    g_lastCount = Local_u16Now;

    g_pulsesLastSecond = Local_u16Diff;
    g_totalPulses += Local_u16Diff;

    return E_OK;
}

uint16 FLOWMETER_GetPulsesPerSec(void)
{
    return g_pulsesLastSecond;
}

uint16 FLOWMETER_GetFlowLpmX10(void)
{

    return (uint16)(((uint32)g_pulsesLastSecond * 4UL) / 3UL);
}

uint32 FLOWMETER_GetTotalMilliliters(void)
{
    return (uint32)((g_totalPulses * 1000UL) / 450UL);
}

STD_ReturnType FLOWMETER_ResetTotaliser(void)
{
    g_totalPulses = 0u;
    return E_OK;
}
