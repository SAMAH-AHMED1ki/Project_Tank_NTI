# 0 "LIB/Ringbuffer/Ringbuffer.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "LIB/Ringbuffer/Ringbuffer.c"
# 1 "LIB/Ringbuffer/Ringbuffer.h" 1



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
# 5 "LIB/Ringbuffer/Ringbuffer.h" 2
# 14 "LIB/Ringbuffer/Ringbuffer.h"
typedef struct
{
    uint8 buffer[64U];
    volatile uint8 head;
    volatile uint8 tail;
    volatile uint8 count;
} RingBuffer_t;





void RB_Init(RingBuffer_t *pRb);
# 35 "LIB/Ringbuffer/Ringbuffer.h"
STD_ReturnType RB_Put(RingBuffer_t *pRb, uint8 data);
# 44 "LIB/Ringbuffer/Ringbuffer.h"
STD_ReturnType RB_Get(RingBuffer_t *pRb, uint8 *pData);


uint8 RB_IsEmpty(const RingBuffer_t *pRb);


uint8 RB_IsFull(const RingBuffer_t *pRb);
# 2 "LIB/Ringbuffer/Ringbuffer.c" 2

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
# 4 "LIB/Ringbuffer/Ringbuffer.c" 2


# 5 "LIB/Ringbuffer/Ringbuffer.c"
static uint8 RB_NextIndex(uint8 Copy_u8Index)
{
 Copy_u8Index++;

 if (Copy_u8Index >= 64U)
 {
  Copy_u8Index = 0U;
 }

 return Copy_u8Index;
}

void RB_Init(RingBuffer_t *pRb)
{
 if (pRb == ((void *)0))
 {
  return;
 }

 pRb->head = 0U;
 pRb->tail = 0U;
 pRb->count = 0U;
}

STD_ReturnType RB_Put(RingBuffer_t *pRb, uint8 data)
{
 uint8 Local_u8Sreg;

 if (pRb == ((void *)0))
 {
  return E_NOK;
 }

 Local_u8Sreg = 
# 38 "LIB/Ringbuffer/Ringbuffer.c" 3
               (*(volatile uint8_t *)((0x3F) + 0x20))
# 38 "LIB/Ringbuffer/Ringbuffer.c"
                   ;
 
# 39 "LIB/Ringbuffer/Ringbuffer.c" 3
__asm__ __volatile__ ("cli" ::: "memory")
# 39 "LIB/Ringbuffer/Ringbuffer.c"
     ;

 if (pRb->count >= 64U)
 {
  
# 43 "LIB/Ringbuffer/Ringbuffer.c" 3
 (*(volatile uint8_t *)((0x3F) + 0x20)) 
# 43 "LIB/Ringbuffer/Ringbuffer.c"
      = Local_u8Sreg;
  return E_NOK;
 }

 pRb->buffer[pRb->head] = data;
 pRb->head = RB_NextIndex(pRb->head);
 pRb->count++;

 
# 51 "LIB/Ringbuffer/Ringbuffer.c" 3
(*(volatile uint8_t *)((0x3F) + 0x20)) 
# 51 "LIB/Ringbuffer/Ringbuffer.c"
     = Local_u8Sreg;
 return E_OK;
}

STD_ReturnType RB_Get(RingBuffer_t *pRb, uint8 *pData)
{
 uint8 Local_u8Sreg;

 if ((pRb == ((void *)0)) || (pData == ((void *)0)))
 {
  return E_NOK;
 }

 Local_u8Sreg = 
# 64 "LIB/Ringbuffer/Ringbuffer.c" 3
               (*(volatile uint8_t *)((0x3F) + 0x20))
# 64 "LIB/Ringbuffer/Ringbuffer.c"
                   ;
 
# 65 "LIB/Ringbuffer/Ringbuffer.c" 3
__asm__ __volatile__ ("cli" ::: "memory")
# 65 "LIB/Ringbuffer/Ringbuffer.c"
     ;

 if (pRb->count == 0U)
 {
  
# 69 "LIB/Ringbuffer/Ringbuffer.c" 3
 (*(volatile uint8_t *)((0x3F) + 0x20)) 
# 69 "LIB/Ringbuffer/Ringbuffer.c"
      = Local_u8Sreg;
  return E_NOK;
 }

 *pData = pRb->buffer[pRb->tail];
 pRb->tail = RB_NextIndex(pRb->tail);
 pRb->count--;

 
# 77 "LIB/Ringbuffer/Ringbuffer.c" 3
(*(volatile uint8_t *)((0x3F) + 0x20)) 
# 77 "LIB/Ringbuffer/Ringbuffer.c"
     = Local_u8Sreg;
 return E_OK;
}

uint8 RB_IsEmpty(const RingBuffer_t *pRb)
{
 uint8 Local_u8Sreg;
 uint8 Local_u8Count;

 if (pRb == ((void *)0))
 {
  return 1U;
 }

 Local_u8Sreg = 
# 91 "LIB/Ringbuffer/Ringbuffer.c" 3
               (*(volatile uint8_t *)((0x3F) + 0x20))
# 91 "LIB/Ringbuffer/Ringbuffer.c"
                   ;
 
# 92 "LIB/Ringbuffer/Ringbuffer.c" 3
__asm__ __volatile__ ("cli" ::: "memory")
# 92 "LIB/Ringbuffer/Ringbuffer.c"
     ;
 Local_u8Count = pRb->count;
 
# 94 "LIB/Ringbuffer/Ringbuffer.c" 3
(*(volatile uint8_t *)((0x3F) + 0x20)) 
# 94 "LIB/Ringbuffer/Ringbuffer.c"
     = Local_u8Sreg;

 return (Local_u8Count == 0U) ? 1U : 0U;
}

uint8 RB_IsFull(const RingBuffer_t *pRb)
{
 uint8 Local_u8Sreg;
 uint8 Local_u8Count;

 if (pRb == ((void *)0))
 {
  return 0U;
 }

 Local_u8Sreg = 
# 109 "LIB/Ringbuffer/Ringbuffer.c" 3
               (*(volatile uint8_t *)((0x3F) + 0x20))
# 109 "LIB/Ringbuffer/Ringbuffer.c"
                   ;
 
# 110 "LIB/Ringbuffer/Ringbuffer.c" 3
__asm__ __volatile__ ("cli" ::: "memory")
# 110 "LIB/Ringbuffer/Ringbuffer.c"
     ;
 Local_u8Count = pRb->count;
 
# 112 "LIB/Ringbuffer/Ringbuffer.c" 3
(*(volatile uint8_t *)((0x3F) + 0x20)) 
# 112 "LIB/Ringbuffer/Ringbuffer.c"
     = Local_u8Sreg;

 return (Local_u8Count >= 64U) ? 1U : 0U;
}
