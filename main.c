/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * AVR_NTI application entry.
 * Layers: LIB (types) -> MCAL (drivers) -> HAL (devices) -> Logic (app) ->
 * main.
 */
#define F_CPU 8000000UL

#include <avr/io.h>

#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "TIMER_interface.h"
#include "SPI_interface.h"
#include "Flowmeter_interface.h"
#include "Scheduler_interface.h"
#include "Shiftreg_interface.h"

/*==========================================================
 *                    UART DRIVER
 *==========================================================*/

static void UART_Init(void)
{
    uint16 Local_u16BaudRate = 51u;

    /* Baud rate = 9600 at F_CPU = 8 MHz */
    UBRRH = (uint8)(Local_u16BaudRate >> 8);
    UBRRL = (uint8)Local_u16BaudRate;

    /* Enable transmitter and receiver */
    UCSRB = (1u << TXEN) | (1u << RXEN);

    /* 8 data bits, 1 stop bit, no parity */
    UCSRC =
        (1u << URSEL) |
        (1u << UCSZ1) |
        (1u << UCSZ0);
}

static void UART_SendChar(uint8 Copy_u8Data)
{
    while ((UCSRA & (1u << UDRE)) == 0u)
    {
    }

    UDR = Copy_u8Data;
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

/*==========================================================
 *                 SCHEDULER TEST TASK
 *==========================================================*/

static void TestTask(void)
{
    UART_SendString("Scheduler Task Running");
    UART_SendNewLine();
}

/*==========================================================
 *                 DELAY HELPER
 *==========================================================*/

static void Test_DelayMS(uint16 Copy_u16Milliseconds)
{
    TIMER0_DelayMS(Copy_u16Milliseconds);
}

/*==========================================================
 *                 SPI + 74HC595 TEST
 *==========================================================*/

static void Test_SPI_ShiftRegister(void)
{
    UART_SendString("SPI + 74HC595 TEST START");
    UART_SendNewLine();

    SPI_InitMaster(SPI_PRESC_16);
    SHIFTREG_Init();

    /* Send different patterns to the LEDs */

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

/*==========================================================
 *                    TIMER0 TEST
 *==========================================================*/

static void Test_Timer0(void)
{
    UART_SendString("TIMER0 DELAY TEST START");
    UART_SendNewLine();

    GPIO_SetPinDirection(
        GPIO_PORTC,
        GPIO_PIN0,
        GPIO_OUTPUT);

    GPIO_SetPinValue(
        GPIO_PORTC,
        GPIO_PIN0,
        GPIO_LOW);

    TIMER0_Init();

    GPIO_SetPinValue(
        GPIO_PORTC,
        GPIO_PIN0,
        GPIO_HIGH);

    TIMER0_DelayMS(1000);

    GPIO_SetPinValue(
        GPIO_PORTC,
        GPIO_PIN0,
        GPIO_LOW);

    UART_SendString("TIMER0 DELAY TEST FINISHED");
    UART_SendNewLine();

    UART_SendString("TIMER0 PWM TEST START");
    UART_SendNewLine();

    TIMER0_PWM(50);

    UART_SendString("Timer0 PWM = 50 percent on PB3");
    UART_SendNewLine();

    Test_DelayMS(2000);

    TIMER0_Stop();

    UART_SendString("TIMER0 PWM TEST FINISHED");
    UART_SendNewLine();
}

/*==========================================================
 *                    TIMER1 PWM TEST
 *==========================================================*/

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

/*==========================================================
 *                    FLOWMETER TEST
 *==========================================================*/

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
        /*
         * Wait approximately one second.
         * During this time Timer1 counts external pulses.
         */

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

/*==========================================================
 *                    SCHEDULER TEST
 *==========================================================*/

static void Test_Scheduler(void)
{
    uint8 Local_u8Counter;

    UART_SendString("SCHEDULER TEST START");
    UART_SendNewLine();

    SCHEDULER_Init();

    SCHEDULER_AddTask(TestTask, 100u);

    /*
     * Temporary software tick test.
     * Each loop represents 10 ms.
     */

    for (Local_u8Counter = 0u; Local_u8Counter < 100u; Local_u8Counter++)
    {
        TIMER0_DelayMS(10);

        SCHEDULER_Tick();

        SCHEDULER_Run();
    }

    UART_SendString("SCHEDULER TEST FINISHED");
    UART_SendNewLine();
}

/*==========================================================
 *                         MAIN
 *==========================================================*/

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

    return 0;
}