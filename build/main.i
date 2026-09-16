# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"
# 12 "main.c"
<<<<<<< HEAD
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
# 13 "main.c" 2

=======
>>>>>>> eaa1cf8 (Update LCD I2C integration)
# 1 "LIB/STD_TYPES.h" 1
# 12 "LIB/STD_TYPES.h"

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
<<<<<<< HEAD
# 15 "main.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 16 "main.c" 2
# 1 "MCAL/TIMER/TIMER_interface.h" 1
# 29 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER0_Init(void);
=======
# 13 "main.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);
>>>>>>> eaa1cf8 (Update LCD I2C integration)




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





<<<<<<< HEAD

STD_ReturnType TIMER1_Init(void);




STD_ReturnType TIMER1_DelayMS(uint16 Copy_u16Milliseconds);
# 73 "MCAL/TIMER/TIMER_interface.h"
STD_ReturnType TIMER1_PWM(uint16 Copy_u16FrequencyHz, uint8 Copy_u8DutyPercent);




STD_ReturnType TIMER1_Stop(void);







STD_ReturnType TIMER1_ExternalCounterInit(void);




uint16 TIMER1_GetCounter(void);




STD_ReturnType TIMER1_ResetCounter(void);
# 17 "main.c" 2
# 1 "MCAL/SPI/SPI_interface.h" 1
# 30 "MCAL/SPI/SPI_interface.h"
STD_ReturnType SPI_InitMaster(uint8 Copy_u8Prescaler);




STD_ReturnType SPI_InitSlave(void);





STD_ReturnType SPI_Transceive(uint8 Copy_u8Sent, uint8 *Copy_pu8Received);





STD_ReturnType SPI_SelectSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
STD_ReturnType SPI_ReleaseSlave(uint8 Copy_u8Port, uint8 Copy_u8Pin);
# 18 "main.c" 2
# 1 "Logic/Flowmeter/Flowmeter_interface.h" 1
# 11 "Logic/Flowmeter/Flowmeter_interface.h"
STD_ReturnType FLOWMETER_Init(void);







STD_ReturnType FLOWMETER_Update1Hz(void);


uint16 FLOWMETER_GetPulsesPerSec(void);


uint16 FLOWMETER_GetFlowLpmX10(void);




uint32 FLOWMETER_GetTotalMilliliters(void);





STD_ReturnType FLOWMETER_ResetTotaliser(void);
# 19 "main.c" 2
# 1 "Logic/Scheduler/Scheduler_interface.h" 1
# 12 "Logic/Scheduler/Scheduler_interface.h"
typedef void (*SchedulerTaskFunction_t)(void);
=======
STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 14 "main.c" 2
# 1 "HAL/lcd_i2c/LCD_I2C_interface.h" 1
# 30 "HAL/lcd_i2c/LCD_I2C_interface.h"
STD_ReturnType LCD_I2C_Init(void);
>>>>>>> eaa1cf8 (Update LCD I2C integration)

STD_ReturnType LCD_I2C_SendCommand(uint8 Copy_u8Command);

STD_ReturnType LCD_I2C_SendData(uint8 Copy_u8Data);

STD_ReturnType LCD_I2C_SendChar(uint8 Copy_u8Char);

STD_ReturnType LCD_I2C_SendString(const char *Copy_pcString);

STD_ReturnType LCD_I2C_SetCursor(uint8 Copy_u8Row, uint8 Copy_u8Column);

STD_ReturnType LCD_I2C_Clear(void);

<<<<<<< HEAD

STD_ReturnType SCHEDULER_Init(void);







STD_ReturnType SCHEDULER_AddTask(
    SchedulerTaskFunction_t TaskFunction,
    uint32 PeriodMs);




void SCHEDULER_Tick(void);






void SCHEDULER_Run(void);
# 20 "main.c" 2
# 1 "HAL/Shiftreg/Shiftreg_interface.h" 1


=======
STD_ReturnType LCD_I2C_SendNumber(uint16 Copy_u16Number);
# 15 "main.c" 2

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
>>>>>>> eaa1cf8 (Update LCD I2C integration)




<<<<<<< HEAD
STD_ReturnType SHIFTREG_Init(void);


STD_ReturnType SHIFTREG_SendByte(uint8 Copy_u8Data);
# 21 "main.c" 2
=======
typedef uint16_t uintptr_t;
# 163 "C:/avr-gcc/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;
>>>>>>> eaa1cf8 (Update LCD I2C integration)





<<<<<<< HEAD
static void UART_Init(void)
{
    uint16 Local_u16BaudRate = 51u;


    
# 31 "main.c" 3
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 31 "main.c"
         = (uint8)(Local_u16BaudRate >> 8);
    
# 32 "main.c" 3
   (*(volatile uint8_t *)((0x09) + 0x20)) 
# 32 "main.c"
         = (uint8)Local_u16BaudRate;


    
# 35 "main.c" 3
   (*(volatile uint8_t *)((0x0A) + 0x20)) 
# 35 "main.c"
         = (1u << 
# 35 "main.c" 3
                  3
# 35 "main.c"
                      ) | (1u << 
# 35 "main.c" 3
                                 4
# 35 "main.c"
                                     );


    
# 38 "main.c" 3
   (*(volatile uint8_t *)((0x20) + 0x20)) 
# 38 "main.c"
         =
        (1u << 
# 39 "main.c" 3
              7
# 39 "main.c"
                   ) |
        (1u << 
# 40 "main.c" 3
              2
# 40 "main.c"
                   ) |
        (1u << 
# 41 "main.c" 3
              1
# 41 "main.c"
                   );
=======


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
>>>>>>> eaa1cf8 (Update LCD I2C integration)
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

<<<<<<< HEAD
static void UART_SendChar(uint8 Copy_u8Data)
{
    while ((
# 46 "main.c" 3
           (*(volatile uint8_t *)((0x0B) + 0x20)) 
# 46 "main.c"
                 & (1u << 
# 46 "main.c" 3
                          5
# 46 "main.c"
                              )) == 0u)
    {
    }

    
# 50 "main.c" 3
   (*(volatile uint8_t *)((0x0C) + 0x20)) 
# 50 "main.c"
       = Copy_u8Data;
}

static void UART_SendString(const char *Copy_pcString)
{
    while (*Copy_pcString != '\0')
    {
        UART_SendChar((uint8)*Copy_pcString);
        Copy_pcString++;
    }
}

static void UART_SendNumber(uint32 Copy_u32Number)
{
    char Local_acNumber[11];
    uint8 Local_u8Index = 0u;

    if (Copy_u32Number == 0u)
    {
        UART_SendChar('0');
        return;
    }

    while (Copy_u32Number > 0u)
    {
        Local_acNumber[Local_u8Index] =
            (char)('0' + (Copy_u32Number % 10u));

        Copy_u32Number /= 10u;
        Local_u8Index++;
    }

    while (Local_u8Index > 0u)
    {
        Local_u8Index--;
        UART_SendChar((uint8)Local_acNumber[Local_u8Index]);
    }
}

static void UART_SendNewLine(void)
{
    UART_SendString("\r\n");
}





static void TestTask(void)
{
    UART_SendString("Scheduler Task Running");
    UART_SendNewLine();
}





static void Test_DelayMS(uint16 Copy_u16Milliseconds)
{
    TIMER0_DelayMS(Copy_u16Milliseconds);
}





static void Test_SPI_ShiftRegister(void)
{
    UART_SendString("SPI + 74HC595 TEST START");
    UART_SendNewLine();

    SPI_InitMaster(1u);
    SHIFTREG_Init();



    SHIFTREG_SendByte(0x01);
    Test_DelayMS(500);

    SHIFTREG_SendByte(0x03);
    Test_DelayMS(500);

    SHIFTREG_SendByte(0x07);
    Test_DelayMS(500);

    SHIFTREG_SendByte(0x0F);
    Test_DelayMS(500);

    SHIFTREG_SendByte(0xFF);
    Test_DelayMS(500);

    SHIFTREG_SendByte(0x00);
    Test_DelayMS(500);

    UART_SendString("SPI + 74HC595 TEST FINISHED");
    UART_SendNewLine();
}





static void Test_Timer0(void)
{
    UART_SendString("TIMER0 DELAY TEST START");
    UART_SendNewLine();

    GPIO_SetPinDirection(
        2u,
        0u,
        1u);

    GPIO_SetPinValue(
        2u,
        0u,
        0u);

    TIMER0_Init();

    GPIO_SetPinValue(
        2u,
        0u,
        1u);

    TIMER0_DelayMS(1000);

    GPIO_SetPinValue(
        2u,
        0u,
        0u);

    UART_SendString("TIMER0 DELAY TEST FINISHED");
    UART_SendNewLine();

    UART_SendString("TIMER0 PWM TEST START");
    UART_SendNewLine();

    TIMER0_PWM(50);

    UART_SendString("Timer0 PWM = 50 percent on PB3");
    UART_SendNewLine();

    Test_DelayMS(3000);

    TIMER0_Stop();

    
# 197 "main.c" 3
   (*(volatile uint8_t *)((0x17) + 0x20)) 
# 197 "main.c"
        |= (1 << 
# 197 "main.c" 3
                 3
# 197 "main.c"
                    );
    
# 198 "main.c" 3
   (*(volatile uint8_t *)((0x18) + 0x20)) 
# 198 "main.c"
         &= ~(1 << 
# 198 "main.c" 3
                   3
# 198 "main.c"
                      );
    UART_SendString("TIMER0 PWM TEST FINISHED");
    UART_SendNewLine();
}





static void Test_Timer1_PWM(void)
{
    UART_SendString("TIMER1 PWM TEST START");
    UART_SendNewLine();

    TIMER1_PWM(50, 50);

    UART_SendString("Timer1 PWM = 50 Hz, 50 percent on PD5");
    UART_SendNewLine();

    Test_DelayMS(3000);

    TIMER1_Stop();

    UART_SendString("TIMER1 PWM TEST FINISHED");
    UART_SendNewLine();
}





static void Test_Flowmeter(void)
{
    uint8 Local_u8Counter;

    UART_SendString("FLOWMETER TEST START");
    UART_SendNewLine();

    FLOWMETER_Init();

    UART_SendString("Generate pulses on PB1 / T1");
    UART_SendNewLine();

    for (Local_u8Counter = 0u; Local_u8Counter < 10u; Local_u8Counter++)
    {
=======
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
# 17 "main.c" 2


# 18 "main.c"
int main(void)
{

    I2C_InitMaster(100000UL);


    LCD_I2C_Init();
>>>>>>> eaa1cf8 (Update LCD I2C integration)

    LCD_I2C_Clear();

<<<<<<< HEAD



        TIMER0_DelayMS(1000);

        FLOWMETER_Update1Hz();

        UART_SendString("Pulses per second = ");
        UART_SendNumber(FLOWMETER_GetPulsesPerSec());
        UART_SendNewLine();

        UART_SendString("Flow L/min x10 = ");
        UART_SendNumber(FLOWMETER_GetFlowLpmX10());
        UART_SendNewLine();

        UART_SendString("Total milliliters = ");
        UART_SendNumber(FLOWMETER_GetTotalMilliliters());
        UART_SendNewLine();

        UART_SendNewLine();
    }

    UART_SendString("FLOWMETER TEST FINISHED");
    UART_SendNewLine();
}





static void Test_Scheduler(void)
{
    uint8 Local_u8Counter;

    UART_SendString("SCHEDULER TEST START");
    UART_SendNewLine();

    SCHEDULER_Init();

    SCHEDULER_AddTask(TestTask, 100u);






    for (Local_u8Counter = 0u; Local_u8Counter < 100u; Local_u8Counter++)
    {
        TIMER0_DelayMS(10);

        SCHEDULER_Tick();

        SCHEDULER_Run();
    }

    UART_SendString("SCHEDULER TEST FINISHED");
    UART_SendNewLine();
}





int main(void)
{
    UART_Init();

    UART_SendString("================================");
    UART_SendNewLine();

    UART_SendString("ATmega32 DRIVER TEST PROGRAM");
    UART_SendNewLine();

    UART_SendString("================================");
    UART_SendNewLine();

    Test_SPI_ShiftRegister();

    Test_Timer0();

    Test_Timer1_PWM();

    Test_Flowmeter();

    Test_Scheduler();

    UART_SendString("ALL TESTS FINISHED");
    UART_SendNewLine();

    while (1)
    {
    }
=======
    LCD_I2C_SetCursor(0u, 0u);
    LCD_I2C_SendString("Hello");

    _delay_ms(2000);

    LCD_I2C_Clear();

    LCD_I2C_SetCursor(0u, 0u);
    LCD_I2C_SendString("LCD Test");

    LCD_I2C_SetCursor(1u, 0u);
    LCD_I2C_SendString("Working!");

    while (1)
    {
    };
>>>>>>> eaa1cf8 (Update LCD I2C integration)

    return 0;
}
