#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "SPI_interface.h"
#include "Shiftreg_interface.h"

/* 74HC595 Latch pin */
#define SHIFTREG_LATCH_PORT GPIO_PORTB
#define SHIFTREG_LATCH_PIN GPIO_PIN4

STD_ReturnType SHIFTREG_Init(void)
{
    STD_ReturnType Local_u8ErrorState = E_OK;

    /* Configure Latch pin as output */
    Local_u8ErrorState =
        GPIO_SetPinDirection(
            SHIFTREG_LATCH_PORT,
            SHIFTREG_LATCH_PIN,
            GPIO_OUTPUT);

    /* Initial latch state */
    if (Local_u8ErrorState == E_OK)
    {
        Local_u8ErrorState =
            GPIO_SetPinValue(
                SHIFTREG_LATCH_PORT,
                SHIFTREG_LATCH_PIN,
                GPIO_LOW);
    }

    return Local_u8ErrorState;
}

STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data)
{
    STD_ReturnType Local_u8ErrorState = E_OK;
    uint8 Local_u8ReceivedData = 0u;

    /*
     * Send data through SPI.
     * The received byte is not important here.
     */
    Local_u8ErrorState =
        SPI_Transceive(
            Copy_u8Data,
            &Local_u8ReceivedData);

    if (Local_u8ErrorState == E_OK)
    {
        /* Generate latch pulse */
        GPIO_SetPinValue(
            SHIFTREG_LATCH_PORT,
            SHIFTREG_LATCH_PIN,
            GPIO_HIGH);

        GPIO_SetPinValue(
            SHIFTREG_LATCH_PORT,
            SHIFTREG_LATCH_PIN,
            GPIO_LOW);
    }

    return Local_u8ErrorState;
}