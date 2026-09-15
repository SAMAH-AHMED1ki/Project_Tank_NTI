# 0 "HAL/lcd_i2c/lcd_i2c.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "HAL/lcd_i2c/lcd_i2c.c"
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
# 2 "HAL/lcd_i2c/lcd_i2c.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 3 "HAL/lcd_i2c/lcd_i2c.c" 2
# 1 "HAL/lcd_i2c/LCD_I2C_interface.h" 1
# 15 "HAL/lcd_i2c/LCD_I2C_interface.h"
STD_ReturnType LCD_I2C_Init(void);

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command);

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char);

STD_ReturnType LCD_I2C_SendString(const char *Copy_pStr);

STD_ReturnType LCD_I2C_Clear(void);

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col);

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Value);
# 4 "HAL/lcd_i2c/lcd_i2c.c" 2
# 1 "C:/avr-gcc/avr/include/util/delay.h" 1 3
# 49 "C:/avr-gcc/avr/include/util/delay.h" 3
# 1 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 1 3 4
# 9 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/avr-gcc/avr/include/stdint.h" 1 3 4
# 125 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 12 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 50 "C:/avr-gcc/avr/include/util/delay.h" 2 3
# 1 "C:/avr-gcc/avr/include/util/delay_basic.h" 1 3
# 37 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
# 1 "C:/avr-gcc/avr/include/inttypes.h" 1 3
# 77 "C:/avr-gcc/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 38 "C:/avr-gcc/avr/include/util/delay_basic.h" 2 3


static __inline__ void _delay_loop_1(uint8_t __count) __attribute__((__always_inline__));
static __inline__ void _delay_loop_2(uint16_t __count) __attribute__((__always_inline__));
# 80 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
void
_delay_loop_1(uint8_t __count)
{
 __asm__ volatile (
  "1: dec %0" "\n\t"
  "brne 1b"
  : "=r" (__count)
  : "0" (__count)
 );
}
# 102 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
void
_delay_loop_2(uint16_t __count)
{
# 113 "C:/avr-gcc/avr/include/util/delay_basic.h" 3
 __asm__ volatile (
  "1: sbiw %0,1" "\n\t"
  "brne 1b"
  : "+w" (__count)
 );

}
# 51 "C:/avr-gcc/avr/include/util/delay.h" 2 3
# 151 "C:/avr-gcc/avr/include/util/delay.h" 3
static __inline__ __attribute__((__always_inline__)) void _delay_ms(double __ms);

void
_delay_ms(double __ms)
{
 double __tmp ;


 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(uint32_t);
 __tmp = ((
# 161 "C:/avr-gcc/avr/include/util/delay.h"
          8000000UL
# 161 "C:/avr-gcc/avr/include/util/delay.h" 3
               ) / 1e3) * __ms;
# 171 "C:/avr-gcc/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(__builtin_ceil(__builtin_fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 197 "C:/avr-gcc/avr/include/util/delay.h" 3
}
# 234 "C:/avr-gcc/avr/include/util/delay.h" 3
static __inline__ __attribute__((__always_inline__)) void _delay_us(double __us);

void
_delay_us(double __us)
{
 double __tmp ;


 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(uint32_t);
 __tmp = ((
# 244 "C:/avr-gcc/avr/include/util/delay.h"
          8000000UL
# 244 "C:/avr-gcc/avr/include/util/delay.h" 3
               ) / 1e6) * __us;
# 254 "C:/avr-gcc/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(__builtin_ceil(__builtin_fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 281 "C:/avr-gcc/avr/include/util/delay.h" 3
}
# 5 "HAL/lcd_i2c/lcd_i2c.c" 2
# 13 "HAL/lcd_i2c/lcd_i2c.c"

# 13 "HAL/lcd_i2c/lcd_i2c.c"
static STD_ReturnType LCD_I2C_WriteNibble(uint8 Copy_u8Nibble, uint8 Copy_u8ControlFlags);

STD_ReturnType LCD_I2C_Init(void)
{
    STD_ReturnType Local_u8Status = E_OK;


    Local_u8Status |= I2C_InitMaster(100000UL);

    _delay_ms(50);


    Local_u8Status |= LCD_I2C_WriteNibble(0x30, 0);
    _delay_ms(5);
    Local_u8Status |= LCD_I2C_WriteNibble(0x30, 0);
    _delay_us(150);
    Local_u8Status |= LCD_I2C_WriteNibble(0x30, 0);
    Local_u8Status |= LCD_I2C_WriteNibble(0x20, 0);


    Local_u8Status |= LCD_I2C_SendCommand(0x28);
    Local_u8Status |= LCD_I2C_SendCommand(0x0C);
    Local_u8Status |= LCD_I2C_Clear();
    Local_u8Status |= LCD_I2C_SendCommand(0x06);

    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command)
{
    STD_ReturnType Local_u8Status = E_OK;


    Local_u8Status |= LCD_I2C_WriteNibble(Copy_u8Command & 0xF0u, 0);
    Local_u8Status |= LCD_I2C_WriteNibble((uint8)(Copy_u8Command << 4u) & 0xF0u, 0);

    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char)
{
    STD_ReturnType Local_u8Status = E_OK;


    Local_u8Status |= LCD_I2C_WriteNibble(Copy_u8Char & 0xF0u, 0x01u);
    Local_u8Status |= LCD_I2C_WriteNibble((uint8)(Copy_u8Char << 4u) & 0xF0u, 0x01u);

    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SendString(const char *Copy_pStr)
{
    if (Copy_pStr == ((void *)0))
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
    _delay_ms(2);
    return Local_u8Status;
}

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Col)
{
    if ((Copy_u8Row > 1u) || (Copy_u8Col > 15u))
    {
        return E_NOK;
    }


    uint8 Local_u8Address = (Copy_u8Row == 0u) ? (0x80u + Copy_u8Col) : (0xC0u + Copy_u8Col);

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


    while (Copy_u16Value > 0u)
    {
        Local_au8Buffer[Local_s8Index++] = (char)('0' + (Copy_u16Value % 10u));
        Copy_u16Value /= 10u;
    }


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
    uint8 Local_u8Payload = Copy_u8Nibble | Copy_u8ControlFlags | 0x08u;


    Local_u8Status |= I2C_SendStart();


    Local_u8Status |= I2C_SendSlaveAddressWithWrite(0x27);


    Local_u8Status |= I2C_SendByte(Local_u8Payload | 0x04u);
    _delay_us(1);


    Local_u8Status |= I2C_SendByte(Local_u8Payload & ~0x04u);
    _delay_us(50);


    I2C_SendStop();

    return Local_u8Status;
}
