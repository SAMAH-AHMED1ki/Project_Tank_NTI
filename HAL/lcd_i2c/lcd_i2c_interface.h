#ifndef LCD_I2C_INTERFACE_H
#define LCD_I2C_INTERFACE_H

#include "STD_TYPES.h"

/* I2C Slave Address for LCD Backpack (Default AIP31068 / PCF8574 address) */
#define LCD_I2C_SLAVE_ADDRESS 0x27

/* LCD Display Parameters */
#define LCD_ROW_1 0u
#define LCD_ROW_2 1u
#define LCD_COL_1 0u
#define LCD_COL_16 15u

STD_ReturnType LCD_I2C_Init(void);

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command);

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char);

STD_ReturnType LCD_I2C_SendString(const char *Copy_pStr);

STD_ReturnType LCD_I2C_Clear(void);

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col);

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Value);

#endif /* LCD_I2C_INTERFACE_H */