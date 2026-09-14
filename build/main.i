# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"
# 72 "main.c"
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
# 73 "main.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 74 "main.c" 2
# 1 "HAL/Shiftreg/Shiftreg_interface.h" 1






STD_ReturnType SHIFTREG_Init(void);


STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data);
# 75 "main.c" 2
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
# 76 "main.c" 2
# 1 "Logic/Flowmeter/Flowmeter_interface.h" 1
# 11 "Logic/Flowmeter/Flowmeter_interface.h"
STD_ReturnType FLOWMETER_Init(void);







STD_ReturnType FLOWMETER_Update1Hz(void);


uint16 FLOWMETER_GetPulsesPerSec(void);


uint16 FLOWMETER_GetFlowLpmX10(void);




uint32 FLOWMETER_GetTotalMilliliters(void);





STD_ReturnType FLOWMETER_ResetTotaliser(void);
# 77 "main.c" 2



int main(void)
{
    uint8 Local_u8SecInPhase = 0u;
    uint8 Local_u8Phase = 0u;
    uint16 Local_u16Value16;
    uint32 Local_u32Value32;

    SPI_InitMaster(1u);
    SHIFTREG_Init();
    TIMER0_Init();
    FLOWMETER_Init();


    SHIFTREG_SendByte(0xFFu);
    TIMER0_DelayS(1);
    SHIFTREG_SendByte(0x00u);
    TIMER0_DelayS(1);


    while (1)
    {
        TIMER0_DelayS(1);
        FLOWMETER_Update1Hz();

        switch (Local_u8Phase)
        {
        case 0:
            Local_u16Value16 = FLOWMETER_GetPulsesPerSec();
            SHIFTREG_SendByte((uint8)Local_u16Value16);
            break;

        case 1:
            Local_u16Value16 = FLOWMETER_GetFlowLpmX10();
            SHIFTREG_SendByte((uint8)Local_u16Value16);
            break;

        case 2:
        default:
            Local_u32Value32 = FLOWMETER_GetTotalMilliliters();
            SHIFTREG_SendByte((uint8)Local_u32Value32);
            break;
        }

        Local_u8SecInPhase++;
        if (Local_u8SecInPhase >= 3u)
        {
            Local_u8SecInPhase = 0u;
            Local_u8Phase++;
            if (Local_u8Phase >= 3u)
            {
                Local_u8Phase = 0u;
            }
        }
    }

    return 0;
}
