# 0 "MCAL/TIMER/TIMER.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/TIMER/TIMER.c"
# 19 "MCAL/TIMER/TIMER.c"
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
# 20 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 29 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER0_Init(void);




STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds);




STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds);







STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER0_Stop(void);






STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 73 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);
# 21 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 22 "MCAL/TIMER/TIMER.c" 2
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
# 23 "MCAL/TIMER/TIMER.c" 2
# 36 "MCAL/TIMER/TIMER.c"

# 36 "MCAL/TIMER/TIMER.c"
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);
# 45 "MCAL/TIMER/TIMER.c"
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);





STD_ReturnType TIMER0_Init(void)
{
    (*(volatile uint8 *)0x53) = (1 << 
# 53 "MCAL/TIMER/TIMER.c" 3
                            3
# 53 "MCAL/TIMER/TIMER.c"
                                 );
    (*(volatile uint8 *)0x5C) = 124;
    (*(volatile uint8 *)0x52) = 0;
    (*(volatile uint8 *)0x53) &= ~((1 << 
# 56 "MCAL/TIMER/TIMER.c" 3
                               2
# 56 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 56 "MCAL/TIMER/TIMER.c" 3
                                             1
# 56 "MCAL/TIMER/TIMER.c"
                                                 ) | (1 << 
# 56 "MCAL/TIMER/TIMER.c" 3
                                                           0
# 56 "MCAL/TIMER/TIMER.c"
                                                               ));
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
    uint16 Local_u16Counter;
    (*(volatile uint8 *)0x58) = (1 << 
# 63 "MCAL/TIMER/TIMER.c" 3
                    1
# 63 "MCAL/TIMER/TIMER.c"
                        );
    (*(volatile uint8 *)0x53) |= (1 << 
# 64 "MCAL/TIMER/TIMER.c" 3
                             1
# 64 "MCAL/TIMER/TIMER.c"
                                 ) | (1 << 
# 64 "MCAL/TIMER/TIMER.c" 3
                                           0
# 64 "MCAL/TIMER/TIMER.c"
                                               );
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Milliseconds; Local_u16Counter++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 
# 67 "MCAL/TIMER/TIMER.c" 3
                                       1
# 67 "MCAL/TIMER/TIMER.c"
                                           ));
    }

    (*(volatile uint8 *)0x53) &= ~((1 << 
# 70 "MCAL/TIMER/TIMER.c" 3
                               2
# 70 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 70 "MCAL/TIMER/TIMER.c" 3
                                             1
# 70 "MCAL/TIMER/TIMER.c"
                                                 ) | (1 << 
# 70 "MCAL/TIMER/TIMER.c" 3
                                                           0
# 70 "MCAL/TIMER/TIMER.c"
                                                               ));
    return E_OK;
}

STD_ReturnType TIMER0_DelayS(uint16 Copy_u16Seconds)
{
    uint16 Local_u16Counter;
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Seconds; Local_u16Counter++)
    {
        TIMER0_DelayMS(1000);
    }
    return E_OK;
}

STD_ReturnType TIMER0_PWM(uint8 Copy_u8DutyPercent)
{
    if (Copy_u8DutyPercent > 100)
    {
        return E_NOK;
    }

    
# 91 "MCAL/TIMER/TIMER.c" 3
   (*(volatile uint8_t *)((0x17) + 0x20)) 
# 91 "MCAL/TIMER/TIMER.c"
        |= (1 << 
# 91 "MCAL/TIMER/TIMER.c" 3
                 3
# 91 "MCAL/TIMER/TIMER.c"
                    );
    (*(volatile uint8 *)0x53) |= (1 << 
# 92 "MCAL/TIMER/TIMER.c" 3
                             3
# 92 "MCAL/TIMER/TIMER.c"
                                  ) | (1 << 
# 92 "MCAL/TIMER/TIMER.c" 3
                                            6
# 92 "MCAL/TIMER/TIMER.c"
                                                 );
    (*(volatile uint8 *)0x53) |= (1 << 
# 93 "MCAL/TIMER/TIMER.c" 3
                             5
# 93 "MCAL/TIMER/TIMER.c"
                                  );
    (*(volatile uint8 *)0x53) &= ~(1 << 
# 94 "MCAL/TIMER/TIMER.c" 3
                              4
# 94 "MCAL/TIMER/TIMER.c"
                                   );
    (*(volatile uint8 *)0x5C) = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    (*(volatile uint8 *)0x53) |= (1 << 
# 96 "MCAL/TIMER/TIMER.c" 3
                             1
# 96 "MCAL/TIMER/TIMER.c"
                                 ) | (1 << 
# 96 "MCAL/TIMER/TIMER.c" 3
                                           0
# 96 "MCAL/TIMER/TIMER.c"
                                               );
    return E_OK;
}

STD_ReturnType TIMER0_Stop(void)
{
    (*(volatile uint8 *)0x53) &= ~((1 << 
# 102 "MCAL/TIMER/TIMER.c" 3
                               2
# 102 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 102 "MCAL/TIMER/TIMER.c" 3
                                             1
# 102 "MCAL/TIMER/TIMER.c"
                                                 ) | (1 << 
# 102 "MCAL/TIMER/TIMER.c" 3
                                                           0
# 102 "MCAL/TIMER/TIMER.c"
                                                               ));
    (*(volatile uint8 *)0x53) &= ~((1 << 
# 103 "MCAL/TIMER/TIMER.c" 3
                               5
# 103 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 103 "MCAL/TIMER/TIMER.c" 3
                                              4
# 103 "MCAL/TIMER/TIMER.c"
                                                   ));
    return E_OK;
}





STD_ReturnType TIMER1_Init(void)
{
    (*(volatile uint8 *)0x4F) = 0;
    (*(volatile uint8 *)0x4E) = (1 << 
# 114 "MCAL/TIMER/TIMER.c" 3
                             3
# 114 "MCAL/TIMER/TIMER.c"
                                  );
    (*(volatile uint16 *)0x4A) = 999;
    (*(volatile uint16 *)0x4C) = 0;
    (*(volatile uint8 *)0x4E) &= ~((1 << 
# 117 "MCAL/TIMER/TIMER.c" 3
                                2
# 117 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 117 "MCAL/TIMER/TIMER.c" 3
                                              1
# 117 "MCAL/TIMER/TIMER.c"
                                                  ) | (1 << 
# 117 "MCAL/TIMER/TIMER.c" 3
                                                            0
# 117 "MCAL/TIMER/TIMER.c"
                                                                ));
    return E_OK;
}

STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds)
{
    uint16 Local_u16Counter;
    (*(volatile uint8 *)0x58) = (1 << 
# 124 "MCAL/TIMER/TIMER.c" 3
                    4
# 124 "MCAL/TIMER/TIMER.c"
                         );
    (*(volatile uint8 *)0x4E) |= (1 << 
# 125 "MCAL/TIMER/TIMER.c" 3
                              1
# 125 "MCAL/TIMER/TIMER.c"
                                  );
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Milliseconds; Local_u16Counter++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 
# 128 "MCAL/TIMER/TIMER.c" 3
                                       4
# 128 "MCAL/TIMER/TIMER.c"
                                            ));
    }
    (*(volatile uint8 *)0x4E) &= ~((1 << 
# 130 "MCAL/TIMER/TIMER.c" 3
                                2
# 130 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 130 "MCAL/TIMER/TIMER.c" 3
                                              1
# 130 "MCAL/TIMER/TIMER.c"
                                                  ) | (1 << 
# 130 "MCAL/TIMER/TIMER.c" 3
                                                            0
# 130 "MCAL/TIMER/TIMER.c"
                                                                ));
    return E_OK;
}

STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent)
{
    uint32 Local_u32Top;
    if (Copy_u8DutyPercent > 100)
    {
        return E_NOK;
    }
    if ((Copy_u16FrequencyHz < 16) || (Copy_u16FrequencyHz > 20000))
    {
        return E_NOK;
    }
    
# 145 "MCAL/TIMER/TIMER.c" 3
   (*(volatile uint8_t *)((0x11) + 0x20)) 
# 145 "MCAL/TIMER/TIMER.c"
        |= (1 << 
# 145 "MCAL/TIMER/TIMER.c" 3
                 5
# 145 "MCAL/TIMER/TIMER.c"
                    );
    (*(volatile uint8 *)0x4F) &= ~((1 << 
# 146 "MCAL/TIMER/TIMER.c" 3
                                1
# 146 "MCAL/TIMER/TIMER.c"
                                     ) | (1 << 
# 146 "MCAL/TIMER/TIMER.c" 3
                                               0
# 146 "MCAL/TIMER/TIMER.c"
                                                    ));
    (*(volatile uint8 *)0x4F) |= (1 << 
# 147 "MCAL/TIMER/TIMER.c" 3
                              1
# 147 "MCAL/TIMER/TIMER.c"
                                   );
    (*(volatile uint8 *)0x4E) |= (1 << 
# 148 "MCAL/TIMER/TIMER.c" 3
                              4
# 148 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 148 "MCAL/TIMER/TIMER.c" 3
                                             3
# 148 "MCAL/TIMER/TIMER.c"
                                                  );
    (*(volatile uint8 *)0x4F) |= (1 << 
# 149 "MCAL/TIMER/TIMER.c" 3
                              7
# 149 "MCAL/TIMER/TIMER.c"
                                    );
    (*(volatile uint8 *)0x4F) &= ~(1 << 
# 150 "MCAL/TIMER/TIMER.c" 3
                               6
# 150 "MCAL/TIMER/TIMER.c"
                                     );
    Local_u32Top = (1000000UL / Copy_u16FrequencyHz) - 1;
    (*(volatile uint16 *)0x46) = (uint16)Local_u32Top;
    (*(volatile uint16 *)0x4A) = TIMER_DutyToCompare((*(volatile uint16 *)0x46), Copy_u8DutyPercent);
    (*(volatile uint8 *)0x4E) |= (1 << 
# 154 "MCAL/TIMER/TIMER.c" 3
                              1
# 154 "MCAL/TIMER/TIMER.c"
                                  );

    return E_OK;
}

STD_ReturnType TIMER1_Stop(void)
{
    (*(volatile uint8 *)0x4E) &= ~((1 << 
# 161 "MCAL/TIMER/TIMER.c" 3
                                2
# 161 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 161 "MCAL/TIMER/TIMER.c" 3
                                              1
# 161 "MCAL/TIMER/TIMER.c"
                                                  ) | (1 << 
# 161 "MCAL/TIMER/TIMER.c" 3
                                                            0
# 161 "MCAL/TIMER/TIMER.c"
                                                                ));

    (*(volatile uint8 *)0x4F) &= ~((1 << 
# 163 "MCAL/TIMER/TIMER.c" 3
                                7
# 163 "MCAL/TIMER/TIMER.c"
                                      ) | (1 << 
# 163 "MCAL/TIMER/TIMER.c" 3
                                                6
# 163 "MCAL/TIMER/TIMER.c"
                                                      ));

    return E_OK;
}





static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask)
{






    while ((*Copy_pu8Register & Copy_u8BitMask) == 0)
    {
    }

    *Copy_pu8Register = Copy_u8BitMask;
}

static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent)
{





    return (uint16)((((uint32)Copy_u16Top + 1UL) * Copy_u8DutyPercent) / 100UL);
}
