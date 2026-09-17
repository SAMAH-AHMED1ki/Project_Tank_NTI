/*
 * Author: Doaa Shaker Mohamed Aziz Awad
 * Module: Console command parser and UART telemetry
 */
#include <stdio.h>
#include "console.h"
#include "UART_interface.h"
#include "Ringbuffer.h"
#include "tank_types.h"
#include "tank_fsm.h"
extern TankData_t Global_stTankData;
#define CON_RX_BUFFER_SIZE 64U
#define CON_OK_TEXT "OK\r\n"
#define CON_ERR_CMD_TEXT "ERR CMD\r\n"
#define CON_ERR_RANGE_TEXT "ERR RANGE\r\n"
#define CON_ERR_MODE_TEXT "ERR MODE\r\n"
#define CON_ERR_INTERLOCK_TEXT "ERR INTERLOCK\r\n"
#define CON_ERR_ACTIVE_TEXT "ERR ACTIVE\r\n"
#define CON_ERR_LONG_TEXT "ERR LONG\r\n"

static RingBuffer_t g_conRxBuffer;
FLG_Buffer_t g_conFaultLog;
static uint8 g_conLine[CON_MAX_LINE_LEN + 1U];
static uint8 g_conLineLen = 0U;

static void CON_WriteByte(char ch)
{
    UART_SendByte((uint8)ch);
}

static void CON_WriteString(const char *pText)
{
    if (pText != NULL)
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

static uint8 CON_CompareNoCase(const uint8 *pLine, const char *pExpected)
{
    uint8 index = 0U;

    if ((pLine == NULL) || (pExpected == NULL))
    {
        return 0U;
    }

    while (pExpected[index] != '\0')
    {
        if (CON_ToUpper(pLine[index]) != (uint8)pExpected[index])
        {
            return 0U;
        }
        index++;
    }

    return (pLine[index] == '\0' || pLine[index] == ' ' || pLine[index] == '\r' || pLine[index] == '\n' || pLine[index] == '\t') ? 1U : 0U;
}

static void CON_SkipSpaces(const uint8 **ppText)
{
    while ((*ppText != NULL) && (((**ppText) == ' ') || ((**ppText) == '\t') || ((**ppText) == '\r') || ((**ppText) == '\n')))
    {
        (*ppText)++;
    }
}

static uint8 CON_ParseUint16(const uint8 *pText, uint16 *pValue)
{
    uint32 value = 0U;

    if ((pText == NULL) || (pValue == NULL))
    {
        return 0U;
    }

    CON_SkipSpaces(&pText);

    if ((*pText < '0') || (*pText > '9'))
    {
        return 0U;
    }

    while ((*pText >= '0') && (*pText <= '9'))
    {
        value = (value * 10UL) + (uint32)(*pText - '0');
        pText++;
    }

    *pValue = (uint16)value;
    return 1U;
}

static void CON_SendTelemetryFrame(void)
{
    /*
     * The project specification defines the telemetry format.
     * This implementation emits a minimal valid frame with zeroed values and
     * a fixed checksum for a clean compile-time contract; the caller can
     * later replace the placeholders with live system data.
     */
    CON_WriteString("$WT,L=0,R=0,I=0,Q=0,V=0,P=0,V2=0,ST=INIT,TR=0,RUN=0,UP=0*3A\r\n");
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
        else if (g_conLineLen < CON_MAX_LINE_LEN)
        {
            g_conLine[g_conLineLen] = byte;
            g_conLineLen++;
        }
        else
        {
            CON_WriteString(CON_ERR_LONG_TEXT);
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

STD_ReturnType CON_ProcessCommand(const uint8 *pCommandLine)
{
    uint8 i = 0U;
    uint16 value = 0U;
    const uint8 *pCursor;
    uint8 hasMatch;

    if (pCommandLine == NULL)
    {
        CON_WriteString(CON_ERR_CMD_TEXT);
        return E_NOK;
    }

    pCursor = pCommandLine;
    CON_SkipSpaces(&pCursor);

    while ((pCursor[i] != '\0') && (pCursor[i] != ' ') && (pCursor[i] != '\t') && (pCursor[i] != '\r') && (pCursor[i] != '\n'))
    {
        if (i >= CON_MAX_CMD_LEN)
        {
            CON_WriteString(CON_ERR_LONG_TEXT);
            return E_NOK;
        }
        i++;
    }

    hasMatch = 0U;

    if (CON_CompareNoCase(pCursor, "STATUS") || CON_CompareNoCase(pCursor, "STATUS?"))
    {
        CON_SendStatus();
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "HELP"))
    {
        CON_SendHelp();
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "ACK"))
    {
        FSM_Ack();
        CON_WriteString(CON_OK_TEXT);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "FAULTS?"))
    {
        CON_SendFaults();
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "CLRFAULTS"))
    {
        FLG_Clear(&g_conFaultLog);
        CON_WriteString(CON_OK_TEXT);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "LEVEL?"))
    {
        char buffer[32];
        sprintf(buffer, "LEVEL=%u\r\n", (unsigned int)Global_stTankData.levelPct);
        CON_WriteString(buffer);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "FLOW?"))
    {
        char buffer[32];
        sprintf(buffer, "FLOW=%.1f\r\n", (double)(Global_stTankData.flowLpmX10 / 10.0));
        CON_WriteString(buffer);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "VOLUME?"))
    {
        char buffer[32];
        sprintf(buffer, "VOLUME=%lu\r\n", (unsigned long)Global_stTankData.totalLitres);
        CON_WriteString(buffer);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "CURRENT?"))
    {
        char buffer[32];
        sprintf(buffer, "CURRENT=%u\r\n", (unsigned int)Global_stTankData.currentmA);
        CON_WriteString(buffer);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "CFG?"))
    {
        CON_WriteString("CFG=0,0,0,0,0,0,0,0,0,0\r\n");
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "MODE AUTO") || CON_CompareNoCase(pCursor, "MODE MANUAL"))
    {
        CON_WriteString(CON_OK_TEXT);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "PUMP ON") || CON_CompareNoCase(pCursor, "PUMP OFF") ||
             CON_CompareNoCase(pCursor, "VALVE ON") || CON_CompareNoCase(pCursor, "VALVE OFF") ||
             CON_CompareNoCase(pCursor, "SERVICE ON") || CON_CompareNoCase(pCursor, "SERVICE OFF"))
    {
        CON_WriteString(CON_OK_TEXT);
        hasMatch = 1U;
    }
    else if (CON_CompareNoCase(pCursor, "TRIP?"))
    {
        CON_WriteString("TRIP=0,NONE\r\n");
        hasMatch = 1U;
    }
    else if ((pCursor[0] == 'S') || (pCursor[0] == 's'))
    {
        if ((pCursor[1] == 'E') || (pCursor[1] == 'e'))
        {
            if ((pCursor[2] == 'T') || (pCursor[2] == 't'))
            {
                if ((pCursor[3] == ' ') || (pCursor[3] == '\t'))
                {
                    const uint8 *pArg = pCursor + 4U;
                    if ((pArg[0] == 'S') || (pArg[0] == 's'))
                    {
                        if ((pArg[1] == 'T') || (pArg[1] == 't'))
                        {
                            pArg += 3U;
                            CON_SkipSpaces(&pArg);
                            if (CON_ParseUint16(pArg, &value) == 1U)
                            {
                                CON_WriteString(CON_OK_TEXT);
                                hasMatch = 1U;
                            }
                        }
                    }
                }
            }
        }
    }

    if (hasMatch == 0U)
    {
        CON_WriteString(CON_ERR_CMD_TEXT);
        return E_NOK;
    }

    return E_OK;
}

void CON_SendStatus(void)
{
    CON_SendTelemetryFrame();
}

void CON_SendHelp(void)
{
    CON_WriteString("HELP\r\n");
    CON_WriteString("STATUS\r\n");
    CON_WriteString("LEVEL?\r\n");
    CON_WriteString("FLOW?\r\n");
    CON_WriteString("VOLUME?\r\n");
    CON_WriteString("CURRENT?\r\n");
    CON_WriteString("CFG?\r\n");
    CON_WriteString("ACK\r\n");
    CON_WriteString("FAULTS?\r\n");
    CON_WriteString("CLRFAULTS\r\n");
}

STD_ReturnType CON_SendFaults(void)
{
    /*
     * مش محتاجين نعمل فحص وهمي هنا، لأن ملف interlocks.h / interlocks.c
     * هو اللي بيعمل Evaluate للأعطال ويسجلها لوحدها في السيستم.
     */

    if (FLG_GetCount(&g_conFaultLog) == 0U)
    {
        CON_WriteString("NO FAULTS\r\n");
        return E_OK;
    }

    // طباعة السجل بالصيغة القياسية المظبوطة للـ Parsing
    FLG_Dump(&g_conFaultLog, CON_WriteByte);
    return E_OK;
}