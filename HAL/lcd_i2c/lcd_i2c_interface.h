#ifndef LCD_I2C_INTERFACE_H
#define LCD_I2C_INTERFACE_H

#include "STD_TYPES.h"

#define LCD_I2C_ADDRESS 0x3E

#define LCD_COMMAND 0x00
#define LCD_DATA 0x40

#define LCD_FUNCTION_SET 0x38
#define LCD_FUNCTION_SET_EXT 0x39
#define LCD_BIAS 0x14

#define LCD_CONTRAST_HIGH 0x70
#define LCD_CONTRAST_LOW 0x56
#define LCD_FOLLOWER 0x6C

#define LCD_DISPLAY_ON 0x0C
#define LCD_CLEAR_DISPLAY 0x01
#define LCD_ENTRY_MODE 0x06

#define LCD_SET_DDRAM_ADDRESS 0x80

#define LCD_ROW_1 0u
#define LCD_ROW_2 1u

#define LCD_COL_1 0u

STD_ReturnType LCD_I2C_Init(void);

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command);

STD_ReturnType LCD_I2C_SendData(uint8 Copy_u8Data);

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char);

STD_ReturnType LCD_I2C_SendString(const char *Copy_pcString);

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Column);

STD_ReturnType LCD_I2C_Clear(void);

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Number);

#endif // LCD_I2C_INTERFACE_H