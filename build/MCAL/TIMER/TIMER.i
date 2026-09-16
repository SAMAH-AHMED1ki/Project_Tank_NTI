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
# 1 "LIB/MATH.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/MATH.h" 2
# 21 "MCAL/TIMER/TIMER.c" 2
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







STD_ReturnType TIMER1_ExternalCounterInit(void);




uint16 TIMER1_GetCounter(void);




STD_ReturnType TIMER1_ResetCounter(void);
# 22 "MCAL/TIMER/TIMER.c" 2
# 1 "MCAL/TIMER/TIMER_private.h" 1
# 23 "MCAL/TIMER/TIMER.c" 2
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
# 24 "MCAL/TIMER/TIMER.c" 2
# 37 "MCAL/TIMER/TIMER.c"

# 37 "MCAL/TIMER/TIMER.c"
static void TIMER_WaitFlag(volatile uint8 *Copy_pu8Register, uint8 Copy_u8BitMask);
# 46 "MCAL/TIMER/TIMER.c"
static uint16 TIMER_DutyToCompare(uint16 Copy_u16Top, uint8 Copy_u8DutyPercent);





STD_ReturnType TIMER0_Init(void)
{
    (*(volatile uint8 *)0x53) = (1 << 
# 54 "MCAL/TIMER/TIMER.c" 3
                            3
# 54 "MCAL/TIMER/TIMER.c"
                                 );
    (*(volatile uint8 *)0x5C) = 124;
    (*(volatile uint8 *)0x52) = 0;
    (*(volatile uint8 *)0x53) &= ~((1 << 
# 57 "MCAL/TIMER/TIMER.c" 3
                               2
# 57 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 57 "MCAL/TIMER/TIMER.c" 3
                                             1
# 57 "MCAL/TIMER/TIMER.c"
                                                 ) | (1 << 
# 57 "MCAL/TIMER/TIMER.c" 3
                                                           0
# 57 "MCAL/TIMER/TIMER.c"
                                                               ));
    return E_OK;
}

STD_ReturnType TIMER0_DelayMS(uint16 Copy_u16Milliseconds)
{
    uint16 Local_u16Counter;
    (*(volatile uint8 *)0x58) = (1 << 
# 64 "MCAL/TIMER/TIMER.c" 3
                    1
# 64 "MCAL/TIMER/TIMER.c"
                        );
    (*(volatile uint8 *)0x53) |= (1 << 
# 65 "MCAL/TIMER/TIMER.c" 3
                             1
# 65 "MCAL/TIMER/TIMER.c"
                                 ) | (1 << 
# 65 "MCAL/TIMER/TIMER.c" 3
                                           0
# 65 "MCAL/TIMER/TIMER.c"
                                               );
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Milliseconds; Local_u16Counter++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 
# 68 "MCAL/TIMER/TIMER.c" 3
                                       1
# 68 "MCAL/TIMER/TIMER.c"
                                           ));
    }

    (*(volatile uint8 *)0x53) &= ~((1 << 
# 71 "MCAL/TIMER/TIMER.c" 3
                               2
# 71 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 71 "MCAL/TIMER/TIMER.c" 3
                                             1
# 71 "MCAL/TIMER/TIMER.c"
                                                 ) | (1 << 
# 71 "MCAL/TIMER/TIMER.c" 3
                                                           0
# 71 "MCAL/TIMER/TIMER.c"
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

    
# 92 "MCAL/TIMER/TIMER.c" 3
   (*(volatile uint8_t *)((0x17) + 0x20)) 
# 92 "MCAL/TIMER/TIMER.c"
        |= (1 << 
# 92 "MCAL/TIMER/TIMER.c" 3
                 3
# 92 "MCAL/TIMER/TIMER.c"
                    );
    (*(volatile uint8 *)0x53) |= (1 << 
# 93 "MCAL/TIMER/TIMER.c" 3
                             3
# 93 "MCAL/TIMER/TIMER.c"
                                  ) | (1 << 
# 93 "MCAL/TIMER/TIMER.c" 3
                                            6
# 93 "MCAL/TIMER/TIMER.c"
                                                 );
    (*(volatile uint8 *)0x53) |= (1 << 
# 94 "MCAL/TIMER/TIMER.c" 3
                             5
# 94 "MCAL/TIMER/TIMER.c"
                                  );
    (*(volatile uint8 *)0x53) &= ~(1 << 
# 95 "MCAL/TIMER/TIMER.c" 3
                              4
# 95 "MCAL/TIMER/TIMER.c"
                                   );
    (*(volatile uint8 *)0x5C) = TIMER_DutyToCompare(255, Copy_u8DutyPercent);
    (*(volatile uint8 *)0x53) |= (1 << 
# 97 "MCAL/TIMER/TIMER.c" 3
                             1
# 97 "MCAL/TIMER/TIMER.c"
                                 ) | (1 << 
# 97 "MCAL/TIMER/TIMER.c" 3
                                           0
# 97 "MCAL/TIMER/TIMER.c"
                                               );
    return E_OK;
}







STD_ReturnType TIMER0_Stop(void)
{

    (*(volatile uint8 *)0x53) &= ~((1 << 
# 110 "MCAL/TIMER/TIMER.c" 3
                               2
# 110 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 110 "MCAL/TIMER/TIMER.c" 3
                                             1
# 110 "MCAL/TIMER/TIMER.c"
                                                 ) | (1 << 
# 110 "MCAL/TIMER/TIMER.c" 3
                                                           0
# 110 "MCAL/TIMER/TIMER.c"
                                                               ));


    (*(volatile uint8 *)0x53) &= ~((1 << 
# 113 "MCAL/TIMER/TIMER.c" 3
                               5
# 113 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 113 "MCAL/TIMER/TIMER.c" 3
                                              4
# 113 "MCAL/TIMER/TIMER.c"
                                                   ));

    
# 115 "MCAL/TIMER/TIMER.c" 3
   (*(volatile uint8_t *)((0x17) + 0x20)) 
# 115 "MCAL/TIMER/TIMER.c"
        |= (1 << 
# 115 "MCAL/TIMER/TIMER.c" 3
                 3
# 115 "MCAL/TIMER/TIMER.c"
                    );
    
# 116 "MCAL/TIMER/TIMER.c" 3
   (*(volatile uint8_t *)((0x18) + 0x20)) 
# 116 "MCAL/TIMER/TIMER.c"
         &= ~(1 << 
# 116 "MCAL/TIMER/TIMER.c" 3
                   3
# 116 "MCAL/TIMER/TIMER.c"
                      );
    return E_OK;
}




STD_ReturnType TIMER1_Init(void)
{
    (*(volatile uint8 *)0x4F) = 0;
    (*(volatile uint8 *)0x4E) = (1 << 
# 126 "MCAL/TIMER/TIMER.c" 3
                             3
# 126 "MCAL/TIMER/TIMER.c"
                                  );
    (*(volatile uint16 *)0x4A) = 999;
    (*(volatile uint16 *)0x4C) = 0;
    (*(volatile uint8 *)0x4E) &= ~((1 << 
# 129 "MCAL/TIMER/TIMER.c" 3
                                2
# 129 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 129 "MCAL/TIMER/TIMER.c" 3
                                              1
# 129 "MCAL/TIMER/TIMER.c"
                                                  ) | (1 << 
# 129 "MCAL/TIMER/TIMER.c" 3
                                                            0
# 129 "MCAL/TIMER/TIMER.c"
                                                                ));
    return E_OK;
}

STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds)
{
    uint16 Local_u16Counter;
    (*(volatile uint8 *)0x58) = (1 << 
# 136 "MCAL/TIMER/TIMER.c" 3
                    4
# 136 "MCAL/TIMER/TIMER.c"
                         );
    (*(volatile uint8 *)0x4E) |= (1 << 
# 137 "MCAL/TIMER/TIMER.c" 3
                              1
# 137 "MCAL/TIMER/TIMER.c"
                                  );
    for (Local_u16Counter = 0; Local_u16Counter < Copy_u16Milliseconds; Local_u16Counter++)
    {
        TIMER_WaitFlag(&(*(volatile uint8 *)0x58), (1 << 
# 140 "MCAL/TIMER/TIMER.c" 3
                                       4
# 140 "MCAL/TIMER/TIMER.c"
                                            ));
    }
    (*(volatile uint8 *)0x4E) &= ~((1 << 
# 142 "MCAL/TIMER/TIMER.c" 3
                                2
# 142 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 142 "MCAL/TIMER/TIMER.c" 3
                                              1
# 142 "MCAL/TIMER/TIMER.c"
                                                  ) | (1 << 
# 142 "MCAL/TIMER/TIMER.c" 3
                                                            0
# 142 "MCAL/TIMER/TIMER.c"
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
    
# 157 "MCAL/TIMER/TIMER.c" 3
   (*(volatile uint8_t *)((0x11) + 0x20)) 
# 157 "MCAL/TIMER/TIMER.c"
        |= (1 << 
# 157 "MCAL/TIMER/TIMER.c" 3
                 5
# 157 "MCAL/TIMER/TIMER.c"
                    );
    (*(volatile uint8 *)0x4F) &= ~((1 << 
# 158 "MCAL/TIMER/TIMER.c" 3
                                1
# 158 "MCAL/TIMER/TIMER.c"
                                     ) | (1 << 
# 158 "MCAL/TIMER/TIMER.c" 3
                                               0
# 158 "MCAL/TIMER/TIMER.c"
                                                    ));
    (*(volatile uint8 *)0x4F) |= (1 << 
# 159 "MCAL/TIMER/TIMER.c" 3
                              1
# 159 "MCAL/TIMER/TIMER.c"
                                   );
    (*(volatile uint8 *)0x4E) |= (1 << 
# 160 "MCAL/TIMER/TIMER.c" 3
                              4
# 160 "MCAL/TIMER/TIMER.c"
                                   ) | (1 << 
# 160 "MCAL/TIMER/TIMER.c" 3
                                             3
# 160 "MCAL/TIMER/TIMER.c"
                                                  );
    (*(volatile uint8 *)0x4F) |= (1 << 
# 161 "MCAL/TIMER/TIMER.c" 3
                              7
# 161 "MCAL/TIMER/TIMER.c"
                                    );
    (*(volatile uint8 *)0x4F) &= ~(1 << 
# 162 "MCAL/TIMER/TIMER.c" 3
                               6
# 162 "MCAL/TIMER/TIMER.c"
                                     );
    Local_u32Top = (1000000UL / Copy_u16FrequencyHz) - 1;
    (*(volatile uint16 *)0x46) = (uint16)Local_u32Top;
    (*(volatile uint16 *)0x4A) = TIMER_DutyToCompare((*(volatile uint16 *)0x46), Copy_u8DutyPercent);
    (*(volatile uint8 *)0x4E) |= (1 << 
# 166 "MCAL/TIMER/TIMER.c" 3
                              1
# 166 "MCAL/TIMER/TIMER.c"
                                  );

    return E_OK;
}

STD_ReturnType TIMER1_Stop(void)
{
    (*(volatile uint8 *)0x4E) &= ~((1 << 
# 173 "MCAL/TIMER/TIMER.c" 3
                                2
# 173 "MCAL/TIMER/TIMER.c"
                                    ) | (1 << 
# 173 "MCAL/TIMER/TIMER.c" 3
                                              1
# 173 "MCAL/TIMER/TIMER.c"
                                                  ) | (1 << 
# 173 "MCAL/TIMER/TIMER.c" 3
                                                            0
# 173 "MCAL/TIMER/TIMER.c"
                                                                ));

    (*(volatile uint8 *)0x4F) &= ~((1 << 
# 175 "MCAL/TIMER/TIMER.c" 3
                                7
# 175 "MCAL/TIMER/TIMER.c"
                                      ) | (1 << 
# 175 "MCAL/TIMER/TIMER.c" 3
                                                6
# 175 "MCAL/TIMER/TIMER.c"
                                                      ));

    return E_OK;
}





STD_ReturnType TIMER1_ExternalCounterInit(void)
{




    (*(volatile uint8 *)0x4E) &=
        ~((1 << 
# 191 "MCAL/TIMER/TIMER.c" 3
               2
# 191 "MCAL/TIMER/TIMER.c"
                   ) | (1 << 
# 191 "MCAL/TIMER/TIMER.c" 3
                             1
# 191 "MCAL/TIMER/TIMER.c"
                                 ) | (1 << 
# 191 "MCAL/TIMER/TIMER.c" 3
                                           0
# 191 "MCAL/TIMER/TIMER.c"
                                               ));





    (*(volatile uint8 *)0x4F) &=
        ~((1 << 
# 198 "MCAL/TIMER/TIMER.c" 3
               1
# 198 "MCAL/TIMER/TIMER.c"
                    ) | (1 << 
# 198 "MCAL/TIMER/TIMER.c" 3
                              0
# 198 "MCAL/TIMER/TIMER.c"
                                   ));

    (*(volatile uint8 *)0x4E) &=
        ~((1 << 
# 201 "MCAL/TIMER/TIMER.c" 3
               4
# 201 "MCAL/TIMER/TIMER.c"
                    ) | (1 << 
# 201 "MCAL/TIMER/TIMER.c" 3
                              3
# 201 "MCAL/TIMER/TIMER.c"
                                   ));




    (*(volatile uint16 *)0x4C) = 0u;





    (*(volatile uint8 *)0x4E) |= (1 << 
# 212 "MCAL/TIMER/TIMER.c" 3
                              2
# 212 "MCAL/TIMER/TIMER.c"
                                  ) | (1 << 
# 212 "MCAL/TIMER/TIMER.c" 3
                                            1
# 212 "MCAL/TIMER/TIMER.c"
                                                ) | (1 << 
# 212 "MCAL/TIMER/TIMER.c" 3
                                                          0
# 212 "MCAL/TIMER/TIMER.c"
                                                              );

    return E_OK;
}

uint16 TIMER1_GetCounter(void)
{
    uint16 Local_u16CounterValue;

    Local_u16CounterValue = (*(volatile uint16 *)0x4C);

    return Local_u16CounterValue;
}

STD_ReturnType TIMER1_ResetCounter(void)
{
    (*(volatile uint16 *)0x4C) = 0u;

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
