#include "STD_TYPES.h"
#include "I2C_interface.h"
#include "LCD_I2C_interface.h"

#include <util/delay.h>

/* =========================================================
 * Send one byte to the AiP31068
 * ========================================================= */

static STD_ReturnType LCD_I2C_Write(uint8 Copy_u8Control,
                                    uint8 Copy_u8Data)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = I2C_SendStart();
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    Local_u8Error = I2C_SendSlaveAddressWithWrite(LCD_I2C_ADDRESS);
    if (Local_u8Error != E_OK)
    {
        I2C_SendStop();
        return E_NOK;
    }

    Local_u8Error = I2C_SendByte(Copy_u8Control);
    if (Local_u8Error != E_OK)
    {
        I2C_SendStop();
        return E_NOK;
    }

    Local_u8Error = I2C_SendByte(Copy_u8Data);
    if (Local_u8Error != E_OK)
    {
        I2C_SendStop();
        return E_NOK;
    }

    I2C_SendStop();

    return E_OK;
}

/* =========================================================
 * Send command
 * ========================================================= */

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = LCD_I2C_Write(LCD_COMMAND, Copy_u8Command);

    _delay_ms(2);

    return Local_u8Error;
}

/* =========================================================
 * Send data
 * ========================================================= */

STD_ReturnType LCD_I2C_SendData(uint8 Copy_u8Data)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = LCD_I2C_Write(LCD_DATA, Copy_u8Data);

    _delay_ms(1);

    return Local_u8Error;
}

/* =========================================================
 * Initialize AiP31068
 * ========================================================= */

STD_ReturnType LCD_I2C_Init(void)
{
    STD_ReturnType Local_u8Error;

    _delay_ms(50);

    /* Function set */
    Local_u8Error = LCD_I2C_SendCommand(0x38);
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    _delay_ms(5);

    /* Extended instruction set */
    Local_u8Error = LCD_I2C_SendCommand(0x39);
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    _delay_ms(1);

    /* Bias / internal configuration */
    Local_u8Error = LCD_I2C_SendCommand(0x14);
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    /* Contrast / voltage configuration */
    LCD_I2C_SendCommand(0x70);
    LCD_I2C_SendCommand(0x56);
    LCD_I2C_SendCommand(0x6C);

    _delay_ms(200);

    /* Return to normal instruction set */
    LCD_I2C_SendCommand(0x38);

    /* Display ON, cursor OFF, blink OFF */
    LCD_I2C_SendCommand(0x0C);

    /* Clear display */
    LCD_I2C_SendCommand(0x01);

    _delay_ms(5);

    /* Entry mode */
    LCD_I2C_SendCommand(0x06);

    return E_OK;
}

/* =========================================================
 * Send character
 * ========================================================= */

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char)
{
    return LCD_I2C_SendData(Copy_u8Char);
}

/* =========================================================
 * Send string
 * ========================================================= */

STD_ReturnType LCD_I2C_SendString(const char *Copy_pcString)
{
    if (Copy_pcString == NULL)
    {
        return E_NOK;
    }

    while (*Copy_pcString != '\0')
    {
        LCD_I2C_SendChar((uint8)*Copy_pcString);
        Copy_pcString++;
    }

    return E_OK;
}

/* =========================================================
 * Set cursor
 * ========================================================= */

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row,
                                 uint8 Copy_u8Column)
{
    uint8 Local_u8Address;

    if (Copy_u8Row > LCD_ROW_2)
    {
        return E_NOK;
    }

    if (Copy_u8Column > 15u)
    {
        return E_NOK;
    }

    if (Copy_u8Row == LCD_ROW_1)
    {
        Local_u8Address = 0x00u + Copy_u8Column;
    }
    else
    {
        Local_u8Address = 0x40u + Copy_u8Column;
    }

    return LCD_I2C_SendCommand(0x80u | Local_u8Address);
}

/* =========================================================
 * Clear display
 * ========================================================= */

STD_ReturnType LCD_I2C_Clear(void)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = LCD_I2C_SendCommand(0x01);

    _delay_ms(5);

    return Local_u8Error;
}

/* =========================================================
 * Send number
 * ========================================================= */

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Number)
{
    char Local_acNumber[6];
    uint8 Local_u8Index = 0;
    uint8 Local_u8i;

    if (Copy_u16Number == 0)
    {
        return LCD_I2C_SendChar('0');
    }

    while (Copy_u16Number > 0)
    {
        Local_acNumber[Local_u8Index] =
            (char)((Copy_u16Number % 10u) + '0');

        Copy_u16Number /= 10u;
        Local_u8Index++;
    }

    for (Local_u8i = Local_u8Index; Local_u8i > 0; Local_u8i--)
    {
        LCD_I2C_SendChar((uint8)Local_acNumber[Local_u8i - 1u]);
    }

    return E_OK;
}