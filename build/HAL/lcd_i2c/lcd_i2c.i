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
# 30 "HAL/lcd_i2c/LCD_I2C_interface.h"
STD_ReturnType LCD_I2C_Init(void);

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command);

STD_ReturnType LCD_I2C_SendData(uint8 Copy_u8Data);

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char);

STD_ReturnType LCD_I2C_SendString(const char *Copy_pcString);

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Column);

STD_ReturnType LCD_I2C_Clear(void);

STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Number);
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
# 6 "HAL/lcd_i2c/lcd_i2c.c" 2






# 11 "HAL/lcd_i2c/lcd_i2c.c"
static STD_ReturnType LCD_I2C_Write(uint8 Copy_u8Control,
                                    uint8 Copy_u8Data)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = I2C_SendStart();
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    Local_u8Error = I2C_SendSlaveAddressWithWrite(0x3E);
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





STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = LCD_I2C_Write(0x00, Copy_u8Command);

    _delay_ms(2);

    return Local_u8Error;
}





STD_ReturnType LCD_I2C_SendData(uint8 Copy_u8Data)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = LCD_I2C_Write(0x40, Copy_u8Data);

    _delay_ms(1);

    return Local_u8Error;
}





STD_ReturnType LCD_I2C_Init(void)
{
    STD_ReturnType Local_u8Error;

    _delay_ms(50);


    Local_u8Error = LCD_I2C_SendCommand(0x38);
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    _delay_ms(5);


    Local_u8Error = LCD_I2C_SendCommand(0x39);
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }

    _delay_ms(1);


    Local_u8Error = LCD_I2C_SendCommand(0x14);
    if (Local_u8Error != E_OK)
    {
        return E_NOK;
    }


    LCD_I2C_SendCommand(0x70);
    LCD_I2C_SendCommand(0x56);
    LCD_I2C_SendCommand(0x6C);

    _delay_ms(200);


    LCD_I2C_SendCommand(0x38);


    LCD_I2C_SendCommand(0x0C);


    LCD_I2C_SendCommand(0x01);

    _delay_ms(5);


    LCD_I2C_SendCommand(0x06);

    return E_OK;
}





STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char)
{
    return LCD_I2C_SendData(Copy_u8Char);
}





STD_ReturnType LCD_I2C_SendString(const char *Copy_pcString)
{
    if (Copy_pcString == ((void *)0))
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





STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row,
                                 uint8 Copy_u8Column)
{
    uint8 Local_u8Address;

    if (Copy_u8Row > 1u)
    {
        return E_NOK;
    }

    if (Copy_u8Column > 15u)
    {
        return E_NOK;
    }

    if (Copy_u8Row == 0u)
    {
        Local_u8Address = 0x00u + Copy_u8Column;
    }
    else
    {
        Local_u8Address = 0x40u + Copy_u8Column;
    }

    return LCD_I2C_SendCommand(0x80u | Local_u8Address);
}





STD_ReturnType LCD_I2C_Clear(void)
{
    STD_ReturnType Local_u8Error;

    Local_u8Error = LCD_I2C_SendCommand(0x01);

    _delay_ms(5);

    return Local_u8Error;
}





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
