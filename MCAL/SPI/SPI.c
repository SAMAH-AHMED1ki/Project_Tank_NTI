/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — SPI.c  (ATmega32, mode 0)
 * Implement every prototype from SPI_interface.h.
 */

#include "STD_TYPES.h"
#include "SPI_interface.h"
#include "SPI_private.h"
#include "GPIO_interface.h"

/* #include "GPIO_interface.h" */ /* use this for SS and the Port-B pin directions */

/*
 * SPI_InitMaster
 * 1. Reject prescaler > SPI_PRESC_128.
 * 2. SS / MOSI / SCK = output, MISO = input. Drive SS HIGH (idle).
 * 3. SPCR = SPE | MSTR | Copy_u8Prescaler.  (mode 0, MSB first)
 * 4. 8 MHz / 16 = 500 kHz SPI clock with SPI_PRESC_16.
 */
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler)
{
    if (Copy_u8Prescaler > SPI_PRESC_128)
    {
        return E_NOK;
    }

    DDRB |= (1u << SPI_SS_PIN);
    DDRB |= (1u << SPI_MOSI_PIN);
    DDRB &= ~(1u << SPI_MISO_PIN);
    DDRB |= (1u << SPI_SCK_PIN);

    PORTB |= (1u << SPI_SS_PIN);

    SPCR = (1u << SPE) | (1u << MSTR) | Copy_u8Prescaler;

    SPSR &= ~(1u << SPI2X);

    return E_OK;
}
/*
 * SPI_InitSlave
 * 1. MISO = output. MOSI, SCK, SS = input.
 * 2. SPCR = SPE only (MSTR = 0).
 */
STD_ReturnType SPI_InitSlave(void)
{
    DDRB &= ~(1u << SPI_SS_PIN);   /* PB4 -> Input */
    DDRB &= ~(1u << SPI_MOSI_PIN); /* PB5 -> Input */
    DDRB |= (1u << SPI_MISO_PIN);  /* PB6 -> Output */
    DDRB &= ~(1u << SPI_SCK_PIN);  /* PB7 -> Input */

    SPCR = (1u << SPE);

    SPSR &= ~(1u << SPI2X);

    return E_OK;
}
/*
 * SPI_Transceive
 * 1. Reject a NULL receive pointer.
 * 2. SPDR = Copy_u8Sent;          // starts the shift in master mode
 * 3. while (SPIF == 0) ;
 * 4. *Copy_pu8Received = SPDR;    // also clears SPIF
 */
STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received)
{
    if (Copy_pu8Received == NULL)
    {
        return E_NOK;
    }

    SPDR = Copy_u8Sent;

    while ((SPSR & (1u << SPIF)) == 0u)
    {
    }

    *Copy_pu8Received = SPDR;

    return E_OK;
}
/*
 * SPI_SelectSlave
 * 1. GPIO_SetPinDirection(port, pin, GPIO_OUTPUT);
 * 2. GPIO_SetPinValue(port, pin, GPIO_LOW);
 *
 * SPI_ReleaseSlave
 * 1. GPIO_SetPinValue(port, pin, GPIO_HIGH);
 */
STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = GPIO_SetPinDirection(Copy_u8Port, Copy_u8Pin, GPIO_OUTPUT);

    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    Local_u8Error =
        GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, GPIO_LOW);

    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = GPIO_SetPinValue(Copy_u8Port, Copy_u8Pin, GPIO_HIGH);

    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    return E_OK;
}
/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — SPI.c  (ATmega32, mode 0)
 * Implement every prototype from SPI_interface.h.
 */
