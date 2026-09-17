# 0 "Logic/Console/console.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/Console/console.c"





# 1 "C:/avr-gcc/avr/include/stdio.h" 1 3
# 44 "C:/avr-gcc/avr/include/stdio.h" 3
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
# 45 "C:/avr-gcc/avr/include/stdio.h" 2 3
# 1 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdarg.h" 1 3 4
# 40 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 103 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 46 "C:/avr-gcc/avr/include/stdio.h" 2 3




# 1 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stddef.h" 1 3 4
# 229 "C:/avr-gcc/lib/gcc/avr/15.2.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 51 "C:/avr-gcc/avr/include/stdio.h" 2 3
# 250 "C:/avr-gcc/avr/include/stdio.h" 3
struct __file {
 char *buf;
 unsigned char unget;
 uint8_t flags;
# 269 "C:/avr-gcc/avr/include/stdio.h" 3
 int size;
 int len;
 int (*put)(char, struct __file *);
 int (*get)(struct __file *);
 void *udata;
};
# 283 "C:/avr-gcc/avr/include/stdio.h" 3
typedef struct __file FILE;
# 420 "C:/avr-gcc/avr/include/stdio.h" 3
extern struct __file *__iob[];
# 432 "C:/avr-gcc/avr/include/stdio.h" 3
extern FILE *fdevopen(int (*__put)(char, FILE*), int (*__get)(FILE*));
# 449 "C:/avr-gcc/avr/include/stdio.h" 3
extern int fclose(FILE *__stream);
# 623 "C:/avr-gcc/avr/include/stdio.h" 3
extern int vfprintf(FILE *__stream, const char *__fmt, va_list __ap);





extern int vfprintf_P(FILE *__stream, const char *__fmt, va_list __ap);






extern int fputc(int __c, FILE *__stream);




extern int putc(int __c, FILE *__stream);


extern int putchar(int __c);
# 664 "C:/avr-gcc/avr/include/stdio.h" 3
extern int printf(const char *__fmt, ...);





extern int printf_P(const char *__fmt, ...);







extern int vprintf(const char *__fmt, va_list __ap);





extern int sprintf(char *__s, const char *__fmt, ...);





extern int sprintf_P(char *__s, const char *__fmt, ...);
# 700 "C:/avr-gcc/avr/include/stdio.h" 3
extern int snprintf(char *__s, size_t __n, const char *__fmt, ...);





extern int snprintf_P(char *__s, size_t __n, const char *__fmt, ...);





extern int vsprintf(char *__s, const char *__fmt, va_list ap);





extern int vsprintf_P(char *__s, const char *__fmt, va_list ap);
# 728 "C:/avr-gcc/avr/include/stdio.h" 3
extern int vsnprintf(char *__s, size_t __n, const char *__fmt, va_list ap);





extern int vsnprintf_P(char *__s, size_t __n, const char *__fmt, va_list ap);




extern int fprintf(FILE *__stream, const char *__fmt, ...);





extern int fprintf_P(FILE *__stream, const char *__fmt, ...);






extern int fputs(const char *__str, FILE *__stream);




extern int fputs_P(const char *__str, FILE *__stream);





extern int puts(const char *__str);




extern int puts_P(const char *__str);
# 777 "C:/avr-gcc/avr/include/stdio.h" 3
extern size_t fwrite(const void *__ptr, size_t __size, size_t __nmemb,
         FILE *__stream);







extern int fgetc(FILE *__stream);




extern int getc(FILE *__stream);


extern int getchar(void);
# 825 "C:/avr-gcc/avr/include/stdio.h" 3
extern int ungetc(int __c, FILE *__stream);
# 837 "C:/avr-gcc/avr/include/stdio.h" 3
extern char *fgets(char *__str, int __size, FILE *__stream);






extern char *gets(char *__str);
# 855 "C:/avr-gcc/avr/include/stdio.h" 3
extern size_t fread(void *__ptr, size_t __size, size_t __nmemb,
        FILE *__stream);




extern void clearerr(FILE *__stream);
# 872 "C:/avr-gcc/avr/include/stdio.h" 3
extern int feof(FILE *__stream);
# 883 "C:/avr-gcc/avr/include/stdio.h" 3
extern int ferror(FILE *__stream);






extern int vfscanf(FILE *__stream, const char *__fmt, va_list __ap);




extern int vfscanf_P(FILE *__stream, const char *__fmt, va_list __ap);







extern int fscanf(FILE *__stream, const char *__fmt, ...);




extern int fscanf_P(FILE *__stream, const char *__fmt, ...);






extern int scanf(const char *__fmt, ...);




extern int scanf_P(const char *__fmt, ...);







extern int vscanf(const char *__fmt, va_list __ap);







extern int sscanf(const char *__buf, const char *__fmt, ...);




extern int sscanf_P(const char *__buf, const char *__fmt, ...);
# 953 "C:/avr-gcc/avr/include/stdio.h" 3
static __inline__ int fflush(FILE *stream __attribute__((unused)))
{
 return 0;
}






__extension__ typedef long long fpos_t;
extern int fgetpos(FILE *stream, fpos_t *pos);
extern FILE *fopen(const char *path, const char *mode);
extern FILE *freopen(const char *path, const char *mode, FILE *stream);
extern FILE *fdopen(int, const char *);
extern int fseek(FILE *stream, long offset, int whence);
extern int fsetpos(FILE *stream, fpos_t *pos);
extern long ftell(FILE *stream);
extern int fileno(FILE *);
extern void perror(const char *s);
extern int remove(const char *pathname);
extern int rename(const char *oldpath, const char *newpath);
extern void rewind(FILE *stream);
extern void setbuf(FILE *stream, char *buf);
extern int setvbuf(FILE *stream, char *buf, int mode, size_t size);
extern FILE *tmpfile(void);
extern char *tmpnam (char *s);
# 7 "Logic/Console/console.c" 2

# 1 "Logic/Console/console.h" 1
# 9 "Logic/Console/console.h"
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
# 10 "Logic/Console/console.h" 2
# 1 "LIB/DATA.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/DATA.h" 2
# 1 "Logic/interlocks/tank_types.h" 1







typedef enum
{
    ST_INIT = 0,
    ST_IDLE,
    ST_FILLING,
    ST_SETTLING,
    ST_RESERVOIR_WAIT,
    ST_TRIPPED,
    ST_MANUAL,
    ST_SERVICE

} TankState_t;



typedef enum
{
    TRIP_NONE = 0,

    TRIP_OVERFLOW,
    TRIP_OVERCURRENT,
    TRIP_DRY_RESERVOIR,
    TRIP_DRY_RUN,
    TRIP_NO_CURRENT,
    TRIP_MAX_RUNTIME,
    TRIP_LEVEL_SENSOR,
    TRIP_LEAK,
    TRIP_NO_RISE

} Trip_t;



typedef struct
{
    uint16 levelRaw;
    uint16 reservoirRaw;
    uint16 currentRaw;

    uint8 levelPct;
    uint8 reservoirPct;

    uint16 currentmA;
    uint16 flowLpmX10;

    uint32 totalLitres;

    sint8 levelRatePctMin;

    uint8 pumpOn : 1;
    uint8 valveOn : 1;
    uint8 highFloat : 1;
    uint8 lowFloat : 1;
    uint8 reserved : 4;

    uint8 state;
    uint8 activeTrip;

    uint16 pumpRunSec;
    uint32 pumpTotalSec;
    uint16 pumpCycles;

    uint32 upTimeSec;

} TankData_t;






typedef struct
{
    uint16 magic;
    uint8 version;

    uint8 startPct;
    uint8 stopPct;
    uint8 reserveMinPct;
    uint8 overflowPct;

    uint8 overCurrentA_X10;
    uint8 minCurrentA_X10;
    uint8 minFlowLpm;

    uint16 maxRunSec;
    uint16 minOffSec;

    uint8 leakDropPct;

    uint32 totalLitres;
    uint32 pumpTotalSec;
    uint16 pumpCycles;

    uint8 faultHead;
    uint8 checksum;

} TankCfg_t;
# 6 "LIB/DATA.h" 2

typedef struct
{
    uint8 trip;
    uint32 timeSec;
    uint8 levelPct;
    uint8 reservoirPct;
    uint16 currentmA;
} FaultRec_t;
# 11 "Logic/Console/console.h" 2
# 1 "Logic/FaultLog/faultlog.h" 1
# 14 "Logic/FaultLog/faultlog.h"
typedef struct
{
    FaultRec_t entries[16U];
    uint8 head;
    uint8 tail;
    uint8 count;
} FLG_Buffer_t;


void FLG_Init(FLG_Buffer_t *pLog);


STD_ReturnType FLG_Append(FLG_Buffer_t *pLog, const FaultRec_t *pRecord);


uint8 FLG_GetCount(const FLG_Buffer_t *pLog);


uint8 FLG_IsFull(const FLG_Buffer_t *pLog);


STD_ReturnType FLG_GetNewestFirst(const FLG_Buffer_t *pLog,
                                 uint8 offsetFromNewest,
                                 FaultRec_t *pRecord);


void FLG_Clear(FLG_Buffer_t *pLog);







void FLG_Dump(const FLG_Buffer_t *pLog, void (*WriteChar)(char));
# 12 "Logic/Console/console.h" 2




typedef enum
{
    CON_RES_OK = 0,
    CON_RES_ERR_CMD,
    CON_RES_ERR_RANGE,
    CON_RES_ERR_MODE,
    CON_RES_ERR_INTERLOCK,
    CON_RES_ERR_ACTIVE,
    CON_RES_ERR_LONG,
    CON_RES_OK_NOOP
} CON_Result_t;


STD_ReturnType CON_Init(void);


void CON_Run(void);


STD_ReturnType CON_ProcessCommand(const uint8 *pCommandLine);


void CON_SendStatus(void);


void CON_SendHelp(void);


STD_ReturnType CON_SendFaults(void);
extern FLG_Buffer_t g_conFaultLog;
# 9 "Logic/Console/console.c" 2
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
# 10 "Logic/Console/console.c" 2


# 1 "Logic/tank_fsm/tank_fsm.h" 1
# 13 "Logic/tank_fsm/tank_fsm.h"
STD_ReturnType FSM_Init(void);


STD_ReturnType FSM_Run(const TankData_t *Copy_pstData);


TankState_t FSM_GetState(void);


STD_ReturnType FSM_Ack(void);


uint8 FSM_IsBuzzerEnabled(void);
# 13 "Logic/Console/console.c" 2

extern TankData_t Global_stTankData;
# 25 "Logic/Console/console.c"
static RingBuffer_t g_conRxBuffer;

FLG_Buffer_t g_conFaultLog;

static uint8 g_conLine[40U + 1U];
static uint8 g_conLineLen = 0U;





static void CON_WriteByte(char ch)
{
    UART_SendByte((uint8)ch);
}

static void CON_WriteString(const char *pText)
{
    if (pText != ((void *)0))
    {
        UART_SendString((const uint8 *)pText);
    }
}





static uint8 CON_ToUpper(uint8 ch)
{
    if ((ch >= 'a') && (ch <= 'z'))
    {
        return (uint8)(ch - ('a' - 'A'));
    }

    return ch;
}

static uint8 CON_CompareNoCase(
    const uint8 *pLine,
    const char *pExpected)
{
    uint8 index = 0U;

    if ((pLine == ((void *)0)) || (pExpected == ((void *)0)))
    {
        return 0U;
    }

    while (pExpected[index] != '\0')
    {
        if (CON_ToUpper(pLine[index]) !=
            (uint8)pExpected[index])
        {
            return 0U;
        }

        index++;
    }




    if ((pLine[index] == '\0') ||
        (pLine[index] == ' ') ||
        (pLine[index] == '\t') ||
        (pLine[index] == '\r') ||
        (pLine[index] == '\n'))
    {
        return 1U;
    }

    return 0U;
}

static void CON_SkipSpaces(
    const uint8 **ppText)
{
    if (ppText == ((void *)0))
    {
        return;
    }

    while ((*ppText != ((void *)0)) &&
           (((**ppText) == ' ') ||
            ((**ppText) == '\t') ||
            ((**ppText) == '\r') ||
            ((**ppText) == '\n')))
    {
        (*ppText)++;
    }
}





STD_ReturnType CON_Init(void)
{
    RB_Init(&g_conRxBuffer);

    FLG_Init(&g_conFaultLog);

    g_conLineLen = 0U;

    if (UART_Init(9600UL) != E_OK)
    {
        return E_NOK;
    }

    UART_SetRxBuffer(&g_conRxBuffer);

    UART_SetRxInterrupt(1U);

    return E_OK;
}





void CON_Run(void)
{
    uint8 byte;

    while (RB_IsEmpty(&g_conRxBuffer) == 0U)
    {
        if (RB_Get(&g_conRxBuffer, &byte) != E_OK)
        {
            break;
        }




        if ((byte == '\r') || (byte == '\n'))
        {
            if (g_conLineLen > 0U)
            {
                g_conLine[g_conLineLen] = '\0';

                CON_ProcessCommand(g_conLine);

                g_conLineLen = 0U;
            }
        }




        else if (g_conLineLen < 40U)
        {
            g_conLine[g_conLineLen] = byte;
            g_conLineLen++;
        }




        else
        {
            CON_WriteString("ERR LONG\r\n");

            while (RB_IsEmpty(&g_conRxBuffer) == 0U)
            {
                if (RB_Get(&g_conRxBuffer, &byte) != E_OK)
                {
                    break;
                }

                if ((byte == '\r') || (byte == '\n'))
                {
                    break;
                }
            }

            g_conLineLen = 0U;
        }
    }
}





STD_ReturnType CON_ProcessCommand(
    const uint8 *pCommandLine)
{
    uint8 hasMatch = 0U;

    if (pCommandLine == ((void *)0))
    {
        CON_WriteString("ERR CMD\r\n");
        return E_NOK;
    }

    CON_SkipSpaces(&pCommandLine);




    if (CON_CompareNoCase(pCommandLine, "HELP"))
    {
        CON_SendHelp();
        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "STATUS") ||
             CON_CompareNoCase(pCommandLine, "STATUS?"))
    {
        CON_SendStatus();
        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "LEVEL?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "LEVEL=%u%%\r\n",
            (unsigned int)Global_stTankData.levelPct);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "FLOW?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "FLOW=%u.%u L/min\r\n",
            (unsigned int)(Global_stTankData.flowLpmX10 / 10U),

            (unsigned int)(Global_stTankData.flowLpmX10 % 10U));

        CON_WriteString(buffer);

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "VOLUME?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "VOLUME=%lu L\r\n",
            (unsigned long)
                Global_stTankData.totalLitres);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "CURRENT?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "CURRENT=%u mA\r\n",
            (unsigned int)
                Global_stTankData.currentmA);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }







    else if (CON_CompareNoCase(pCommandLine, "CFG?"))
    {
        CON_WriteString(
            "CFG=30,90,60,8,0.5,1,10,15,120\r\n");

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "ACK"))
    {
        if (FSM_Ack() == E_OK)
        {
            CON_WriteString("OK\r\n");
        }
        else
        {
            CON_WriteString("ERR ACTIVE\r\n");
        }

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "FAULTS?"))
    {
        CON_SendFaults();

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "CLRFAULTS"))
    {
        FLG_Clear(&g_conFaultLog);

        CON_WriteString("OK\r\n");

        hasMatch = 1U;
    }




    else if (CON_CompareNoCase(pCommandLine, "TRIP?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "TRIP=%u\r\n",
            (unsigned int)
                Global_stTankData.activeTrip);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }







    else if (CON_CompareNoCase(
                 pCommandLine,
                 "MODE AUTO"))
    {
        CON_WriteString(
            "ERR MODE - USE MODE BUTTON\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "MODE MANUAL"))
    {
        CON_WriteString(
            "ERR MODE - USE MODE BUTTON\r\n");

        hasMatch = 1U;
    }







    else if (CON_CompareNoCase(
                 pCommandLine,
                 "PUMP ON"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "PUMP OFF"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "VALVE ON"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "VALVE OFF"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "SERVICE ON"))
    {
        CON_WriteString(
            "ERR MODE - USE SERVICE CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "SERVICE OFF"))
    {
        CON_WriteString(
            "ERR MODE - USE SERVICE CONTROL\r\n");

        hasMatch = 1U;
    }




    if (hasMatch == 0U)
    {
        CON_WriteString("ERR CMD\r\n");
        return E_NOK;
    }

    return E_OK;
}





void CON_SendStatus(void)
{
    char buffer[96];




    const char *stateText;

    switch (FSM_GetState())
    {
    case ST_INIT:
        stateText = "INIT";
        break;

    case ST_IDLE:
        stateText = "IDLE";
        break;

    case ST_FILLING:
        stateText = "FILLING";
        break;

    case ST_SETTLING:
        stateText = "SETTLING";
        break;

    case ST_RESERVOIR_WAIT:
        stateText = "RES_WAIT";
        break;

    case ST_TRIPPED:
        stateText = "TRIPPED";
        break;

    case ST_MANUAL:
        stateText = "MANUAL";
        break;

    case ST_SERVICE:
        stateText = "SERVICE";
        break;

    default:
        stateText = "UNKNOWN";
        break;
    }




    sprintf(
        buffer,
        "LEVEL=%u%% R=%u%% I=%umA\r\n",
        (unsigned int)
            Global_stTankData.levelPct,

        (unsigned int)
            Global_stTankData.reservoirPct,

        (unsigned int)
            Global_stTankData.currentmA);

    CON_WriteString(buffer);

    sprintf(
        buffer,
        "FLOW=%u.%uL/min VOL=%luL\r\n",
        (unsigned int)(Global_stTankData.flowLpmX10 / 10U),

        (unsigned int)(Global_stTankData.flowLpmX10 % 10U),

        (unsigned long)
            Global_stTankData.totalLitres);

    CON_WriteString(buffer);

    sprintf(
        buffer,
        "PUMP=%u VALVE=%u HIGH=%u LOW=%u\r\n",
        (unsigned int)
            Global_stTankData.pumpOn,

        (unsigned int)
            Global_stTankData.valveOn,

        (unsigned int)
            Global_stTankData.highFloat,

        (unsigned int)
            Global_stTankData.lowFloat);

    CON_WriteString(buffer);

    sprintf(
        buffer,
        "STATE=%s TRIP=%u RUN=%u UP=%lu\r\n",
        stateText,

        (unsigned int)
            Global_stTankData.activeTrip,

        (unsigned int)
            Global_stTankData.pumpRunSec,

        (unsigned long)
            Global_stTankData.upTimeSec);

    CON_WriteString(buffer);
}





void CON_SendHelp(void)
{
    CON_WriteString("=== WATER TANK CONSOLE ===\r\n");

    CON_WriteString(
        "STATUS      - System status\r\n");

    CON_WriteString(
        "LEVEL?      - Roof tank level\r\n");

    CON_WriteString(
        "FLOW?       - Current flow\r\n");

    CON_WriteString(
        "VOLUME?     - Total volume\r\n");

    CON_WriteString(
        "CURRENT?    - Pump current\r\n");

    CON_WriteString(
        "CFG?        - Configuration\r\n");

    CON_WriteString(
        "TRIP?       - Active trip\r\n");

    CON_WriteString(
        "FAULTS?     - Fault history\r\n");

    CON_WriteString(
        "CLRFAULTS   - Clear fault history\r\n");

    CON_WriteString(
        "ACK         - Acknowledge trip\r\n");

    CON_WriteString(
        "MODE AUTO/MANUAL - Mode command\r\n");

    CON_WriteString(
        "===========================\r\n");
}





STD_ReturnType CON_SendFaults(void)
{
    if (FLG_GetCount(&g_conFaultLog) == 0U)
    {
        CON_WriteString("NO FAULTS\r\n");

        return E_OK;
    }

    FLG_Dump(
        &g_conFaultLog,
        CON_WriteByte);

    return E_OK;
}
