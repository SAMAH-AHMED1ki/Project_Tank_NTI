/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — UART.c  (ATmega32 USART, 8N1 polling)
 * Implement every prototype from UART_interface.h.
 */

#include "STD_TYPES.h"
#include "UART_interface.h"
#include "UART_private.h"
#include "MATH.h"

/*
 * UART_Init
 * 1. Reject baud == 0.
 * 2. Compute UBRR = F_CPU / (16 * baud) - 1. Write UBRRH then UBRRL.
 * 3. UCSRC = URSEL | UCSZ1 | UCSZ0   (8N1, async).
 * 4. UCSRB = RXEN | TXEN.
 * 5. At 8 MHz, 9600 baud -> UBRR = 51.
 */
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate)
{
    uint16 UBRRValue;

    if (Copy_u32BaudRate == 0)
    {
        return E_NOK;
    }

    UBRRValue = BRUD_PRESCALER(Copy_u32BaudRate);
    UBRRH = (uint8)(UBRRValue >> 8);
    UBRRL = (uint8)(UBRRValue & 0xFF);
    UCSRC = (1 << URSEL) | (1 << UCSZ1) | (1 << UCSZ0);
    UCSRB = (1 << RXEN) | (1 << TXEN);
    // At 8 MHz, 9600 baud -> UBRR = 51. Check if the computed UBRR matches this value for validation.

    return E_OK;
}
/*
 * UART_SendByte
 * 1. while (UDRE == 0) ;   then UDR = Copy_u8Data.
 */
STD_ReturnType UART_SendByte(uint8 Copy_u8Data)
{
    while (GET_BIT(UCSRA, UDRE) == 0)
    {
        UDR = Copy_u8Data;
    }
    return E_OK;
}
/*
 * UART_ReceiveByte
 * 1. Reject a NULL pointer.
 * 2. while (RXC == 0) ;    then *Copy_pu8Data = UDR.
 */
STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data)
{
    if (Copy_pu8Data == NULL)
    {
        return E_NOK;
    }
    while (GET_BIT(UCSRA, RXC) == 0)
    {
        *Copy_pu8Data = UDR;
    }
    return E_OK;
}
/*
 * UART_SendString
 * 1. Reject a NULL pointer.
 * 2. Send bytes until '\0'. Do not send the terminator unless the lab asks.
 */
STD_ReturnType UART_SendString(const uint8 *Copy_pu8String)
{
    if (Copy_pu8String == NULL)
    {
        return E_NOK;
    }
    uint8 i = 0;
    while (Copy_pu8String[i] != '\0')
    {
        UART_SendByte(Copy_pu8String[i]);
        i++;
    }
    return E_OK;
}
/*
 * UART_IsDataReady
 * 1. Return E_OK if RXC is 1, else E_NOK.
 */
STD_ReturnType UART_IsDataReady(void)
{
    if (GET_BIT(UCSRA, RXC) == 1)
        return E_OK;
    else
        return E_NOK;
}
/*
 * UART_SetRxInterrupt / UART_SetTxInterrupt
 * 1. Set or clear RXCIE / UDRIE in UCSRB.
 * 2. Vectors: USART_RXC_vect , USART_UDRE_vect.
 */
STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1)
    {
        SET_BIT(UCSRB, RXCIE);
        return E_OK;
    }
    else if (Copy_u8State == 0)
    {
        CLR_BIT(UCSRB, RXCIE);
        return E_OK;
    }
    else
    {
        return E_NOK;
    }
}
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1)
    {
        SET_BIT(UCSRB, UDRIE);
        return E_OK;
    }
    else if (Copy_u8State == 0)
    {
        CLR_BIT(UCSRB, UDRIE);
        return E_OK;
    }
    else
    {
        return E_NOK;
    }
}
