# 0 "MCAL/UART/UART.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/UART/UART.c"
# 9 "MCAL/UART/UART.c"
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
# 10 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 15 "MCAL/UART/UART_interface.h"
# 1 "LIB/Ringbuffer/Ringbuffer.h" 1
# 19 "LIB/Ringbuffer/Ringbuffer.h"
typedef struct
{
    uint8 buffer[64U];
    volatile uint8 head;
    volatile uint8 tail;
    volatile uint8 count;
} RingBuffer_t;





void RB_Init(RingBuffer_t *pRb);
# 40 "LIB/Ringbuffer/Ringbuffer.h"
STD_ReturnType RB_Put(RingBuffer_t *pRb, uint8 data);
# 49 "LIB/Ringbuffer/Ringbuffer.h"
STD_ReturnType RB_Get(RingBuffer_t *pRb, uint8 *pData);


uint8 RB_IsEmpty(const RingBuffer_t *pRb);


uint8 RB_IsFull(const RingBuffer_t *pRb);
# 16 "MCAL/UART/UART_interface.h" 2





STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);





STD_ReturnType UART_SetRxBuffer(RingBuffer_t *Copy_pRxBuffer);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 11 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_private.h" 1
# 12 "MCAL/UART/UART.c" 2
# 1 "LIB/MATH.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/MATH.h" 2
# 13 "MCAL/UART/UART.c" 2
# 1 "C:/avr-gcc/avr/include/avr/interrupt.h" 1 3
# 38 "C:/avr-gcc/avr/include/avr/interrupt.h" 3
# 1 "C:/avr-gcc/avr/include/avr/io.h" 1 3
# 99 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 1 3
# 126 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 3
# 1 "C:/avr-gcc/avr/include/inttypes.h" 1 3
# 37 "C:/avr-gcc/avr/include/inttypes.h" 3
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
# 38 "C:/avr-gcc/avr/include/inttypes.h" 2 3
# 77 "C:/avr-gcc/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;





typedef uint32_t uint_farptr_t;
# 127 "C:/avr-gcc/avr/include/avr/sfr_defs.h" 2 3
# 100 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 230 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/iom32.h" 1 3
# 720 "C:/avr-gcc/avr/include/avr/iom32.h" 3
       
# 721 "C:/avr-gcc/avr/include/avr/iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 231 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 785 "C:/avr-gcc/avr/include/avr/io.h" 3
# 1 "C:/avr-gcc/avr/include/avr/portpins.h" 1 3
# 786 "C:/avr-gcc/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr/include/avr/common.h" 1 3
# 788 "C:/avr-gcc/avr/include/avr/io.h" 2 3

# 1 "C:/avr-gcc/avr/include/avr/version.h" 1 3
# 790 "C:/avr-gcc/avr/include/avr/io.h" 2 3






# 1 "C:/avr-gcc/avr/include/avr/fuse.h" 1 3
# 248 "C:/avr-gcc/avr/include/avr/fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 797 "C:/avr-gcc/avr/include/avr/io.h" 2 3


# 1 "C:/avr-gcc/avr/include/avr/lock.h" 1 3
# 800 "C:/avr-gcc/avr/include/avr/io.h" 2 3
# 39 "C:/avr-gcc/avr/include/avr/interrupt.h" 2 3
# 14 "MCAL/UART/UART.c" 2


# 15 "MCAL/UART/UART.c"
static RingBuffer_t *g_uartRxBuffer = ((void *)0);


# 17 "MCAL/UART/UART.c" 3
void __vector_13 (void) __attribute__ ((__signal__,__used__, __externally_visible__)) ; void __vector_13 (void)

# 18 "MCAL/UART/UART.c"
{
    uint8 Local_u8Data;

    Local_u8Data = 
# 21 "MCAL/UART/UART.c" 3
                  (*(volatile uint8_t *)((0x0C) + 0x20))
# 21 "MCAL/UART/UART.c"
                     ;

    if (g_uartRxBuffer != ((void *)0))
    {
        RB_Put(g_uartRxBuffer, Local_u8Data);
    }
}
# 36 "MCAL/UART/UART.c"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate)
{
    uint16 UBRRValue;

    if (Copy_u32BaudRate == 0)
    {
        return E_NOK;
    }

    UBRRValue = ((uint16)((8000000UL / (16UL * (Copy_u32BaudRate))) - 1));
    
# 46 "MCAL/UART/UART.c" 3
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 46 "MCAL/UART/UART.c"
         = (uint8)(UBRRValue >> 8);
    
# 47 "MCAL/UART/UART.c" 3
   (*(volatile uint8_t *)((0x09) + 0x20)) 
# 47 "MCAL/UART/UART.c"
         = (uint8)(UBRRValue & 0xFF);
    
# 48 "MCAL/UART/UART.c" 3
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 48 "MCAL/UART/UART.c"
         = (1 << 
# 48 "MCAL/UART/UART.c" 3
                 7
# 48 "MCAL/UART/UART.c"
                      ) | (1 << 
# 48 "MCAL/UART/UART.c" 3
                                2
# 48 "MCAL/UART/UART.c"
                                     ) | (1 << 
# 48 "MCAL/UART/UART.c" 3
                                               1
# 48 "MCAL/UART/UART.c"
                                                    );
    
# 49 "MCAL/UART/UART.c" 3
   (*(volatile uint8_t *)((0x0A) + 0x20)) 
# 49 "MCAL/UART/UART.c"
         = (1 << 
# 49 "MCAL/UART/UART.c" 3
                 4
# 49 "MCAL/UART/UART.c"
                     ) | (1 << 
# 49 "MCAL/UART/UART.c" 3
                               3
# 49 "MCAL/UART/UART.c"
                                   );


    return E_OK;
}




STD_ReturnType UART_SendByte(uint8 Copy_u8Data)
{
    while ((((
# 60 "MCAL/UART/UART.c" 3
          (*(volatile uint8_t *)((0x0B) + 0x20))
# 60 "MCAL/UART/UART.c"
          ) >> (
# 60 "MCAL/UART/UART.c" 3
          5
# 60 "MCAL/UART/UART.c"
          )) & 1u) == 0)
    {
    }
    
# 63 "MCAL/UART/UART.c" 3
   (*(volatile uint8_t *)((0x0C) + 0x20)) 
# 63 "MCAL/UART/UART.c"
       = Copy_u8Data;

    return E_OK;
}





STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data)
{
    if (Copy_pu8Data == ((void *)0))
    {
        return E_NOK;
    }
    while ((((
# 78 "MCAL/UART/UART.c" 3
          (*(volatile uint8_t *)((0x0B) + 0x20))
# 78 "MCAL/UART/UART.c"
          ) >> (
# 78 "MCAL/UART/UART.c" 3
          7
# 78 "MCAL/UART/UART.c"
          )) & 1u) == 0)
    {
    }
    *Copy_pu8Data = 
# 81 "MCAL/UART/UART.c" 3
                   (*(volatile uint8_t *)((0x0C) + 0x20))
# 81 "MCAL/UART/UART.c"
                      ;

    return E_OK;
}





STD_ReturnType UART_SendString(const uint8 *Copy_pu8String)
{
    if (Copy_pu8String == ((void *)0))
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




STD_ReturnType UART_IsDataReady(void)
{
    if ((((
# 110 "MCAL/UART/UART.c" 3
       (*(volatile uint8_t *)((0x0B) + 0x20))
# 110 "MCAL/UART/UART.c"
       ) >> (
# 110 "MCAL/UART/UART.c" 3
       7
# 110 "MCAL/UART/UART.c"
       )) & 1u) == 1)
        return E_OK;
    else
        return E_NOK;
}





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1)
    {
        ((
# 124 "MCAL/UART/UART.c" 3
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 124 "MCAL/UART/UART.c"
       ) |= (1u << (
# 124 "MCAL/UART/UART.c" 3
       7
# 124 "MCAL/UART/UART.c"
       )));
        return E_OK;
    }
    else if (Copy_u8State == 0)
    {
        ((
# 129 "MCAL/UART/UART.c" 3
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 129 "MCAL/UART/UART.c"
       ) &= ~(1u << (
# 129 "MCAL/UART/UART.c" 3
       7
# 129 "MCAL/UART/UART.c"
       )));
        return E_OK;
    }
    else
    {
        return E_NOK;
    }
}

STD_ReturnType UART_SetRxBuffer(RingBuffer_t *Copy_pRxBuffer)
{
    g_uartRxBuffer = Copy_pRxBuffer;
    return E_OK;
}
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State)
{
    if (Copy_u8State == 1)
    {
        ((
# 147 "MCAL/UART/UART.c" 3
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 147 "MCAL/UART/UART.c"
       ) |= (1u << (
# 147 "MCAL/UART/UART.c" 3
       5
# 147 "MCAL/UART/UART.c"
       )));
        return E_OK;
    }
    else if (Copy_u8State == 0)
    {
        ((
# 152 "MCAL/UART/UART.c" 3
       (*(volatile uint8_t *)((0x0A) + 0x20))
# 152 "MCAL/UART/UART.c"
       ) &= ~(1u << (
# 152 "MCAL/UART/UART.c" 3
       5
# 152 "MCAL/UART/UART.c"
       )));
        return E_OK;
    }
    else
    {
        return E_NOK;
    }
}
