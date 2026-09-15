#include "STD_TYPES.h"
#include "I2C_interface.h"
#include "LCD_I2C_interface.h"
#include <util/delay.h>

/* PCF8574 / AIP31068 Backpack Pin Mapping Bits */
#define LCD_RS_BIT 0x01u    /* Register Select: 0=Command, 1=Data */
#define LCD_RW_BIT 0x02u    /* Read/Write: 0=Write, 1=Read        */
#define LCD_EN_BIT 0x04u    /* Enable Pulse Bit                   */
#define LCD_BACKLIGHT 0x08u /* Backlight Control Bit              */

/* Private Helper Function */
static STD_ReturnType LCD_I2C_WriteNibble(uint8 Copy_u8Nibble, uint8 Copy_u8ControlFlags);

STD_ReturnType LCD_I2C_Init(void)
{
    STD_ReturnType Local_u8Status = E_OK;

    /* 1. Initialize I2C Peripheral Driver at 100 kHz */
    Local_u8Status |= I2C_InitMaster(100000UL);

    _delay_ms(50); /* LCD Power-on stabilization delay */

    /* 2. Initialization sequence to force 4-bit mode (HD44780 standard) */
    Local_u8Status |= LCD_I2C_WriteNibble(0x30, 0);
    _delay_ms(5);
    Local_u8Status |= LCD_I2C_WriteNibble(0x30, 0);
    _delay_us(150);
    Local_u8Status |= LCD_I2C_WriteNibble(0x30, 0);
    Local_u8Status |= LCD_I2C_WriteNibble(0x20, 0); /* Switch to 4-bit bus interface */

    /* 3. Standard LCD configuration commands */
    Local_u8Status |= LCD_I2C_SendCommand(0x28); /* 4-bit mode, 2-line display, 5x8 font */
    Local_u8Status |= LCD_I2C_SendCommand(0x0C); /* Display ON, Cursor OFF, Blink OFF  */
    Local_u8Status |= LCD_I2C_Clear();           /* Clear Screen                        */
    Local_u8Status |= LCD_I2C_SendCommand(0x06); /* Entry Mode: Auto Increment Cursor   */

    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command)
{
    STD_ReturnType Local_u8Status = E_OK;

    /* Send upper nibble then lower nibble with RS = 0 (Command Mode) */
    Local_u8Status |= LCD_I2C_WriteNibble(Copy_u8Command & 0xF0u, 0);
    Local_u8Status |= LCD_I2C_WriteNibble((uint8)(Copy_u8Command << 4u) & 0xF0u, 0);

    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char)
{
    STD_ReturnType Local_u8Status = E_OK;

    /* Send upper nibble then lower nibble with RS = 1 (Data Mode) */
    Local_u8Status |= LCD_I2C_WriteNibble(Copy_u8Char & 0xF0u, LCD_RS_BIT);
    Local_u8Status |= LCD_I2C_WriteNibble((uint8)(Copy_u8Char << 4u) & 0xF0u, LCD_RS_BIT);

    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SendString(const char *Copy_pStr)
{
    if (Copy_pStr == NULL)
    {
        return E_NOK;
    }

    while (*Copy_pStr != '\0')
    {
        if (LCD_I2C_SendChar((uint8)(*Copy_pStr)) != E_OK)
        {
            return E_NOK;
        }
        Copy_pStr++;
    }

    return E_OK;
}

STD_ReturnType LCD_I2C_Clear(void)
{
    STD_ReturnType Local_u8Status = LCD_I2C_SendCommand(0x01);
    _delay_ms(2); /* Execution delay for Clear Display command */
    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col)
{
    if ((Copy_u8Row > LCD_ROW_2) || (Copy_u8Col > LCD_COL_16))
    {
        return E_NOK;
    }

    /* Row 0 starts at 0x00, Row 1 starts at 0x40 */
    uint8 Local_u8Address = (Copy_u8Row == LCD_ROW_1) ? (0x80u + Copy_u8Col) : (0xC0u + Copy_u8Col);

    return LCD_I2C_SendCommand(Local_u8Address);
}

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Value)
{
    char Local_au8Buffer[6];
    sint8 Local_s8Index = 0;

    if (Copy_u16Value == 0u)
    {
        return LCD_I2C_SendChar('0');
    }

    /* Convert integer to reverse decimal ASCII string */
    while (Copy_u16Value > 0u)
    {
        Local_au8Buffer[Local_s8Index++] = (char)('0' + (Copy_u16Value % 10u));
        Copy_u16Value /= 10u;
    }

    /* Display string in correct left-to-right order */
    while (--Local_s8Index >= 0)
    {
        if (LCD_I2C_SendChar((uint8)Local_au8Buffer[Local_s8Index]) != E_OK)
        {
            return E_NOK;
        }
    }

    return E_OK;
}

static STD_ReturnType LCD_I2C_WriteNibble(uint8 Copy_u8Nibble, uint8 Copy_u8ControlFlags)
{
    STD_ReturnType Local_u8Status = E_OK;
    uint8 Local_u8Payload = Copy_u8Nibble | Copy_u8ControlFlags | LCD_BACKLIGHT;

    /* 1. Transmit START condition */
    Local_u8Status |= I2C_SendStart();

    /* 2. Send 7-bit Slave Address with Write bit (R/W = 0) */
    Local_u8Status |= I2C_SendSlaveAddressWithWrite(LCD_I2C_SLAVE_ADDRESS);

    /* 3. Write payload with Enable HIGH */
    Local_u8Status |= I2C_SendByte(Local_u8Payload | LCD_EN_BIT);
    _delay_us(1);

    /* 4. Write payload with Enable LOW (latching falling edge) */
    Local_u8Status |= I2C_SendByte(Local_u8Payload & ~LCD_EN_BIT);
    _delay_us(50);

    /* 5. Transmit STOP condition */
    I2C_SendStop();

    return Local_u8Status;
}