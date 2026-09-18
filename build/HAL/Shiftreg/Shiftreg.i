# 0 "HAL/Shiftreg/Shiftreg.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/Shiftreg/Shiftreg.c"
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
# 2 "HAL/Shiftreg/Shiftreg.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 3 "HAL/Shiftreg/Shiftreg.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 4 "HAL/Shiftreg/Shiftreg.c" 2
# 1 "HAL/Shiftreg/Shiftreg_interface.h" 1






STD_ReturnType SHIFTREG_Init(void);


STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data);
# 5 "HAL/Shiftreg/Shiftreg.c" 2





STD_ReturnType SHIFTREG_Init(void)
{
    STD_ReturnType Local_u8ErrorState = E_OK;


    Local_u8ErrorState =
        GPIO_SetPinDirection(
            1u,
            4u,
            1u);


    if (Local_u8ErrorState == E_OK)
    {
        Local_u8ErrorState =
            GPIO_SetPinValue(
                1u,
                4u,
                0u);
    }

    return Local_u8ErrorState;
}

STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data)
{
    STD_ReturnType Local_u8ErrorState = E_OK;
    uint8 Local_u8ReceivedData = 0u;





    Local_u8ErrorState =
        SPI_Transceive(
            Copy_u8Data,
            &Local_u8ReceivedData);

    if (Local_u8ErrorState == E_OK)
    {

        GPIO_SetPinValue(
            1u,
            4u,
            1u);

        GPIO_SetPinValue(
            1u,
            4u,
            0u);
    }

    return Local_u8ErrorState;
}
